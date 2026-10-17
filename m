Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E72F60B2;
	Sat, 17 Oct 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273221; cv=none; b=jkapwEu+wIGEcAPImY3xaodvbyzk8Dq0y/pgeiozj8d6NEt7PUQTgISK3zVB69BhPlZxiKjPUAc5zZKt6TuawIo+YHYL3e5dG++a+OlELdsP1oAsTfLz9xaHazgCqox5T8RDmZDVprPf8PXzrOgdwitbjpEifAWqj0z9KLVi4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273221; c=relaxed/simple;
	bh=ZPU+6pL9dSCS0lBdPECZAZr8Yj1+06Le9ECSNxvwusI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R58/jaaSQs36MVLLaCffz/pz/vt4uinDJ2FeIE31FDJBqTWa4jd1i0rTmXK54b+g4lI/Q1kmtdLo7AYTI6XCweRwMf0+Cv1xDmN+dReT6qP2tzw9VYXq1/pQEq8mxzabke6TOu1QxlgUMXBnJZaZrBKMILJnfDf6yU103xVGrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZuUnF5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZuUnF5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8171F000C4;
	Sat, 17 Oct 2026 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792273220;
	bh=WEQoMZ2bChs4RLc/Ijgg2H/5omfdkYuVoREo4xEk6Bg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kZuUnF5oBvFkvzuXKzzquBs8Ath7mdmtPFX+TrzNHScgan2v17kwmtk/VkBw0IOZN
	 eMkBo7vA7PgwUSpl4ZZExc/9Mb8FgwSsPfy5Unpm/8jkHjoMniOddjXe3ZFA8oUc5K
	 +iDZmwKEDDAivN6A+6TZKUQz4ijCpQCyDLhVKtZXEw93ynEBPXDJAagg6qJx3zEPSu
	 tqTDH6jYt9g2mg3hra6GNsnAgfkFKfmAkynBqb6TkK3F8WKOy+mdMqzCbSVuXSmTaZ
	 MrmzP144Rj8oMyKpzbrwzTW3PxOvbZH8yul2T28E/OZ90yCVH81wvxfQCoWz+pAlFz
	 murPH4a4JnNew==
Subject:
 Re: [PATCH net v3] net: do not let defer_count outlive an empty defer_list
From: netdev-bot+sashiko@kernel.org
To: jkain@nuro.ai
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Sat, 17 Oct 2026 21:40:18 +0000
Message-ID: <179227321891.3135.3487538638002916061@kernel.org>
In-Reply-To: <20261013205416.3417296-1-jkain@nuro.ai>
References: <20261013205416.3417296-1-jkain@nuro.ai>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new reject-path undo in skb_attempt_defer_free()
  (net/core/skbuff.c:7399) brings in a new absorbing state that leaves…

Pre-existing issues:
- [Medium] In skb_attempt_defer_free() the reject path jumps to nodefer
  without calling kick_defer_list_purge().
- [Low] Documentation/admin-guide/sysctl/net.rst (line 365) describes
  skb_defer_max as the "Max size (in skbs) of the per-cpu list".

--

net: do not let defer_count outlive an empty defer_list

When the skb_defer_max limit rejects an skb, skb_attempt_defer_free() now
undoes its defer_count increment, so the counter only counts skbs that are
actually queued. In __skb_defer_free_flush() the counter reset now comes
after llist_del_all(), which avoids a transient over-count.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..a5912b728ddd7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6940,8 +6940,11 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
>  
>  	if (llist_empty(&sdn->defer_list))
>  		return;
> -	atomic_long_set(&sdn->defer_count, 0);
>  	free_list = llist_del_all(&sdn->defer_list);
> +	/* Racy on purpose, as in __dev_xmit_skb(): a producer landing between
> +	 * the del_all and this store stays queued but uncounted.
> +	 */
> +	atomic_long_set(&sdn->defer_count, 0);

[ ... ]

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..e45e15506283b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7392,8 +7392,13 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
>  	defer_count = atomic_long_inc_return(&sdn->defer_count);
>  
> -	if (defer_count >= defer_max)
> +	if (defer_count >= defer_max) {

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The >=
test means at most defer_max - 1 skbs are queued. However,
Documentation/admin-guide/sysctl/net.rst describes skb_defer_max as:

    Max size (in skbs) of the per-cpu list of skbs being freed
    by the cpu which allocated them.

With skb_defer_max=1, nothing is deferred at all. The list is also now per
(cpu, node), not per-cpu.

Should the documentation or the comparison be changed so they agree?

> +		/* Undo, or the count outlives the skbs it was counting: the
> +		 * reject path never reaches kick_defer_list_purge() below.
> +		 */
> +		atomic_long_dec(&sdn->defer_count);

[Severity: High]
Can this decrement push defer_count below zero if it races with the flush
on the owner CPU?

The increment and the undo are two separate atomic operations. The
atomic_long_set() in __skb_defer_free_flush() can run between them. With
defer_max = M and M-1 skbs queued:

P1, P2 (remote producers)            owner CPU
atomic_long_inc_return() -> M
atomic_long_inc_return() -> M+1
both take the reject branch
                                     llist_del_all()
                                     atomic_long_set(&sdn->defer_count, 0)
atomic_long_dec() -> -1
atomic_long_dec() -> -2

This leaves the counter at -2 with an empty list.

defer_count is an unsigned long, so the next producer's
atomic_long_inc_return() returns -1, which reads as ULONG_MAX. The
defer_count >= defer_max test is true, so that producer rejects and
decrements back to -2. Every later producer that runs alone does the same.

__skb_defer_free_flush() then returns early on the empty list and never
resets the counter:

    if (llist_empty(&sdn->defer_list))
        return;

dev_cpu_dead() and sysctl writes don't reset it either.

Wouldn't this switch off deferral for that (cpu, node) slot indefinitely,
even at the default skb_defer_max?

Several things can widen the inc-to-dec window: hardirqs, preemption in
process context (the TCP/UDP recvmsg paths), and softirq preemption on
PREEMPT_RT. Meanwhile the flush runs from net_rx_action, busy poll and
threaded NAPI on the owner CPU.

This seems to contradict the commit message:

    The counter then only accounts for skbs that are actually queued, so
    it cannot outlive them, and the absorbing state is unreachable without
    depending on a flush ever running on the owner CPU.

The new comment in __skb_defer_free_flush() cites __dev_xmit_skb() as
precedent. That path increments q->defer_count and drops without ever
decrementing, so its reset can only under-count and can never go negative:

    defer_count = atomic_long_inc_return(&q->defer_count);
    if (unlikely(defer_count > READ_ONCE(net_hotdata.qdisc_max_burst))) {
        kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_BURST_DROP);
        return NET_XMIT_DROP;

The new comment also only covers producers that get accepted. It does not
cover rejected producers whose increment is erased by the store before
their decrement runs.

Would an approach that never increments past the limit avoid this? Some
options:

- atomic_long_add_unless() or a cmpxchg loop
- a signed comparison, so a negative count heals
- having the flush subtract the number of drained skbs instead of storing 0

>  		goto nodefer;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch. The reject path still jumps to
nodefer without calling kick_defer_list_purge(). The kick further down in
skb_attempt_defer_free() only fires on exact equality:

    kick = (defer_count - 1) == (defer_max >> 1);

Can that threshold become unreachable, even with an accurate counter?

With skb_defer_max=2, the only accepted value is inc_return == 1, and
(1 - 1) == 1 is false. Every later producer increments to 2, rejects, and
decrements back to 1.

The same happens if the limit is lowered below the current count before
the old kick fired. For example, with 127 skbs queued under a limit of 256,
set the limit to 128. Every producer then goes 127 -> 128, rejects, and goes
back to 127. The new threshold of 65 has already been passed.

proc_do_skb_defer_max() only toggles skb_defer_disable_key on changes to or
from 0. It doesn't reset the counters or schedule a flush:

    if (nval != oval) {
        if (nval)
            static_branch_enable(&skb_defer_disable_key);
        else
            static_branch_disable(&skb_defer_disable_key);
    }

Consider an owner CPU that never runs NET_RX, such as the TX-only
application CPU from the commit message, whose skbs are completed with
napi_consume_skb() on another CPU. Wouldn't up to defer_max - 1 skbs stay
pinned on that list, with deferral off for that (cpu, node), for as long as
the sysctl keeps that value?

Before this patch, the counter also climbed past the threshold without
kicking. With this patch, it can recover once the limit is raised again.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013205416.3417296-1-jkain%40nuro.ai
