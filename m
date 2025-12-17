Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7410FD
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998191; cv=none; b=gQGjnNSkiR1eucThULPNl9bmS3J+2ZbDduO5vJfn65N5viNDqtx63Tlqo1LfFHm8fZ8XTq3b9iDFL6sFJ3+80uDk/RSmWkOuaiIZU/3j9XpA1IVtFxHScYqsDsFBh5rRAddig0GAiBBsteb/Z76hy8LFRzLP73632zhkEb6VI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998191; c=relaxed/simple;
	bh=leNjndYxVGb1f2AS/G12/zrndwN6iU3qLwUSIaF3XxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH/CZeSXTU+C5rWu4pC8aVUXNOtVr0K23qyworpSxEwaNe+qz3GUAUQUL9jyA4/qK6V9oxn7FTAbHHi6EIpRXN9g5PQLPXPXOAC5vUmHO2dY+c39SEKe1w4iRqS/8nYj75YvAchXoGFqg8z6MJtLbSh/JxHqUofwZqK8Zmth7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38CA2FEC;
	Wed, 17 Dec 2025 11:03:00 -0800 (PST)
Received: from [10.57.91.77] (unknown [10.57.91.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D7B3F73F;
	Wed, 17 Dec 2025 11:03:03 -0800 (PST)
Message-ID: <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
Date: Wed, 17 Dec 2025 19:03:02 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251217182007.2345700-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 18:20, Yeoreum Yun wrote:
> The current __kpti_install_ng_mappings() allocates a temporary PGD
> while installing the NG mapping for KPTI under stop_machine(),
> using GFP_ATOMIC.
> 
> This is fine in the non-PREEMPT_RT case. However, it becomes a problem
> under PREEMPT_RT because generic memory allocation/free APIs
> (e.g., pgtable_alloc(), __get_free_pages(), etc.) cannot be invoked
> in a non-preemptible context, except for the *_nolock() variants.
> These generic allocators may sleep due to their use of spin_lock().
> 
> In other words, calling __get_free_pages(), even with GFP_ATOMIC,
> is not allowed in __kpti_install_ng_mappings(), which is executed by
> the stopper thread where preemption is disabled under PREEMPT_RT.
> 
> To address this, preallocate the page needed for the temporary PGD
> before invoking __kpti_install_ng_mappings() via stop_machine().
> 
> Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e4e6c7e0a016..69d9651de0cd 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1360,7 +1360,7 @@ static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
>  	return kpti_ng_temp_alloc;
>  }
>  
> -static int __init __kpti_install_ng_mappings(void *__unused)
> +static int __init __kpti_install_ng_mappings(void *data)
>  {
>  	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
>  	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> @@ -1368,10 +1368,9 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>  
>  	int cpu = smp_processor_id();
>  	int levels = CONFIG_PGTABLE_LEVELS;
> -	int order = order_base_2(levels);
>  	u64 kpti_ng_temp_pgd_pa = 0;
>  	pgd_t *kpti_ng_temp_pgd;
> -	u64 alloc = 0;
> +	u64 alloc = *(u64 *)data;
>  
>  	if (levels == 5 && !pgtable_l5_enabled())
>  		levels = 4;
> @@ -1382,8 +1381,6 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>  
>  	if (!cpu) {
>  		int ret;
> -
> -		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
>  		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
>  		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
>  
> @@ -1414,16 +1411,17 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>  	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
>  	cpu_uninstall_idmap();
>  
> -	if (!cpu) {
> -		free_pages(alloc, order);
> +	if (!cpu)
>  		arm64_use_ng_mappings = true;
> -	}
>  
>  	return 0;
>  }
>  
>  void __init kpti_install_ng_mappings(void)
>  {
> +	int order = order_base_2(CONFIG_PGTABLE_LEVELS);
> +	u64 alloc;
> +
>  	/* Check whether KPTI is going to be used */
>  	if (!arm64_kernel_unmapped_at_el0())
>  		return;
> @@ -1436,8 +1434,14 @@ void __init kpti_install_ng_mappings(void)
>  	if (arm64_use_ng_mappings)
>  		return;
>  
> +	alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);

I don't think this requires GFP_ATOMIC now?

With that removed:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> +	if (!alloc)
> +		panic("Failed to alloc page tables\n");
> +
>  	init_idmap_kpti_bbml2_flag();
> -	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
> +	stop_machine(__kpti_install_ng_mappings, &alloc, cpu_online_mask);
> +
> +	free_pages(alloc, order);
>  }
>  
>  static pgprot_t __init kernel_exec_prot(void)

