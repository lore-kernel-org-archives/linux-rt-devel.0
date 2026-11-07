Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017428;
	b=o0fkgxpYpom9GQQ3x4IUubRUovo0vj8kpS1txriaRuvaW2hxT14RhbBilkDAwsMkgwaV
	 KusLOKCQ4KQ4Fwcuhjo0/r2ye+Xjrg2LC8Tsb5YgEin+FKoElHsV0Dkh1uD58x9aFu9/w
	 sWF8Pc2TK7zLa4Oxs4g/UO57ZFrb2qeklkoGV/GVs38XBVMN2allUjnow71DpjM8hIJp6
	 V5nAdakj55DVfkC/aZ5YquxTs6X/ho9kAYlz7AOxb99h/1jy4d4xwGkVqixeIq7qHwFtH
	 z3enJuVqSm0zwCxFUV57wR4kKbSTeM8n6FLEWMZXoot8KsqaxgljkW3TDFFHTq02c0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017428;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cQViQy0oe9uGlkh+ExsB7itQp+VW3WBKjHlSDXyD4ec=;
	b=cReGRFs+ApAx6Z4lvO8X+7Ub9n8bjPk6RqnfFKxxZR9Lwd6YLRGVErw71U/gtrQ7jKEm
	 0VvvfisxjHfJ+D9KT4FMjqY+/xoE4cYFl8q7kis+aAij36xjAu2wrh7HzAVwGK1+Yf+BG
	 7Wh+VNOnQ7c5iV/fEWTZTuz7+p092UXge1w9R7/3Pu+nfDg0xZYO7LhFqhPXVl2Is3G3c
	 loua5gXz4ZIRdRVJDhAuOBbJILR41++GUtWDpbMz34p/8AfHcOlbPdG+GcnHzggYXLL3i
	 y9at4OUqVDXLxOvq2Qh9NIHehDQXfSzHKXiDW98eLNTG4uBs/8jkMxgN9X7p/Tevy3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RP1ChzlF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA74606A32D;
	Sat,  7 Nov 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RP1ChzlF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2BB1F0089F;
	Sat,  7 Nov 2026 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794017428;
	bh=cQViQy0oe9uGlkh+ExsB7itQp+VW3WBKjHlSDXyD4ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RP1ChzlFJiZRVZND9KvaVazINDNxLLPI8d202pgNfgXuWHmPEH395hpNArbD/A0QE
	 TnmWrt30EY7/8isb0xvSPfTwTSqWSNsiD4OGxEso9hcd8i5VZdGfH114T8FUCdZBo2
	 UmiHaVfe5UZjjRJyULvcu4NuJ7RFHqTFKTzfTnqUYu8u9qeiPy/lbJAo74sSeWQAUQ
	 EjVLRU08ELaxTKoFsL+Tz8GJSwJ466i6z7rtOT0DocmUYVvOrHx+6IZBDmxvtlj6Vb
	 BrU3YIudQnEtnp/lgkxCpg1Dn98d4Z6cROyjifdqmAh0hcQKRV85la+Mroo5pJodOO
	 7615tVSLk0d7A==
Message-ID: <sashiko-outbox-202482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/26] sched/deadline: Leave a dying task out of a
 rebuild of the accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-16-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-16-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:10:27 +0000
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
- [Medium] sched/deadline: premature bandwidth drop in
  dl_add_task_root_domain()
--

commit 961e96ebfc4954b76eeee2f5e097ac6c0a279fa7
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Leave a dying task out of a rebuild of the accounting

This commit skips tasks in TASK_DEAD state that are not on the departed list
when rebuilding root domain deadline bandwidth accounting in
dl_add_task_root_domain().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 45a896a4f4615..3f3de4b74a2dc 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3643,6 +3643,15 @@ void dl_add_task_root_domain(struct task_struct *p)
>  		cpu =3D p->dl.dl_departed_cpu;
>  		if (!cpu_active(cpu))
>  			goto unlock;
> +	} else if (READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
> +		/*
> +		 * Dead and not departed: its bandwidth was released at its
> +		 * last schedule, under its runqueue lock and not this one,
> +		 * and dl_bw may still say otherwise. do_task_dead() sets
> +		 * TASK_DEAD under pi_lock before that, so a task found alive
> +		 * here dies after this walk, and releases what it counted.
> +		 */
> +		goto unlock;
>  	}

[Severity: Medium]
Can this drop the bandwidth of a dying task whose 0-lag time is still in the
future?

do_task_dead() calls set_special_state(TASK_DEAD), which sets p->__state =3D
TASK_DEAD under p->pi_lock and immediately releases p->pi_lock before
calling __schedule().  The task only sets p->dl.dl_departed_cpu later inside
__schedule() -> ... -> dequeue_task_dl() -> task_non_contending() ->
dl_task_depart():

CPU0                                  CPU1
do_task_dead()                        dl_rebuild_rd_accounting()
  set_special_state(TASK_DEAD)          dl_clear_root_domains()
    lock(&p->pi_lock)                     dl_bw_gen++
    p->__state =3D TASK_DEAD                rd->dl_bw.total_bw =3D 0
    unlock(&p->pi_lock)                 ...
                                        dl_add_task_root_domain(p)
                                          p->dl.dl_departed_cpu < 0
                                          p->__state =3D=3D TASK_DEAD
                                          goto unlock  <-- skips p->dl.dl_bw
  __schedule(SM_NONE)
    ...
    task_non_contending(p)
      /* zerolag_time >=3D 0 */
      dl_task_depart(p, ...)
      start_inactive_timer(p)

Until inactive_timer fires at the 0-lag time, p's bandwidth is missing from
rd->dl_bw.total_bw, allowing sched_dl_overflow() to over-admit new deadline
tasks beyond the root domain's capacity.  In addition, because p joins
dl_departed_list with a stale p->dl.dl_bw_gen, a second rebuild before
inactive_timer fires will take the p->dl.dl_departed_cpu >=3D 0 branch in
dl_add_task_root_domain() and add p->dl.dl_bw back on top of any newly
admitted tasks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D15
