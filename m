Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799835;
	b=DslWL80IvFhxLQ2FgiVSYY6MDlfPU9Gx850KNksiRg8nCHB5xi2sz4qT0slIX2/+isMD
	 3NYxn4+p3Oj7O9SCMhQC3VOZdJKDUYoWBDL4KOM2aXGxJdczxxluMo7HidziMBcerW8pw
	 fyU0pdS3/DFoxTiaXuJ0zsVIDsKdysZgCiRgaAzui7B9b2yP21fsecMR7i+kYgPV/MLJZ
	 wsIYNKxLztUftE0KII1jhDUyR1S1HeZbwpr4j5f5G7KWCblLahjC9+8xWbGd1HSRkxXFd
	 OSwWFWBn37tNvnOxgMZ1pAvBm28zD1QVMIsRy1fDoj1/YJ05YzQd9tdKkdnP5pFa5rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bu2RPJeVRbnL5z1vo5s9lD3EAcTiSn64Ve67QHXyRfo=;
	b=YT82nCLBzAr4FZDsJlpPbmugWhDmRhrg2dKsC84MgafTNoXzqdDn7r6Hg+w6nYGwEZAH
	 Fz+Oq9CYVXeRN4yMsIdqE4JXLcdRN+YIafO2ESOWFR/MJGBrzgDGvQf8mxi+N1ZNM/cyQ
	 5+nu4u98GCNCMiAHxvpbaHnZfcMr380tF9AOxdZVYdwx+nPuQUrpE/C2y9RuJCxB2hF49
	 7+68IxUe1ktB90HbciccWthcUf5KQs4oa3IHxQiWDJs8EKlBPNB3nCITREFi9HRkbczQN
	 xtvkGjVpLGmMp4rkdWs8dhEUQ7YdSSTj3LRcljlclRA1qkB2HTHWdUliF8jmYtKyflw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJoHidZd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F6606A329;
	Fri, 27 Nov 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJoHidZd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2823D1F0092A;
	Fri, 27 Nov 2026 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799835;
	bh=Bu2RPJeVRbnL5z1vo5s9lD3EAcTiSn64Ve67QHXyRfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aJoHidZdi0W/znZ2pZl8oxn+YTvEF87DRpmZS99d92hago7XPDKNdMmaFPGS2UO/5
	 xGNmHwoew3q+CsBL7OYwaUTHVI1kkpH3hjVAbSxqFXjhjmDgfwR/MzAQfplhoGl5ej
	 TMj2n/se89XCLKYyM01qk5C5WAVxD45c1WHydWEnqu/W8xmqhEHtXzyQVNnajUko/o
	 NawcruPN3jQmgGtwgiTZFMJ5L7EqcmSOuoHE0izILkgCPj0hCAo5ClGeK2QGUpNExO
	 /hsFsybyfnRY4c45j8dgGnSZ4PpbGStr5SVwGwNNVtjZewdIhw4jcV5igywITawDFa
	 /YhNZoUxNH+Uw==
Message-ID: <sashiko-outbox-237979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 30/43] sched/deadline: Start a period for a task
 that enters the class blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <36173003b241b9b994997ab4edce8a5cff1895ad.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <36173003b241b9b994997ab4edce8a5cff1895ad.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:17:14 +0000
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
- [Medium] sched/deadline: missing dl_boost_blocked() call in
  __setscheduler_dl_pi()
--

commit 5b744c28d31fd000da17d32b4f44f2734f91f651
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task that enters the class blocked

This commit starts a deadline period for a task blocked on an rt_mutex
when it enters SCHED_DEADLINE via sched_setattr() or when a priority
inheritance boost gives it a new deadline donor, so that the rt_mutex
chain walk sorts its waiter using a valid deadline rather than 0.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7a3a7e755d20b..edd26b321feeb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7980,8 +7980,12 @@ void rt_mutex_setprio(struct task_struct *p, struc=
t task_struct *pi_task)
>  			if (!dl_prio(p->normal_prio) ||
>  			    (pi_task && dl_prio(pi_task->prio) &&
>  			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
> +				struct sched_dl_entity *old_donor =3D p->dl.pi_se;
> +
>  				dl_set_donor(&p->dl, pi_task);
>  				scope->flags |=3D ENQUEUE_REPLENISH;
> +				if (!scope->queued && p->dl.pi_se !=3D old_donor)
> +					dl_boost_blocked(p);
>  			} else {
>  				dl_deboost(&p->dl);
>  				/*

[Severity: Medium]
Should __setscheduler_dl_pi() also call dl_boost_blocked(p) when
!scope->queued and p->dl.pi_se changes?

kernel/sched/syscalls.c:__setscheduler_dl_pi() {
    ...
	if (dl_prio(newprio) && !dl_policy(policy)) {
		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);

		if (pi_task) {
			dl_set_donor(&p->dl, pi_task);
			scope->flags |=3D ENQUEUE_REPLENISH;
		}
	}
    ...
}

If p is blocked on an rt_mutex while already boosted in dl_sched_class by
an earlier deadline donor, and a new top waiter boosts p's lock waiter M,
__sched_setscheduler() on p can run before M's preemptible chain walk
reaches p.  __setscheduler_dl_pi() then updates p->dl.pi_se to the new
donor without replenishing p->dl.deadline (since p is not queued and stays
in dl_sched_class, neither enqueue nor switched_to_dl() runs).
rt_mutex_adjust_pi(p) copies the new pi_se with the old donor's deadline
into p's waiter, and when M's chain walk reaches rt_mutex_setprio(p, M),
p->dl.pi_se =3D=3D old_donor is already true, so dl_boost_blocked(p) is
skipped there as well and p's waiter stays sorted by the previous donor's
stale deadline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D30
