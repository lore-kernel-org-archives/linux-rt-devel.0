Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E12F99B8
	for <linux-rt-devel@lists.linux.dev>; Fri, 22 Aug 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856098; cv=none; b=qYStlo2pN7ncFiuut8fxLz1O2d/S0ZDO/WGujqUJxyTbmxarltpCwGlG9zKQknkc5cS0kLiq2Wy9jkyZgdGkGfXd13HNVRaLEYpiBW9IaGQRRnJyyot9EhJ5w/RarOMY42oF+A7HzwqeIKJOO+ybz2q5wnUomHrAZCHTnegMbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856098; c=relaxed/simple;
	bh=8jQ1SElZ7Mtuc8En+iTgDEWb7wCqXjJUOzXaIBcfon0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgjFt/O73dLoMej15OMScJygHzH1H/O0vP1OYEGKBsPzuAdSuwMHd7KKgTksHYUpgLfdSapPBjCQvD+pv+qIoYzmXCYy1uy+Y0e5yVPE1hHjskVI8E8Vr+fali8V7IGOUDtSfaZSjNTrRUpI5KJ5VFqg9HuW5pu8oyEvujaAwZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIvohLqq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNrcMePv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIvohLqq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNrcMePv"
Date: Fri, 22 Aug 2025 11:48:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755856093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMJqqBl9hf4m0UHilGtUBnDb9eQqNKcfMHu01GtPB0k=;
	b=pIvohLqqD66jf/Z3DDywdHxpq6St6qkkVcpNcFIG8etnlIpLRBGa1wSEg7sawlgpHu03ZX
	Z7UAwsnS2bbJ1zDx6ZtN84DlC3X4YiJAs9ry8jiPNhOAFim0SxqFivtp7Gp2FCoeZ0ZqE4
	+8OzLY5SrfrCuXy6KMrSkwgm7GVW4V5gsIwWtlGrH5CrCn7GwqwFqy5hLcKijP9pF2AREW
	Vu5Clu3aa4IKSQz7vsE0YcasRGKKUW7girAmMVBINqGszfRebIRvIMPBdyarVlOCuk1ioB
	AtgpptysQJ7EaRnyx6EE5OnbXKfNXmZOrAApID+dzvDoxwSLI3VQOWrUpcizJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755856093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMJqqBl9hf4m0UHilGtUBnDb9eQqNKcfMHu01GtPB0k=;
	b=ZNrcMePvFQXuhovVDH13mRm3ZQhz2CNfZGHNORIvOBfK7s3Ccb9tAWTWctM440w3zy4MC3
	rgKBAKVGhOh9q3Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250822094812.L4hiquhY@linutronix.de>
References: <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
 <20250821092827.zcFpdnNy@linutronix.de>
 <aKdTEkK5MBz_Fj47@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aKdTEkK5MBz_Fj47@slm.duckdns.org>

On 2025-08-21 07:10:42 [-1000], Tejun Heo wrote:
> Hello, Sebastian.
Hello Tejun,

> Oh, I'm not insisting, don't know enough to do so. Just trying to underst=
and
> the situation.

ah okay.

> > > I'm most likely missing something about RT but wouldn't the above sti=
ll lead
> > > to deadlocks if the caller is non-hardirq but higher priority thread?
> >=20
> > Not sure what you refer to. Right now there is this lock in
> > local_bh_disable() which forces PI.
> > Removing the whole section for RT as in this snippet gets us to the
> > wait_for_completion() below. It lets the task with higher priority
> > schedule out allowing task with lower priority to run. Eventually the
> > barrier item completes and with the wakeup the high priority task will
> > continue.
> > So the high-priority task will lose runtime (allowing task with lower
> > priority to run). I don't think it will be a problem because it is
> > mostly used in "quit" scenarios (not during normal workload) and matches
> > tasklet_disable().
>=20
> Okay, so, on !RT, that busy loop section is there to allow
> cancel_work_sync() to be called from BH-disabled contexts and the caller =
is
> responsible for ensuring there's no recursion. It's not great but matches
> the existing behavior.=20

hold on for for a sec: existing behaviour for tasklet_unlock_spin_wait()
which has three users (a fourth one if we count i915 which has its own
tasklet layer). Not something that I would call common or wide spread
behaviour in the kernel (and task workqueue does not have it either).

tasklet_disable() and tasklet_kill() both sleep while waiting for
completion and don't spin.

>                        Obviously, in !RT, we can't go to
> wait_for_completion() there because we can be in a non-sleepable context.

Again, only a small amount of users require to do so.

> Are you saying that, in RT, it'd be fine to call wait_for_completion()
> inside local_bh_disable() and won't trip any of the context warnings? If =
so,
> yeah, we don't need any of the looping.

No, that won't work. local_bh_disable() will start a RCU read section
and then RCU will complain during schedule().
So if the requirement is to cancel a BH workitem from within a BH
disabled section then we need the first patch in this thread.

But if we get rid of this requirement=E2=80=A6

> Thanks.

Sebastian
