Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29E31354F
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857059; cv=none; b=qmZG0sHoW7BfCWZnvTeR9Cprf2tTGKFNsucEfBLauLwsig0wuJYPfqip3lod/Ftoeu6AyDsppM+jflcW7Q1mCmmz0P+xuyZCkiPon7h+netenTPvfg1P+bkoBH3SSCIgbQ+2Itut0yg036+ScAjfgY0eh9Og1R0F9spb6Q84J80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857059; c=relaxed/simple;
	bh=4/k0lmtJuc4Joqk+oRAk6T5BqmUdkRQK0cP7tk5VLw0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UJKwBV6dVF6+n1OSiutuqlQJ5sCCUJLrdAc9B/klmT0r1bfAnumS3n+xNKAziZ925v9LTr1W+znAFgvjXhQIghhGQFMSF7fHwLeo1nmjZkfp6gV+U071iF1RgA23ry9+beaJvxn3kF9zMQ0TRzWn/MlaVRwM+hi63PFNZdCbL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xTYox5oI; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xTYox5oI"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781857055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sklxb2aHOWZNcgEmSllXh3Te/ix6CK2RSGXrEub8f1Q=;
	b=xTYox5oIZ9OU/n4UV73SeNpDSsHY7KiCF+E1xZo3z7i3YVfbAz6ckDDjPeDFdH0dAW82Kz
	wujsHdeHDNF5dJVwP9YoWXI1vYXfiDxA8VUIzN1LjNxrr6SmgbINnCHTVf3oZi8uRK4/RR
	fFGsTeft6twr6SY6oNdxsw+GREz/BG0=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 08:17:31 +0000
Message-Id: <DJCVLX0WK118.3V7CXOTLISFOQ@linux.dev>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi Yan"
 <ziy@nvidia.com>, "Muchun Song" <muchun.song@linux.dev>, "Oscar Salvador"
 <osalvador@suse.de>, "David Hildenbrand" <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>,
 "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>,
 "Byungchul Park" <byungchul@sk.com>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Hao Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>,
 "Gregory Price" <gourry@gourry.net>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Matthew Wilcox" <willy@infradead.org>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <ajS96fWbG4dzP3u3@casper.infradead.org>
In-Reply-To: <ajS96fWbG4dzP3u3@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri Jun 19, 2026 at 3:56 AM UTC, Matthew Wilcox wrote:
> On Wed, Jun 17, 2026 at 03:29:42PM +0000, Brendan Jackman wrote:
>> +++ b/mm/page_alloc.c
>> @@ -5253,24 +5253,98 @@ void free_pages_bulk(struct page **page_array, u=
nsigned long nr_pages)
>>  	}
>>  }
>> =20
>> -/*
>> - * This is the 'heart' of the zoned buddy allocator.
>> - */
>> -struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>> -		int preferred_nid, nodemask_t *nodemask)
>> +static inline bool alloc_order_allowed(gfp_t gfp, unsigned int order,
>> +				       unsigned int alloc_flags)
>>  {
>> -	struct page *page;
>> -	unsigned int alloc_flags =3D ALLOC_WMARK_LOW;
>> -	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
>> -	struct alloc_context ac =3D { };
>> +
>
> Spurious blank line?

Yep, thanks.

>> +	if (alloc_flags & ALLOC_TRYLOCK)
>> +		return pcp_allowed_order(order);
> [...]
>> +/*
>> + * GFP flags to set for ALLOC_TRYLOCK i.e. alloc_pages_nolock().
>> + *
>> + * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allow=
ed.
>> + * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
>> + * is not safe in arbitrary context.
>> + *
>> + * These two are the conditions for gfpflags_allow_spinning() being tru=
e.
>> + *
>> + * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a rea=
son
>> + * to warn. Also warn would trigger printk() which is unsafe from
>> + * various contexts. We cannot use printk_deferred_enter() to mitigate,
>> + * since the running context is unknown.
>> + *
>> + * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() belo=
w
>> + * is safe in any context. Also zeroing the page is mandatory for
>> + * BPF use cases.
>
> It may be mandatory for BPF, but it seems wasteful for other uses.

True, don't see why we shouldn't push this out to the caller, I can do
it as part of this series.

>> + * Though __GFP_NOMEMALLOC is not checked in the code path below,
>> + * specify it here to highlight that alloc_pages_nolock()
>> + * doesn't want to deplete reserves.
>> + */
>> +static const gfp_t gfp_trylock =3D __GFP_NOWARN | __GFP_ZERO | __GFP_NO=
MEMALLOC |
>> +				__GFP_COMP;

> I rather dislike this being turned into a file-scope variable, even a
> non-varying variable.  Can't it remain inside a function?

Um, we could put it into a function like `void add_gfp_trylock(gfp_t *gfp)`=
=20
but that doesn't really reduce the scope in any meaninful way, right?=20

We could also squash it into what's currently called
`alloc_trylock_allowed` but then it's a bit of a mush function, would it
be called `do_trlock_stuff`?

Putting it directly into __alloc_frozen_pages_noprof() would make that
function too big IMO, and its real estate would be dominated by trylock
stuff.

It's definitely understandable to find the large variable scope yucky
but IMO the real fix for that would be to break up page_alloc.c, which
I don't really want to do in this series.=20

>> +/*
>> + * This is the 'heart' of the zoned buddy allocator.
>> + */
>> +struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>> +		int preferred_nid, nodemask_t *nodemask, unsigned int alloc_flags)
>> +{
>> +	struct page *page;
>> +	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
>> +	struct alloc_context ac =3D { };
>> +
>> +	/* Other flags could be supported later if needed. */
>> +	if (WARN_ON(alloc_flags & ~ALLOC_TRYLOCK))
>>  		return NULL;
>> =20
>> +	if (!alloc_order_allowed(gfp, order, alloc_flags))
>> +		return NULL;
>> +
>> +	if (alloc_flags & ALLOC_TRYLOCK) {
>> +		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
>
> So the only GFP flag the user is allowed to specify is __GFP_ACCOUNT?
> That seems bogus; other flags would be reasonable including all the ones
> in gfp_trylock, as well as GFP_HIGHMEM, GFP_DMA, GFP_MOVABLE, GFP_HARDWAL=
L.

Definitely makes sense for the ones in gfp_trylock.

For the others, I'm not sure - this "nolock" functionality is a bit
weird and sketchy, I suspect the reason for the WARN here is "let's make
sure we have a proper think before we allow it to grow usecases that are
meaningfully different from the other ones". I think I like that
conservatism here, I would lean towards keeping it? Not a passionately
held opinion though.
