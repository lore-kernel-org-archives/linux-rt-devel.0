Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472518;
	b=m79i7AISEhdctEZ+LTjpyakBnlY22Q08UM+RlKx4D7+OYpHNGSo7dbecYndXG2UKTsBT
	 hi39wMvXx0qZaDUr0A4uoYTcPDQaq+l4v24Rf6hog51wCPglMe7TKx5fD8gqdxwaI6dSw
	 Nj9+NV/E4vxE7DnVy76H8r7C5MQyM+5PS0El0ghUPKhse0UFRrvjFsal58FO2BQaexRPT
	 3Y6JAE3aUyqjg5QwhJSgSJgnt4u2bGnh3MGiB7o3C4hDnz/dBwIEdWxGLYKdx+fNCoXTO
	 wTF52OTRLuydoqVRlQCK3RUwEH5pTLBxufBaijJ2JAVpEstRErFqSEiPIBj1sdDH8Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472518;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=thYjGMCcQahnwH6w61hdDqOfxPW/G3rPGhil4Sq0LIM=;
	b=SigGL6rc/QccVIOtS987+guZA+Q3lHBGWyOFC6MIxBBYlGY9UsYrRmyYMXg8mjLYBFzx
	 UqFpnwjgoUBg6m8MTQi/RqEmeiowBQkop+1iBYF9lMmJ+AoNpa4QIcDhGfKanJQHeWikl
	 N/XjwGgQnoty7R30bD8nXTrbucETLOlSWzAsOlH3K+b7MmkIn7VEoEkSZzOeBQ9fxKm2f
	 Ucb+zg+2qZ/uNkABoIvsy1GGJFEAuaU+MGdPSJdc+Fwtd/k3f3pUoOrl58yMVWFzvS4r7
	 2PCtBrfz8DNOQDb5L3R/yCHvlyRjybAs6ttG/qsmURlm7QhVZqa9pKNnyuAycMIH2zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2IMod4C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647B606A33D;
	Thu, 12 Nov 2026 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2IMod4C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507041F00A06;
	Thu, 12 Nov 2026 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472517;
	bh=thYjGMCcQahnwH6w61hdDqOfxPW/G3rPGhil4Sq0LIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2IMod4CB+R5XGxG4VOYHZciiXdHL6Vy4RLeqQqLsfcyzMdr/A0y6aBUf4uEKiaXB
	 xk215SPm+75NuyOmu2tafTSs3En0QxuTjDPpSOVcVRpI7gdpExTrEt1rpdYOlmg2ai
	 s6NkwPomdOOg92LlYU/n2K7liO+046LjTg+bNzskvdT6HDb10jAczHuFHuHg/+dilR
	 yesffkgDUJeT9f1IuTWi8boP4ukqPXtkwnncCqoy1cvKB7DeYuUQ5x14TkGp0phWQ1
	 XmP2vQ7y1qvmrZ9HtOFYnmv+zdGXepioz6J7dUn35z8QHMKuIMQKF1jQZm+bahFU7p
	 JsO8zT6QhTMfQ==
Message-ID: <sashiko-outbox-210743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] irqchip/riscv-imsic: Complete vector moves
 without a timer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Troy Mitchell" <troy.mitchell@linux.dev>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261112-imsic-remote-sync-irqwork-v2-2-680f65b24ff6@linux.dev>
References: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev>
 <20261112-imsic-remote-sync-irqwork-v2-2-680f65b24ff6@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:35:16 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] irqchip/riscv-imsic: imsic_remote_kick() in
  __imsic_local_sync() wakes idle CPU
- [Low] irqchip/riscv-imsic: missing Fixes trailer for commit
  0f67911e821c
--

commit 41f6c7fe40c982e58c49f5640f84619e2a018221
Author: Troy Mitchell <troy.mitchell@linux.dev>

> irqchip/riscv-imsic: Complete vector moves without a timer
>
> When a vector moves, the new CPU clears move_prev only after the old CPU
> has released the old vector. If the new CPU syncs first, it arms a timer
> on itself and retries a jiffy later. That CPU is often the one entering
> idle and taking over the broadcast interrupt, with its tick already
> stopped, so the timer is not programmed. The move then completes only on
> the next interrupt of that CPU, which took up to 0.5s on an idle
> SpacemiT K3. Until then the IRQ is still marked as moving and further
> affinity changes of it return -EBUSY.
>
> Let the old CPU queue the sync work on the new CPU once it has released
> the old vector, and remove the retry timer. Wait only while the old
> vector still points to the new vector, since a released old vector may
> already belong to another move.
>
> IMSIC synchronization no longer depends on a timer.
>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>

[Severity: Low]
This fixes a bug in the two-step vector move synchronization and local
retry timer.  Should it include a Fixes tag?

  Fixes: 0f67911e821c ("irqchip/riscv-imsic: Separate next and previous poi=
nters in IMSIC vector")

> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index f6373e4019a22..36f4b7ede76a5 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c

[ ... ]

> @@ -151,13 +164,13 @@ static bool __imsic_local_sync(struct imsic_local_p=
riv *lpriv)
>  		mvec =3D READ_ONCE(vec->move_prev);
>  		if (mvec) {
>  			/*
> -			 * If the old vector has not been updated then
> -			 * try again in the next sync-up call.
> +			 * If the old vector has not been updated then keep
> +			 * this vector dirty. The old CPU kicks this CPU once
> +			 * it has updated the old vector. A released old vector
> +			 * may already belong to another move.
>  			 */
> -			if (READ_ONCE(mvec->move_next)) {
> -				ret =3D false;
> +			if (READ_ONCE(mvec->move_next) =3D=3D vec)
>  				continue;
> -			}
> =20
>  			WRITE_ONCE(vec->move_prev, NULL);
>  		}
> @@ -199,30 +212,15 @@ static bool __imsic_local_sync(struct imsic_local_p=
riv *lpriv)
> =20
>  			WRITE_ONCE(vec->move_next, NULL);
>  			imsic_vector_free(vec);
> +
> +			/* Let the new CPU finish the move it may be waiting for */
> +			imsic_remote_kick(mvec->cpu);
>  		}

[Severity: Medium]
Does calling imsic_remote_kick(mvec->cpu) here wake the destination CPU
out of cpuidle right after it takes over the broadcast timer?

When CPU1 enters a timer-stop idle state and moves the broadcast IRQ to
itself via cpuidle_enter_state() -> tick_broadcast_enter(), it runs
__imsic_local_sync() synchronously while CPU0 is still processing its
sync_work IPI:

CPU0                              CPU1
                                  cpuidle_enter_state()
                                    tick_broadcast_enter()
                                      ...
                                        imsic_vector_move(old_vec, new_vec)
                                          imsic_vector_move_update(old_lpri=
v, ...)
                                            imsic_remote_kick(CPU0)
                                          imsic_vector_move_update(new_lpri=
v, ...)
                                            __imsic_local_sync(new_lpriv)
                                              /* mvec->move_next =3D=3D vec=
 */
                                              /* leaves new_vec->move_prev =
set */
                                    target_state->enter()
imsic_local_sync_work()
  ...
    WRITE_ONCE(vec->move_next, NULL)
    imsic_vector_free(vec)
    imsic_remote_kick(CPU1)       <-- IPI wakes CPU1 from idle

CPU1 has already enabled new_vec->local_id in its local EIE CSR during its
own __imsic_local_sync(), so the IPI wakes CPU1 out of wfi or
riscv_sbi_hart_suspend() solely to clear new_vec->move_prev, forcing it
through tick_broadcast_exit() and another idle entry cycle.

In addition, cpuidle_enter_state() keeps local IRQs disabled on CPU1 from
before tick_broadcast_enter() until after target_state->enter() and
tick_broadcast_exit().  Until CPU1 re-enables IRQs and services the IPI,
new_vec->move_prev remains non-NULL, so if a third CPU enters
tick_broadcast_enter() with an earlier expiry during that window,
imsic_irq_set_affinity() still sees imsic_vector_get_move() !=3D NULL and
returns -EBUSY.

Finally, when imsic_vector_move() runs on old_vec->cpu (such as from
tick_handle_oneshot_broadcast() or imsic_irq_ack() -> irq_move_irq()), the
first imsic_vector_move_update(old_lpriv, ...) runs __imsic_local_sync()
synchronously and calls imsic_remote_kick(new_vec->cpu) before the second
imsic_vector_move_update(new_lpriv, ...) has set new_vec->move_prev or
marked new_vec dirty, kicking new_vec->cpu twice.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-imsic-remo=
te-sync-irqwork-v2-0-680f65b24ff6@linux.dev?part=3D2
