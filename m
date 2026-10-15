Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4B489FAB;
	Thu, 15 Oct 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053052; cv=none; b=WVNcEo0nz4Gmp7vgue7HB/nY9if3A6l7qsj2innl9hWV7IKcn4LKTuMu8iHvaKl/kcNDtn3aBk1kEsvbS/fEKMrzqNFjU/taEZ+p5/sTMnzc29l1yiouMLITsQsuKt0wSvZc6N9z+sHvg5cLbpEr/tTyhwDZTuJWGZTaaLzcmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053052; c=relaxed/simple;
	bh=z8IU1fkEgp1290t/w/Z/ySFFzsb8vyPLQ7ok1wOZys8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E0IBkXx4m0VtB5vAYtZmEcRET/U0aFZNqDvgMbRMkj0nLnkRe5RWRvR2biRVibpgUISPTOICFObLgTNwDRLS8hIvPnQlb0ff2WoEiapVh2o05wWTtvXQHXo1ZONbzHuwL2V8x33Qjus+MSsbM/F5N3nm9xXFpg1F6jmnz8xrGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHfvrsEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHfvrsEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FD91F000C4;
	Thu, 15 Oct 2026 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053049;
	bh=m9ift2F/lZr6q7gHusFTJVZXU4O1x8N8mEICyyr5xAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHfvrsEUIqkh1h9bYyLL5L69phWVTEamO8ZGAd2YH2dlTtqeo8O4Y0J4lzG7rhW9Q
	 ObCmY/WoUarZgpRSuAO3Qzm1vUSDUaCE54dj7nA7YY4hM8nG9BtrTF+VKtvul52jEn
	 KabJzHXhRk5a20gOkJC76i+6TOpr6umwFwJuAwF5wo7zl2vThioyf1I53ZnxDaYpO4
	 b4kRxSXyMW7lQBWaF2HctIU02kR2Yj4LO6JuF+IkPfRuPSjveZXvsshmqmztWDE0J/
	 cciVApMcaYE306MPOe2cPHj2Cn3WbBqXJ/5wkSXuHJXzp2gqEtndFdyqbs2S7wqx34
	 T8ItJIMOvz/hA==
Message-ID: <sashiko-outbox-172495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 6/6] rust: sync: Introduce
 SpinLockIrq::lock_with() and friends
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261015-spinlock-irq-6-18-v1-6-72c58975994e@google.com>
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
 <20261015-spinlock-irq-6-18-v1-6-72c58975994e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:30:49 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] locking: lock_with() panics on PREEMPT_RT and deadlocks with CondV=
ar
- [Medium] rust: sync: lockdep_assert_irqs_disabled() fails on PREEMPT_RT i=
n kunit
--

commit 5ae395d5694f43cafc4f5157f39a1c85552be6b1
Author: Lyude Paul <lyude@redhat.com>

rust: sync: Introduce SpinLockIrq::lock_with() and friends

This commit adds lock_with() and try_lock_with() methods to SpinLockIrq.
These methods allow acquiring a spinlock without changing the interrupt
state by passing a LocalInterruptDisabled token. The goal is to avoid
overhead when it is already known that local interrupts are disabled.

Link: https://patch.msgid.link/20260807070218.27144-19-boqun@kernel.org

> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/sp=
inlock.rs
> index e566f223c6494..b3a0d7a3de04c 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -208,7 +221,47 @@ macro_rules! new_spinlock_irq {
>  /// # Ok::<(), Error>(())
>  /// ```
>  ///
> +/// The next example demonstrates locking a [`SpinLockIrq`] using [`lock=
_with()`] in a function
> +/// which can only be called when local processor interrupts are already=
 disabled.
> +///
> +/// ```
> +/// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
> +/// use kernel::interrupt::*;
> +///
> +/// struct Inner {
> +///     a: u32,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Example {
> +///     #[pin]
> +///     inner: SpinLockIrq<Inner>,
> +/// }
> +///
> +/// impl Example {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             inner <- new_spinlock_irq!(Inner { a: 20 }),
> +///         })
> +///     }
> +/// }
> +///
> +/// // Accessing an `Example` from a function that can only be called in=
 no-interrupt contexts.
> +/// fn noirq_work(e: &Example, interrupt_disabled: &LocalInterruptDisabl=
ed) {
> +///     // Because we know interrupts are disabled from interrupt_disabl=
e, we can skip toggling
> +///     // interrupt state using lock_with() and the provided token
> +///     assert_eq!(e.inner.lock_with(interrupt_disabled).a, 20);
> +/// }

[Severity: High]
Does this code demonstrate a pattern that will crash a preempt-rt kernel?

If the guard returned by lock_with() is passed to a CondVar, the condition
variable will drop the spinlock and sleep. Because the LocalInterruptDisabl=
ed
token remains in scope, the thread will invoke the scheduler with hard IRQs
physically disabled, causing a deadlock and panic.

[ ... ]

> @@ -273,6 +326,43 @@ unsafe fn assert_is_held(ptr: *mut Self::State) {
>      }
>  }
> =20
> +impl<T: ?Sized> Lock<T, SpinLockIrqBackend> {
> +    /// Casts the lock as a `Lock<T, SpinLockBackend>`.
> +    #[inline]
> +    fn as_lock_in_interrupt<'a>(&'a self, _context: &'a LocalInterruptDi=
sabled) -> &'a SpinLock<T> {
> +        // SAFETY:
> +        // - `Lock<T, SpinLockBackend>` and `Lock<T, SpinLockIrqBackend>=
` both have identical data
> +        //   layouts.
> +        // - As long as local interrupts are disabled (which is proven t=
o be true by _context), it
> +        //   is safe to treat a lock with SpinLockIrqBackend as a SpinLo=
ckBackend lock.
> +        unsafe { core::mem::transmute(self) }
> +    }
> +
> +    /// Acquires the lock without modifying local interrupt state.
> +    ///
> +    /// This function should be used in place of the more expensive [`Lo=
ck::lock()`] function when
> +    /// possible for [`SpinLockIrq`] locks.
> +    #[inline]
> +    pub fn lock_with<'a>(&'a self, context: &'a LocalInterruptDisabled) =
-> SpinLockGuard<'a, T> {
> +        self.as_lock_in_interrupt(context).lock()
> +    }

[Severity: High]
Can acquiring a spinlock here while hardware interrupts are explicitly held
disabled by the provided context token violate wait-context rules?

On preempt-rt, spinlock_t is mapped to an rt_mutex which sleeps on contenti=
on.
Acquiring a sleeping lock while hardware interrupts are explicitly disabled
triggers a panic. Regular SpinLockIrq::lock() avoids this because
spin_lock_irq() conditionally omits hard IRQ disablement on RT.

> +
> +    /// Tries to acquire the lock without modifying local interrupt stat=
e.
> +    ///
> +    /// This function should be used in place of the more expensive [`Lo=
ck::try_lock()`] function
> +    /// when possible for [`SpinLockIrq`] locks.
> +    ///
> +    /// Returns a guard that can be used to access the data protected by=
 the lock if successful.
> +    #[must_use =3D "if unused, the lock will be immediately unlocked"]
> +    #[inline]
> +    pub fn try_lock_with<'a>(
> +        &'a self,
> +        context: &'a LocalInterruptDisabled,
> +    ) -> Option<SpinLockGuard<'a, T>> {
> +        self.as_lock_in_interrupt(context).try_lock()
> +    }

[Severity: High]
Is it safe to try acquiring a sleepable spinlock_t with interrupts disabled,
or does this also trigger a wait-context violation on preempt-rt?


While reviewing the file, I also noticed an issue in the tests:

rust/kernel/sync/lock/spinlock.rs:WorkItem::run() {
    ...
        // Make sure the interrupts actually turned off
        // SAFETY: It's always safe to call `lockdep_assert_irqs_disabled()`
        unsafe { bindings::lockdep_assert_irqs_disabled() };
    ...
}

[Severity: Medium]
Will this lockdep assertion incorrectly assume that SpinLockIrq::lock() dis=
ables
hardware interrupts across all configurations?

On preempt-rt it does not, which triggers a lockdep warning when running the
rust_spinlock_irq_condvar kunit test.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-spinlock-i=
rq-6-18-v1-0-72c58975994e@google.com?part=3D6
