Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927048;
	b=GbH1fPsq/mHKvjPo9Jc0kWZplqdN8EYWkU+aBXjuVuXhhNCZjx5X3+nQDnlmY7JdXJEL
	 p5q8MCWWmGpjT2gQ1iZf+RcKsuSG94UoLv2Us26oaMWtPR5AvxTss+xM13YvGrqia9KGi
	 ePMFRa6ED704spDtzBhaZsLVX8zi1lm5vQC7bHU7WTuOQ4oEQW3zLcro7vZ5RR50hzH0s
	 KQ/ZidWTMWjxj6WIIqicPtwowm749s2uBPQ+lXpP6S2fzzMLYn0cF1T5WAbN7gKkYp+TT
	 RwIMz/axpD0xZlsffFBzPBHFj4aC0ppgDU5UKu9+ruWbj8bAOdv3RxH1b1EySPk5J/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=39owESljnRbXAYAVd0yLP4cFyCePXzA2/ghuswqngSQ=;
	b=fabcK64N3K6fuosMxRFSxO1PM1Hzpm8GmXDjZphX+gZ8Qi8wv9w1LUZeqDS6YzXImqC8
	 u9ue3mNfht7q38wEY4VdOTpvkFkaiJ1pHZ82kCd0tL6JTGlfv77ObUF5fnYaDHc+1eo+x
	 HCKsma37qIK5nN1SEp2yZqFhCVBuRqh2udbJm/g1+PPlNwPDRErZz6hJuex/YkL3FMhyM
	 Sf+PAgaIvdLHwiSxswH7B4GlygimfxpEPmEUAZOIo62c6uRbS+LHIz4nzukBoH0eqHGFR
	 EoSIg6dhb15Br43BfwYvQWNkNj3jXe+a3rFazJQAB5aWXWqz8sAcT0hzyVnhQU+Y6wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfvhI0qL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4834606A31C;
	Tue, 17 Nov 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfvhI0qL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5D31F000C4;
	Tue, 17 Nov 2026 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927048;
	bh=39owESljnRbXAYAVd0yLP4cFyCePXzA2/ghuswqngSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jfvhI0qLknjhPKqKSC1LxhVM4jFiB6L2N4ko8BYOFj+zJoBsuAq1ouM3vTePzepgE
	 C9ZfQ8tirAweymva8a0x/Dh7cQwKp3qqrm6HB97KFMQ6bLDzpcN88fvmvoCRglux0b
	 aHVNikQHvYI8OHqRSv/ezH8ibnIVGppWcLVeRU2UmOhOLBt/SlaOyPqmFatqk0iuMY
	 TQG1Xhiya+Q6T69G0lxp0n50Wgwjk1x7OKCC4E7QSIybdEt6O2WNxn2ZVeepV0sgKS
	 Mx26q49U8e4u4HLEUSvfNPX1FWOyKnkpfx7drSZmfYH9AsxsNhD81P0BLPUp2OnfnT
	 d8TJsdQYhCMOw==
Message-ID: <sashiko-outbox-218990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/40] rtmutex: Continue the chain walk when a
 waiter's deadline donor changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <c8b228501d8981454f63843b394019fefd4002f3.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <c8b228501d8981454f63843b394019fefd4002f3.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:50:47 +0000
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

commit 9c99e3811a419d96fcdd59dd7a4617c1edc67678
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

rtmutex: Continue the chain walk when a waiter's deadline donor changes

This commit records the task's deadline donor in struct rt_mutex_waiter
and checks it in rt_waiter_up_to_date() so that priority inheritance chain
walks continue when a blocked task's deadline donor changes without
changing its sort keys.

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 5a9534c715b84..c78dfe9c93fc5 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c

[ ... ]

> @@ -824,12 +841,13 @@ static int __sched rt_mutex_adjust_prio_chain(struc=
t task_struct *task,
> =20
>  	/*
>  	 * If the waiter priority is the same as the task priority
> -	 * then there is no further priority adjustment necessary.  If
> +	 * then there is no further priority adjustment necessary. The
> +	 * task must also pass on the same deadline donor.  If
>  	 * deadlock detection is off, we stop the chain walk. If its
>  	 * enabled we continue, but stop the requeueing in the chain
>  	 * walk.
>  	 */
> -	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
> +	if (rt_waiter_up_to_date(waiter, task)) {
>  		if (!detect_deadlock)
>  			goto out_unlock_pi;
>  		else

[Severity: High]
Can rt_mutex_adjust_prio_chain() still stop one lock too early at the
preceding top_waiter !=3D task_top_pi_waiter(task) check when a task holds
two locks and its top PI waiter switches from one lock to the other?

Consider the commit message setup where O (SCHED_OTHER) holds L2, M
(SCHED_OTHER) holds L1 and L1' and blocks on L2, W (SCHED_DEADLINE,
earlier deadline) blocks on L1', and Z (SCHED_DEADLINE, later deadline)
blocks on L1, so both M and O have dl.pi_se =3D &W->dl.  If W switches to
SCHED_OTHER via sched_setscheduler() -> rt_mutex_adjust_pi(W), the first
iteration of rt_mutex_adjust_prio_chain() demotes W's waiter on L1' in
M->pi_waiters, making Z's waiter on L1 the new task_top_pi_waiter(M) and
updating M->dl.pi_se =3D &Z->dl, while step [12] records L1's top waiter:

kernel/locking/rtmutex.c:rt_mutex_adjust_prio_chain() {
    ...
	if (top_waiter) {
		if (!task_has_pi_waiters(task))
			goto out_unlock_pi;
		if (top_waiter !=3D task_top_pi_waiter(task)) {
			if (!detect_deadlock)
				goto out_unlock_pi;
    ...
	top_waiter =3D rt_mutex_top_waiter(lock);
}

On the next iteration at M, top_waiter is still W's waiter on L1' while
task_top_pi_waiter(M) is Z's waiter on L1, so the walk exits at
goto out_unlock_pi before reaching rt_waiter_up_to_date(waiter, task).
O->dl.pi_se remains &W->dl, and once W unblocks and exits, O's next
replenish_dl_entity() reads W's freed task_struct (use-after-free).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D9
