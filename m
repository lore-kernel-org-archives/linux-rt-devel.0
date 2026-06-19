Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106473F9FB;
	Fri, 19 Jun 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841420; cv=none; b=T5bXKfvdAY+LXmrfCkwJx8lIgksWyP+AZCe2m99XwCySvwYc8YO0r1plIJ5pB5/S9AofEkx0l2hxdOsfJu5nwHbuGeV0XlO3l1fYzBcz51LjnNEJgiJk1cz6i0nVDMTX5ORRznN9jKuXdDkQ8Zud8xaTNP5nTLnVr8pMyyTAwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841420; c=relaxed/simple;
	bh=uEPOKqF/uAmcziWRJl8DY4JVxcO5GOMcfh2+XYtbVS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0at3d1fQ1D2chAok0ZnqvM5SZpHgh/TWd/mkQrZ74iF08V+9kLzZPcOQ4wqMXxuPjAYNjbbiaL7lNNl5myT/q/oB9si1KUbMbzfvnnQTS6i49x45RhtNoPGj5HC+LhO1ugAKsZbhh1Z9t+r1QvAjqbop4brxyi69HRhZnUc4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k2PYLv9Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k2PYLv9Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wifbDAq8EI2ICrdKxvkegaDG7NSADDww2zqkIubQQEo=; b=k2PYLv9QnhBOWOz5lutAaTjL2E
	gBDfu3j5vo2+h/v2ddHGdFQP8/wbvfCGqoCev9d/49MWszhZkswgG5BRWqRCTfTfskI+oDo9nVSSe
	NcwmhKmKZojSPOnfXthpcZcehw7NYA6HxD3V70FvPaWc7N9bSoGTgS6aODg1Oxq/QmHhS3BCzusUi
	8LABhUTJwB5pAlxvp+pA1rds/ZKobwzcTETaBtOuoAUZGurdDrJ61NQEuqjopJDWXe5iwAJX5OB+S
	RUt8Jtc1JBSp+NYGDk4NC4fWxl70QvTNa2i/9HBexrgWnJtrDtaBXHP+c+KGd0W92l/EiiV25HCuX
	/d35Iy6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waQLB-0000000Fan8-44Uu;
	Fri, 19 Jun 2026 03:56:26 +0000
Date: Fri, 19 Jun 2026 04:56:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
Message-ID: <ajS96fWbG4dzP3u3@casper.infradead.org>
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>

On Wed, Jun 17, 2026 at 03:29:42PM +0000, Brendan Jackman wrote:
> +++ b/mm/page_alloc.c
> @@ -5253,24 +5253,98 @@ void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
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
> -	unsigned int alloc_flags = ALLOC_WMARK_LOW;
> -	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
> -	struct alloc_context ac = { };
> +

Spurious blank line?

> +	if (alloc_flags & ALLOC_TRYLOCK)
> +		return pcp_allowed_order(order);
[...]
> +/*
> + * GFP flags to set for ALLOC_TRYLOCK i.e. alloc_pages_nolock().
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

It may be mandatory for BPF, but it seems wasteful for other uses.

> + * Though __GFP_NOMEMALLOC is not checked in the code path below,
> + * specify it here to highlight that alloc_pages_nolock()
> + * doesn't want to deplete reserves.
> + */
> +static const gfp_t gfp_trylock = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC |
> +				__GFP_COMP;

I rather dislike this being turned into a file-scope variable, even a
non-varying variable.  Can't it remain inside a function?

> +/*
> + * This is the 'heart' of the zoned buddy allocator.
> + */
> +struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> +		int preferred_nid, nodemask_t *nodemask, unsigned int alloc_flags)
> +{
> +	struct page *page;
> +	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
> +	struct alloc_context ac = { };
> +
> +	/* Other flags could be supported later if needed. */
> +	if (WARN_ON(alloc_flags & ~ALLOC_TRYLOCK))
>  		return NULL;
>  
> +	if (!alloc_order_allowed(gfp, order, alloc_flags))
> +		return NULL;
> +
> +	if (alloc_flags & ALLOC_TRYLOCK) {
> +		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);

So the only GFP flag the user is allowed to specify is __GFP_ACCOUNT?
That seems bogus; other flags would be reasonable including all the ones
in gfp_trylock, as well as GFP_HIGHMEM, GFP_DMA, GFP_MOVABLE, GFP_HARDWALL.

