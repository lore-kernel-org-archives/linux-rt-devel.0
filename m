Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094723645D;
	Wed,  1 Jul 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871813; cv=none; b=arLICIkdH2B67Jti4LO89VqG2oe6k0h9piZS1q3zGPmLMHdVx38t4fGWtS8nQM9kNs0dZF7SuhyoK7UFjgNXdSLT0Y0GIB3vGiQl2DTxeMrG92/WQLsbddVIY4msDz1GRPPetJWVTUera3hbFveB+RLw3fXRqYGKfG6Q430kVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871813; c=relaxed/simple;
	bh=1aQ7xuiCvp3drMakTFcko4BeGbiv22U6yGbR8b2NPoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olyqUlnsXGpudvvhLAHOc8jqRoxgJcCYg28LzIDutJYX6iLLABd+9NwiFqTiIUib9dQPOnzN11GCwlcQXUyDSEBugvR5IYzFEEmXYWkeCwBLzfSMwDBx8+r96rS8cnlH9ajOZlPLHed1VSmaal6Sz+SWcXeQRfGIsSq2rg58WKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEQwEePj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEQwEePj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7105B1F00A3A;
	Wed,  1 Jul 2026 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782871812;
	bh=ewUR5EKwRVK7OHg0Wq3wjxtpvGAISbTvWg9/qD2xWwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JEQwEePjCvYahCGPlAyQXMLv5Z0Jdfx8U8WnLSI0QRUCzBoM6ZTsvx0oZqyLme71K
	 uID8B7vNlARwSRu30nQbit473tWcKkj79IzZP9FfDroja40KwRgHss80Jqh3ARFKsN
	 6jAsXQFZCQsYdFFHxellyxWwtC4sL4qW01Xvlkf1M3clUuaKZP9vNaJw2eP+ZTjrKd
	 Ci4B8Nlgfia1hHf1Fv5+aYq6Cyn6OHmwqVjxYToCqnK9ez0/q2BClXts2T4Kj5Vlm4
	 h5VqBRUxA0CCPPCR7jKpG28B8AqQ8fqV+kCEKahlcFjsstTdjpIgkMMrmsXbU7SvEx
	 zUBPncHDn/b6A==
Message-ID: <3beb08a2-d1ce-478c-bd10-9434b417752d@kernel.org>
Date: Wed, 1 Jul 2026 11:10:03 +0900
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
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Brendan Jackman <jackmanb@google.com>,
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
Cc: Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
 <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
 <11a6d404-dc87-442a-9f2c-9cf34cae4869@kernel.org>
 <DJMJIZGFZHEQ.3IIRFIZYFGB6O@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJMJIZGFZHEQ.3IIRFIZYFGB6O@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/1/26 1:56 AM, Brendan Jackman wrote:
> On Tue Jun 30, 2026 at 3:34 PM UTC, Vlastimil Babka (SUSE) wrote:
>> On 6/30/26 15:36, Harry Yoo wrote:
>>>
>>>
>>> On 6/29/26 10:11 PM, Brendan Jackman wrote:
>>>> Currently the core allocator code is controlled by ALLOC_NOLOCK, but=
 the
>>>> main entry point function is significantly different from the normal=

>>>> __alloc_frozen_pages_nolock(), this is tiring when reading the code.=

>>>>
>>>> Plumb the ALLOC_NOLOCK control one layer up in the call stack: creat=
e
>>>> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is o=
nly
>>>> exposed to mm/) and then turn the nolock variant into a thin wrapper=

>>>> that just sets that flag (as well as handling NUMA_NO_NODE, similar =
to
>>>> how some of the wrappers in gfp.h do).
>>>>
>>>> Rationale that this doesn't change anything:
>>>>
>>>> 1. Simple bits: A bunch of the nolock-specific handling is just move=
d to
>>>>    the new alloc_order_allowed(), alloc_trylock_allowed() and
>>>>    gfp_trylock.
>>>
>>> Right.
>>>
>>>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>>>    previously in the nolock variant:
>>>>
>>>>    a. Application of gfp_allowed_mask; this only affects early boot,=
 and
>>>>       only flags that affect the slowpath get changed here.
>>>
>>> gfp_allowed_mask clears __GFP_RECLAIM, and that means now allocations=

>>> with GFP_KERNEL during early boot would see
>>> gfpflags_allow_spinning() =3D false.
>>
>> Is it a problem though? non-nolock allocations were affected before (t=
he
>> masking existed for those already) and will be affected now the same, =
and
>> _nolock() allocations don't pass __GFP_RECLAIM in the first place, so =
the
>> masking can't affect them?
>
> This was my thinking too.

Oh! You guys are right :) I was confused.

>>> The helper is not used in in the page allocator, but used in
>>> memcg/stackdepot/page_owner.
>>>
>>>>    b. Application of current_gfp_context() - also only affects the
>>>>       slowpath
>>>
>>> PF_MEMALLOC_PIN affects the fast path, but ALLOC_NOLOCK users
>>> won't be affected.
>>
>> And it wouldn't be wrong if they were? It only clears __GFP_MOVABLE?

Nothing wrong, but wanted to mention things that were not mentioned in
the changelog as it argues there's no functional change intended.

>>> What about alloc_flags_nofragment/nonblocking()?
>>
>> ALLOC_NOFRAGMENT due to e.g. defrag_mode could be a problem indeed, if=

>> there's no slowpath. Make ALLOC_NOLOCK override it?
>=20
> Yeah calling alloc_flags_nofragment() here is a bug in the patch,
> and Sashiko also complained:=20
>=20
> https://lore.kernel.org/all/20260629142921.9A05A1F000E9@smtp.kernel.org=
/
>=20
> Like I said in the reply to that thread I think maybe we _do_ want to
> set ALLOC_NOFRAGMENT for nolock allocations? But, that is a functional
> change, it doesn't belong in this series.

I don't think it was intentional to bypass ALLOC_NOFRAGMENT for nolock
allocations. But yeah that's a functional change.

>> nonblocking() is probably fine?
>=20
> Yeah, I believe this is fine.

Agreed.

--=20
Cheers,
Harry / Hyeonggon

