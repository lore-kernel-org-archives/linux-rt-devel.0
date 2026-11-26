Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656733;
	b=SpcfVV9/Hac+LGVsCqhEvthm/X104DJoB3IYc80W3FQw8kpIEzs0/U78Y+Sc0ju1q/LL
	 NZE3dTIeJDHT4ELldwf1XfFvXKiOkNbWSEGIPFWe0LWrYuT2orcovv3EuIbTqwyBJIP2D
	 2wyjDWKYEYAnWLK7+/z077tAqhNYIYnYo+UEDUf8VFscbfAWdfz62z1q8K1toBV4OxDHQ
	 IHjY+4pH4PKf9ZExtXdD043/9Eav/I4vp6WKoTbXBTcp2emPGghhcoaSMauGnogv2ASs4
	 anTLrSCNdcwd28eOCm2ydwntiHl+Aqe62tYNB1qQfwbNlbxtrzrtUORd+wmRUaQsHcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IeOMS4Xk3IfW0flGi3s6pj9NvgNzNZr9mxYJinJDXiU=;
	b=pii8u+A3/YWDpUnLlfScUQVaBM0u27MkbtkIARgpzLr548fKNzL5ODC67UOQX8wUi4HS
	 bEvZLibxLMdBVM9QFJvzZlur4EGA+8Ht6J7QnicC8g9OX1zAwD1A6oNypmivYaTkoTtOh
	 RCa6bJS0qvi7O2INrCFWwIs+UD5M7MUnGJWH7bvnez5uiNP83UIySjXtmuvKTZWq0dLql
	 OS8hwylwH0dH/KoAaPN+rHenFcxE4hDyzdg+NUbPjvrQr6ePhvseaucE7ZrdXUG6c7R7a
	 x44VRFb2paYiqpFu3XCBpAsjeKDs3jQT9lWKLIWN6fio5s1K3oLCS43/IdXv40xVpRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBDH9fw+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE34606A31E;
	Thu, 26 Nov 2026 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBDH9fw+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BF21F000D0;
	Thu, 26 Nov 2026 01:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656733;
	bh=IeOMS4Xk3IfW0flGi3s6pj9NvgNzNZr9mxYJinJDXiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBDH9fw+YSvVTkSHjb8QnL1zATSUz2TCpdEFqOsuYu08wWnEYEBaWeQLVjfOFXX2Z
	 AMHe/+MNJoUYpBpJATFdOqpqcTwYWu8q7gAAdXckYfUahJ4Hze51wpUX6ETePfLvMM
	 ZKpp6e4l4KEs5PNCE2w/J8qjIHZxgJDBeqIFOaBskQHLfFrTMRxsOtEikxZZpl5IdF
	 uVjN/NeeqnowA5CRtJwvanj5cLaIhWh77zWvZqHU3I+FYfGbE/da4InsPw/UovRUWF
	 qGxGAQEzJWrGU4MQgejnDr5cj1obLyLb2pIxfSDZeyvmYY6T99InNfbKezkwN9FGm+
	 7geqNuT3n0ocQ==
Message-ID: <sashiko-outbox-234553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 21/43] rtmutex: Continue the chain walk when a
 waiter's deadline donor changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <1f5dbe87dcc9405b5848044acbb7381db868418d.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <1f5dbe87dcc9405b5848044acbb7381db868418d.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:32:12 +0000
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
- [Medium] rtmutex: waiter->pi_se desynchronizes from owner->dl.pi_se
  after unlocking pi_lock
--

commit 20b64bd5f85400f14e722790295c12b998e0b8ee
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

rtmutex: Continue the chain walk when a waiter's deadline donor changes

This commit records a task's deadline donor in struct rt_mutex_waiter and
includes it in the chain-walk termination check so that donor changes on a
blocked task propagate to downstream lock owners even when the waiter's
priority and deadline sort keys remain unchanged.

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 5a9534c715b84..c78dfe9c93fc5 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -369,10 +369,12 @@ static __always_inline void
>  waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *t=
ask)
>  {
>  	lockdep_assert_held(&waiter->lock->wait_lock);
> +	lockdep_assert_held(&task->pi_lock);
>  	lockdep_assert(RB_EMPTY_NODE(&waiter->tree.entry));
> =20
>  	waiter->tree.prio =3D __waiter_prio(task);
>  	waiter->tree.deadline =3D task->dl.deadline;
> +	waiter->pi_se =3D task->dl.pi_se;
>  }
> =20
>  /*
> @@ -433,6 +435,21 @@ static __always_inline int rt_waiter_node_equal(stru=
ct rt_waiter_node *left,
>  	return 1;
>  }
> =20
> +/*
> + * Return true if @waiter is up to date with its task @task. Compare the
> + * sort keys and the deadline donor, which rt_mutex_setprio() copies from
> + * @task to the lock owner. A boost or a deboost of @task can change its
> + * donor and leave its keys as they were. The owner must then get the new
> + * donor: the old one can exit. The caller holds @task->pi_lock, which
> + * protects @task->dl.pi_se. @waiter->pi_se is never dereferenced.
> + */
> +static __always_inline bool
> +rt_waiter_up_to_date(struct rt_mutex_waiter *waiter, struct task_struct =
*task)
> +{
> +	return rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task)) &&
> +	       waiter->pi_se =3D=3D task->dl.pi_se;
> +}

[Severity: Medium]
Can waiter->pi_se get out of sync with the donor that rt_mutex_setprio()
copies to the lock owner?

In rt_mutex_adjust_prio_chain(), waiter_update_prio() snapshots
waiter->pi_se from task->dl.pi_se at [7], then drops task->pi_lock at [8]
before taking owner->pi_lock and calling rt_mutex_adjust_prio() at [11]:

kernel/locking/rtmutex.c:rt_mutex_adjust_prio_chain() {
    ...
	waiter_update_prio(waiter, task);

	rt_mutex_enqueue(lock, waiter);
	...
	raw_spin_unlock(&task->pi_lock);
	put_task_struct(task);
	...
	task =3D get_task_struct(rt_mutex_owner(lock));
	raw_spin_lock(&task->pi_lock);

	/* [11] requeue the pi waiters if necessary */
	if (waiter =3D=3D rt_mutex_top_waiter(lock)) {
		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
		waiter_clone_prio(waiter, task);
		rt_mutex_enqueue_pi(task, waiter);
		rt_mutex_adjust_prio(lock, task);
    ...
}

Because rt_mutex_adjust_prio() -> rt_mutex_setprio() reads pi_task->dl.pi_se
directly from the task rather than from the waiter, a concurrent boost and
deboost on an intermediate task M (holding L1 and L1', blocked on L2 owned
by O, already boosted by deadline task H on L1') can update O->dl.pi_se to
a new deadline waiter W on L1 while M's waiter w_M on L2 still records
&H->dl:

CPU0 (walk for H on L1')          CPU1 (W blocks on L1, then leaves)
------------------------          ----------------------------------
rt_mutex_adjust_prio_chain(M)
  raw_spin_lock(&M->pi_lock)
  [7] waiter_update_prio(w_M, M)
        w_M->pi_se =3D &H->dl
  [8] raw_spin_unlock(&M->pi_lock)
                                  task_blocks_on_rt_mutex(L1, W)
                                    raw_spin_lock(&M->pi_lock)
                                    rt_mutex_setprio(M, W)
                                      M->dl.pi_se =3D &W->dl
                                    raw_spin_unlock(&M->pi_lock)
  [10] raw_spin_lock(&O->pi_lock)
  [11] rt_mutex_adjust_prio(L2, O)
         rt_mutex_setprio(O, M)
           O->dl.pi_se =3D M->dl.pi_se
           /* O->dl.pi_se is &W->dl */
  [13] raw_spin_unlock(&O->pi_lock)
                                  remove_waiter(L1, W)
                                    raw_spin_lock(&M->pi_lock)
                                    rt_mutex_setprio(M, H)
                                      M->dl.pi_se =3D &H->dl
                                    raw_spin_unlock(&M->pi_lock)
                                  rt_mutex_adjust_prio_chain(M)
                                    raw_spin_lock(&M->pi_lock)
                                    rt_waiter_up_to_date(w_M, M)
                                      /* w_M->pi_se =3D=3D M->dl.pi_se =3D=
=3D &H->dl */
                                      goto out_unlock_pi;
                                  W exits
O refills from W->dl  <-- use-after-free

Even with commit "sched/deadline: Hold a reference on the deadline donor of
a boosted task" keeping W's task_struct alive, the chain walk still stops
early at M and leaves O running on the departed donor W's parameters instead
of H's.

Copying waiter->pi_se into waiter->pi_tree in waiter_clone_prio() and having
rt_mutex_setprio() read the donor from the top pi_waiter (or holding the
donor's pi_lock across the read) would keep waiter->pi_se and owner->dl.pi_=
se
consistent.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D21
