Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8B3911AB;
	Thu, 27 Aug 2026 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874220; cv=none; b=DnPYbP86juwKsEP4VnlZy68F/i0XgWgaboagifx12k7+0m9oxk4QdwwG+UG30chPPRbIAfD71zLFZf4r31GXBQVTnE92dBTUbH8Vv/a99WbcPkPrEraS5F2yCmvb0QqWO2YpTp+VJLQ7pJybVgLkeIO01NFsR0GPl9YSnE95knM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874220; c=relaxed/simple;
	bh=aVbapNLWK2qfSawOG2PBSAswbd0mvUw5awyzWMDDGdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uEJYYRJUPLprIxg/vVRUIdnTDgUHrdbYP9I2VxZTnIm+si854ZnZQNJIsuO6QvGoGgHF/QUIWZyJwB0VgUQ8doKsvp3qse3EkhzZ7EZjemKinJ04MuNT+SLqBm3PYAaDh7/WUgxbzM5hX1XT7bvC4xXPC0aeR2B0Yo+OZZNtoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjYYTimE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjYYTimE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1441F000E9;
	Thu, 27 Aug 2026 23:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787874218;
	bh=uG/sFEYg6fLCXYbNnioa5h406ZuuQtswBX3GqQ3y1Wg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjYYTimEgX81hphj9S+zikpktLrOLN75rFHIYOpWFs4GLu4PgwaGEYEVEBqgCOSEj
	 /Z+duVxHY8BJbToNjuGq5XiPzaa9Hq7QPv3H1T8PrkRA7Bug0HTWa6lfITitztPUf2
	 STjMRwY2qmG6VDAzk/xu7R2aVK56rkklDwQ3dHnVnsvXbduasD34C7Af9fmRjZR/mT
	 sfb/bfieYwU6Ods/MTL1WNyM5Sn0UwQLnLhtDNIfisL3oYYvzT1JXh+WkYTC45/+yz
	 6tmj7ojLDRYxq5JoGVToj1coxgrO1rmI9mxxcyIounpyWMBw8RjLt1RrQn2sEKPsNR
	 EE1wvPkulbEpg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 08/10] Set PF_RECLAIMABLE_STACK in various places
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Stevens" <stevensd@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260827232948.2520558-9-stevensd@google.com>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-9-stevensd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 23:43:37 +0000
Message-Id: <20260827234338.3F1441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Safe Rust methods `set_flag_bits` and `clear_flag_bits` on `Task` =
allow data races when called on non-current tasks.
- [Medium] Unconditional clearing of `PF_RECLAIMABLE_STACK` in Rust binder =
breaks flag preservation logic.
--

commit 6f8ac02f62f897200c71ad824d4019095dc4428c
Author: David Stevens <stevensd@google.com>

Set PF_RECLAIMABLE_STACK in various places

Annotate various blocking locations with the PF_RECLAIMABLE_STACK.

> diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/th=
read.rs
> index bc0ef8927905c..be62f7fd43ca2 100644
> --- a/drivers/android/binder/thread.rs
> +++ b/drivers/android/binder/thread.rs
> @@ -538,13 +538,21 @@ fn get_work_local(self: &Arc<Self>, wait: bool) -> =
Result<Option<DLArc<dyn Deliv
[ ... ]
>              inner.looper_flags |=3D LOOPER_WAITING;
> +
> +            current.set_flag_bits(bindings::PF_RECLAIMABLE_STACK);
> +
>              let signal_pending =3D self.work_condvar.wait_interruptible_=
freezable(&mut inner);
> +
> +            current.clear_flag_bits(bindings::PF_RECLAIMABLE_STACK);

[Severity: Medium]
Will unconditionally clearing the flag break flag preservation logic if sta=
ck
reclaim states are nested?

The C allow_stack_reclaim guard explicitly saves and restores the flag to
support nesting. If get_work_local() is called from a context where
PF_RECLAIMABLE_STACK is already set, this will unexpectedly disable stack
reclamation for the outer scope upon exit.

> +
>              inner.looper_flags &=3D !LOOPER_WAITING;
> =20
>              if signal_pending {
> @@ -592,15 +600,21 @@ fn get_work(self: &Arc<Self>, wait: bool) -> Result=
<Option<DLArc<dyn DeliverToRe
[ ... ]
> +            current.set_flag_bits(bindings::PF_RECLAIMABLE_STACK);
> +
>              inner.looper_flags |=3D LOOPER_WAITING | LOOPER_WAITING_PROC;
>              let signal_pending =3D self.work_condvar.wait_interruptible_=
freezable(&mut inner);
>              inner.looper_flags &=3D !(LOOPER_WAITING | LOOPER_WAITING_PR=
OC);
> =20
> +            current.clear_flag_bits(bindings::PF_RECLAIMABLE_STACK);

[Severity: Medium]
Similar to get_work_local(), is it safe to unconditionally clear the flag h=
ere
in get_work() instead of restoring its previous state?

> +
>              if signal_pending || inner.looper_need_return {
>                  // We need to return now. We need to pull the thread off=
 the list of ready threads
>                  // (by dropping `reg`), then check the state again after=
 it's off the list to
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 38273f4eedb51..6168f058343a2 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -344,6 +344,22 @@ pub fn group_leader(&self) -> &Task {
>          // only be used while `current` is still valid, thus still runni=
ng.
>          unsafe { &*ptr.cast() }
>      }
> +
> +    /// Sets the given task flag bits on the current task.
> +    #[inline]
> +    pub fn set_flag_bits(&self, set: u32) {
> +            // SAFETY: The `flags` field of `current` is not modified fr=
om other threads, so
> +	    // the non-atomic update isn't a race.
> +	    unsafe { (*self.as_ptr()).flags |=3D set }
> +    }

[Severity: High]
Does this expose a soundness hole by allowing data races on the flags field
when called on a non-current task?

The safety comment assumes self is the current task, but the method signatu=
re
accepts any Task reference. Because Task implements Send + Sync, another th=
read
could obtain a reference to a non-current task (for example, via group_lead=
er())
and safely call this method. This allows an unsafe non-atomic read-modify-w=
rite
and undefined behavior in safe Rust.

> +
> +    /// Clears the given task flag bits on the current task.
> +    #[inline]
> +    pub fn clear_flag_bits(&self, clear: u32) {
> +            // SAFETY: The `flags` field of `current` is not modified fr=
om other threads, so
> +	    // the non-atomic update isn't a race.
> +	    unsafe { (*self.as_ptr()).flags &=3D !clear }
> +    }
>  }

[Severity: High]
Does this method suffer from the same soundness hole as set_flag_bits() sin=
ce it
is a safe method performing a non-atomic update without verifying self is t=
he
current task?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827232948.2520=
558-1-stevensd@google.com?part=3D8
