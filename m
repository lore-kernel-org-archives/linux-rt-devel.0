Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5630C608;
	Mon, 19 Jan 2026 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843909; cv=none; b=ngJb06jAEmqdAIiMkBhdUCh+DGmcOrqmN9iwRJfZWqSH/BbLpvGBedIfB//hPOl1fWYxt678QUvmzvslgfnty9qvLDqzoa27X5jXbXfDSJgSGP4sJBWIPhUsz1fwGp+TFsh8BDZzihKQjZ9+m668cbH3Ml9lfVqXyz/D29QQJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843909; c=relaxed/simple;
	bh=05zscD5VFLw9poBWpM3GKQq1zp3KfSkLbp1GatELe+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk7FjJ4tBRJIGEJnExqEV7AlHiHKq29y1lx7sRm+Meo7jelafCH1zgVMRML1mnRRQJmTpihuyC8mtkB7lutp58cmFRRM8r6imL1EGzkBthei698MR13MzehxdvsVvWNiPL5+/fNi1zWhXiaNuKOfFKof/OhqaHVX/bowkFD7dSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFRB3+Xe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFRB3+Xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57323C116C6;
	Mon, 19 Jan 2026 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843909;
	bh=05zscD5VFLw9poBWpM3GKQq1zp3KfSkLbp1GatELe+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFRB3+XeQWq5bsyig93pQzFUB8JfoKBfpHnb/5C9iaywScMH36rSqm1TYkRlS9pIb
	 j2rPlm1E+e6h6nF1HCipQC3QEexcTLpvJmVa/rFxHzo670Tvw7KdgrhsfMBhZrB/k2
	 9xmsqvibvmm2T34zYT6Qa+czaeWjbOe+MWB1QWDKCjesMpKzB6b5nco7QlO79pwCO8
	 KYn/G7D6FaOL9JyakbgCZD34eEOHrvxYYVM2soeoGWOSTpn6+tvGKALNEpkaK5CJad
	 vmYH87wAmoZ7xPOOgTUvEdAOdIT0NybE/a3fTM8pmJlWo/vKTHXI81gkyuBYPGUAWA
	 PqKOetDve4wng==
Date: Mon, 19 Jan 2026 17:31:42 +0000
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
	ryan.roberts@arm.com, akpm@linux-oundation.org, david@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 3/3] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Message-ID: <aW5qfh_bsGNRd0Vd@willie-the-truck>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-4-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105202328.2418990-4-yeoreum.yun@arm.com>

On Mon, Jan 05, 2026 at 08:23:28PM +0000, Yeoreum Yun wrote:
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
>  arch/arm64/mm/mmu.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 120874a2d35b..6ea5b80ab54f 100644
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
> @@ -1414,16 +1411,16 @@ static int __init __kpti_install_ng_mappings(void *__unused)
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
>  	/* Check whether KPTI is going to be used */
>  	if (!arm64_kernel_unmapped_at_el0())
>  		return;
> @@ -1436,8 +1433,14 @@ void __init kpti_install_ng_mappings(void)
>  	if (arm64_use_ng_mappings)
>  		return;
>  
> +	alloc = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	if (!alloc)
> +		panic("Failed to alloc page tables\n");

Why are you adding this panic?

Will
