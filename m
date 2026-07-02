Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5F388881
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974041; cv=none; b=YD+ZIUoo9MkoZ1v/2CFlSsewyPIdpivqPoE2JIZx4z9IVAJ0DTkvhoFjcQCFj/AwadxWTJwJM3Qd3JIv5f9IQ1ymfkyYNb6lPZHXFs3PwQli6b6FMEzMeKeOo2XHNgMshWMXYsxT6hhuE18T+8v5FfYKxIXBNaWac6IsvQetyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974041; c=relaxed/simple;
	bh=74boahNZzYwL9MKBDoebU3TIZtRoTbOvagBnezf4s70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw2nnxl4NgKoNqDGDWft5CwRrFSBOt9bTl8HmPJ+ywuOR0cpViQ3BbffBVduOUOsgMyBALAvWmyZ+ZMYf6/FEErPgoCPDmNjA91U/A3zeIsNJm3AroARzDmyyx97EhmkAolTRS8ej21wkKIIPYhpBqaWOiTTbU6KW6owJvYUHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tiQ+NPMc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=trII+zFF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tiQ+NPMc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="trII+zFF"
Date: Thu, 2 Jul 2026 08:33:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782974038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=but+KKeAYMreeOkngpAdeQad9e6+IRPsa1mDowU/Zdc=;
	b=tiQ+NPMc40Fdk++THz8PxVGAorclRjZwcjQlP2R3MTlINBr39MfNhRSACFuEoSVDGIu4Rl
	jlGqfijDP2dJZ9lWKWLj+J7/n64IoKa1NH1KuSvvhMgitUCBi1uiGRBU5HweyzbwC38HS4
	k7mdXkSWvf1t1cFjpCLD6E15Swqpudah9u2Avmhxa4lxM5btcyoBIppRggYuGlJrjMQxJm
	JOyKZCidi8tCetor6FMZhcMmxX60uXzyR4TgiusKfFwcsry+32p9FFw/PZ4NyMCwTzkp60
	lvlqpA9A+8Obln9RulkoSvVioI8mjyOnPWPpZFWswoIUDyorbnqVAGmRjgGNDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782974038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=but+KKeAYMreeOkngpAdeQad9e6+IRPsa1mDowU/Zdc=;
	b=trII+zFF1XJMbFKK2gUJW/lasmxP88xtrIsj8w5FPmXmtvr3UzceobuuRaojbkDVP2GRoa
	J0Pr1mjH2Yg5X4Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: [PATCH] futex/requeue: Revert "Prevent NULL pointer dereference
 in remove_waiter() on self-deadlock""
Message-ID: <20260702063356.mzkkgdJT@linutronix.de>
References: <20260701131150.0Ijhq4Dw@linutronix.de>
 <87h5mipwa6.ffs@fw13>
 <20260701154517.0u_G4dkO@linutronix.de>
 <87echmplpq.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87echmplpq.ffs@fw13>

On 2026-07-01 21:13:21 [+0200], Thomas Gleixner wrote:
> On Wed, Jul 01 2026 at 17:45, Sebastian Andrzej Siewior wrote:
> 
> > On 2026-07-01 17:25:05 [+0200], Thomas Gleixner wrote:
> >> > That has been already handled by Davidlohr in commit 40a25d59e85b3
> >> > ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")
> >> > and requires no further acting.
> >> 
> >> No. If the self deadlock is obvious, then this should not even go into
> >> the proxy lock code. I clearly failed to notice the leak problem, but
> >> reverting it and relying on some magic down the road to handle it
> >> correctly is not really solid.
> >
> > Davidlohr fixed the issue that has been fixed again. We don't need two
> > changes for the same thing.
> 
> He hardened the remove() function against that scenario.
> 
> > We have deadlock detection down the road, why special case it here?
> 
> It's not special, but there is no point to actucally call into complex
> and as demonstrated fragile code when you can avoid it upfront, no?

It has been like that for since forever. So it is a tested path.  If it
wouldn't be for commit 3bfdc63936dd4 ("rtmutex: Use waiter::task instead
of current in remove_waiter()") then none of these would be needed and
we would still the deadlock detection in one place.  It is just
unfortunate that had two fixes for the same thing "recently".

For the timeline:
| 8161239a8bcce ("rtmutex: Simplify PI algorithm and make highest prio task get lock")
| Date:   Fri Jan 14 17:09:41 2011 +0800
|
| 3bfdc63936dd4 ("rtmutex: Use waiter::task instead of current in remove_waiter()")
| Date:   Wed Apr 8 16:46:00 2026 +0800
|
| 40a25d59e85b3 ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")
| Date:   Thu May 7 04:29:13 2026 -0700
|
| 74e144274af39 ("futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock")
| Date:   Tue Jun 2 09:12:04 2026 +0000

So July is the next futex fix patch for sure ;)

I will try to add a function test for these two paths but I'm already
behind on my other futex thingy so I can't promise anything.

Sebastian
