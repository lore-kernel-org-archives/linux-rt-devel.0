Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912333;
	b=fWBwuR5jn1/DbbAut9dC+Fe5SCv24p2HyrBuVX7/PG/v/xwnxahoTr2Zm+0DQ/CY66SJ
	 kxre/1EjH+Mt3WMvX6Ff9Z+dwErOV1YbN2qNPUkAXbdbJSnX8n9GAa4l49q+/HpxDYa85
	 +fRKcfjZYZEXePN9NifYCmTUZJ2OoTwCpR5/fYEGxmfk35PJ3WSSwujomdReMjam6TOgc
	 hEJ4kL/+UeN0Iam2rfXhKzun+jyHns0eQfNog2tMpTrH03AAOvcHEWg50Gfatsh1Z3uBR
	 CE4zNxBExRUh/+C2mhCd0lWDfjnDn2zaYZLmUuCBCl/mNsDgmQ4pdLVesl9UN9b4kdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vC43Z356TqJuicgxWCHmaZbSDkPZZGittg+sJHxPzEo=;
	b=QRhCHVABQIwCAQDdyaeH8+f9xYUihfshHEqaboVtr2Te/za98XOViurAt2+cSql9rJkz
	 l96zlXmJZyJAD7u0t9tEi3Tb65el4IpVFPOzhrDrsIujUfA3Oc8G3TDQ6IEYpAiBT6FFa
	 3uay2zaDjqL8l8a2rQPe+FIxZcENoY60fNJQpGE43dyjzNUDl8m1aSa2HGGUOq0MRnyqj
	 WmJL4PUDa8IkZgBGEgB3W3e97C4oYJFdzcFUjjbwlwnAFyvCKj2AroL1Vf2PMEwjanVQ2
	 3x/EKa5g60fhbFX/d0PTX0AVNqPXLDUNjRl/q7yLiRCGaJ/t8lhunefbYEjYn3ycEkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPQmbF+9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BEC606A328;
	Thu,  5 Nov 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPQmbF+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB7B1F0089F;
	Thu,  5 Nov 2026 20:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912332;
	bh=vC43Z356TqJuicgxWCHmaZbSDkPZZGittg+sJHxPzEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPQmbF+90bTYLHZFA5HBS9TNtgBhU24zGb5anSfW1d4QSImPRkEjPxss58IqB8Qrg
	 6AJlQbMNT1Z6Afusr4y8MHRzT0GRDXAwexNWjMcKifEhuGH5XUMnc59PXYt72Byqct
	 9GzLoqNumZtbyiYzNWstozD3/QjlrrL5n+sKnM/l0FQoU9RbhCMdcPBWKJQasXQpmr
	 bmHDvt0RJf7x0U3I+2p4pvg2JJG2TwkiufGizXeNsfffaJPvG/eElDjItxyraebvuj
	 eZhCHdGJN+SM/cEN5buyDAQa8qq8aSrlcPMOcFHg6Fzd8mZVV79/87dATCUficIZGj
	 vNXhNIdIA90ag==
Message-ID: <sashiko-outbox-200171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/24] sched/deadline: Credit a rebuild to the CPU
 recorded with the task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-19-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-19-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:58:52 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sched/deadline: stale HK_TYPE_DOMAIN mask used in dl_get_task_effe=
ctive_cpus()
- [High] sched/deadline: dl_task_rebuild_cpu() drops cpu from dl_task_offli=
ne_migration()
--

commit 8fc0e93077a2156f71e1f02a2a295664e07d7e75
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Credit a rebuild to the CPU recorded with the task's bandwi=
dth

This commit adds dl_task_rebuild_cpu() so that root domain bandwidth
rebuilds credit a deadline task's bandwidth to its previously recorded
CPU when active and allowed, falling back to an active housekeeping or
cpuset-allowed CPU, or skipping the task when no active CPU is available.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a058e0c65eca4..bcf7f88b204ad 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3607,6 +3607,36 @@ static void dl_get_task_effective_cpus(struct task=
_struct *p, struct cpumask *cp
>  	cpuset_cpus_allowed_locked(p, cpus);
>  }
> =20
> +/*
> + * A CPU of the root domain that a rebuild of the accounting counts @p's
> + * bandwidth in. The one recorded with it, where it is active and the
> + * cpuset of @p allows it: that of the root domain that admitted the
> + * bandwidth, or that the last move put it in, which the cpuset alone do=
es
> + * not tell where it holds CPUs of two root domains, housekeeping ones
> + * beside the ones isolcpus=3D"domain" leaves to the default root domain=
. The
> + * record answers as well for a task whose own CPUs went offline, moved =
to
> + * an active one by dl_task_offline_migration(). Else the first active C=
PU
> + * the cpuset allows, a housekeeping one where it has any; and nr_cpu_ids
> + * where it allows none, which the isolated CPUs allow, no deadline task
> + * of theirs keeping the last of them online.
> + */
> +static unsigned int dl_task_rebuild_cpu(struct task_struct *p)
> +{
> +	struct cpumask *msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	int recorded =3D p->dl.dl_bw_cpu;
> +	unsigned int cpu;
> +
> +	dl_get_task_effective_cpus(p, msk);
> +	cpumask_and(msk, msk, cpu_active_mask);
> +	if (recorded >=3D 0 && cpu_active(recorded) &&
> +	    (cpumask_test_cpu(recorded, msk) || cpumask_empty(msk)))
> +		return recorded;

[Severity: High]
As reported by Sashiko on v2 [1], does calling dl_get_task_effective_cpus()
here still observe the lagging HK_TYPE_DOMAIN mask during cpuset partition
transitions?

In kernel/sched/deadline.c, dl_get_task_effective_cpus() checks
housekeeping_cpumask(HK_TYPE_DOMAIN):

    hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
    if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
        if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
            cpumask_andnot(cpus, cpu_active_mask, hk_msk);
            return;
        }
    }

Because cpuset_update_sd_hk_unlock() and cpuset_handle_hotplug() invoke
rebuild_sched_domains_locked() -> dl_rebuild_rd_accounting() before calling
housekeeping_update(), HK_TYPE_DOMAIN still reflects the pre-transition
isolated partitions and excludes all CPUs in any PRS_ISOLATED partition.

For example, if an isolated partition on CPUs 2-3 containing a deadline task
p admitted on CPU 2 (p->dl.dl_bw_cpu =3D=3D 2) is shrunk to CPU 3, CPU 2 re=
turns
to top_cpuset's root domain while cpuset_update_tasks_cpumask() updates
p->cpus_ptr to {3} without SCA_DL_BW_RESERVED. During the rebuild,
HK_TYPE_DOMAIN still excludes both CPU 2 and CPU 3, so
dl_get_task_effective_cpus() sets msk to {2, 3}. In dl_task_rebuild_cpu(),
cpumask_test_cpu(recorded, msk) then succeeds for CPU 2 (and the fallback
cpumask_first_and(msk, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)) would also
pick CPU 2), crediting p's bandwidth to top_cpuset's root domain instead of
def_root_domain.

Similarly, if another CPU (such as CPU 1) is isolated by isolcpus=3Ddomain,1
or in another isolated partition while an isolated partition on CPU 2
transitions from PRS_ISOLATED to PRS_ROOT or PRS_MEMBER, HK_TYPE_DOMAIN
still excludes {1, 2} during the rebuild, so dl_get_task_effective_cpus()
sets msk to {1, 2} rather than the cpuset's allowed CPUs {2}. Conversely,
because HK_TYPE_DOMAIN is built from cpu_possible_mask, if a task running on
boot-isolated CPUs in def_root_domain has offline housekeeping CPUs in
p->cpus_ptr, cpumask_intersects(p->cpus_ptr, hk_msk) evaluates to true and
falls through to cpuset_cpus_allowed_locked(), causing dl_task_rebuild_cpu()
to prefer an active housekeeping CPU over remaining active isolated CPUs in
def_root_domain when the recorded CPU goes offline.

> +	cpu =3D cpumask_first_and(msk, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT=
));
> +	if (cpu < nr_cpu_ids)
> +		return cpu;
> +	return cpumask_first(msk);
> +}
> +
>  /* The caller should hold cpuset_mutex */
>  void dl_add_task_root_domain(struct task_struct *p)
>  {
> @@ -3614,7 +3644,6 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	struct rq *rq;
>  	struct dl_bw *dl_b;
>  	unsigned int cpu;
> -	struct cpumask *msk;
> =20
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	/*
> @@ -3626,10 +3655,16 @@ void dl_add_task_root_domain(struct task_struct *=
p)
>  		return;
>  	}
> =20
> -	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> -	dl_get_task_effective_cpus(p, msk);
> -	cpu =3D cpumask_first_and(cpu_active_mask, msk);
> -	BUG_ON(cpu >=3D nr_cpu_ids);
> +	cpu =3D dl_task_rebuild_cpu(p);
> +	if (cpu >=3D nr_cpu_ids) {
> +		/*
> +		 * No active CPU to count this task's bandwidth: leave it out
> +		 * of this rebuild, where dl_bw_gen keeps its release out as
> +		 * well, until one has a CPU for it.
> +		 */
> +		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> +		return;
> +	}

[Severity: High]
As reported by Sashiko on v2 [2], can a throttled deadline task migrated by
dl_task_offline_migration() still have its bandwidth credited to the wrong
root domain or left unaccounted?

When all CPUs in p->cpus_ptr are offline, dl_task_offline_migration() sees
cpumask_any_and(cpu_active_mask, p->cpus_ptr) >=3D nr_cpu_ids and falls bac=
k to
cpumask_any(cpu_active_mask), moving the task and p->dl.dl_bw_cpu to an
active CPU while p->cpus_ptr still contains only the offline CPUs.

In dl_task_rebuild_cpu(), the check preserving recorded when the task's own
CPUs are offline tests cpumask_empty(msk), where msk is the result of
dl_get_task_effective_cpus(p, msk) & cpu_active_mask rather than
p->cpus_ptr & cpu_active_mask. If other CPUs in msk remain active outside
p->cpus_ptr (for instance, with isolcpus=3Ddomain,1,2 when p is affined to
CPU 1 and CPU 1 goes offline while CPU 2 stays online, or when p is pinned
to one CPU of a multi-CPU cpuset with admission control disabled and moved =
to
another partition's CPU), msk is non-empty ({2}) and does not contain the
fallback CPU recorded by dl_task_offline_migration() (such as CPU 0).
dl_task_rebuild_cpu() then rejects recorded and credits p's bandwidth to
CPU 2's root domain while p runs on CPU 0.

Additionally, during CPU deactivation in sched_cpu_deactivate(),
cpuset_cpu_inactive() runs dl_rebuild_rd_accounting() immediately after
sched_set_rq_offline(), before a throttled task's hrtimer fires
dl_task_timer() -> dl_task_offline_migration(). If the deactivated CPU was
the task's last active CPU in msk, dl_task_rebuild_cpu() returns nr_cpu_ids
and dl_add_task_root_domain() returns early without updating
p->dl.dl_bw_gen. When dl_task_timer() subsequently fires and calls
dl_task_offline_migration():

    scoped_guard (raw_spinlock, &dl_departed_lock) {
        if (p->dl.dl_bw_gen =3D=3D dl_bw_gen) {
            ...
            __dl_add(dl_b, p->dl.dl_bw,
                     cpumask_weight(later_rq->rd->span));
            raw_spin_unlock(&dl_b->lock);
        }
        p->dl.dl_bw_cpu =3D later_rq->cpu;
    }

Because p->dl.dl_bw_gen !=3D dl_bw_gen, doesn't dl_task_offline_migration()
skip adding p->dl.dl_bw to later_rq->rd->dl_bw, leaving the migrated task's
bandwidth unaccounted until another root domain rebuild occurs?

[1] https://lore.kernel.org/r/sashiko-outbox-198343@kernel.org
[2] https://lore.kernel.org/r/sashiko-outbox-198343@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D18
