Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219C3B14B6
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133672; cv=none; b=pL8JNFv6pDDzBSbYiwccxzvoSZfkfxaFMf17MeDNDFr0vGucSWWutITGlkQlzDQZ5xesmRNuWV53JDkcwvLS7CGhS0a+QHOPS9NMr6G6WFb2HwhxVb7cCLSz84U1EZOWCvg/UPK02FLxPttoigQ1LY/IaIKrw9cBilPiSKWVysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133672; c=relaxed/simple;
	bh=m1ueIM4R+9wsWDxgMC52/3OaWAEnBL0zzjsNRu2m4gg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mxnYgIh4wyVk1MOSTJ01I/whgLTxsAcgda0rShNUtvVMBi8ocGl8ZhegoLlclxIrYf6JTi83FNflSPonKBvbjXQS0kN/J2W3Q6j5GVxHnt6ikla15N+zpu7rxxzWj61xuVf6wvvtHKj5t2ogvyl1y8qVzL7cSbD8Nh+0Gta+4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YwrJHPhw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YwrJHPhw"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782133666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pne37grVKNkhqLJPvEWX88uVjsSxqnASZgflvMtzG3o=;
	b=YwrJHPhwm7j7/p2kfVr1Ct4NfleSK0geBevPHUEoZFwTfevnK6G7mFIlOa0vIrqYW7YpIU
	0nwzaDABIIp8paEZq693mcUdFiyEduT5I08YvEcB4YJZ0U29w5vBrk60Dx+dMVJ4PslyDI
	hv1m3iQT+G2IDM3qr8LYIEXyeY66s5s=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 13:07:42 +0000
Message-Id: <DJFLNQEBX3PK.1ONMJBA46AQNL@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2 12/13] mm: Move __alloc_pages() to mm/internal.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Brendan Jackman"
 <jackmanb@google.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "Lorenzo
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
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-12-31f31367d420@google.com>
 <41e92bab-6882-401a-8de9-154adbdcfb36@kernel.org>
In-Reply-To: <41e92bab-6882-401a-8de9-154adbdcfb36@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 22, 2026 at 12:24 PM UTC, David Hildenbrand (Arm) wrote:
> On 6/22/26 12:01, Brendan Jackman wrote:
>> It's no longer used outside of mm/.
>>=20
>> Since this means __alloc_pages_noprof() is no longer visible from gfp.h,
>> this also means moving the definition of alloc_pages_node_noprof into
>> the .c file.
>>=20
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>  Documentation/admin-guide/cgroup-v1/cpusets.rst |  2 +-
>>  Documentation/admin-guide/mm/transhuge.rst      |  2 +-
>>  include/linux/gfp.h                             | 16 +---------------
>>  mm/internal.h                                   |  4 ++++
>>  mm/page_alloc.c                                 | 11 +++++++++++
>>  5 files changed, 18 insertions(+), 17 deletions(-)
>
> Do we want some mm/page_alloc.h , to start splitting up mm/internal.h

Don't see why not, if people are on board I'm happy to do that for v3.

(I just realised I put __alloc_pages_noprof() at the bottom of the file,
while it should be next to __alloc_frozen_pages etc, should fix that in
case we don't end up going for the separated header).

So what would go in the new header...

- All the buddy alloc/free entry points
- ALLOC_ flags
- alloc_context
- buddy_order*(), page_is_buddy(), find_buddy_page_pfn() and
  __find_buddy_pfn()
- post_alloc_hook(), free_pages_prepare()
- zone_pcp_*()
- find_suitable_fallback()
- free_area_empty()

Anything else? Or anything on that list that should stay in
mm/internal.h?
