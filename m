Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828811;
	b=nL9LlOfU+cVoTkHpnKVhUe3oncF9XJDh6Ni7kFwsVASMuQZdbaX2SZRAL5Myngxr0ccm
	 brjKFEBxcmeopwBPKz6AWDG+tMxO8BEnibAc9ouGp3MZAJRWRZUacPmu3BmrH71RaBLtt
	 oWpP9vlYfzpvAao+p4iFt94rcSki1mxLBv4cY7dOjQRb6AxU+nhX8XxMBY/DOhT+aRr3t
	 zWBu6fYVa3bvwMP8Zf+9OqS5tTC0v2LFpjctj6NEn4Qg47oDZoOlZZDhZWlZxvpEVLyQJ
	 SrFcIZ/2eW1p2BAN/D98shK5k0yHuZ7ewnp90QJT0HfxH9zU8ryep3GyBLmKsGSTlPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B/+Tw39nWIip5+PScAXZbdossYLtNBKyZ8Bm07MqdZc=;
	b=fj8HIcPZEy8n6ah/NmDMZiKiy876uQMOe3oIsJEyIR/4g1X6BQyQIb72K5PcfwNXSuny
	 s4FWD/ezeBCan/9rX4snw4gZBP+e3rbuUej+M4C0Zb3cIk2l/4LwKYeAVBriTiAXnlD28
	 /bUGPrkDz9+/rEhfl08orjZysJ5UAjHJ8fpWcEkd665Wbb1jbboH2/fFouowQfGlebNiI
	 iPnI26q9yL4xR5nRyFgFX7eLnWcTRrn0YHD2pAd0hLVT6IsnyAGsRm3YwjBRmhEMZomIM
	 oxVy+GMtJ9etQr0pxVN2cSwGV8xdlJL9OTPy/bfhYVRL8etIFPYxfUDbpO8mp1b4B7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWcDN+va;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84D606A330;
	Wed,  4 Nov 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWcDN+va
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E4F1F000C1;
	Wed,  4 Nov 2026 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828810;
	bh=B/+Tw39nWIip5+PScAXZbdossYLtNBKyZ8Bm07MqdZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWcDN+vaWTiwJa6L8FJaeo5XfPD0ZTQDqkTwTdnbBMO8u6comfo9C9YCmcT8wttD9
	 x4ZCDVcQ4cTmcjvgeJDiP6GjeiKF3SdUs4CkqMatnisdjDwiXFYoc9ziBQ/4cfJuWs
	 /+3YSB792iBITLjuhYnGE5uCKfzW4mPeQ+IGsnkUIcgxw0VRz7KoY/2SHfIEMSVpaF
	 Qcje2eTQPYNFFAtFfzYgove5iibISSoWY6RHcci/gGDTNzsfGYnxXnRjJwDnmKfnKP
	 HwMLZ5HV9shJOTN6yW5Rv9G7H3MnlRX/wJ33i+yWVI56H8jDUb5SwUvIxrsBqNVgS+
	 r31A/QVMnFCUQ==
Message-ID: <sashiko-outbox-198153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/21] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-5-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-5-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:46:49 +0000
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
- [Medium] sched/deadline: dl_b->total_bw underflow in __dl_sub() and __dl_=
add()
--

commit 1283d9f058013be0f43eec132085929ecd9c1f99
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not divide by zero active CPUs of a root domain

This commit guards the calls to __dl_update() in __dl_sub() and __dl_add()
with a check that cpus is non-zero to avoid dividing by zero when all CPUs =
in
a root domain are inactive. When cpus is zero, it leaves the dl_b->total_bw
updates in place without updating per-CPU extra_bw.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 963fda6ddb7f6..dadda1a528ec6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -189,18 +189,25 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
>  	}
>  }
> =20
> +/*
> + * @cpus is the number of active CPUs of the root domain, whose extra_bw
> + * shares the change: none once they all went offline, and total_bw alone
> + * changes then.
> + */
>  static inline
>  void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  {
>  	dl_b->total_bw -=3D tsk_bw;
> -	__dl_update(dl_b, (s32)tsk_bw / cpus);
> +	if (cpus)
> +		__dl_update(dl_b, (s32)tsk_bw / cpus);
>  }
> =20
>  static inline
>  void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  {
>  	dl_b->total_bw +=3D tsk_bw;
> -	__dl_update(dl_b, -((s32)tsk_bw / cpus));
> +	if (cpus)
> +		__dl_update(dl_b, -((s32)tsk_bw / cpus));
>  }

[Severity: Medium]
Can updating dl_b->total_bw when cpus =3D=3D 0 (or on an inactive CPU) unde=
rflow
or corrupt dl_b->total_bw in the paths mentioned in the commit message?

During a root-domain rebuild in dl_rebuild_rd_accounting(),
dl_clear_root_domain() resets rd->dl_bw.total_bw to 0 and dl_server_add_bw()
only adds server bandwidth back for active CPUs:

kernel/sched/deadline.c:dl_clear_root_domain() {
	rd->dl_bw.total_bw =3D 0;
	for_each_cpu(i, rd->span)
		cpu_rq(i)->dl.extra_bw =3D cpu_rq(i)->dl.max_bw;

	for_each_cpu(i, rd->span)
		dl_server_add_bw(rd, i);
}

kernel/sched/deadline.c:dl_server_add_bw() {
	dl_se =3D &cpu_rq(cpu)->fair_server;
	if (dl_server(dl_se) && dl_se->dl_bw_attached && cpu_active(cpu))
		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
}

Likewise, __dl_server_attach_bw_locked() and __dl_server_detach_bw_locked()
only update dl_b->total_bw when cpu_active(cpu_of(rq)) is true, because an
inactive CPU's server bandwidth is not accounted in dl_b->total_bw.

In dl_server_apply_params(), however, dl_b is updated unconditionally when
dl_se->dl_bw_attached is set:

kernel/sched/deadline.c:dl_server_apply_params() {
	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
		return -EBUSY;

	if (init) {
		__add_rq_bw(new_bw, &rq->dl);
		__dl_add(dl_b, new_bw, cpus);
		dl_se->dl_bw_attached =3D 1;
	} else if (dl_se->dl_bw_attached) {
		__dl_sub(dl_b, dl_se->dl_bw, cpus);
		__dl_add(dl_b, new_bw, cpus);

		dl_rq_change_utilization(rq, dl_se, new_bw);
	}
}

While a CPU sits in def_root_domain with !cpu_active(cpu) (between
sched_cpu_deactivate() and CPU offline, or between CPU online and
sched_cpu_activate()), its fair_server bandwidth is not in
def_root_domain.dl_bw.total_bw. If admission control is disabled
(dl_b->bw =3D=3D -1) and a debugfs write sets new_bw < dl_se->dl_bw,
__dl_overflow() passes and __dl_sub() followed by __dl_add() subtracts the
unaccounted dl_se->dl_bw from 0, underflowing def_root_domain.dl_bw.total_b=
w.
Even with admission control enabled, if def_root_domain also contains active
isolated CPUs (cpus > 0), dl_server_apply_params() on the inactive
hotplugging CPU will subtract unaccounted dl_se->dl_bw and add new_bw to
def_root_domain.dl_bw.total_bw and the active CPUs' extra_bw. Should
dl_server_apply_params() gate the __dl_overflow(), __dl_sub(), and __dl_add=
()
calls on cpu_active(cpu), matching __dl_server_attach_bw_locked() and
__dl_server_detach_bw_locked()?

For the task paths mentioned in the commit message, at this commit:

1. In inactive_task_timer() (and task_non_contending()), if a task leaves
SCHED_DEADLINE or dies before its 0-lag time and task_cpu(p) goes offline
before the timer fires, the root-domain rebuild has already reset
def_root_domain.dl_bw.total_bw to 0 without re-adding the departed task:

kernel/sched/deadline.c:inactive_task_timer() {
	if (!dl_task(p) || READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
		struct dl_bw *dl_b =3D dl_bw_of(task_cpu(p));
		...
		raw_spin_lock(&dl_b->lock);
		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
		raw_spin_unlock(&dl_b->lock);
}

Calling __dl_sub() with cpus =3D=3D 0 then subtracts p->dl.dl_bw from 0 and
underflows def_root_domain.dl_bw.total_bw. (A later commit in this series,
commit 1e8adcf8ed27 ("sched/deadline: Keep departing bandwidth across a root
domain rebuild"), addresses the rebuild race via dl_departed_list and
dl_bw_gen.)

2. With admission control off, if sched_setattr() switches a task asleep on
an offline CPU to SCHED_DEADLINE, sched_dl_overflow() calls __dl_add() on
def_root_domain (where cpus =3D=3D 0), adding new_bw to
def_root_domain.dl_bw.total_bw. Subsequent removal in switched_from_dl() or
set_cpus_allowed_dl() uses dl_task_root_domain_cpu(p) in an active root
domain, leaving def_root_domain.dl_bw.total_bw elevated and underflowing the
active root domain's total_bw. (A later commit in this series, commit
90cd336704a1 ("sched/deadline: Record the root domain holding a task's
bandwidth"), records dl_bw_cpu on the entity.)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D4
