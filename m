Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65D29408;
	Mon, 31 Aug 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157255; cv=none; b=gW/PImN38e5pL0ikwO67XRQmgypJRBQeUuTb3Gh67mJ4Y4at+qaA7X00i2xYfgsNL9eZeDs7aJXZu9Yn+6h7qNu0Fs9mDgdMO8yx417HP2lL01FNtW60FqkbwV7spHZGLIngP0yUQ+oTc4ApAQCmj/y3GozJ6fPIhWJkmWy3THY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157255; c=relaxed/simple;
	bh=rwr1AxAfwSaLuyxoVAiITU9qmPaQWHYBLJfM3wzb1yQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KYezOYRmXj3YXXPTxivKBsu6YQ3Uu1EKfNQcNOc2SRW2ixLsMT1ExcIbkq0AzX1wLPl+5PPiSzDeaU+svvfdEyrfj4RCb8txj7ZFsZvpg5XBAgs6pw5pA6hhzWqTwuOMuXrEgeHkRDnbOphebsyichkhUFQSejHTfATzEIVqR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPOTRWlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPOTRWlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319EA1F000E9;
	Mon, 31 Aug 2026 06:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788157254;
	bh=RccuAwUjjYQS8UYQ+DNxS0f7Ytxkz9Lfp1Z2NrXtpvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPOTRWlLFBTGbx8cRsnoYIIZV/iE8Bjph03VnRNZdRKq3mKCK355t9L2SpauYioiH
	 i+e3png4VQHDDxyTTSKfRoHhC8h+UQMBi6esy0YDWXZx/d4CGqDItfgwwcEBJwATlP
	 OtTLAiWghxR23hN6FiaMemWD+15lZSbLKmrYTc7E6L4fFv3lxW+3q602o/F7Ht/cqY
	 +BIbmJh/8bVXdMI3KwPojJKZx9DBKMNXhQOFL/DBbrMdG76YazUIKnrFLK2HENFiBg
	 MHbMh1w5bR8WLqc/a7y//fCxS6MhpT2uQrAvI5sbG4TbidCCIO5kvKF0fUCzNcNA/H
	 28LuO3PrHF/8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT
 in kvfree_call_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260831060633.6831-1-ngocthang2710.1999@gmail.com>
References: <20260831053846.107974-1-ngocthang2710.1999@gmail.com>
 <20260831060633.6831-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:20:53 +0000
Message-Id: <20260831062054.319EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lock recursion deadlock in kfree_rcu() on !PREEMPT_RT when caller =
holds scheduler locks
- [High] kfree_call_rcu_nolock() violates its 'any context' API guarantee o=
n PREEMPT_RT, leading to Invalid Wait Context
--

commit 405a1ecd91cd7581e29421663a94a33714163104
Author: ThangNN99 <ngocthang2710.1999@gmail.com>

mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()

This commit addresses a lockdep warning by skipping the sheaf fast path
in kvfree_call_rcu() on PREEMPT_RT, avoiding a local_trylock() under a
raw spinlock. It also notes that kfree_call_rcu_nolock() has a similar
problem but leaves it untouched.

Closes: https://syzkaller.appspot.com/bug?extid=3Dacf142088e0182172e58

> kfree_call_rcu_nolock(), added later in commit 3bc999d944b3
> ("mm/slab: introduce kfree_rcu_nolock()"), is untouched by this
> patch. Note it would not be a safe substitute here either: it still
> reaches __kfree_rcu_sheaf()'s local_trylock() on &s->cpu_sheaves->lock
> unconditionally, so a caller already holding a raw spinlock would hit
> the same lockdep ordering cycle through that path too.

[Severity: High]
This is a pre-existing issue, but does leaving this unaddressed violate
the API guarantee of kfree_call_rcu_nolock() in mm/slab_common.c?

The documentation for kfree_call_rcu_nolock() states it is safe for any
context. However, on PREEMPT_RT it leads to this call chain:

kfree_call_rcu_nolock()
  __kfree_rcu_sheaf(..., SLAB_FREE_NOLOCK)
    local_trylock(&s->cpu_sheaves->lock)

Since local_lock maps to a sleepable rt_mutex on PREEMPT_RT, executing
this trylock from a raw spinlock or hardirq context violates wait-type
rules.

Won't any subsystem using kfree_call_rcu_nolock() in these contexts still
trigger an Invalid wait context lockdep splat on PREEMPT_RT?

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b19ba1b31484c..3de1eabe6c770 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1667,15 +1667,8 @@ static bool kfree_rcu_sheaf(void *obj)
>  {
>  	struct kmem_cache *s;
>  	struct slab *slab;
> -	unsigned int free_flags =3D SLAB_FREE_DEFAULT;
> -
> -	/*
> -	 * It is not safe to spin on PREEMPT_RT because the kernel might be
> -	 * holding a raw spinlock and slab acquires sleeping locks.
> -	 */
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		free_flags =3D SLAB_FREE_NOLOCK;
> =20
> +	/* Callers on PREEMPT_RT never reach here, see kvfree_call_rcu(). */
>  	if (is_vmalloc_addr(obj))
>  		return false;
> =20
> @@ -1685,7 +1678,7 @@ static bool kfree_rcu_sheaf(void *obj)
> =20
>  	s =3D slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_mem_i=
d()))
> -		return __kfree_rcu_sheaf(s, obj, free_flags);
> +		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
> =20
>  	return false;
>  }
> @@ -2034,7 +2027,14 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head,=
 void *ptr)
>  	if (!head)
>  		might_sleep();
> =20
> -	if (kfree_rcu_sheaf(ptr))
> +	/*
> +	 * Callers may hold a raw spinlock here on PREEMPT_RT (e.g.
> +	 * set_cpus_allowed_force() with p->pi_lock held), and the sheaf/barn
> +	 * locks are also taken as blocking locks elsewhere, so trying them
> +	 * here creates a lockdep-visible ordering conflict. Skip sheaves on
> +	 * PREEMPT_RT.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but does this lead to a lock
recursion deadlock on !PREEMPT_RT?

On !PREEMPT_RT, this can result in the following call chain:

kvfree_call_rcu()
  kfree_rcu_sheaf()
    __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT)
      alloc_empty_sheaf() with GFP_NOWAIT
        wakeup_kswapd()
          try_to_wake_up()

Since GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM, the page allocator can call
wakeup_kswapd() if the zone watermark is low.

This enters the scheduler and attempts to acquire scheduler locks. If the
caller, like set_cpus_allowed_force() in the trace above, already holds a
scheduler raw spinlock, won't this result in a hard deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831060633.6831=
-1-ngocthang2710.1999@gmail.com?part=3D1
