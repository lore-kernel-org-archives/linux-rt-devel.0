Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521657;
	b=ziUAMwB9KIjB83Lw0xVbUg/3izWmus/f2fwTXamlLKU/1ywLyHPyg3DaGp6mVH3caYpO
	 CgPp6hsiGmfM0fdhuF6J691EZIYjxgIfFhuUKrVEJYYZF+ZF0c87uD3AkLw/iHllqXxq/
	 V5eC5/m15BOoi+Uoo0dPELJ4loYWXXWhm7JJw+flvm3TU/VRnBwR9AsUfDhvfqr+OcpNL
	 yLz3HjNYdqS41DIxW0OqnOMjChL4hCJMULkveti5ToF5lDRJ7Udo0p5tbxQeIZDr7KerI
	 R4KPYNu/Z17M08u/n8ohhnsHccYF9WuJtLNnMEVBCw4gy4u9jSKt5o+V1WY54Gh6cSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=9KhTxx7Zr4hjfg7KTdE7MstkrdgDZypeK0mfiKIhiOs=;
	b=SbMaZXYzeemb+4MAqatHakZ7kY1CSeZufCbodAi9MpJwnZeAL5Np0HxDyT4HACNcEI2u
	 I/Io86/jyC5um0X3RsULNq3n+viiPBvEGEQafn+DKMfiZqZKNEWRNVvIYcioRlme3Yvdc
	 i7u20M3rjxV/SaIwCkVDUUUw5Lt1/lE+JlyaYdI2j1+ZOgiuHNcBEg1mjnKsL+wEeBW2R
	 iBe1OoXMep9V8ZZz/0WvhYvTLUuIfNN/sBIruaVEjF1mVtxZoa4JbszsDP1f1/LrNPt2R
	 5vpe7JqrNlkNmQM5qPRG7cGsnDFwRTELlnbiSnkdP8Kt5FchMa1w4mDJO1rkduetYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvwMMI7P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60345606A31C;
	Thu, 12 Nov 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvwMMI7P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2F61F000C9;
	Thu, 12 Nov 2026 22:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521657;
	bh=9KhTxx7Zr4hjfg7KTdE7MstkrdgDZypeK0mfiKIhiOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YvwMMI7PRXhf6+j5PUnskPlwa1Pr/RJadLUItvSSBIdcs8RK3zRJWfO29isaqQexw
	 yAtNMEL0ShxpoIssQl5RabhaGraEMnCn8iJAMbfDG9SjO2kUOIFCTvCXTtJlSyFAxM
	 fkPGCto0+AbuEup2wNJtIa6Z6kjuwrGxAKYK+6439yi0LQd7It47fH5X92uNOeNGbN
	 bBwiY+HXzfYdUIwtfQIafDLRUcGpaEvBc2N3h2MNXb47NLuOUrmVIJH0t5c5iQPxD5
	 jXmLyz0Zzf7eZ+NHFHVzDDs/6kzGGnvrjXvbDSUy0EATKpe0oMlsZewfoWB404oFav
	 4egUNxy+AEXNQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.dev>, Radu Rendec <radu@rendec.net>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev, Troy
 Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v2 2/2] irqchip/riscv-imsic: Complete vector moves
 without a timer
In-Reply-To: <20261112-imsic-remote-sync-irqwork-v2-2-680f65b24ff6@linux.dev>
References: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev>
 <20261112-imsic-remote-sync-irqwork-v2-2-680f65b24ff6@linux.dev>
Date: Thu, 12 Nov 2026 23:14:13 +0100
Message-ID: <87v761snnu.ffs@fw13>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 12 2026 at 07:54, Troy Mitchell wrote:
> When a vector moves, the new CPU clears move_prev only after the old CPU
> has released the old vector. If the new CPU syncs first, it arms a timer
> on itself and retries a jiffy later. That CPU is often the one entering
> idle and taking over the broadcast interrupt, with its tick already
> stopped, so the timer is not programmed.

When that timer expires _before_ the earliest programmed timer on the
remote CPU then that remote CPU is kicked out of idle to reevaluate.

So your problem description does not make any sense at all.

If the timer code fails to kick that remote CPU out for re-evaluation
then this needs to be fixed and not worked around somewhere else with
dubious claims.

> The move then completes only on the next interrupt of that CPU, which
> took up to 0.5s on an idle SpacemiT K3. Until then the IRQ is still
> marked as moving and further affinity changes of it return -EBUSY.

What's the problem with that? The notification to cleanup can be
arbitrarily long delayed. See below.

> Let the old CPU queue the sync work on the new CPU once it has released
> the old vector, and remove the retry timer. Wait only while the old
> vector still points to the new vector, since a released old vector may
> already belong to another move.

That's even more bogus. The old CPU does not queue anything.

The issue with these completely misdesigned interrupt controllers is
that the only safe way to migrate an interrupt is to do the following:

   1) Defer the affinity change to the interrupt context of the original
      target CPU.

   2) When the next interrupt arrives on the original target CPU switch
      the affinity over to the new target CPU (carefully...)

   3) If the interrupt is pending again on the original target CPU after
      switching affinity send an IPI to the new target to kick that
      vector.

   4) When the new target CPU receives the first interrupt (it does not
      matter whether it's from the device or from the IPI in #3) it
      tells the original target CPU to cleanup the stale
      associations. That's what the timer is for.

So the requirement is that the new target CPU has to receive an
interrupt to be able to release the associations on the original target
CPU and to re-enable affinity settings. This can obviously cause
arbitrarily long delays if #3 is not the case as the cleanup has to wait
for #4.

That has absolutely nothing to do with the timer and changing that to an
IPI as that only shortens the cleanup delay from _ONE_ jiffies to almost
instant. Who the hell cares?

Why is that requirement there in the first place?

  Because there neither is a guarantee that the affinity change takes
  place immediately when the update happens nor there is a guarantee
  that an interrupt message which was sent to the old CPU is delivered
  before the pending check in #3 happens. There are arbitrary device
  specific delays between the point where the device reads the target
  message and the point where it is sent and fabrics have delays too.

A lot of people spent a massive amount of time and head scratching to
come up with a solution for that especially for non-maskable MSI
interrupts.

Coming back to your change.

Of course this can be done with an IPI from the _new_ target CPU to
the _old_ target CPU, but only under one condition:

    The IPI vector cannot be higher prioritized than the to be cleaned
    up device vector.

Why?

Contrary to level interrupts which stay asserted until the interrupt
handler resets the condition, edge interrupts (e.g. PCI/MSI[-X]) are
from a device POV fire and forget. There is no guarantee that a device
waits for handler response before sending the next one.

So due to this and the arbitrary hardware (device/fabric) delays you can
end up in a situation where there is an interrupt pending either in the
old target or in the new target after #3 above or on both.

For the on both case assume that the new target CPU wins the race to
handle it and it sends the IPI to the old target CPU, which is currently
in an interupt disabled region. Once the old target CPU re-enables
interrupts it handles the highest priority interrupt first, which is the
IPI. Now the IPI handler detects that the lower priority device interrupt is
pending and retriggers the cleanup IPI on itself ---> livelock.

Sure, you can make that so that it ignores that situation and waits for
the new target CPU to re-issue the clenaup IPI on the next interrupt,
but that's still not solving the arbitrary delay problem, i.e. waiting
for that next interrupt which might take forever....

I'm still puzzled that at least _two_ decades after it was publicly
known that the x86 APIC is a design disaster hardware people still
insisted on making the same mistakes over and over. It's not only RISCV
folks, there are more insanities like that in other architectures...

But please read back on the initial IMSIC discussion which led up to
merging this driver. There is a ton of more context there which I'm not
going to repeat.

Thanks,

        tglx



