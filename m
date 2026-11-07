Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018150;
	b=AmTnbp6Qyk2wr0+hNnr1ixOV1XlfbpV16YShkw1MYo5g5oEIGxhWflK7FUgcaO6D/ZUb
	 NKpgUbWVHKbXiqJhKvijmx5bp2/lAFPd0JXj37P8joe1RP0i+YkVoXzZQmttfdKm9I6oG
	 ZuR/2t1G0mT83SvzLBfPb4K5xyk1KWsqKEC+HU2TGpFKBgXm3/F9Qhy3yt5J5xhZDCzkI
	 IgQXBlnZZyPgtQlCEdi338OPTNAqrjeRVqKIIx2xm3x93mTr+DJTaphLDyRloal88aVW0
	 MBTUBmR8P8pFvq05A4iPekexJLl4CJUc7cpKOYMEqu3JdW4dok9b4a5lkrWq4B/steg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gtGVHmv7RhuVkHcOWgsQYd+MT70/un0/NtwvCeY7rt4=;
	b=HmqI3JfbF3YWShE8OhG3SdWyB8ll4oHxrdzdUfR4/N+O2GuxoFO7CsGkllWL9mYNcMO9
	 LtfmuHvQ8Civ7YHyG9M5GdzYyU83AA5y6X1O7DTpuNcQGanhOryz4Aot/FZyQ+Ydr+MdV
	 6BzzxP75aR6YVPL0XmVlqcB1hdhujoC4mcHYLoocGjEQ8aI3K5QlJyhDJvE24Z38XPgl+
	 U2dQYIUOmnxIdixpS6SEbjCAAHOIKiFjXfGnZ8oo9/p73xVSP2zuPPjH8EA3Q072VETKI
	 eTZLRoQaqW1Zhecd3BRJj714VRqWYyVVVuZHLyRPqTnZLzt6gE43X18PhR/KBdxIdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mN7XNz6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC3606A326;
	Sat,  7 Nov 2026 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mN7XNz6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B51F008A1;
	Sat,  7 Nov 2026 02:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018149;
	bh=gtGVHmv7RhuVkHcOWgsQYd+MT70/un0/NtwvCeY7rt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mN7XNz6BO4MKYAu5jG7X5nhgXweIBUDerWpIrQvcMir8Sfedo+o7N2JlrkAcrqVew
	 gpDXYmBJHOikQWKajamPInKFoaBSEfGvIHPCam0djvFETYVWLPlr9cf2lTl6rDWcA2
	 PPFh4ie95lFhMSxFC5FjLDXTENNqh3Y0iWX1QXQdMz0tfpVBHJF3zb7FcsaWDQxl4o
	 EqvZ+W1QThRUn6CIaM09Oe+xmb3d8EEnGXMGH486PeZeSWCmEmtHsUHtCVMtD3ACVz
	 NuYIG5oLd6rWHdtcS74pSj6wrkAlooRtY110vagLgwtCdLxvlJW2/J4N8xWkuqv37d
	 kDn2f7bQO4pOA==
Message-ID: <sashiko-outbox-202500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/26] sched/deadline: Rebuild the root domains'
 accounting from the task list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-15-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-15-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:22:29 +0000
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
- [Medium] sched/deadline: missing dl_bw_gen check in
  dl_add_task_root_domain()
--

commit e697aca18463b223769b3e38b19e21df9b87aad8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Rebuild the root domains' accounting from the task list

This commit moves dl_rebuild_rd_accounting() into the deadline scheduler
to walk the task list under tasklist_lock instead of iterating over
cpusets, and adds dl_accounting_mutex to serialize bandwidth admission
against rebuilds when CONFIG_CPUSETS is disabled.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6b0ec20038573..45a896a4f4615 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3705,13 +3710,71 @@ void dl_clear_root_domain(struct root_domain *rd)
>  		dl_server_add_bw(rd, i);
>  }

[ ... ]

> +void dl_rebuild_rd_accounting(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&sched_domains_mutex);
> +	lockdep_assert_cpuset_lock_held();
> +	lockdep_assert_dl_accounting_held();
> +
> +	dl_clear_root_domains();
> +
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, p) {
> +		/*
> +		 * Tested without the task's lock first, to spare the others
> +		 * the locks: a task enters the class under the locks this
> +		 * rebuild holds, or by a boost, which brings it no bandwidth
> +		 * of its own to count.
> +		 */
> +		if (dl_task(p))
> +			dl_add_task_root_domain(p);
> +	}
> +	read_unlock(&tasklist_lock);
> +}

[Severity: Medium]
Can dl_add_task_root_domain() resurrect departed bandwidth that an earlier
rebuild already dropped?

Unlike css_task_iter, for_each_process_thread() visits un-reaped
EXIT_ZOMBIE tasks.  When a SCHED_DEADLINE task on CPU X exits before its
0-lag time and stays a zombie, it remains dl_task(p) with p->dl.dl_bw > 0
and p->dl.dl_departed_cpu =3D=3D X on dl_departed_list until its
inactive_timer fires.

If CPU X goes offline, the first rebuild drops the zombie's bandwidth
because !cpu_active(X), leaving p->dl.dl_bw_gen behind at generation G.
If CPU X comes back online before inactive_timer expires, the second
rebuild (generation G + 2) skips the task in dl_clear_root_domains()
because dl_se->dl_bw_gen !=3D dl_bw_gen - 1, but then visits it in the
tasklist walk and calls dl_add_task_root_domain():

kernel/sched/deadline.c:dl_add_task_root_domain() {
	...
	if (p->dl.dl_bw_gen =3D=3D dl_bw_gen)
		goto unlock;
	if (p->dl.dl_departed_cpu >=3D 0) {
		cpu =3D p->dl.dl_departed_cpu;
		if (!cpu_active(cpu))
			goto unlock;
	}
	rq =3D cpu_rq(cpu);
	dl_b =3D &rq->rd->dl_bw;

	raw_spin_lock(&dl_b->lock);
	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
	raw_spin_unlock(&dl_b->lock);
	p->dl.dl_bw_gen =3D dl_bw_gen;
	...
}

Because p->dl.dl_bw_gen =3D=3D dl_bw_gen is false (G !=3D G + 2) and cpu_ac=
tive(X)
is now true, dl_add_task_root_domain() adds p->dl.dl_bw back into
dl_b->total_bw, over-accounting total_bw until inactive_timer expires and
causing new admissions to fail with -EBUSY or pushing total_bw past the
root domain capacity if tasks were admitted while CPU X was offline.
Checking p->dl.dl_bw_gen !=3D dl_bw_gen - 1 when p->dl.dl_departed_cpu >=3D=
 0
(matching dl_clear_root_domains()) would avoid re-adding dropped
bandwidth.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D14
