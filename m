Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B11CAA78
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380423; cv=none; b=gd/r23F6WVStyp4iLg0bMvQsFfRKRMqi7gzvfENij0WaZEOUuUIHr14lhJgA/yFTon1dEA8JrKev/gjqWZv+dYu+uQy4J5Di/FFGpPhwUzB1Au+p5i1+Hyhhqg+f56mEhKshSrYYaAA6RtxLbcy+ngj4g/PdwAQYqeAU3Pv4nm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380423; c=relaxed/simple;
	bh=6SXLGQsV/q7/TS5s4cy4vhPQdlMVsc7MPTAMPp+vVGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YgTOQlNjGMLhfzLbzROLm9NJ3Vho29vA9Pnc41OJEXX5YZtC6yrdeNHpNQdvppMGFWq6/XsUcR9GqkbCdktDT/SDdNxBiQ+JYpvCfUIYos/nwFRgkqUh2NbR2Ph+s4Kd8FTYyFMJZMO4b8WoceSADU3uT6//1y8gsLBQIjhioY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXReBvDY; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXReBvDY"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782380418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FY1PyiORB/zCxts/fRveZ6vdxg1hQ/t5DTuDGlkXWW8=;
	b=vXReBvDYDhFntJr5ITL+FUB98gaGuUalk/XfSWhDmbPb1FGX0/ndA7EjtCGefA2lO66tCb
	bz0VTaIZBMWYcZzWgNMGcmKXiwxMhoqiIGjEYkU5X4UhhJMhp2JKabICirFtek+SRqmBra
	PAx3UFYK65LKv1LQrtCEPFIA5Ql0pQk=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 09:40:14 +0000
Message-Id: <DJI14IET2O9O.XJHLXBK60WES@linux.dev>
To: "Suren Baghdasaryan" <surenb@google.com>, "Hao Ge" <hao.ge@linux.dev>
Cc: "Brendan Jackman" <jackmanb@google.com>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory
 Price" <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>, "Michal
 Hocko" <mhocko@suse.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Alistair Popple" <apopple@nvidia.com>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 13/13] mm: remove __GFP_NO_CODETAG
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-13-31f31367d420@google.com>
 <6e312b15-d2b5-4137-aa3f-720ec214c7ab@linux.dev>
 <CAJuCfpF9-CS-gt1S=tRNaK10yNnnod9DLEe-Y5L3ad5u60Gagg@mail.gmail.com>
In-Reply-To: <CAJuCfpF9-CS-gt1S=tRNaK10yNnnod9DLEe-Y5L3ad5u60Gagg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Jun 24, 2026 at 4:47 PM UTC, Suren Baghdasaryan wrote:
> On Tue, Jun 23, 2026 at 12:57=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> Hi Brendan
>>
>>
>> On 2026/6/22 18:01, Brendan Jackman wrote:
>> > Now that alloc_pages has an entrypoint that allows passing alloc_flags=
,
>> > we can take advantage of this to start removing GFP flags that are onl=
y
>> > used for mm-internal stuff.
>> >
>> > This requires also plumbing the alloc_flags into some more of the
>> > allocator code, in particular __alloc_pages[_noprof]() gets an
>> > alloc_flags arg to go along with its callees, and we now need to pass
>> > those flags deeper into the allocator so they can reach the alloc_tag
>> > code.
>> >
>> > To try and keep the new ALLOC_NO_CODETAG's scope nice and narrow, don'=
t
>> > define it in mm/internal.h, instead just define a "reserved bit" and
>> > then use that in places that don't care about what it means.
>
> I don't understand why you want to narrow down visibility of one of
> the alloc_flag bits. We don't do that for any other flags, and this
> seems like an unnecessary complexity.

OK can drop this and just expose it directly.

This was just coz __GFP_NO_CODETAG was local to the .c file and it felt
like a "regression" to "leak" it into the header. But yeah on the other
hand this "reserved bit" thing is unncessary indirection.

>> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>
>>
>> Nit: The title says "remove __GFP_NO_CODETAG" but the flag isn't really
>> removed =E2=80=94 it's migrated from gfp_t to alloc_flags as
>>
>> ALLOC_NO_CODETAG. Something like "mm: replace __GFP_NO_CODETAG with an
>> alloc_flag" would be more accurate.
>>
>>
>> Additionally, as Lorenzo pointed out in another thread, you will likely
>> need to rebase this series later.
>>
>> I noticed Vlastimil has already landed the slab changes removing
>> __GFP_NO_OBJ_EXT into mainline:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/=
?id=3D335c347686e76df9d2c7d7f61b5ea627a4c5cb4c
>>
>> For v3, it might make sense to fold in Vlastimil's patch so the full
>> removal of __GFP_NO_OBJ_EXT can be completed end-to-end
>>
>> https://lore.kernel.org/all/20260609-slab_alloc_flags-v1-15-2bf4a4b9b526=
@kernel.org/
>
> I think Vlastimil's patch will be merged before this one, so this
> patch could remove __GFP_NO_OBJ_EXT complely, saying that its last
> user (__GFP_NO_CODETAG) is gone.

Yup, Vlastimil's other patches went directly to Linus so the final
__GFP_NO_OBJ_EXT removal is already  in my local branch for the v3 :)
