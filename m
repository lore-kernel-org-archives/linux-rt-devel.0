Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A32609C5
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059448; cv=none; b=pjFDElbFSX+kxsQmPLttis5MLzI15RHo+5uvxWnQ6GHQ+uXMk1DiPo0fWfz2/KZsA6UT6vIgxnI2KYtJACjX9jgM+2nyj1VD2FBxGrY5ShuAZqAjpGBJfjZGmzhHjc10YDlaLnk7NoVzF/5z9sbBvRB5JlHpnT6S6ZFXWcM2U7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059448; c=relaxed/simple;
	bh=e2rBsAuESxGLDeyt8z6waI57VlOJXIQioXY90iGBOGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US01mF7h2Dbv4uQ4VpYG408H3pTR2zLgGqYLA3heozMkQ/p4i7Hky9FQViVeQDkrrieNOh0HnCFIn8fu3bkqCUJVaHQwaOHPA4uAzQw1Njavz3bv+0D+iDYbWZFxYfD8EcIRm4WVuFnWLe3Ubkrv6CXX9VDaJTkNlWkKzcjncck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNcSl7Ut; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zeoGcmP3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNcSl7Ut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zeoGcmP3"
Date: Fri, 29 May 2026 14:57:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780059445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTA7PrYFBdf5dfakGhTEilrMz/5Fu7clSPzp1R+Zxew=;
	b=FNcSl7UtC3wq5fWcYoz1E7jbdzFyVbZ2jghLv+71yxGL4jyBLZVzvQ9RRqBT7b/Ne3ejrU
	YazLVAzUWBYxK+dtzl7SwsKL2T3DX9GJPFPIPLRJfNirJGciVY0eOBad0ytBtHejfxhqLs
	9mPoz0jDJH5iaLSINgYUl1fzQc1GU9Zh1AIMoK4S3c4qzBStnMp3XvmufhaeJ1Ru3QcSHs
	8UDWEcQcRn6cmjR561BswhTD1Kydo/WRpBbBzL2GlcRokZ0cmqjJRsaKHaiyp4a9IIAvQH
	qmmD10pEXogOLhV0AnWXitwZQ2MpcSFCC8JpZg50OCt2exsICZOe6JWKVyL2WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780059445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTA7PrYFBdf5dfakGhTEilrMz/5Fu7clSPzp1R+Zxew=;
	b=zeoGcmP3NDq8HKn98HZQ6Te2w5amuovh/bMGIKGaPBgCFXlfbamIrHztQoBWni0MelcM74
	wuML7ubmMLtgnwBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>, linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v6 3/3] pps: convert pps_device.lock to raw_spinlock_t
Message-ID: <20260529125724.ZaipPjjc@linutronix.de>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me>
 <20260528074939.7MLrIhrM@linutronix.de>
 <ahhl8dZ-uMM8gmDO@mozart.vkv.me>
 <20260529071931.nSO7Uqb2@linutronix.de>
 <ahmIp6lEjoiy-EDJ@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahmIp6lEjoiy-EDJ@mozart.vkv.me>

On 2026-05-29 05:37:59 [-0700], Calvin Owens wrote:
> > So lets look at the series:
> > - #1 splits the handler to take time stamp in hardirq and the remaining
> >   work in the thread. It seems to be crucial to do so because doing so
> >   in thread breaks something. Okay. Granted, makes a bit of sense.
> > 
> > - #2 ignore for argument's sake
> > 
> > - #3 says swap the lock so we can use pps_event() in hardirq context.
> 
> I interpreted that as saying "swap the lock so the lock can be safely
> acquired from code running in both hardirq and threaded context".

That is correct. But wake_up_interruptible_all() and kill_fasync() must
not be used in hardirq context.

> But looking more closely, it doesn't seem that either lock is ever
> acquired in hardirq context before or after this series.
> 
> So I think patches 2 and 3 are unnecessary.

Okay then.

> As a quick confirmation, I tested only patch 1 on a bona fide pps-gpio
> setup with lockdep and atomic_sleep and saw no splats.
> 
> Patch 2 suggests tk_core.lock being a raw lock was somehow a problem,
> but it's never held across anything, it seems fine.

pps_event() does invoke pps_kc_event(). So you need to swap this lock
(pps_kc_hardpps_lock) before swapping pps->lock. And hardpps() itself
already has a raw_spinlock_t so it is fine.

That is my interpretation.

> > Now. Why or where do we need to use pps_event() in hardirq context?
> > If we use pps_event() is used in hardirq context, as claimed in the
> > commit message, then dropping the lock early here does not help and it
> > will lead to the same splat in wake_up_interruptible_all() because
> > interrupts are still disabled independent of the lock here. It is
> > hardirq-context after all.
> > 
> > You don't see this warning in your testcase because it gets here from a
> > timer, yes. But. pps_event() can't be used as-is from hardirq context
> > either.
> 
> In pps-gpio it's called from pps_gpio_irq_handler() which is threaded.
> 
> In pps-ldisc it's called from pps_tty_dcd_change(). That is called from
> uart_handle_dcd_change(), the uart_port lock is a normal spin lock and
> is held over the call, and it calls wake_up_interruptible(), so I think
> that one must be fine (I only looked closely at 8250).
> 
> PTP calls it from ptp_clock_event() which itself takes a normal spin
> lock, so if that one wasn't safe people would get a splat already.
> 
> In pps-parport it's called from parport_irq(). That is called from
> parport_irq_handler() and mfc3_interrupt() which both look threaded to
> me.
> 
> In the testcase the earlier trace was from it's called from
> pps_ktimer_event() which is threaded.
> 
> I don't see anywhere pps_event() is called in hardirq context.

Okay. In that case #1 should be sufficient to not delay the taking the
timestamp if the context switch to the threaded interrupt is indeed such
a problem.

Sebastian
