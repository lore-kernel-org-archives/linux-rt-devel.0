Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807232;
	b=b/m0Dngw03/0j9oxPS2wMFH/CJ00Iv8SSC0UOr30KNDVS2EcmzlrlVqpPSSdZxAhx+QS
	 y8OxW9auJYykHAQM05jM8DebYN6DVMmgxTTkVPJE1LSCyqY1WdsR8Lkm7CtHnaLtd5O55
	 JZ8UJUY9NTwLLHLzUtru1YifwiOWkGDs3r+WnJ0rN3cS/U+/ug7GSkT+G6swySdtoWC1F
	 5gfDtMkEROrwMqOKeFOOyCuFEHImQFBJAe3QeLtLk49i82l+ViAcCqbVd9KodUTMbuDPO
	 omgDWtw3+f7FID6p3oVfgc3CzE/3yuCzRgW3x1nWnuv8DhA6IfZG7b2+fe1zbHsHnqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807232;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aec1Lu6Nd3VPvPPXwOhn7jLshGozOB4bDpOOIOHYEuI=;
	b=Mn7vmoN9vY9SpOCNQayHeY9gZnLAP5jSlAS7MaJdMFnM45+MSUyR7P3TG4KhQJJIYzEZ
	 W75nctwilGngU2XCtRjuTq7gL1DuXWB94N+Jryixd5EKsdKA7c98roqE1fY5Tv4vvxJ73
	 BcAA/tRyCKU+BOqovET3O5NVyg6sN70XhujiVbrTEAHdhEXvXC2sYWSDJfYcf7DnzFJ36
	 zlPHMkIlEpMFcF03s0GS5d44qVgJX/Hym8NGWE4C5lO8AYFmowNgDDBVJkuVyDAPVvdrA
	 O2TuM18q89EW4pLGGC3ect2cs/vWAKH3OlL6sYho0/R2CuCqD0LOozFlBEmrPJz3KlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0KP84hc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C950606A328;
	Wed,  4 Nov 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0KP84hc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A251F00A18;
	Wed,  4 Nov 2026 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807231;
	bh=aec1Lu6Nd3VPvPPXwOhn7jLshGozOB4bDpOOIOHYEuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0KP84hcDWw+KWS2ofZI3jdDRPl552Szs3ckar+ftRHc1+PR6h9EkFV7vjDexYegz
	 faSnpgPmUfFUPPnjhoLL9CY1o2wUIzfZtV1ramMT+/+0GYbmKQ2i9zoyYyuFJMzz2A
	 teiJmRX8USRe+ayMgfPDvk//pMWgR0XIb0+cE2RkQU1kKLlDr27CEjJ93DHbcFgiXv
	 yclYrYocY+WvKwKcVkwToREqpTTuODJXwZrov+C7YcyUSxXyh2uWNwcddv2ykRoHeM
	 Ml83yUbly9sn7XZa5bMCzRwjDu9Jqa+bvbViICxcksFoWAXTjTNChDG3mHl6IcWT8/
	 SEdxvjHgTSSbQ==
Message-ID: <sashiko-outbox-197541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] sched/deadline: Keep departing bandwidth across a
 root domain rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <9a2c58b84302e5ed3765f773eca3c71c7d5ea7bb.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <9a2c58b84302e5ed3765f773eca3c71c7d5ea7bb.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:47:10 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] sched/deadline: bandwidth leak and underflow in switched_to_dl() o=
n PI boost
- [High] sched/deadline: dl_clear_root_domains() drops and resurrects depar=
ted bw
- [High] sched/deadline: exiting tasks lose or corrupt bandwidth across rd =
rebuild
- [High] sched/deadline: task_non_contending() uses task_cpu() instead of m=
ask CPU
--

commit e37776f3c05c45d876702021f65c587c9806cb26
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep departing bandwidth across a root domain rebuild

This commit tracks tasks that leave SCHED_DEADLINE or die before their
0-lag time on a departed list associated with a CPU of their root domain,
and uses a rebuild generation counter to preserve or release their
bandwidth across root domain accounting rebuilds.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3c57e5f5fc056..8ead9b050dfcf 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -217,6 +223,88 @@ __dl_overflow(struct dl_bw *dl_b, unsigned long cap,=
 u64 old_bw, u64 new_bw)
>  	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
>  }
> =20
> +/*
> + * A task that leaves SCHED_DEADLINE, or dies, before its 0-lag time kee=
ps
> + * its bandwidth in total_bw until then: the inactive timer removes it. A
> + * rebuild of the root domains' accounting meanwhile (dl_clear_root_doma=
ins()
> + * and dl_add_task_root_domain(), on any change of the partitions or CPU
> + * hotplug) finds no such task among the deadline tasks of the cpusets: =
it
> + * puts that bandwidth back from dl_departed_list, which holds them from
> + * their departure to their timer, in the root domain each left, found by
> + * its mask then (dl_task_root_domain_cpu()), or by the CPU it dies on: =
the
> + * CPU it last ran on may be of another one, when it was moved asleep. T=
he
> + * task may run anywhere meanwhile, as another policy; its timer holds a
> + * reference to it.
> + *
> + * dl_bw_gen counts the rebuilds, and each task records the one that last
> + * counted its bandwidth. A rebuild that dropped it since then leaves
> + * nothing to remove: the CPU recorded was no longer active, or the task
> + * exited while the rebuild ran, which the cpuset walk skips, and was not
> + * dead yet when the list was put back. Both counts, and the list, are u=
nder
> + * dl_departed_lock, taken with interrupts disabled (under the task's rq
> + * lock or pi_lock, or by the rebuild) and before any dl_bw lock.
> + */
> +static LIST_HEAD(dl_departed_list);
> +static DEFINE_RAW_SPINLOCK(dl_departed_lock);
> +static unsigned int dl_bw_gen;

[ ... ]

> +static void dl_task_release_bw(struct task_struct *p, int cpu)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +	struct dl_bw *dl_b;
> +
> +	lockdep_assert_irqs_disabled();
> +	guard(raw_spinlock)(&dl_departed_lock);
> +	if (dl_se->dl_departed_cpu >=3D 0) {
> +		cpu =3D dl_se->dl_departed_cpu;
> +		dl_se->dl_departed_cpu =3D -1;
> +		list_del(&dl_se->dl_departed_node);
> +	}
> +	if (dl_se->dl_bw_gen =3D=3D dl_bw_gen) {
> +		dl_b =3D dl_bw_of(cpu);
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(cpu));
> +		raw_spin_unlock(&dl_b->lock);
> +	}
> +	dl_se->dl_bw_gen =3D dl_bw_gen;
> +}

[Severity: High]
What happens when dl_rebuild_rd_accounting() runs while a SCHED_DEADLINE
task is in the middle of do_exit()?

In do_exit(), exit_signals() sets PF_EXITING and decrements signal->live to
0 near the beginning of task teardown, before exit_mm(), exit_files(),
exit_notify(), and cgroup_exit(), whereas do_task_dead() -> __schedule() ->
deactivate_task() -> dequeue_task_dl() -> task_non_contending() ->
dl_task_depart() only runs at the very end of do_exit().

If dl_rebuild_rd_accounting() runs during that window (or if the task
reaches do_task_dead() after dl_clear_root_domains() has walked
dl_departed_list, and unlinks from its cset before
dl_update_tasks_root_domain() walks it), dl_clear_root_domains() increments
dl_bw_gen without finding the task on dl_departed_list, and
dl_update_tasks_root_domain() calls css_task_iter_start(&cs->css, 0, &it)
without CSS_TASK_ITER_WITH_DEAD, which skips the task because PF_EXITING is
set and signal->live is 0.

Doesn't that cause three problems for an exiting deadline task?

1. Its bandwidth is dropped from total_bw while the task is still running
in do_exit() and before its 0-lag time.

2. When the task finally reaches do_task_dead() -> task_non_contending()
with zerolag_time >=3D 0, task_non_contending() unconditionally calls
dl_task_depart(p, task_cpu(p)) without checking whether p->dl.dl_bw_gen
matches dl_bw_gen. If a second rebuild runs before inactive_task_timer()
fires, dl_clear_root_domains() will add p->dl.dl_bw back into total_bw on
top of any bandwidth admitted after the first rebuild.

3. If the task is migrated while in do_exit() after the first rebuild
dropped its bandwidth (for example via set_cpus_allowed_dl() or
dl_task_offline_migration()), those paths subtract p->dl.dl_bw from the
source root domain without checking p->dl.dl_bw_gen =3D=3D dl_bw_gen
(underflowing total_bw), and dl_task_offline_migration() adds p->dl.dl_bw
to later_rq->rd->dl_bw without updating p->dl.dl_bw_gen, so
dl_task_release_bw() later skips subtracting it and leaks p->dl.dl_bw in
later_rq->rd.

[ ... ]

> @@ -449,13 +537,9 @@ static void task_non_contending(struct sched_dl_enti=
ty *dl_se, bool dl_task)
>  				sub_running_bw(dl_se, dl_rq);
> =20
>  			if (!dl_task || READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
> -				struct dl_bw *dl_b =3D dl_bw_of(task_cpu(p));
> -
>  				if (READ_ONCE(p->__state) =3D=3D TASK_DEAD)
>  					sub_rq_bw(dl_se, &rq->dl);
> -				raw_spin_lock(&dl_b->lock);
> -				__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
> -				raw_spin_unlock(&dl_b->lock);
> +				dl_task_release_bw(p, task_cpu(p));
>  				__dl_clear_params(dl_se);
>  			}
>  		}
> @@ -464,8 +548,18 @@ static void task_non_contending(struct sched_dl_enti=
ty *dl_se, bool dl_task)
>  	}
> =20
>  	dl_se->dl_non_contending =3D 1;
> -	if (!dl_server(dl_se))
> -		get_task_struct(dl_task_of(dl_se));
> +	if (!dl_server(dl_se)) {
> +		struct task_struct *p =3D dl_task_of(dl_se);
> +
> +		get_task_struct(p);
> +		/*
> +		 * Dying: its bandwidth is in the root domain of the CPU it
> +		 * runs on. switched_from_dl() records one that leaves
> +		 * SCHED_DEADLINE.
> +		 */
> +		if (READ_ONCE(p->__state) =3D=3D TASK_DEAD)
> +			dl_task_depart(p, task_cpu(p));
> +	}

[Severity: High]
Should task_non_contending() use dl_task_root_domain_cpu(p) instead of
task_cpu(p) when calling dl_task_release_bw() and dl_task_depart()?

Suppose a SCHED_DEADLINE task p is running on CPU 0 in RD_0 (or has
is_migration_disabled(p) true) while it is moved to a cpuset partition in
RD_1:

  cpuset_can_attach()
    -> reserves p->dl.dl_bw in RD_1->dl_bw.total_bw
  cpuset_attach_task()
    -> set_cpus_allowed_ptr()
      -> __set_cpus_allowed_ptr_locked()
        -> do_set_cpus_allowed()
          -> set_cpus_allowed_dl()
            -> subtracts p->dl.dl_bw from RD_0->dl_bw.total_bw
            -> updates p->cpus_mask to RD_1
        -> affine_move_task()
          -> task_on_cpu(rq0, p) or is_migration_disabled(p) is true
          -> unlocks rq0 and queues migration_cpu_stop (or waits for
             migrate_enable())

Before migration_cpu_stop runs on CPU 0 (or while migration remains
disabled), p's bandwidth is already accounted in RD_1 (matching
p->cpus_mask), but task_cpu(p) is still CPU 0 in RD_0.

If p then exits into do_task_dead() -> dequeue_task_dl() ->
task_non_contending(&p->dl, true), or switches policy via
switched_from_dl() -> task_non_contending(&p->dl, false) when zerolag_time
< 0 or hrtimer_active(&dl_se->inactive_timer) is true, passing task_cpu(p)
causes dl_task_release_bw() or dl_task_depart() to target RD_0 instead of
RD_1, underflowing RD_0->dl_bw.total_bw and leaking p->dl.dl_bw in
RD_1->dl_bw.total_bw.

[ ... ]

> @@ -3542,9 +3653,37 @@ void dl_clear_root_domain(struct root_domain *rd)
>  		dl_server_add_bw(rd, i);
>  }
> =20
> -void dl_clear_root_domain_cpu(int cpu)
> +/*
> + * Clear every root domain ahead of a rebuild of their accounting, which
> + * dl_add_task_root_domain() then fills with the deadline tasks of the
> + * cpusets: put back their servers, and the bandwidth of the tasks that
> + * left SCHED_DEADLINE, or died, before their 0-lag time, which no cpuset
> + * holds as a deadline task, in the root domain of the CPU recorded for
> + * each; dropped if it is no longer active.
> + */
> +void dl_clear_root_domains(void)
>  {
> -	dl_clear_root_domain(cpu_rq(cpu)->rd);
> +	struct sched_dl_entity *dl_se;
> +	u64 cookie =3D ++dl_cookie;
> +	struct dl_bw *dl_b;
> +	int cpu;
> +
> +	guard(raw_spinlock_irqsave)(&dl_departed_lock);
> +	dl_bw_gen++;
> +	for_each_possible_cpu(cpu) {
> +		if (!dl_bw_visited(cpu, cookie))
> +			dl_clear_root_domain(cpu_rq(cpu)->rd);
> +	}
> +	list_for_each_entry(dl_se, &dl_departed_list, dl_departed_node) {
> +		cpu =3D dl_se->dl_departed_cpu;
> +		if (!cpu_active(cpu))
> +			continue;
> +		dl_b =3D dl_bw_of(cpu);
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_add(dl_b, dl_se->dl_bw, dl_bw_cpus(cpu));
> +		raw_spin_unlock(&dl_b->lock);
> +		dl_se->dl_bw_gen =3D dl_bw_gen;
> +	}
>  }

[Severity: High]
Can dl_clear_root_domains() prematurely drop departed bandwidth in a
multi-CPU root domain and later resurrect it?

When a task departs or dies in a root domain spanning CPUs 0 and 1,
dl_task_depart() records only a single CPU in dl_se->dl_departed_cpu (for
example, CPU 1). If CPU 1 is then taken offline via sched_cpu_deactivate(1)
before the task's 0-lag time while CPU 0 remains active in the same root
domain, dl_bw_deactivate(1) succeeds if CPU 0 has enough capacity for the
root domain's total_bw. However, when cpuset_cpu_inactive() ->
dl_rebuild_rd_accounting() -> dl_clear_root_domains() runs, cpu_active(1)
is false, so dl_clear_root_domains() skips dl_se and drops its bandwidth
from the still-active root domain before its 0-lag time.

In addition, when dl_clear_root_domains() skips an entry because
!cpu_active(cpu), the entry stays on dl_departed_list with its old
dl_bw_gen. If CPU 1 becomes active again and another rebuild runs before
inactive_task_timer() fires, dl_clear_root_domains() does not check whether
dl_se->dl_bw_gen matched the previous generation before dl_bw_gen++, so it
adds dl_se->dl_bw back into dl_bw_of(cpu) and updates dl_se->dl_bw_gen =3D
dl_bw_gen after that bandwidth was already dropped.

[ ... ]

> @@ -3642,6 +3786,16 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  {
>  	cancel_inactive_timer(&p->dl);
> +	/*
> +	 * Boosted back into the class before its 0-lag time (a policy change
> +	 * released that bandwidth in sched_dl_overflow()): the inactive
> +	 * timer will not remove it, but its leaving the class again. That
> +	 * forgets the CPU recorded: moved to another root domain meanwhile,
> +	 * the task then removes the bandwidth from that one, as it did
> +	 * before departures were recorded.
> +	 */
> +	if (p->dl.dl_departed_cpu >=3D 0)
> +		dl_task_undepart(p);

[ ... ]

> @@ -3909,6 +4055,19 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  	}
>  	raw_spin_unlock(&dl_b->lock);
> =20
> +	/*
> +	 * Back before its 0-lag time, the task still has the bandwidth it
> +	 * left with, which the new one replaces: removed from the root
> +	 * domain that keeps it (dl_task_release_bw()). A rebuild cannot
> +	 * run meanwhile: the caller holds cpuset_mutex.
> +	 */
> +	if (!err && dl_policy(policy) && !task_has_dl_policy(p)) {
> +		lockdep_assert_cpuset_lock_held();
> +		if (p->dl.dl_departed_cpu >=3D 0)
> +			dl_task_release_bw(p, -1);
> +		p->dl.dl_bw_gen =3D dl_bw_gen;
> +	}
> +
>  	return err;
>  }

[Severity: High]
Does calling dl_task_undepart(p) in switched_to_dl() when a departed task
is PI-boosted cause bandwidth leaks and cross-root-domain underflows?

When a SCHED_DEADLINE task p switches to SCHED_OTHER before its 0-lag time,
switched_from_dl() arms inactive_timer, keeps p->dl.dl_runtime and
p->dl.dl_bw set, and records the origin root domain CPU in
p->dl.dl_departed_cpu via dl_task_depart(). If p is then boosted into
dl_sched_class via rt_mutex_setprio() before the timer fires,
switched_to_dl() cancels inactive_timer and calls dl_task_undepart(p),
which resets p->dl.dl_departed_cpu to -1 and removes p from
dl_departed_list without releasing p->dl.dl_bw from the origin root domain:

1. If p is switched back to SCHED_DEADLINE via sched_setattr() while still
PI-boosted (!task_has_dl_policy(p) is true), sched_dl_overflow() adds
new_bw to dl_b->total_bw and then checks:

	if (p->dl.dl_departed_cpu >=3D 0)
		dl_task_release_bw(p, -1);

Because switched_to_dl() already set p->dl.dl_departed_cpu =3D -1 (or if p
was already PI-boosted when it earlier switched from SCHED_DEADLINE to
SCHED_OTHER, so switched_from_dl() never ran), dl_task_release_bw() is
skipped and __setparam_dl() overwrites p->dl.dl_bw with new_bw, permanently
leaking the old p->dl.dl_bw in total_bw (and in rq->dl.this_bw if p was not
queued when boosted).

2. If p migrated to another root domain (RD_B) while in SCHED_OTHER and is
then PI-boosted, dl_task_undepart(p) forgets the origin root domain (RD_A)
recorded in dl_departed_cpu. When p is later deboosted in RD_B,
switched_from_dl() releases or re-departs p->dl.dl_bw from RD_B via
dl_task_root_domain_cpu(p), underflowing RD_B->dl_bw.total_bw and leaking
the bandwidth in RD_A->dl_bw.total_bw.

3. If p is sleeping when PI-boosted and the waiter times out or is
interrupted while p is still sleeping (!task_on_rq_queued(p)), deboosting p
calls switched_from_dl() with p->dl.dl_non_contending =3D=3D 0, which enter=
s:

	} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
		dl_task_release_bw(p, dl_task_root_domain_cpu(p));
		released =3D true;
	}

and releases p->dl.dl_bw immediately before p's 0-lag time.

4. If dl_clear_root_domains() runs while p is PI-boosted (so p is not on
dl_departed_list) and p is deboosted before dl_add_task_root_domain(p)
visits it, dl_add_task_root_domain(p) sees !dl_task(p) and returns early,
dropping p's bandwidth before its 0-lag time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D7
