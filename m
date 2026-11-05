Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913217;
	b=k0hlj+8TY6HD1A+JyB1WGlgdiVef8tpTFZbvVQNUnFNhXWN7v7NDSGFtL9FwWkbzWwic
	 5axKIPzranaR/Rk+ELjgg0rjPRQSeK2oseIy05ySe7cMdVZ4MI1VOW6rmC1m5JK+orN46
	 62dJfGTi/hf587FbRrk8vYovfzfbGWrhAWFZtCz/+4yviFrtQZL7hAp+KCkmeX1nP7GbY
	 DxNlb22zPtV1uPUq1odG3EJSwvS/j2n6mfuq2xezx5ATjLzcgcn17+JA1BmOZET/ocutS
	 +Q5m5qVSRgaHVHk0xofFEHxMn3Wel9VtGEwAMSZBVaqD9laHPWJniv1PBdpjrw7kKXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913217;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UmHX//7Wohb0Gcd1yh+Uxm9hRlUusQrSBkZoBu31kNw=;
	b=PfbLYmNBtHmlnkzwbzOzPmE5eNU0lBtPo8mQypBR0cWsb6yp7QRQI6wAe2+NDm4HRlUg
	 3Rveo9h4CGPmX3e4uvoCYBA23A+yiGp2DRy/4/lrlwDt7JcFYTkFXpjRybMIvv5qbKsti
	 H0oTNmLUN/eUazdAouxsRLrnM1kSJlh0Cb8kdps4b9SRVpP6FAWvuPDqzeoeQKdwqwOj7
	 bxNorpqLkbOdU4enil2ObI2oAkqrHp9L3hB32KRj3dAO+A+3SXLfZcl7D40MVdW0QdRxf
	 gXZSvRzOe5syw7DHV6w7eSnHpFBM8EBWwrSbspHLm/54Iw97hUGwvJqO7Mw0AAxsA4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwiEMgzA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C7606A31B;
	Thu,  5 Nov 2026 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwiEMgzA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A961F0089F;
	Thu,  5 Nov 2026 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913216;
	bh=UmHX//7Wohb0Gcd1yh+Uxm9hRlUusQrSBkZoBu31kNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwiEMgzADRnOFK3/b+bz9krDkKhY+hMnbmx7HrTivfoBgaUMBQ/XAf+2tNKlWm76J
	 woz8j1tySZEwNwxFP3r0MBHwSgBXm7/WjAGwhFN2reiPdcwCqSX68KpyNDcoSZL4RA
	 aeU2VeJXSM9xWb9aI4r6k16AadbBXdOOXx7KS1TGS6yq6yoFy7KEkqEu0Q/K5AeUiy
	 XYYRW7xfcGPvPlfPfp07Vx15GhBSpxRPN6W1dNddD6iqZ5h6IB0amnzQCx5tArVnPB
	 iDehLMXG8pb+odLYfleg0uXC60J2Zy6VX63xJj5uREBrAbf8QLU2c5AdZ5BALEm+sl
	 Ml9tRnPmIaTdQ==
Message-ID: <sashiko-outbox-200204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/24] sched/deadline: Count the bandwidth a boosted
 task is given
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-21-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-21-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:13:35 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched/deadline: uncounted bandwidth skipped in sched_dl_overflow()
--

commit 58e85ecec73a900cbca47b57215c8b485328d349
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Count the bandwidth a boosted task is given

This commit moves the runqueue bandwidth accounting update from
sched_dl_overflow() to __setparam_dl() so that tasks boosted into
SCHED_DEADLINE via priority inheritance have their new bandwidth added to
rq->dl.this_bw when their parameters are updated. It also charges new_bw wh=
en
dl_se->dl_bw_oncpu is not set and skips special SCHED_FLAG_SUGOV requests.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f772a944a3e53..746bffb03b7cb 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -4283,6 +4292,20 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
>  {
>  	struct sched_dl_entity *dl_se =3D &p->dl;
> +	u64 period =3D attr->sched_period ?: attr->sched_deadline;
> +
> +	/*
> +	 * The bandwidth of a special entity is counted on no runqueue, and
> +	 * the request tells one, the flags of the entity being those of the
> +	 * parameters it had. The rest have theirs changed here, where their
> +	 * parameters are:
> +	 * switched_to_dl() hands it to the runqueue of a task that enters
> +	 * the class, and a task that priority inheritance boosted into the
> +	 * class is in it already, so nothing dequeues it and enqueues it
> +	 * back for that.
> +	 */
> +	if (!(attr->sched_flags & SCHED_FLAG_SUGOV))
> +		dl_change_utilization(p, to_ratio(period, attr->sched_runtime));

[Severity: High]
When a sugov kthread is given a reservation of its own via sched_setattr()
without SCHED_FLAG_SUGOV, or when a deadline task whose bandwidth was dropp=
ed
by a root domain rebuild updates its parameters, what happens if the new
runtime-to-period ratio matches the existing p->dl.dl_bw?

For example, sugov_kthread_create() initializes a sugov kthread with
SCHED_DEADLINE, SCHED_FLAG_SUGOV, sched_runtime =3D 1ms, and sched_period =
=3D
10ms. In sched_dl_overflow(), the SCHED_FLAG_SUGOV check returns 0 early,
leaving p->dl.dl_bw_cpu at -1 and not adding to dl_b->total_bw, while
__setparam_dl() still sets p->dl.dl_bw to to_ratio(10ms, 1ms).

If sched_setattr() is later called on that kthread without SCHED_FLAG_SUGOV
and with the same 1:10 ratio, dl_param_changed() returns true because the
flags changed, and __sched_setscheduler() calls sched_dl_overflow():

kernel/sched/deadline.c:sched_dl_overflow() {
	...
	/* !deadline task may carry old deadline bandwidth */
	if (new_bw =3D=3D p->dl.dl_bw && task_has_dl_policy(p))
		return 0;

	counted =3D task_has_dl_policy(p) && p->dl.dl_bw_cpu >=3D 0 &&
		  p->dl.dl_bw_gen =3D=3D dl_bw_gen;
	...
}

Because new_bw =3D=3D p->dl.dl_bw && task_has_dl_policy(p) is checked before
counted, sched_dl_overflow() returns 0 early without running admission
control, adding new_bw to dl_b->total_bw, or setting p->dl.dl_bw_cpu.

__setparam_dl() then adds the bandwidth to rq->dl.this_bw via
dl_change_utilization() (or on enqueue if queued) and clears SCHED_FLAG_SUG=
OV
from p->dl.flags while p->dl.dl_bw_cpu remains -1. If the task later exits =
or
leaves SCHED_DEADLINE, dl_task_release_bw() hits:

kernel/sched/deadline.c:dl_task_release_bw() {
	...
	cpu =3D dl_se->dl_bw_cpu;
	WARN_ON_ONCE(dl_se->dl_bw && cpu < 0);
	if (cpu < 0 || dl_se->dl_bw_gen !=3D dl_bw_gen)
		return;
	...
}

The same early return in sched_dl_overflow() also skips restoring root doma=
in
bandwidth when a task whose bandwidth was dropped by a root domain rebuild
(p->dl.dl_bw_gen !=3D dl_bw_gen) changes its deadline or flags while keeping
new_bw =3D=3D p->dl.dl_bw.

Should the early return in sched_dl_overflow() require counted to be true
before skipping the root domain update when new_bw =3D=3D p->dl.dl_bw?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D20
