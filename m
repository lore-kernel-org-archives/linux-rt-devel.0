Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06262445ACE
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Sep 2026 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322982; cv=none; b=GsNHCO+1aEPEOQHI2LQyXER2ZvJ/eTdb2cOfcvEjdhqw7APEMYTMR8uoYV7m3mbTkbTvYZkcw2PzGpNyKEdr64Nku7L0A4xneU7UDfBiRW6b2Cvgn5e9P2tMs0ECN/w6jxNtBq3vUIL0imceixwVIOfz4xiWsT8FcrYSM05c7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322982; c=relaxed/simple;
	bh=Ui75wXekg5t2R6O9WeXZbgWA1lG0HWJSVZS3zprP3kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmoR+2tXCtyWRZN9EZ2qB03YqK/P945iX1VUiYBUacQ+sqOcqaVKfsFLHkL8Xx1ckbdY6jJAuj/CWyHYGbVIZBDnjvUFxKKV5nc/uLYF+eVG0bMmk8F8h7l4J2edZ4cIbc+8lipRqc1TTU+b7Hpf512wMiS7dfEWGEs59VNsGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FnpXE7kL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bxeKQOI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FnpXE7kL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bxeKQOI"
Date: Fri, 25 Sep 2026 09:56:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790322979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCk2YJMmvPlOCeVyko3p0KOgVHNll2SPcOMsAX/v4S4=;
	b=FnpXE7kL5K6/UocX35wpUDumPsNQzp00+AZtVlHIOqxuGNhjXZ1YOipaJyPODabsnmWamG
	GXHf69OFWiIg1SAweN8cj69//qr0F/Pf6M9WuVJbH35bACr5kPOPRD5oI50AT9mcXu/WeM
	+wfI0KsgwdRhPxHanWL8PPQEZ9Lqh25mzX4BL4iMupQKaUYnUjoQAs32o0qbf4qceY6lg2
	axFukcberRGBW+UjfqCdTToQykFm12We+mNlj3yUeWdUz1BFyjN+R4uWZ9PWYfyJAAMBys
	6/+5BwsF+kVt1ClswVT34mSdB+BrkUJSEbVfFMCB6gIL/pHmww2oCbcpkAkDEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790322979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCk2YJMmvPlOCeVyko3p0KOgVHNll2SPcOMsAX/v4S4=;
	b=0bxeKQOIAHmEZ7WslL9Nm95sVTsGrmsaeSCdqbIbeS/OJYJHnjhpJ965LtptxwDjcGoTP9
	VhoTY38gZeETcNBg==
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
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20260925075617.utJ7am6k@linutronix.de>
References: <20260924041538.52574-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260924041538.52574-1-kmehltretter@gmail.com>

On 2026-09-24 06:15:38 [+0200], Karl Mehltretter wrote:
> __irq_exit_rcu() removes HARDIRQ_OFFSET first and then runs
> hrtimer_rearm_deferred(), invoke_softirq() and wake_timersd(). This is
> interrupt exit work with interrupts disabled, but preempt_count already
> describes the interrupted task again. Everything which derives the
> context from preempt_count gets it wrong in that window:

On the return from interrupt path __irq_exit_rcu() removes
HARDIRQ_OFFSET from the preemption counter at the very top of the
function. Everything after that will get the current context reported as
TASK instead of HARDIRQ. Everything in that function, such as
invoke_softirq(), is aware of the situation and does not rely on the
counter. There are some exceptions:

>   - ftrace, perf and the ring buffer record task context and use the
=E2=80=A6
> Notes:
>     v3 also adds a pending softirq check after the final
>     preempt_count_sub(). A preempt_enable tracepoint callback can raise a
>     softirq there, after the softirq and timer thread checks. With an RCU
>     reader in that callback I saw 10 NOHZ tick-stop warnings per boot in
>     QEMU without the new check, and none on the base kernel or with the
>     check. The check wakes ksoftirqd for newly pending softirqs. Does this
>     case justify the extra check on every IRQ exit?

No, I don't think so. This is not the normal path. I would rather prefer
of not being able to attach a tracepoint to preempt_count_sub() within
__irq_exit_rcu() than this. Also one can attach a tracepoint to
tick_irq_exit() leaving you with the exact same problem. So I would
rather have __irq_exit_rcu() in a section where tracepoints can not be
attached or have the consequences that someone did that. Or maybe have
tracepoints/BPF taught to not do this here.

We may legitimately leave invoke_softirq() with pending softirqs. So you
probably for that reason mask everything out and have a few other
conditions for that reason. Does not justify it.

=E2=80=A6
>     - Rebased on tip/master c81f6d2398d0.

The hash here is not really helpful because tip/master is getting thrown
away. tip/master as of today, better yet the branch that it will be
probably applied to.

> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -197,8 +197,9 @@ return true, handles NOHZ tick state and interrupt ti=
me accounting. This
>  means that up to the point where irq_enter_rcu() is invoked in_hardirq()
>  returns false.
> =20
> -irq_exit_rcu() handles interrupt time accounting, undoes the preemption
> -count update and eventually handles soft interrupts and NOHZ tick state.
> +irq_exit_rcu() handles interrupt time accounting, handles soft interrupt=
s if
> +possible, undoes the preemption count update and finally handles the NOH=
Z tick
> +state.

Changed the ordering to the code flow. Okay.

  irq_exit_rcu() handles interrupt time accounting, eventually handles
  soft interrupts, undoes the preemption count update and handles NOHZ
  tick state.

Or leave it.

>  In theory, the preemption count could be updated in irqentry_enter(). In
>  practice, deferring this update to irq_enter_rcu() allows the preemption=
-count
> @@ -207,10 +208,13 @@ irqentry_exit(), which are described in the next pa=
ragraph. The only downside
>  is that the early entry code up to irq_enter_rcu() must be aware that the
>  preemption count has not yet been updated with the HARDIRQ_OFFSET state.
> =20
> -Note that irq_exit_rcu() must remove HARDIRQ_OFFSET from the preemption =
count
> -before it handles soft interrupts, whose handlers must run in BH context=
 rather
> -than irq-disabled context. In addition, irqentry_exit() might schedule, =
which
> -also requires that HARDIRQ_OFFSET has been removed from the preemption c=
ount.

> +Note that soft interrupt handlers must run in BH context rather than in =
hard
> +interrupt context. irq_exit_rcu() therefore replaces HARDIRQ_OFFSET with
> +SOFTIRQ_OFFSET in the preemption count while it handles soft interrupts =
and
> +puts HARDIRQ_OFFSET back afterwards, so that the remaining interrupt exi=
t work
> +is still attributed to the interrupt. HARDIRQ_OFFSET is removed before
> +irq_exit_rcu() returns because irqentry_exit() might schedule, which req=
uires
> +that HARDIRQ_OFFSET has been removed from the preemption count.

Good.

>  Even though interrupt handlers are expected to run with local interrupts
>  disabled, interrupt nesting is common from an entry/exit perspective. For
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c3729c5b284b0..efa6707edc0e9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -350,8 +350,8 @@ static inline void ksoftirqd_run_end(void)

As mentioned, the changes below look good except for the check
in __irq_exit_rcu() which feels a bit much.

Sebastian
