Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796323;
	b=cEXMoSrhGHl7XWZJFhNaN9cb9ch4ueJV6WqYQaWbtlZAMbQlTCjBIegCD9HGegF1UUvB
	 cjUXSVm/yM18YHrKyG/MEZleWxq6fAe8+QdFDsQ353pNI86WMLv06+Fo+NlJFep4RcxmJ
	 mMRvS4C14pV+TWIxsvpFAM2fSMxPavG7XF0QvrgZmNLZEZixGuwII3bVXuKXV6BbGlxRL
	 Tqk/zwc43k4oDQcSGNra0BLZin4PfH/CvdRkgpCMRupdoasuJhLT0HdKsKiWcqiN8pRTV
	 hv65LhYl4OFQBn2ivs4axZkFK2oUioLmMWeEYzIZtsXcmEvjkRJSCp7hIqQ2LHeXqfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ttcp9mL62BqPrUTMOtiA5GUX35v7XK0b+9vV9K/SM3A=;
	b=Gha4I2xe+0I4ZJvtc7783HpJ0uNI1LzQJm0pfH3vvuPGy5M5xkoNK4hqN7FvmfaBDoud
	 SMxaowxkEjEK8+wVkbmy33hZWWDeSoDXuVwowVTquhSDKlZqftT8hF1QQAIC4mZMsdrov
	 0biGxgMSoiXyoTVgj/zqXHds9pw5jZM0wofLy6gywzDmvK0JmQ5laYVMEdul/nXLhO7pa
	 DupAPDyfHLsa1DugmDotFtCuGp6pbU5z4+tInBF+JBPFEn5oNBB0z0CBgjdRlxHsqc3Ot
	 FF2RtPYR4n8Jc296ciHURKTDq2FHSEour83sAm4SIGeEvMqSJttxK8pRvdIQxo/p2sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAt9Uwxa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B7606A31C;
	Fri, 27 Nov 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAt9Uwxa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C91F00893;
	Fri, 27 Nov 2026 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796322;
	bh=ttcp9mL62BqPrUTMOtiA5GUX35v7XK0b+9vV9K/SM3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAt9Uwxasg4z02a1KoVOolsdOchmq2v/uaEyADWN943uk3TaHKsrxA6J4JNLeifui
	 /0pzEvaZmf9cFDvCEGfw5BmrBytXGXmRGCio98M7mngRFUgLwbd3kKCGXoKT0a3Gvt
	 69WxvKoKXntQHigCJ3DEf5SFZgxohNMz0f+d3S5QARkaA/E5tflL99ESUcTFL0o9+5
	 s4I9M32kKoubE8mRYsfux38cfLqtcWQzyUGQwsXwLtcmtOmsKnlQH4GadPNuF6V5f4
	 IXgtTg33YKv/AVF/gJ9kv4FFtkESSxbfuj6VI1PXneBy/pS5kUuYW9uFItkikafU/x
	 EBAJnL7SWbH3Q==
Message-ID: <sashiko-outbox-237867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 22/43] rtmutex: Do not stop the chain walk at an
 owner whose top waiter changed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <482c6c8e24d0aec9e9e875b14087fb465034fd6b.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <482c6c8e24d0aec9e9e875b14087fb465034fd6b.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:18:41 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rtmutex: requeue flag not reset in
  rt_mutex_adjust_prio_chain()
--

commit 93bf69b06e02028d41139b08a870313be6d420b0
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

rtmutex: Do not stop the chain walk at an owner whose top waiter changed

This commit removes the early exit checks in rt_mutex_adjust_prio_chain()
when a task has no PI waiters or when top_waiter is no longer its top PI
waiter, relying instead on rt_waiter_up_to_date() so that concurrent or
previous-step changes to the task's priority or deadline donor propagate to
the next owner.

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index c78dfe9c93fc5..b09816977d4e5 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -818,27 +818,14 @@ static int __sched rt_mutex_adjust_prio_chain(struc=
t task_struct *task,
>  		detect_deadlock =3D false;
> =20
>  	/*
> -	 * Drop out, when the task has no waiters. Note,
> -	 * top_waiter can be NULL, when we are in the deboosting
> -	 * mode!
> +	 * Do not stop at a task that has no pi waiters, or whose top pi
> +	 * waiter is not top_waiter. The previous step can have made a
> +	 * waiter on another lock the top pi waiter of the task. A waiter
> +	 * can also have left meanwhile, and its own walk can be late. The
> +	 * priority of the task changed then, and the next owner must
> +	 * follow. The test below tells whether there is something to pass
> +	 * on.
>  	 */
> -	if (top_waiter) {
> -		if (!task_has_pi_waiters(task))
> -			goto out_unlock_pi;
> -		/*
> -		 * If deadlock detection is off, we stop here if we
> -		 * are not the top pi waiter of the task. If deadlock
> -		 * detection is enabled we continue, but stop the
> -		 * requeueing in the chain walk.
> -		 */
> -		if (top_waiter !=3D task_top_pi_waiter(task)) {
> -			if (!detect_deadlock)
> -				goto out_unlock_pi;
> -			else
> -				requeue =3D false;
> -		}
> -	}
> -
>  	/*
>  	 * If the waiter priority is the same as the task priority
>  	 * then there is no further priority adjustment necessary. The

[Severity: Medium]
Does rt_mutex_adjust_prio_chain() also need to reset requeue to true on each
retry and step when detect_deadlock is enabled?

requeue is initialized to true only once at function entry, and
rt_waiter_up_to_date() sets it to false without ever setting it back to
true:

kernel/locking/rtmutex.c:rt_mutex_adjust_prio_chain() {
	...
	bool requeue =3D true;
	...
 retry:
	raw_spin_lock_irq(&task->pi_lock);
	...
	if (rt_waiter_up_to_date(waiter, task)) {
		if (!detect_deadlock)
			goto out_unlock_pi;
		else
			requeue =3D false;
	}

	lock =3D waiter->lock;
	if (!raw_spin_trylock(&lock->wait_lock)) {
		raw_spin_unlock_irq(&task->pi_lock);
		cpu_relax();
		goto retry;
	}
	...
	if (!requeue) {
		...
		goto again;
	}
}

Once rt_waiter_up_to_date() sees an up-to-date waiter with detect_deadlock
set and clears requeue, a failed raw_spin_trylock(&lock->wait_lock) drops
task->pi_lock and jumps to retry (or the walk advances to the next owner via
goto again).  If task's priority or deadline donor changes while
task->pi_lock is dropped and the other walk is preempted,
rt_waiter_up_to_date() returns false on the next pass, but requeue stays
false and the out-of-date waiter is skipped, leaving the next owner with a
stale priority or deadline donor.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D22
