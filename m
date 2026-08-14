Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6A2D8385
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Aug 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700956; cv=none; b=g0HJHSrDdETSzKSiNBTzld8v6umUPE5RNPvNZvEXT1oT7WnBnu5Qctl4VeJVCKaKLCGJWjgQbtebOD7jZg+jTogvyNv5pykg83x+XS2j8z/Otl9TlPTmUPiqQ02mL60gF+8RrM2J78jsYakHt4EdZgQZ2JCulZNxQuA1NFwXRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700956; c=relaxed/simple;
	bh=gWzin9wfOINNBvmpTDDtuNaWDRNMnVMGnqukN63vv1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEqdfDYzKRqNVzjoWCNHNwofTDAz/3dVk/ebbIT0z/wX1WSy+PT1kIYbA6Z+X9CmkxPmzIv31/GhkRrmwIXhZ9B0vTFf5/4NEYfzw5lqIFM15fziBD1mxTbSUEQ6eYIxrLVmSVMwCbKDTGGWHolmh0vVb9IWvrbGnqAsLa99L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YiXuDCtA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HrDb0Ckv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YiXuDCtA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HrDb0Ckv"
Date: Fri, 14 Aug 2026 11:49:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786700951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTiP7FWyTqJGmNFqRB+XUaEeim2Ak2m+qKESeUYSbR8=;
	b=YiXuDCtAst5zubxsGQCRNFp2MKZQMFMSHGggT5dcEGKC9ZFjJsK+ogkRY/q36a491ETSad
	jQ2nGUTvmPJVQDi94NHawjKk3VD+F9166F5iiL7DV7b1FL/Th4Xfi2zPYSyu9npamY2dGM
	GqH/RXyYed5J7APW3S5RXGvBiSV5SelrPKlEvFTDyFMfvCTNEsZ2eNi2IppWFYHAgdpfZa
	ZMEZE7bVqXecUSJ84Ikar5GMFNG5Ih1hQLLGNH2ndqtFGyvCfif+LBrxCAxQdtLsCXSTPm
	tDqNXvf/cUXv0W7PwYHbPb1QFIhXHqrwdXs0WUOuP76/xKJ+tXbHkc1rGTvigQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786700951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTiP7FWyTqJGmNFqRB+XUaEeim2Ak2m+qKESeUYSbR8=;
	b=HrDb0Ckvhx2HTPOMSBQb5fJgRVT0if/XrZ18C8dQTD0hB+zv1y9IHhT3H7rGiH0i8LsAWe
	KCUMWrYDnOR8QyDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Liang Hao <haohlliang@gmail.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] docs: timers: hrtimers: clarify expiry modes and
 ktimersd on PREEMPT_RT
Message-ID: <20260814094910.akPMAqd4@linutronix.de>
References: <20260812145440.23528-1-haohlliang@gmail.com>
 <20260813145746.26612-1-haohlliang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813145746.26612-1-haohlliang@gmail.com>

On 2026-08-13 22:57:46 [+0800], Liang Hao wrote:
> --- a/Documentation/timers/hrtimers.rst
> +++ b/Documentation/timers/hrtimers.rst
> @@ -171,3 +171,31 @@ hrtimers-based high-resolution clock implementation, so the hrtimers
>  code got a healthy amount of testing and use in practice.
>  
>  	Thomas Gleixner, Ingo Molnar
> +
> +
> +Expiry modes and PREEMPT_RT
> +---------------------------
> +
> +The default expiry context on PREEMPT_RT and the role of the ktimersd
> +thread are documented in :doc:`/core-api/real-time/differences`
> +(Timers).  Those details are not repeated here.

Interesting to say.

> +The per-CPU ``ktimers/%u`` thread (referred to as ktimersd in that

Maybe the other document could be updated so it ktimers everywhere.

> +document) runs at the lowest ``SCHED_FIFO`` priority via
> +``sched_set_fifo_low()``.  That priority is fixed: the callback does
> +not inherit the priority of the task that armed the timer.  A
> +``SCHED_FIFO`` task running at priority 99 that starts an unmarked
> +timer still expires on ``ktimers/%u`` (lowest ``SCHED_FIFO`` priority),
> +not at priority 99.

Right. Why would one expect that to happen?

> +Priority inheritance on PREEMPT_RT is used for the cancel handshake,
> +not for the arming path; see the "Spin until ready" section of the same
> +document.
> +
> +``hrtimer_setup_sleeper_on_stack()`` (used by ``clock_nanosleep()`` and similar)

I wouldn't say similar because what is similar? Does the timeout passed
to select() count as similar? Any of the POSIX timers?

> +is an exception: when armed by an RT or DEADLINE task it is marked
> +``HRTIMER_MODE_HARD``, so the wakeup runs in hardirq context and does
> +not go through ``ktimers/%u``.
> +
> +If callback work must run at the owning task's RT priority, either
> +mark the timer ``HRTIMER_MODE_HARD`` (and keep the callback
> +hardirq-safe) or wake a dedicated kthread from the callback.

I don't think this belongs here. Anything that general hrtimer related
could be added here. The flags parameters such as HRTIMER_MODE_REL,
HRTIMER_MODE_HARD, HRTIMER_MODE_SOFT are only documented in their
kernel-doc of the hrtimer_mode. 

This document does not cover where or in which context the timer
expires. This is also true for timer_list timers. Those are not affected
by this and expire always via ktimers/.

I would suggest that you extend the existing document that you refer to
instead adding RT bits here and refer to the other document. If there is
a need to mention the default context, hrtimer_mode would be the place.

> -- 
> 2.50.1 (Apple Git-155)

Sebastian
