Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3E41DED5
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431393; cv=none; b=N7I9UTj7nftATvLbjtMaiqnxgPaUVxBm31xvUp1PwQ6PB6b2djclJgG8PJsgB5cYKmbY+Y6mXlHVq8sOeVKiVe95Vd2jAd3GupvIpbGu+18C8o+35kNj0lovHKv6BfirWaXztf/SP2r4MUzwB3cqhXLL/lGWh2ssbtjlX5wiaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431393; c=relaxed/simple;
	bh=WFJ3OkIk0+cRC2fEyVd7FqrPVqNYZJNNbpLdjOQiuPY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ujggPBRK5Mq82LZQZdX/oJibhWSnmKc25I+z5wFyUJKOj5DGr04TfavOPMOSOSChZd5iITkG/Z97nM2jqZhWTX1IkpTMy7ZzR0TvK4QLwo59Vxw3f2dDJDACsI0FWaE83wOdAyQ6yM9bX/22txBnRe+QdR9NTXE0Y64gwVG2wJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHf0iP6p; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHf0iP6p"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so10200095ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783431390; x=1784036190; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YTT2EDmNQmPoFd5ibUkdhfarwMp1tgdKNvXjK9tKgTE=;
        b=HHf0iP6pAyNv1ZFxag6oWbTVA0Mi/LYvVAHBBv1qVyKpO6orrbf4GUYX9cG/Wp/G31
         CZTVSwazgseij0J0/NJI5kKw4/g7yBSMBtPVxNPHtjWPjoB0SU4bfUNW3kuiCW/R/x81
         e36ZJKHh7uHUQuQxQSavLrS9sNgUOugWOBjmn9tCuK/QfaDn9O5GlYmjCf6TpEmCnadR
         4KjM3jUn/VxJWste12Fn6SOgUfo0y66mmhNNVcq7yyiUF25opTKup0dPcMtbW3DLEf5g
         /n+bwaORFEzUwZSBT+JdlIzb+irAOnn2yEPMogKVPGqQjl0D/lgf2ix1UQItSHOjde6+
         W5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431390; x=1784036190;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTT2EDmNQmPoFd5ibUkdhfarwMp1tgdKNvXjK9tKgTE=;
        b=hVsjuTQ0ZI8QowXBw+oKPV0iE+CclJFgrJ0NF/EpH69O1kyZrrtT0DCgTifY5XwWro
         gNW7F9W7VmTEaisXbcJwrCn4cEdYwnlQvCe3bOxA7xHw0MtpEPRuU6H4OKISteJOSmCY
         4kVH5gOD6f3OT3cC9LbldZpiMncaQ44SP/Cc2/bImElooARgdpQON5c7YiFksmV2zTcX
         DDtlrOj9gavmBpllddYjO85dYACwSi5W/J+8RiV/0ABjBbq2m5kG29kuwSPre/HqZeI5
         85oYd5CtKUhYSEhp4qZ9IHRc/ojyJdHI+booMpr0ZynL9VdLn5hqhd33ChVBg9cu0pGT
         7GJw==
X-Forwarded-Encrypted: i=1; AHgh+RqKqKJ2iZCfdalo0rNf7WwJOIROLOrRECA4dXyMe0yHDojlPMJcO9STsVYdt2xlRsgRtxFwTKgwNBUkbXKkrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQOazkPP10T+CC5NJkmpWID9xw3cNUzaQ7TjJSV4Am6J2W97nh
	Tu5u4NkeZY4MrEJxElUxyQGtA/PrqbjgMP5C9hZKr/TD5DRNRRpo3MDh
X-Gm-Gg: AfdE7cnY1I5l5PGyrk1damYFG4+2ixQUQshe/cESgxQ586lwDmp9MU/Wg7P5xxjcTde
	YMdWlhMj+CK+JemfaGpkEvUdwmEdxI6NAsuTdytChNwiS+XukrBF3wXxxe4dV9gpfUJuUQEUwQG
	UCkLlZyLxEoMO6qqvju/VGOO+ZYU2DLswSPAkEWVS1P71xpvnTgeZTYWjIPd6K/OpaROw6+nuGm
	zeYVTm5rDBYHGHYCHvW5wtFwmc7s+dWUn/Bs277dYKYhwKbJIP1oH+p0NMCd0C4hqHWpNIhne4U
	bCzkE1tMDUhqlvCv/y9uh6W6rmcfSugyb/U4mvZFwBdPT5JGD+JOrJ1TJgSfnMMglzOzsmqB3qu
	ezNWw58UNt3ApaAX3G+uY01/SjRQRg0uEyBJSywGv/xmoAJXpup3/fUPSVbxzbn2mOPDn4KeDcH
	aQS7bxL4BYg9bBpVnFIaSh
X-Received: by 2002:a17:903:2444:b0:2c9:ae0b:61e3 with SMTP id d9443c01a7336-2ccbe40b8efmr55426065ad.2.1783431390369;
        Tue, 07 Jul 2026 06:36:30 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm12488775ad.31.2026.07.07.06.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:36:29 -0700 (PDT)
Message-ID: <bd88f65e-000b-4dde-92f7-28af6a34e977@gmail.com>
Date: Tue, 7 Jul 2026 21:36:17 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
From: Wandun <chenwandun1@gmail.com>
To: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, bigeasy@linutronix.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260707125925.3725177-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 20:59, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> The region covered by mlock[all] may contain CMA pages. cma_alloc installs
> migration entries in the page table, if a memory access occurs at this
> point, it must wait for the migration to complete, which may cause
> latency spikes on the RT kernels.
> 
> Try to move the migration cost into the mlock[all] caller, which is
> typically a setup path. So reduce the chance of latency spikes on RT
> kernels by migrating the currently mapped CMA pages out of CMA region.
> 
> Suggested-by: Frank van der Linden <fvdl@google.com>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Link: https://lore.kernel.org/all/CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com/#t
> ---
>  mm/mlock.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index ac65de40b22b..f56c685533f5 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -25,6 +25,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/mm_inline.h>
>  #include <linux/secretmem.h>
> +#include <linux/migrate.h>
>  #include <linux/compaction.h>
>  
>  #include "internal.h"
> @@ -428,6 +429,119 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_CMA
> +static int mlock_collect_migratable_pte_range(pmd_t *pmd, unsigned long addr,
> +			unsigned long end, struct mm_walk *walk)
> +{
> +	struct vm_area_struct *vma = walk->vma;
> +	struct list_head *folio_list = walk->private;
> +	spinlock_t *ptl;
> +	pte_t *start_pte, *pte;
> +	pte_t ptent;
> +	struct folio *folio;
> +	unsigned int step = 1;
> +
> +	if (!(vma->vm_flags & VM_LOCKED))
> +		return 0;
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		if (!pmd_present(*pmd)) {
> +			if (unlikely(softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
> +				spin_unlock(ptl);
> +				pmd_migration_entry_wait(vma->vm_mm, pmd);
> +				walk->action = ACTION_AGAIN;
> +				return 0;
> +			}
> +			goto out;
> +		}
> +		if (is_huge_zero_pmd(*pmd))
> +			goto out;
> +		folio = pmd_folio(*pmd);
> +		if (folio_is_zone_device(folio))
> +			goto out;
> +		if (is_migrate_cma_page(&folio->page))
> +			isolate_folio_to_list(folio, folio_list);
> +		goto out;
> +	}
> +
> +	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	if (!start_pte) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +
> +	for (pte = start_pte; addr != end; pte += step, addr += step * PAGE_SIZE) {
> +		step = 1;
> +		ptent = ptep_get(pte);
> +		if (!pte_present(ptent)) {
> +			if (unlikely(softleaf_is_migration(softleaf_from_pte(ptent)))) {
> +				pte_unmap_unlock(start_pte, ptl);
> +				migration_entry_wait(vma->vm_mm, pmd, addr);
> +				walk->action = ACTION_AGAIN;
> +				return 0;
> +			}
> +			continue;
> +		}
> +		folio = vm_normal_folio(vma, addr, ptent);
> +		if (!folio || folio_is_zone_device(folio))
> +			continue;
> +		step = folio_mlock_step(folio, pte, addr, end);
> +		if (is_migrate_cma_page(&folio->page))
Here should be, sorry about this.
	if (!is_migrate_cma_page(&folio->page))
		continue;

Best regards
Wandun
> +			continue;
> +		isolate_folio_to_list(folio, folio_list);
> +	}
> +	pte_unmap(start_pte);
> +out:
> +	spin_unlock(ptl);
> +	cond_resched();
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops mlock_collect_migratable_ops = {
> +	.pmd_entry	= mlock_collect_migratable_pte_range,
> +	.walk_lock	= PGWALK_RDLOCK,
> +};
> +
> +static void mlock_migrate_cma_range(unsigned long start, unsigned long len)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long end = start + len;
> +	LIST_HEAD(folio_list);
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		.gfp_mask = GFP_HIGHUSER | __GFP_NOWARN,
> +		.reason = MR_SYSCALL,
> +	};
> +
> +	if (compaction_allow_unevictable())
> +		return;
> +
> +	lru_cache_disable();
> +
> +	if (mmap_read_lock_killable(mm))
> +		goto out;
> +
> +	walk_page_range(mm, start, end, &mlock_collect_migratable_ops,
> +			&folio_list);
> +	mmap_read_unlock(mm);
> +
> +	if (list_empty(&folio_list))
> +		goto out;
> +
> +	if (migrate_pages(&folio_list, alloc_migration_target, NULL,
> +			  (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL))
> +		putback_movable_pages(&folio_list);
> +out:
> +	lru_cache_enable();
> +}
> +#else
> +static inline void mlock_migrate_cma_range(unsigned long start,
> +					   unsigned long len)
> +{
> +}
> +#endif /* CONFIG_CMA */
> +
>  /*
>   * mlock_vma_pages_range() - mlock any pages already in the range,
>   *                           or munlock all pages in the range.
> @@ -678,6 +792,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>  	error = __mm_populate(start, len, 0);
>  	if (error)
>  		return __mlock_posix_error_return(error);
> +	mlock_migrate_cma_range(start, len);
>  	return 0;
>  }
>  
> @@ -790,8 +905,10 @@ SYSCALL_DEFINE1(mlockall, int, flags)
>  	    capable(CAP_IPC_LOCK))
>  		ret = apply_mlockall_flags(flags);
>  	mmap_write_unlock(current->mm);
> -	if (!ret && (flags & MCL_CURRENT))
> +	if (!ret && (flags & MCL_CURRENT)) {
>  		mm_populate(0, TASK_SIZE);
> +		mlock_migrate_cma_range(0, TASK_SIZE);
> +	}
>  
>  	return ret;
>  }

