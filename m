Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691193;
	b=1VtJokvK82i29Qh0dp09P5ZsESPDuKJS5rDF5D3beZH7wC/pBFDej+mZaejl60D72Zjo
	 69IewPgHzkqc6+XDdfeqtPkN/frJNJO9R+RjRuX4Xtou6vFM0hFTmRxYfev9jfn9bGx5U
	 ByjIZtZVHuHRwIt/OaWG/mWGPJiixI0rvc1OvVIi+ENZ4E0t2CBfmhw3Kgtk8M/Ge7Q3B
	 IFiRibNjDTzhm0i56el8W+CFfKSvB3Zc/KvbmaIWffoKNakTqe9xwFkCKuPy+VpxcSitw
	 u3WQywehS0FpMJQzui03+AFpdYxlpWYUoLbyMFVbOBy9p6r+GmsL3IWBgA0WgxrsUeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691193;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RN1roBnXGHM2RUIZqsOiBG/dxCptL71UAyh6p8TcQBA=;
	b=SGVZKISAwxDTma8NOCCFW3zpAneUhzwTy3EcvCGVMMinxY/Cp/xWwD8qIu08V2/DTJAf
	 M9SnIO+g0yLa4sTKw4u1IaVimT/e29Pgu/hBcLRvr5wpux0RCc/KJ/ciikSSkAv2vTtYB
	 o9FAcTc7TkklNnmp0NGFBB8+jaHPaaq+uThWr4XoGhdh4OjpecfKmPwBRku27/2fPfUcD
	 lHr1qiVmJCAMA1M6Wx3+aEfZcZO+uhP1KXRngZox9kzQpyBIrS0hWzngR5n5BuDhDwEK0
	 A37mIfbCh/smX9N3/FlT7vQNZiOkH/iJDg2F5JkJthPOKkTNTRg5Zp+IvBo0RQcoRyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+KSrfRF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858F606A319;
	Thu, 22 Oct 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+KSrfRF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C11F01825;
	Thu, 22 Oct 2026 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691193;
	bh=RN1roBnXGHM2RUIZqsOiBG/dxCptL71UAyh6p8TcQBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O+KSrfRF3uctHI9NPm2SH/1HZi2ZQzfYWRpILKCbF2c+/Q5vG/euq5rH4PzgLpaYL
	 Ilh2P4kxtFtGGeMkjMTATdVBXAfFoMXmfgOaWtlkSu4EUhLpZv2qcz0DiXTY86n4Bq
	 DWSvuK+f6ca825pfR2EfK0HFXfUNmI4oQ6a2jpKAh7y5k75YbFpG1sfGRjrZm80lJ4
	 XqDp9b2FNMlE9KmTQWv9YaaRTsMy/UxairqYjQIOLFoZ5C6Ua3to32hUeatDufzwAV
	 zb4ozOLbHJikIKdF7ulMooMD0KCA/4JDv8Wp1mq2vS4OZw5w1mwfp3D3ifblGrECI9
	 mGukJHIhzQnpQ==
Subject:
 Re: [PATCH net v6] net: schedule a purge when the defer queue rejects a free
From: netdev-bot+sashiko@kernel.org
To: jkain@nuro.ai
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 17:46:32 +0000
Message-ID: <179269119233.3135.4255107020079411339@kernel.org>
In-Reply-To: <20261019174400.1377093-1-jkain@nuro.ai>
References: <20261019174400.1377093-1-jkain@nuro.ai>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not remove the absorbing state that its commit
  message names in its first sentence (defer_count at or above…
- [Medium] skb_attempt_defer_free() (net/core/skbuff.c:7399-7400) now
  calls kick_defer_list_purge(cpu) on every rejected deferred free while…

Pre-existing issues:
- [Low] Documentation/admin-guide/sysctl/net.rst (lines 362-368)
  describes skb_defer_max as the 'Max size (in skbs) of the per-cpu…

--

net: schedule a purge when the defer queue rejects a free

This patch makes skb_attempt_defer_free() call kick_defer_list_purge()
when a deferred free is rejected and the defer_list is not empty. It also
changes the limit test from >= to >, so the effective limit becomes
skb_defer_max. Finally, __skb_defer_free_flush() now drains the list
before zeroing defer_count, so that defer_count no longer stays above
skb_defer_max while the defer_list is empty.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360..a5912b728ddd 100644
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

[Severity: Low]
This is a pre-existing issue, but the commit message says the new > test
matches "what Documentation/admin-guide/sysctl/net.rst describes". The
net.rst text is:

    Max size (in skbs) of the per-cpu list of skbs being freed
    by the cpu which allocated them.

skb_attempt_defer_free() actually enforces the limit per (owner cpu,
producer node):

    sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);

net.rst also doesn't say that 0 disables the feature through
skb_defer_disable_key in proc_do_skb_defer_max().

Should net.rst be updated to describe the per-node scope and what 0
means?

With the new ordering, a producer that calls llist_add() between
llist_del_all() and atomic_long_set() stays queued but uncounted. A list
can then go a few skbs past skb_defer_max. The old clear-then-drain order
allowed the same thing (increment before the clear, llist_add() after
the del_all). The new order only makes that window slightly larger, and
the new comment marks it as intentional.

>  
>  	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
>  		prefetch(next);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421..596f99811bac 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7392,8 +7392,14 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
>  	defer_count = atomic_long_inc_return(&sdn->defer_count);
>  
> -	if (defer_count >= defer_max)
> +	if (unlikely(defer_count > defer_max)) {
> +		/* The kept increment only comes back down when a flush zeroes
> +		 * it, and this is the one path that sees a full queue.
> +		 */
> +		if (!llist_empty(&sdn->defer_list))
> +			kick_defer_list_purge(cpu);

[Severity: High]
Can defer_count still get stuck above skb_defer_max while the
defer_list is empty?

This path only kicks when the list is not empty. The only reset of
defer_count is in __skb_defer_free_flush(), and that function returns
before the reset when the list is empty:

net/core/dev.c:__skb_defer_free_flush() {
    if (llist_empty(&sdn->defer_list))
        return;
    free_list = llist_del_all(&sdn->defer_list);
    ...
    atomic_long_set(&sdn->defer_count, 0);
    ...
}

So an increment that is rejected while the list is empty never triggers
a kick and is never cleared.

The Fixes: tag targets the 6.18 to 7.0 trees, which don't have
skb_defer_disable_key. There, net.core.skb_defer_max=0 seems to lead to
this sequence:

  - the first reject sees a non-empty list and kicks
  - the flush empties the list and sets defer_count to 0
  - every later cross-CPU free increments, rejects (count > 0), finds
    the list empty, and sends no kick

defer_count then grows without bound. Restoring 128 leaves it far above
128 with an empty list. That is the same "setting 0 and restoring the
previous value" case the commit message describes.

On mainline, proc_do_skb_defer_max() stores the new value before the
static key changes:

net/core/sysctl_net_core.c:proc_do_skb_defer_max() {
    ...
    ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
    nval = !net_hotdata.sysctl_skb_defer_max;

    if (nval != oval) {
        if (nval)
            static_branch_enable(&skb_defer_disable_key);
    ...
}

Producers that run between that store and static_branch_enable() taking
effect can read defer_max == 0 and raise the counter while the list is
empty. If a limit at or below the stranded count is then restored (for
example 0 followed by 1), would that latch in the same way?

If so, the claims "From v7.1 on, 0 is safe" and "The reject-path kick
recovers both" don't seem to hold. Some possible fixes:

  - undo the increment on reject
  - reset the counter, and kick, even when the list is empty
  - have proc_do_skb_defer_max() reset the counters or schedule flushes

Would one of these work?

[Severity: Medium]
Does this add a remote lock or a remote cmpxchg to every rejected free
while the list is full?

Before this patch, a reject only called kfree_skb_napi_cache(). Now every
reject with a non-empty list calls kick_defer_list_purge(). The commit
message says:

  kick_defer_list_purge() already coalesces through
  sd->defer_ipi_scheduled, so a burst of rejects costs one IPI.

When use_backlog_threads() is true, defer_ipi_scheduled is not used at
all. That is always the case on PREEMPT_RT, or with thread_backlog_napi
on the command line. The remote lock is also taken before
NAPI_STATE_SCHED is tested:

net/core/dev.c:kick_defer_list_purge() {
    if (use_backlog_threads()) {
        backlog_lock_irq_save(sd, &flags);

        if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
            __napi_schedule_irqoff(&sd->backlog);

        backlog_unlock_irq_restore(sd, flags);
    } else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
    ...
}

Every over-limit cross-CPU free (napi_consume_skb() on TX completion,
tcp_eat_recv_skb(), skb_consume_udp()) would then take the owner CPU's
sd->input_pkt_queue.lock with IRQs disabled, until that CPU's backlog
thread flushes. enqueue_to_backlog() and process_backlog() on the owner
CPU use the same lock.

In IPI mode, every reject does a cmpxchg on the remote
sd->defer_ipi_scheduled. trigger_rx_softirq() clears the flag before the
flush runs:

net/core/dev.c:trigger_rx_softirq() {
    __raise_softirq_irqoff(NET_RX_SOFTIRQ);
    smp_store_release(&sd->defer_ipi_scheduled, 0);
}

When threadirqs or ksoftirqd defers NET_RX, each reject in that gap
would send another IPI.

The notes below the cut line report about 756k kicks over about 750k
skb_attempt_defer_free() calls at skb_defer_max=1. That looks like one
kick per call rather than one per burst. Was the cost on PREEMPT_RT
measured?

>  		goto nodefer;
> +	}
>  
>  	llist_add(&skb->ll_node, &sdn->defer_list);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019174400.1377093-1-jkain%40nuro.ai
