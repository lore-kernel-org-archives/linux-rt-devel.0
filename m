Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4181E907A
	for <linux-rt-devel@lists.linux.dev>; Fri,  8 Nov 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068275; cv=none; b=oNHDAZZweoHD18QtZ5hBTUySAGU/cO7AbFVbcZGewuWECHY7IuDvZxwwUAFmzJNswIQo4lZRHS99iQWI0xF00Fu4SB16Zvpv+ZaLy4V8mOvGxkSWYZ5mLfAC5JIpPgZmTXugubfBS49LSVHr5DBRe5I/TKvWYCqdFZBHsLPkp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068275; c=relaxed/simple;
	bh=mSjEQxcT1jzRrZG3Lk514ZG8ezGlL78HxIMrX5JBN1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEw5qukxC/xvJVidv8DirXgKjcbTrLcSSc1UbvotdFzlzLOBfC2iiw9bOMs2p0cHN4BcGRUn/vBo2taWsZOfEg3Ey88FcCWRz0O6Tr5A4ZPfLC4reJ8daZxeZhe9iVGPyLOULNilnkP4O98GWXsG0UHc5GX9wAnD3SCMrsXkHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cbhu8vG8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S15ds1pE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cbhu8vG8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S15ds1pE"
Date: Fri, 8 Nov 2024 13:17:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731068270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTSbTLRK4vrdFAfI5oV/Tg8syNe6Xf6hf6GqaudQgI0=;
	b=Cbhu8vG8c4sPPnzbO0rrenPO6MMPUDQqw9eCOQKxH8senJsatKlw22sfU6j2mR7/p2zKZe
	fUvppKI9p1CnAErQ8XNyU2DfN0eSMx4eZGjf9lcxyX58/Hen0FjUYf8su1PG4IYa4lTHri
	f2nQTwACfWyXWUXeMhZ86dDMnQ9LePMN9maE5waYjP0WByguByFuKnvw78KnAScpmMEKX4
	kKNQewWcQxlulaB+YVvLd0kkhNMkGu5cGY9D80inZkFc0C1uEe7DU+Ux3KJEoaCpD/7jUx
	2ZHAJJTsvIbxnSSwZwJ+mccc4m5R3iRoQASTAJStA4AmDr5K5daRKkiA+jS/Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731068270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTSbTLRK4vrdFAfI5oV/Tg8syNe6Xf6hf6GqaudQgI0=;
	b=S15ds1pEo3+8HOeicIjEH1qEsfo7FRGLEPmbkEql77rKojJcruiuBUt+tNLPhxT3vKhOsF
	Yt0bFxF9pTelizBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v4 3/3] sched/core: Prevent wakeup of ksoftirqd during
 idle load balance
Message-ID: <20241108121748.tGlosO1b@linutronix.de>
References: <20241030071557.1422-1-kprateek.nayak@amd.com>
 <20241030071557.1422-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241030071557.1422-4-kprateek.nayak@amd.com>

On 2024-10-30 07:15:57 [+0000], K Prateek Nayak wrote:
> Scheduler raises a SCHED_SOFTIRQ to trigger a load balancing event on
> from the IPI handler on the idle CPU. Since the softirq can be raised
> from flush_smp_call_function_queue(), it can end up waking up ksoftirqd,
> which can give an illusion of the idle CPU being busy when doing an idle
> load balancing.
>=20
> Adding a trace_printk() in nohz_csd_func() at the spot of raising
> SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
> and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
> current behavior:
>=20
>        <idle>-0   [000] dN.1.:  nohz_csd_func: Raising SCHED_SOFTIRQ from=
 nohz_csd_func
>        <idle>-0   [000] dN.4.:  sched_wakeup: comm=3Dksoftirqd/0 pid=3D16=
 prio=3D120 target_cpu=3D000
>        <idle>-0   [000] .Ns1.:  softirq_entry: vec=3D7 [action=3DSCHED]
>        <idle>-0   [000] .Ns1.:  softirq_exit: vec=3D7  [action=3DSCHED]
>        <idle>-0   [000] d..2.:  sched_switch: prev_comm=3Dswapper/0 prev_=
pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dksoftirqd/0 next=
_pid=3D16 next_prio=3D120
>   ksoftirqd/0-16  [000] d..2.:  sched_switch: prev_comm=3Dksoftirqd/0 pre=
v_pid=3D16 prev_prio=3D120 prev_state=3DS =3D=3D> next_comm=3Dswapper/0 nex=
t_pid=3D0 next_prio=3D120
>        ...
>=20
> ksoftirqd is woken up before the idle thread calls
> do_softirq_post_smp_call_flush() which can make the runqueue appear
> busy and prevent the idle load balancer from pulling task from an
> overloaded runqueue towards itself[1].
>=20
> Since the softirq raised is guranteed to be serviced in irq_exit() or
> via do_softirq_post_smp_call_flush(), set SCHED_SOFTIRQ without checking
> the need to wakeup ksoftirq for idle load balancing.
>=20
> Following are the observations with the changes when enabling the same
> set of events:
>=20
>        <idle>-0       [000] dN.1.: nohz_csd_func: Raising SCHED_SOFTIRQ f=
or nohz_idle_balance
>        <idle>-0       [000] dN.1.: softirq_raise: vec=3D7 [action=3DSCHED]
>        <idle>-0       [000] .Ns1.: softirq_entry: vec=3D7 [action=3DSCHED]
>=20
> No unnecessary ksoftirqd wakeups are seen from idle task's context to
> service the softirq.

| Use __raise_softirq_irqoff() to raise the softirq. The SMP function call
| is always invoked on the requested CPU in an interrupt handler. It is
| guaranteed that soft interrupts are handled at the end.

You could extend it

| If the SMP function is invoked from an idle CPU via
| flush_smp_call_function_queue() then the HARD-IRQ flag is not set and
| raise_softirq_irqoff() wakes needlessly ksoftirqd because soft
| interrupts are handled before ksoftirqd get on the CPU.

This on its own is a reasonable optimisation. A different question would
be if flush_smp_call_function_queue() should pretend to be in-IRQ like a
regular IPI but=E2=80=A6

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@=
inria.fr/ [1]
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v3..v4:
>=20
> o New patch based on Sebastian's suggestion.
> ---
>  kernel/sched/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index aaf99c0bcb49..2ee3621d6e7e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1244,7 +1244,18 @@ static void nohz_csd_func(void *info)
>  	rq->idle_balance =3D idle_cpu(cpu);
>  	if (rq->idle_balance) {
>  		rq->nohz_idle_balance =3D flags;
> -		raise_softirq_irqoff(SCHED_SOFTIRQ);
> +
> +		/*
> +		 * Don't wakeup ksoftirqd when raising SCHED_SOFTIRQ
> +		 * since the idle load balancer may mistake wakeup of
> +		 * ksoftirqd as a genuine task wakeup and bail out from
> +		 * load balancing early. Since it is guaranteed that
> +		 * pending softirqs will be handled soon, either on
> +		 * irq_exit() or via do_softirq_post_smp_call_flush(),
> +		 * raise SCHED_SOFTIRQ without checking the need to
> +		 * wakeup ksoftirqd.
> +		 */

/*
 * This is always invoked from an interrupt handler, simply raise the
 * softirq.
 */

should be enough IMHO. But *I* would even skip that, since it is
obvious.

> +		__raise_softirq_irqoff(SCHED_SOFTIRQ);
>  	}
>  }

Sebastian
