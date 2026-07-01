Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DECD3C0601;
	Wed,  1 Jul 2026 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893343; cv=none; b=PRIipi6/yvAuV3udJ1hRkHwDJX496DVI/5Foe1FtEU8RmAUsoJ1vffIGw7uN/L1xZobjWMBOC25aGDtcdfJmHfkd6p740zLG6ZSa4xltre9w+/WDNHzx/NpYXmqxFaI7xRgpC2gvTwKzPrdjCwodLyNNy5OnGxHytp71TQ8A/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893343; c=relaxed/simple;
	bh=48/4hQJDfCGrSFzr2ItZtFYdgkNzlN/SzS+kLHk7hhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwtoQoD61jQwL4STeE5YZWG40PZ+65k6Hx11FhBChZtrSPu14umWmefe7TS4859tGxYAM5m1fkvJRcKtThT29BkR4QCR5wjN31QS07CMUBC84nWM7cFFV8P5ijtuGY3OAyoZWjzgkmW8nvAZazwRHLX+B+gDzXpkhjJPl9AzI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuviNBw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuviNBw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A021F000E9;
	Wed,  1 Jul 2026 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893340;
	bh=PasTiCU3YYSzDJMw/2oW+WrIXsxSxSCS/T4cLHURas4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PuviNBw/zP6qFiEZRgLkSTMXs85DfGhL6LknJ9ziVHJETZBMibiUp2GOe/SF3dJCU
	 vEi12ODGnu7w8E8m1TA1r0ITEEF9KuNZsrFXXIBPiKnh5yBYIsfsFC5m/r+DcyLA+t
	 McIrVNAq620EI1vNaPcGfU9K4az3LbRyko8CS1X15bPC4m4QMSYgleQoST24LNdWMR
	 FqHzicmUT/RV2AeO5dZ5vcCPLn+qW3olpEbkW0Mj7YZWi6ii8pXyRk7HTtoprbIJ61
	 g4aFbJOJA16KAMzNEOcN6UBH7KkJNduMypns1g8M8hPa1NLRjCHO4cIiQvIoOmxb6p
	 b+rMv7iH2z1kQ==
Message-ID: <6e250f1a-70c8-4330-a938-162cd700170e@kernel.org>
Date: Wed, 1 Jul 2026 10:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] mm: Move __alloc_pages() to mm/page_alloc.h
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
 <20260629-alloc-trylock-v3-14-57bef0eadbc2@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260629-alloc-trylock-v3-14-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 15:12, Brendan Jackman wrote:
> It's no longer used outside of mm/.
> 
> Since this means __alloc_pages_noprof() is no longer visible from gfp.h,
> this also means moving the definition of alloc_pages_node_noprof into
> the .c file.
> 
> Also remove references to this API from the documentation tree -
> referring to the specific function name was already questionable but
> now the function is not even public it definitely seems wrong.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Less inline bloat also good.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  Documentation/admin-guide/cgroup-v1/cpusets.rst |  2 +-
>  Documentation/admin-guide/mm/transhuge.rst      |  2 +-
>  include/linux/gfp.h                             | 16 +---------------
>  mm/page_alloc.c                                 | 13 ++++++++++++-
>  mm/page_alloc.h                                 |  4 ++++
>  5 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> index c7909e5ac1361..52a213aff04e5 100644
> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> @@ -284,7 +284,7 @@ take action.
>  ==>
>      Unless this feature is enabled by writing "1" to the special file
>      /dev/cpuset/memory_pressure_enabled, the hook in the rebalance
> -    code of __alloc_pages() for this metric reduces to simply noticing
> +    code of the page allocator for this metric reduces to simply noticing
>      that the cpuset_memory_pressure_enabled flag is zero.  So only
>      systems that enable this feature will compute the metric.
>  
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 23f8d13c2629d..16f37135ed80d 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -761,7 +761,7 @@ compact_fail
>  	but failed.
>  
>  It is possible to establish how long the stalls were using the function
> -tracer to record how long was spent in __alloc_pages() and
> +tracer to record how long was spent in the page allocator and
>  using the mm_page_alloc tracepoint to identify which allocations were
>  for huge pages.
>  
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 3bf55a5f9143e..4d57e9c0bf204 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -204,10 +204,6 @@ static inline void arch_free_page(struct page *page, int order) { }
>  static inline void arch_alloc_page(struct page *page, int order) { }
>  #endif
>  
> -struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
> -		nodemask_t *nodemask);
> -#define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
> -
>  struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
>  		nodemask_t *nodemask);
>  #define __folio_alloc(...)			alloc_hooks(__folio_alloc_noprof(__VA_ARGS__))
> @@ -272,17 +268,7 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
>   * prefer the current CPU's closest node. Otherwise node must be valid and
>   * online.
>   */
> -static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
> -						   unsigned int order)
> -{
> -	if (nid == NUMA_NO_NODE)
> -		nid = numa_mem_id();
> -
> -	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> -	warn_if_node_offline(nid, gfp_mask);
> -
> -	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
> -}
> +struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order);
>  
>  #define  alloc_pages_node(...)			alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9cb3f1665b41b..026f33f217036 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5427,7 +5427,18 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>  		set_page_refcounted(page);
>  	return page;
>  }
> -EXPORT_SYMBOL(__alloc_pages_noprof);
> +
> +struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
> +{
> +	if (nid == NUMA_NO_NODE)
> +		nid = numa_mem_id();
> +
> +	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> +	warn_if_node_offline(nid, gfp_mask);
> +
> +	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
> +}
> +EXPORT_SYMBOL(alloc_pages_node_noprof);
>  
>  struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
>  		nodemask_t *nodemask)
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index af83764788b96..2058cbdca56e7 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -244,6 +244,10 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
>  	alloc_hooks(alloc_frozen_pages_nolock_noprof(__VA_ARGS__))
>  void free_frozen_pages_nolock(struct page *page, unsigned int order);
>  
> +struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
> +		nodemask_t *nodemask);
> +#define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
> +
>  extern void zone_pcp_reset(struct zone *zone);
>  extern void zone_pcp_disable(struct zone *zone);
>  extern void zone_pcp_enable(struct zone *zone);
> 

