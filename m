Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAB59E33B;
	Mon, 31 Aug 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184312; cv=none; b=hPhrZbNzB+Da3zQRkmialbQgdhsttg6kgI3y+/7OxFLf5wCMUsza9XeP3I6SZjghcUyX3rNUeugUU+MXT3zs2bWErO5LLeYnSpp9EeIZCMwrn4bSPyFxI5N7VOHap8AJwI5pe440PLfrhHGM0E+N6jWNhjSu/w2KDLfKGbB8mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184312; c=relaxed/simple;
	bh=XHugDTr01YTLTNAXHIfx4el+tijG/FN9LN6F7bGD9ck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvFueuHZCKZNrcYnIAxJUALHCYDxWcyr9qys4bVwiWGJdbB0fbInNH+SMcsvy6kNmkTkJPwliGS8XdVuFSUSpQKRpIz6f8Cw3fLRPbna0a6H/KvKR3HAcs3cudldWNhfOBjwziWgKGwOzgg8dxxQwqUz0CZxqM6nZ+sMb6tI32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZYwsrQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZYwsrQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4B31F00A3E;
	Mon, 31 Aug 2026 13:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184310;
	bh=moGoMUSpiw5W3Q1w0pMFZXPnxmITHbEmp8bgPRGatx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZYwsrQciCAoxq6Wxtv57cosM4eDh4zqUyiFS0wOd0FL4XfsAXMMADCa205fbmrIU
	 fX2wvvq6NMi4SyZTrnMiOfpSzdIVr0S/NTJ7qcKSpuMXDRRXYN1+i19lm8/SS/aTkm
	 N4Dehm3XfeBoGYYrmzacTVwwNt9x1z4akZgcI6iVPWloTK+wm9iOJfuHZxdNJ6wX8H
	 xez/kdcs0/1qpBA+lDXHHsq5gofIAEVz80qCQ6Ua7BXJ06Ytqh8DWDiB04bhJ7rTEi
	 MFI6kY5lzG0lnqDd1tgM4/7/OuS6dTwmP7lMaO7FnrBPiFtrzPtT8zXsegaxHF0HyK
	 IpgKoh8iyrKdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT
 in kvfree_call_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260831133222.8637-1-ngocthang2710.1999@gmail.com>
References: <20260831130057.HLukQ-zm@linutronix.de>
 <20260831133222.8637-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:51:49 +0000
Message-Id: <20260831135150.1B4B31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] __kfree_rcu_sheaf() allocates with GFP_NOWAIT on !PREEMPT_RT, =
which can trigger wakeup_kswapd() and deadlock against scheduler locks (e.g=
., pi_lock).
- [High] kfree_call_rcu_nolock() unconditionally calls __kfree_rcu_sheaf() =
and triggers lockdep wait context violations and circular dependencies on P=
REEMPT_RT when called from raw spinlock context.
--

commit fade274cd80fc5162ad3fd4de36a4d5b181861b2
Author: ThangNN99 <ngocthang2710.1999@gmail.com>

mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()

This commit fixes a circular locking dependency on PREEMPT_RT by skipping
the kfree_rcu sheaves layer in kvfree_call_rcu() when called from contexts
that hold a raw spinlock. This safely falls back to the existing list.

Closes: https://syzkaller.appspot.com/bug?extid=3Dacf142088e0182172e58
Fixes: 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT")

> kfree_call_rcu_nolock(), added later in commit 3bc999d944b3
> ("mm/slab: introduce kfree_rcu_nolock()"), is untouched by this
> patch. Note it would not be a safe substitute here either: it still
> reaches __kfree_rcu_sheaf()'s local_trylock() on &s->cpu_sheaves->lock
> unconditionally, so a caller already holding a raw_spinlock_t would
> hit the same lockdep ordering cycle through that path too.

[Severity: High]
This is a pre-existing issue, but since the patch leaves
kfree_call_rcu_nolock() untouched, does the API contract for the nolock
variant remain violated on PREEMPT_RT?

As noted in the commit message, calling kfree_call_rcu_nolock() still
unconditionally reaches __kfree_rcu_sheaf() with SLAB_FREE_NOLOCK, which
executes:

mm/slub.c:__kfree_rcu_sheaf() {
    ...
    if (!local_trylock(&s->cpu_sheaves->lock))
        goto fail;
    ...
    empty =3D alloc_empty_sheaf(s, gfp, alloc_flags);
    ...
}

While local_trylock() bypasses the Invalid wait context check, it still
creates a lock-class ordering dependency (raw_spinlock_t -> spinlock_t),
which causes circular dependency splats against other paths taking the lock.

Furthermore, if it needs an empty sheaf, it calls alloc_empty_sheaf(),
which enters the page allocator. The page allocator acquires sleeping locks
like zone->lock via spin_lock_irqsave. This triggers a hard Invalid wait
context violation and exposes the system to genuine deadlocks on PREEMPT_RT.

Could this be addressed to ensure kfree_call_rcu_nolock() is truly safe for
raw spinlock contexts as intended?

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b19ba1b31484c..015380ba8bcc6 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c

[ ... ]

> @@ -2034,7 +2027,14 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head,=
 void *ptr)
>  	if (!head)
>  		might_sleep();
> =20
> -	if (kfree_rcu_sheaf(ptr))
> +	/*
> +	 * Callers may hold a raw_spinlock_t here on PREEMPT_RT (e.g.
> +	 * set_cpus_allowed_force(), whose callers all hold
> +	 * task_struct::pi_lock), and the sheaf/barn locks are also taken
> +	 * as blocking locks elsewhere, so trying them here creates a
> +	 * lockdep-visible ordering conflict. Skip sheaves on PREEMPT_RT.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))

[Severity: Critical]
This isn't a bug introduced by this patch, but does falling back to
kfree_rcu_sheaf() on !PREEMPT_RT expose us to a deadlock when called under
scheduler locks?

When kvfree_call_rcu() is called holding pi_lock, like in
set_cpus_allowed_force(), on !PREEMPT_RT it enters __kfree_rcu_sheaf() with
allow_spin evaluating to true. This sets up the allocation:

mm/slub.c:__kfree_rcu_sheaf() {
    ...
    gfp_t gfp =3D allow_spin ? GFP_NOWAIT : __GFP_NOWARN;
    ...
    empty =3D alloc_empty_sheaf(s, gfp, alloc_flags);
    ...
}

GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM. If alloc_empty_sheaf() needs to
be called, the page allocator will wake kswapd.

Waking kswapd calls try_to_wake_up(), which attempts to acquire scheduler
locks such as the runqueue lock or kswapd->pi_lock.

If the original caller already holds pi_lock or rq_lock, wouldn't this
cause lock recursion (e.g., rq_lock -> pi_lock -> rq_lock) and deadlock
the system?

>  		return;
> =20
>  	// Queue the object but don't yet schedule the batch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133222.8637=
-1-ngocthang2710.1999@gmail.com?part=3D1
