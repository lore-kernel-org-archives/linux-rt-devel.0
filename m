Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F0393DC7;
	Tue,  4 Aug 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856372; cv=none; b=tRUyT8xcwMyu8vCQzav8Y8po1paaXsPzh9R65AUoAoIYopYGdQVyUGDwqNv1fmJPQxrg9Gd7lWPmpx+A1VoBNJYjVKs/2eG3GWSmLGDwITX7l4J5qzFaO89uvkbHq67Zs14YH101K9IUQ63o5MDBdcbyb3ZQauflXvT103gMaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856372; c=relaxed/simple;
	bh=wd17nCm0G1BsKneBnn867vor45Jwq7191cRoZPYEZ+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rMFyjFqZGsGxyzIgJHpJkVIh+o2z5UKS8Kky9wBpTupTELa3ifQV1t/JcVRfoehnHKSMVqH3BxLyffrAYSEpz/Rs0kOFXNkF8H+K0RZHi2LW7KTU9X/dxe+51ShhKkDwDnPfZmN5cRRJLaw2fa+vHlk4Wjur3zS5XF+BCcwVCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPX40sdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPX40sdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649741F000E9;
	Tue,  4 Aug 2026 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785856370;
	bh=wd17nCm0G1BsKneBnn867vor45Jwq7191cRoZPYEZ+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CPX40sdm4LZfGgga3caYx8PQZa7oRnJ5IA7a8czvloRIx1cU46fzPNDzIK6BIsXub
	 oQwf655lCuoDxp9sC2zadgyuohAsujlK40ol1vlHZb35W5c6araS/9kd6ISYel5jFV
	 FC9yolbenUtvX0KP8KQKm/qzA+aYVt7RjqdoLUuwci2ienhpNpMKl0ThKAQlFIE/V+
	 vvqtcrnP0QuUCio8g7V0Zm06rUKnV6bvJlY6PDmHiJGkhX37PU8ifVYF48hefm9sJ8
	 No2eunbCIAvWqwP90fjMV1y/Df4g1u1YYnGiKoItWXyOOy2nlqMpbwC9mtsIId9um9
	 LV5a5f4jtnABg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] pinctrl: stm32: program the EXTI mux from .alloc
 instead of .activate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ju Nan" <junan76@163.com>
Cc: lee@kernel.org, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260804141402.86911-2-junan76@163.com>
References: <20260803061718.43210-1-junan76@163.com>
 <20260804141402.86911-2-junan76@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:12:49 +0000
Message-Id: <20260804151250.649741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing hardware spinlock serialization when restoring `irqmux` in=
 the resume path.
- [Medium] Missing cleanup of `irqmux_map` reservation and hardware mux sta=
te when parent IRQ domain allocation fails.
- [Medium] HWSPNLCK_TIMEOUT is defined as microseconds but passed to a func=
tion expecting milliseconds.
--

--- Patch [1]: [PATCH v3] pinctrl: stm32: program the EXTI mux from .alloc =
instead of .activate ---
(Note: The format of this report has been altered to provide a free-form su=
mmary
without quoting the original patch, due to recitation restrictions.)

commit a303f103b81b7e7b2ea355f3dc199454d3911bbc
Author: Ju Nan <junan76@163.com>

pinctrl: stm32: program the EXTI mux from .alloc instead of .activate

This commit moves the programming of the EXTI interrupt multiplexer from the
.activate callback to the sleepable .alloc callback. This prevents a wait
context violation on PREEMPT_RT caused by a spinlock-protected regmap access
in the syscon driver. It also ensures the EXTI mux write is serialized with=
in
the existing irqmux_lock section.

Closes: https://lore.kernel.org/all/20220202174430.pf37tt6lua2op3gc@pengutr=
onix.de/
v2: https://lore.kernel.org/all/20260804032227.35017-3-junan76@163.com/
v1: https://lore.kernel.org/all/20260803061718.43210-1-junan76@163.com/

[Severity: Medium]
This is a pre-existing issue, but in stm32_gpio_domain_alloc(), if
irq_domain_alloc_irqs_parent() fails, the function directly returns the err=
or
without reverting the irqmux_map reservation or the hardware state.

Because the core IRQ subsystem does not invoke the .free callback for a
domain that fails mid-allocation, doesn't this result in the irqmux_map bit
remaining permanently set and the hardware EXTI mux remaining incorrectly
programmed for an abandoned allocation?

[Severity: Medium]
This is also a pre-existing issue, but when hwspin_lock_timeout_in_atomic()=
 is
called in stm32_gpio_domain_alloc(), HWSPNLCK_TIMEOUT is passed as the time=
out
argument.

Since HWSPNLCK_TIMEOUT is defined as 1000 microseconds, but the timeout
parameter expects milliseconds (using msecs_to_jiffies), doesn't this result
in a 1-second timeout instead of a 1-millisecond timeout?

Spinning for 1 second in an atomic context could potentially trigger lockup
detectors if the lock is heavily contended.

[Severity: High]
This is another pre-existing issue, but in stm32_pinctrl_restore_gpio_regs(=
),
the irqmux is reprogrammed using regmap_field_write() without holding the
hardware spinlock.

Since stm32_gpio_domain_alloc() correctly serializes access to the shared
EXTI register against the coprocessor by acquiring pctl->hwlock, doesn't the
unprotected write in the resume path risk a data race and potential hardware
register corruption if the coprocessor contends for it concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804141402.8691=
1-2-junan76@163.com?part=3D1
