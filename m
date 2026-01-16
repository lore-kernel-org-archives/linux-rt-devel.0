Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619093933FE
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595407; cv=none; b=nondaGdlt0DPvYVkajZjG4g9nLRWq2cPub4gK9GtFrphxnfAkzKb5hpMa2cflziyROQLkAs4jSPIxUku/9HsggPFO5HfrkDAh6Ley9uGEMLHRz1RH2kBkDolOSEtzdbBnWinuKQInlO17P18QzOTkvxRsIh2e06+Y6LlL9/jd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595407; c=relaxed/simple;
	bh=4HlzR5qP1qW3gy3QPSAvAFHolihouueHIz/u+nMvo1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8yAQEyGX4+BSunU2Qg7SsaaKScQzG+0sWk8yWzbTyULzvU3mLn0Z76AQm3tgttAIpmgK0jD0pi7XWJ4wIbBKsClzhtXv9/5sKHHEXnL1uD7ORVHdvsgPjekVln2yVqD+XrRb6iuyMurR6fjn30iznjIiK9Eqei47jYxA7BKAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lNB4oS6L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZAJ/26hU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lNB4oS6L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZAJ/26hU"
Date: Fri, 16 Jan 2026 21:30:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768595404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WecrocRMKZU/iNM4UOnRLQSWj3zv3D/TPEXXPniLmn8=;
	b=lNB4oS6L/T2CJs+x4Ue/QNzT2Im4c+SSYJ2l+IqAVGrg80PZ7qzZbGSBrs9X8hLyq5xj+6
	yBUBK7oJYhkZPerxNaQdhfwkWn3O9pzafpV03w7QUvZrUt9MUMyV/lsZ2HwLNtaxY4/uNW
	C7vPHJ4bMsNKYxt9Ax0sc6/HeKcrDKfb9ZZByZ3H40gNsbNr8yNH7E4GqnWjdaQXSMwfKD
	UOI8yIprFCNnS9mzukOhVJs/ccTK6K6idWlockkHpwurtihcvWcdZwRovXnRa5IMjzSIJY
	26WoMK6GUvruDcn2HCGSL59U00vegz8EnpsRfJXWGvYV4vDsebbm3EKP9V9MMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768595404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WecrocRMKZU/iNM4UOnRLQSWj3zv3D/TPEXXPniLmn8=;
	b=ZAJ/26hUWZYJCgXrahM+b5b5tJPh4hmp+MPndaGil0ynh7KDmT0wDBoUQVRohVpEgokmbM
	WtSNY2361Mo4+HBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v4 1/2] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <20260116203002.ocPCBG8L@linutronix.de>
References: <20260116170041.1059997-1-bigeasy@linutronix.de>
 <20260116170041.1059997-2-bigeasy@linutronix.de>
 <aWp2fKGfIQKJ8wze@shell.armlinux.org.uk>
 <20260116181201.v-z31XJY@linutronix.de>
 <aWqZDwxUtaE1yP28@shell.armlinux.org.uk>
 <aWqal9WQkYMkSzJl@shell.armlinux.org.uk>
 <aWqbB68tx8pdkN2q@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWqbB68tx8pdkN2q@shell.armlinux.org.uk>

On 2026-01-16 20:09:43 [+0000], Russell King (Oracle) wrote:
> > Oh, and, as I've said on netdev recently, I have lots of patches. I
> > don't have time to push all patches all the time. Those that I think
> > are the highest priority get the attention - so if something goes
> > quiet, the patches don't get progressed (because something else has
> > taken over.)
> > 
> > I haven't published these yet to my external git tree because they're
> > currently on top of my raw private "development" branch containing...
> > 
> > $ git lg origin..rmk | wc -l
> > 473
> > 
> > many of those behind those I mentioned above. At some point I need to
> > move them to their own separate branch, or to the "misc" branch after
> > sending them to the mailing list... but the latter means spending time
> > writing a covering message summarising the changes, and the key thing
> > is "time".
> > 
> > I've wasted almost all of today running a bisect for a stmmac issue that
> > takes out my _entire_ network at home. It's wasted because what I
> > thought was a good commit turns out, on re-testing, to have been bad,
> > and right now I have no idea what a good commit is, and whether that
> > even exists before the platform support was merged.
> 
> Sorry for a third reply... yesterday I started at about 10am, finished
> at 2am last night chasing a different stmmac regression.
> 
> Yea, if there was more time, then I could push all the patches I have,
> but I don't, and the above patches were generated back when we were
> discussing the issue last time.

No worries. Is your tree rmk tree public so I could pull those and test?
Do you want me to review any of those?

Sebastian
