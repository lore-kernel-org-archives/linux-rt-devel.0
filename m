Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183944;
	b=jkAJVWsZ9rP0JYtq1J6TEBntlfD5/7r+uqcfZveHQI57x2zlkz/rJ4g4ohjrr7+UvSpH
	 lOwHLothbR+bg2Z8U8DcEdk5kY6JgByvIe1A4lkivirYWkhWHg0sXkRaIMGBq0pBwUP1K
	 Pn0GKLk5jrlo8n9J3LDeyywwa5bWUHhuC4xbGvG3IQAp7Hr3sm9ubhqLTojZnQc6bHU8n
	 QQvHfrvjvLIaRwYo/x7NONy/2wTuMlvSFkvZAAeoAd0mfGcHdvG3MYmlqsBqN9huB6st+
	 vhRe5Y5XzoQfZh8/A0On6IK53hX4WIelVmNBY7Bf/zBDqLolV0XBtPXU0cl5gKWBUJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/oyu+yyfZwp6ukWGk9slJ/wA+6qMKkgKzjIOhOX7IPY=;
	b=cGHNSjJPeBzK3FtBvMPJM3f/49Nuk0oZU1bmKSaYT7RItM4WkhaMJn4LuAPbOlGRIM5+
	 YhmMDbPa5elLjQHuSnGwEjIOM+kKqiEo3v3hy2xJhwPnCkMOjgM2TWWE1S3MUfNtDPC/r
	 2OycxmyXw2tV3CS5PmQgZXI2BCYc8V0KUYA1OATvbJ/nWY9Onr0U1GSoASgEqjvxG3E9Q
	 tQk4yue+h8K4JclMzWSLvPsCWTdojqapbqLWchVqtYOvHcJwCdOcCzOTU8sjdGnwVD54r
	 wP7XfuREsutiVy5ybgfzDLvZMl90l9Cc20pgic1ZJzb0u9weZb+/YidkZjDYaaxWm1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Re21vAQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ABC606A325;
	Fri, 20 Nov 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Re21vAQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8391F000C0;
	Fri, 20 Nov 2026 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183943;
	bh=/oyu+yyfZwp6ukWGk9slJ/wA+6qMKkgKzjIOhOX7IPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Re21vAQKt+1D0q7NqXKUGu5eE6OiMf0TQjQzH4+V0hEAqyRajHCrmby2WyDzX9qlA
	 LR2DQFX9RplLBeGC0MdflAjjL+Xt5MMCjFg+i+jJ2v6/v2QpewY8Obvo4bfZLVvSks
	 dcv/p3mcb06mBL97cbClgXskLPmUPvFSYCGH5OoiDvoIkHGblfaVW/6j1JHfsFrkYk
	 VVhDzeYX3upl29GnpNURTomYnYKz2JXxTTe3eFku6XZ2XnqUMK849gm5hfEGhYV7I2
	 xU+FM5Y1zLnd8hE3lGXjOJG6NMBow4Cu3Lbc+nlBkB1ItfU0+X0Fgu471WYgtCzRq+
	 6QPk+Oj5D0a2w==
Message-ID: <sashiko-outbox-225338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 15/33] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <26529637dd1398d1bce1398efa83d9b71802777f.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <26529637dd1398d1bce1398efa83d9b71802777f.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:12:22 +0000
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
- [Medium] sched/deadline: dl_task_offline_migration() ignores span on
  inactive cpus_ptr
--

commit 30bbbaf8a09d1e3ee2bdeb94517ef4083cc36f04
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep a task in the root domain that counts its bandwidth

This commit adds dl_task_bw_span() and dl_bw_def tracking so that CPU
selection paths keep a deadline task and its bandwidth in the root domain
that admitted it.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3942464be30b4..d84c403cc8223 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -956,18 +975,36 @@ static struct rq *find_lock_later_rq(struct task_st=
ruct *task, struct rq *rq);
> =20
>  static struct rq *dl_task_offline_migration(struct rq *rq, struct task_s=
truct *p)
>  {
> +	const struct cpumask *span;
>  	struct rq *later_rq =3D NULL;
>  	struct dl_bw *dl_b;
> =20
>  	later_rq =3D find_lock_later_rq(p, rq);
> +	/*
> +	 * find_lock_later_rq() looks in the root domain of @rq. Once @rq is
> +	 * offline, a rebuild attaches it to def_root_domain. That root domain
> +	 * may not count @p. Do not take @p out of the root domain that counts
> +	 * it while @p has an active CPU there.
> +	 */
> +	span =3D dl_task_bw_span(p);
> +	if (later_rq && span && !cpumask_test_cpu(later_rq->cpu, span) &&
> +	    cpumask_first_and_and(cpu_active_mask, p->cpus_ptr, span) < nr_cpu_=
ids) {
> +		double_unlock_balance(rq, later_rq);
> +		later_rq =3D NULL;
> +	}
>  	if (!later_rq) {
>  		int cpu;
> =20
>  		/*
>  		 * If we cannot preempt any rq, fall back to pick any
> -		 * online CPU:
> +		 * online CPU. Try the root domain that counts @p first.
>  		 */
> -		cpu =3D cpumask_any_and(cpu_active_mask, p->cpus_ptr);
> +		cpu =3D nr_cpu_ids;
> +		if (span)
> +			cpu =3D cpumask_first_and_and(cpu_active_mask,
> +						    p->cpus_ptr, span);
> +		if (cpu >=3D nr_cpu_ids)
> +			cpu =3D cpumask_any_and(cpu_active_mask, p->cpus_ptr);
>  		if (cpu >=3D nr_cpu_ids) {
>  			/*
>  			 * Failed to find any suitable CPU.
>  			 * The task will never come back!
>  			 */
>  			WARN_ON_ONCE(dl_bandwidth_enabled());
> =20
>  			/*
>  			 * If admission control is disabled we
>  			 * try a little harder to let the task
>  			 * run.
>  			 */
>  			cpu =3D cpumask_any(cpu_active_mask);
>  		}

[Severity: Medium]
Should dl_task_offline_migration() also fall back to an active CPU in span
when p->cpus_ptr has no active CPUs left?

In sched_cpu_deactivate(), set_cpu_active(cpu, false) and
sched_set_rq_offline() run before cpuset_cpu_inactive() updates task
cpumasks for a cpuset whose last active CPU just went offline.  If
dl_task_timer() fires in that window for a throttled task on the offlining
runqueue, p->cpus_ptr has no active CPUs even though span still has active
CPUs.

Because dl_task_offline_migration() only intersects span with p->cpus_ptr,
it triggers WARN_ON_ONCE(dl_bandwidth_enabled()) and falls back to
cpumask_any(cpu_active_mask).  With isolcpus=3Ddomain,0,1, that can pick an
isolated CPU in def_root_domain and move p->dl.dl_bw into another root
domain without an admission check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D15
