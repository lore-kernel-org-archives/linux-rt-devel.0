Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657313;
	b=noZA/VvYy9GHchtENv+9d9ovYUgTddpgpAP1bOrPCy52qoCGuPNJJ2IyBfpJljSkhlAv
	 4YsbixUfKAgQt1ty6iq7yvl2u8YPurBIKaMDBNDd9iO+tkzWtmMYcAfiUvqB7FirQWvxp
	 JH+kbPzhpqKnPpqNOxbRacGz9jiLE8T/YT//N6qQ9AhEEJcScuUGxJTW/F30GJBPM+40R
	 3Y3L6JtmzQ/ZQgmRH7WgYnuVkoS0Hv+18FcTvBCm6ya2LpNWyZpydKSkzn7NHFKA/5h7j
	 iDiQUp/Y/i3JfIJrNq5X5w95qbDrMvOKM6dxP63ilyzo7hmyMIJKOX4sXyuZtxIt0QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657313;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tPyPOhu9AaWWXOBWE2nSNiLeRaBmDPFB2m7ibTx7FFk=;
	b=QApUTcH3dzAZ/eshzn5lpaE/0e7uM9tcTVc/moW9ZsPH3s2wc68WodtGfBlmrpVcI1YF
	 E2yjtiCAdJXclapMRUsRq6+HXzzgxPQkUvbADpe76taeXOOIwx2YvvDLPT4mrRTPLYA3Z
	 c5ehbuyKKZ+L44S6qNd5ZwrHdbBiMHRzVuBXgFgCoIiuwydZK46ThYhc0o4FrjFr7E+Ou
	 VVPIiUdbsq9VodiU0w0ooLfbBG98w6BDsOHK0lJVkrosHNBR9XIyyRN7JSJmv4VF6/Gjj
	 vdz8KG2feGWHW5LZaD49ZPorKJcQWGPgoPjcP/wgYLZF1AN25+Sfgq5QNkd4tOTM3jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyIKi5Rm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16906606A31E;
	Thu, 26 Nov 2026 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyIKi5Rm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AA21F000C6;
	Thu, 26 Nov 2026 01:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657312;
	bh=tPyPOhu9AaWWXOBWE2nSNiLeRaBmDPFB2m7ibTx7FFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WyIKi5RmMUXxP0WgzQSuMMNol1+HyFDXTs3dB4iiIKrxi6EV52JNIdrOW/1Vdw03G
	 kt4s/g/USw+ovg4+PCQiyr5yEr3BuJaCKsWhg74Ly8xQdXmxerUQW7GoDJ9qR4AG+4
	 t3u2dv0s0vsNU5lhKaXxmNnIu/rl2cKz0Tujg7kjS3DXZ+9XSaddPaO5dpHkWVViOY
	 RqoC8bS8mBOdF6YSz3HHGOetq/xSWc8UkmzfU1TJBOrNt3oLsMlNvffuwXqkpNIZdz
	 mo/FjMlSW/cHJiM+3fU8XjX5p62U53Rn3gDtuC8mWDGqJNldsO4wPv3xHLv6mWFBjz
	 n1SOfv5JGNFzQ==
Message-ID: <sashiko-outbox-234578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 17/43] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <2a3cf1f221564450a14f75f0f4eeebc3379a992e.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <2a3cf1f221564450a14f75f0f4eeebc3379a992e.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:41:52 +0000
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
- [Medium] cgroup/cpuset: unnecessary hierarchy and task walks in
  dl_tasks_keep_*()
- [Medium] cgroup/cpuset: dl_tasks_keep_without() omits pending CPUs for
  PRS_ISOLATED
--

commit 0cb8536a44f47c8f95c649627afa6a220c61e952
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Refuse to take a deadline task out of its root domain

This commit refuses cpuset CPU mask updates and invalidates partitions that
would move a deadline task out of the root domain accounting its bandwidth.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 37d04b08996ec..67b2429c0e22f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -1148,6 +1181,91 @@ static void effective_cpus_below(struct cpuset *cp=
, struct cpuset *from,
>  	}
>  }
> =20
> +/*
> + * A scratch mask for dl_tasks_keep_without(). Its callers still need ea=
ch
> + * mask of their struct tmpmasks after the call. Protected by
> + * cpuset_mutex.
> + */
> +static cpumask_var_t dl_keep_cpus, dl_pending_cpus;
> +
> +/*
> + * Return false if a partition that takes the CPUs of @xcpus makes a
> + * deadline task leave the root domain that counts its bandwidth. A cpus=
et
> + * can hold CPUs of two root domains: with isolcpus=3D"domain", or on cg=
roup
> + * v1 with sched_load_balance off. Such a task would run in a root domain
> + * that did not admit it.
> + *
> + * @root is the partition root that gives the CPUs. @part is the cpuset
> + * that takes them. In the same change, @part can give the CPUs of @gives
> + * back to @root. @gives is NULL if it gives none back.
> + *
> + * Work out the new CPUs of each cpuset of @root from the top down, as
> + * update_cpumasks_hier() does, down to the next partition roots. If
> + * @enable, @part becomes a partition root. Then do the same for its own
> + * cpusets, starting from the active CPUs of @xcpus.
> + */
> +static bool dl_tasks_keep_without(struct cpuset *root, struct cpuset *pa=
rt,
> +				  const struct cpumask *xcpus,
> +				  const struct cpumask *gives, bool enable)
> +{
> +	struct cpumask *new_cpus =3D dl_keep_cpus, *pending =3D NULL;
> +	struct cgroup_subsys_state *pos_css;
> +	struct cpuset *cp;
> +	bool keep =3D true;
> +
> +	lockdep_assert_cpuset_lock_held();
> +	/*
> +	 * The CPUs of @root can have changed before the rebuild of the
> +	 * sched domains, which ends the change. Then the root domain of a
> +	 * task of @root does not span them yet. The rebuild gives the CPUs
> +	 * of a root partition to one root domain.
> +	 */
> +	if (root->partition_root_state =3D=3D PRS_ROOT) {
> +		pending =3D dl_pending_cpus;
> +		cpumask_copy(pending, root->effective_cpus);
> +		if (root =3D=3D &top_cpuset)
> +			cpumask_and(pending, pending,
> +				    housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
> +	}

[Severity: Medium]
Should pending also be populated when root->partition_root_state is
PRS_ISOLATED (or via is_partition_valid(root))?

An isolated partition root can have an invalid child isolated partition and
hold deadline tasks counted in def_root_domain.  When that isolated parent
grows to include a new CPU before rebuild_sched_domains_locked() runs at
the end of the change, def_root_domain.span does not include the new CPU
yet.  Because pending is left NULL here, re-evaluating the child during
update_cpumasks_hier() -> update_parent_effective_cpumask() rejects the
child with PERR_DLTASK even though the rebuild will attach the parent's new
CPU to def_root_domain.

> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cp, pos_css, root) {
> +		if (cp =3D=3D part || (cp !=3D root && is_partition_valid(cp))) {
> +			pos_css =3D css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +		/* The CPUs that @root has after the change. */
> +		cpumask_copy(new_cpus, root->effective_cpus);
> +		if (gives) {
> +			cpumask_or(new_cpus, new_cpus, gives);
> +			cpumask_and(new_cpus, new_cpus, cpu_active_mask);
> +		}
> +		cpumask_andnot(new_cpus, new_cpus, xcpus);
> +		effective_cpus_below(cp, root, new_cpus);
> +		if (cpumask_equal(cp->effective_cpus, new_cpus))
> +			continue;
> +		keep =3D dl_tasks_keep_cpus(cp, new_cpus, pending);
> +		if (!keep)
> +			break;
> +	}

[Severity: Medium]
Does dl_tasks_keep_without() (and dl_tasks_keep_root_domain() below) walk
the cpuset hierarchy and iterate every task in affected cpusets even when
no deadline tasks hold bandwidth or admission control is disabled?

Commit "sched/deadline: Keep the last CPU a task has in its root domain"
earlier in this series guards dl_cpu_last_of_task() with
!dl_bandwidth_enabled() || !atomic_read(&dl_nr_bw_tasks), whereas here
dl_bandwidth_enabled() is only checked per task inside
dl_task_keeps_root_domain() after css_task_iter has already locked
css_set_lock and pinned each task, and dl_nr_bw_tasks is not checked.

In addition, when cpumask_equal(cp->effective_cpus, new_cpus) is true in
either function, continuing without advancing pos_css =3D
css_rightmost_descendant(pos_css) visits all descendants of an unchanged
subtree even though their effective_cpus cannot change either.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D17
