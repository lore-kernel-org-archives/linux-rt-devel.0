Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487523161A1;
	Fri, 26 Jun 2026 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497117; cv=none; b=oDhlL5Y8N6x89bnovSYT7qS98WLRQz/DqVdpNyZ9ti+140YFBiT0HHx7VmJbvhQMDU66q7iy+KyWC73nOMW30/uZqXepaDtPZCr7Y7J7SnrQLJAI4NisBomzJcalrWK9sBQQHH9H6mn1gERN3vQsmjn9LAJj9Yaj9bxxis7Vszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497117; c=relaxed/simple;
	bh=JCJoFDG0qYd1PLil+ubkJCcSvKpGgC+mRent2Za8zhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGTbvYFbxp2F722u8pmRTkL9qC5qOWrVovObyC7Eo7eFbaxEX8YEdBGowPDbb3Cw+WhrwG93EXEh7daxSiwrj1iidQbCdqGIvTmSOcGLtvW4/ncMDyEPoiBPw7DCbY00vg89y3zPm+t+yziVqbdqftZkjWuza5bI1W+U8K8IzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWQRTWo/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWQRTWo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F171F000E9;
	Fri, 26 Jun 2026 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782497115;
	bh=fGiMyZB/kEhf07t+JFhkktFDb6T15Rf253lpTmaTVd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RWQRTWo/O74n4A8v4P+Qyk3xgKStasPuZl6B7LVJ5wjaiALscfqq3SAfKa+w4+OQA
	 FoXgyKGVvOeF8Z1Vi9qJ5l/MYpAHoPt0ZRQn00vUIcY3HrM82aA4S8UiuPcfaZfZNd
	 t850CYdcz+VqiDQls9RsFY/JrIa5Xqt2g2YKaZwz4UL2o3bUhBZYGli3c6ubwjL6+0
	 SkoSXh+vnsLm+eUoMO9GJE3sE4cwTXdr8M7Yjs3X2cqSyVSp5t9lExOaDSXj3b42HU
	 faUqhcmcq/+zhWKeqTFFQQDtztGavuSbocqtkCrnsmzjBgmWd0ww3MdqT5ikusnD4I
	 /AI9JO7i8hEQA==
Message-ID: <10824fdd-0abf-44ad-9a2f-e62aeb669195@kernel.org>
Date: Fri, 26 Jun 2026 20:05:07 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] mm/page_alloc: some renames to clarify
 alloc_flags scopes
Content-Language: en-US
To: Brendan Jackman <brendan.jackman@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko
 <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
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
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>,
 Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-2-31f31367d420@google.com>
 <CAJuCfpGagFf4RaCNJqu4Y1oqOXXOWSkP1UGuT9LA-9EbDN4Njw@mail.gmail.com>
 <DJHEUV09YHKE.1YVJWE38NM8U5@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DJHEUV09YHKE.1YVJWE38NM8U5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/24/26 18:13, Brendan Jackman wrote:
> On Wed Jun 24, 2026 at 3:03 PM UTC, Suren Baghdasaryan wrote:
>> On Mon, Jun 22, 2026 at 3:01 AM Brendan Jackman <jackmanb@google.com> wrote:
>>>
>>> It's pretty confusing that:
>>>
>>> - The slowpath and fastpath have a totally distinct set of alloc_flags.
>>>
>>> - gfp_to_alloc_flags() sounds generic but it only influences the
>>>   slowpath.
>>>
>>> - prepare_alloc_pages() is generic in that it sets up the
>>>   alloc_context, but the alloc_flags it generates are only used for the
>>>   fastpath.
>>
>> I understand you want to clarify the usage but this particular point
>> seems to be an implementation detail. IOW, if tomorrow
>> __alloc_frozen_pages_noprof() is changed to use alloc_flags when
>> calling __alloc_pages_slowpath(), would we be renaming it back? So, I
>> would suggest keeping alloc_flags as is in prepare_alloc_pages() 
> 
> I would say yes, we should rename it even though it might mean having to
> rename it back later. IMO it's very useful to make it clear to the
> reader that they also need to look elsewhere to find the slowpath flag
> logic, without them having to notice this rather odd detail of
> __alloc_frozen_pages_noprof().
> 
> But, yeah I guess prepare_alloc_pages() doesn't really care that its
> caller is only using the result for the fastpath so I could see the
> rationale for keeping the arg as alloc_flags...
> 
>> and its callers. 
> 
> ...  but for it's caller I really do think the rename is necessary and
> doesn't really have any downside? Especially once alloc_context gets an
> alloc_flags field as it does later in the series.

I don't mind either of the renames. It's all page_alloc.c internal anyway.

>> The rest LGTM.
> 
> Thanks as always, I appreciate the review.

