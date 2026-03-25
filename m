Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107B3EDAC7
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458345; cv=none; b=RIW14A1Vw08u6TIUAYFGRGJ6wsnbQryvTU3QhZV080E0g1sI8rJtxA4sOxgUKNvuwHIOaWrv2ExdnEa9gR+M6JbADJ9Mf8VRwCVBXI68OQwsryXjzDvbAhNdKPIXg4SkGhNFNekNPyyRu4d39yY4iTddI6FDMGv6veAhWG7O0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458345; c=relaxed/simple;
	bh=Qkhn5xhUvRY3FsRKRwIeRVy5vTTe+E0IQXfB8XYewek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXjZH0PzNts4mBy9N5G/dC10BplK19SQDtelfl3m90sOIicefFk6nfoUn2S7e2vpfmTGGY7bOhg+GXyupXvYoDRQBJVBIV9/xjwbEYQ5o+ErePoifqVP7fIm34mu6PaSIoBfwNbD4s78rW86KCFEaO1ODIrXx5Ux7mgaUjkgIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvP8MVT2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7UZtiY8e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvP8MVT2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7UZtiY8e"
Date: Wed, 25 Mar 2026 18:05:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774458341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkhn5xhUvRY3FsRKRwIeRVy5vTTe+E0IQXfB8XYewek=;
	b=kvP8MVT2LTvYBL7kAMDaFuR0o9O8hZohP3nd2K7TtgbeSjzEbV0RWlDarav+Oz432DAuI6
	g6UotS9jGo2TNnafAHSb8epDq9RQ7z9F10McrqLPlkn0vmsf4esyO/vkdkQGJVE0zn2B59
	x3An8OpdV5rwa5jNA9deGPdJJv9gAAcv7kiFocZyhC4ZhBdEbSSDoBNhPLXlxEvaINtE8e
	4DvXueFnSX5HxpAg0nc6h+bmgySQ3kT6FOnthAxhQCj3pcNdSP/qeIkY/JUUUvhhkteqkD
	JdmqCubR6xPwAOP1hsMcLXVL1RgGLQFZDfGhCUoCYxQxNfOmkxH0c/fbcmOmJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774458341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkhn5xhUvRY3FsRKRwIeRVy5vTTe+E0IQXfB8XYewek=;
	b=7UZtiY8eLOSFtTCw8s7jdsDcmPf6HWszVYCt7m1ADulM2244LGQYzs8b6ykBut3dW05Lpo
	VHIio4nJ485yFjAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325170539.MHkr49jU@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
 <20260325111351.1d38a0bc@gandalf.local.home>
 <20260325153826.EbSqlX_n@linutronix.de>
 <20260325115315.052e34ac@gandalf.local.home>
 <20260325155504.tm4zHWMI@linutronix.de>
 <5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>

On 2026-03-26 00:34:58 [+0800], Jiayuan Chen wrote:
> In irq_work_single(), just wrap the post-callback section with
> rcu_read_lock to keep the work structure alive through an RCU grace
> period:
>=20
> '''
> =C2=A0 lockdep_irq_work_enter(flags);
> =C2=A0 work->func(work);
> =C2=A0 lockdep_irq_work_exit(flags);
>=20
> +=C2=A0 =C2=A0rcu_read_lock();
>=20
> =C2=A0 (void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK=
_BUSY);
>=20
> =C2=A0 if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
> =C2=A0 =C2=A0 =C2=A0 !arch_irq_work_has_interrupt())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rcuwait_wake_up(&work->irqwait);
>=20
> +=C2=A0 =C2=A0rcu_read_unlock();
> '''

This shouldn't be needed. run_irq_workd() should get a guard(rcu)(),
the other callers run with disabled interrupts. This should include CPU
hotplug invocation but need to check.

> Then provide a helper for callers that need to free:
>=20
> void irq_work_synchronize_free(struct irq_work *work)
> {
> =C2=A0 irq_work_sync(work);
> =C2=A0 synchronize_rcu();
> }

Why not just having the synchronize_rcu()?

> Callers that free the containing structure would switch to
> irq_work_synchronize_free(), or use kfree_rcu() if appropriate

If we provide the irq_work_synchronize_free() then using kfree_rcu()
would sort of open code irq_work_synchronize_free() since we couldn't
simply replace synchronize_rcu() with something else and update the
irq_work core side (we would also have to update all users). I guess
that was Steven's idea in providing a helper for synchronisation.

> Thanks,
> Jiayuan

Sebastian
