Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184446;
	b=Lbk80PTtXydg2SiXw3NBBxr+QikT4pj4fpyyZ0w9MImvwwgxD+s6kIv/O1xgEhADvLgP
	 ORd+veAoUafdK9ffJhHcGI/wgoRGLjnwin+o3MnLCdDcSAL02G1Qxs6cLP4owe3TLG3jG
	 LgdVxjdCb7qSmvxOddZLk9XNa3Dozi/xWitBAiAB9D0JvnUsv4xWhQFB9BBgvSEOPYdcc
	 tD9F+py10rIc1blTsQte3QIEsJR3EgZCIiG+g0Qjkagut67BRFHufYbXGvkIYYdrL+Apa
	 TxTvvCD44WFp5KMYM8wDH3qQRvsUsaLwEPk2NrgToapailgnsZuZwY8xiPXftvTig5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2jGOHL7rKwXl1jT5V7Gwe6eZMcsw3mKNVzsJCxgJguE=;
	b=jMte/PK6nH+FzQRKQ5CEsuqtPmM+1HrFlR5NsIpWPm+6EbgzHq9w9nt+0+cBGe7IzEVm
	 VcPErehW6I7f1k1m27Me9UKRgPXXr5zOs+v3jP2db71zWMmIs2CFp01JmGiznHA8C4FQM
	 6ZLZq5MkMMfFI5omAniotWL/T274xVTcR1ghsHf9J8BrwtieD+pGnhmC7g/vh/UZh6b+P
	 0zud/SdZ5lOt0+Cw/UY+jkg+J929UKFXhg6ZUXVoAim8LHGjDgBRfrAk7mYIoY5Fr2jIl
	 sQkDDWXB7TlHvYycFgSl0yY+AVHciICvHDN9yG4sDgvyN/8Bo3SiQaKTHg4GIUo8d3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzPBuscg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A172606A320;
	Fri, 20 Nov 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzPBuscg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578271F000CF;
	Fri, 20 Nov 2026 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184445;
	bh=2jGOHL7rKwXl1jT5V7Gwe6eZMcsw3mKNVzsJCxgJguE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AzPBuscg2UpG5GqPijCz57ul4N7u2zkrg2dx31xMCYrXCTovV3PJQLyAp7EiMgiq6
	 1uEyTHa1LvmxJBay3hAgoRxfwl3rbSPlA2oiIRr1YF7eJj/FsiyQ8IdvbGtMbpIVyP
	 t8EMU5L406OS/iTszaf1VfS65cJ+jjDdY9nZgiN+CI0HABv/MeAcS5ZA80/K+zpzRg
	 lu8mhcYFiK5nvBhRhwSLcU5r7KYfS7pLvZu4uvroXV6Vg9K5fV15lAB0XoTAFuf70+
	 X6ycjXLgVNGOZH46/qicPh8aXngxboPfugpo7FYDP5cFfo0fmFRoyQjov0JviKwmog
	 XTA4umdwrbw2A==
Message-ID: <sashiko-outbox-225348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 21/33] rtmutex: Continue the walk when the owner's
 top waiter changes lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <6438d828d974eeda3fc9bdf8a2caeb4392e96cd6.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <6438d828d974eeda3fc9bdf8a2caeb4392e96cd6.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:20:44 +0000
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
- [High] rtmutex: premature chain walk stop in
  rt_mutex_adjust_prio_chain()
--

commit f337380aa6d8b1a73b3aab01c70615b369f151be
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

rtmutex: Continue the walk when the owner's top waiter changes lock

This commit removes the top_waiter !=3D task_top_pi_waiter(task) check in
rt_mutex_adjust_prio_chain() so the PI chain walk continues when the
previous step changes the owner's top PI waiter to a waiter on another
lock.

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index c78dfe9c93fc5..c06261259a563 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -821,23 +821,15 @@ static int __sched rt_mutex_adjust_prio_chain(struc=
t task_struct *task,
>  	 * Drop out, when the task has no waiters. Note,
>  	 * top_waiter can be NULL, when we are in the deboosting
>  	 * mode!
> +	 *
> +	 * Do not compare top_waiter with the top pi waiter of the
> +	 * task here. The previous step can have made a waiter on
> +	 * another lock the top pi waiter of the task. The priority of
> +	 * the task changed then, and the next owner must follow. The
> +	 * test below tells whether there is something to pass on.
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
> +	if (top_waiter && !task_has_pi_waiters(task))
> +		goto out_unlock_pi;
> =20
>  	/*
>  	 * If the waiter priority is the same as the task priority

[Severity: High]
Can this !task_has_pi_waiters(task) check still stop a deboost chain walk
early and leave the next owner with a stale priority or dangling
SCHED_DEADLINE donor?

The comment assumes top_waiter is NULL in deboosting mode, which is only
true on the first step: at the end of step 1, rt_mutex_adjust_prio_chain()
sets top_waiter =3D rt_mutex_top_waiter(lock) before dropping task->pi_lock
and lock->wait_lock.

Suppose O (SCHED_OTHER) holds L2, M (SCHED_OTHER) holds L1 and blocks on
L2, and W (SCHED_DEADLINE) and X (SCHED_OTHER) both block on L1, so M and
O inherit W's deadline donor (&W->dl):

CPU0 (W)                          CPU1 (X)
sched_setscheduler(SCHED_OTHER)
  rt_mutex_adjust_pi(W)
    rt_mutex_adjust_prio_chain()
      /* step 1: task =3D W, lock =3D L1 */
      /* requeues W behind X on L1 */
      /* deboosts M to SCHED_OTHER */
      top_waiter =3D X_waiter
      unlock(M->pi_lock, L1->wait_lock)
                                  /* X times out on L1 */
                                  remove_waiter(L1, X_waiter)
                                    /* M->pi_waiters is now empty */
                                    unlock(M->pi_lock, L1->wait_lock)
      /* step 2: task =3D M, lock =3D L2 */
      lock(M->pi_lock)
      if (top_waiter &&
          !task_has_pi_waiters(M))
        goto out_unlock_pi;
/* W times out on L1 */
remove_waiter(L1, W_waiter)
  /* !is_top_waiter: returns */
/* W exits and frees task_struct */
                                  /* O still has O->dl.pi_se =3D=3D &W->dl =
*/
                                  /* before X's walk reaches O */
                                  replenish_dl_entity()  <-- use-after-free

Because step 1 demoted W below X on L1, W's own remove_waiter() sees
!is_top_waiter and returns without walking the chain, while O stays
boosted to W's deadline parameters (and can even preempt X's chain walk on
the same CPU) after W exits.

Removing the if (top_waiter && !task_has_pi_waiters(task)) check as well
lets rt_waiter_up_to_date(waiter, task) below stop the walk when the
waiter is already unboosted, while requeueing an out-of-date waiter when M
was just deboosted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D21
