Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2842FD684;
	Fri, 28 Nov 2025 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764324299; cv=none; b=hXKhINpOCC+XqiFoxA6/eX9g7fCORC/2FZNhJWuseY2/gEebmgqXbzlh/eRTKTmH9P2KQmPO+O9xNbBIbMoRkw+dPkgL6rie9ElyNjgVOnBgMywaMx4OKOm/cT+GPGVGBPdovF+69AhuyOgtmfNgrnKkMmMZZ+sinGYVqamccpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764324299; c=relaxed/simple;
	bh=8EWaOhwdH85AzrT5/WosRIC52cbIpjrVApspeZn9Trk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqVDtvInWAVm0oPyaRahClYLs489pRLg1Zqt1G3LBAaMyuuYfCjbu61E893sgiSSNp0Nzz8g0FQuA/mp01WtpRy6CzNEE4HcGYQAJF6X5eUZZ1Pxq8fiESRoqmn7T4rid7wGccIWir8ofMbYyokJib7WLA893KwB5GalmzW5o0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KCbJp/SP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KCbJp/SP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bcyjvAqhz1SkMYMk/nXwG4ryh32HmTyTnTT4CXJiYRo=; b=KCbJp/SP+9i/jf3y+x8lBIQNu4
	gQFZuFKVA46/QetKDFltQXglrZzZlOmF8Pi7KSiXcIk5P0scLwz8pkrhy33DXfEjG+euaurh1nY93
	SEzarZaOJUwSTbfi7T7HIsMW+q56aTCNdiW1DLiLccroJ2J2vU6theUCCQFcwN3dUDtof5X71htSZ
	b43u76m3Q7Q1l7l8aSgI845s3YwDrdhNxsYrEAuf8WDfakOZVn8od2qcIxeEd0jcg7zKnjVH58Vqp
	zkSRtDuBFy15gtTkhm24Ll6idUmAOzLtK1YUGiaM3AgXOYfXZmBZGKoPtjkdKUJ8Q2T3bh9isRnAP
	UqFHW3AA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOuTr-0000000Bglg-32fO;
	Fri, 28 Nov 2025 09:09:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A7154300230; Fri, 28 Nov 2025 11:04:51 +0100 (CET)
Date: Fri, 28 Nov 2025 11:04:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 RESEND 0/2] locking/local_lock: shadowing and
 maintainers entry
Message-ID: <20251128100451.GX4067720@noisy.programming.kicks-ass.net>
References: <20251127144140.215722-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127144140.215722-1-bigeasy@linutronix.de>

On Thu, Nov 27, 2025 at 03:41:38PM +0100, Sebastian Andrzej Siewior wrote:
> This is a repost of two individual postings earlier:
> 	https://lore.kernel.org/all/20250927090110.t8Tm9yrk@linutronix.de/	
> 	https://lore.kernel.org/all/20251009103900.2Fk8stnM@linutronix.de/
> 
> Sebastian Andrzej Siewior (1):
>   locking: Add local_locks to MAINTAINERS
> 
> Vincent Mailhol (1):
>   locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce risk of
>     shadowing
> 
>  MAINTAINERS                         |  1 +
>  include/linux/local_lock_internal.h | 62 ++++++++++++++---------------
>  2 files changed, 32 insertions(+), 31 deletions(-)

Thanks, stuck in queue/locking/core.
