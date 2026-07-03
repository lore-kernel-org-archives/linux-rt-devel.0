Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E763AFD07
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070197; cv=none; b=FRHZNAX9L/DyNhI7ulW0AqFJBUT9Gi0QOa77qZJDZ3puJVEL+sMWpb1hXLsUYobW5dpe55jAlWKpXE/PvP6l2NacqOdqQqAZN//F8RikDqpxaFhZtygLBtxQ+ixAlpPv9HTKRQxSd01qYL2Df8NQrEIkZ3y86OGW7s+xrAY5F7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070197; c=relaxed/simple;
	bh=cjladEAkzRrN7pPP1OOOc5gAK72fK5gVtCQNyKikpqA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VFtM66vzUj5V0rOnLoq9dfoeFGCfM+h1wvNRB6Y1sU3ljNx2bicINu2iBgRQZ93J2Md0wLop7WWyztbIwr8RFMVBmn+huR0fX+JxrCIY+yb1It5aYFGcR7ZrATTIaRsbCv1p6IOCbZRhMJXF8X5XjNcHXcjmkTERiBV2INYUWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sp3T9V8o; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sp3T9V8o"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783070193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjladEAkzRrN7pPP1OOOc5gAK72fK5gVtCQNyKikpqA=;
	b=sp3T9V8oqmc6/s7YfVT//BEqowOUEdep9bgFwcs6b4/GAbxsn2VBGgedZ7wFf+x7gnzzB/
	r7IFsDz3dN8sscgB95Bw9wiVD8LF57o5AHBmdFgaPV6yTqwWup5XBH4kTIRBIabpDYTMZ3
	LhOaz6tkpkcG7ndRrzsWtm22WZlP9UA=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 09:16:11 +0000
Message-Id: <DJOTMGFAPDBF.261U5OD4NPU74@linux.dev>
Subject: Re: [PATCH v4 18/18] mm: factor out can_spin_trylock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
 <20260702122822.562721F00A3A@smtp.kernel.org>
In-Reply-To: <20260702122822.562721F00A3A@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu Jul 2, 2026 at 12:28 PM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The refactoring to deduplicate spin_trylock safety checks into c=
an_spin_trylock() missed __free_frozen_pages(), leaving a pre-existing UP N=
MI corruption bug unpatched.
> --
>
> Note: The format of this report has been altered to provide a free-form
> summary of the findings due to recitation restrictions.
>
> commit a99a7a468132ab177e1233c7e2f5644523ace0a7
> Author: Brendan Jackman <jackmanb@google.com>
> Subject: mm: factor out can_spin_trylock()
>
> This commit introduces can_spin_trylock() to deduplicate checks for wheth=
er=20
> the current context is safe for spin_trylock(). It updates=20
> alloc_nolock_allowed() in mm/page_alloc.c and __kmalloc_nolock_noprof() i=
n=20
> mm/slub.c to use this newly factored helper.
>
> Link: https://lore.kernel.org/all/397859cb-b127-4cc6-9c71-044afc99bf0c@ke=
rnel.org/
>
> [Severity: High]
>
> This isn't a bug introduced by this patch, but the deduplication refactor=
ing=20
> appears to have missed an open-coded check in __free_frozen_pages() in=20
> mm/page_alloc.c.=20
>
> Could this open-coded check also be updated to use the new=20
> can_spin_trylock() helper to resolve a pre-existing UP NMI safety issue?
>
> When __free_frozen_pages() handles FPI_TRYLOCK, it explicitly checks for
> CONFIG_PREEMPT_RT and NMI/hardirq context. On UP systems where CONFIG_SMP=
=20
> is disabled, spin_trylock() and its variants are defined to unconditional=
ly=20
> succeed because there is no actual lock state tracked.
>
> If a caller invokes free_pages_nolock() from an NMI context on a UP syste=
m,=20
> the current RT-specific check fails. The execution then falls back to=20
> free_one_page(), where spin_trylock_irqsave() falsely succeeds even if th=
e=20
> NMI interrupted another task that was actively modifying the free list un=
der=20
> the zone lock.=20
>
> This allows concurrent modification of the free list, which can lead to=
=20
> corruption and kernel panics.
>
> Updating the check in __free_frozen_pages() to use !can_spin_trylock()=20
> would catch the UP NMI case and safely route the allocation to the lockle=
ss=20
> add_page_to_zone_llist() path instead.

I think Sashiko is right? Based on the unfixed kprobe bugs described in
[0] should we just disable nolock on UP? If that has a user, who knows
what they are up to, but I would wager that we'd prefer to break their=20
probabilistic tracing than corrupt their freelists.

Not a strongly held opinion though I can also send a patch to "fix it"
if people prefer; I'll keep functional changes separate from this series
though.

[0]: https://lore.kernel.org/all/20260427-nolock-api-fix-v2-0-a6b83a92d9a4@=
kernel.org/
