Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E93E763E;
	Thu, 15 Oct 2026 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053082; cv=none; b=EwBAEFPD3l6/50EXcqyDcf6lZ2VKtxrjNhbTqtw5qFUrCUd84M7irESbQp7ualY5tjrLdo1HjLwoOVaGss3GDrqd/sYWXzyAkUQXpamE4TaAQnIYIAwAXIT8RegR+KbAe8YP1WSW0tcvqsziQ0pD+kJimGHSluR1xgqz++tjmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053082; c=relaxed/simple;
	bh=Pcg0uLDWATDMHyw1tpnJfI4xW6R0Vn9AOSggytLRyhM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aXheVbXMHbQhpxjTSML8GDMh2ol0arif2Rt6QRvq/s2z69UOVw+FyzFmdjupqxXuSCfztLqLCCERHGa/h9kGS0dv0urgBBxge5GpkPMN3I2Ro0Hq97vJoEEPFoOifnNzQLtQ1MIA2ctk4dd8eimwWpspJXYdR5zPnMRuVjFr31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnFecq4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnFecq4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4F71F000C4;
	Thu, 15 Oct 2026 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053080;
	bh=b2PBGZPvNQJMl05graDk2sfalTQtk5hjDTcVNq6mwz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bnFecq4/cGTsmNuCjYUwrg5PikKi/Dy+8I81NzyNcsNuekm7hHuDViUELH3E6I5Um
	 BuLf/s7MIH5f3uWddScvpMURRzopV7AeyJGua0dsOK8e0w/Lez1txiNkvk3+ausq7k
	 IKYS1JbGdNDEOC47r/my78fBUatY/LvslbmuZB2JWs01zrTPJsW0xWITlecwbi2SpO
	 HReKQb3j0cr7E0gTry5SVDAd2uKvrrGjz6RuubvjCm2EG9m81Y8R0h+4/8YQSjDssE
	 ePef6egNbZXiUvp322PTQ3JaszjlSTWei6gLsaDcd8djhPCqljcJAgJMRBTdXYdHM0
	 pSL4i0Pn9NVOw==
Message-ID: <sashiko-outbox-172497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/6] rust: Introduce interrupt module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261015-spinlock-irq-6-18-v1-2-72c58975994e@google.com>
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
 <20261015-spinlock-irq-6-18-v1-2-72c58975994e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:31:19 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] rust: docs falsely claim local_interrupt_disable is no-op on !PR=
EEMPT kernels
- [Medium] rust: interrupt: missing #[must_use] on LocalInterruptDisabled g=
uard
- [Low] rust: missing // INVARIANT: comment for LocalInterruptDisabled
- [Low] rust: redundant FFI helper for out-of-line local_interrupt_disable()
--

commit d5f70a73a2c90b91e9114a20f641c084d5e70a96
Author: Lyude Paul <lyude@redhat.com>
rust: Introduce interrupt module

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts along with the
ability to annotate functions as expecting that IRQs are already
disabled on the local CPU.

Link: https://patch.msgid.link/20260807070218.27144-15-boqun@kernel.org

> diff --git a/rust/helpers/interrupt.c b/rust/helpers/interrupt.c
> new file mode 100644
> index 0000000000000..69595498620f5
> --- /dev/null
> +++ b/rust/helpers/interrupt.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/spinlock.h>
> +
> +__rust_helper void rust_helper_local_interrupt_disable(void)
> +{
> +	local_interrupt_disable();
> +}
> +
> +__rust_helper void rust_helper_local_interrupt_enable(void)
> +{
> +	local_interrupt_enable();
> +}

[Severity: Low]
This isn't a bug, but are these C FFI wrappers necessary? According to
the subsystem rules, rust/helpers/ should only be used to export inline
functions or function macros.

Looking at kernel/softirq.c, local_interrupt_disable() and
local_interrupt_enable() are unconditionally implemented as out-of-line
functions across all configurations. Could we expose them directly via
bindgen by including <linux/interrupt_rc.h> in
rust/bindings/bindings_helper.h instead of adding redundant boilerplate?

[ ... ]

> diff --git a/rust/kernel/interrupt.rs b/rust/kernel/interrupt.rs
> new file mode 100644
> index 0000000000000..a880ec3b8538a
> --- /dev/null
> +++ b/rust/kernel/interrupt.rs

[ ... ]

> +/// # Invariants
> +///
> +/// Local processor interrupts are disabled on preemptible kernels for a=
s long as an object of this
> +/// type exists.
> +pub struct LocalInterruptDisabled(NotThreadSafe);

[Severity: Medium]
Should this struct be marked with #[must_use]?

Because LocalInterruptDisabled implements Drop to call
local_interrupt_enable(), if a caller forgets to bind the returned guard to
a variable:

    local_interrupt_disable();

the guard will be dropped instantly at the semicolon. This would
unintentionally re-enable interrupts immediately, leaving the intended
critical section unprotected against interrupts.

> +
> +/// Disable local processor interrupts on a preemptible kernel.
> +///
> +/// This function disables local processor interrupts on a preemptible k=
ernel, and returns a
> +/// [`LocalInterruptDisabled`] token as proof of this. On non-preemptibl=
e kernels, this function is
> +/// a no-op.

[Severity: Medium]
Does this accurately describe the behavior on non-preemptible kernels?

Looking at the C implementation in kernel/softirq.c:local_interrupt_disable=
(),
it unconditionally calls local_irq_save(flags). This always disables
hardware interrupts regardless of CONFIG_PREEMPT or CONFIG_PREEMPT_RT.

Could this documentation mislead developers into assuming the function
has zero cost on non-preemptible kernels, while it actually degrades
interrupt latency?

> +///
> +/// **Usage of this function is discouraged** unless you are absolutely =
sure you know what you are
> +/// doing, as kernel interfaces for Rust that deal with interrupt state =
will typically handle local
> +/// processor interrupt state management on their own and managing this =
by hand is quite error
> +/// prone.
> +#[inline]
> +pub fn local_interrupt_disable() -> LocalInterruptDisabled {
> +    // SAFETY: It's always safe to call `local_interrupt_disable()`.
> +    unsafe { bindings::local_interrupt_disable() };
> +
> +    LocalInterruptDisabled(NotThreadSafe)

[Severity: Low]
This isn't a bug, but should this construction have an // INVARIANT: commen=
t?

The subsystem guidelines mandate that when a struct with an # Invariants
documentation section is constructed, the code should have an // INVARIANT:
comment explaining why the invariants are satisfied.

[ ... ]

> +impl LocalInterruptDisabled {
> +    /// Assume that local processor interrupts are disabled on preemptib=
le kernels.
> +    ///
> +    /// This can be used for annotating code that is known to be run in =
contexts where local
> +    /// processor interrupts are disabled on preemptible kernels. It mak=
es no changes to the local
> +    /// interrupt state on its own.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For the whole life `'a`, local interrupts must be disabled on pr=
eemptible kernels. This
> +    /// could be a context like, for example, an interrupt handler.
> +    #[inline]
> +    pub unsafe fn assume_disabled<'a>() -> &'a LocalInterruptDisabled {
> +        const ASSUME_DISABLED: &LocalInterruptDisabled =3D &LocalInterru=
ptDisabled(NotThreadSafe);

[Severity: Low]
Similarly, should this construction also include an // INVARIANT: comment?

> +
> +        // Confirm they're actually disabled if lockdep is available
> +        // SAFETY: It's always safe to call `lockdep_assert_irqs_disable=
d()`.
> +        unsafe { bindings::lockdep_assert_irqs_disabled() };
> +
> +        ASSUME_DISABLED
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-spinlock-i=
rq-6-18-v1-0-72c58975994e@google.com?part=3D2
