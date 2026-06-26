Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071737B409
	for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493622; cv=none; b=oYhJL4A79IeBi1L0HIPVb/m+urugjBqJPaPh+VpksvZZEaJ3iPQ0StfpL4CTM/nYDPNS7ZT6FmQf9+xHOIKMJhbniK6SBrMfJjYqv05aaUO437C2uIi9tNaVo1GVgi25uavc0wALM2fnCk6Lo2cqtvV5DrgddnLO1Fi8K8HhOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493622; c=relaxed/simple;
	bh=JC/mq/hrZ91neaIuFGIQoRn0uXdL4pxe+dweBylGL54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8uBSDe/oZaRjV1GdzFNrL/4pMLIt4PgnaGERto2A/8wS2TI7sn6XlycahzD7L4nngqpYK7bQmwOnw7LkCkDySM3YtwEiPrhUFJU4UcYS+01U0Z3HWgH4tHLf8i0CgN0pa2ABdTV3bZyRC0ZDlOtP23drxhipVJBT+aVAdcmRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ejvn5toS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ADwbh8Z6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ejvn5toS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ADwbh8Z6"
Date: Fri, 26 Jun 2026 19:06:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782493619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+Fc7aUpuOZTN344NWoff6BdYfX4hiFMOFEOCbL7VBw=;
	b=Ejvn5toS4Q9se3PxapFtNUUQ0YdtosQ+Kmcl932HjG7142qkhe5XTlvWGbSr3RF6I6xGhl
	B7VH0NK5uTZG741UPR+hc9TzsgaXl2Uf6Aqnm+alkN2TDdFzYwWgUTgvSLtI46y/ebYDGF
	Vyhv747xC4TWVFuhiKLemqBTLwVZOiQWLfIBqid0GIbHzmTLCnxTYLZojpZrC/0w1Hnxv0
	yPZWnClagu3uO72mZ7Ein7Ppa/a9lYi4Gw3t8nrLjQIuW5CVTmu9efvhL3ulEmfp5wJKhW
	qJDrcFaRH0Xpr4LUItLvfPX5yIMscMvmIBQlIxaw5gZ4YNM79hI76Ckz5PT3+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782493619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+Fc7aUpuOZTN344NWoff6BdYfX4hiFMOFEOCbL7VBw=;
	b=ADwbh8Z6AG+wuxCc24H8PaEng8A0yd+w8Qb6BNxwUcT21ZipxHmBw/HliQbw/MDgqTM/Qj
	QXqKHMILsFkXP8BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 5/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Message-ID: <20260626170658.0bqzsB-1@linutronix.de>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
 <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
 <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>
 <20260625145115.KZ9l1-lv@linutronix.de>
 <aj6gdH2KS_XrNjIm@pathway.suse.cz>
 <aj6jcajaZXMF_BYG@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aj6jcajaZXMF_BYG@pathway.suse.cz>

On 2026-06-26 18:06:09 [+0200], Petr Mladek wrote:
> > Interesting, does the spin_lock_irqsave() even allow sleeping under RT?
> > 
> > I mean, does spin_lock_irqsave() violate the raw_spin_lock
> > vs. spin_lock nesting rules?
> 
> Ignore the silly question, please. Sure, even spin_lock_irqsafe()
> is a sleeping lock in RT.
> 
> That said, I am not sure how to effectively pretend the right
> context to lockdep. It looks a bit ugly to disable interrupts
> around all the code which is guarded only by a fake lock_map.

That splat is from !RT and here it wouldn't happen if interrupts were
disabled.
On RT that interrupt (softirq) would not interrupt as such. So it is not
possible due to how softirqs are processed.

My idea is to remove that thing so we don't have to annotate it.
The reason behind it: There is no added benefit from my point of view.
I can't think of reason to return real kernel pointers via proc/ sysfs
to the user which depend on a security policy. The %p will return a
value which can be compared against other values and check if it is the
same or not. The root user or dev can either disable this hashing
behaviour or use %px while debugging. I haven't figured a reason why
this is important.

If you have something, I am all yours. If not, I poke networking next
week and try to remove this entirely.

> Best Regards,
> Petr
> 
> PS: I am sorry for the rummour. It is Friday evening and a very hot
>     weather here.

I tried to stay strong but in the end I relocated towards the basement
and continued working there.

Sebastian
