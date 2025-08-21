Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3628031D
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 Aug 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768512; cv=none; b=a0Fu1NbjkmmKU3zck9ENWP1/28SgOMI0VQNWKplVdyGcpgy0m/8xx7xeeG7pMY3xHFBJ9JPEwhWyMlCG50ImDAvSlbuEIoVKfKU4ZuWi/1tJC2c9Fy0Oza7JDnVthyNJe/hz9vkESxoeiICMrHgHrewjXKJHZQXLDb2wq2xhLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768512; c=relaxed/simple;
	bh=FFkqcHyNLGVIkxTVqaglxLctBTrfvQNtONprm/7E0P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8aCebID+gVEdG9wJ59EbWs69lChLCEWKeDnP/Rrys/Wxr/BEuS3U+vVWP+qP0+P8UC0psRoh2wW7VaXsZ+Lz8hzEmBP9p14T8ueY1/mlYjP+c5KGMpz+xaq1fnoyKkwrt/9YkKq0TGSo91rEAMMEkSg80V7SDwj83HLzv5XfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yxqPURep; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7hNYeuAV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yxqPURep";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7hNYeuAV"
Date: Thu, 21 Aug 2025 11:28:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755768509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU/cBDBWbyglLLmEqf++i2P7dpq4BufgBTHjyWh9zuk=;
	b=yxqPURepnPP223gj7lTjP9eoaP6pdN8AzglLTkAKdp1eq6SweHz6nJvQq/KRYhrOv3UCn7
	d8VDoXcJwqb+PMLDRZiQQZzvduS/B+CVEwp8CFoEzvFbM421KDMXW4Kkz5zA621WwWQbSr
	s0C+kY3w6Bh8d2sGSHs8Mi9wE6yxq0deRcG91H112TVggDwaJwDcjeMBpIGaAPpGFMPl8n
	MksKTzq9klen/6L5fLfmB177UPRujALl6SuvHHqUnBQE3oNejqwYpZ+HuCmk7MTu0qsJr3
	Ibmh8yInCfQvKjh/Q4f6MIAGs2qZxgntYixDJrMWSSCybggssmk6AcMLcGKbZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755768509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU/cBDBWbyglLLmEqf++i2P7dpq4BufgBTHjyWh9zuk=;
	b=7hNYeuAVRFn8ZhQXdxfKBdOaIkt1v1c4H86UXNtQeR2HtENjXsf8CWdqz+uFw1N+pcsQbY
	M0HFzu6sYArmquBA==
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
Message-ID: <20250821092827.zcFpdnNy@linutronix.de>
References: <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aKYltdkLBRZJF0Ok@slm.duckdns.org>

On 2025-08-20 09:44:53 [-1000], Tejun Heo wrote:
> Hello,
Hi Tejun,

> On Wed, Aug 20, 2025 at 12:55:18PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-08-20 12:36:59 [+0200], To Tejun Heo wrote:
> > > Subject: [PATCH] workqueue: Provide a handshake for canceling BH work=
ers
> > =E2=80=A6
> > > This will flush all BH-work items assigned to that pool.
> >=20
> > We need to flush all items because the inserted wq_barrier is at the
> > end of the queue. So if the cb_lock is dropped after
> > worker->current_func(work) then we will live lock. Just tested, I
> > somehow assumed it polls on worker.
>=20
> Is flushing all a problem tho?=20

It is not wrong as in something will explode. The priority-inheritance
boost is meant to give the lower priority task runtime in order to leave
its critical section. So the task with the higher priority can continue
to make progress instead of sitting around. Spinning while waiting for
completion will not succeed.
In this case "leaving the critical section" would mean complete the one
work item. But instead we flush all of them. It is more of semantics in
this case. That is why the looping-cancel in tasklet cancels just that
one workitem.

> I think the main focus is keeping the
> semantics matching on RT, right?

Yes, but having the semantics with busy waiting on a BH work is kind of
the problem. And there is no need for it which makes it a bit difficult.
The previous patch would match the !RT bits but we flush all work, have
and the lock for no reason. That is why I don't like it. The majority of
tasklet users don't need it. It is in my opinion bad semantics.

But if you insist on it, the previous patch will make it work and has
been tested. There is not much I can do.

> ...
> > -	if (from_cancel) {
> > +	if (from_cancel && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >  		unsigned long data =3D *work_data_bits(work);
> > =20
> >  		if (!WARN_ON_ONCE(data & WORK_STRUCT_PWQ) &&
> >  		    (data & WORK_OFFQ_BH)) {
> > -			/*
> > -			 * On RT, prevent a live lock when %current preempted
> > -			 * soft interrupt processing or prevents ksoftirqd from
> > -			 * running by keeping flipping BH. If the BH work item
> > -			 * runs on a different CPU then this has no effect other
> > -			 * than doing the BH disable/enable dance for nothing.
> > -			 * This is copied from
> > -			 * kernel/softirq.c::tasklet_unlock_spin_wait().
> > -			 */
> >  			while (!try_wait_for_completion(&barr.done)) {
> > -				if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > -					local_bh_disable();
> > -					local_bh_enable();
> > -				} else {
> > -					cpu_relax();
> > -				}
> > +				cpu_relax();
>=20
> I'm most likely missing something about RT but wouldn't the above still l=
ead
> to deadlocks if the caller is non-hardirq but higher priority thread?

Not sure what you refer to. Right now there is this lock in
local_bh_disable() which forces PI.
Removing the whole section for RT as in this snippet gets us to the
wait_for_completion() below. It lets the task with higher priority
schedule out allowing task with lower priority to run. Eventually the
barrier item completes and with the wakeup the high priority task will
continue.
So the high-priority task will lose runtime (allowing task with lower
priority to run). I don't think it will be a problem because it is
mostly used in "quit" scenarios (not during normal workload) and matches
tasklet_disable().

> Thanks.

Sebastian
