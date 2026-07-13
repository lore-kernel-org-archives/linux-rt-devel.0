Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2330CD85;
	Mon, 13 Jul 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960256; cv=none; b=bfXCfihOuW6y+0eGdz6CH9rZ3QeX4+qps/amgrGkq/RC4KDEPKxUxLJSRPaz3quVKjD4PBij2iVS98k85yR1H2WV18aolkmTtitHSw790XIZv6VpN3SHJXFh5AazYtPYOnYnKeC/eG1BBvl4WMa6lZh5logFl+8pWYVQVq65IfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960256; c=relaxed/simple;
	bh=UGVzdMyQyCjZvCqHUbg+b+NDUt/DV8hq+f+nqplxtwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fb3NrkoGdHbpSsko/Icl5uRiY5EcZ3BfQvXW2wROJZuYebAclpXe9pzgngaPpMEAf6nQAI/quubZmaMBlJm93Z1/OJbOyIEl+QXHTxrPYf365SSv5241HjIjeey7kflqYtOEoghTuWQ8GR/hOvx1p3MeFlqni/o+Z0mhoLiwHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9AjbsfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9AjbsfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E541F000E9;
	Mon, 13 Jul 2026 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960254;
	bh=PMyE14iizY5E2lFXOalrRCdzTIzlOnvgtBrcDbYeja0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N9AjbsfHTJXoFHnSBGJkPeYeWmKCNZDfuT0DOOPJetqIJEOAhDeeJGyh1edKit18Q
	 W+B3YaBZZqjo/WPcS02OFCCvb4nzgLBg+WcbRjgaUY8ARbI4WSjUWqzTTTdrOKvhl2
	 yrGVc2FWkptlj+uMGaHZqGsjJUeth/zHoY7bjpczYrkIvkEVNZ8Hj+LhZbsNjC8+Rt
	 DoSQ1nD6MwAM41sYWMG2sk64cIOx4A9tOkrRmdckunZdZRZBIcppKnsIJZg5FblI7z
	 FIhv7+3d/fxT6MniDEd3zWnVSx6kEHLQuPwaxGpeeUnx/yMw5UnC8GyI9OJ3zqOjAz
	 SJHjD+q1JOjOg==
Message-ID: <324a1790-ab9f-41fd-8671-dcb2875b9bde@kernel.org>
Date: Mon, 13 Jul 2026 18:30:46 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/18] mm: Remove __alloc_pages_node()
Content-Language: en-US
To: Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price
 <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com,
 Yosry Ahmed <yosry@kernel.org>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-13-c87b714e19d3@google.com>
 <DJP0VKJLE8TE.6EDLC2BFI1SG@nvidia.com> <DJXJRNZFBPQ2.2S6CM4YAKHVQ5@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DJXJRNZFBPQ2.2S6CM4YAKHVQ5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 17:26, Brendan Jackman wrote:
> On Fri Jul 3, 2026 at 2:57 PM UTC, Zi Yan wrote:
>> On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
>>> There were only a few users, which have been removed. The only advantage
>>> of this API over alloc_pages_node() is avoiding a single conditional
>>> branch. The disadvantages are:
>>>
>>> 1. More API surface, more sources of confusion, more maintenance.
>>>
>>> 2. Worse impact of CPU hotplug bugs: most users of __alloc_pages_node()
>>>    were using the result of cpu_to_node(); if the CPU gets hotplugged
>>>    out this will return NUMA_NO_NODE. If one of these paths fails to
>>>    protect against a concurrent hotplug then page_alloc.c will use
>>>    NUMA_NO_NODE as an index into NODE_DATA() and cause some horrible
>>>    memory corruption or other. With alloc_pages_node(), the code might
>>>    just work fine.
>>>
>>> Ulterior motive: this frees up the __* variants of the allocator APIs to
>>> serve specifically for use as mm-internal API.
>>>
>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>> ---
>>>  include/linux/gfp.h | 20 ++++----------------
>>>  1 file changed, 4 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>>> index 01d6d2591f49e..3bf55a5f9143e 100644
>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -256,21 +256,6 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
>>>  	dump_stack();
>>>  }
>>>  
>>> -/*
>>> - * Allocate pages, preferring the node given as nid. The node must be valid and
>>> - * online. For more general interface, see alloc_pages_node().
>>> - */
>>> -static inline struct page *
>>> -__alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
>>> -{
>>> -	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>>> -	warn_if_node_offline(nid, gfp_mask);
>>> -
>>> -	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>>> -}
>>> -
>>> -#define  __alloc_pages_node(...)		alloc_hooks(__alloc_pages_node_noprof(__VA_ARGS__))
>>> -
>>>  static inline
>>>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
>>>  {
>>> @@ -293,7 +278,10 @@ static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
>>>  	if (nid == NUMA_NO_NODE)
>>>  		nid = numa_mem_id();
>>>  
>>> -	return __alloc_pages_node_noprof(nid, gfp_mask, order);
>>> +	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>>
>> Could this become a VM_WARN_ON?
> 
> Er, it will almost certainly crash later if this is violated. Personally

Agreed.

> if I'm enabling DEBUG_VM I'd rather it crashes with a helpful stacktrace
> instead of chasing random poihnters, likely corrupting memory, and then
> crashing later in a completely undebuggable way instead.
> 
> TBH I don't really understand the "don't BUG" culture we have in Linux.

It comes from Linus. The main motivation AFAIU are cases that would be
recoverable otherwise. This is almost certainly not the one, but it's hard
sell anyway.
I think he would also argue that the "almost certainly crash" you argue
about above should give you enough info for you to debug it :)
It's likely not the case that would silently corrupt something and then you
crash in completely different context.

> I usually just go along with it coz it doesn't seem important enough to
> argue about. But now I'm wondering: if we really don't like VM_BUG_ON()
> why not get rid of it completely? I wonder if there's some case-by-case
> difference that I'm not picking up on.

IIRC we did agree on getting rid of it, but there was no concerted effort
yet. So we're in this "if you touch something, remove it" mode for a while.

Here I think you can just remove it here completely, and not replace it with
a warn. Realistically it was only potentially useful for an unexpected
NUMA_NO_NODE passed to __alloc_pages_node_noprof() and that's gone with your
patch. So keeping that check would be an arbitrary paranoia at this point.
