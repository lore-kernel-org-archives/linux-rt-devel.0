Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034133;
	b=rceyTpv3AEm/SsZktCCWJ0BBfc7qNkdOH/Pwlm7b+vNgjb64SijH32KY8tHxfgrUWXqv
	 mDoVyF/8fqJ0QVZrdw5Gy4e9WrMhdVyS/t7w0xSOF+iO17CbWs41HlHQdU2tg0qas4sMJ
	 W8t4ch768yX3sJ70gktDiQwcl761ic1KfzgNXzw5I+r9Ob4MYcRt0QrNjgE4QWDTR0EK1
	 ZMWoq70+hAhlrg+661WA9LQ0W7dSmtgK23mzjVRhOk5lFFdLWKiG4Ek8izj8F9s67jUJ4
	 BgQKvY9VU44kLJ7lJ9JoQk7hljthtpgYPUv8/4AbSjRMYI0Rl2zLCVP6MwerG1fNXiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HIJ8eaMjiQzuxtgcHnJg5sm0XTsZze+IOOLFm60WcG0=;
	b=QErd+3EDZehYSU/YuqQ77Z+6AaOilySz51qh0tnmK3jh8kQ6x8fXj7V/MLQ+QDHq4sa0
	 WbV2vB4vuYEclDmRDhUjFVggfX+EJ3z6kB00gs3vTv/JMSdRkBBb9HgJUUpT5hogKPN0P
	 yftrxLtpKr7NcBIhPx2wwwoZbHb4iZUYBuwV68GJxbQik+M/8OarzI4BPN+kAZVGok1d5
	 BZYp1VKWovAiIstZzYru64YzBg/MFLzs6iBX4dmyNbV9oKIlE55xln5nYZCWVXQWhfLmJ
	 VRduXKvVtWsMgwz+QIcz7MzyNfAy0XO/Tvt2iJhlaLyOkuedRnpwuO7Osjg7MtUi/1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUXYsoj0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F13606A320;
	Wed, 18 Nov 2026 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUXYsoj0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322A91F000C4;
	Wed, 18 Nov 2026 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795034133;
	bh=HIJ8eaMjiQzuxtgcHnJg5sm0XTsZze+IOOLFm60WcG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUXYsoj0z1H+rMHlbyRo+l6CKNz/zILmnoPQRONwo8Ne8Yp3jCZrakecn0erphewO
	 F58la+tgsVtDj4R2d+aaeyyKTo5w2VkyyesXsnm/NqVjuaCzwfV4aKuHIFgmZsYPF5
	 R6HBdSEuQE44fsKkaSIymmg52BAlVc+d5NoGIR7o4b6tIw+/lGxkEYjq7RCbYSDCvi
	 AwrcTR3QTskup7W2nFS10JG2G8qZxJNS7kPWhIxvSpoc2W+Cqv84YuGkECNwyC2FwQ
	 PQcun9VwW0VOSNdRBNkc4JIF+CTl2RahUQmyQiZqjn7lA8e/Oj0202AoR/nCIxqEhl
	 9MHHhUxWOxlTQ==
Message-ID: <sashiko-outbox-221939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/16] sched/deadline: Do not replenish a boost from
 cleared parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <ae7a53ee206a422a9debf0cbbeb241c8b233d160.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <ae7a53ee206a422a9debf0cbbeb241c8b233d160.1795031605.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 20:35:32 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] sched/deadline: use-after-free of pi_se via
  rt_mutex_adjust_prio_chain() [1]
--

commit 961bc9d5ebb4610c191709612415310c77835eeb
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not replenish a boost from cleared parameters

This commit prevents an infinite loop in replenish_dl_entity() when an
rt_mutex donor leaves SCHED_DEADLINE and has its deadline parameters
cleared before the priority-inheritance chain walk deboosts the lock
owner.

Link: https://lore.kernel.org/all/avL8oOtjKqVNR7-l@jlelli-thinkpadt14gen4.r=
emote.csb/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e4d7cbf4861de..71b1c155c2424 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -807,8 +807,38 @@ static void replenish_dl_entity(struct sched_dl_enti=
ty *dl_se)
>  {
>  	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
>  	struct rq *rq =3D rq_of_dl_rq(dl_rq);
> +	struct sched_dl_entity *pi_se =3D pi_of(dl_se);
> +	u64 runtime =3D READ_ONCE(pi_se->dl_runtime);
> +	u64 deadline =3D READ_ONCE(pi_se->dl_deadline);
> +	u64 period =3D READ_ONCE(pi_se->dl_period);

[Severity: High]
This problem wasn't introduced by this patch, but can pi_se point to a
freed task_struct after a nested rt_mutex wait is aborted [1]?

Suppose deadline task M with positive remaining runtime holds lock L1, and
deadline task W with an earlier deadline blocks on L1.  rt_mutex_setprio()
sets M->dl.pi_se =3D &W->dl while replenish_dl_entity() leaves
M->dl.deadline unchanged, and when M blocks on L2 held by O, O->dl.pi_se
becomes &W->dl.

When W aborts its wait on L1, remove_waiter() resets M->dl.pi_se to &M->dl
without changing M->dl.deadline and calls rt_mutex_adjust_prio_chain() on
M:

kernel/locking/rtmutex.c:rt_mutex_adjust_prio_chain() {
    ...
	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
		if (!detect_deadlock)
			goto out_unlock_pi;
    ...
}

Because rt_waiter_node_equal() compares only prio and deadline, it sees no
change for M's waiter on L2 and stops the walk before reaching O.  Once W
exits and is freed, replenishing O here dereferences a dangling O->dl.pi_se
(use-after-free).

[1] https://sashiko.dev/#/bug/linux-e1386e80-9bd4-4219-9441-8f56e84f7735

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795031605.gi=
t.mathieu.desnoyers@efficios.com?part=3D8
