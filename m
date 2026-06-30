Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D743C0610
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838590; cv=none; b=DuVitSu8igNGalHqLxJcYqnnySJdQXig/Fs39cYLg7ePqFp7UhYRf1UQHzylm5uFS/K9vdPUUKu9jLV5EAU7eBdLeBaI8sPVnvSkJXU1s8kjg/Tx91C2SOrOP/yXrOiuOY6MHMGsRq2b9t1v6yKnKPYM5ZFdquvh9ASg73X9lWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838590; c=relaxed/simple;
	bh=t1pvd1sj9NUwuA0h5BynpLFv7a9BymAC6H29i8T/QMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FCOows8lFdehtmLi784k/rpYTbFXlRN5ChgwrKQQ9b4yKGX3UFlzhnoH63clTNQUWiXnONdvKXSjaLcrMo1uG2kfCC/6NVNiyDQr1Hrm6xUwS7bu+viW5hC5RMKLRRlTgJARThKfRl0mAk6sDhOF26bMzWUSD2bU6AMI6yd5IpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLlmfsF/; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLlmfsF/"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782838585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqHYqouwZFakB3/yAJGkeIhefpYHS6QsTSYK57j0e1I=;
	b=JLlmfsF/x2Mo/N7b1BVsCr77TnV1ido8SLAzQcSgAuPuPr+zdQxni7oTzhcxDij9WivpZN
	cCajOF9WUHJxJh+yx/7t5DN4ljl7Ga8y/38TczYWWjmOqVddw3G0X9yGUH88It0Vt0ra/Q
	gmscYMCcvBjMBMK+tCeXJJe2KhbGPU4=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 16:56:08 +0000
Message-Id: <DJMJIZGFZHEQ.3IIRFIZYFGB6O@linux.dev>
Cc: "Gregory Price" <gourry@gourry.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Matthew Wilcox" <willy@infradead.org>, "Hao Ge"
 <hao.ge@linux.dev>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v3 05/16] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Harry Yoo"
 <harry@kernel.org>, "Brendan Jackman" <jackmanb@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
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
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
 <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
 <11a6d404-dc87-442a-9f2c-9cf34cae4869@kernel.org>
In-Reply-To: <11a6d404-dc87-442a-9f2c-9cf34cae4869@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue Jun 30, 2026 at 3:34 PM UTC, Vlastimil Babka (SUSE) wrote:
> On 6/30/26 15:36, Harry Yoo wrote:
>>=20
>>=20
>> On 6/29/26 10:11 PM, Brendan Jackman wrote:
>>> Currently the core allocator code is controlled by ALLOC_NOLOCK, but th=
e
>>> main entry point function is significantly different from the normal
>>> __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>>>=20
>>> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
>>> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only
>>> exposed to mm/) and then turn the nolock variant into a thin wrapper
>>> that just sets that flag (as well as handling NUMA_NO_NODE, similar to
>>> how some of the wrappers in gfp.h do).
>>>=20
>>> Rationale that this doesn't change anything:
>>>
>>> 1. Simple bits: A bunch of the nolock-specific handling is just moved t=
o
>>>    the new alloc_order_allowed(), alloc_trylock_allowed() and
>>>    gfp_trylock.
>>=20
>> Right.
>>=20
>>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>>    previously in the nolock variant:
>>>=20
>>>    a. Application of gfp_allowed_mask; this only affects early boot, an=
d
>>>       only flags that affect the slowpath get changed here.
>>=20
>> gfp_allowed_mask clears __GFP_RECLAIM, and that means now allocations
>> with GFP_KERNEL during early boot would see
>> gfpflags_allow_spinning() =3D false.
>
> Is it a problem though? non-nolock allocations were affected before (the
> masking existed for those already) and will be affected now the same, and
> _nolock() allocations don't pass __GFP_RECLAIM in the first place, so the
> masking can't affect them?

This was my thinking too.

>> The helper is not used in in the page allocator, but used in
>> memcg/stackdepot/page_owner.
>>=20
>>>    b. Application of current_gfp_context() - also only affects the
>>>       slowpath
>>=20
>> PF_MEMALLOC_PIN affects the fast path, but ALLOC_NOLOCK users
>> won't be affected.
>
> And it wouldn't be wrong if they were? It only clears __GFP_MOVABLE?
>
>> What about alloc_flags_nofragment/nonblocking()?
>
> ALLOC_NOFRAGMENT due to e.g. defrag_mode could be a problem indeed, if
> there's no slowpath. Make ALLOC_NOLOCK override it?

Yeah calling alloc_flags_nofragment() here is a bug in the patch,
and Sashiko also complained:=20

https://lore.kernel.org/all/20260629142921.9A05A1F000E9@smtp.kernel.org/

Like I said in the reply to that thread I think maybe we _do_ want to
set ALLOC_NOFRAGMENT for nolock allocations? But, that is a functional
change, it doesn't belong in this series.

> nonblocking() is probably fine?

Yeah, I believe this is fine.
