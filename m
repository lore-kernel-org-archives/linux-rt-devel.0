Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB22DCC1F
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181264; cv=none; b=kPwJ/b7x2FDrwi3DqErUgZmsJQEBCX4Quf7ZtJwY8G7PWNycin+xdSPsOs2cGFdflfQyBujMcAA3CN1mT7TIhoIjuqp+OFmY+9f3mH/WC1GQPc4lfckmtPWEz3/Iz61xkoVvjQTRhz57EzDTEdQJ2IQTyNoZPz6KjjBV6GOr6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181264; c=relaxed/simple;
	bh=YK+uCOSlSxthi0nGQFvzfbUxqeZ7F12VlRFY/yUQSec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiQMNoZHrL+r9N5S+wh/+aju6u/QdUGqHg0m24hwNwNreSWO1koWQyp40fTdDB1U0KFlvUDnNXWk9XUWopqTPw36UISY6IEjVTS4Ib9e42cwcHhhlMDcTnxI+HuHBPOW73fXRPFtJwbFRik4WznBNC8CODI16N9mlO9a1QZVFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lyE6qyKj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VNqZwd9w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lyE6qyKj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VNqZwd9w"
Date: Mon, 31 Aug 2026 15:00:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788181258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVKRVR8QAa3+pNGan/n7Vu6OKGnK3U7HFuskJ9RSYns=;
	b=lyE6qyKjPXT1Qxi/43WwjoH1OJeBQ3ngIPaLC80rD3A0Ijx4uH9sE9dQbYHt235OWu76xv
	5hPIUKh8o8FOxu8jafjHXxa01Otyf2nExAEovTKKDCKq6SDVZoj7biMn2aqFdmauYWaZei
	fH19P+pdJGPk37qhIPk/oQCFFTuU0ZWAXr1pSb9fBeIE4CMhwLCSXUa88/N4MdPRlatVAl
	AMAQH98/Jf2HlJZr/B2E7IDdZkiuVpAU5hN3avLgxD4QEvnJL1tdvtq/qbe70oBK0F2f8I
	w1CpwqzpBtPhMCkGPxfuYZ+A16FbHg2tVX2or6tfvoez7HDa42DnTG+FsYixwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788181258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVKRVR8QAa3+pNGan/n7Vu6OKGnK3U7HFuskJ9RSYns=;
	b=VNqZwd9weJWTl4G/a215AAzey2BWbnZFMvlcNcL/18S2VuRfDyDdUqJ0MSUTSUdOoJewGL
	nK/ILA+zUhqFj3Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: ThangNN99 <ngocthang2710.1999@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in
 kvfree_call_rcu()
Message-ID: <20260831130057.HLukQ-zm@linutronix.de>
References: <20260831053846.107974-1-ngocthang2710.1999@gmail.com>
 <20260831060633.6831-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260831060633.6831-1-ngocthang2710.1999@gmail.com>

On 2026-08-31 13:06:32 [+0700], ThangNN99 wrote:
> syzbot reports a possible circular locking dependency between
> &p->pi_lock and the per-CPU kfree_rcu sheaf lock (_T->lock) on
> PREEMPT_RT:
>=20
>   __balance_push_cpu_stop()               [holds p->pi_lock, raw]
>     select_fallback_rq()
>       cpuset_cpus_allowed_fallback()
>         set_cpus_allowed_force()
>           kfree_rcu(ac.user_mask)
>             kvfree_call_rcu()
>               kfree_rcu_sheaf()
>                 __kfree_rcu_sheaf()
>                   local_trylock(&s->cpu_sheaves->lock)   <- _T->lock
>=20
> set_cpus_allowed_force() uses kfree_rcu() instead of kfree() here
> specifically because it can be called with p->pi_lock (a raw
> spinlock) held, and plain kfree() may sleep under PREEMPT_RT.

A raw_spinlock_t. Please don't invent new things.

=E2=80=A6
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b19ba1b31484..3de1eabe6c77 100644
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

No. All callers of set_cpus_allowed_force() hold task_struct::pi_lock.

> +	 * locks are also taken as blocking locks elsewhere, so trying them
> +	 * here creates a lockdep-visible ordering conflict. Skip sheaves on
> +	 * PREEMPT_RT.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))

Given that this can hold the pi_lock I am not a big of this trylock
underneath. So skipping it is my favorite.

>  		return;
> =20
>  	// Queue the object but don't yet schedule the batch.
> diff --git a/mm/slub.c b/mm/slub.c
> index f9b56cb439e7..1e8bad7a018e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6088,10 +6088,10 @@ static void rcu_free_sheaf(struct rcu_head *head)
>  /*
>   * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
>   * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMP=
T_RT),
> - * this would violate lock nesting rules. Therefore, kvfree_call_rcu() a=
voids
> - * this problem by passing SLAB_FREE_NOLOCK on PREEMPT_RT.
> + * this would violate lock nesting rules. kvfree_call_rcu() avoids this =
by
> + * bypassing the sheaves layer on PREEMPT_RT.
>   *
> - * However, lockdep still complains that it is invalid to acquire spinlo=
ck_t
> + * lockdep still complains that it is invalid to acquire spinlock_t
>   * while holding raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is=
 a
>   * spinning lock. Tell lockdep that acquiring spinlock_t is valid here
>   * by temporarily raising the wait-type to LD_WAIT_CONFIG. Skip the lock=
dep map

Sebastian
