Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9ED2D3ED1
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Jun 2026 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207100; cv=none; b=YoJgIkKzPgqO675p5ULaLnc8t/OmgtnvPvmvfreU6y9sh4TE1b6iC+GlIJ3KWeCzcnK6bcrtCSyV7ReDdZAXMxNs8/eEcJ89xE5743whlx8ChgIGHFlgiWR3+3/j/RTk/8f0DRPu0hIPD4pz0WSuxnrrjvJ8fUZsuZdTivHVnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207100; c=relaxed/simple;
	bh=WlYKkmH2+/Rx3UAOeXIoxhHEVrRwDnGqfKhquFOHazM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZLFbEkJqpvI0Di13zHlDPYMoZOT0PyOJzXLLLJYU+OcWTr2zDjRswT/KcIP08m2Fk+SOJS6C/9DFWhiaB8k5EkxJawqW6DEasqRcS/s/B31xQQj0X4t9A1ETomIrtGkYtS/Ht96ZQQQh9Ub97AJhWJkgAZANyx1YD2O2SCUvyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T6lIdTHi; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T6lIdTHi"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782207096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlYKkmH2+/Rx3UAOeXIoxhHEVrRwDnGqfKhquFOHazM=;
	b=T6lIdTHi0Rw450pvnrbxiKrURLhGKrhbo2SKEUGzxFi6FggL0IOWqc7iH6b1dGba6B5SJA
	h1lU6z/OiyYWXXR41iC4yOa1e88mpxvbAL57BHsUNY2aoji2cwUzP9N0oB5UwF+fcyZk7R
	c2p1zDGq3NtqlJLuyHGvSNAfZCQczeM=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 09:31:30 +0000
Message-Id: <DJGBOQRQD5N4.1AH0U7LYOAEQK@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
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
 Rostedt" <rostedt@goodmis.org>, "Suren Baghdasaryan" <surenb@google.com>
Subject: Re: [PATCH v2 13/13] mm: remove __GFP_NO_CODETAG
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Hao Ge" <hao.ge@linux.dev>, "Brendan Jackman" <jackmanb@google.com>,
 "Vlastimil Babka" <vbabka@kernel.org>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-13-31f31367d420@google.com>
 <6e312b15-d2b5-4137-aa3f-720ec214c7ab@linux.dev>
In-Reply-To: <6e312b15-d2b5-4137-aa3f-720ec214c7ab@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue Jun 23, 2026 at 7:56 AM UTC, Hao Ge wrote:
> Hi Brendan
>
>
> On 2026/6/22 18:01, Brendan Jackman wrote:
>> Now that alloc_pages has an entrypoint that allows passing alloc_flags,
>> we can take advantage of this to start removing GFP flags that are only
>> used for mm-internal stuff.
>>
>> This requires also plumbing the alloc_flags into some more of the
>> allocator code, in particular __alloc_pages[_noprof]() gets an
>> alloc_flags arg to go along with its callees, and we now need to pass
>> those flags deeper into the allocator so they can reach the alloc_tag
>> code.
>>
>> To try and keep the new ALLOC_NO_CODETAG's scope nice and narrow, don't
>> define it in mm/internal.h, instead just define a "reserved bit" and
>> then use that in places that don't care about what it means.
>>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
>
> Nit: The title says "remove __GFP_NO_CODETAG" but the flag isn't really=
=20
> removed =E2=80=94 it's migrated from gfp_t to alloc_flags as
>
> ALLOC_NO_CODETAG. Something like "mm: replace __GFP_NO_CODETAG with an=20
> alloc_flag" would be more accurate.

Good point, will reword this.

> Additionally, as Lorenzo pointed out in another thread, you will likely=
=20
> need to rebase this series later.
>
> I noticed Vlastimil has already landed the slab changes removing=20
> __GFP_NO_OBJ_EXT into mainline:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
id=3D335c347686e76df9d2c7d7f61b5ea627a4c5cb4c
>
> For v3, it might make sense to fold in Vlastimil's patch so the full=20
> removal of __GFP_NO_OBJ_EXT can be completed end-to-end
>
> https://lore.kernel.org/all/20260609-slab_alloc_flags-v1-15-2bf4a4b9b526@=
kernel.org/

Ack, thanks for the links and review!
