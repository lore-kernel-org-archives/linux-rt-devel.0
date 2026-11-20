Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184874;
	b=nC/8YMiUbVPeHra7cOzwipqZCXxcYyHw7ZJeiY/KGxofLlpq492FG8Bvn09I/QJcosO+
	 PyRSb/E9DHV/YZJKXTcNwTeZryI1rEIHZ0nU7MkDUfARR3udfHX6bhA8/GogxYR2/3oli
	 mvWjYFVT2vVx/kdxTHjW6EfRtsYk7Or1vhnaSjEZ8H2HfRAaEndNhIJsIBgb91kXX675S
	 5rO9kYWrwToohc3t/5OMu6VRp3XTK+G3Yt66kSqmVtpAJHbGvsdGi+FHg8Rv9kymeCPk8
	 Ar7IpGS8ymRR/zneyiwfU0Xmp6dr1Yn/6O8X18PHGZqHxEl4MYiyKrsyHUk0sKY4B6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fK4YY07s/4C+nY1srkLYXNmxCp1vNjcjcKP9ULyKz/k=;
	b=jj2BI8Yca3hxazwjSM0jB4vzFvRsDwKaZwP1cohlkQFGlVGaF7EEd+EEYxWQHFZAVcWP
	 UBDSl3FZRl6FHw8tiAEa334IgMoGzq9N1m5UdXJV/Gm1ds4YUpBc9t4vIbyyuxyJ1Goyp
	 iFvT00/c7uWWLkVMsvHbXiGE6UmgTIlcr56gP3tmOaZxkociJs8od+7MYAyytf6oOe4ea
	 x58DBMale4HM5JYOFwQyz2ETvsQhrPLQ1PXnA6qzPXy3gK/LCfpG2mDj/ZQjXZ1IbQfm/
	 0fifuVMfzXOjSbjCKuUpZ5NULMU1yLwONC6OzGuIujlF4oDZJHb/Dx856TshOSZm9JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cew2kGH6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C2606A326;
	Fri, 20 Nov 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cew2kGH6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280A41F000C6;
	Fri, 20 Nov 2026 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184873;
	bh=fK4YY07s/4C+nY1srkLYXNmxCp1vNjcjcKP9ULyKz/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cew2kGH6LaL4kAldLCORqV3RbuPd1yQrZwjzN/r5Dh9TfEQF0+LuJLfCYg9Du9A7j
	 6xf23t7Vj7AwN5r0biT2AA+bXcA/yd9kKHVg47XZSR/x3ug3w2jDS1Lo7kBOihddtk
	 6wPH/be8wYcnNtj/0aW/Dnu2wYhXK55VzjyA0i+P1x7qX1rU7S+/Z8R/J5UQQ0ynkp
	 j2USdiK3rmRtqvbLr3qX7LqzMpD2HA/+1weWg9U5w/rf0JxHrVZ9JPJScGqqLYJ64d
	 oGfKosqKBl8eUuxoFC+CpJXUXszCQa5mGpOozPIxqel7P0pG9oAw9DXtT1dZoK4G2G
	 s+FZ7uYJ2K4RQ==
Message-ID: <sashiko-outbox-225366@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 27/33] sched/deadline: Start a period at a deboost
 out of the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <b0c0b935fc2c40dbd924975c77e3a0132def0abf.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <b0c0b935fc2c40dbd924975c77e3a0132def0abf.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:27:52 +0000
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
- [Medium] sched/deadline: uncanceled inactive_timer on asleep deboost
  in dl_deboost()
--

commit 7130bcba22c9d38507c258ff46870cd5112cbc8d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period at a deboost out of the class

This commit starts a new period of the task's own reservation in
switched_from_dl() and cancels any armed inactive timer when a task that
was refilled from a donor during a boost leaves SCHED_DEADLINE.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c57bbc7a9536a..4c46a7aa27096 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -83,6 +83,16 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_=
se)
>  	return !RB_EMPTY_NODE(&dl_se->rb_node);
>  }
> =20
> +/*
> + * Start a period of the reservation of @dl_se now. The caller holds the=
 rq
> + * lock and has updated the rq clock.
> + */
> +static inline void dl_start_own_period(struct sched_dl_entity *dl_se)
> +{
> +	dl_se->deadline =3D rq_clock(rq_of_dl_se(dl_se)) + dl_se->dl_deadline;
> +	dl_se->runtime =3D dl_se->dl_runtime;
> +}
> +
>  #ifdef CONFIG_RT_MUTEXES
>  static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_s=
e)
>  {
> @@ -117,12 +127,8 @@ static inline void dl_note_donor_refill(struct sched=
_dl_entity *dl_se)
>   */
>  void dl_deboost(struct sched_dl_entity *dl_se)
>  {
> -	struct rq *rq =3D rq_of_dl_se(dl_se);
> -
> -	if (dl_se->dl_donor_refill) {
> -		dl_se->deadline =3D rq_clock(rq) + dl_se->dl_deadline;
> -		dl_se->runtime =3D dl_se->dl_runtime;
> -	}
> +	if (dl_se->dl_donor_refill)
> +		dl_start_own_period(dl_se);
>  	dl_drop_boost(dl_se);
>  }

[ ... ]

> @@ -4629,6 +4637,19 @@ void dl_clear_root_domains(void)
> =20
>  static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  {
> +	bool own_period =3D p->dl.dl_runtime && p->dl.dl_donor_refill;
> +
> +	/*
> +	 * The boost of a task with parameters of its own ends, and the task
> +	 * leaves the class. If the boost refilled its runtime from the
> +	 * donor's parameters, its runtime and deadline are not those of its
> +	 * reservation. task_non_contending() would mix them with its own
> +	 * dl_runtime and dl_period. Start a period of its own instead, as
> +	 * dl_deboost() does. Its 0-lag time is then now, or has passed.
> +	 */
> +	if (own_period)
> +		dl_start_own_period(&p->dl);
> +
>  	/*
>  	 * task_non_contending() can start the "inactive timer" (if the 0-lag
>  	 * time is in the future). If the task switches back to dl before
> @@ -4660,6 +4681,18 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  		if (p->dl.dl_non_contending)
>  			sub_running_bw(&p->dl, &rq->dl);
>  		sub_rq_bw(&p->dl, &rq->dl);
> +		/*
> +		 * The task blocked while boosted, after a refill from the
> +		 * donor. The timer armed then mixes the donor's runtime and
> +		 * deadline with the task's own parameters. Cancel it, and
> +		 * work out the 0-lag time of the period just started below.
> +		 * If the handler runs already, it releases the bandwidth.
> +		 */
> +		if (own_period && p->dl.dl_non_contending &&
> +		    hrtimer_try_to_cancel(&p->dl.inactive_timer) =3D=3D 1) {
> +			p->dl.dl_non_contending =3D 0;
> +			put_task_struct(p);
> +		}

[Severity: Medium]
Should dl_deboost() also cancel inactive_timer and subtract running_bw
when a donor-refilled task is deboosted while asleep in SCHED_DEADLINE?

When a boosted SCHED_DEADLINE task blocks after a donor refill,
dequeue_dl_entity() -> task_non_contending() arms inactive_timer from the
mix of the donor's runtime/deadline and the task's own parameters, and
sets dl_non_contending =3D 1.  If the boost ends while the task is still
asleep and remaining in SCHED_DEADLINE (for example, when the donor waiter
times out on the rt_mutex), rt_mutex_setprio() calls dl_deboost().
dl_deboost() starts a fresh period of the task's own reservation (whose
0-lag time is now) and clears dl_donor_refill via dl_drop_boost(), but
leaves the donor-mixed inactive_timer armed and dl_non_contending set.

This keeps rq->dl.running_bw inflated by the sleeping task's dl_bw until
the donor-mixed timer expires.  Furthermore, if the sleeping task later
leaves SCHED_DEADLINE before that timer fires, switched_from_dl() sees
dl_donor_refill =3D=3D 0 (own_period =3D=3D false) and dl_non_contending =
=3D=3D 1, so
it neither cancels inactive_timer nor calls task_non_contending() to
release the task's bandwidth from the root domain's total_bw.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D27
