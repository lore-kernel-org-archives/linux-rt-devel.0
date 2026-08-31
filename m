Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6673815DD;
	Mon, 31 Aug 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155410; cv=none; b=ryMjVhAkGEEisRJSWNM+9dJ76Kgqfy28pZe/VareGww5Z6ko1dMPni6n6YWYAMmGN3xcGgJy3j0nklRYspA/Byen7BG6L5kqzxUFMaAthMSvsERbbYNmLkpby3/uNdqcE6iyAbLJJNnI99r6uqRcx1IF7k8nNNtpzk3Bsx31STk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155410; c=relaxed/simple;
	bh=y2PyUy9h+eP2pcUnYvUMOwGBoegoqHYDKYIgLlrHlcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZa7QFylQk0bOzJHFEHI9h3U8U6VyqUdnZIKlfynrxaCvp2XBn9IaOx9NYbL0DftUZvWyVqj5XO39axfeSZ7kuDV2tuz2QyW4fM8fb6th1OYMF/Q48IvAwtIGkxVwnfraY5dlrvZhK17y0P3fOhHHSfv0EPzHwX18XujxsjdiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwmT5FF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwmT5FF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D51F000E9;
	Mon, 31 Aug 2026 05:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788155409;
	bh=3uYL9Uos+8SAq21BjilWSH8PWP7Nw5ON685Ijt6iN5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OwmT5FF6FZ8avz8OyanJXl/F/1QdSFoREdoV7xBYiNnO5zrYE+hlB8LzT6zWFluoq
	 s5XpniqeVOniKUtjTWvkuUHRr+z+fT9KTRjhPbL5LtA2IgPY3zLs56L+OUXnYfeJKC
	 FK1aUHiGbIBO/DjPItkfX2UW6MJZYjtK8zUqDgWt3weW/6TFCcxbrloizClAi98TZY
	 w9cG9culpXvBnHccXDT+6RbbAew4zAhwTmu5r/7dAieZK4UHwQ6SB/2tW3dbj3v6Tt
	 mQYyQ/0Oh3MR31+X0Jgi0+66UtFyuhym6aw6t9fPQwLph8uebh90bXIEHDuQYPFMSq
	 6U2wG07RqAM2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in
 kvfree_call_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260831053846.107974-1-ngocthang2710.1999@gmail.com>
References: <20260831053846.107974-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 05:50:08 +0000
Message-Id: <20260831055009.340D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message and comments incorrectly recommend using kfre=
e_call_rcu_nolock() under a raw spinlock on PREEMPT_RT, but doing so will t=
rigger the exact same lockdep violation.
- [Low] The patch introduces unreachable dead code inside `kfree_rcu_sheaf(=
)`.

Pre-existing issues:
- [High] Headless kfree_rcu() calls might_sleep() and synchronize_rcu(), ma=
king it unsafe to call under a raw spinlock.
--

commit 766d83bf3f72fb4bed74c42f068169aae388d06f
Author: ThangNN99 <ngocthang2710.1999@gmail.com>
mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()

This patch skips the sheaves fast path on PREEMPT_RT in kvfree_call_rcu()
to avoid a lockdep circular dependency when the caller holds a raw
spinlock. It modifies kvfree_call_rcu() to avoid calling into the sheaf
machinery when PREEMPT_RT is enabled, falling back to the krcp list. The
commit message and comments also suggest raw spinlock callers needing
the fast path should migrate to kfree_call_rcu_nolock() instead.

Reported-by: syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dacf142088e0182172e58
Fixes: 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT")

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b19ba1b31484c..6d6cd78d00c4b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2034,7 +2034,14 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head,=
 void *ptr)
>  	if (!head)
>  		might_sleep();
> =20

[Severity: High]
This is a pre-existing issue, but does using headless kfree_rcu() under a r=
aw
spinlock actually avoid sleeping?

The commit message states that set_cpus_allowed_force() uses kfree_rcu()
because it holds the raw p->pi_lock and cannot sleep. However, if head is
NULL (which is the case for the single-argument kfree_rcu() macro), this
might_sleep() is unconditionally called. Does this mean set_cpus_allowed_fo=
rce()
is actually triggering a "sleeping function called from invalid context" bu=
g?

> -	if (kfree_rcu_sheaf(ptr))
> +	/*
> +	 * Callers may hold a raw spinlock here on PREEMPT_RT (e.g.
> +	 * set_cpus_allowed_force() with p->pi_lock held), and the sheaf/barn
> +	 * locks are also taken as blocking locks elsewhere, so trying them
> +	 * here creates a lockdep-visible ordering conflict. Skip sheaves on
> +	 * PREEMPT_RT; use kfree_rcu_nolock() instead if this doesn't apply.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))

[Severity: Medium]
Will callers migrating to kfree_call_rcu_nolock() on PREEMPT_RT hit the same
issue this patch is trying to fix?

Looking at kfree_call_rcu_nolock(), it unconditionally calls
__kfree_rcu_sheaf() with SLAB_FREE_NOLOCK:

bool kfree_call_rcu_nolock(void *ptr)
{
    ...
    if (unlikely(!__kfree_rcu_sheaf(slab->slab_cache, ptr, SLAB_FREE_NOLOCK=
)))
    ...
}

This in turn calls local_trylock(&s->cpu_sheaves->lock). On PREEMPT_RT, this
lock is a sleepable spinlock_t. Doesn't acquiring a sleepable lock under a =
raw
spinlock violate lock nesting rules, even with a trylock?

[Severity: Low]
Does skipping kfree_rcu_sheaf() when PREEMPT_RT is enabled turn the early
check inside kfree_rcu_sheaf() into unreachable dead code?

kfree_rcu_sheaf() has an early check:

static bool kfree_rcu_sheaf(void *obj)
{
    ...
    if (IS_ENABLED(CONFIG_PREEMPT_RT))
        free_flags =3D SLAB_FREE_NOLOCK;
    ...
}

Since kvfree_call_rcu() is the only caller of kfree_rcu_sheaf(), that code
appears to be completely unreachable now.

>  		return;
> =20

[ ... ]

> diff --git a/mm/slub.c b/mm/slub.c
> index f9b56cb439e70..83bc322557f89 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6088,10 +6088,11 @@ static void rcu_free_sheaf(struct rcu_head *head)
>  /*
>   * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
>   * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMP=
T_RT),
> - * this would violate lock nesting rules. Therefore, kvfree_call_rcu() a=
voids
> - * this problem by passing SLAB_FREE_NOLOCK on PREEMPT_RT.
> + * this would violate lock nesting rules. kvfree_call_rcu() avoids this =
by
> + * bypassing the sheaves layer on PREEMPT_RT; use kfree_call_rcu_nolock()
> + * instead for atomic/unknown-context callers that need the sheaves path.
>   *
> - * However, lockdep still complains that it is invalid to acquire spinlo=
ck_t
> + * lockdep still complains that it is invalid to acquire spinlock_t

[Severity: Medium]
As mentioned above, if callers follow this comment and use
kfree_call_rcu_nolock() under a raw spinlock on PREEMPT_RT, won't lockdep
still complain because kfree_call_rcu_nolock() will call __kfree_rcu_sheaf()
which attempts to acquire the sleepable spinlock_t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831053846.1079=
74-1-ngocthang2710.1999@gmail.com?part=3D1
