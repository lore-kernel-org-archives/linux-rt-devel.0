Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BD3C2BBA
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839081; cv=none; b=Y4l33R1leBhkKhy5oRqYCkdwZ5fQLufW96nRGJ4fPL+NVM5KhM4noepQLCRvk+OCxOVAl7TUkQP+ek09gVJZuk1o/CxeKjUaQ/bU3rBveWdrRrXdxwpysD1x7ldpQBYaTaHl2ISdShxB8sH5B4RjACdv7VUpjjuCUUA+dDTPjQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839081; c=relaxed/simple;
	bh=W8wueXs23wqvjeskb2y9BjPbrMMAMyqA2cnkfTHs7Xo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PPxAQ9I7IeeYOUEkA45OquYdZ0IRO+1OEg1CwIfD+CIOTHfJC/urxLpiObgwKaNXOJkRcpa5ikhxZUE83FPMKt7d8Bwu7c4gPjhhMa/yvFrOpm+HrJ1xM+uWcOOVuLZWEmDOYs9XvD5q1RiluZ/zP792FJOLR11Fp9O740lqM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIUeLrAU; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIUeLrAU"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782839067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/CsbYV4XDviXFW81lgbhLDB47StBOrhGmsnhiBiiro=;
	b=qIUeLrAUS8xPYvH8/wmNw9ubJF/bC6wfh5Yz9at3wXaV/ZuZvRPIshyNxD8wu7TqRSa3rT
	rvJh5wtFqMw0/sNSjkLYMl0al8s75VU857iAX6TkFB5XIiC6pAWxVzA6x5W3L2mg216yNP
	nMH92Rx11cETlXGkXmlp2r1oqn9Yax4=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 17:04:21 +0000
Message-Id: <DJMJPA37E3V0.39XKKI63O2ETU@linux.dev>
To: "Harry Yoo" <harry@kernel.org>, "Brendan Jackman" <jackmanb@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
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
 Rostedt" <rostedt@goodmis.org>
Cc: "Gregory Price" <gourry@gourry.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Matthew Wilcox" <willy@infradead.org>, "Hao Ge"
 <hao.ge@linux.dev>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v3 05/16] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
 <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
In-Reply-To: <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue Jun 30, 2026 at 1:36 PM UTC, Harry Yoo wrote:
>> Ulterior motive: adding an alloc_flags arg to the allocator's
>> mm-internal entrypoint can later be used to do more allocation
>> customisation without needing to create new GFP flags.
>>=20
>> While adding this flag to a bunch of places, create ALLOC_DEFAULT to
>> avoid a mysterious literal 0 in most places.
>>
>> alloc_frozen_pages_noprof() is defined above the alloc flags
>
> The function is defined below the alloc flags, no?

Yep this paragraph is stale since I created mm/page_alloc.h, will remove
it.

>> so just leave that as a slightly messy
>> exception instead of trying to fully reorder mm/internal.h for that one
>> case.
>>=20
>> No functional change intended.
>>=20
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>  mm/hugetlb.c    |   3 +-
>>  mm/mempolicy.c  |  10 ++--
>>  mm/page_alloc.c | 178 +++++++++++++++++++++++++++++--------------------=
-------
>>  mm/page_alloc.h |   6 +-
>>  mm/slub.c       |   6 +-
>>  5 files changed, 108 insertions(+), 95 deletions(-)
>>=20
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a3ba63c7f9199..8d409d075e3e9 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5271,24 +5271,98 @@ void free_pages_bulk(struct page **page_array, u=
nsigned long nr_pages)
>>  	}
>>  }
>> =20
>> +static inline bool alloc_trylock_allowed(void)
>> +{
>> +	/*
>> +	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
>> +	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the curren=
t
>> +	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() wil=
l
>> +	 * mark the task as the owner of another rt_spin_lock which will
>> +	 * confuse PI logic, so return immediately if called from hard IRQ or
>> +	 * NMI.
>> +	 *
>> +	 * Note, irqs_disabled() case is ok. This function can be called
>> +	 * from raw_spin_lock_irqsave region.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>> +		return false;
>> +
>> +	/* On UP, spin_trylock() always succeeds even when it is locked */
>> +	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
>> +		return false;
>
> Except for deferred_pages_enabled(), it's not specific to the page
> allocator. SLUB has
>
> 	/*
> 	 * See the comment for the same check in
> 	 * alloc_frozen_pages_nolock_noprof()
> 	 */
>
> ... and repeats the same thing as above.
>
> Perhaps let's factor it out into a helper
> rather than trying not to forget to update the other place?

Hm, not sure about this. I think I would say it's a "coincidence" that
these two bits of code look the same? Like, page_alloc.c uses
spin_trylock() so you can't do alloc_pages_nolock() from IRQ on
PREEMPT_RT. slub.c ALSO uses spin_trylock(), so you ALSO can't use
kmalloc_nolock() in those scenarios. But those are two different facts
that just happen to be isomorphic? Putting them into a shared helper
would kinda imply that these are part of a single system with inherently
coupled constraints.

I dunno I'm being a bit of a ponderous philosopher there, I don't have
particularly strong feelings. But I'd lean towards leaving this out of
the patchset since the potential deduplication isn't really related to
the other cleanups anyway.
