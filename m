Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0873D091A
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820914; cv=none; b=TIgq/oEw4uZYshMRRhxMwDa1TR3GMEmuCNzWS/YVqksFkoup1slg1H7rDra301MUmj6BTX7YSaY4SfoHweGv1446m/O+ET6CBFyqFqn8oGMz3WYncc8DeMsn1N3dvzeE4K9urKjB6s7HLBoIddYiKy2YHmXC0jIlpunuK1yIZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820914; c=relaxed/simple;
	bh=rUAjUgPvFvnLSQu3UYtZbdv2V8E+HjHs5amdXDXXa6k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Ff20WbhP6lcn4lz6a+S1VPZ7sxYW/uCbIKT3QSbF8Bo5HN9sSDovSqirol1FWBQ1+7mscElUcoMF8SKXvMpDkr0q6BbC4+fa9YIQ35jlQ8jcEFNhAr2jBJV5D76D7JhN51dbWXB8M3zgVNC6GZV9mFG8yTOz1EopC2aQFDoiEUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d/HMIBfc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d/HMIBfc"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782820910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nPODt4gTf0vvhWgCFfGUzQ9veN5BNMQcI7/OEbq+Vo=;
	b=d/HMIBfckQ/xUy/p4Ui9WnefAf9EcK14IoRJ8lJkSyf6CftDv4WIt1LK+uKzpR/oz1uBao
	kSpCOLzYNW3L4+AwuJoC/Ekt3JmfEldNFDXWB5bsGBHsnQW3AvQmlMyPpK21b0BwlosqNM
	IkeTyZvmHHehLNn/frvAmWaWqlZzOfM=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 12:01:37 +0000
Message-Id: <DJMD9HIQHO0T.JBREVOE4VDEU@linux.dev>
To: "Hao Ge" <hao.ge@linux.dev>, "Brendan Jackman" <jackmanb@google.com>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Zi Yan" <ziy@nvidia.com>, "Muchun Song" <muchun.song@linux.dev>, "David
 Hildenbrand" <david@kernel.org>, "Oscar Salvador" <osalvador@suse.de>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Matthew Brost"
 <matthew.brost@intel.com>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Byungchul Park" <byungchul@sk.com>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Hao Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH v3 15/16] mm: replace __GFP_NO_CODETAG with
 ALLOC_NO_CODETAG
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-15-57bef0eadbc2@google.com>
 <b4916118-3537-4e19-8bc8-1d103dd0d225@linux.dev>
In-Reply-To: <b4916118-3537-4e19-8bc8-1d103dd0d225@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue Jun 30, 2026 at 1:55 AM UTC, Hao Ge wrote:
>> +/*
>> + * Skip early PFN recording for a page allocation.  Used by
>> + * __alloc_tag_add_early_pfn() to avoid recursion when allocating pages=
 for the
>> + * early PFN tracking list itself.
>> + *
>> + * Codetags of the pages allocated with __GFP_NO_CODETAG should be
>> + * cleared (via clear_page_tag_ref()) before freeing the pages to preve=
nt
>> + * alloc_tag_sub_check() from triggering a warning.
>> + */
>
>
> I originally wrote this lengthy comment because the logic lives inside=20
> alloc_tag.c.
>
> I wanted to document all the context to avoid confusion when revisiting=
=20
> this code later on.
>
> We've since replaced __GFP_NO_CODETAG with ALLOC_NO_CODETAG, a generic=20
> alloc_flags bit defined in page_alloc.h.
>
> The original long comment is no longer accurate:
>
> Given that, I suggest updating it to the following:
>
> /*
>
>  =C2=A0* Avoid alloc_tag recursion for internal allocations.
>
>  =C2=A0* Callers must clear_page_tag_ref() before
>  =C2=A0* freeing to avoid warnings from alloc_tag_sub_check().
>
>  =C2=A0*/

Thanks for the context, pasting this in for v4!
