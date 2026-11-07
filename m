Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018339;
	b=RpROTcQ7SlAI/riSYdBgSgfgIjKgw30Q8fJqHiVpQCjlzdxdzBqU42hyFooZd+1N3/pZ
	 dZWzJzBUAX/0J2ukYzMv+115rdbqtQcg+MI7CwJfiffumZ1Ls4IFcrr3ZCz23caj7wDk6
	 JZYkjvrUtYci7hXXT6pN2EwOaR5Pgnbv00dfIgcDBzN9H0mxWkgsQgR1B+pdOIKHwyQzm
	 gFctIC32XzUjnMbgzYkq0hTGvNSiwJ8AbfhxRHkgUY3XzwBJtyzbVJw3MZExQvfaWR0Hh
	 ClwmwZPnySizJ5D/LMSjIXo/cxdeEeaIhfToCAphFtyAn1TRTVkah6qd+dT7/DY9alA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018339;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dFtFqZomesyElxV8dCwez46ovZ/K2caQbxgvXUnMGRg=;
	b=fb1R0C3mPGW8wLwtZ9IN3ng8JohM3wqBsUuadk40++t7ZrzKFEv4KwdNmmznVoNGy3NB
	 x6m5lgOnuvPHAuYjWGHIdvSa4wDeVmvWHUDotrl8afNINNSFzspOlaidW09ghaGLdbSzd
	 sQnW48TSJuBmVVnns2wAWQRGtxohAK7c+Vw6an3UJkDnJ8y7veCo4yjWL+T5U3vQHzDD4
	 ILMmNGU+JEhb+FFKBo7knTMEEhz+8W+VmzAsHz8zb/UKOvGqwfIafQy5vmVhSHGVvtHV0
	 D+Jp3CCUxFKX8yzl1D2aC2qezJo4t79c/TynA2uvAQxYukzvrmEBXdU+vCTWSrkpQ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1l1A5Og;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E72606A32C;
	Sat,  7 Nov 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1l1A5Og
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8951F008A3;
	Sat,  7 Nov 2026 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018338;
	bh=dFtFqZomesyElxV8dCwez46ovZ/K2caQbxgvXUnMGRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W1l1A5Og+Jz+xQ3dZiQpJ77b+zsWkQJVq/UqAjBU+vY+0gEEp8Fl+wkvcyJjyD8xT
	 Z78zestgVuJ5JrNSKJ9F5wmdRVyjuscwNDxAhWal1mjzPOkybKr6fns8DwjU8aKQ+e
	 mmgH8wsNEc17KGutbtfCLHV9S14krJCiEGpVad3pYsQ3vzlxmEqkHW9QyBSgC3BxJp
	 jRw5ahKK0V/QqaQBl2BjfcCssPNgwYMIJ5Wsz3ShezF9Vhy2JCsodtCbzEZmNPOwtX
	 Mxy6cLMX1XQGAkD3oVvXrHusWEntqL1XMZQxHoUJPKbgM3M4RW8UfioPG5Dgwf6T5Z
	 KdsapdlmJrbpg==
Message-ID: <sashiko-outbox-202507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/26] sched/deadline: Take a deadline boost from the
 waiter's rt_mutex node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-9-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-9-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:25:37 +0000
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
- [Medium] sched/deadline: missing reset of dl_boosted in
  __sched_setscheduler()
--

commit 58101a4480d1230ff10b589ddb99ec9388dce3f3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Take a deadline boost from the waiter's rt_mutex node

This commit records a deadline waiter's reservation parameters in its
rt_mutex_waiter node under pi_lock and copies them into the boosted owner's
sched_dl_entity so replenishment does not spin if the waiter leaves
SCHED_DEADLINE before the PI chain walk completes.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index c3f404cddb9e7..89c185f7d4980 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -297,10 +297,10 @@ static inline void __setscheduler_dl_pi(int newprio=
, int policy,
>  	 */
> =20
>  	if (dl_prio(newprio) && !dl_policy(policy)) {
> -		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);
> +		const struct sched_dl_params *params =3D rt_mutex_top_dl_params(p);
> =20
> -		if (pi_task) {
> -			p->dl.pi_se =3D pi_task->dl.pi_se;
> +		if (params) {
> +			dl_boost(&p->dl, params);
>  			scope->flags |=3D ENQUEUE_REPLENISH;
>  		}
>  	}

[Severity: Medium]
Can __sched_setscheduler() leave p->dl.dl_boosted set when a task boosted by
a deadline waiter changes its own scheduling policy or parameters?

If a task holding an rt_mutex with a deadline waiter switches its own policy
to SCHED_DEADLINE with an earlier deadline than the waiter's, __setparam_dl=
()
updates p->dl.dl_runtime, dl_deadline, and dl_period without clearing
p->dl.dl_boosted, and __setscheduler_dl_pi() does nothing because
dl_policy(policy) is true.  The task continues to run on the waiter's
pi_params and skips setup_new_dl_entity() in enqueue_dl_entity() until unlo=
ck.

Similarly, if normalize_rt_tasks() resets a deadline-boosted non-deadline t=
ask
to SCHED_NORMAL with pi =3D=3D false, switched_from_dl() skips __dl_clear_p=
arams()
because p->dl.dl_runtime is 0, and __setscheduler_dl_pi() does nothing beca=
use
!dl_prio(newprio).  When the task later unlocks the rt_mutex,
rt_mutex_setprio() sees prio =3D=3D p->prio and !dl_prio(prio) and returns =
at
out_unlock without clearing p->dl.dl_boosted, leaving is_dl_boosted(&p->dl)
permanently true if the task later enters SCHED_DEADLINE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D8
