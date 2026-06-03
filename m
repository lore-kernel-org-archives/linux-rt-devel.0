Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836973FE668
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473426; cv=none; b=Cp24nHZ4HNeeX22+SzevTHZoFccI9ynz7URdRAEYBJ66WV6hdB18TGunWLKjf4CVigrRaQP06zKOBaG5fZEh7AsVHE61dObz94RN2H6bBokn8zrCQQYiXtDUSm6EDyj4tWy+KOaXZSa/trSxzC1ji5XC9F17BBkrNSIxhCGUJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473426; c=relaxed/simple;
	bh=BeCP2SNOICSdCqy7JewkAe+iVgTCvnQP7YFQ7TT8i/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUJmvO7OcL7Aefpf5UUE8LmpB5EIR112vt9xdP/Wt24fVu8R9ABApucuTQN0VBwVb1T6KMMhc1xlUPSJ5CDSHfr6+ATX0kbM8y0qLm6LY0xkRZVdZCd9b/7pFhMc2ttwYg+07yW8u7LN3bGop4PJNSd66/HJZSN4597zKsLo2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKtxqvhA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZBhtFdq3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKtxqvhA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZBhtFdq3"
Date: Wed, 3 Jun 2026 09:56:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780473418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr8+S9/C1qzItVzRxEn3nWzdZxWKVaN+cU+OzXuI3AQ=;
	b=eKtxqvhAICqDuumHL4moZJ7a7S8rPzIY8vsC+RNu0YakaaBBfvFpeRS84iI4c6W3si3h+U
	VCITK47vdVDdTeb1ig0OJmLZ7z/PWzASo2bdKPyq+3w42Js5DtjoTFzKMw8lWXk9EV0je7
	qxH/UVZLcSV7bCDFKUEoFYgBx2RjTLbOE12LnWiuaYhVpz6ohf75sDxPEsnc1J6/cOXhGe
	nvq/gX2WzfkObSh4ECpNdE2jAnjscViceEZng+V+rdOW5hk1D6rn/JB7x9ySXmcB6h6U8H
	wYA3P4WCC2DgYBoz2jLh5pUyyAVdCK/ZAbHy0qcrqnkEj7WwHdHdH3IjqITvGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780473418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr8+S9/C1qzItVzRxEn3nWzdZxWKVaN+cU+OzXuI3AQ=;
	b=ZBhtFdq3X80kbO/U0yWFpli4CqdvVhBPfCbM1sk/LvdcDCCmVbR5yfX1WDd6C0XsU2oZNo
	WJ+hPJywMhhS7MCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH-tip v3] debugobjects: Don't call fill_pool() in early
 boot non-task context
Message-ID: <20260603075656.S1aZM9PO@linutronix.de>
References: <20260520201509.931905-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260520201509.931905-1-longman@redhat.com>

On 2026-05-20 16:15:09 [-0400], Waiman Long wrote:
> When booting a debug PREEMPT_RT kernel on an arm64 system with grace
> processor, the following lockdep warning was reported during early boot.
>=20
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   WARNING: inconsistent lock state
>   7.1.0-rc4-test+ #1 Not tainted
>   --------------------------------
>   inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>   swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>   ffff0000803346a0 (&n->list_lock){?.+.}-{3:3}, at: get_from_partial_node=
+0x74/0xa0
>     :
>   Call trace:
>     :
>    rt_spin_lock+0xa0/0x400
>    get_from_partial_node+0x74/0xa0
>    ___slab_alloc+0x94/0x4f8
>    kmem_cache_alloc_noprof+0x2d4/0x598
>    kmem_alloc_batch+0x54/0x170
>    fill_pool+0x12c/0x438
>    debug_objects_fill_pool+0x58/0x60
>    debug_object_activate+0xfc/0x3d0
>    add_timer_on+0x250/0x3a0
>    add_interrupt_randomness+0x2d4/0x340
>    handle_percpu_devid_irq+0x2e0/0x4e0
>    handle_irq_desc+0xc0/0x120
>    generic_handle_domain_irq+0x20/0x40
>    __gic_handle_irq_from_irqson.isra.0+0x3c4/0x708
>    gic_handle_irq+0x7c/0xe0
>    call_on_irq_stack+0x30/0x48
>    do_interrupt_handler+0x134/0x158
>    el1_interrupt+0x48/0xb0
>     :

What about:

  During early boot, interrupts are getting enabled before the scheduler
  is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
  can fire and attempt to fill the pool from within the hardirq. This can
  lead to a deadlock the interrupt occurred while in the memory allocator.
 =20
  Reorder the exception rule and forbid this scenario by excluding
  allocations from hardirq.

=E2=80=A6
> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTE=
M_SCHEDULING")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
=E2=80=A6
>  	/*
>  	 * On RT enabled kernels the pool refill must happen in preemptible
> -	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
> -	 * on the fact that spinlock_t and raw_spinlock_t are basically the
> -	 * same type and this lock-type inversion works just fine.
> +	 * context and not enqueued on an rt_mutex or in task context during
> +	 * early boot before scheduling starts.
> +	 *
> +	 * For !RT kernels we rely on the fact that spinlock_t and
> +	 * raw_spinlock_t are basically the same type and this lock-type
> +	 * inversion works just fine.
>  	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING =
||
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> +	    (system_state < SYSTEM_SCHEDULING && in_task()) ||
>  	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
>  		/*
>  		 * Annotate away the spinlock_t inside raw_spinlock_t warning

I updated the comment to explain in more verbose why this and that is
done.
I re-ordered the whole thing stared with the pi-locked-on part since
this is always valid. It shouldn't happen during early boot I think it
is easier to read that way. Then we restrict it to the preeptible case
which can be overruled with the SYSTEM_SCHEDULING exception however as
long as it is not an hardirq. It looks easier to parse and hopefully
brings an end to this.

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b18a682fe3da2..2adfe2a79a086 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -736,12 +736,17 @@ static void debug_objects_fill_pool(void)
=20
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
-	 * on the fact that spinlock_t and raw_spinlock_t are basically the
-	 * same type and this lock-type inversion works just fine.
+	 * context and not while blocking on a lock which can trigger recursion
+	 * during PI. During system boot (before scheduling) preemption is
+	 * disabled and the pool gets exhausted. Without scheduling a deadlock
+	 * is not possible if allocations from interrupt context are excluded.
+	 * For !RT kernels we rely on the fact that spinlock_t and
+	 * raw_spinlock_t are basically the same type and this lock-type
+	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
-	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
+	    !debug_objects_is_pi_blocked_on() &&
+	    (preemptible() || (system_state < SYSTEM_SCHEDULING && !in_hardirq())=
)) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
Sebastian
