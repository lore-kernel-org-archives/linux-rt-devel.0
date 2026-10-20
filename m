Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518261;
	b=gH6HtWkI0hZaU6H4T/6zcD621wIpoaNUQfcRlXrv7Q34J6QCK6lwWx8l+98FmKNTgqDj
	 XX9cox3nZAQ/gmEpDHKv9f0fCKWyVyLSh4CBbF6H5+i0tk2BzMIwTenQGbPQU6foTgMyh
	 9Oi5iQteYZENMDw/QUIWCxbv0Le9+HD3FDpolMYgstNfBIYLO9vpkjSnd/RVNjOfHFwh3
	 Mn5As7foy9YT2nI5NHBly21y30ezPUB35jiRP9zNJI5KAJAcQRCn99mT10s4f84LHE6ZA
	 BJHowMHYLKd0NFEi9dCbV4wFHvG9M+7QS2rJ+e5kr+81yAyGSf8Yp3EshwwpkN8oJ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518261;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+K8ozS5zuMGtMGwNhUM19X47O639ySjcKiELw/sxceA=;
	b=aCkVydE4W+74w72PiXsYiZlcnCmKvfOGVctAdq1qjom+lGN4TVt8vkbrJaIN7Lmz5cwb
	 oIcj0zi09P4S48QygObpRNURJwuD5IZqVIyvrgNy4X6c4EjeYpxkIpJGLiQiuK7x1hfaO
	 DDV8k1zPRBiF0wUxqanxGGzGPQxDhO4aP6ifTyCHlsbeQRP91xRZBX6GpSWkN4npqags3
	 xPvvfKu4frFYE6xjnQQ96JtXGDaIv4EVsM1yHrUcJeW9GMt2D5smM8Mhelxwd5SYxj0jo
	 8EzPhCnkDmjEOLbi8+v24W/5e8SlJZ7ocgSjxNoEBHsaSABH1gfwgh/AJIlhjDEnCbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUDRh7YW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FB606A31C;
	Tue, 20 Oct 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUDRh7YW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EBA1F000C9;
	Tue, 20 Oct 2026 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792518261;
	bh=+K8ozS5zuMGtMGwNhUM19X47O639ySjcKiELw/sxceA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gUDRh7YWfe9WXFp97Ekumy3Uc+t7Jl5KGU1SqMu+vRNSQBd8OmUSQbWnVXZiDb3VA
	 qwhxr5lvCtJSG3NgF+yFewtFW9xXuW6hK93i5/jYD7XRi6E2NeGMZplMxA1JxJnVuq
	 4U10F4AWuf26z4s40Kh9fm+y702cTIgTW94Ma2CDBHcdd095g9uRpPvmfi7itx8e40
	 CIFbWqeOvAWQyhGZz31M+N6MVLOj10Zagq7kEQXU8lTaC5R0mQ5Pg86BXk9QdwH1tq
	 kS8QazMow37t/jcvBlTOGOCJ+J0OYduKjHydf2tVXlI0l3t0egRbF80mu1QGJOwA5n
	 8pZ4M717xFLjg==
Message-ID: <sashiko-outbox-179440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6] net: schedule a purge when the defer queue
 rejects a free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joseph Kain" <jkain@nuro.ai>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261019174400.1377093-1-jkain@nuro.ai>
References: <20261019174400.1377093-1-jkain@nuro.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:44:11 +0000
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
- [Medium] net: skb_attempt_defer_free() still latches defer_count on skb_d=
efer_max=3D0
- [Medium] net: repeated IPIs and lock contention in skb_attempt_defer_free=
()
--

commit 6c549c105bac5ff899022b2e84c0969ec08de899
Author: Joseph Kain <jkain@nuro.ai>

net: schedule a purge when the defer queue rejects a free

This commit schedules a defer list purge from the reject path in
skb_attempt_defer_free() when defer_count exceeds defer_max, changes the
limit check from >=3D to >, and moves the defer_count reset after
llist_del_all() in __skb_defer_free_flush().

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
Can setting net.core.skb_defer_max to 0 and later restoring a positive
limit still latch sdn->defer_count in the absorbing state?

In net/core/sysctl_net_core.c:proc_do_skb_defer_max(),
proc_dointvec_minmax() writes 0 to net_hotdata.sysctl_skb_defer_max
before static_branch_enable(&skb_defer_disable_key) patches the jump
label across CPUs:

    oval =3D !net_hotdata.sysctl_skb_defer_max;
    ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
    nval =3D !net_hotdata.sysctl_skb_defer_max;

    if (nval !=3D oval) {
        if (nval)
            static_branch_enable(&skb_defer_disable_key);
        else
            static_branch_disable(&skb_defer_disable_key);
    }

Additionally, preemptible callers in tcp_eat_recv_skb(),
skb_consume_udp(), or mptcp_eat_recv_skb() may already have passed the
skb_defer_disable_key check in skb_attempt_defer_free(), and on 6.18
through 7.0 stable kernels targeted by Fixes: 844c9db7f7f5,
skb_defer_disable_key is not present at all.

When defer_max is 0 and sdn->defer_list is empty (either initially or
after a flush drains existing entries), each producer in
skb_attempt_defer_free() increments sdn->defer_count to 1, 2, ..., N,
sees defer_count > 0, skips kick_defer_list_purge(cpu) because
llist_empty(&sdn->defer_list) is true, and jumps to nodefer without
adding to sdn->defer_list.

Because __skb_defer_free_flush() returns early when
llist_empty(&sdn->defer_list) is true without zeroing sdn->defer_count,
restoring net.core.skb_defer_max to a value <=3D N leaves sdn->defer_count
at or above defer_max with an empty sdn->defer_list, permanently
disabling deferred freeing for that (cpu, node) pair.

Also, if sdn->defer_list has fewer than (defer_max >> 1) entries queued
when net.core.skb_defer_max is set to 0, enabling skb_defer_disable_key
causes subsequent producers to return before the reject path while
proc_do_skb_defer_max() neither kicks nor flushes pending nodes, which
can strand those queued SKBs if the owner CPU does not raise
NET_RX_SOFTIRQ on its own.

[Severity: Medium]
Does calling kick_defer_list_purge(cpu) on every rejected SKB cause
repeated IPIs and lock contention when the target CPU has BH disabled or
uses backlog threads?

The commit message notes that kick_defer_list_purge() coalesces through
sd->defer_ipi_scheduled so a burst of rejects costs one IPI. However, in
net/core/dev.c:trigger_rx_softirq(), sd->defer_ipi_scheduled is cleared
in hardirq IPI context immediately after raising NET_RX_SOFTIRQ, before
net_rx_action() and skb_defer_free_flush() run:

    static void trigger_rx_softirq(void *data)
    {
        struct softnet_data *sd =3D data;

        __raise_softirq_irqoff(NET_RX_SOFTIRQ);
        smp_store_release(&sd->defer_ipi_scheduled, 0);
    }

If the target alloc_cpu is running with BH disabled (for example under
bh_lock_sock(), local_bh_disable(), or napi_poll()), or if softirq
processing is deferred to ksoftirqd, hardirqs remain enabled on that
CPU. Each CSD IPI interrupts the target CPU in hardirq context and clears
sd->defer_ipi_scheduled to 0 while sdn->defer_list remains non-empty,
allowing subsequent rejected frees in skb_attempt_defer_free() to send
repeated IPIs until skb_defer_free_flush() actually drains the list.

Furthermore, when use_backlog_threads() is true (such as on
CONFIG_PREEMPT_RT), kick_defer_list_purge() unconditionally acquires
sd->input_pkt_queue.lock via backlog_lock_irq_save() on every rejected
free even when NAPI_STATE_SCHED is already set on sd->backlog.state:

    if (use_backlog_threads()) {
        backlog_lock_irq_save(sd, &flags);

        if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
            __napi_schedule_irqoff(&sd->backlog);

        backlog_unlock_irq_restore(sd, flags);
    }

> =20
>  	llist_add(&skb->ll_node, &sdn->defer_list);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019174400.1377=
093-1-jkain@nuro.ai?part=3D1
