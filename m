Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017203911CA;
	Mon, 31 Aug 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202377; cv=none; b=NzeVAh1y/Xccc0bsN2xTVKrk8KR2MHacZAmW00kHZBk0b/aaAJXhVR7NoWBopNop+5CVd20wZyEIoD4PoFvg3+GvfLc9naF3n4rFSJbqWpbOITb9KREgFOEHVRdfc3KY8plFIOOd/0UYu6YqvGR5vt5IGTmGQpyIWCyZ7Egmu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202377; c=relaxed/simple;
	bh=8kE3mn4MJehlGgEx4d09366c1li57ep7/5mbxQUQIaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHKSk9FivtcxqEtiVKWYB58z1A/Pz/D0WPo6SB1VqiVrhoEag7VN+XOJqnlN19jVLvsbBvOudv9gjg4we46tusmTskrbOOXeBY80hFTgkNipKatj50aPrc3EzmToMdXqu9NjVSB5uEd0GnzfIcd37Ra9bVk1CH2U2LN5HxEJBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQlVMdhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQlVMdhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6AE1F000E9;
	Mon, 31 Aug 2026 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202375;
	bh=ZKV9le2OGTOsoM2XZ2llaOQkKHdNM+4MR1RB/yAg/0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQlVMdhqghiYQU/bp4RqfBaWoxZCV3hjFuccPtiyG9ICjuQf7we6mlOyZBTNaCDnV
	 Wzt5Qt3GQty6d1CL6snQgFIN/LW1rXnaL+VdDRUJMAMKNpf324Z7x42uHoKCAWvw1Q
	 QwqQJVwQDayG2xQbtbfUZ1OtE9u4+RrmS6XWP6x7DyE15litGvOT2zMjklKDzXXCuK
	 USamVAzGcOvWlZf6dRsRwc4h7uzs/IfZTY5VeMtdrfW084Z1avZskqBRqiJcHjvFNS
	 mSOodeByzT0YXbjEq8Ar6ijx3SscTQltd10C3PFgDP6XzrpVQSEUrUUt+MHGJ4A19C
	 OccQwLN7YaNcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Vmxhc3RpbWlsIEJhYmthIChTVVNFKQ==?= <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:52:54 +0000
Message-Id: <20260831185255.5F6AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] kfree_call_rcu_nolock() is fundamentally broken on PREEMPT_RT when=
 called from raw spinlock contexts, and the newly added comment falsely ass=
erts that it is safe.

Pre-existing issues:
- [Critical] Lock recursion deadlock on !PREEMPT_RT due to __GFP_KSWAPD_REC=
LAIM allocation under scheduler locks in kvfree_call_rcu().
- [High] Lockdep 'Invalid wait context' warning on !PREEMPT_RT kernels due =
to acquiring `local_trylock` while holding a `raw_spinlock_t` in `kvfree_ca=
ll_rcu()`.
--

commit 2bc8f43addec97fafa1e1eee6c2edf8016a0ff92
Author: Vlastimil Babka (SUSE) <vbabka@kernel.org>

mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again

This partially reverts commit 2a8bb29ec9b2 to skip kfree_rcu_sheaf() on
PREEMPT_RT from kvfree_call_rcu(). It adds a comment explaining that
local_trylock() is unsafe on PREEMPT_RT when called under pi_lock.

Link: https://syzkaller.appspot.com/bug?extid=3Dacf142088e0182172e58
Link: https://lore.kernel.org/all/20260807-kfree_nolock_kmalloc-v1-0-ba993c=
bf7a60@kernel.org/

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b19ba1b31484c..7223a7596dabb 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
[ ... ]
> @@ -1685,7 +1677,7 @@ static bool kfree_rcu_sheaf(void *obj)
> =20
>  	s =3D slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_mem_i=
d()))
> -		return __kfree_rcu_sheaf(s, obj, free_flags);
> +		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);

[Severity: Critical]
This is a pre-existing issue, but does passing SLAB_FREE_DEFAULT on
!PREEMPT_RT risk a lock recursion deadlock during low memory conditions?

When kfree_rcu_sheaf() forwards to __kfree_rcu_sheaf() with SLAB_FREE_DEFAU=
LT,
it sets allow_spin to true. If the sheaf is empty, it calls:
    alloc_empty_sheaf(..., GFP_NOWAIT, ...)

GFP_NOWAIT implicitly includes __GFP_KSWAPD_RECLAIM. During high memory
pressure, this can trigger wakeup_kswapd(), which enters the scheduler via
try_to_wake_up() and acquires scheduler locks.

Since kvfree_call_rcu() is already called with task_struct::pi_lock held,
couldn't this allocation cause a lock recursion deadlock?

[ ... ]
> @@ -2034,7 +2026,13 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head,=
 void *ptr)
>  	if (!head)
>  		might_sleep();
> =20
> -	if (kfree_rcu_sheaf(ptr))
> +	/*
> +	 * kvfree_rcu() is called by set_cpus_allowed_force() with
> +	 * task_struct::pi_lock acquired. On PREEMPT_RT the local_trylock()
> +	 * usage below will acquire the waitlock which must be avoided.
> +	 * Therefore avoid it on PREEMPT_RT.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
>  		return;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does executing
kfree_rcu_sheaf() on !PREEMPT_RT under pi_lock trigger a static wait-type
violation?

kvfree_rcu() is called while holding task_struct::pi_lock, which establishes
a RAW (LD_WAIT_SPIN) wait context. On !PREEMPT_RT, this code proceeds to
call kfree_rcu_sheaf(), which calls local_trylock() inside __kfree_rcu_shea=
f().

Even though local_lock only disables preemption on non-RT, its lockdep map
declares an LD_WAIT_CONFIG (spinlock) wait-type. Since
CONFIG_PROVE_RAW_LOCK_NESTING statically checks declared wait-types rather
than runtime behavior, won't attempting to acquire an LD_WAIT_CONFIG lock
while holding an LD_WAIT_SPIN lock trigger an immediate "Invalid wait conte=
xt"
warning on !PREEMPT_RT kernels?

> diff --git a/mm/slub.c b/mm/slub.c
> index f9b56cb439e70..7a7e906a0e44d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6088,8 +6088,9 @@ static void rcu_free_sheaf(struct rcu_head *head)
>  /*
>   * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
>   * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMP=
T_RT),
> - * this would violate lock nesting rules. Therefore, kvfree_call_rcu() a=
voids
> - * this problem by passing SLAB_FREE_NOLOCK on PREEMPT_RT.
> + * this would violate lock nesting rules. Therefore, kfree_call_rcu_nolo=
ck()
> + * avoids this problem by passing SLAB_FREE_NOLOCK. kvfree_call_rcu() is
> + * bypassing the sheaves layer completely on PREEMPT_RT.
>   *

[Severity: High]
Is the assertion in this comment that kfree_call_rcu_nolock() avoids the lo=
ck
nesting problem accurate for PREEMPT_RT?

Passing SLAB_FREE_NOLOCK to __kfree_rcu_sheaf() only prevents spinning, but
it still unconditionally calls local_trylock(&s->cpu_sheaves->lock). On
PREEMPT_RT, local_trylock() attempts to acquire a sleepable lock (rt_mutex),
which is an invalid wait context when held from NMI or raw spinlock context=
s.

Given that kfree_call_rcu_nolock() is actively used and tested in hardirq/N=
MI
contexts (e.g., via test_nolock() in lib/tests/slub_kunit.c), won't this
cause a lockdep splat or kernel panic on PREEMPT_RT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-b4-kfree_r=
cu_hotfix-v1-1-4f0fb882638b@kernel.org?part=3D1
