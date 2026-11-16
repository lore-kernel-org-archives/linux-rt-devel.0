Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858461;
	b=4kVfSaIgOTqzlkT0I+s7uQhSc0AfGwnGX0nrHp5nfQDDk7yZ+YwyJ/d/m/9Iv42o92+p
	 jTw/Tf3u62mSHmGgaq4X1hlFuHGjETLywXxFySObNfHt5I7jqccvfwYtrjz4JzlzzhWv8
	 fTRZ4i02mAx/PCoogrz1PihaneEEk+FJYqbPl7e7NWlmzMQtPsrEWx1poixat9iPOTc4Y
	 CnvVmYW7obCAPWw/rCg0PvJaKXQ3ll8BHK/2pYhfnZC5V/bHZE/J4k5MeK0dVrv5WAdM6
	 xRyjN9CO+5MvLSuiqZ0qL+3vB4NFjjLSAi6QbjmcMvU3HZluGM3104vyyAiRmm1mP9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L0zwR5x8kplTJ19R1oB6/sukw04QJPkLje3ObmX7HUo=;
	b=Bhd9KE/wmln6n//lCsjUlU7r2eNSOW5ZKzWSlLnG3QQfUtjdRExf44sYhZwG7FYT/FVE
	 Uc90M4Kr/FwRL/Bm1dAqS3CI0PkaCGvQLag5JRMlEiQF7uDbGSNHIw62MwBOkW47dJ3/0
	 mtzCIBZPAVS21PQdmdW0SdVHqbsROiP2w9vTAMYndbXXEjcmk4+/ycFppQyygKS4uEbbe
	 BLnPocURWmynoE4oqy8yJnPnTnWku/aztAnbi7KoImgE8n8Q+V6WGYgKf1ssE/WiQzzwe
	 eUzbKkC+Hv/Qnl3xS6R3hUZxk0OVh6qU+JR8CvNAwLHFHFEj0mI2ToT8GNjKdTN9ksg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzrGWouY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49692606A335;
	Mon, 16 Nov 2026 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzrGWouY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45BC1F000CD;
	Mon, 16 Nov 2026 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858461;
	bh=L0zwR5x8kplTJ19R1oB6/sukw04QJPkLje3ObmX7HUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FzrGWouYqvPPvRPqhLSR5B7Y4rwApyISmpTxCnOTHBa8XZ/q5KUUuGv5XJmK4ox/K
	 6wgK8uSWlZxu+k6ls/DWFpPlIHsbG5pJXEvWYZ8xAiyymeoS1D9NiAyr2N64leF4F5
	 myMIU4PSGWcvMCqB9EzgleNZdSNk9/rstVzaWgiG8cu3adVebgCxnJLwHuyOYlmyPi
	 abm4dDF1TamyBuibVCjea0XMW8+RUxsJGoeaj/94O18qjP+AA4esyKUbok11HquCSL
	 Xso6QxC8xtzMASUfjwp6c0e6irVrUkGp88qxvN4dh+X9KjMNXDAUirJllyG0pYVTq+
	 bHMMb+mLDhl/Q==
Message-ID: <sashiko-outbox-217613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 25/37] sched/deadline: Move a task's bandwidth to the
 root domain it runs in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-26-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-26-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:47:40 +0000
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
- [Medium] sched/deadline: missing cpu_active() check in
  dl_task_move_bw()
--

commit 1138754ab6e05269e8ea3d708fa33a8aa8f05601
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Move a task's bandwidth to the root domain it runs in

This commit moves a deadline task's bandwidth to the root domain of its
target CPU during migration and wakeup if its bandwidth is currently
counted in another root domain or was left out of a rebuild.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c765a403014a2..35f40185953a3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2910,11 +2910,69 @@ select_task_rq_dl(struct task_struct *p, int cpu,=
 int flags)
>  	return cpu;
>  }
> =20
> -static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __mayb=
e_unused)
> +/*
> + * Return true if the root domain of @cpu may not count the bandwidth of
> + * @p. Either another root domain counts it, or a rebuild left @p out.
> + * Test without dl_departed_lock, so that a move inside a root domain
> + * takes no lock. dl_task_move_bw() tests again under it.
> + */
> +static bool dl_task_bw_elsewhere(struct task_struct *p, int cpu)
> +{
> +	int bw_cpu =3D READ_ONCE(p->dl.dl_bw_cpu);
> +
> +	if (bw_cpu < 0 || !p->dl.dl_bw)
> +		return false;
> +	return READ_ONCE(p->dl.dl_bw_gen) !=3D READ_ONCE(dl_bw_gen) ||
> +	       cpu_rq(bw_cpu)->rd !=3D cpu_rq(cpu)->rd;
> +}
> +
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

[Severity: Medium]
Can dl_task_move_bw() move p->dl.dl_bw to def_root_domain and record an
inactive CPU in p->dl.dl_bw_cpu when new_cpu is not active?

During CPU hot-unplug, sched_cpu_deactivate() clears the outgoing CPU from
cpu_active_mask, attaches it to def_root_domain, and rebuilds root-domain
accounting so a sleeping migration-disabled deadline task is counted on an
active CPU in p->cpus_mask.  If that task wakes up before
sched_cpu_wait_empty() finishes, is_cpu_allowed() still permits the
online outgoing CPU, so ttwu_do_activate() -> task_woken_dl() calls
dl_task_move_bw() on it.

Because neither dl_task_bw_elsewhere() nor dl_task_move_bw() checks
cpu_active(), this regression subtracts p->dl.dl_bw from the active root
domain and moves it to def_root_domain, allowing the active root domain to
admit deadline tasks beyond its capacity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D25
