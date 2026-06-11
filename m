Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C0428472;
	Thu, 11 Jun 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203000; cv=none; b=adBwiOzrltEInDJho6+h/GKcUVt/NJ++kFCsfu0at1og6WegD2Vqw547aMw8KlN156hp/8xr1TFy44hJHPklTeAtD8f87ZFBbX9ZDU/G4dOZoedo/ZIIJqTp0u2NZzCjvCeWKlzVOoVcKLlyxM398zp9fW1RA6sHnBaL2fUb8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203000; c=relaxed/simple;
	bh=ken2Iegzok37VS7rS4L7enGArV1U0jxT+si9LD+Kcvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K1sHpu0iogha09lZHh0Wn0JqdA/5oLs0hbojmuKQOKwmFFzrzkzMyaRo3agUD3gP2vDpWHT4lldYvr/YkMVUCDRg6enwstaCha4v2Ma3deLxIjjeKTeKOXHzzMmJJnOrExGwys8Iz0HRCQg0c8DrUNAX1mGYWbKAJwDeNGtChK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kte+rBHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kte+rBHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D431F00A3A;
	Thu, 11 Jun 2026 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781202999;
	bh=AWmeA6er28ExgJNxgOrM2MXM2weqPhJ0z6WU1rD/EgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kte+rBHTk/OxPr+2ODVDDQbsIOcKgzk64tCLA6DPN3Z1GuJqS58TTGuFYrCHTtI7b
	 AXXGGeNmOiNIKLS4kDWZGbSPfJ2vcXFaqWw3ReuMmL5+jiuTwvpaqT3FcML3KK8u/Z
	 22/xPooO9CNzR/PlT93Ugxl4sRDp4TZFN0nUzIsvCXWS+vt4uPKjKgnFADZchUKADG
	 DoA9qruwnpRiISQypQhMc+WDFjHq/nJynzsO4tUcrqxqIiCeZZJH17TX0DzlgUlide
	 VWnj8Zkesfo9pITUjkpdYydE+SIBFWBPTDYUz+en0qwqJNGNk0Frqk45flb0q+Fmun
	 FKbqdLTrdyQdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vlad Poenaru" <vlad.wing@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260610183621.3915271-1-vlad.wing@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:36:38 +0000
Message-Id: <20260611183639.28D431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] On PREEMPT_RT, `local_bh_enable()` triggers a lockdep splat and se=
lf-deadlocks because IRQs are disabled.
- [High] The addition of `local_bh_disable()` and `_local_bh_enable()` trig=
gers a `WARN_ON_ONCE(in_hardirq())` splat when netconsole is used from hard=
irq context.

Pre-existing issues:
- [Critical] The patch fails to resolve the self-deadlock because it shifts=
 the ksoftirqd wakeup to `zap_completion_queue()`.
--

commit 5559ca23d7e6dcba4ded6d9783c2b7954c8e659f
Author: Vlad Poenaru <vlad.wing@gmail.com>

netpoll: run NAPI poll in softirq context to avoid rq->lock self-deadlock

This commit aims to prevent a self-deadlock caused by netconsole flushing
messages while holding a runqueue lock. It wraps the netpoll NAPI callback
in local_bh_disable() to ensure softirqs are not raised out of band,
deferring them instead of waking ksoftirqd inline.

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 3f4a17fa5713a..18da97eff5322 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
[ ... ]
> +	 * Disabling BH makes in_interrupt() true for the duration of the poll,
> +	 * so the TX completion only sets the softirq-pending bit and never wak=
es
> +	 * ksoftirqd. The raised softirq is harmless and benign: netpoll reaps
> +	 * the freed skbs itself via zap_completion_queue() below, and the
> +	 * pending NET_TX softirq is serviced at the next irq_exit().
> +	 */
> +	local_bh_disable();

[Severity: High]
Does adding local_bh_disable() here trigger a warning when netpoll is called
from hardirq context?

Netconsole is frequently used to flush dmesg synchronously during kernel
panics or sysrq, which occur in hardware interrupt handlers. Both
local_bh_disable() (via __local_bh_disable_ip()) and _local_bh_enable()
explicitly assert WARN_ON_ONCE(in_hardirq()).

Could this cause recursive warnings or disrupt the logging path during a
panic sequence?

>  	if (ops->ndo_poll_controller)
>  		ops->ndo_poll_controller(dev);
> =20
>  	poll_napi(dev);
> =20
> +#ifndef CONFIG_PREEMPT_RT
[ ... ]
> +#else
> +	/*
> +	 * On PREEMPT_RT this path runs with IRQs enabled and softirqs are
> +	 * threaded, so there is no IRQ-disabled, lock-holding context to
> +	 * protect. _local_bh_enable() is not available on RT, and local_bh_dis=
able()
> +	 * there takes the per-CPU softirq_ctrl local_lock that only the full
> +	 * local_bh_enable() releases -- so use it.
> +	 */
> +	local_bh_enable();

[Severity: High]
The commit message states that on PREEMPT_RT this path runs with IRQs
enabled. Is this accurate?

Looking at netpoll_send_skb(), it unconditionally calls local_irq_save(),
meaning hardware interrupts are disabled here. Calling local_bh_enable()
maps to __local_bh_enable_ip(), which enforces lockdep_assert_irqs_enabled(=
).
Will this trigger a lockdep splat?

Additionally, because IRQs are disabled, preemptible() evaluates to false.
Does the RT implementation then skip inline softirq processing and instead
fall back to wakeup_softirqd(), resulting in the exact same rq->lock
self-deadlock?

> +#endif
> +
>  	up(&ni->dev_lock);
> =20
>  	zap_completion_queue();

[Severity: Critical]
This isn't a bug introduced by this patch, but does the patch fail
to fix the self-deadlock it intends to resolve?

The fix wraps poll_napi() to ensure in_interrupt() is true, preventing
the ksoftirqd wakeup. However, zap_completion_queue() is called after
_local_bh_enable(), meaning in_interrupt() is false again.

When zap_completion_queue() processes unfreeable SKBs, it calls:

zap_completion_queue()
  dev_kfree_skb_any()
    dev_kfree_skb_irq_reason()
      raise_softirq_irqoff(NET_TX_SOFTIRQ)

Because in_interrupt() is now false, this immediately invokes
wakeup_softirqd(). Won't this attempt to acquire the CPU's rq->lock
that the caller (e.g., __schedule()) already holds, resulting in the
exact same self-deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610183621.3915=
271-1-vlad.wing@gmail.com?part=3D1
