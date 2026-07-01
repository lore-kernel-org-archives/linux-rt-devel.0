Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D339FCCC
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895278; cv=none; b=Wz4dwMnPIBPYBV/40Vlv+p4osWeJpmC8Cc1rXKJtU8mvNqTOGuT8inRUDapzQmnOlieQIrFfnbNtHVzM4pSNh17xY0QQ+OCzd+17Drmbk8l1Ty5sPxIcb5vphcGxPUUB4glmKmx3nRwjCDz43oTQP9rM3QKnsI4wDFrDZ0jlZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895278; c=relaxed/simple;
	bh=nsxGIrdrz1p7UQGk15zk8vdSso+4xAlR+DYGhsOZKbs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GaXMwDIGF2vQhSSrfHrtUPjAOTPwbStDPwg3cam2KgeVyBBNIUViFBDgwl7lbFLeIiSPq6jLzyKsUNlSc+ausOMLtkb1a//clrlAfDPBDBi9Q+MIrXYpWJfDwMVlqEFj6mzv3NTNM1+WWU6yARPryUCEDMsZ19yPwCw+4RGZPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DmU9SIka; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmU9SIka"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782895273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGrFD8S8lQ+BASYixy8RN9uVW/2UQNoP/HAty0kmd4I=;
	b=DmU9SIkabHFsQPD8XxzUshbsAT7wCxhtvnPHcgxRiNYlAjgVDK+AILgqoS4CwAOOWXLgCu
	ZU2oOAPTr0qa96GDozfDP/t3fIQDl79mExZWgZWMEoz6iwZCBQ1UeHdevZl7fb5RVIN14N
	Xool8UPLEtm+blogWqnWnSN/fnm/dYU=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 08:40:50 +0000
Message-Id: <DJN3MAVWO7YV.2FIHJGQO8I6US@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Harry Yoo" <harry@kernel.org>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Brendan Jackman" <jackmanb@google.com>,
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
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
 <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
 <DJMJPA37E3V0.39XKKI63O2ETU@linux.dev>
 <791b1aee-8667-4721-ad93-2a1b8fd2aef1@kernel.org>
In-Reply-To: <791b1aee-8667-4721-ad93-2a1b8fd2aef1@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed Jul 1, 2026 at 2:21 AM UTC, Harry Yoo wrote:
>
>
> On 7/1/26 2:04 AM, Brendan Jackman wrote:
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index a3ba63c7f9199..8d409d075e3e9 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -5271,24 +5271,98 @@ void free_pages_bulk(struct page **page_array,=
 unsigned long nr_pages)
>>>>  	}
>>>>  }
>>>> =20
>>>> +static inline bool alloc_trylock_allowed(void)
>>>> +{
>>>> +	/*
>>>> +	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
>>>> +	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the curr=
ent
>>>> +	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() w=
ill
>>>> +	 * mark the task as the owner of another rt_spin_lock which will
>>>> +	 * confuse PI logic, so return immediately if called from hard IRQ o=
r
>>>> +	 * NMI.
>>>> +	 *
>>>> +	 * Note, irqs_disabled() case is ok. This function can be called
>>>> +	 * from raw_spin_lock_irqsave region.
>>>> +	 */
>>>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>>>> +		return false;
>>>> +
>>>> +	/* On UP, spin_trylock() always succeeds even when it is locked */
>>>> +	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
>>>> +		return false;
>>>
>>> Except for deferred_pages_enabled(), it's not specific to the page
>>> allocator. SLUB has
>>>
>>> 	/*
>>> 	 * See the comment for the same check in
>>> 	 * alloc_frozen_pages_nolock_noprof()
>>> 	 */
>>>
>>> ... and repeats the same thing as above.
>>>
>>> Perhaps let's factor it out into a helper
>>> rather than trying not to forget to update the other place?
>>=20
>> Hm, not sure about this. I think I would say it's a "coincidence" that
>> these two bits of code look the same? Like, page_alloc.c uses
>> spin_trylock() so you can't do alloc_pages_nolock() from IRQ on
>> PREEMPT_RT. slub.c ALSO uses spin_trylock(), so you ALSO can't use
>> kmalloc_nolock() in those scenarios. But those are two different facts
>> that just happen to be isomorphic? Putting them into a shared helper
>> would kinda imply that these are part of a single system with inherently
>> coupled constraints.
>
> But as long as they use spinlocks and can be called in unknown contexts,
> they are supposed to have the same constraint?
>
> And actually, the only reason free_pages_nolock() or kfree_nolock()
> don't have these checks is just because we don't allow kmalloc() ->
> kfree_nolock() or alloc_pages() -> free_pages_nolock(). Once we allow
> them, we'll need to repeat this again.
>
> I think it doesn't even belong page/slab allocators,
> probably should be spin_trylock_allowed()?

You are right. I was imagining a function called alloc_nolock_allowed()
but actually now I see the name spin_trylock_allowed() I realise it's
not about the allocators (which both just happen to use spin_trylock())
at all, it makes perfect sense.

>> But I'd lean towards leaving this out of> the patchset since the
> potential deduplication isn't really related to
>> the other cleanups anyway.
>
> Ack.

Patchset is getting pretty big already but most stuff is already acked
and also most of the patches are trivial so maybe I'll tack it on after
all...
