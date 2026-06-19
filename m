Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9111330678
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856216; cv=none; b=QKUXtTRmpECCraEnkMsea95XUsaaX97v7SdvaMN012fUYedJ4aQ/P5I13F7rWY0Dll1nEpQdCTQmEMLYHtdws/8czTvTIkTyfj8oigcEzXOG14YjWhuUbLIuz1CBDtqytxv+jXmWGPS0cIMTCxC/c/GIj15L9fDqAdnU2MhM0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856216; c=relaxed/simple;
	bh=ztgvt3KFrUzJ9sy/un5zYu773skg9zw4JRLlJ1TpoY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HgCL1J7Hu7dJl+uZG2B+M8Nn50SYSv+idsOH/yArS18Z1LY0rbVcHtdcggTq9GNXWSHEnx/Gf2Ga5jwx4774Cn7sd2KaA9577bLFj732pLxR2xssZrNR6z8B1e1mmXwrppA2I03gC4KVOBKTMH7j1Mwi2Bb66OT2OW6+4v4y1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JO24wKCZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JO24wKCZ"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781856211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97ALfhxEHKnHr+DmTHdJ5AlydQr7RUIpXUMAyaq3tCI=;
	b=JO24wKCZF5d/OU6egxMZuPUk6dgIJvBGm4v0uD7IArIJp9pyn/5XcsAHDty9wVgahfTxAv
	wA4cxqUQmxO2lMudPiLf1Y+W6W9OXOpiiN+fOvhlTVMSvM6HZAgFEnVbVgZX5rBmdGBZgV
	ych8oKJROkfLPyWkoMLLClVHFy8WIKA=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 08:03:13 +0000
Message-Id: <DJCVAYJNZB2V.1DJFHIK9QB9EV@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Hao Ge" <hao.ge@linux.dev>, "Brendan Jackman" <jackmanb@google.com>,
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
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <692d9bfb-66ee-448c-942f-a26c07a19f61@linux.dev>
In-Reply-To: <692d9bfb-66ee-448c-942f-a26c07a19f61@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu Jun 18, 2026 at 6:56 AM UTC, Hao Ge wrote:
> Hi Brendan
>
>
> On 2026/6/17 23:29, Brendan Jackman wrote:
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
>> Rationale that this doesn't change anything:
>>
>> 1. Simple bits: A bunch of the nolock-specific handling is just moved to
>>     the new alloc_order_allowed(), alloc_trylock_allowed() and
>>     gfp_trylock.
>>
>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>     previously in the nolock variant:
>>
>>     a. Application of gfp_allowed_mask; this only affects early boot, an=
d
>>        only flags that affect the slowpath get changed here.
>>
>>     b. Application of current_gfp_context() - also only affects the
>>        slowpath
>>
>> 3. The slowpath itself: this is now just explicitly skipped under
>>     !ALLOC_TRYLOCK.
>>
>> Ulterior motive: adding an alloc_flags arg to the allocator's
>> mm-internal entrypoint can later be used to do more allocation
>> customisation without needing to create new GFP flags.
>
>
> If so, I believe we could generalize this further.
>
> Under the current logic, |__alloc_pages_slowpath| cannot access the=20
> alloc_flags
> passed down from upper-level callers.
> As I discussed in another thread, we can introduce a new alloc_flags to
> replace the |__GFP_NO_CODETAG| (|__GFP_NO_OBJ_EXT|) GFP flag.
> This newly added flag needs to be propagated along the entire call
> chain down to |prep_new_page|, which means |__alloc_pages_slowpath| also=
=20
> has to
> handle this flag accordingly.
>
> I'm wondering if we could introduce a caller_alloc_flags field within=20
> struct alloc_context
> to handle alloc_flags that need to persist throughout the entire page=20
> allocation cycle, when such flags exist.
> I'm sure others will have more appropriate solutions.

Yeah totally, this is exactly how I imagined this evolving.
