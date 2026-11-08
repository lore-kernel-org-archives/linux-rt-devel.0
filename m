Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166918;
	b=Up5yF+udt3JGbj9nyLB1goEseZQ7gDenYQOF9ZCgYRoQ8RjQ9sIwh9u9nbcsTxDRTbWm
	 ASUYwgp9Bn4F4xHuJzroHC5tY8Bcg4PXq/wS7qv3DXKeFNlf2UPX4AOXeDKik2S59kXGq
	 y9cFlCBHNbR8biwGdVgHQooJGDOvkEQ5ezfT2ofDDoxyAorYdfXWrh71cgKZQfOLUTy9d
	 vp1if0yT9s5FuW/b60LEyEmw0gmFbk9epBOdP1+81XDtelENLCOehIWZ0h+K0EeVF0bC4
	 eV7EZ/rMkI4u/klT1BNa2A3spu20E5S5/ZcTQiBWKcJEGMCUYFVa2AVpwHtoCNlwjVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vSPNLyed1NVfGWxpMicpkv7Zg5euZD/vPQnOQUFXZOQ=;
	b=T5hwNJ8UezJ1gEwWAPVLZLH9FNfc78uV4/SA8hLXlzSMb6BA0Rhln10qUD3yAqDJWrQf
	 1bRMr4nTKe5XQJqXpLjdznuL/nnnX7qvf3cgGp91wDg9BbUoh0FLo+km8OkkKEuAwa4px
	 mEkcSSARDqDeSOJAwr97LgPpd9jj8eiwZI0qv8Bzqo/JfjvlwXaCDlxi2MKLbn3Z66Rvn
	 LSS8sCr8TUYMoH0F/0NmrjHIHqNCdiIzYxSVgvR+rJafdBbMWPUkUtyrKsmr1i7/pN0sY
	 oS+x5GXol9SKREHr/YJZwyS2Vtu79DYTMXnQxWnv0nHOGbSS8C2phpZvwL1RpWbwwYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VC+r9Ehd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A79606A31C;
	Sun,  8 Nov 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VC+r9Ehd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF6B1F0089F;
	Sun,  8 Nov 2026 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166918;
	bh=vSPNLyed1NVfGWxpMicpkv7Zg5euZD/vPQnOQUFXZOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VC+r9EhdEwCvB7NavC3IXyUEUag/glM/R5kARUFi/Zfq7LpovKNFaN0WRp7kd95fL
	 ff0SPfPx3kswnXETOeopesa/5ueDzU3AdJ009MxeQbBsAXfruH/HC2Rx0NwuWGIjlc
	 aLMSWlFlIQSfft7uFja/orykF3g65VPnSKaLvqjKEcF5UsktsO8O2HPZG0X0SiADdn
	 fh4kA+GSalJ0f0JW2N685oYH/Hi0jPqEajJsp/RX+3qkfRGH9a19OBuMJZmQtA0tiI
	 hpqktX00xfLB/bHxDkeeHo2g1rGJvCliuq1HJww2IXv7Dvn3+Di3SQoNrZxwqJFgJu
	 7cYfPcNvyITbg==
Message-ID: <sashiko-outbox-203989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/29] sched/deadline: Move a task's bandwidth when
 it must leave its CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261108185406.1549770-24-mathieu.desnoyers@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-24-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:41:57 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] sched/deadline: stale dl_bw_cpu on same-rd return in
  dl_task_move_bw()
- [Medium] sched/deadline: missed bw move in migrate_task_rq_dl() on
  task wakeup
--

commit 83356714a4dd1213bf9ceba0a7dd4eb657180f4e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Move a task's bandwidth when it must leave its CPU

This commit moves a deadline task's bandwidth to the destination CPU's root
domain in migrate_task_rq_dl() when the task leaves an inactive or
disallowed CPU.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index bc31045e4686f..a35609a10ec5a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2873,11 +2873,54 @@ select_task_rq_dl(struct task_struct *p, int cpu,=
 int flags)
>  	return cpu;
>  }
> =20
> -static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __mayb=
e_unused)
> +/*
> + * Move the bandwidth of @p to the root domain of @new_cpu. Count it the=
re
> + * also if a rebuild left @p out. Add it even without room, since @p runs
> + * there. The caller holds the rq lock of @p, or its pi_lock for a wakeu=
p.
> + */
> +static void dl_task_move_bw(struct task_struct *p, int new_cpu)
> +{
> +	struct dl_bw *dl_b;
> +	int cpu;
> +
> +	if (dl_entity_is_special(&p->dl) || !p->dl.dl_bw)
> +		return;
> +
> +	guard(raw_spinlock)(&dl_departed_lock);
> +	cpu =3D p->dl.dl_bw_cpu;
> +	if (cpu < 0)
> +		return;
> +	if (p->dl.dl_bw_gen =3D=3D dl_bw_gen) {
> +		if (cpu_rq(cpu)->rd =3D=3D cpu_rq(new_cpu)->rd)
> +			return;

[Severity: Medium]
Does returning here without setting p->dl.dl_bw_cpu =3D new_cpu leave a sta=
le
offline or disallowed CPU recorded when the task moves within the same root
domain?

During sched_cpu_deactivate(cpu), set_cpu_active(cpu, false) and
balance_push_set(cpu, true) run before cpuset_cpu_inactive(cpu) detaches
cpu from its root domain and rebuilds bandwidth accounting.  When
balance_push() or try_to_wake_up() moves a task from the deactivating cpu
to an active new_cpu in the same root domain during that window,
cpu_rq(cpu)->rd =3D=3D cpu_rq(new_cpu)->rd still holds, so p->dl.dl_bw_cpu =
is
left pointing to the inactive cpu.  If the task then departs on new_cpu
before its 0-lag time, dl_clear_root_domains() and dl_add_task_root_domain()
see !cpu_active(p->dl.dl_bw_cpu) and drop the task's departing bandwidth
from new_cpu's root domain, or dl_task_release_bw() subtracts it from
def_root_domain once detach_destroy_domains() has run.

Updating p->dl.dl_bw_cpu =3D new_cpu before returning when the root domains
match would keep the recorded CPU valid.

> +		dl_b =3D dl_bw_of(cpu);
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
> +		raw_spin_unlock(&dl_b->lock);
> +	}
> +	dl_b =3D dl_bw_of(new_cpu);
> +	raw_spin_lock(&dl_b->lock);
> +	__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(new_cpu));
> +	raw_spin_unlock(&dl_b->lock);
> +	p->dl.dl_bw_cpu =3D new_cpu;
> +	p->dl.dl_bw_gen =3D dl_bw_gen;
> +}
> +
> +static void migrate_task_rq_dl(struct task_struct *p, int new_cpu)
>  {
> +	int cpu =3D task_cpu(p);
>  	struct rq_flags rf;
>  	struct rq *rq;
> =20
> +	/*
> +	 * The task must leave a CPU that is no longer active, or that its
> +	 * mask no longer holds. The new CPU can then be in another root
> +	 * domain. Move the bandwidth there, as dl_task_offline_migration()
> +	 * does for a throttled task.
> +	 */
> +	if (unlikely(!cpu_active(cpu) || !cpumask_test_cpu(cpu, p->cpus_ptr)))
> +		dl_task_move_bw(p, new_cpu);

[Severity: Medium]
Can this check miss the bandwidth move on wakeup when task_cpu(p) is an
active CPU that is in p->cpus_ptr by the time set_task_cpu() runs?

If a task sleeps on an active housekeeping CPU c0 (task_cpu(p) =3D=3D c0) a=
nd
has its affinity and bandwidth moved to an isolated CPU c1 while asleep,
taking c1 offline leaves the task out of the rebuild (or counted in
def_root_domain).  When the task wakes up in try_to_wake_up():

kernel/sched/core.c:select_fallback_rq() {
    ...
		case cpuset:
			if (cpuset_cpus_allowed_fallback(p)) {
				state =3D possible;
				break;
			}
			fallthrough;
		case possible:
			set_cpus_allowed_force(p, task_cpu_fallback_mask(p));
    ...
}

select_fallback_rq() widens p->cpus_ptr to include c0 before returning to
try_to_wake_up().  If it picks another housekeeping CPU c2, set_task_cpu()
calls migrate_task_rq_dl(p, c2) with cpu =3D c0, which is both active and n=
ow
in p->cpus_ptr, so dl_task_move_bw() is skipped.  If select_fallback_rq()
picks c0 itself, try_to_wake_up() sees task_cpu(p) =3D=3D cpu and skips
set_task_cpu() and migrate_task_rq_dl() altogether.  The same happens when
sched_setaffinity() (with admission control disabled) moves a sleeping task
away from c0 across a rebuild and then back to a mask containing c0 before
wakeup.  In each case the waking task runs in a root domain that does not
count its bandwidth.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108185406.1549=
770-1-mathieu.desnoyers@efficios.com?part=3D23
