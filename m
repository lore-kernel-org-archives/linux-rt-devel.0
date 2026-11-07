Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017932;
	b=zGBLkI8JbKguwR4tbjtrrB5tKfK4o33D7s6kJerjj4krbdihyrSYdI9rdaeHIGuTDq/M
	 nHk7zr/0aIlHabX5Nky7YoL/vaL/pzXpoQb/2VPbHWKBwdwMpUkARBAD3GXOPZVO2iR6W
	 oP5FVsVo4T5crygVXEiT16d3OxBmLiwh95gKBmKttkHCi/WbokPvhJjLeH4+vrP/9/UxB
	 lxTXMdIbaYTBxejGy94m45rCMUtu3iFZWWKgv9NyF8t/vo5Z870CY5rc+tt+oPHT5bhno
	 yfnkRu6sH8ftrFboPdPK4yTET8GIvn4ihUQRubDHJgTLkuuxqr2zc1tkOqN1iVKd00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017932;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JQ1C2ky/Lad3SoNI9yNFlJIbV1dy/UU8jiTiXydNucc=;
	b=dmrQLkeuW5P1zT4LoiPbUC6zeSazeekMDxdmK93jDx4jln/YjjSLHSkNc46l+XcFq+g2
	 zvJPKM8Sibg42V55cuttKydoPm+yGb1xdfLss+p7sUmRQCTu08sbHQfBJigKDPIC36BJR
	 JTuIAUfhBJVG/1YkV8uPSeGztHfya9Zvdg2Hcmk0tvivyts8JWdapxSTp0Halz4gtvSjq
	 WcwF0EfAH3tS/yZ6k4DS9YSDLLrhtCNhkDxeRqL5p9Bl6F03xV4zf2SNLHQaLIrSe00y1
	 42Y1H3D2xxkrtx6UiVx6Wio0Yux6nDc8Ec8dNqKQKtqu8VyN/90cy6pEnpOSeNauG0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ncj1XSZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86E606A326;
	Sat,  7 Nov 2026 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ncj1XSZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB591F0089F;
	Sat,  7 Nov 2026 02:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794017931;
	bh=JQ1C2ky/Lad3SoNI9yNFlJIbV1dy/UU8jiTiXydNucc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ncj1XSZPjaGaxp7wacV8elNpClU+7/v9BzjfsYN8GrMhCwjys4MvR33G7kZiY0lER
	 eMHq0EdjaQTwZj1AncNKg73VJk5syuCVZ2R0ZJlkl2CTjsPF3DSvxWf++Rpmywpsai
	 9+7k5SMRkxqCXVt8V2Vk9IYJI21VjAHU/0o3PHGnykqJCDnombGLYdPp0LVqdSw7ie
	 YELursxOvrGN6Cuj2ud4eQBr6b4W5DmwWMYP0odSVS87Y0zI5Tr0bsGae1UDW5IwOo
	 aR+fZP3SmxyquieoI75f9JIVvuHTn2k7x0oo4htCUfW6eAocY04MR8L+qSVpyTkRdD
	 GohFUiFYxMlJw==
Message-ID: <sashiko-outbox-202497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/26] sched/deadline: Reset the deadline and the
 runtime with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-10-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-10-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:18:50 +0000
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
- [Medium] sched/deadline: unreset donor period in switched_from_dl()
  when dl_runtime !=3D 0
- [Medium] sched/deadline: donor deadline and runtime kept on deboost
  after setattr
--

commit e10fc72d0029b6302955712a86b151e84624b177
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the deadline and the runtime with the parameters

This commit resets dl_se->deadline and dl_se->runtime in
__dl_clear_params() and in switched_from_dl() when a deboosted task has no
dl_runtime of its own.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b8b0076870a64..f389620e6fc9a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3580,6 +3580,16 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(&p->dl, false);
> =20
> +	/*
> +	 * Deboosted from priority inheritance with no parameters of its own:
> +	 * the deadline and the runtime are the donor's. A change into the
> +	 * class then starts a period from the parameters it is given.
> +	 */
> +	if (!p->dl.dl_runtime) {
> +		p->dl.deadline =3D 0;
> +		p->dl.runtime =3D 0;
> +	}

[Severity: Medium]
What happens in switched_from_dl() when a task that still carries pre-0-lag
parameters (p->dl.dl_runtime !=3D 0) is PI-boosted by a SCHED_DEADLINE wait=
er
and then deboosted?

When the task is boosted before its inactive_timer fires, switched_to_dl()
cancels inactive_timer and replenish_dl_entity() overwrites p->dl.deadline
and p->dl.runtime from the donor's pi_params.  On deboost, p->dl.dl_runtime
is non-zero, so switched_from_dl() skips the reset and passes the
donor-modified deadline and runtime to task_non_contending(), mixing them
with the task's old dl_period and dl_runtime.

Depending on the donor's parameters, this either releases the task's old
bandwidth before its real 0-lag time or leaves the donor's future deadline
and runtime in place for a subsequent entry into SCHED_DEADLINE.

[Severity: Medium]
Can a task keep the donor's deadline and runtime if sched_setattr() gives
it SCHED_DEADLINE parameters while it is PI-boosted?

If a non-deadline task is boosted into dl_sched_class and then configured
as SCHED_DEADLINE via sched_setattr() before unlocking the rt_mutex, both
__sched_setscheduler() and the subsequent deboost in rt_mutex_setprio()
keep the task in dl_sched_class without calling switched_from_dl():

kernel/sched/core.c:rt_mutex_setprio() {
    ...
		} else {
			p->dl.dl_boosted =3D 0;
		}
    ...
}

When rt_mutex_setprio() clears dl_boosted, enqueue_dl_entity() only calls
setup_new_dl_entity() if dl_se->deadline is already in the past, so the
task runs unboosted on the donor's remaining runtime and deadline instead
of starting a period from its own parameters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D9
