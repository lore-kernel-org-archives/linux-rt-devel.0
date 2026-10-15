Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B637A848;
	Thu, 15 Oct 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053015; cv=none; b=RDlYS7yCH5il8OFvezfxTtmdiBsJOxXLd0bTwmidsyEZq8WULd3o9U0a/6KmqZqUkPA6xu+iZqcd+7d81DzNENz5k2GSInxxvfRf0t3tcqR8Pl+b9/UvfOlZqgQH8Mn1ZAp3QeakIfT1dlgfgDSDF1ipzdLeL1aKNBeYAqkBiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053015; c=relaxed/simple;
	bh=SrmYoiT362l29bCSzMqbL/Ykls95TKflNTsPS8b030Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Hofq4RMo86XEjM/ogtARPTjU/ZJQh8i+S7hDWGXrh0BzfjEzTM5VOGoxyPSSMn0zP1cbZc4V1CAM/x3x+e3lVdVIjfVgP3zLuYrWwXV6aAwJgfUB4P/h9/OoPxzB3RIjEtq9uFlk3uesrAzO5Iq0Wr4qwHdCcFTK2gbifIhPqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKTrJ2VA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKTrJ2VA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55401F000C5;
	Thu, 15 Oct 2026 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053013;
	bh=NoygY2UDFMIbpalc5FGC7SvtbPCGaB72cjwiZBZpZa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKTrJ2VAwDfo7PIs0KCapD/tTSpzDN5rR33yiFUb+eWlaw4KPsF4tXaL3ut1iEK0h
	 2cBbk7HaKpqJXNMqDtfpG6F9jgUYyA7S4cssGIIWEhxxCj6+GEl0PUuoQkk3eZefLT
	 et1XobruXMSR19d+J0dRDL8kGv39Fp2fsh6tVJArz+0Qc9oHsglCfRhTZ2TW2+R2SE
	 I+YGPJ2XDkazlUcc2/5p5dXjzfVUUioJmdXbfJrUvQcKHrQaDKJSw43hFgQGXBKiEv
	 qnk6K9y8lcME8ow+1hrumo2KekuWISWPmhJmwvx2iQrrxholT/6RMVi6IzeVw37LIL
	 Np3x2OoJPAoFA==
Message-ID: <sashiko-outbox-172494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 5/6] rust: sync: Add SpinLockIrq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261015-spinlock-irq-6-18-v1-5-72c58975994e@google.com>
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
 <20261015-spinlock-irq-6-18-v1-5-72c58975994e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:30:13 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] workqueue: missing flush_work in spinlock_irq test causes module-u=
nload UAF
- [Medium] rust: sync: lockdep_assert_irqs_disabled() in test fails on PREE=
MPT_RT
- [Low] rust: sync: missing loop around CondVar::wait in spinlock_irq_condv=
ar test
- [Low] rust: sync: misleading SpinLockIrqBackend documentation
--

commit 53307f4fda1c118612a5cc4ab386ba1ddc8eda26
Author: Lyude Paul <lyude@redhat.com>

rust: sync: Add SpinLockIrq

A variant of `SpinLock` that ensures interrupts are disabled in the
critical section. `lock()` will ensure that either interrupts are
already disabled or disable them. `unlock()` will reverse the respective
operation.

Link: https://patch.msgid.link/20260807070218.27144-18-boqun@kernel.org

> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/sp=
inlock.rs
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
[ ... ]
> +/// A kernel `spinlock_t` lock backend that can only be acquired in inte=
rrupt disabled contexts.
> +pub struct SpinLockIrqBackend;

[Severity: Low]
Does this comment accurately reflect the backend's behavior?

The backend implementation calls bindings::spin_lock_irq_disable(ptr),
which disables interrupts itself if they aren't already disabled.

Could this doc string be updated to clarify that it disables interrupts,
rather than requiring them to be disabled beforehand?

[ ... ]
> +    impl WorkItem for Test {
> +        type Pointer =3D Arc<Self>;
> +
> +        fn run(this: Arc<Self>) {
> +            // Wait for the test to be ready to wait for us
> +            let mut state =3D this.state.lock();
> +
> +            // Make sure the interrupts actually turned off
> +            // SAFETY: It's always safe to call `lockdep_assert_irqs_dis=
abled()`
> +            unsafe { bindings::lockdep_assert_irqs_disabled() };

[Severity: Medium]
Will this test fail on preempt-rt configurations?

On preempt-rt, spin_lock_irq_disable() is implemented as a sleepable lock
and intentionally does not disable hardware interrupts. This means
bindings::lockdep_assert_irqs_disabled() will evaluate to true and trigger
a warning or panic depending on configuration.

Could this check be adjusted or guarded so the test doesn't unconditionally
fail on preempt-rt kernels?

[ ... ]
> +    #[test]
> +    fn spinlock_irq_condvar() -> Result {
> +        let testdata =3D Test::new()?;
> +
> +        let _ =3D workqueue::system().enqueue(testdata.clone());
> +
> +        // Let the updater know when we're ready to wait
> +        let mut state =3D testdata.state.lock();
> +        state.waiter_ready =3D true;
> +        testdata.waiter_state_changed.notify_sync();
> +
> +        // Wait for the exciting value update
> +        testdata.state_changed.wait(&mut state);

[Severity: Low]
Is this wait vulnerable to spurious wakeups?

Condition variables in the kernel waitqueue can wake up spuriously.
If a spurious wakeup occurs before the worker thread increments the value,
the test will proceed to the assert and panic since the value is still 1.

Should this wait be wrapped in a while loop checking state.value,
similar to how the worker thread checks state.waiter_ready?

> +        assert_eq!(state.value, 2);
> +        Ok(())
> +    }

[Severity: High]
Does this test leave background work running, potentially causing a
use-after-free during module unload?

The test enqueues a work item to workqueue::system() and waits for
state_changed.notify_sync(). Once notified, this main thread completes and
returns, which allows the kunit test to finish.

If the module is unloaded immediately after the test completes, the worker
thread executing Test::run() might still be finishing its final steps or
returning to the C workqueue executor. This would cause the kernel to
execute unmapped memory.

Should there be a flush_work() or similar synchronization barrier here
before returning from the test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-spinlock-i=
rq-6-18-v1-0-72c58975994e@google.com?part=3D5
