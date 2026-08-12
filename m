Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DC2C08CF;
	Wed, 12 Aug 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547301; cv=none; b=ozau0vIcwFYjl8ITd7BvfesPoJPV/+HMeIR85u2hO/xnqfUyo1WaQB1N63GOaRQnsNgF48IQ5KIoJKUGuF0wLACn/YtGNYCD3GK35QjYszpKtfrAdJyLsStblDe/uTzMGB4oZiV7jHOlNi2lJj9waXpz0Ai57AhBa/MXrjNMskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547301; c=relaxed/simple;
	bh=aRmE3zbpfSNPdir/3TWgP/hRyUVjljrKrTim96IE0b8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMjGfRBveqC9NtYUoqqUFIxOg6MdTlAJmwEJsDzUvmAY5uHXxtGB3ZROe49fdKHwwefLF1sr91JQuuMa+0aqaRr2tUaEC8ETuTTjlyenETft2wVnbUAB0rSfvbmREcc0s8i5eGgOSo9/bvb0qHtwfXY4FPRepiL/xu7rfg8mh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUboRfpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUboRfpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33771F000E9;
	Wed, 12 Aug 2026 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547300;
	bh=aRmE3zbpfSNPdir/3TWgP/hRyUVjljrKrTim96IE0b8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eUboRfpwjrbdI6EcrjLTWJ4VXHLB+M/HXviCkdh0p662gRx9dXsGmhpVirWDgh136
	 0s6KL8xMgjF2gGAcclaH5RFf9yj6I35I5x09VGkfh+wr13bKT+hHSFh7okjQwhAIfT
	 e45zChyAS2iGaCUSaWy4vlzua6tRXzrgcYP1KbC1UCM9jWo6ggaiKUvYG9LQgDXHw1
	 Bj+rYK6BPl648hseZfPWb9jOW7ukZgfLtm41aa8ALr3r2r3No0u/C0p114ikqkxKY8
	 J9Y6FOwI6KDgDQ4HySXgB1IYqJE1W80FJXAD2J+xcTA/NMmo0WPBGo/sOBhPnl0QH2
	 8wCVgxbcsxuRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] docs: timers: hrtimers: clarify expiry modes and
 ktimersd on PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liang Hao" <haohlliang@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260812145440.23528-1-haohlliang@gmail.com>
References: <20260807161929.49913-1-haohlliang@gmail.com>
 <20260812145440.23528-1-haohlliang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:08:19 +0000
Message-Id: <20260812150819.C33771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Reference to non-existent API `hrtimer_setup_sleeper()` in document=
ation.
--

--- Patch [1]: [PATCH v2] docs: timers: hrtimers: clarify expiry modes and =
ktimersd on PREEMPT_RT ---
commit 2dc8d2cd0774356027c94f2b3b606b15bca92ef3
Author: Liang Hao <haohlliang@gmail.com>

docs: timers: hrtimers: clarify expiry modes and ktimersd on PREEMPT_RT

This commit documents the PREEMPT_RT expiry-mode semantics for timers not
explicitly marked HRTIMER_MODE_HARD, explaining how they default to softirq
expiry on the ktimers thread. It also clarifies priority inheritance rules
and sleeper exceptions for RT/DL-armed timers.

> diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrt=
imers.rst
> --- a/Documentation/timers/hrtimers.rst
> +++ b/Documentation/timers/hrtimers.rst

[ ... ]

> +Priority inheritance on PREEMPT_RT is used for the cancel handshake,
> +not for the arming path; see the "Spin until ready" section of the same
> +document.
> +
> +``hrtimer_setup_sleeper()`` (used by ``clock_nanosleep()`` and similar)

[Severity: Low]
This isn't a bug, but should this refer to hrtimer_setup_sleeper_on_stack()
instead? The hrtimer_setup_sleeper() API does not appear to exist in the
source tree, as the exported API for this functionality is
hrtimer_setup_sleeper_on_stack(), which internally calls
__hrtimer_setup_sleeper().

> +is an exception: when armed by an RT or DEADLINE task it is marked
> +``HRTIMER_MODE_HARD``, so the wakeup runs in hardirq context and does
> +not go through ``ktimers/%u``.
> +
> +If callback work must run at the owning task's RT priority, either
> +mark the timer ``HRTIMER_MODE_HARD`` (and keep the callback
> +hardirq-safe) or wake a dedicated kthread from the callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812145440.2352=
8-1-haohlliang@gmail.com?part=3D1
