Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB1345CD0;
	Tue, 30 Jun 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836192; cv=none; b=pE1KIbepSMpuURZ4h+2/ggMTbvpUu5ChITCd5np8PCEbye1cu7+2YeO4hMAcFDiti8n4MeUMEsHYN+AZEmg3v277Nm8Sdmy7WqwGHwxIEmUdndV70pX03C6YBVic1o8Rh31DvHA/XG65h/ume5CLzdN6vXn2EqJk4G/4StUgUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836192; c=relaxed/simple;
	bh=SsAMZX/DGKUrXxi5h2r3xO8006PoKiborx7W9c5VTl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQ3o/xVkggl02zdpv6tp/BcjxVm5RloDwGBxywkPmTfq1/kjuiR0In35dyBBYovTqxvzTXb3CIyjzCrYIukmpFhMC86VKNxEzJZ3k83NYinN9futBzV9RFV347/ff2weqRTbGWZbfms/5KJd+GqHqCh5+4Wc8/dqiUFWs6y3obQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6JRZBqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6JRZBqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24241F000E9;
	Tue, 30 Jun 2026 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782836187;
	bh=gSJCvZ/dwOzu87v2A3i62lqWRETvglfB6UPAFNWrcXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V6JRZBqtLhnl4J/rumnhOdehRImSxvhilApkN56v/XTEb6EAUfP5pilKgG7hCNWhq
	 1nGO93rV5l6Y52tl0bH1IKNrpN3nNBepVA3IyZImcyHdFxQVufaqklZnRdi1yAnoyE
	 6JgcJjgpEUQGFHI8stdG0aQ24zJoO9O2h+4YWBHwXjaSjQNDHHo9ch1k+4P2O9U9Lk
	 /+pdAQyrN9gzG95QUgewnpIe4I5W3uVC2Dye7xGoBPVos1L1rsHvNwvIIwPSoy6Vtc
	 v4J2/jyNSACgeuGTr0KLoRm+OYGbOMjUGoqmJrX4XpRkfH0hWyoM5ItUHoLdDdT8Tu
	 9/ZV0HyFhnj2g==
Message-ID: <611bd3dc-95d4-45e0-ae5a-158c6cf1472f@kernel.org>
Date: Tue, 30 Jun 2026 18:16:20 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price
 <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 15:11, Brendan Jackman wrote:
> Currently the core allocator code is controlled by ALLOC_NOLOCK, but the
> main entry point function is significantly different from the normal

Let's mention it explicitly, alloc_frozen_pages_nolock_noprof().

> __alloc_frozen_pages_nolock(), this is tiring when reading the code.

You mean __alloc_frozen_pages_noprof()?

> 
> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only

Again __alloc_frozen_pages_noprof()

> exposed to mm/) and then turn the nolock variant into a thin wrapper
> that just sets that flag (as well as handling NUMA_NO_NODE, similar to
> how some of the wrappers in gfp.h do).
> 
> Rationale that this doesn't change anything:
> 
> 1. Simple bits: A bunch of the nolock-specific handling is just moved to
>    the new alloc_order_allowed(), alloc_trylock_allowed() and
>    gfp_trylock.

Should be alloc_nolock_allowed() and gfp_nolock

> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>    previously in the nolock variant:
> 
>    a. Application of gfp_allowed_mask; this only affects early boot, and
>       only flags that affect the slowpath get changed here.

As discussed in reply to Harry, I'd mention the flags excluded by
GFP_BOOT_MASK are not usable by _nolock() anyway.

>    b. Application of current_gfp_context() - also only affects the
>       slowpath
> 
> 3. The slowpath itself: this is now just explicitly skipped under
>    !ALLOC_TRYLOCK.

ALLOC_NOLOCK.

> 
> Ulterior motive: adding an alloc_flags arg to the allocator's
> mm-internal entrypoint can later be used to do more allocation
> customisation without needing to create new GFP flags.
> 
> While adding this flag to a bunch of places, create ALLOC_DEFAULT to
> avoid a mysterious literal 0 in most places.


> alloc_frozen_pages_noprof()
> is defined above the alloc flags so just leave that as a slightly messy
> exception instead of trying to fully reorder mm/internal.h for that one
> case.

This no longer applies in v3?

> No functional change intended.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/hugetlb.c    |   3 +-
>  mm/mempolicy.c  |  10 ++--
>  mm/page_alloc.c | 178 +++++++++++++++++++++++++++++---------------------------
>  mm/page_alloc.h |   6 +-
>  mm/slub.c       |   6 +-
>  5 files changed, 108 insertions(+), 95 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f7925624c4d2e..dfcfcfa4715bf 100644

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a3ba63c7f9199..8d409d075e3e9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5222,7 +5222,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  		}
>  		nr_account++;
>  
> -		prep_new_page(page, 0, gfp, 0);
> +		prep_new_page(page, 0, gfp, ALLOC_DEFAULT);
>  		set_page_refcounted(page);
>  		page_array[nr_populated++] = page;
>  	}
> @@ -5271,24 +5271,98 @@ void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
>  	}
>  }
>  
> -/*
> - * This is the 'heart' of the zoned buddy allocator.
> - */
> -struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> -		int preferred_nid, nodemask_t *nodemask)
> +static inline bool alloc_order_allowed(gfp_t gfp, unsigned int order,
> +				       unsigned int alloc_flags)
>  {
> -	struct page *page;
> -	unsigned int fastpath_alloc_flags = ALLOC_WMARK_LOW;
> -	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
> -	struct alloc_context ac = { };
> +	if (alloc_flags & ALLOC_NOLOCK)
> +		return pcp_allowed_order(order);
>  
>  	/*
>  	 * There are several places where we assume that the order value is sane
>  	 * so bail out early if the request is out of bound.
>  	 */
> -	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> +	return !(WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp));
> +}
> +
> +static inline bool alloc_trylock_allowed(void)

alloc_nolock_allowed()

> +{
> +	/*
> +	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
> +	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
> +	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() will
> +	 * mark the task as the owner of another rt_spin_lock which will
> +	 * confuse PI logic, so return immediately if called from hard IRQ or
> +	 * NMI.
> +	 *
> +	 * Note, irqs_disabled() case is ok. This function can be called
> +	 * from raw_spin_lock_irqsave region.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +		return false;
> +
> +	/* On UP, spin_trylock() always succeeds even when it is locked */
> +	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> +		return false;
> +
> +	/* Bailout, since _deferred_grow_zone() needs to take a lock */
> +	if (deferred_pages_enabled())
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * GFP flags to set for ALLOC_NOLOCK i.e. alloc_pages_nolock().
> + *
> + * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
> + * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
> + * is not safe in arbitrary context.
> + *
> + * These two are the conditions for gfpflags_allow_spinning() being true.
> + *
> + * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a reason
> + * to warn. Also warn would trigger printk() which is unsafe from
> + * various contexts. We cannot use printk_deferred_enter() to mitigate,
> + * since the running context is unknown.
> + *
> + * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
> + * is safe in any context. Also zeroing the page is mandatory for
> + * BPF use cases.
> + *
> + * Though __GFP_NOMEMALLOC is not checked in the code path below,
> + * specify it here to highlight that alloc_pages_nolock()
> + * doesn't want to deplete reserves.
> + */
> +static const gfp_t gfp_nolock = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC |
> +				__GFP_COMP;
> +
> +/*
> + * This is the 'heart' of the zoned buddy allocator.
> + */
> +struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> +		int preferred_nid, nodemask_t *nodemask, unsigned int alloc_flags)
> +{
> +	struct page *page;
> +	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
> +	struct alloc_context ac = { };
> +	unsigned int fastpath_alloc_flags = alloc_flags;
> +
> +	/* Other flags could be supported later if needed. */
> +	if (WARN_ON(alloc_flags & ~ALLOC_NOLOCK))
>  		return NULL;
>  
> +	if (!alloc_order_allowed(gfp, order, alloc_flags))
> +		return NULL;
> +
> +	if (alloc_flags & ALLOC_NOLOCK) {
> +		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
> +		if (!alloc_trylock_allowed())
> +			return NULL;
> +		gfp |= gfp_nolock;

I think we could do a
		fastpath_alloc_flags |= ALLOC_WMARK_MIN;

to make it explicit, even though it's a no-op (the value is 0) and
alloc_frozen_pages_nolock_noprof() didn't do it.

> +	} else {
> +		fastpath_alloc_flags |= ALLOC_WMARK_LOW;
> +	}
> +
>  	gfp &= gfp_allowed_mask;
>  	/*
>  	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
> @@ -5310,9 +5384,9 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>  	fastpath_alloc_flags |= alloc_flags_nofragment(zonelist_zone(ac.preferred_zoneref), gfp);
>  	fastpath_alloc_flags |= alloc_flags_nonblocking(gfp, order) & ALLOC_HIGHATOMIC;
>  
> -	/* First allocation attempt */
> +	/* First allocation attempt (or, for nolock, only attempt) */
>  	page = get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags, &ac);
> -	if (likely(page))
> +	if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
>  		goto out;
>  
>  	alloc_gfp = gfp;
> @@ -5329,7 +5403,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>  out:
>  	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>  	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
> -		free_frozen_pages(page, order);
> +		__free_frozen_pages(page, order,
> +				    alloc_flags & ALLOC_NOLOCK ? FPI_TRYLOCK : 0);
>  		page = NULL;
>  	}
>  
> @@ -5345,7 +5420,8 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>  {
>  	struct page *page;
>  
> -	page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid, nodemask);
> +	page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid, nodemask,
> +					   ALLOC_DEFAULT);
>  	if (page)
>  		set_page_refcounted(page);
>  	return page;
> @@ -7875,80 +7951,10 @@ static bool __free_unaccepted(struct page *page)
>  
>  struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
>  {
> -	/*
> -	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
> -	 * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
> -	 * is not safe in arbitrary context.
> -	 *
> -	 * These two are the conditions for gfpflags_allow_spinning() being true.
> -	 *
> -	 * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a reason
> -	 * to warn. Also warn would trigger printk() which is unsafe from
> -	 * various contexts. We cannot use printk_deferred_enter() to mitigate,
> -	 * since the running context is unknown.
> -	 *
> -	 * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
> -	 * is safe in any context. Also zeroing the page is mandatory for
> -	 * BPF use cases.
> -	 *
> -	 * Though __GFP_NOMEMALLOC is not checked in the code path below,
> -	 * specify it here to highlight that alloc_pages_nolock()
> -	 * doesn't want to deplete reserves.
> -	 */
> -	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
> -			| gfp_flags;
> -	unsigned int alloc_flags = ALLOC_NOLOCK;
> -	struct alloc_context ac = { };
> -	struct page *page;
> -
> -	VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
> -	/*
> -	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
> -	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
> -	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() will
> -	 * mark the task as the owner of another rt_spin_lock which will
> -	 * confuse PI logic, so return immediately if called from hard IRQ or
> -	 * NMI.
> -	 *
> -	 * Note, irqs_disabled() case is ok. This function can be called
> -	 * from raw_spin_lock_irqsave region.
> -	 */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> -		return NULL;
> -
> -	/* On UP, spin_trylock() always succeeds even when it is locked */
> -	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> -		return NULL;
> -
> -	if (!pcp_allowed_order(order))
> -		return NULL;
> -
> -	/* Bailout, since _deferred_grow_zone() needs to take a lock */
> -	if (deferred_pages_enabled())
> -		return NULL;
> -
>  	if (nid == NUMA_NO_NODE)
>  		nid = numa_node_id();
>  
> -	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> -			    &alloc_gfp, &alloc_flags);
> -
> -	/*
> -	 * Best effort allocation from percpu free list.
> -	 * If it's empty attempt to spin_trylock zone->lock.
> -	 */
> -	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
> -
> -	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> -
> -	if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
> -	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
> -		__free_frozen_pages(page, order, FPI_TRYLOCK);
> -		page = NULL;
> -	}
> -	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
> -	kmsan_alloc_page(page, order, alloc_gfp);
> -	return page;
> +	return __alloc_frozen_pages_noprof(gfp_flags, order, nid, NULL, ALLOC_NOLOCK);
>  }
>  /**
>   * alloc_pages_nolock - opportunistic reentrant allocation from any context
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index 3250d44f96457..e16f905f859a7 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -11,6 +11,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/types.h>
>  
> +#define ALLOC_DEFAULT		0
>  /* The ALLOC_WMARK bits are used as an index to zone->watermark */
>  #define ALLOC_WMARK_MIN		WMARK_MIN
>  #define ALLOC_WMARK_LOW		WMARK_LOW
> @@ -219,7 +220,7 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
>  extern int user_min_free_kbytes;
>  
>  struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order, int nid,
> -		nodemask_t *nodemask);
> +		nodemask_t *nodemask, unsigned int alloc_flags);
>  #define __alloc_frozen_pages(...) \
>  	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
>  void free_frozen_pages(struct page *page, unsigned int order);
> @@ -230,7 +231,8 @@ struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
>  #else
>  static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order)
>  {
> -	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL);
> +	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL,
> +					   0 /* ALLOC_DEFAULT */);

Can use ALLOC_DEFAULT now.

>  }
>  #endif
>  
