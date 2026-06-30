Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78F3C1973;
	Tue, 30 Jun 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837782; cv=none; b=cSZfJ7EjiEKQUzXsOLmC3mZqnLkNp5LbAjALxbqCx/uFqskZc06vx2aA33hnuyMiicOf4ovK4zpF7fX1AysT4Oxjovc5zAw6dJ4nyV+ag7GggEFlHAyoH7B4pG0hSohrSjHKZEITAXzm26HKyy/pW9+O80oTCrhBONCatFWG3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837782; c=relaxed/simple;
	bh=mEOA/EAvFLi8N4oVyVoj4I23Wfhrg7Lhh0877/GS6lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiWc3pMkH8yTZgOeOXfaevo50aBVO8RR5oealh7ERNXa5hd4KSmXS8s6llKvZQ47Fwd7NTmxGuHQG14QpuiCsb+L3mxWRMG8ERxJTKxAIecMqtOw6amS8FWanS6JeRQbTXW8fVAOJxZut8LVXzPXukeyxHbAGJ9u85rp0ICBy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYu4WJqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYu4WJqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354F61F000E9;
	Tue, 30 Jun 2026 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782837781;
	bh=4no/T3y+pOIxv64XMBmnIaHRZyQSycdHiWcySde2mDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AYu4WJqJH5ZaCUKN/g3Ikke2XoyXdOD9sdSonINoyNrGo2gm+D9cVHXR3l4tR5zML
	 wUFSuaISxTyRYf8Q93ynJmwBtTatth8JxeMnWTZULXOj53PRIzxIHKmnNQA88dK9Fc
	 uDDMZoKzRmBR7odAxP4lC8d3R3/mg2bQ0Qq/13oYG8UOp+BQ1Zw8cUc2df29DlaML/
	 rAX2d1TLfeATWPf6aqYP+lc1FhgjU/mPyAHCTCekKXhfFVdjI/oynLjki5p3EjxJe2
	 4KiFLyjUNw05o9fyt8vRviStV+Pcyths4QRtv7nCScvrzAnyBqVYkI3uNbPU73HzPA
	 Trz1F8mciiXJQ==
Message-ID: <c88f957a-e2a3-45f4-80ea-f48dbf6f4b7e@kernel.org>
Date: Tue, 30 Jun 2026 18:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] mm: move some stuff to mm/page_alloc.h
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
 <20260629-alloc-trylock-v3-7-57bef0eadbc2@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260629-alloc-trylock-v3-7-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 15:11, Brendan Jackman wrote:
> Some of this stuff in the public header is only used internally so
> shrink the scope to avoid silently growing new users.
> 
> drain_local_pages() is still used from kernel/power/snapshot.c so that
> needs to stay behind.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  include/linux/gfp.h | 26 --------------------------
>  mm/page_alloc.h     | 28 ++++++++++++++++++++++++++++
>  mm/vmstat.c         |  1 +
>  3 files changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index cdf95a9f0b87c..01d6d2591f49e 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -17,28 +17,6 @@ struct mempolicy;
>  #define __default_gfp(a,b,...) b
>  #define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
>  
> -/* Convert GFP flags to their corresponding migrate type */
> -#define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
> -#define GFP_MOVABLE_SHIFT 3
> -
> -static inline int gfp_migratetype(const gfp_t gfp_flags)
> -{
> -	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
> -	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
> -	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
> -	BUILD_BUG_ON((___GFP_RECLAIMABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_RECLAIMABLE);
> -	BUILD_BUG_ON(((___GFP_MOVABLE | ___GFP_RECLAIMABLE) >>
> -		      GFP_MOVABLE_SHIFT) != MIGRATE_HIGHATOMIC);
> -
> -	if (unlikely(page_group_by_mobility_disabled))
> -		return MIGRATE_UNMOVABLE;
> -
> -	/* Group based on mobility */
> -	return (__force unsigned long)(gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
> -}
> -#undef GFP_MOVABLE_MASK
> -#undef GFP_MOVABLE_SHIFT
> -
>  static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  {
>  	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
> @@ -395,10 +373,6 @@ extern void free_pages(unsigned long addr, unsigned int order);
>  #define __free_page(page) __free_pages((page), 0)
>  #define free_page(addr) free_pages((addr), 0)
>  
> -void page_alloc_init_cpuhp(void);
> -bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
> -void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
> -void drain_all_pages(struct zone *zone);
>  void drain_local_pages(struct zone *zone);
>  
>  void page_alloc_init_late(void);
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index e16f905f859a7..af83764788b96 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -266,6 +266,34 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
>  	return list_empty(&area->free_list[migratetype]);
>  }
>  
> +/* Convert GFP flags to their corresponding migrate type */
> +#define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
> +#define GFP_MOVABLE_SHIFT 3
> +
> +static inline int gfp_migratetype(const gfp_t gfp_flags)
> +{
> +	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
> +	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
> +	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
> +	BUILD_BUG_ON((___GFP_RECLAIMABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_RECLAIMABLE);
> +	BUILD_BUG_ON(((___GFP_MOVABLE | ___GFP_RECLAIMABLE) >>
> +		      GFP_MOVABLE_SHIFT) != MIGRATE_HIGHATOMIC);
> +
> +	if (unlikely(page_group_by_mobility_disabled))
> +		return MIGRATE_UNMOVABLE;
> +
> +	/* Group based on mobility */
> +	return (__force unsigned long)(gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
> +}
> +#undef GFP_MOVABLE_MASK
> +#undef GFP_MOVABLE_SHIFT
> +
> +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
> +void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
> +void drain_all_pages(struct zone *zone);
> +void drain_local_pages(struct zone *zone);
> +
> +void page_alloc_init_cpuhp(void);
>  void page_alloc_sysctl_init(void);
>  
>  #endif /* __MM_PAGE_ALLOC_H */
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 7b93fbf9af092..3b5cb1031f720 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -30,6 +30,7 @@
>  #include <linux/sched/isolation.h>
>  
>  #include "internal.h"
> +#include "page_alloc.h"
>  
>  #ifdef CONFIG_PROC_FS
>  #ifdef CONFIG_NUMA
> 

