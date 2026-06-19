Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BA1F1932
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870277; cv=none; b=USvg5FNPJNuDYQp1uRKe9iUa7PIbM4plxMMTQsoWSVC5Bt0G8XwA8wLfKCx8rOYKAMTSMuqYQeXkbpY9VVsYLKdQbovUf40BReECe9FByrWYlhKGbkD8+qh1MpcLkjIpig9cvupbZxnLJ7SUm8hiT+lmZBRj6+CkX0rug4qMDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870277; c=relaxed/simple;
	bh=wyhkemWNQpWjGxa/C2PnC8oIGT28ZI7NMGInkEie8vE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hBriB1pREbEo7hUy91Jt3EPCpfQSOqJ0DpzMKa1GeMQyCyKrf5E+htofr4CYeElIokPkBLnHXMdMTgy8EkEtvx+lTQ1BrTg/7c2DNTP4ZGa9yjic8/mnbKy96X5qHM2a22V1Y/cearetVj8GRVy+xDVvclUYYnNSwmaBisdWjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQUYWDF3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQUYWDF3"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781870263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wftliC1LQ6z9VS1Gw5TysYxVhKRYeesey3bP0ol5Avg=;
	b=qQUYWDF3+qK8Youd5mWL5OSayVDCQc7sH6PPvGQhfyxa9pcZi3OvfCDvkSPhBx6ULmXnDY
	ysHy9TRSNVAdPxtbcopzGMXib8jKqMynp2WmE46jofyPIXckB/hSRrU8biBNnlOxkXjsDK
	xQcfgnKGWSwIMYnqGWgtr42osPzhabs=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 11:57:39 +0000
Message-Id: <DJD0AGHTWYRN.1YWG5MDH87WVO@linux.dev>
To: "Hao Ge" <hao.ge@linux.dev>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Suren Baghdasaryan" <surenb@google.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Brendan Jackman" <jackmanb@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Michal Hocko" <mhocko@suse.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Muchun Song"
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
 Rostedt" <rostedt@goodmis.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org>
 <CAJuCfpG48TmvaiaRvnL-NXKU6nn55D3bks2DgzAc0URsZhAxqA@mail.gmail.com>
 <DJBHRVM65A11.1OL2M9MXN56H@linux.dev>
 <45fcc57a-ec8d-46d6-9c28-065d001c081f@linux.dev>
In-Reply-To: <45fcc57a-ec8d-46d6-9c28-065d001c081f@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu Jun 18, 2026 at 2:22 AM UTC, Hao Ge wrote:
>
> On 2026/6/18 01:14, Brendan Jackman wrote:
>> On Wed Jun 17, 2026 at 4:49 PM UTC, Suren Baghdasaryan wrote:
>>> On Wed, Jun 17, 2026 at 9:39=E2=80=AFAM Vlastimil Babka (SUSE)
>>> <vbabka@kernel.org> wrote:
>>>> +Cc Alexei
>>>>
>>>> On 6/17/26 17:29, Brendan Jackman wrote:
>>>>> Currently the core allocator code is controlled by ALLOC_NOLOCK, but =
the
>>>> It's not, it's ALLOC_TRYLOCK! Thanks for proving that we need to renam=
e it
>>>> to ALLOC_NOLOCK:
>>>>
>>>> https://lore.kernel.org/all/DJ9QPTO2WXNB.10E88ZHWRDHB0@gmail.com/
>>>>
>>>> So you just won the job to do the rename :) I think it should be done =
before
>>>> this patch, so that the new usages and other _trylock names introduced=
 here
>>>> can be done as _nolock outright.
>> Ack. I'll aim to send that tomorrow once Sashiko has caught up.
>>
>>>>> main entry point function is significantly different from the normal
>>>>> __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>>>>>
>>>>> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
>>>>> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is on=
ly
>>>>> exposed to mm/) and then turn the nolock variant into a thin wrapper
>>>>> that just sets that flag (as well as handling NUMA_NO_NODE, similar t=
o
>>>>> how some of the wrappers in gfp.h do).
>>>>>
>>>>> Rationale that this doesn't change anything:
>>>>>
>>>>> 1. Simple bits: A bunch of the nolock-specific handling is just moved=
 to
>>>>>     the new alloc_order_allowed(), alloc_trylock_allowed() and
>>>>>     gfp_trylock.
>>>>>
>>>>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>>>>     previously in the nolock variant:
>>>>>
>>>>>     a. Application of gfp_allowed_mask; this only affects early boot,=
 and
>>>>>        only flags that affect the slowpath get changed here.
>>>>>
>>>>>     b. Application of current_gfp_context() - also only affects the
>>>>>        slowpath
>>>>>
>>>>> 3. The slowpath itself: this is now just explicitly skipped under
>>>>>     !ALLOC_TRYLOCK.
>>>> I'll have to ponder it more closely.
>>>>
>>>>> Ulterior motive: adding an alloc_flags arg to the allocator's
>>>>> mm-internal entrypoint can later be used to do more allocation
>>>>> customisation without needing to create new GFP flags.
>>>> Ack.
>>> I think this change might also help us in removing __GFP_NO_CODETAG
>> Nice, this actually looks trivial? I can probably just tack it onto the
>> v2 for this patch/series.
>>
>>> introduced in [1] and being the only user of __GFP_NO_OBJ_EXT once
>>> Vlastimil's patchset removing other __GFP_NO_OBJ_EXT users lands.
>>> CC'ing Hao as he is brainstorming ways to remove __GFP_NO_CODETAG, and
>>> this might be the answer.
>
>
> Hi Brendan, Suren,
>
> Thanks for CC'ing me, Suren. This is indeed a viable approach
>
> and I believe it brings us one step closer to removing
>
> __GFP_NO_CODETAG entirely.
>
>
> Brendan, I'd actually put together a rough local implementation
>
> earlier with mostly the same core idea as yours, and this change
>
> would indeed be minimal based on your patch.
>
> Thanks a lot for being interested in tacking this into your v2 patch seri=
es.

Oh, I just took a look and it's a bit more fiddly than I thought because
alloc_tag.c is actually in lib/ not mm/.=20

How did you tackle that, can you share your implementation? It would be
nice if we can avoid exposing alloc_flags in gfp.h.
