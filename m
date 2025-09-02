Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5012E4241
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828599; cv=none; b=fR1ordNnJdyvIT1BxiDlF1ExfoMuba27EIIiKY8NpRaiP/5JQPQ56PenGklm9+HdNFuFpBaa1PHTfxkcUrQcp8sQereFQooPuu4+s5D1+/cIkiecapa704yEhteSo91e+e9/e7cNjME/QmzD1sUb8BQeruoKn9wIvQco92gsK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828599; c=relaxed/simple;
	bh=g1bkIG37s9fgjXu+ib19trGheHGbvz+8KR9RvID0OGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr9mSdR8ZgSG3DZAwsML2GAcjotqInNh+G0UIEwHK9sv587qbjfvloSRXgGaqAptD0ALRyDCTi/9kZL49mx64qGCeCcUdAxPJ0fVYDr42+i63ONeMuV0CVg7Bt5LpU4xQpEfL2SrbUslWSY+sHvEAZ7ipSMsjwPLZhASGATsvMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tt+Sbh7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBFyc0oz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tt+Sbh7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBFyc0oz"
Date: Tue, 2 Sep 2025 17:56:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756828596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LswVthRZlVgY9iC1UxIP2BbJPLTS0TiEx2kp0GoNkR4=;
	b=2tt+Sbh7Pws/rEAFVGNjoTAQYjWM61wm5c/IDVWVfPoB9gyPv6anfPxqmvMoa2GvR11Czk
	+JPHo+55bSVsz9vAfqcH/gBVSoNWPXcCf5Hh82TY0Ui7YjZoIypyF3osTaktjZTrcri8l1
	rdmXx73j8qK3pDKr5Q+7scFgDfpG1VGoKpEOT20vB5GLWBIWi7Wm0IrESUiW+F5KZfKEjm
	99q1VTa6wG8OSXmyxklNKIguKqiH2v4RpJSu8Q+Lji+s35uXw9CJdDPsehh0GzxttbvGmr
	rcHM9IXk3RJLDnjxi0SrHLQtcP35mqUATGxwY0/u5KHWkY3BL8Jw63D0584IWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756828596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LswVthRZlVgY9iC1UxIP2BbJPLTS0TiEx2kp0GoNkR4=;
	b=pBFyc0ozG9j3HdnTlVm0ArkSsc2pW0pfiI8wyNJIb9Fw8yBskyjUSLTjOuEPBl+quaDZS2
	57+ngw7A4c3S3xDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH
 workers
Message-ID: <20250902155634.enTifVKX@linutronix.de>
References: <20250901163811.963326-1-bigeasy@linutronix.de>
 <20250901163811.963326-2-bigeasy@linutronix.de>
 <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>
 <20250902111740.hwMmUu4T@linutronix.de>
 <CAJhGHyD7x9QLJ+uoRnbh4qOhphdxJU4c384D1Ph2tn5ktR_=kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJhGHyD7x9QLJ+uoRnbh4qOhphdxJU4c384D1Ph2tn5ktR_=kw@mail.gmail.com>

On 2025-09-02 22:19:26 [+0800], Lai Jiangshan wrote:
> Hello, Sebastian
Hi Lai,

> On Tue, Sep 2, 2025 at 7:17=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > > Is it possible to use rt_mutex_init_proxy_locked(), rt_mutex_proxy_un=
lock()
> > > and rt_mutex_wait_proxy_lock()?
> > >
> > > Or is it possible to add something like rt_spinlock_init_proxy_locked=
(),
> > > rt_spinlock_proxy_unlock() and rt_spinlock_wait_proxy_lock() which wo=
rk
> > > the same as the rt_mutex's proxy lock primitives but for non-sleep co=
ntext?
> >
> > I don't think so. I think non-sleep context is the killer part. Those
> > are for PI and this works by assigning waiter's priority, going to sleep
> > until "it" is done. Now if you want non-sleep then you would have to
> > remain on the CPU and spin until the "work" is done. This spinning would
> > work if the other task is on a remote CPU. But if both are on the same
> > CPU then spinning is not working.
> >
>=20
> I meant to say that the supposed rt_spinlock_wait_proxy_lock() would
> work similarly to the rt_mutex proxy lock, which would wait until the
> boosted task (in this case, the kthread running the BH work) calls
> rt_spinlock_proxy_unlock(). It would also behave like the PREEMPT_RT
> version of spin_lock, where the task blocked  on a spin_lock has a
> special style of blocked/sleep instead of spinning on the CPU and this
> is what the prefix "rt_spinlock" means.

That interface is actually implementing that boosting for users which
don't use it directly. By "it" I mean the proper rtmutex.

This is used by the PI/ futex code where a rtmutex is created as a
substitute for the lock that is held by the user in userland. The lock
is acquired in userland without kernel's doing. So in case of contention
the user goes to kernel and creates a rtmutex as a representation of the
userland lock in the kernel and assign it to the task that is holding
the userland lock. Now you can block on the lock and userland tasks is
forced to go to the kernel for unlocking.

For RCU, as far as I remember, a task within an RCU can get preempted
and in that case it adds itself to a list during schedule() so it can be
identified later on. There can be more than one task which is preempted
within a RCU section and so block a GP. The boost mutex is assigned to
the first task currently blocking the GP and then next one if needed.=20
A poor substitute would be something like taking a lock during
schedule() and having a list of all those locks in case boosting is
needed so it be acquired one by one.

> By the way, I=E2=80=99m not objecting to this patch =E2=80=94 I just want=
 to explore
> whether there might be other options.

Right. So you would avoid taking the cb_lock in bh_worker(). Instead you
would need to assign the "acquired" lock to the bh_work() task in
__flush_work() and then block on that lock in __flush_work(). In order
to figure out which task it is, you need some bookkeeping for it. And a
lock to synchronise adding/ removing tasks on that list (bookkeeping) as
well as accessing the lock itself in case of "contention".
So given all this, that approach looks slightly more complicated. You
would avoid the need to acquire the lock in bh_worker() but you would
also substitute it with bookkeeping and its locking elsewhere. So I am
not sure it is worth it.

On !RT you can have only one running softirq at a time. On RT with the
removal of the lock in local_bh_disable() (patch #3) there can be
multiple softirqs instances in parallel on the same CPU. The primary
goal is avoid center bottleneck and make it possible to have one NIC
doing throughput and another NIC doing low latency packets and allowing
the low latency NIC preempt the throughput NIC in the middle of sending/
receiving packets instead of waiting for NAPI doing a handover.

The lock I'm adding here adds some synchronisation here. So you see how
this requirement for the three legacy users makes it slightly more
complicated especially after the cleanup years ago=E2=80=A6
However I hope now to come up with a atomic API as Tejun suggested and
push it behind Kconfig bars or so.

> Thanks
> Lai

Sebastian
