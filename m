Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8E40D56B
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318273; cv=none; b=f1//uPVb1PchT2/SrxWXiWrGkaaxqJKVIVKSj/iZH1bAfXK6Fs48RmcOFZxLFjbC9t9JhF4yF8kDq5X0cAfICUDmoWq6n1JmSRLcNNGHEyqOdkEGzgupEwCXuOuPVvC+t+fVShDRg2eU9rMfsvvCplg+Rsbpf16qBN362qJNOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318273; c=relaxed/simple;
	bh=pIX/mM3PQMYGUaXlw5O3DtlmpIS9XfSE+7CEFFkIjzI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p2ZSvooTDrVuZ2AR5hbg3dvkxbvNfH0TYL+GaM8jYK6w2N5qEByFbwA39GDgM0TNtuhe3jTIeFWiYHllDnYKOdFJZDyZU7xllrFDOuVgvKu3OHQARQCJBqD86z7DY6fOfuODL+kO4x3hq/tH7H6/hTdWFo4N2tPg5Yn32zE41Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qFHnevJg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qFHnevJg"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782318259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCSclJsOHXGUR9PPnNQt/KSxQU5CDN7d+xhXrFSXdFQ=;
	b=qFHnevJgDyc87ZrZY47VjxEqXA89BZaLQJxeubOA8i6wlCnoxO1zxlqexltOhiSP1mJ1B7
	otStABHF1E7ajWjm02PBOzJDLYTFmB365svZ3sgHi6JJ9ZFyOhdWfqGltg8SQnpX4PCV4w
	VoKCdKXbZAf/1znIe0ErC4bci6VBduY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 16:24:16 +0000
Message-Id: <DJHF3BKSTZ8M.15Q62P3TSDLVH@linux.dev>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner"
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
 Rostedt" <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>,
 "Gregory Price" <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Matthew Wilcox" <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2 03/13] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Suren Baghdasaryan" <surenb@google.com>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-3-31f31367d420@google.com>
 <CAJuCfpE28TqZy2k5-X1ZEdd0HhTuc5i7+0kyxX5nXH4j+5JVfw@mail.gmail.com>
In-Reply-To: <CAJuCfpE28TqZy2k5-X1ZEdd0HhTuc5i7+0kyxX5nXH4j+5JVfw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Jun 24, 2026 at 4:00 PM UTC, Suren Baghdasaryan wrote:
> On Mon, Jun 22, 2026 at 3:02=E2=80=AFAM Brendan Jackman <jackmanb@google.=
com> wrote:
>>
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
>>    the new alloc_order_allowed(), alloc_trylock_allowed() and
>>    gfp_trylock.
>>
>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>    previously in the nolock variant:
>>
>>    a. Application of gfp_allowed_mask; this only affects early boot, and
>>       only flags that affect the slowpath get changed here.
>>
>>    b. Application of current_gfp_context() - also only affects the
>>       slowpath
>>
>> 3. The slowpath itself: this is now just explicitly skipped under
>>    !ALLOC_TRYLOCK.
>>
>> Ulterior motive: adding an alloc_flags arg to the allocator's
>> mm-internal entrypoint can later be used to do more allocation
>> customisation without needing to create new GFP flags.
>
> Looks like a nice overall cleanup.
>
>>
>> While adding this flag to a bunch of places, create ALLOC_DEFAULT to
>> avoid a mysterious literal 0 in most places. alloc_frozen_pages_noprof()
>> is defined above the alloc flags so just leave that as a slightly messy
>> exception instead of trying to fully reorder mm/internal.h for that one
>> case.
>
> Moving the whole alloc_frozen_pages() block down seems simple enough
> and would avoid special-casing this.

Yeah... when you put it like that, I don't actually know why I was so
intimidated by the prospect of moving a handful of function
declarations!

Anyway in the v3 I'm creating a new mm/page_alloc.h so this will happen
as a side effect of that.
