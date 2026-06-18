Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB41632E7
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749438; cv=none; b=YBeF911PZkKwyTfPeeR+sW+udJaLFDtcgtx3/vqGAPgGImMiAc7Nhbqp0jSwnwMzKgdxDrFOfPk2fxG3oHD/g2Yhfa0B2j2th80zTFDfR0NH7raaxqZOtstlh5qbTG6A3NTQ+TezLpoYtvxVC1xgwg4cxWg5sB1MFvlBWCAQruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749438; c=relaxed/simple;
	bh=RFJlpQy9TvmKjPUb9OCSTSfYfIKV9NtKRPpE3ThjANQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/lifdhOj4cSicfHNTe9mSmFUzfq+M841wDDZGvK3bpHbpwNI8pGOxtXgGyoAhQVFjqVK+QAEuFm4+K23/lkzJQrqa6feYCmH9ChBJROG0vsuzpo3REhyscKmRsdgMXjNJp7CJtYunHuVWKIy1L+u5LgAm0YPKJ3PiBI0Rvt6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O3UfvT/1; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O3UfvT/1"
Message-ID: <45fcc57a-ec8d-46d6-9c28-065d001c081f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781749433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfUm8af/m5Y+JvEu5zk0BWRI+9j/PXO2lmh/Wz0+tsw=;
	b=O3UfvT/1MKiXtNvGidZMkfJ5JuNdkyR8S+zPPWv9pS9CANHCtAc95ka7/DKnM/iGfcbWVb
	Ftrei5j/5KT11Bnfcu/K0q/mftP6aEgB40P687LESlZvdqrqD6vOCwMqayeuc19JuU2S7s
	mOQKdiH/a8oeTVe0QRkhZDezTFs9iMU=
Date: Thu, 18 Jun 2026 10:22:47 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
To: Brendan Jackman <brendan.jackman@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
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
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <ast@kernel.org>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org>
 <CAJuCfpG48TmvaiaRvnL-NXKU6nn55D3bks2DgzAc0URsZhAxqA@mail.gmail.com>
 <DJBHRVM65A11.1OL2M9MXN56H@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <DJBHRVM65A11.1OL2M9MXN56H@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2026/6/18 01:14, Brendan Jackman wrote:
> On Wed Jun 17, 2026 at 4:49 PM UTC, Suren Baghdasaryan wrote:
>> On Wed, Jun 17, 2026 at 9:39 AM Vlastimil Babka (SUSE)
>> <vbabka@kernel.org> wrote:
>>> +Cc Alexei
>>>
>>> On 6/17/26 17:29, Brendan Jackman wrote:
>>>> Currently the core allocator code is controlled by ALLOC_NOLOCK, but the
>>> It's not, it's ALLOC_TRYLOCK! Thanks for proving that we need to rename it
>>> to ALLOC_NOLOCK:
>>>
>>> https://lore.kernel.org/all/DJ9QPTO2WXNB.10E88ZHWRDHB0@gmail.com/
>>>
>>> So you just won the job to do the rename :) I think it should be done before
>>> this patch, so that the new usages and other _trylock names introduced here
>>> can be done as _nolock outright.
> Ack. I'll aim to send that tomorrow once Sashiko has caught up.
>
>>>> main entry point function is significantly different from the normal
>>>> __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>>>>
>>>> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
>>>> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only
>>>> exposed to mm/) and then turn the nolock variant into a thin wrapper
>>>> that just sets that flag (as well as handling NUMA_NO_NODE, similar to
>>>> how some of the wrappers in gfp.h do).
>>>>
>>>> Rationale that this doesn't change anything:
>>>>
>>>> 1. Simple bits: A bunch of the nolock-specific handling is just moved to
>>>>     the new alloc_order_allowed(), alloc_trylock_allowed() and
>>>>     gfp_trylock.
>>>>
>>>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>>>     previously in the nolock variant:
>>>>
>>>>     a. Application of gfp_allowed_mask; this only affects early boot, and
>>>>        only flags that affect the slowpath get changed here.
>>>>
>>>>     b. Application of current_gfp_context() - also only affects the
>>>>        slowpath
>>>>
>>>> 3. The slowpath itself: this is now just explicitly skipped under
>>>>     !ALLOC_TRYLOCK.
>>> I'll have to ponder it more closely.
>>>
>>>> Ulterior motive: adding an alloc_flags arg to the allocator's
>>>> mm-internal entrypoint can later be used to do more allocation
>>>> customisation without needing to create new GFP flags.
>>> Ack.
>> I think this change might also help us in removing __GFP_NO_CODETAG
> Nice, this actually looks trivial? I can probably just tack it onto the
> v2 for this patch/series.
>
>> introduced in [1] and being the only user of __GFP_NO_OBJ_EXT once
>> Vlastimil's patchset removing other __GFP_NO_OBJ_EXT users lands.
>> CC'ing Hao as he is brainstorming ways to remove __GFP_NO_CODETAG, and
>> this might be the answer.


Hi Brendan, Suren,

Thanks for CC'ing me, Suren. This is indeed a viable approach

and I believe it brings us one step closer to removing

__GFP_NO_CODETAG entirely.


Brendan, I'd actually put together a rough local implementation

earlier with mostly the same core idea as yours, and this change

would indeed be minimal based on your patch.

Thanks a lot for being interested in tacking this into your v2 patch series.


Thanks

Best Regards

Hao


>>> Besides the need to ponder unintended effects, mostly LGTM. Just not a fan
>>> of the hardcoded '0' passed at various places. In the slab variant of this
>>> (the thread I've linked above) I went with SLAB_ALLOC_DEFAULT, so you can do
>>> e.g. ALLOC_DEFAULT here?
> Yup ALLOC_DEFAULT sounds fine to me.
>
> Thanks for the reviews as always.
