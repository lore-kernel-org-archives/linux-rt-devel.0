Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDF18FDBD;
	Wed,  1 Jul 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872489; cv=none; b=mEAo1rwPgoMmmzxk19pSfQ/wKsSaPD2WeXkdKDEYb5nwCkH67Ne5HFu1sGhNh2ACn8Jc3DNAri3++CYrCfRKFiU9bGDcxEaf2kb27kzG1PiVlWUSVUNT+xm67/s1N5+LGrZgLe9BjBvDIJ5jxukF4GmgFzbKp5ULjO3tc9SjjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872489; c=relaxed/simple;
	bh=auauuOjZ92BaKsENNiNkswrNlwykoFTYdO/+oXjkZ1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nof5CbNiXpwVI7DCtrQLMfr8/5SMyZSl14wJLFcquFpHBqoBDgj3P9fAi9v9mUZO9qyvTPoJmjLIgAVyxVTmk+mx74IG2sRd6LiTDeUZNzKGv3JjPcNIoX35s9wuXGwcUgz/2CymCxnAAS5pAnXp18XLFi2fzMtPRQIxWhOsIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS4zIjG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS4zIjG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439E71F000E9;
	Wed,  1 Jul 2026 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872488;
	bh=zVfVUy7IfXqZtOhE1UFWWdUajt97pUy56ocHqvqgDOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hS4zIjG1iKnyvbC1j55hqujYovzRU7RrTYvCHSGCq2EhprH3x5VvLMPx7/cP5K6kE
	 DQpMolhpTWoHpkkFtOfjW0+teIem5DqywhOWROmOQcbzczRwKONTSi5XCkEp2g9xhM
	 DxftY/gA2fib91mCi5eSRElaByTYiZuSHs1TPiDKU/GxvaZPhMcbTrzyq6ghFhM8sm
	 Pc7HiVGimFGtEQ7vur6v9h9f1XC9ySZ2braLjDI8Sxx4ADIinH8PZdmgq1a3+LQqbR
	 +6UqvdqsMrw2GdZKTV/BTi2vkeuZmyaOvt8Kbjg1ChAeMAL1TRKatQAOCxMLAi8qu3
	 4Wzm7Nbb8g8ag==
Message-ID: <791b1aee-8667-4721-ad93-2a1b8fd2aef1@kernel.org>
Date: Wed, 1 Jul 2026 11:21:20 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
To: Brendan Jackman <brendan.jackman@linux.dev>,
 Brendan Jackman <jackmanb@google.com>,
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
Cc: Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
 <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
 <DJMJPA37E3V0.39XKKI63O2ETU@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJMJPA37E3V0.39XKKI63O2ETU@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/1/26 2:04 AM, Brendan Jackman wrote:
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index a3ba63c7f9199..8d409d075e3e9 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5271,24 +5271,98 @@ void free_pages_bulk(struct page **page_array=
, unsigned long nr_pages)
>>>  	}
>>>  }
>>> =20
>>> +static inline bool alloc_trylock_allowed(void)
>>> +{
>>> +	/*
>>> +	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
>>> +	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the cur=
rent
>>> +	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() =
will
>>> +	 * mark the task as the owner of another rt_spin_lock which will
>>> +	 * confuse PI logic, so return immediately if called from hard IRQ =
or
>>> +	 * NMI.
>>> +	 *
>>> +	 * Note, irqs_disabled() case is ok. This function can be called
>>> +	 * from raw_spin_lock_irqsave region.
>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>>> +		return false;
>>> +
>>> +	/* On UP, spin_trylock() always succeeds even when it is locked */
>>> +	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
>>> +		return false;
>>
>> Except for deferred_pages_enabled(), it's not specific to the page
>> allocator. SLUB has
>>
>> 	/*
>> 	 * See the comment for the same check in
>> 	 * alloc_frozen_pages_nolock_noprof()
>> 	 */
>>
>> ... and repeats the same thing as above.
>>
>> Perhaps let's factor it out into a helper
>> rather than trying not to forget to update the other place?
>=20
> Hm, not sure about this. I think I would say it's a "coincidence" that
> these two bits of code look the same? Like, page_alloc.c uses
> spin_trylock() so you can't do alloc_pages_nolock() from IRQ on
> PREEMPT_RT. slub.c ALSO uses spin_trylock(), so you ALSO can't use
> kmalloc_nolock() in those scenarios. But those are two different facts
> that just happen to be isomorphic? Putting them into a shared helper
> would kinda imply that these are part of a single system with inherentl=
y
> coupled constraints.

But as long as they use spinlocks and can be called in unknown contexts,
they are supposed to have the same constraint?

And actually, the only reason free_pages_nolock() or kfree_nolock()
don't have these checks is just because we don't allow kmalloc() ->
kfree_nolock() or alloc_pages() -> free_pages_nolock(). Once we allow
them, we'll need to repeat this again.

I think it doesn't even belong page/slab allocators,
probably should be spin_trylock_allowed()?

> But I'd lean towards leaving this out of> the patchset since the
potential deduplication isn't really related to
> the other cleanups anyway.

Ack.

--=20
Cheers,
Harry / Hyeonggon

