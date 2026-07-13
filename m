Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080C2D24B7
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956440; cv=none; b=mlxHe+FdHhmT/vuo56VByusutIXJ29ZAttNva4P14hOUKKDPf9qILlj5xLpORkle8VZ8BiSVlJ0ykS+pn8gVbVRRjOKHzaRuFAuD07TgtSB+eNfsIYQkWn1Gz9/G113v1ccr+BCjTUDxlpetF3HSA/JZ4FNBIdrqiAmBGovgtn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956440; c=relaxed/simple;
	bh=9Sj1q0LnnW72NwNLNAI7AIzu/UlFVstB0YoHjdvHdks=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Sgsldk/gLhmtWFvQtPRH3gZ3malCD7aa+kl4U8LlqhJF20jNfowfKSOMUYzovCCTywb9Bx3Y4TUpsxGhjArSWb6txLgut21QPjHMFYq+w16AojeykBQ0bCsiHtmwBz4WSNs7DHOg5oGBjuzNkL6NnGjrbDkyZhYEPWzvIGJuUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=alh2lfRH; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="alh2lfRH"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783956435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGM+htLZdutLBDNc5mxxfxxEn2ZysJrfQe8Dn9wLtck=;
	b=alh2lfRHVG8G8NevS66Gh7NDLWFYdbGR4+mqA2vynLl4THE6uFGrwsXygsFfBygmV6YUXa
	WUoAq/SHdFGJORCQFJtr6nL06Pee0SemWQfYZSu5viQC6QK9WygW+I48pL+STkIv8o2X2U
	v/8WZw4g2hHSZMLlGjkFe0nEJNtqdw4=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 15:26:48 +0000
Message-Id: <DJXJRNZFBPQ2.2S6CM4YAKHVQ5@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>
Subject: Re: [PATCH v5 13/18] mm: Remove __alloc_pages_node()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Zi Yan" <ziy@nvidia.com>, "Brendan Jackman" <jackmanb@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
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
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-13-c87b714e19d3@google.com>
 <DJP0VKJLE8TE.6EDLC2BFI1SG@nvidia.com>
In-Reply-To: <DJP0VKJLE8TE.6EDLC2BFI1SG@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Fri Jul 3, 2026 at 2:57 PM UTC, Zi Yan wrote:
> On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
>> There were only a few users, which have been removed. The only advantage
>> of this API over alloc_pages_node() is avoiding a single conditional
>> branch. The disadvantages are:
>>
>> 1. More API surface, more sources of confusion, more maintenance.
>>
>> 2. Worse impact of CPU hotplug bugs: most users of __alloc_pages_node()
>>    were using the result of cpu_to_node(); if the CPU gets hotplugged
>>    out this will return NUMA_NO_NODE. If one of these paths fails to
>>    protect against a concurrent hotplug then page_alloc.c will use
>>    NUMA_NO_NODE as an index into NODE_DATA() and cause some horrible
>>    memory corruption or other. With alloc_pages_node(), the code might
>>    just work fine.
>>
>> Ulterior motive: this frees up the __* variants of the allocator APIs to
>> serve specifically for use as mm-internal API.
>>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>  include/linux/gfp.h | 20 ++++----------------
>>  1 file changed, 4 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 01d6d2591f49e..3bf55a5f9143e 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -256,21 +256,6 @@ static inline void warn_if_node_offline(int this_no=
de, gfp_t gfp_mask)
>>  	dump_stack();
>>  }
>> =20
>> -/*
>> - * Allocate pages, preferring the node given as nid. The node must be v=
alid and
>> - * online. For more general interface, see alloc_pages_node().
>> - */
>> -static inline struct page *
>> -__alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
>> -{
>> -	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
>> -	warn_if_node_offline(nid, gfp_mask);
>> -
>> -	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>> -}
>> -
>> -#define  __alloc_pages_node(...)		alloc_hooks(__alloc_pages_node_noprof=
(__VA_ARGS__))
>> -
>>  static inline
>>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, =
int nid)
>>  {
>> @@ -293,7 +278,10 @@ static inline struct page *alloc_pages_node_noprof(=
int nid, gfp_t gfp_mask,
>>  	if (nid =3D=3D NUMA_NO_NODE)
>>  		nid =3D numa_mem_id();
>> =20
>> -	return __alloc_pages_node_noprof(nid, gfp_mask, order);
>> +	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
>
> Could this become a VM_WARN_ON?

Er, it will almost certainly crash later if this is violated. Personally
if I'm enabling DEBUG_VM I'd rather it crashes with a helpful stacktrace
instead of chasing random poihnters, likely corrupting memory, and then
crashing later in a completely undebuggable way instead.

TBH I don't really understand the "don't BUG" culture we have in Linux.
I usually just go along with it coz it doesn't seem important enough to
argue about. But now I'm wondering: if we really don't like VM_BUG_ON()
why not get rid of it completely? I wonder if there's some case-by-case
difference that I'm not picking up on.
