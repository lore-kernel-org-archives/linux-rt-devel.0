Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800077;
	b=rOgMJKm3N9mXrbEFmHhfOIhmnqK4fChiqNYbljdQP4mGVdDxC7mmwIlh9ZdMQjqa7l6R
	 YJEcn5uaC6ltdSCLT6Ncnxe2n+zZlL9mV8UmZeXhRYo/cDsigPorXq0uz+0HX3tpfr/5e
	 Nad3H9Se/p2VvOhLL68oND/T0GZGQ1aAdfOuhevJ0LDCxsY+s4uHRKE5cNPjIBwxzX0xv
	 ocfKJeeXMtxgx2q+TXieicuBdLGnNsX3nozWRJfxPIbZywg1YGMVgDcY8wZlEA8w7r4P5
	 pvCDM98D2SapSHs+QZDD2tggluwr3DKinvqAfznw0hjOYseQr2JSaSub01oK6oSMxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800077;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JXyrYuvxJAxv7N45cI/QmVHg+ruVtzmOUBU8VqoH1xw=;
	b=SdjTN/xg332jV/ctw7nghGa6h0SxoBrQXnmY/2eDv7cJAkhjN5nBRkgpYWy7TWj9r/R/
	 TvDV29s6m51/Gn3ePqDqg1HIrkEYWyqPbfNyXvRgS0UnJrpljUTs/2i8kbUnoKMbhs+1k
	 WbAOyhHMWNqqcwjEODh9rr5r+7cpO2KmBRMqzSYc1alkicnx8ZuiJvCmafZ2TNOoDAEby
	 SuZTNRQ7fPL1knknGCKK7wAKnMC4EoWP7p46dTqXpyBvoKBMZqofQV8gJwgcfqxz3fanI
	 pg5fj5/Ju/0ok8wljtnNZjmQ6sUEGRtlVDyxvQ6M5Y/W7C2tO3LXBJORWtfaxZXhr9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DB3heLv9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D31606A33B;
	Fri, 27 Nov 2026 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DB3heLv9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE9B1F00893;
	Fri, 27 Nov 2026 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800077;
	bh=JXyrYuvxJAxv7N45cI/QmVHg+ruVtzmOUBU8VqoH1xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DB3heLv9CEHzV+ExoS6c1/gcVonRnLM+m3hACGIcliQwtvU+Ithq3vp6GcaIeHgAW
	 pypjzXW3WMw27cxVj4SvkU21Rhzs4pox8mCMV6qni4hVbq6fnwrFd57FmpuRNxXFSJ
	 LdwNf/u6wWEsvN/3YOSNfr6b6yRwIgS/iWrM0OJkdRblFBrMChZr3fiDvB02ZeudjZ
	 I2RIlvxDanw+QFEZ5WgALhGf7SwNQAt71Y2e3Q/C3OAxonGtXMNTACRdVWrYLLzHSz
	 PCNSgvs0CQBlZ1X70qvD4EsoUfhZDDbFJbzpX4o7SAEtDkf4psQX77QevKpbFMNznj
	 d0KIBhQGur7pw==
Message-ID: <sashiko-outbox-237986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 32/43] sched/deadline: Start a period for a task
 requeued onto an rt_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <108966f2fba71871167eb2108c0bb126aa2e8668.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <108966f2fba71871167eb2108c0bb126aa2e8668.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:21:16 +0000
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
- [Medium] rtmutex: race before try_to_take_rt_mutex() in
  __rt_mutex_start_proxy_lock()
--

commit d799657d6a0cd901baee2fbb5b5e3b2e122a9c25
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task requeued onto an rt_mutex

This commit adds dl_proxy_block() and invokes it in
__rt_mutex_start_proxy_lock() and task_blocks_on_rt_mutex() so that a
sleeping SCHED_DEADLINE task requeued onto an rt_mutex receives an
up-to-date deadline before trylock evaluation and waiter queueing.

> diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
> index 6bdbd36bac949..f1246efc62d3a 100644
> --- a/kernel/locking/rtmutex_api.c
> +++ b/kernel/locking/rtmutex_api.c
> @@ -342,6 +342,18 @@ int __sched __rt_mutex_start_proxy_lock(struct rt_mu=
tex_base *lock,
> =20
>  	lockdep_assert_held(&lock->wait_lock);
> =20
> +	/*
> +	 * A requeued @task sleeps, so its deadline can be stale. The trylock
> +	 * below and the waiter node both read it: update it first.
> +	 * futex_lock_pi() passes current, which is running. Its deadline is
> +	 * up to date.
> +	 */
> +	if (task !=3D current) {
> +		raw_spin_lock(&task->pi_lock);
> +		dl_proxy_block(task);
> +		raw_spin_unlock(&task->pi_lock);
> +	}
> +
>  	if (try_to_take_rt_mutex(lock, task, NULL))
>  		return 1;

[Severity: Medium]
Can a sleeping task switched to SCHED_DEADLINE after raw_spin_unlock(&task-=
>pi_lock)
still reach try_to_take_rt_mutex() with task->dl.deadline =3D=3D 0?

The same window noted for task_blocks_on_rt_mutex() exists before
try_to_take_rt_mutex().  Because task is not queued on a runqueue and
task->pi_blocked_on is still NULL, a concurrent sched_setattr() leaves
task->dl.deadline at 0 in switched_to_dl():

CPU0                                  CPU1
__rt_mutex_start_proxy_lock()
  raw_spin_lock(&task->pi_lock)
  dl_proxy_block(task)
  raw_spin_unlock(&task->pi_lock)
                                      sched_setattr()
                                        raw_spin_lock(&task->pi_lock)
                                        ...
                                        switched_to_dl()
                                          /* !dl_task_pi_blocked(task):
                                           * leaves deadline =3D=3D 0 */
                                        raw_spin_unlock(&task->pi_lock)
  try_to_take_rt_mutex(lock, task, NULL)
    rt_mutex_steal(task_to_waiter(task),
                   rt_mutex_top_waiter(lock))
      /* reads deadline =3D=3D 0 */       <-- steals lock ahead of top_wait=
er

When the rt_mutex is in the unlocked-with-waiters transition state,
try_to_take_rt_mutex() calls rt_mutex_steal() without holding
task->pi_lock, allowing task to steal the lock ahead of a deadline
top_waiter with an earlier real deadline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D32
