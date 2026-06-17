Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006254611C4
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716482; cv=none; b=cAm9TSI+er+UZu7nm9ZYpTvn6gwHmOL1n7W8enqqR3RzXf8L/ZQEPz1aUsKEuP88lvfM57lrJPHdjeG5f954aiL7gLO4paNXix0cv4ZxbhL6TtAQd5CvoKE2zs3kYgBm6omlDl/H6i6uKCD4fNyZHnQkdqCS8ZckW4WFxaaGf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716482; c=relaxed/simple;
	bh=kFemRanvc6E5S6TRcsxsOq/DYjRukGgE0QCE4X4i0ms=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nahjWu7W8n9ATLNdnikrtNxveRGiLbTocsixdbbWXV9SOJt4M90oDIV53urlD5k7i2muOi5ocr3YACgpRboV95MkR/C/zUf7lnUHa8YAmKwk6Uq35oFOYQkj9qZkCiobydQJp2olFMTKbOVNYBckjFSnYysdzQi1F3nZMLfAeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URPUI+Kx; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URPUI+Kx"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781716477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5SZXXiFJ8ueBXhlsGQFJZi5a2AW4j8ADP8QWnx4K3E=;
	b=URPUI+KxX5k2L3dXRV6rad5ag+FPQQaxDxIUK7ydK6ENuc2D6h+cIasadvkr9vZSYWnBoB
	gzeq9d5VdvLRYjMeOEE4YFmBzQPOgS1Wb2XFmG/AhqYDEwxEpT43tx40GKKgRY54XN7e+t
	WtLX3QXOtLqSfo09anHRSIUsBplrdXs=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 17:14:23 +0000
Message-Id: <DJBHRVM65A11.1OL2M9MXN56H@linux.dev>
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
 <linux-rt-devel@lists.linux.dev>, "Hao Ge" <hao.ge@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org>
 <CAJuCfpG48TmvaiaRvnL-NXKU6nn55D3bks2DgzAc0URsZhAxqA@mail.gmail.com>
In-Reply-To: <CAJuCfpG48TmvaiaRvnL-NXKU6nn55D3bks2DgzAc0URsZhAxqA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Jun 17, 2026 at 4:49 PM UTC, Suren Baghdasaryan wrote:
> On Wed, Jun 17, 2026 at 9:39=E2=80=AFAM Vlastimil Babka (SUSE)
> <vbabka@kernel.org> wrote:
>>
>> +Cc Alexei
>>
>> On 6/17/26 17:29, Brendan Jackman wrote:
>> > Currently the core allocator code is controlled by ALLOC_NOLOCK, but t=
he
>>
>> It's not, it's ALLOC_TRYLOCK! Thanks for proving that we need to rename =
it
>> to ALLOC_NOLOCK:
>>
>> https://lore.kernel.org/all/DJ9QPTO2WXNB.10E88ZHWRDHB0@gmail.com/
>>
>> So you just won the job to do the rename :) I think it should be done be=
fore
>> this patch, so that the new usages and other _trylock names introduced h=
ere
>> can be done as _nolock outright.

Ack. I'll aim to send that tomorrow once Sashiko has caught up.

>> > main entry point function is significantly different from the normal
>> > __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>> >
>> > Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
>> > an alloc_flags argument to __alloc_frozen_pages_nolock() (which is onl=
y
>> > exposed to mm/) and then turn the nolock variant into a thin wrapper
>> > that just sets that flag (as well as handling NUMA_NO_NODE, similar to
>> > how some of the wrappers in gfp.h do).
>> >
>> > Rationale that this doesn't change anything:
>> >
>> > 1. Simple bits: A bunch of the nolock-specific handling is just moved =
to
>> >    the new alloc_order_allowed(), alloc_trylock_allowed() and
>> >    gfp_trylock.
>> >
>> > 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>> >    previously in the nolock variant:
>> >
>> >    a. Application of gfp_allowed_mask; this only affects early boot, a=
nd
>> >       only flags that affect the slowpath get changed here.
>> >
>> >    b. Application of current_gfp_context() - also only affects the
>> >       slowpath
>> >
>> > 3. The slowpath itself: this is now just explicitly skipped under
>> >    !ALLOC_TRYLOCK.
>>
>> I'll have to ponder it more closely.
>>
>> > Ulterior motive: adding an alloc_flags arg to the allocator's
>> > mm-internal entrypoint can later be used to do more allocation
>> > customisation without needing to create new GFP flags.
>>
>> Ack.
>
> I think this change might also help us in removing __GFP_NO_CODETAG

Nice, this actually looks trivial? I can probably just tack it onto the
v2 for this patch/series.

> introduced in [1] and being the only user of __GFP_NO_OBJ_EXT once
> Vlastimil's patchset removing other __GFP_NO_OBJ_EXT users lands.
> CC'ing Hao as he is brainstorming ways to remove __GFP_NO_CODETAG, and
> this might be the answer.
>>
>> Besides the need to ponder unintended effects, mostly LGTM. Just not a f=
an
>> of the hardcoded '0' passed at various places. In the slab variant of th=
is
>> (the thread I've linked above) I went with SLAB_ALLOC_DEFAULT, so you ca=
n do
>> e.g. ALLOC_DEFAULT here?

Yup ALLOC_DEFAULT sounds fine to me.

Thanks for the reviews as always.
