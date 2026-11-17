Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927356;
	b=f0tGwLzdbOJv/rnJbIxjHSvVsRNe2fYxuO0bYgZbLnThN2d4P3ycCjBMJAVyB3P6+fzn
	 Tb++zced69sFj+qiUfaIq2ByvC8YbHlbTSnxuEkwfqZSBTM6tIxjUh46znB4+r/jfI+z3
	 c9h51LNY+xH+wSQBaslAy8J/jmISoFEhXyznoVEbq+cvNZTOwSUxKDKjGEZ37ShcZAIRX
	 vbIL57eU4iEuNseyfGtYdn6quLEgHTSeknNXUdVAP8wamXVsaG2bSxtONrMWE0OF5PJ0P
	 Cq0hO80Y8XLZs4Sg8Y2AbdRc8w37JH/g2IrEtlvMwpCebbvLb4pgrEpRxv7HCmN+XOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R7zSTKJyVnWXJ5mA4BmMybYOxeqNTovMSx8ktxRALb4=;
	b=5plwdq+g3tE259GoR/kXWRxCt9lxYmgXasgsaJInFW8FVd0Nwv6aOoS8vnRiMBg/kfxE
	 McQcqNl9nlRvTqpQNMZJiVBMPwWwTgDPk0EEjOJavgcRPTK3wXVIYv5+SHe6KJfZkWPo7
	 u5CVdsWyG7oavsBU8gDHL/1R2tKLxTWhCCb5mrcdvwz0a9G9Ue7dHE+wJQXDz6mYE0x5i
	 d2artQ5txHVYyKJPnjSiDX+pS5MQqssge/SRSZIAA20r3kfwrRlnNKozMVNy1cN4XT8YX
	 PKf5+FCfDtifQobyixyx/pERbww+scZwOgnJjv+cQ5WoNNoJteg0RJ/MRHTk6glAeEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMDNH0e2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813A606D7C7;
	Tue, 17 Nov 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMDNH0e2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6011F000C5;
	Tue, 17 Nov 2026 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927356;
	bh=R7zSTKJyVnWXJ5mA4BmMybYOxeqNTovMSx8ktxRALb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMDNH0e235OzQ/Ktw1SPJJS/Njumdc/A8VtpKU4J86qNjSnbf7kvFAX/qGL1VdU9H
	 OxW5LGP45CMaC3wCjWd8PDHbjE1zvoupck5/mLUmmTP8R5x4uMo+1leXmpfJjT1pkh
	 X6jpf0pDBBY9wO1pMMzixl5VI2v3aqwGAVT6ctdQyXM8IdMJdy7h7Ew4+xnqUYyH0x
	 Vvuflewpqm3m9j0Xcbs2ovYm5MhOeq4UoQmACnGHCS322t5OUA2g+j8jrGqqAPBikQ
	 QACNU8180d3DQ/whGDK3tmu2tBv/GCTSbBr1c+efrn2an7GwWaa6v4B5dT2YK5OVc0
	 rkQgm+IKr24gw==
Message-ID: <sashiko-outbox-219003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/40] sched/deadline: Reset the deadline and the
 runtime with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <2931e871568442196444a57d784b64c04f57f968.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <2931e871568442196444a57d784b64c04f57f968.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:55:55 +0000
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
- [Medium] sched/deadline: donor runtime kept in switched_from_dl() when
  dl_runtime !=3D 0
--

commit c6cd5264704d8a0de90183dbd3576cbeaa15e19c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the deadline and the runtime with the parameters

This commit resets a deadline entity's dynamic deadline and runtime in
__dl_clear_params() and in switched_from_dl() when a boosted task with no
parameters of its own leaves SCHED_DEADLINE, so that its next entry into
the class starts a new period.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 71b1c155c2424..d6d2657dcddd6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3569,6 +3569,16 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(&p->dl, false);
> =20
> +	/*
> +	 * A task with no parameters of its own was boosted into the class.
> +	 * Its deadline and runtime are the donor's. Reset them, so that its
> +	 * next entry into the class starts a new period.
> +	 */
> +	if (!p->dl.dl_runtime) {
> +		p->dl.deadline =3D 0;
> +		p->dl.runtime =3D 0;
> +	}

[Severity: Medium]
Can a task deboosting via switched_from_dl() still retain a donor's
deadline and runtime when p->dl.dl_runtime is non-zero?

If a SCHED_DEADLINE task holding an rt_mutex contended by a deadline
waiter changes policy to SCHED_OTHER, __setscheduler_dl_pi() keeps it
boosted in dl_sched_class with its non-zero p->dl.dl_runtime while setting
p->dl.pi_se to the donor.  When its runtime is replenished while boosted,
replenish_dl_new_period() refills p->dl.deadline and p->dl.runtime from
the donor's reservation.

At unlock, rt_mutex_setprio() invokes switched_from_dl() before calling
dl_drop_boost(&p->dl).  Because p->dl.dl_runtime is non-zero,
switched_from_dl() skips resetting p->dl.deadline and p->dl.runtime, and
task_non_contending() computes zerolag_time by mixing the donor's dynamic
deadline and runtime with p's static dl_period and dl_runtime.  If the
donor's runtime makes zerolag_time negative, task_non_contending() clears
p's bandwidth and parameters before its true 0-lag time; otherwise, p
keeps the donor's runtime and can consume it on top of its own reservation
if it re-enters SCHED_DEADLINE before the inactive timer fires.

Commits "sched/deadline: Reset the donor's runtime at a deboost in the
class" and "sched/deadline: Check the runtime of a task whose parameters
change" later in this series handle deboosts that stay in dl_sched_class,
but do not cover leaving dl_sched_class via switched_from_dl() with
non-zero p->dl.dl_runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D10
