Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794010306;
	b=eGCHEm2ZWHmG6MPapZVRWMaCdKhx/gDAToLigap0fZ6nyYLvDFPS9ijxG8B3wcG8APHu
	 DYm/61jtlcJ4/KTZHJdXHHzLJvViRTj0vH4K3OP8Euh+CuTPknVWYPz7ddqvDxjzWr4Pe
	 iC3AN095KUu7ukrvtgzJWwMHx16Ol7MSnqVTsblHau/MGkYtu83f1XlRqtmIFZZkI2Ukq
	 y3zreIvLuj+6+KQvMcQEipBk/2b8ourLzH85Zogj6rpGk7POPEfzkSVLBXB6CMdoAzXhV
	 jo5YjXLt3OeMMtisUg+BwcWtCvNZCOt6mGeCcdIVuNmEPjy14Ekn/1NrQuSnX/VbgrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794010306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O1YwaBYKL60DTpaRiHPM1BWsGMVsXcGSphhmfyChFiw=;
	b=YqLmkquh473Xvtl8zJvwH4vOUAzVxcxuCS5LB/85kPhJe4FM6phbMcvkYud5YMxnZL1S
	 e3Cfl5/7e0SJm/NRFU1S6JoTsWUU080LxZQUGeY+sNnTs7mwLHfIouDVco2GJx9WP8J9v
	 2+ABrpB37cQ7635xO++yqtgGMiKADK3mi6FfpgukeLlpwLimri4L19Xddwpbyc0oDg7vv
	 M8vCG4ANckVuyLA4WlQzkjpsVqyLd1w3qyrIgmYbRX8xALhhoiHWvQVfLlFkHBX4plU20
	 g5e5CT1TE5/7K/vgNSnCMbpAaAobGfp8AjibO5/i0Aq7eSQJafpy/+bP9mU3aPfOmZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Clpvd24C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79386606A326;
	Sat,  7 Nov 2026 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Clpvd24C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFF61F0089F;
	Sat,  7 Nov 2026 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794010306;
	bh=O1YwaBYKL60DTpaRiHPM1BWsGMVsXcGSphhmfyChFiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Clpvd24CJwr/f52xsfUXjUubKlUpHQFZqbAVRM4iNf04oRjsk4NBvcWAmEaZR81w7
	 Usw3POAgFFk04Tkpl7LHqEI2eMR5ANQ8y6dHKUgjJP9qgkhVVW7OxBJ6p1JWO4BRNA
	 NzulLkK9ETVPVQOQNoUEXg/30AyFVFGLRQtbb6M5LjbgSllZwSDrO0NitUcVSO+AHb
	 K6F8yM03WCa2kS1uqw3xNlRLAH6/UOUKLQAZUO+b+pDUQCs4lfUCWys/495lLB1Rvi
	 cixbLAuY+/u/a7vdwY6v34OutczaijoYahkBoaGh+xjdsWLBVtpHQFJNITWTcd7xPy
	 DePtqQP5QVFgQ==
Message-ID: <sashiko-outbox-202413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] locking/ww_mutex/test: Time an ABBA with both
 owners running
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261106235931.1478800-6-mathieu.desnoyers@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-6-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 00:11:45 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] locking/ww_mutex/test: missing stage ordering in
  test_abba_spin()
--

commit a75841edff4ce8ecc91baad12d6e7f770d7d72f7
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

locking/ww_mutex/test: Time an ABBA with both owners running

This commit adds a wound-wait test case to test-ww_mutex where two
SCHED_FIFO threads on separate CPUs create an ABBA contention while both
owners remain running.

> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mute=
x.c
> index 838d631544ed2..1bf3a91adfec5 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
[ ... ]
> @@ -279,6 +281,213 @@ static int test_abba(struct ww_class *class, bool t=
rylock, bool resolve)
>  	return ret;
>  }
> =20
[ ... ]
> +static bool abba_spin_until(struct test_abba_spin *s, int stage)
> +{
> +	u64 end =3D ktime_get_ns() + 5ULL * NSEC_PER_SEC;
> +
> +	while (atomic_read(&s->stage) < stage) {
> +		if (ktime_get_ns() > end)
> +			return false;
> +		cpu_relax();
> +	}
> +	return true;
> +}
[ ... ]
> +static int abba_spin_old(void *arg)
> +{
> +	struct test_abba_spin *s =3D arg;
> +	struct ww_acquire_ctx ctx;
> +	u64 t, end;
> +	int err =3D -ETIMEDOUT;
> +
> +	sched_set_fifo_low(current);
> +	wait_for_completion(&s->start);
> +	ww_acquire_init_noinject(&ctx, s->class);
> +	atomic_set(&s->stage, 1);
[ ... ]
> +static int abba_spin_young(void *arg)
> +{
> +	struct test_abba_spin *s =3D arg;
> +	struct ww_acquire_ctx ctx;
> +	int err =3D -ETIMEDOUT;
> +
> +	sched_set_fifo_low(current);
> +	wait_for_completion(&s->start);
> +	if (!abba_spin_until(s, 1))
> +		goto out;
> +	ww_acquire_init_noinject(&ctx, s->class);

[Severity: Low]
Can abba_spin_young() obtain a smaller ctx.stamp than abba_spin_old() on
weakly-ordered architectures?

ww_acquire_init() allocates ctx->stamp with
atomic_long_inc_return_relaxed(&ww_class->stamp), and s->stage is updated
and polled with relaxed atomic_set() and atomic_read():

CPU0 (abba_spin_old)              CPU1 (abba_spin_young)
ww_acquire_init_noinject()
  atomic_long_inc_return_relaxed(&s->class->stamp) [reordered]
atomic_set(&s->stage, 1)
                                  abba_spin_until(s, 1)
                                    atomic_read(&s->stage) =3D=3D 1
                                  ww_acquire_init_noinject()
                                    atomic_long_inc_return_relaxed(...)
  [stamp increment executes here]  <-- young gets the older stamp

If abba_spin_young() receives the smaller stamp, it wounds
abba_spin_old() when blocking on s->a_mutex, causing abba_spin_old()'s
ww_mutex_lock(&s->b_mutex, &ctx) to fail with -EDEADLK.  Using
atomic_set_release() and atomic_read_acquire() on s->stage would order
the stamp allocations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106235931.1478=
800-1-mathieu.desnoyers@efficios.com?part=3D5
