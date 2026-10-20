Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518208;
	b=kbNE0rLNwLqfg+b4dHhY/QVK6r/90qmgKvCobjq1BoQcUNV/GdWFuLIvBeMcZJKBew+U
	 nX3uzLBDeW9pUSU/pxA9IGpy3MiyX+dS7on2ar3yaF9J0WOmPs4U/cF0BZIzFyIrfNlGg
	 X4I9vNOwt05AGhR5mO5Ba6AJtm8NFq21Xx6SB1UbwK2aFiHx0TUDYN21+P968VqkIL+vG
	 HmpIZtL5oY2nHW/QXmn5yyc8LIGjfjFjzX+hRLBoCnXiax/pdHos0TaSCLUIRRpNepjBu
	 fOJCpfXbBWnQfe5oGbHxbnH5mjAIfEHcXHvoSF7Q3StGhSRDTao/iMYahW5WTi8iDnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518208;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YzYP/WyaVmBwoebhiZXVASs4ZlwqDBJlN1u3TY4fiF8=;
	b=KD5KEvBRt3k1fGOqGOLBCXqMkiZ57Vr6Bw15/FHGv+Fc4UChVf6PK7reZR0GcaFn7GM2
	 V3Z6OgUgxXRqAXFCTWrbc0MsX+fWtpeptke9YOr9B2dNU/VexruXwCxVlGny8JayLlkPJ
	 hG82bZKseLeiYBS030RO0JKZ/O3omvVaUiGSrP+LYNAP3kzVLrzuDGn43bXypwJRzXWar
	 tMXxH2D09tppfsH0YkN+zYMxt1GEcj9uhpcTGcAUN4lI8fxkyYyylqW9FXVxjh7S2bVHA
	 zOzH+bHmCv6SGClK6RArSl4B5Tk3ATQOjrOlu/haZ/f9CaihJrsVt6eXmGKR22eiMkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61B606A319;
	Tue, 20 Oct 2026 17:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE871F000CB;
	Tue, 20 Oct 2026 17:43:28 +0000 (UTC)
Message-ID: <sashiko-outbox-179437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6] net: schedule a purge when the defer queue
 rejects a free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joseph Kain" <jkain@nuro.ai>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261019174258.1375583-1-jkain@nuro.ai>
References: <20261019174258.1375583-1-jkain@nuro.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:43:18 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] net: skb_attempt_defer_free() still latches when skb_defer_max h=
its 0
- [Medium] net: repeated IPIs and lock contention on skb_attempt_defer_free=
() reject path
--

commit 4683493f7039cdaa5b1372dd8cadf3a6b5ffb8f0
Author: Joseph Kain <jkain@nuro.ai>

net: schedule a purge when the defer queue rejects a free

This commit schedules a defer list purge from the reject path in
skb_attempt_defer_free(), changes the limit comparison from >=3D to >, and
reorders llist_del_all() before resetting defer_count in
__skb_defer_free_flush() so that rejected frees do not leave defer_count
permanently stuck above skb_defer_max.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..a5912b728ddd7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6940,8 +6940,11 @@ static void __skb_defer_free_flush(struct skb_defe=
r_node *sdn, int budget)
> =20
>  	if (llist_empty(&sdn->defer_list))
>  		return;
> -	atomic_long_set(&sdn->defer_count, 0);
>  	free_list =3D llist_del_all(&sdn->defer_list);
> +	/* Racy on purpose, as in __dev_xmit_skb(): a producer landing between
> +	 * the del_all and this store stays queued but uncounted.
> +	 */
> +	atomic_long_set(&sdn->defer_count, 0);
> =20
>  	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
>  		prefetch(next);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..596f99811bacd 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7392,8 +7392,14 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	defer_max =3D READ_ONCE(net_hotdata.sysctl_skb_defer_max);
>  	defer_count =3D atomic_long_inc_return(&sdn->defer_count);
> =20
> -	if (defer_count >=3D defer_max)
> +	if (unlikely(defer_count > defer_max)) {
> +		/* The kept increment only comes back down when a flush zeroes
> +		 * it, and this is the one path that sees a full queue.
> +		 */
> +		if (!llist_empty(&sdn->defer_list))
> +			kick_defer_list_purge(cpu);
>  		goto nodefer;
> +	}

[Severity: Medium]
Can sdn->defer_count still permanently latch above defer_max with an empty
sdn->defer_list when net.core.skb_defer_max is set to 0 and later restored =
to
a positive value?

Both the new reject path in skb_attempt_defer_free() and
__skb_defer_free_flush() rely on sdn->defer_list being non-empty whenever
sdn->defer_count > defer_max:

net/core/skbuff.c:skb_attempt_defer_free() {
	...
	if (unlikely(defer_count > defer_max)) {
		if (!llist_empty(&sdn->defer_list))
			kick_defer_list_purge(cpu);
		goto nodefer;
	}
}

net/core/dev.c:__skb_defer_free_flush() {
	if (llist_empty(&sdn->defer_list))
		return;
	free_list =3D llist_del_all(&sdn->defer_list);
	atomic_long_set(&sdn->defer_count, 0);
	...
}

When a producer observes defer_max =3D=3D 0, even the first increment
(defer_count =3D=3D 1) satisfies defer_count > defer_max and jumps to nodef=
er
without adding an skb to sdn->defer_list.

The commit message notes that from v7.1 on, 0 is safe because
proc_do_skb_defer_max() flips skb_defer_disable_key before producers
increment. However, in proc_do_skb_defer_max():

net/core/sysctl_net_core.c:proc_do_skb_defer_max() {
	oval =3D !net_hotdata.sysctl_skb_defer_max;
	ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
	nval =3D !net_hotdata.sysctl_skb_defer_max;

	if (nval !=3D oval) {
		if (nval)
			static_branch_enable(&skb_defer_disable_key);
		else
			static_branch_disable(&skb_defer_disable_key);
	}
}

proc_dointvec_minmax() writes 0 to net_hotdata.sysctl_skb_defer_max before
static_branch_enable() acquires the jump_label locks and patches kernel text
across all CPUs. During that window (and deterministically on 6.18 through
7.0 stable trees targeted by Fixes: 844c9db7f7f5, which do not have
skb_defer_disable_key), concurrent callers of skb_attempt_defer_free() pass
the static key check, read defer_max =3D=3D 0, and increment sdn->defer_cou=
nt
while rejecting before llist_add().

Once sdn->defer_list is empty and sdn->defer_count has accumulated to a val=
ue
at or above the restored net.core.skb_defer_max limit, every subsequent
producer sees defer_count > defer_max and llist_empty(&sdn->defer_list),
skips kick_defer_list_purge(), and even an autonomous __skb_defer_free_flus=
h()
on the owner CPU returns early without zeroing sdn->defer_count.

[Severity: Medium]
Does calling kick_defer_list_purge(cpu) on every rejected skb when
!llist_empty(&sdn->defer_list) cause repeated cross-CPU IPIs and lock
contention during a burst of rejects?

The commit message states:

  kick_defer_list_purge() already coalesces through sd->defer_ipi_scheduled,
  so a burst of rejects costs one IPI.

In net/core/dev.c, the IPI callback trigger_rx_softirq() runs in hardirq
context and clears sd->defer_ipi_scheduled immediately after raising
NET_RX_SOFTIRQ, before net_rx_action() and skb_defer_free_flush() run in
softirq context to drain sdn->defer_list:

net/core/dev.c:trigger_rx_softirq() {
	struct softnet_data *sd =3D data;

	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
	smp_store_release(&sd->defer_ipi_scheduled, 0);
}

net/core/dev.c:kick_defer_list_purge() {
	struct softnet_data *sd =3D &per_cpu(softnet_data, cpu);
	unsigned long flags;

	if (use_backlog_threads()) {
		backlog_lock_irq_save(sd, &flags);

		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
			__napi_schedule_irqoff(&sd->backlog);

		backlog_unlock_irq_restore(sd, flags);

	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
		if (smp_call_function_single_async(cpu, &sd->defer_csd))
			WRITE_ONCE(sd->defer_ipi_scheduled, 0);
	}
}

Previously, kick_defer_list_purge() was gated on the exact equality
(defer_count - 1) =3D=3D (defer_max >> 1), so it was invoked at most once p=
er
(cpu, node) per flush cycle.

With this change, whenever the target CPU has hardirqs enabled but has not =
yet
reached skb_defer_free_flush() (for example, while executing in a
local_bh_disable() section, polling NAPI, or when softirqs are deferred to
ksoftirqd), each IPI immediately clears sd->defer_ipi_scheduled in hardirq
context while sdn->defer_list is still non-empty. Won't subsequent rejected
skbs on remote CPUs then repeatedly win cmpxchg(&sd->defer_ipi_scheduled, 0=
, 1)
and send back-to-back IPIs, or contend on backlog_lock_irq_save() on every
rejected skb when use_backlog_threads() is enabled?

> =20
>  	llist_add(&skb->ll_node, &sdn->defer_list);
> =20

[ ... ]

=E5=AE=8C=E7=BE=8E =E2=80=94 wait no extra text! Let me make sure I don't o=
utput anything after the blank line! Let me remove that accidental thought =
line before finishing! Wait=E2=80=94I am already in the output stream! Oh! =
Let me be careful. I cannot erase what was emitted, so I will just end with=
 a blank line now.
$]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019174258.1375=
583-1-jkain@nuro.ai?part=3D1
