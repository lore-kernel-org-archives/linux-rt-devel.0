Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8F306775
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317623; cv=none; b=bH/Nz1wIDrFslasjyNIxxs56yS/YXgihlZumbdqSx0OU4mQKf3kJ7HndUGZBHhcnFmCmxqjKrSTS0U3gHidLkKs6Nx3GP+96+VQsfx+X0MiuZx0YsqRtoCUvAGYhk+xKYMewWuGEsNtcCkSL4pgqIp0Xm4Qu7JkTpHR/o8yoUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317623; c=relaxed/simple;
	bh=nSrGe93AJ2Jpp1vw4SR7nx1VtkMTC+Rk3kBGgc7BVC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SePwx+DcS/V9xBNU05mjTv/fnFAVlu7FCoQNxexF3kCmubHSnp/Wv+yW5sW6Ep6m13EdoYYJVwjY4KVZxjG42VA9rxllLPLWkpLMlQJcD3QNRVNGXcI5Wumyp+igmaMX+ZTi0v3ZwV/f9pdSMKpN9vjXwDuaYVwuxvsUOQ+Hw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fa3J2SOh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fa3J2SOh"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782317609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9aVF+G3OXPyZ/vcAkXPeyAs2FuDRWvwGyzee9qXB9c=;
	b=fa3J2SOhvillti8Liv5ZP1niw3sCiypVHde+AiPnhIfoN4KtMBponRsJ4fCdvD4pujO0m2
	ebvOAK1vccQyOHILjsjOpsvJAhyrY7vw5BUfQ9hzM5FDRyqDH4v4Cj0zl+XPIrcg7yjeF5
	jTaznLi8uMLZFrFPe/3m2rvQr5i7Yvs=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 16:13:13 +0000
Message-Id: <DJHEUV09YHKE.1YVJWE38NM8U5@linux.dev>
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
Subject: Re: [PATCH v2 02/13] mm/page_alloc: some renames to clarify
 alloc_flags scopes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Suren Baghdasaryan" <surenb@google.com>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-2-31f31367d420@google.com>
 <CAJuCfpGagFf4RaCNJqu4Y1oqOXXOWSkP1UGuT9LA-9EbDN4Njw@mail.gmail.com>
In-Reply-To: <CAJuCfpGagFf4RaCNJqu4Y1oqOXXOWSkP1UGuT9LA-9EbDN4Njw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Jun 24, 2026 at 3:03 PM UTC, Suren Baghdasaryan wrote:
> On Mon, Jun 22, 2026 at 3:01=E2=80=AFAM Brendan Jackman <jackmanb@google.=
com> wrote:
>>
>> It's pretty confusing that:
>>
>> - The slowpath and fastpath have a totally distinct set of alloc_flags.
>>
>> - gfp_to_alloc_flags() sounds generic but it only influences the
>>   slowpath.
>>
>> - prepare_alloc_pages() is generic in that it sets up the
>>   alloc_context, but the alloc_flags it generates are only used for the
>>   fastpath.
>
> I understand you want to clarify the usage but this particular point
> seems to be an implementation detail. IOW, if tomorrow
> __alloc_frozen_pages_noprof() is changed to use alloc_flags when
> calling __alloc_pages_slowpath(), would we be renaming it back? So, I
> would suggest keeping alloc_flags as is in prepare_alloc_pages()=20

I would say yes, we should rename it even though it might mean having to
rename it back later. IMO it's very useful to make it clear to the
reader that they also need to look elsewhere to find the slowpath flag
logic, without them having to notice this rather odd detail of
__alloc_frozen_pages_noprof().

But, yeah I guess prepare_alloc_pages() doesn't really care that its
caller is only using the result for the fastpath so I could see the
rationale for keeping the arg as alloc_flags...

> and its callers.=20

...  but for it's caller I really do think the rename is necessary and
doesn't really have any downside? Especially once alloc_context gets an
alloc_flags field as it does later in the series.

> The rest LGTM.

Thanks as always, I appreciate the review.
