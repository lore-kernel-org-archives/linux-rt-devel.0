Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185123;
	b=KlZ6GMxoe3JXD06BA4KXJA5YqbCc26KTqMlB2Zb/zhQe6FouUEnyJvaCQPOyqmwupt7M
	 ozYoTrx+hs35lxD43cC0iCv2wV3yzewquGWovksaOnhHS1XzKW6LPTQVLHVsIHZ9BAXHc
	 YD0BrNm1dsWhJ08sej1OJkGKPInCqg3Bg+Yiqu96W27l3/h+MYmJ3CYjakUsFvc/t5Vl8
	 TAwO9r96kcb9MDgKJt/8UcnRbckGtgU5ZV6cXbDq9m8nafnCDKpv/01k9oZ9YtEfGsWsE
	 gnB5IYwwFt5jRrUABdZGaGDgIK3u/p0ZvGb7SqElMTSFNYW2DSqNsbaI/SqrzU7bIKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Uz5jJCEooT9VSz9OEp/qQX85X8lhKjDmlTH9PJLliuc=;
	b=xXiKl3FF7hf3Kj+0XFVFu4wcJcUOT16DzAlrPttXxBbXknhGCdjSDax6ME0ZtftgHuQO
	 u0z5NSEXuJJG9d8GByw6i1I/JfNBvswYf276ypeahXuvm4i9plJ9RxMGZ2Ruph89xZiS2
	 fMrN1mDGrFgJU+8IxajQSC2z7O3j4gzGBJVNQd7P+Irn6ZOaj1YkVn31iDx48eyeyCPFU
	 PtYMZNhSJk26FtC67m8w3g6KLEUSZIt48DUbiI4Fi9oSFKPWK0qpP6L8pvu933aYRh8Qp
	 XXN95Mzf0n4C+qQSeOw39cKFSDhbJ3R/y4DF1z0UG+d25/NnbvjIySNiY2qw9GB91nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUrPFE5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0A60A2618;
	Fri, 20 Nov 2026 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUrPFE5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0031B1F00A3D;
	Fri, 20 Nov 2026 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795185123;
	bh=Uz5jJCEooT9VSz9OEp/qQX85X8lhKjDmlTH9PJLliuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUrPFE5MrgV8nG4IvksPs4RWoc+U8yJSmJoZMWiQY7mU07CmnrVHeaVnj6q0ofxId
	 vz7lZbdJXAWAE1AOSxq5UlFwOXY55iYAksyoy3v+I6HIAqjlHlJZmbwgc2HOmqHgwk
	 shnH9fPuS0/B+oi2gYyYHlU5PTvuy4qegG5L/+RiePubVE1Ur7aDa1eF36QtLgzJYL
	 FuG4GwGmCVZcsx74T/zmB53seoFXkv0uJhDhEfkmpgax0p0uZp+E0Gy2skdwxradSF
	 yJmvtrJKO+56BE88D0EHrax3AdZ1vCnEmVBtzF39Jed+eJRN0kOFptZYJzdL3xi3dv
	 Bf/spEsaCJtnQ==
Message-ID: <sashiko-outbox-225378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/33] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <4baa44df95dd38644a85999954acce718b79661b.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <4baa44df95dd38644a85999954acce718b79661b.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:32:02 +0000
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
- [Medium] sched/deadline: dl_task_keeps_root_domain() checks cpus_ptr
  instead of cpus_mask
- [Medium] cgroup/cpuset: stale root domain check in
  update_parent_effective_cpumask()
--

commit 4c72bde1a70aea14e6251ce1be702d2fe1b0466d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Refuse to take a deadline task out of its root domain

This commit rejects cpuset.cpus updates with -EBUSY and invalidates
partitions with PERR_DLTASK when a cpumask change would remove all CPUs
of the root domain accounting a deadline task's bandwidth.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ef95c730853e0..421e0bfc1c81e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -2106,10 +2232,13 @@ static int update_parent_effective_cpumask(struct=
 cpuset *cs, int cmd,
>  				}
>  				rcu_read_unlock();
>  			}
> -			if (exclusive)
> -				deleting =3D !cpumask_empty(tmp->delmask);
> -			else
> +			if (!exclusive)
>  				part_error =3D PERR_NOTEXCL;
> +			else if (!dl_tasks_keep_without(parent, cs, tmp->delmask,
> +							NULL, true))
> +				part_error =3D PERR_DLTASK;
> +			else
> +				deleting =3D !cpumask_empty(tmp->delmask);
>  		}
>  		/*
>  		 * When both cs and parent remain valid, parent's

[Severity: Medium]
Can this dl_tasks_keep_without() check fail with PERR_DLTASK against a
stale root domain span before the sched domains are rebuilt?

This branch (partcmd_update with newmask =3D=3D NULL) runs from
update_cpumasks_hier() and cpuset_hotplug_update_tasks() after
parent->effective_cpus grows, but before rebuild_sched_domains_locked() or
rebuild_sched_domains_cpuslocked() updates rd->span to include the newly
added or onlined CPUs.

If a valid non-top partition parent holding CPU 0, a deadline task on CPU
0, and an invalid child partition requesting CPU 0 (previously PERR_NOCPUS)
is expanded to CPUs 0-1, dl_tasks_keep_without() checks parent's remaining
CPU 1 against the task's pre-rebuild dl_task_bw_span() of CPU 0 and keeps
the child invalid with PERR_DLTASK.  Similarly, when a CPU comes online for
an invalid partition holding a deadline task on a fallback CPU,
dl_tasks_keep_without() tests the newly onlined CPU against the fallback
root domain span and sets PERR_DLTASK before hotplug_update_tasks() moves
the task onto the onlined CPU anyway.

[ ... ]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 2ed99b55d8a60..a21b504d467f3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -5268,6 +5268,31 @@ int dl_bw_deactivate(int cpu)
>  	return ret;
>  }
> =20
> +/*
> + * Return false if @p has CPUs in the root domain that counts its
> + * bandwidth and @new_mask holds none of them. A cpuset refuses such a
> + * mask: only a move to another cpuset makes room in another root domain.
> + * Like __set_cpus_allowed_ptr(), keep @new_mask within the affinity set=
 by
> + * the user, if they intersect.
> + */
> +bool dl_task_keeps_root_domain(struct task_struct *p,
> +			       const struct cpumask *new_mask)
> +{
> +	const struct cpumask *span;
> +
> +	if (!dl_bandwidth_enabled() || !task_has_dl_policy(p))
> +		return true;
> +	/* pi_lock also protects p->user_cpus_ptr. */
> +	guard(raw_spinlock_irqsave)(&p->pi_lock);
> +	guard(rcu)();
> +	span =3D dl_task_bw_span(p);
> +	if (!span || !cpumask_intersects(span, p->cpus_ptr))
> +		return true;
> +	if (p->user_cpus_ptr && cpumask_intersects(new_mask, p->user_cpus_ptr))
> +		return cpumask_intersects_and(span, new_mask, p->user_cpus_ptr);
> +	return cpumask_intersects(span, new_mask);
> +}

[Severity: Medium]
Should dl_task_keeps_root_domain() check &p->cpus_mask instead of
p->cpus_ptr, as dl_task_leaves_span() and dl_task_rebuild_cpu() do?

When p is scheduled out inside a migrate_disable() section,
migrate_disable_switch() sets p->cpus_ptr to cpumask_of(rq->cpu) while
p->cpus_mask retains the task's allowed mask.  If a domain rebuild (such
as switching an isolated partition covering housekeeping and isolated CPUs
back to a member cpuset) happens while p is scheduled out in
migrate_disable() on a housekeeping CPU, dl_task_rebuild_cpu() inspects
&p->cpus_mask and keeps p's bandwidth in def_root_domain.  At that point
span intersects &p->cpus_mask but not p->cpus_ptr, so
cpumask_intersects(span, p->cpus_ptr) is false and a subsequent
cpuset.cpus write can strip all def_root_domain CPUs from p, moving its
bandwidth into the housekeeping root domain without admission control when
p wakes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D17
