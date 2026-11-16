Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858299;
	b=gAKUt/55TBn1RmiziVOofbSFvcP4HjKor6WAZ8JLV9RXLccVOQHbAFMjdjepCV40T85m
	 sKRd1YaLjLmDi3sSPxn6ol1tYDYAHUVqd93hjVTAcIW4UtveOGQqJMziS/EHsCY17GvAV
	 hZa3MFXSLEZeD2P+NLENFT0K8RsK18Q+WsOig1fBhgezgrXtjcgEV/pf3wjKWW08zooiN
	 0am4KwXyn/To/iqCqItm1L41NkaeDDRiBM1DkCJ0SERqWJGeuVuFZLX6y8Bdc12dHdTcO
	 vo6JSsKPPXICR553aTL7JK4yCe7Xd8ZHexFj7C3DCCvtgYoE0VXwJ/K49oo9XsxvmgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o1fO/TN0TawiIXOevv4jOj6AmBk+euCS4j5XlM/jT3s=;
	b=tycWEYdc9eKRPqevEzlQBmfDz1W/LKGi7gmQ2FWb3I1CrUlzIuFYheiTNNN2nPFb5fiM
	 jhtlMjHMmRW22ATnbkAIFxiCBHGnTna8T8UPs1VKNd+fS+j5whxLmaTTw9C/KYGcgZyyM
	 iQQV139RvguYB9CknCsmLenYzHo3WmA/khHSWVB+6YpnYMi0/HHd2GBa+Giv47KVJYuQN
	 nSyMK1pXuwST3QFCAPnPjvH5B1o1BX56R0oi9bH7O8Dy9ZwvjUSDZdVVnyZVzfWa6jzC/
	 mxLjS2Blshf+BGz8sQ6aBGuBkjQtj+DdecHK8SIH9HD8HJMSqosMMj3+wyaBaNzCBHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eae4RWYU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B10606A89C;
	Mon, 16 Nov 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eae4RWYU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EFD1F000CA;
	Mon, 16 Nov 2026 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858298;
	bh=o1fO/TN0TawiIXOevv4jOj6AmBk+euCS4j5XlM/jT3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eae4RWYU4y8OCV3ZDEIz12Qw2yz5VYSqyQItQlzGJURLmZ0X4mDnwH6iae9+N6LCk
	 a9pNyCa2zkG/rIFCNQj3t9F39fj9Uz8k+847bafQqTzAU5VP4XwipqNWyWPQzdofM/
	 3qT9L5lcD9S+jk4zcXKz6R7rskbjP9FSOFAwgcqtKdmyVdT5UOq1zYSejA5EjO8Zo7
	 xw7O7ZgG4b3rraAfnrC/ImDmxcEhBFldI5djWj30uIXfsY2mjKUdWn9phuyOXt6ltb
	 GQsbvGGH+NumVCbla9K0zhZINbigpRSYJGwTTFOGUGXHfZfDknJiFf55C//amKws+Q
	 lb4drpxVsfYeQ==
Message-ID: <sashiko-outbox-217599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/37] sched/deadline: Record the root domain holding
 a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-17-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-17-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:44:58 +0000
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
- [Medium] sched/deadline: __sched_setscheduler() checks task_rq(p) root
  domain
--

commit 685fb9b4f51b7675ac0c8a518174590afd51eb14
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Record the root domain holding a task's bandwidth

This commit records in dl_bw_cpu a CPU of the root domain that accounts for
a deadline task's bandwidth, and updates bandwidth moves, releases,
parameter changes, and affinity checks to consult that recorded root domain
instead of task_rq(p)->rd.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ccd6426811b9e..44db625bffc32 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -4193,6 +4260,23 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  	if (new_bw =3D=3D p->dl.dl_bw && task_has_dl_policy(p))
>  		return 0;
> =20
> +	/*
> +	 * Change the bandwidth of a deadline task where it is counted: in
> +	 * the root domain of the CPU recorded with it. A task moved asleep
> +	 * has not run there yet, so the CPU it is on can be elsewhere. No
> +	 * bandwidth is counted if a rebuild dropped it, or if the task
> +	 * enters the class. A runtime below about a millionth of the period
> +	 * gives a bandwidth of 0. It counts for nothing, and no move updates
> +	 * its record. In these three cases, the root domain of the CPU the
> +	 * task is on takes the new bandwidth. The caller holds cpuset_mutex,
> +	 * or dl_accounting_mutex without cpusets, so no rebuild runs
> +	 * meanwhile.
> +	 */
> +	counted =3D task_has_dl_policy(p) && p->dl.dl_bw_cpu >=3D 0 &&
> +		  p->dl.dl_bw_gen =3D=3D dl_bw_gen;
> +	cpu =3D counted && p->dl.dl_bw ? p->dl.dl_bw_cpu : task_cpu(p);
> +	dl_b =3D dl_bw_of(cpu);
[ ... ]
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4c013caa24713..306cd8d32173b 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1185,6 +1185,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct s=
ched_attr __user *, uattr,
> =20
>  int dl_task_check_affinity(struct task_struct *p, const struct cpumask *=
mask)
>  {
> +	unsigned int cpu;
> +
>  	/*
>  	 * If the task isn't a deadline task or admission control is
>  	 * disabled then we don't care about affinity changes.
> @@ -1204,9 +1206,16 @@ int dl_task_check_affinity(struct task_struct *p, =
const struct cpumask *mask)
>  	 * if admission test is enabled, we only admit -deadline
>  	 * tasks allowed to run on all the CPUs in the task's
>  	 * root_domain.
> +	 *
> +	 * That is the root domain that counts the bandwidth of the task:
> +	 * the one of the CPU recorded with it. A task moved asleep to
> +	 * another cpuset is still on a CPU of the root domain it left. A
> +	 * bandwidth of 0 is counted nowhere, and no move updates its
> +	 * record: use the CPU the task is on.
>  	 */
> +	cpu =3D READ_ONCE(p->dl.dl_bw) ? dl_task_root_domain_cpu(p) : task_cpu(=
p);
>  	guard(rcu)();
> -	if (!cpumask_subset(task_rq(p)->rd->span, mask))
> +	if (!cpumask_subset(cpu_rq(cpu)->rd->span, mask))
>  		return -EBUSY;
> =20
>  	return 0;

[Severity: Medium]
Should __sched_setscheduler() also check the root domain of the recorded
dl_bw_cpu instead of rq->rd?

While sched_dl_overflow() and dl_task_check_affinity() are updated to look
up the root domain via dl_bw_cpu for a task moved while asleep,
__sched_setscheduler() still checks rq =3D task_rq(p) before calling
sched_dl_overflow():

kernel/sched/syscalls.c:__sched_setscheduler() {
	...
		if (dl_bandwidth_enabled() && dl_policy(policy) &&
				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
			cpumask_t *span =3D rq->rd->span;

			if (!cpumask_subset(span, &p->cpus_mask) ||
			    rq->rd->dl_bw.bw =3D=3D 0) {
				retval =3D -EPERM;
				goto unlock;
			}
		}
	...
}

When a sleeping SCHED_DEADLINE task is moved to another exclusive cpuset,
p->cpus_mask is updated to the destination cpuset while task_rq(p) stays in
the old root domain.  Because the old rq->rd->span is disjoint from
p->cpus_mask, sched_setattr() fails here with -EPERM before reaching
sched_dl_overflow().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D16
