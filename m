Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C032C325C
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858637; cv=none; b=dCYerzftaazz3tRAhzbLR45tV89iij6a+qXhgrDNBFIPU06mgzlBjwtUjRYI0y6N+hol3x4G+2XmBmNt/kVcYxuE+p4MV6JAeISY/7Rhk0EcEZRFG7g4vRUZRNcRZ9YHzCw3wAAR0BqvmsSJtPDft1SH/p7CIkNr5SKy3LZXr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858637; c=relaxed/simple;
	bh=NAZ42QB36nrAdmAjh+rf/GCgFzjXqICskAwIj3jKyQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KKdWBke7FlfOtaviKiVNl2l8CcTO68RqLb0N4itsvxGfe1BXbTIcTwWv0S8CXQpcV7+vI9/4eDaSDJ94BV0aOX49GXTilO2ZuIeBF0pB3hzFf/61Jt6uIZLvqL5H0cDw/gphSXyw7U4AzfsvVqhnpSHV0fpp6S7c8mGHQfzSF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTgxJITT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTgxJITT"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781858622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JT3agkcvHZt5F7xrG4mpo3JBg3ES6F+qE2PnUZWPoY=;
	b=cTgxJITT5pXSSlZ2K4cY9UptzxTsEBWEKnVjQXQR0CMYn/dZvGA4pMdRTFDUzxDKfHf7DW
	YwsOk3J5u2GrSfhW1ql+j9ZZYOZZizTTlxe4rnUzQEJHp1LexIpHXPn3CpNQeDpUCYBDK0
	evTdnePbygzBIUKlah0fx0PxuRaF0RU=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 08:43:33 +0000
Message-Id: <DJCW5UN9FGSY.3F00439Y7YBYD@linux.dev>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
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
 Rostedt" <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>,
 "Gregory Price" <gourry@gourry.net>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Brendan Jackman" <brendan.jackman@linux.dev>, "Matthew Wilcox"
 <willy@infradead.org>, "Brendan Jackman" <jackmanb@google.com>
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <ajS96fWbG4dzP3u3@casper.infradead.org>
 <DJCVLX0WK118.3V7CXOTLISFOQ@linux.dev>
In-Reply-To: <DJCVLX0WK118.3V7CXOTLISFOQ@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri Jun 19, 2026 at 8:17 AM UTC, Brendan Jackman wrote:
> On Fri Jun 19, 2026 at 3:56 AM UTC, Matthew Wilcox wrote:
>> On Wed, Jun 17, 2026 at 03:29:42PM +0000, Brendan Jackman wrote:

>>> +/*
>>> + * GFP flags to set for ALLOC_TRYLOCK i.e. alloc_pages_nolock().
>>> + *
>>> + * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allo=
wed.
>>> + * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
>>> + * is not safe in arbitrary context.
>>> + *
>>> + * These two are the conditions for gfpflags_allow_spinning() being tr=
ue.
>>> + *
>>> + * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a re=
ason
>>> + * to warn. Also warn would trigger printk() which is unsafe from
>>> + * various contexts. We cannot use printk_deferred_enter() to mitigate=
,
>>> + * since the running context is unknown.
>>> + *
>>> + * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() bel=
ow
>>> + * is safe in any context. Also zeroing the page is mandatory for
>>> + * BPF use cases.
>>
>> It may be mandatory for BPF, but it seems wasteful for other uses.
>
> True, don't see why we shouldn't push this out to the caller, I can do
> it as part of this series.

Wait, I wasn't paying attention to the bit about kmsan_alloc_page().
__GFP_ZERO is load bearing for the implementation because otherwise
kmsan_alloc_page() does things that might not be safe in the current
context.=20

> >> +	if (alloc_flags & ALLOC_TRYLOCK) {
> >> +		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
> >
> > So the only GFP flag the user is allowed to specify is __GFP_ACCOUNT?
> > That seems bogus; other flags would be reasonable including all the one=
s
> > in gfp_trylock, as well as GFP_HIGHMEM, GFP_DMA, GFP_MOVABLE, GFP_HARDW=
ALL.
>=20
> Definitely makes sense for the ones in gfp_trylock.
>=20
> For the others, I'm not sure - this "nolock" functionality is a bit
> weird and sketchy,=20

...

> I suspect the reason for the WARN here is "let's make
> sure we have a proper think before we allow it to grow usecases that are
> meaningfully different from the other ones". I think I like that
> conservatism here, I would lean towards keeping it? Not a passionately
> held opinion though.

I'd probably still lean towards pushing __GFP_ZERO to the caller though,
and just WARN+fail if it isn't passed, to make it explicit?
