Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943A3ACA7A
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701833; cv=none; b=Y6Ywj39lD12rtFGDHnBpaCE1OxcFhzHucbcpelUe14MTj5GpNeyN+p4qmgcNh3ta6IG/2sSgZPoxgJLBFLO+m8dD8UIwT6zy26rtxqGucrpHjtn6AbbXFevVwmR+8ZvrlHK1GaIGZwVTW/6NL9q+oUz0Acrysy+Eqd9yjkBzv8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701833; c=relaxed/simple;
	bh=ovnAJQiCLsgMI+5PHQLg5I6hq/8XkpM7SMxkd5hZixU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fT0e6y9TlAWOZtbLQ6ePD23TvHQK0tMLm0f2ZZAVzOyoT+tPCjuwXjMpjlRuOaDSyZhnHglHBYc18FgtnLF8kJCoYWbKnE3yDsCOF/dJ0GiAXwj7ekOmau12b/4rfXDXTVF+60gG7H0svx08lvffXfJZF0Sk9n1MMdv2/QD5/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mLFJjav/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mLFJjav/"
Message-ID: <cf2e7b98-5980-463c-82df-61524ddf253b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784701827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwMf+4RK6SICi7wthzq1GiMbIn6GQQqznOWIrXFUXxE=;
	b=mLFJjav/girYppI6ZaTUZBUHyD9kE9qq4lF8E7sra9OcZOrcnVW/Kf3W3tl4eQuqN2adyj
	FiLfkrEcHZFiMyfwHTDVh2xjPEsA5khR+vUUdVV0kReBK1zE4cYJz9hkZH9X+lAij/LgGU
	X1d9Y4dF7IaZaHo8mu5+DB4fV9UNTDY=
Date: Wed, 22 Jul 2026 14:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v5 16/18] mm: remove the __GFP_NO_OBJ_EXT flag
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
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
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 derkling@google.com, reijiw@google.com, Yosry Ahmed <yosry@kernel.org>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-16-c87b714e19d3@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260703-alloc-trylock-v5-16-c87b714e19d3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2026/7/3 20:31, Brendan Jackman wrote:
> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
>
> All users of the flag are converted to SLAB_ALLOC_NO_RECURSE or
> ALLOC_NO_CODETAG (from __GFP_NO_CODETAG which reused the NO_OBJ_EXT bit).
> Free up the flag bit.
>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> [Rebased onto __GFP_NO_CODETAG removal]
> Signed-off-by: Brendan Jackman <jackmanb@google.com>


Acked-by: Hao Ge <hao.ge@linux.dev>


> ---
>   include/linux/gfp_types.h       |  7 -------
>   include/trace/events/mmflags.h  | 10 +---------
>   tools/include/linux/gfp_types.h |  7 -------
>   3 files changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 463b551d12d99..190191411009f 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -55,7 +55,6 @@ enum {
>   #ifdef CONFIG_LOCKDEP
>   	___GFP_NOLOCKDEP_BIT,
>   #endif
> -	___GFP_NO_OBJ_EXT_BIT,
>   	___GFP_LAST_BIT
>   };
>   
> @@ -96,7 +95,6 @@ enum {
>   #else
>   #define ___GFP_NOLOCKDEP	0
>   #endif
> -#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
>   
>   /*
>    * Physical address zone modifiers (see linux/mmzone.h - low four bits)
> @@ -138,17 +136,12 @@ enum {
>    *
>    * %__GFP_ACCOUNT causes the allocation to be accounted to the active
>    * cgroup context.
> - *
> - * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
> - * mark_obj_codetag_empty() should be called upon freeing for objects allocated
> - * with this flag to indicate that their NULL tags are expected and normal.
>    */
>   #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
>   #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
>   #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
>   #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
>   #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
> -#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
>   
>   /**
>    * DOC: Watermark modifiers
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index a6e5a44c9b429..c1a05ff0feab0 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -54,18 +54,10 @@
>   # define TRACE_GFP_FLAGS_LOCKDEP
>   #endif
>   
> -#ifdef CONFIG_SLAB_OBJ_EXT
> -# define TRACE_GFP_FLAGS_SLAB			\
> -	TRACE_GFP_EM(NO_OBJ_EXT)
> -#else
> -# define TRACE_GFP_FLAGS_SLAB
> -#endif
> -
>   #define TRACE_GFP_FLAGS				\
>   	TRACE_GFP_FLAGS_GENERAL			\
>   	TRACE_GFP_FLAGS_KASAN			\
> -	TRACE_GFP_FLAGS_LOCKDEP			\
> -	TRACE_GFP_FLAGS_SLAB
> +	TRACE_GFP_FLAGS_LOCKDEP
>   
>   #undef TRACE_GFP_EM
>   #define TRACE_GFP_EM(a) TRACE_DEFINE_ENUM(___GFP_##a##_BIT);
> diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
> index 6c75df30a281d..a93b8bd200b76 100644
> --- a/tools/include/linux/gfp_types.h
> +++ b/tools/include/linux/gfp_types.h
> @@ -55,7 +55,6 @@ enum {
>   #ifdef CONFIG_LOCKDEP
>   	___GFP_NOLOCKDEP_BIT,
>   #endif
> -	___GFP_NO_OBJ_EXT_BIT,
>   	___GFP_LAST_BIT
>   };
>   
> @@ -96,7 +95,6 @@ enum {
>   #else
>   #define ___GFP_NOLOCKDEP	0
>   #endif
> -#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
>   
>   /*
>    * Physical address zone modifiers (see linux/mmzone.h - low four bits)
> @@ -137,17 +135,12 @@ enum {
>    * node with no fallbacks or placement policy enforcements.
>    *
>    * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
> - *
> - * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
> - * mark_obj_codetag_empty() should be called upon freeing for objects allocated
> - * with this flag to indicate that their NULL tags are expected and normal.
>    */
>   #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
>   #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
>   #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
>   #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
>   #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
> -#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
>   
>   /**
>    * DOC: Watermark modifiers
>
