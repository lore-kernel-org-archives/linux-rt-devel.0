Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D037756C
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924140; cv=none; b=nGt9a8VI4bJtnKgd0cFgYO1faL6cVeEOY30YWK/QP5df2kxA8PkH2mJWPsyP/cbUovsjOQf0Qe3nVfAe1vQ2bhk/8IQUJCbzxd7dAUytpWTJPpsRO/zQzx3WupVduW7WF2Bs3JJz/gfSTu7v5iPQ4BcLTD702L23LJnJrBybzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924140; c=relaxed/simple;
	bh=D6Jp4rawiXmUerxKc/vs/HIx+Nz7ULvB8flOmBQMtfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNitpr+lgcUxgr0NIONFZPNkZYrFfox7K/Ut5FN5bCYf2sxJax4Z4Sn8HTdwJzzCppIcDGh3Gpk+3hUlNpNVK3/1e+gnUtJ3cS1MU8Cj+FSWQJpd72e3G+I95gf8Q1IGyfoshI6AjkO7eQzXW7EBkvv3/Pub32tvd2/XaoEt1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gob2BKBl; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gob2BKBl"
Message-ID: <a953f120-6e81-44ce-a542-ce42c1cff747@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782924136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+2gpszS6w1yPKfdIUMLb1Oz1PqSPFzVoqNJzo8qoik=;
	b=Gob2BKBl4xI1NuEjSX/JqK/ZTWRbrSC78wZVvwDeHm7rMYcEjgQX654mowJYjIDp4/2X7Y
	fFCksd0v4vcM9WNyEkD1WOxXaV37inPDU5Spax8knAo8OFESpem8NpvkG+c05nK1fd2ES+
	DJrmMEPCzsrhiRYGoE8G3U151/Sw1/I=
Date: Wed, 1 Jul 2026 09:41:08 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v3 02/16] mm/page_alloc: some renames to clarify
 alloc_flags scopes
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>,
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
 linux-rt-devel@lists.linux.dev
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-2-57bef0eadbc2@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: JP Kobryn <jp.kobryn@linux.dev>
In-Reply-To: <20260629-alloc-trylock-v3-2-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/29/26 6:11 AM, Brendan Jackman wrote:
> It's pretty confusing that:
> 
> - The slowpath and fastpath have a totally distinct set of alloc_flags.
> 
> - gfp_to_alloc_flags() sounds generic but it only influences the
>   slowpath.
> 
> Rename some variables to highlight which alloc_flags are
> fastpath-specific. Rename gfp_to_alloc_flags() to highlight that it's
> slowpath-specific.
> 
> gfp_to_alloc_flags_cma() and gfp_to_alloc_flags_nonblocking() currently
> have perfectly harmless names, but to keep the naming consistent also
> rename those to the alloc_flags_*() pattern (which already exists for
> alloc_flags_nofragment()).
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 421271849f291..6010693861ec2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3774,8 +3774,8 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>  }
>  
>  /* Must be called after current_gfp_context() which can change gfp_mask */
> -static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
> -						  unsigned int alloc_flags)
> +static inline unsigned int alloc_flags_cma(gfp_t gfp_mask,
> +					   unsigned int alloc_flags)
>  {
>  #ifdef CONFIG_CMA
>  	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> @@ -4474,7 +4474,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
>  }
>  
>  static inline unsigned int
> -gfp_to_alloc_flags_nonblocking(gfp_t gfp_mask, unsigned int order)
> +alloc_flags_nonblocking(gfp_t gfp_mask, unsigned int order)
>  {
>  	unsigned int alloc_flags = 0;
[...]


Acked-by: JP Kobryn <jp.kobryn@linux.dev>
