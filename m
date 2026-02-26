Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55F318BBF
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111705; cv=none; b=fHau+ynNyQ2/UmSy9f87QTClnLzyswgJZFpNhTQRXe64t5lr+mT9OBab+iMMEg/uNxDjZETq/6tIBgkkNj85pEv/YkI3KMYeUul/Za9BFXHiNRemRwlEL9tvM++b8uhgjhPTJAu7ScSLB1rPja58vkb2IvwJX5nQHUNW1a5mIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111705; c=relaxed/simple;
	bh=epy5poEiRjng6LMc5QKFugg0z2A62Tl1e+nBwxRks+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpPzhrr2+prYU4rLqd5rK3a/B29RNdFt4Z8EN//1yXDfzf5gFJcnTy23voYQZdPCBnYKNQv9+PwwYSD/Dzxey421laNB8t0SvE/Kw1DL6KSAUO+dKHI5858L5Tt/IYGqAL//3SNqD2yg/1pRvLu3QVPnw9A6gwBYjMjTaDIMn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BehE2YRg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wS2L/5Xy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BehE2YRg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wS2L/5Xy"
Date: Thu, 26 Feb 2026 14:14:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772111701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9CDr3NUu/sKpVBd5lt9QN1bpaxogyWeWa+do82w1+U=;
	b=BehE2YRgVuzgSCllJG9NEK5zdFCWHrjjINxBTYIbIi3Yk0Wv/FjE94mf+aPxMAZDkG4qgW
	DNkgNK6itRAL8Ow5R0KrDaaTiR4fbd0qmhHDJkv5+D5zHogKkZmZOBnxGXizyIPgmynvVW
	pEZO+3C24POW9N0ysrh2y3crYExckvdgkPYmw1Jftl0T8EPvFXf22gHOoBjr7POofwrshW
	xrH4XHQ3fYS2dqsJgHitMqp/lQ7HAuPju+Zne4/yW1jFDRiC5O2CeoD7dgtC0TlCH1A2ik
	dIYH0VYy+gDbBYNX6TcHvSl21/FQWJj580MkDW09++/qPZFfd/pLf4lm1uHgcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772111701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9CDr3NUu/sKpVBd5lt9QN1bpaxogyWeWa+do82w1+U=;
	b=wS2L/5XybNnrmwSrjn7LPdhisOo0huBHxtY9rebHvX+O2b0nV3KwluS5GeZGsRhHnk0MZ+
	UrYKPxfEnMuVN3Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>
Subject: Re: [PATCH v5 1/2] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <20260226131459.8lBz2Cbs@linutronix.de>
References: <20260226111742.3598421-1-bigeasy@linutronix.de>
 <20260226111742.3598421-2-bigeasy@linutronix.de>
 <aaA8uR3_o55uuevl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaA8uR3_o55uuevl@shell.armlinux.org.uk>

On 2026-02-26 12:29:45 [+0000], Russell King (Oracle) wrote:
> Sorry, I've been swamped with stmmac for ages, which has become a
> millstone.
> 
> I need to push out these patches:
> 
> ARM: provide individual is_translation_fault() and is_permission_fault()
> ARM: move FSR fault status definitions before fsr_fs()
> ARM: use BIT() and GENMASK() for fault status register fields
> ARM: move is_permission_fault() and is_translation_fault() to fault.h
> ARM: move vmalloc() lazy-page table population
> ARM: ensure interrupts are enabled in __do_user_fault()
> 
> which will address some of your issues, and clean up the fault handling
> code. These patches all date from 5th December. :/

Okay. Thank you. Please let me know once you pushed them where I can
reach them. Then maybe we can reduce this to just 2/2 ;)

Sebastian
