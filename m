Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB972620FC
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352230; cv=none; b=PdVOmVohSYQu4jjQKKfLVsBzlVDNeghJZsLy3p27Z++Vv5dRww7lN+lxWyqQrIvZo9qnybIeCgZYu8XGq2l0w+UFXUjztbH1oXWWNMc3RWipOvAH7J1GN90slYyhnd1CBuish/wN3l1OnKwC/yeYmSyf3fajEjX9VSXQWTAXXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352230; c=relaxed/simple;
	bh=DITRn2hJUkiQP39zpfAGL88UD70iMXgdzf3rtq5ZHfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2V5iVeHTVIn1m8frMia3t++e3gm6HHU5Pskw3egiGcHL7ShJk95AeVZh1ICa9+Ltn8ZfQkM/MMqshAERINWUq0RHzG7bA+Jni6uZEAuz7u20AydT7dfPvg6bIomUnyFju9wquEFTbsZ3KKb4dSg+G+jkSgny8okAOUR3wZgB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38E66497;
	Fri,  2 Jan 2026 03:10:20 -0800 (PST)
Received: from [10.57.94.221] (unknown [10.57.94.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88A0E3F63F;
	Fri,  2 Jan 2026 03:10:23 -0800 (PST)
Message-ID: <dc8b55e0-7cba-4bd2-a68b-88710c17e9aa@arm.com>
Date: Fri, 2 Jan 2026 11:10:21 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, mhocko@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20251218194750.395301-1-yeoreum.yun@arm.com>
 <20251218194750.395301-3-yeoreum.yun@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251218194750.395301-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2025 19:47, Yeoreum Yun wrote:
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
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 96a9fa505e71..9ad9612728e6 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1369,7 +1369,7 @@ static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
>  	return kpti_ng_temp_alloc;
>  }
>  
> -static int __init __kpti_install_ng_mappings(void *__unused)
> +static int __init __kpti_install_ng_mappings(void *data)
>  {
>  	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
>  	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> @@ -1377,10 +1377,9 @@ static int __init __kpti_install_ng_mappings(void *__unused)
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
> @@ -1391,8 +1390,6 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>  
>  	if (!cpu) {
>  		int ret;
> -
> -		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
>  		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
>  		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
>  
> @@ -1423,16 +1420,17 @@ static int __init __kpti_install_ng_mappings(void *__unused)
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

nit: Restore the blank line between the variable definitioins and the logic.

But you already have my R-b :)

>  	/* Check whether KPTI is going to be used */
>  	if (!arm64_kernel_unmapped_at_el0())
>  		return;
> @@ -1445,8 +1443,14 @@ void __init kpti_install_ng_mappings(void)
>  	if (arm64_use_ng_mappings)
>  		return;
>  
> +	alloc = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
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

