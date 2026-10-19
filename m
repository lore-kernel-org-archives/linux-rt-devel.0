Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428261;
	b=1U1Dq4FRFvIZ2WvClvtyN53YsVbLxnvt9RggaLjv6QXcNB1rXqPgchKa9Qi9z3BIvNQ8
	 xo/fYpIDS6Ks5XxUYkzS5I+z3XA/XeskApWIktEyDqSb/Fp3QfIPibCllg7Yez110oYii
	 9+BYWVsBySHx5Ap7EfYqQSPYcYwFwKUBSUKxFgad0WG9xKO8qj09lWB5F9Jr1V/32sX/j
	 jl7RV9TCU9NBSJjoedsWR4j9CYvIIT7HzOdXEnXm/05fncVbqrXkGWU+oqwEd8+H8flmb
	 G1RFUaOK2+zmziGCIHTBKotkzQoGDOF4+4O+ylOHz5Qp62LBFqnKcL9vP9rOmOFfpWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428261;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xxmctpVt6LC6OQdxxTHfXyb8cOj5HeFKq0AjwhVXAm4=;
	b=P+4BUsmb+MDpxRn/QfGpTx026GP/JipUzQ9xxKm2jZ9At5fA3QmOmM8u+ea/18Gg9dDS
	 6jqd/Z3mfdOLXmBLaXvWr4RL+aS091Sk+iAyytzRqwvgwX8rPVpPWAS+PqY721jWrRFhm
	 RM2D4UY+PEW2ZD5WdFwNHR62yjSpfQC4Tzw5oCBi+QuqsiAo0BlcShbJzbTXY7rkWqTj/
	 VMNGfgPdOjLEjvM0YB81Mnw1eBUjY5DtYTqFYMkwn8ioSt9YJm+eAHFUr8y91HK3geQ/z
	 7vxOx26rbepbxqZmn8gJmAdA+S0sGtT3Z8RdbEXK3L2r0wuyljKqAE1lg7yjVIPcHVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQaPlh8g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5A606A31B;
	Mon, 19 Oct 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQaPlh8g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C791F000C4;
	Mon, 19 Oct 2026 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428261;
	bh=xxmctpVt6LC6OQdxxTHfXyb8cOj5HeFKq0AjwhVXAm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FQaPlh8gKIwJF1ZMcj9IY6o18bQPgRKhMlTz7Id+3Zx6+imad61o4TKPlBP2bGVZr
	 JDrZ3VGH4F3C0zcTTwEEbPboog5yLn/j4nTSQz7CA30Q35EPCC7ANuEiIRAAejJzGd
	 duviv1SH+TWKtbvtx9efkFC6WLU2Yca3ueEATXEAM2gY3gmhtGKF7ESWzvfih6hRGa
	 rb8CdreYFeuJgbnV+FYiOzd1//UREAPMn62VGFrLnUyof093pXq7eMpxIs0BFE+BDt
	 kmBYY2FHzU/ntW3Ai7v3Y4EpZ2W+b5VoxLhu1wbvmkheZv8f+A7BXzGWEbhF/hb3R4
	 xD8v4G6jXfHwQ==
Subject:
 Re: [PATCH net v4] net: do not let defer_count outlive an empty defer_list
From: netdev-bot+sashiko@kernel.org
To: jkain@nuro.ai
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 16:44:19 +0000
Message-ID: <179242825964.3135.3632926428667630864@kernel.org>
In-Reply-To: <20261015162209.485940-1-jkain@nuro.ai>
References: <20261015162209.485940-1-jkain@nuro.ai>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes the empty-list latch unreachable, but a
  closely related latch on a non-empty list is still reachable.
- [Low] Two user-visible behaviour changes in skb_attempt_defer_free()
  appear only in the v4 notes below the '---' line, so they will be…
- [Low] Documentation/admin-guide/sysctl/net.rst (lines 362-368) still
  calls skb_defer_max the 'Max size (in skbs) of the per-cpu list of…

--

net: do not let defer_count outlive an empty defer_list

This patch moves the skb_defer_max test in skb_attempt_defer_free() ahead
of the atomic increment. A rejected free then no longer leaves defer_count
raised with nothing queued. It also changes __skb_defer_free_flush() to
drain the list before it zeroes defer_count.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..411cbf6754f9e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7390,11 +7390,14 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);
>  
>  	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
> -	defer_count = atomic_long_inc_return(&sdn->defer_count);
> -
> -	if (defer_count >= defer_max)
> +	/* Test before incrementing: the reject path returns below without
> +	 * reaching kick_defer_list_purge(), so a kept increment never flushes.
> +	 */
> +	if (atomic_long_read(&sdn->defer_count) >= defer_max)
>  		goto nodefer;

[Severity: Medium]

This fixes the empty-list case. Can a non-empty list still get stuck the
same way?

The reject path here still returns through nodefer without calling
kick_defer_list_purge(). The only kick is an exact-equality test later in
skb_attempt_defer_free():

	kick = (defer_count - 1) == (defer_max >> 1);

proc_do_skb_defer_max() only acts when the value crosses 0:

	if (nval != oval) {
		if (nval)
			static_branch_enable(&skb_defer_disable_key);
		else
			static_branch_disable(&skb_defer_disable_key);
	}

So a change from one positive value to another does not reset
defer_count, does not flush, and does not kick.

If a limit change leaves the count at or past the new half-capacity
point, the kick never matches. The counter then climbs to the limit (or
is already above it), and every later producer rejects without a kick.
For example:

  skb_defer_max=128, count in 51..64 (the 128 kick only fires at 65)
  sysctl -w net.core.skb_defer_max=100   # half is 50, already passed
  count climbs to 100, then every producer rejects
  sysctl -w net.core.skb_defer_max=128   # half is 64, count is 100
  pre-increment 100..127 never equals 64, so it stays stuck at 128

A simpler case: lower the limit from 128 to 32 while 40 skbs are queued.
Every producer then reads 40 >= 32 and rejects.

A preemptible recvmsg producer can also miss the kick. If it samples a
larger defer_max and the limit is lowered before it increments, it
compares against the old half and does not kick.

The owner CPU here is the one the commit message describes.
napi_consume_skb() defers TX-completion frees to skb->alloc_cpu, so a
TX-only application CPU that never raises NET_RX owns these lists.

Deferral for that (cpu, node) stays off. The queued skbs and their pages
stay pinned until something runs net_rx_action() or busy-poll on that
CPU, or the CPU goes offline.

The commit message says:

  "the absorbing state is unreachable without depending on a flush ever
   running on the owner CPU"

Does that hold only for the empty-list state? The sequence above restores
the default value and still does not recover, which is the same symptom
as the reproducer in the commit message.

Would it work to kick on reject when the list is non-empty, rate-limited
through defer_ipi_scheduled or the backlog NAPI SCHED bit? Another option
is to make the kick a threshold-crossing test. A third is to have
proc_do_skb_defer_max() flush or kick the defer nodes when the limit
changes.

>  
> +	defer_count = atomic_long_inc_return(&sdn->defer_count);
> +

[Severity: Low]

This isn't a bug, but the changelog body leaves out two behaviour changes
that come from testing before the increment. They are only described in
the v4 notes below the '---' line, and git am drops that part.

First, the effective per-(cpu, node) limit moves from skb_defer_max - 1
to skb_defer_max, because the old code rejected on the post-increment
value.

Second, the half-capacity kick can now fire at small limits. With
skb_defer_max=1, the old post-increment value of 1 was always rejected,
so no kick was ever sent. Now the first producer after each flush sees a
pre-increment value of 0, which equals 1 >> 1, so it kicks. With
skb_defer_max=2, the kick now fires on the second producer.

Could these two changes go into the commit message itself, for stable
backporters and for anyone tuning skb_defer_max?

>  	llist_add(&skb->ll_node, &sdn->defer_list);

[Severity: Low]

The commit message says "This makes the limit advisory", but
Documentation/admin-guide/sysctl/net.rst still describes skb_defer_max
as:

  Max size (in skbs) of the per-cpu list of skbs being freed
  by the cpu which allocated them.

The atomic_long_read() check and the atomic_long_inc_return() are now
separate steps. Producers that read the same below-limit value all pass
and call llist_add(). The recvmsg callers can also be preempted between
the two steps. The list can therefore exceed skb_defer_max by roughly the
number of producers in flight.

__skb_defer_free_flush() now does:

	free_list = llist_del_all(&sdn->defer_list);
	...
	atomic_long_set(&sdn->defer_count, 0);

Any skb queued between those two steps stays on the list without being
counted, and up to skb_defer_max more can be added on top of it.

The old code was not exact either, and the doc already says per-cpu for
a list that is really per-(cpu, node). Should the sysctl documentation be
updated to say the limit is approximate?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015162209.485940-1-jkain%40nuro.ai
