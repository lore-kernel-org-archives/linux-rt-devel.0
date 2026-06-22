Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C138E8C3
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117208; cv=none; b=fEJzjSCSrZYwll1fTmSxX+Nhz4WoBd4Cv6LtorC5WABfLt7xdPc7GFkldn1oMQYcHujBHPTIUFdiFcj4l4vOOdaRiBBP9MeFhKap90a5cFiOUkbV44YcKBKhz7Wi9rWGT8n6mJ+B1BfmoWOK0Coa0zMvBrVsj8cJsiLOlVwU2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117208; c=relaxed/simple;
	bh=rJ9EqyZX+1uDH1xu352c0spmEyEZT9KSZXW7ls/HB/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IdMwHfY63FfV49Bh5Kra4WrHfdnMHH80MzjZGSnNv6AqzgZYCZSY03KPZSPapUEGmUtMfi3yMS9luhClSslr0g/76taZhFZhlC7TN7cq2zp9ZY5Z+XnYhJA92/y2yM7KusqwMhshtCx0YDh0ulDY479KBu+8X7Jxn/MldTJv1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FHQAc44n; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FHQAc44n"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782117204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqsCQKkmRUVfBZPd9K730PqbM5N64wyAbDnC+li40Cw=;
	b=FHQAc44nNfvpZIk6Uesy9k4k9buuih+lxEV7l+zy54ZgveUwr+BgFoeslLQE75ak8UVx4M
	y7bVz8N0i/NrJh5F/0cTK/UcW17X8U94lzBuQX+qTpeGiy4CZJNXy5Eh7fIs3JrAJVIOfd
	lJhqrCFABYGLKPmVbs/XB8+wA4Q2SSA=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 08:33:12 +0000
Message-Id: <DJFFTJZGYZ91.6Y7J8M13KU5@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Hao Ge" <hao.ge@linux.dev>, "Suren Baghdasaryan" <surenb@google.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Brendan Jackman"
 <jackmanb@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Michal
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
 Rostedt" <rostedt@goodmis.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org>
 <CAJuCfpG48TmvaiaRvnL-NXKU6nn55D3bks2DgzAc0URsZhAxqA@mail.gmail.com>
 <DJBHRVM65A11.1OL2M9MXN56H@linux.dev>
 <45fcc57a-ec8d-46d6-9c28-065d001c081f@linux.dev>
 <DJD0AGHTWYRN.1YWG5MDH87WVO@linux.dev>
 <CAJuCfpGtymV=Tmsvs8Z-oF6pi7mD54mRiZNZtpF3UpYwBL7Uig@mail.gmail.com>
 <267e070f-adc2-4f42-b528-746f852d9ef4@linux.dev>
In-Reply-To: <267e070f-adc2-4f42-b528-746f852d9ef4@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 22, 2026 at 1:58 AM UTC, Hao Ge wrote:
>
> On 2026/6/20 02:08, Suren Baghdasaryan wrote:
>> On Fri, Jun 19, 2026 at 4:57=E2=80=AFAM Brendan Jackman
>> <brendan.jackman@linux.dev> wrote:
>>> On Thu Jun 18, 2026 at 2:22 AM UTC, Hao Ge wrote:
>>>> On 2026/6/18 01:14, Brendan Jackman wrote:
>>>>> On Wed Jun 17, 2026 at 4:49 PM UTC, Suren Baghdasaryan wrote:
>>>>>> On Wed, Jun 17, 2026 at 9:39=E2=80=AFAM Vlastimil Babka (SUSE)
>>>>>> <vbabka@kernel.org> wrote:
>>>>>>> +Cc Alexei
>>>>>>>
>>>>>>> On 6/17/26 17:29, Brendan Jackman wrote:
>>>>>>>> Currently the core allocator code is controlled by ALLOC_NOLOCK, b=
ut the
>>>>>>> It's not, it's ALLOC_TRYLOCK! Thanks for proving that we need to re=
name it
>>>>>>> to ALLOC_NOLOCK:
>>>>>>>
>>>>>>> https://lore.kernel.org/all/DJ9QPTO2WXNB.10E88ZHWRDHB0@gmail.com/
>>>>>>>
>>>>>>> So you just won the job to do the rename :) I think it should be do=
ne before
>>>>>>> this patch, so that the new usages and other _trylock names introdu=
ced here
>>>>>>> can be done as _nolock outright.
>>>>> Ack. I'll aim to send that tomorrow once Sashiko has caught up.
>>>>>
>>>>>>>> main entry point function is significantly different from the norm=
al
>>>>>>>> __alloc_frozen_pages_nolock(), this is tiring when reading the cod=
e.
>>>>>>>>
>>>>>>>> Plumb the ALLOC_NOLOCK control one layer up in the call stack: cre=
ate
>>>>>>>> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is=
 only
>>>>>>>> exposed to mm/) and then turn the nolock variant into a thin wrapp=
er
>>>>>>>> that just sets that flag (as well as handling NUMA_NO_NODE, simila=
r to
>>>>>>>> how some of the wrappers in gfp.h do).
>>>>>>>>
>>>>>>>> Rationale that this doesn't change anything:
>>>>>>>>
>>>>>>>> 1. Simple bits: A bunch of the nolock-specific handling is just mo=
ved to
>>>>>>>>      the new alloc_order_allowed(), alloc_trylock_allowed() and
>>>>>>>>      gfp_trylock.
>>>>>>>>
>>>>>>>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>>>>>>>>      previously in the nolock variant:
>>>>>>>>
>>>>>>>>      a. Application of gfp_allowed_mask; this only affects early b=
oot, and
>>>>>>>>         only flags that affect the slowpath get changed here.
>>>>>>>>
>>>>>>>>      b. Application of current_gfp_context() - also only affects t=
he
>>>>>>>>         slowpath
>>>>>>>>
>>>>>>>> 3. The slowpath itself: this is now just explicitly skipped under
>>>>>>>>      !ALLOC_TRYLOCK.
>>>>>>> I'll have to ponder it more closely.
>>>>>>>
>>>>>>>> Ulterior motive: adding an alloc_flags arg to the allocator's
>>>>>>>> mm-internal entrypoint can later be used to do more allocation
>>>>>>>> customisation without needing to create new GFP flags.
>>>>>>> Ack.
>>>>>> I think this change might also help us in removing __GFP_NO_CODETAG
>>>>> Nice, this actually looks trivial? I can probably just tack it onto t=
he
>>>>> v2 for this patch/series.
>>>>>
>>>>>> introduced in [1] and being the only user of __GFP_NO_OBJ_EXT once
>>>>>> Vlastimil's patchset removing other __GFP_NO_OBJ_EXT users lands.
>>>>>> CC'ing Hao as he is brainstorming ways to remove __GFP_NO_CODETAG, a=
nd
>>>>>> this might be the answer.
>>>>
>>>> Hi Brendan, Suren,
>>>>
>>>> Thanks for CC'ing me, Suren. This is indeed a viable approach
>>>>
>>>> and I believe it brings us one step closer to removing
>>>>
>>>> __GFP_NO_CODETAG entirely.
>>>>
>>>>
>>>> Brendan, I'd actually put together a rough local implementation
>>>>
>>>> earlier with mostly the same core idea as yours, and this change
>>>>
>>>> would indeed be minimal based on your patch.
>>>>
>>>> Thanks a lot for being interested in tacking this into your v2 patch s=
eries.
>>> Oh, I just took a look and it's a bit more fiddly than I thought becaus=
e
>>> alloc_tag.c is actually in lib/ not mm/.
>
> Hi Suren and Bredan
>
>
>> One option is to move alloc_tag.c into mm/ (while keeping more generic
>> codetag.c in lib/). From a quick look, that seems doable and probably
>> the easiest approach.
>>
>>> How did you tackle that, can you share your implementation? It would be
>>> nice if we can avoid exposing alloc_flags in gfp.h.
>
> First, I introduced the ALLOC_NO_CODETAG flag as shown below:
>
> @@ -1478,6 +1480,7 @@ unsigned int reclaim_clean_pages_from_list(struct=
=20
> zone *zone,
>  =C2=A0#define ALLOC_HIGHATOMIC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x200=
 /* Allows access to=20
> MIGRATE_HIGHATOMIC */
>  =C2=A0#define ALLOC_TRYLOCK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x400 /* Only use spin_trylock in=20
> allocation path */
>  =C2=A0#define ALLOC_KSWAPD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x800 /* allow waking of kswapd,=20
> __GFP_KSWAPD_RECLAIM set */
> +#define ALLOC_NO_CODETAG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1000 /* s=
kip codetag tracking for this=20
> allocation */
>
>
> Then, mirroring __alloc_pages_noprof, we wrapped a helper function named=
=20
> alloc_pages_noprof_notag.
>
>
> @@ -5252,13 +5335,25 @@ struct page *__alloc_pages_noprof(gfp_t gfp,=20
> unsigned int order,
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page;
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D __alloc_frozen_pages_nopro=
f(gfp, order, preferred_nid,=20
> nodemask);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D __alloc_frozen_pages_nopro=
f(gfp, order, preferred_nid,=20
> nodemask, 0);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (page)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 set_page_refcounted(page);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return page;
>  =C2=A0}
>  =C2=A0EXPORT_SYMBOL(__alloc_pages_noprof);
>
> +struct page *alloc_pages_noprof_notag(gfp_t gfp, unsigned int order)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D __alloc_frozen_pages_nopro=
f(gfp, order, numa_node_id(), NULL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ALLOC_NO_CODETAG);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (page)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 set_page_refcounted(page);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return page;
> +}
> +EXPORT_SYMBOL_GPL(alloc_pages_noprof_notag);
>
>
> Lastly, we exported this function in gfp.h as shown below:
>
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 51ef13ed756e..ac6e837ac8c0 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -234,6 +234,9 @@ struct folio *__folio_alloc_noprof(gfp_t gfp,=20
> unsigned int order, int preferred_
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nodemask_t *nodemask);
>  =C2=A0#define __folio_alloc(...) alloc_hooks(__folio_alloc_noprof(__VA_A=
RGS__))
>
> +struct page *alloc_pages_noprof_notag(gfp_t gfp, unsigned int order);
> +#define alloc_pages_notag(...)=20
> alloc_hooks(alloc_pages_noprof_notag(__VA_ARGS__))
>
>
> Hope this information helps you.

Cool, thanks! On Friday I also tried doing it by just moving the .c
file and that also seems to be pretty practical.=20
