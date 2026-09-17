Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427AF4CDDD2
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658521; cv=none; b=Hbp+zxbkmdZk3/R8BciBeTGypVsm6xpqFeiseC5nw5t74C7p4JxEKgXf4Bp0VdhLAYIPQXNTP4y9BlM0M7M1jg4Td6AlbCVm1ho6D6MUaAUFNMQDmpNED0uFUK76XbrEs+rx99VmbxD9h4jVadSUNwfCQ4tryDJzKVhIA1GCfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658521; c=relaxed/simple;
	bh=NJRmz+N9DvAsNAtKXueQ2oLTmSCBYg0u2uP46TwvVdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg0ybt/2kgtU/LjMuuvR5UFgOTUjjgBbm5/MEI9ZQQKxXBwqgEpN5WOC2LBTBeQIcdSkK079f0S7RRM0hXf86O4Y2g9m7t1qmAagGAyHJWu0bdL2e3MimoLqszk36uUM/RQaciXCRiZzCaiirEQsgnCORyfJKenL63eS9lUxcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0qbyOChV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VL5oXdik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0qbyOChV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VL5oXdik"
Date: Thu, 17 Sep 2026 17:21:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789658512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEHBpd/JUlTRBgm143V9kNup9O7q9unjW2cPmVy5+rY=;
	b=0qbyOChV0tWUTWlURSoFo+sdWoQkE5wj808hSdrTB3aEOTAyPem8d7Gzmfs1lvG7fArYQx
	QmF9i8NrtEYN/MAA2yk+wFX/vYmnjPIp4X9Y3oE3BhQJtRjlX64ejsKOXYNQ/HpZUAlT23
	xAuV+XuuU27UM2dBGjlq8pCl1DIDl5Y3r/jn4JjfjrCZWE4miaYQp0aYf9rbqrC6i9SalB
	Aco3sZehxArsRqwariZONuhP1nLDWlt23lbRlsVnl2SUGTMeuu4FGrGV/+TK1HPSSpAucj
	GH+BhlQItdXiCJ/7P55zTcY0ziU1P6L1bTXKBMDehKKcvPwzzVUW6Rm8oBbVlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789658512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEHBpd/JUlTRBgm143V9kNup9O7q9unjW2cPmVy5+rY=;
	b=VL5oXdikz3JqxVy7Ys1BXg3W6d9n/hmiG2JDAb88fZPYgxTppbcjju/TdxAjmUkhzdW0jy
	yw7MZw1NeXS6ZNDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20260917152150.dvEKJ8B3@linutronix.de>
References: <20260905023210.82853-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260905023210.82853-1-kmehltretter@gmail.com>

On 2026-09-05 04:32:10 [+0200], Karl Mehltretter wrote:
> __irq_exit_rcu() drops HARDIRQ_OFFSET before deferred hrtimer rearm,
> entry into softirq dispatch, and timersd wakeup. The rearm, wakeup, and
> softirq entry code before softirq_handle_begin() are still on the IRQ
> return path, but in_task() reports task context.
>=20
> Context-sensitive code called from this window therefore sees task
> context. ftrace records normal-context flags and selects its normal
> recursion slot. KCSAN attributes IRQ-exit accesses to the interrupted
> task, while KMSAN can select and modify that task's metadata.

The breakage is limited to KCSAN & friends within the window during
transition to softirq and out. There is nothing else? Well, the timer
wake looks wrong in trace, noted.

=E2=80=A6
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -481,15 +481,35 @@ void __local_bh_enable_ip(unsigned long ip, unsigne=
d int cnt)
>  }
>  EXPORT_SYMBOL(__local_bh_enable_ip);
> =20
> -static inline void softirq_handle_begin(void)
> +static inline bool softirq_handle_begin(void)
>  {
> -	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +	bool from_hardirq =3D in_hardirq();
> +
> +	if (!from_hardirq) {
> +		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +		return false;
> +	}
> +
> +	/* Replace the retained hardirq context with normal softirq context. */

/*
 * This is only entered on return from interrupt. Preemption disabled
 * locations remains unchanged, the context (-HARDIRQ +SOFTIRQ) is
 * updated and lockdep is let known.
 */

> +	__preempt_count_add((int)SOFTIRQ_OFFSET - (int)HARDIRQ_OFFSET);
The casts look odd. We need this? It is defined as long, yes, but
preempt_count accepts an int only so it will throw the upper bits away.

> +	WARN_ON_ONCE(softirq_count() !=3D SOFTIRQ_OFFSET);

I think we want to ensure that irq_count() =3D=3D SOFTIRQ_OFFSET

at this point. Only the lower preemption bits may differ, everything
else should be as we expect it. softirq_count() would drop the HARDIRQ
bits.

> +	lockdep_softirqs_off(_RET_IP_);
> +
> +	return true;
>  }
> =20
> -static inline void softirq_handle_end(void)
> +static inline void softirq_handle_end(bool from_hardirq)
>  {
> -	__local_bh_enable(SOFTIRQ_OFFSET);
> -	WARN_ON_ONCE(in_interrupt());
> +	if (!from_hardirq) {
> +		__local_bh_enable(SOFTIRQ_OFFSET);
> +		WARN_ON_ONCE(in_interrupt());
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(softirq_count() !=3D SOFTIRQ_OFFSET);
> +	lockdep_softirqs_on(_RET_IP_);
> +	__preempt_count_sub((int)SOFTIRQ_OFFSET - (int)HARDIRQ_OFFSET);
> +	WARN_ON_ONCE(!in_hardirq());

that is quite some WARN_ON_ONCE. We would like to see just
HARDIRQ_OFFSET at the end. Or SOFTIRQ_OFFSET before the end. One should
be enough or the math is wrong.

>  }
> =20
>  static inline void ksoftirqd_run_begin(void)
> @@ -740,6 +761,8 @@ static inline void wake_timersd(void) { }
> =20
>  #endif
> =20
> +#define IRQ_EXIT_TIMERS	(NMI_MASK | HARDIRQ_MASK)
> +
>  static inline void __irq_exit_rcu(void)
>  {
>  #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
> @@ -748,8 +771,7 @@ static inline void __irq_exit_rcu(void)
>  	lockdep_assert_irqs_disabled();
>  #endif
>  	account_hardirq_exit(current);
> -	preempt_count_sub(HARDIRQ_OFFSET);
> -	if (!in_interrupt() && local_softirq_pending()) {
> +	if (irq_count() =3D=3D HARDIRQ_OFFSET && local_softirq_pending()) {

irq_enter_rcu() did preempt_count_add(HARDIRQ_OFFSET), did record
task_struct::preempt_disable_ip. Due to the split, it does not recording
the softirq handling as disabling preemption point but keeps the
original until the end. This looks like an improvement.

>  		/*
>  		 * If we left hrtimers unarmed, make sure to arm them now,
>  		 * before enabling interrupts to run softirq.
> @@ -759,9 +781,11 @@ static inline void __irq_exit_rcu(void)
>  	}
> =20
>  	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
> -	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
> +	    local_timers_pending_force_th() &&
> +	    (preempt_count() & IRQ_EXIT_TIMERS) =3D=3D HARDIRQ_OFFSET)

Why is this preempt_count() instead irq_count(). Why is there
IRQ_EXIT_TIMERS? It is almost as the first check except now we would
like to ignore the additional softirq_count().

>  		wake_timersd();
> =20
> +	preempt_count_sub(HARDIRQ_OFFSET);
>  	tick_irq_exit();
>  }
> =20
>=20
> base-commit: 2af470916a208b576ac9975d221d9a378cf8ace9

Sebastian
