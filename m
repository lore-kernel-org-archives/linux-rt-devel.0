Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCFA3403ED
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957217; cv=none; b=SsAdBI1Z5JBbLCuEyxC3ka33Q0bop04rwZ63msOYbNaeFuVw+5KRBci13DtDuwZTBr7N6jZVWb4eQZCGkircCyE0253vKvvq0S0FELxFdCv6pFsb5oMJUYVUj5upvzoBVIgbG7eoabi3cI8feXUUJq5l3cHSnCeNT+Lkr/Gh7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957217; c=relaxed/simple;
	bh=XaiRGt41PdVDK7BfFINq2j6dUvACExkFxYYZ7r4LLMY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DoqudSKWXINWyU/4HbuaitJr5lwdPdCy4GjFZ6MmMGdG09gsuFrcn2xlgvgSFAJtLVyZRzAUFUlC3bF+i9r4QAxkeNFoPzWCKAMynRjUJZ3vr+RF9k7X9+qASBd9hyMcO91aKHjsNxiwh3eM/YBhcOrNLPB526y6WGAcqzuToT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VpL91rYo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VpL91rYo"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783957211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlkLaHtRYAVpE4WxTmCUGpkNu8tzK1MssH3C9d4Lj50=;
	b=VpL91rYo+y2+CR011e23Uc5ksnQ1xmwHVNTLJQsVl2f8ubPHy06muUywGP3MBmv+brEROf
	6VBVC24s3DS0AzmDgQXa/wuLOylma8BfZMphJzNJtlzl9RDPya6gy9aJSHUbOGK9y+mMQm
	7swMY0r9LyNXKHeqJelB7hXkbqwa0xA=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 15:40:04 +0000
Message-Id: <DJXK1TXBDIVC.18M4LNRSJPFWV@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>
Subject: Re: [PATCH v5 05/18] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Zi Yan" <ziy@nvidia.com>, "Brendan Jackman" <jackmanb@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-5-c87b714e19d3@google.com>
 <DJP0KNE4S3WN.209EE744YM0YT@nvidia.com>
In-Reply-To: <DJP0KNE4S3WN.209EE744YM0YT@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Fri Jul 3, 2026 at 2:42 PM UTC, Zi Yan wrote:
> On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
>> Currently the core allocator code is controlled by ALLOC_NOLOCK, but the
>> main entry point function is significantly different from the normal
>> __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>>
>> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
>> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only
>> exposed to mm/) and then turn the nolock variant into a thin wrapper
>> that just sets that flag (as well as handling NUMA_NO_NODE, similar to
>> how some of the wrappers in gfp.h do).
>>
>> For consistency, set ALLOC_WMARK_MIN explicitly in fastpath_alloc_flags
>> for the new ALLOC_NOLOCK path. This was already "done" silently in
>> __alloc_frozen_pages_nolock_noprof(): ALLOC_WMARK_MIN is 0.
>>
>> Rationale that this doesn't change anything:
>>
>> 1. Simple bits: A bunch of the nolock-specific handling is just moved to
>>    the new alloc_order_allowed(), alloc_nolock_allowed() and
>>    gfp_nolock.
>>
>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>    previously in the nolock variant:
>>
>>    a. Application of gfp_allowed_mask; this only affects early boot,
>>       only flags that affect the slowpath get changed here, and the
>>       nolock allocation path isn't allowed to the GFP_BOOT_MASK flags.
>>
>>    b. Application of current_gfp_context() - also only affects the
>>       slowpath
>>
>> 3. The slowpath itself: this is now just explicitly skipped under
>>    !ALLOC_TRYLOCK.
>
> s/TRYLOCK/NOLOCK

Thanks - Andrew would you mind fixing this up in mm-new?

>>
>> Ulterior motive: adding an alloc_flags arg to the allocator's
>> mm-internal entrypoint can later be used to do more allocation
>> customisation without needing to create new GFP flags.
>>
>> No functional change intended.
>>
>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>  mm/hugetlb.c    |   3 +-
>>  mm/mempolicy.c  |  10 +--
>>  mm/page_alloc.c | 192 +++++++++++++++++++++++++++++--------------------=
-------
>>  mm/page_alloc.h |   6 +-
>>  mm/slub.c       |   6 +-
>>  5 files changed, 117 insertions(+), 100 deletions(-)
>>
>
> <snip>
>
>> +/*
>> + * This is the 'heart' of the zoned buddy allocator.
>> + */
>> +struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>> +		int preferred_nid, nodemask_t *nodemask, unsigned int alloc_flags)
>> +{
>> +	struct page *page;
>> +	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
>> +	struct alloc_context ac =3D { };
>> +	unsigned int fastpath_alloc_flags =3D alloc_flags;
>> +
>> +	/* Other flags could be supported later if needed. */
>> +	if (WARN_ON(alloc_flags & ~ALLOC_NOLOCK))
>>  		return NULL;
>> =20
>> +	if (!alloc_order_allowed(gfp, order, alloc_flags))
>> +		return NULL;
>> +
>> +	if (alloc_flags & ALLOC_NOLOCK) {
>> +		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
>> +		if (!alloc_nolock_allowed())
>> +			return NULL;
>
> At first look, I wonder why __alloc_frozen_pages_noprof() needs to care
> about alloc_nolock_allowed(). But the patch's idea is to centralize all
> allocation policies, so it makes sense.
>
> Ideally, I would want alloc_frozen_pages_nolock_noprof() to filter as
> much as possible, so that __alloc_frozen_pages_noprof() has minimal/no
> awareness of ALLOC_NOLOCK. But ALLOC_NOLOCK has different preferences
> compared to the default __alloc_frozen_pages_noprof() policy like
> ALLOC_WMARK_MIN vs ALLOC_WMARK_LOW, skip slowpath, and more. Maybe we
> could do something like:
>
> __alloc_frozen_pages_noprof()
> {
>      alloc_fastpath();
>      alloc_slowpath();
> }
>
> alloc_frozen_pages_nolock_noprof()
> {
>     alloc_order_allowed();
>     alloc_nolock_allow();
>     alloc_fastpath();
> }
>
> But it still cannot remove ALLOC_NOLOCK completely from
> __alloc_frozen_pages_noprof(), like the nofragment skip. Anyway, this
> patch is a reasonable cleanup. Thanks.

Yeah, thanks this does look sensible but I think it's a separate
cleanup.
