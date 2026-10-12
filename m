Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97295357D08;
	Mon, 12 Oct 2026 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791847687; cv=none; b=SIBZ7ZDM34PEVxHfcft0QysbfAh2uXFT5wCMpYqhC4+N2LTk4GmplpRTcXomS9GClKhc4Cr57VN5cNpk+qz6lIxF2PBv4sS2oPDGI6PF+kan/vGANzd7Lpb3lrj4rG2zLxMPI2q2jvPXecIU9dEzBDTW//2hcWlPsNcRR44+dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791847687; c=relaxed/simple;
	bh=QEXzlbnFVgwc+JP+qE5LQb/H6+wO6B9yWmAhgi/yCUg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AytDpIKx37tQwZHgHYdI5bFzpwHbVGA/J7/+9Z2PvwMzhWBtKAbDx2Md4j94P2r07YjxtfrO8uFOFpCj/wo3j/ZhjrPct/8XG9PJqEL/ce/VqSciwdD56rKG2a8NLP4y4eK2cozS5CbcB1YsVPnmi9yecM83DjdxQH6aOQRwpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW8SmKqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW8SmKqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F711F0089B;
	Mon, 12 Oct 2026 23:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791847686;
	bh=x4QWWhSGkIIeeGunKR//0WtK5Y28qf1EYFbA7Wu7upw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fW8SmKqTJNW4h0C323Bb4Sd24dQNBwAyuKwS3JDFzJ/VbJON0lhmcGsTqv89JtzX5
	 TEYaNCbcQdeZ7jBFTxlS+Ag705Mw485EfbVorh0u/1wemf5jEaB7jgrhC9xmR0VVSe
	 Opndc5PtO5N1FtHODp4PFS73rLRE6ZivvZhxCr34Mn81Uy9Pzf5B4S+N2b8kp6HmCl
	 DOzqJhRpToGVImcxHyEPmVHREenQjWnU9SBh7eAUtwBKIiBpXhGgNRuRDqOqCiQ0bu
	 pkNIGFLC13HQGJ8XGcO0f4V/K16Oi+KU1wrPWVQgZ3wtdiW7j3xNAv+a2gzqa2wUAb
	 wrh48g3uh5SSw==
Subject:
 Re: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
From: netdev-bot+sashiko@kernel.org
To: jkain@nuro.ai
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 23:28:05 +0000
Message-ID: <179184768524.434549.10991307098335983416@kernel.org>
In-Reply-To: <20261008220256.1844072-1-jkain@nuro.ai>
References: <20261008220256.1844072-1-jkain@nuro.ai>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only partly fixes a stranded defer_count.

Pre-existing issues:
- [Low] The skb_defer_max documentation and the sysctl range do not match
  how the counter works.

--

net: do not let defer_count outlive an empty defer_list

This patch changes __skb_defer_free_flush() so that it drains the
defer_list before it clears defer_count. It also clears defer_count on the
empty-list path. The goal is to stop a stale counter from turning off
deferred skb freeing for a (cpu, node) pair until reboot.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..e847e243a692e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6938,10 +6938,13 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
>  	struct llist_node *free_list;
>  	struct sk_buff *skb, *next;
>  
> -	if (llist_empty(&sdn->defer_list))
> +	if (llist_empty(&sdn->defer_list)) {
> +		if (unlikely(atomic_long_read(&sdn->defer_count)))
> +			atomic_long_set(&sdn->defer_count, 0);
>  		return;

[Severity: High]
Does this recovery path ever run on a CPU whose counter is stranded?

The counter is only cleared when the owner CPU calls
__skb_defer_free_flush() itself. skb_defer_free_flush() only walks the
this_cpu_ptr() sdns. It is called from net_rx_action(),
napi_threaded_poll_loop() and busy-poll.

The producer side in skb_attempt_defer_free() is unchanged:

net/core/skbuff.c:skb_attempt_defer_free() {
    ...
	defer_count = atomic_long_inc_return(&sdn->defer_count);

	if (defer_count >= defer_max)
		goto nodefer;
    ...
	/* Send an IPI every time queue reaches half capacity. */
	kick = (defer_count - 1) == (defer_max >> 1);
    ...
	if (unlikely(kick))
		kick_defer_list_purge(cpu);
}

The reject path keeps the increment and never reaches
kick_defer_list_purge(). Once the counter is at or above defer_max, no
producer schedules a flush on the owner CPU.

Some CPUs only get NET_RX softirq through these kicks. One example is an
application CPU that sends TCP or UDP while NIC IRQs are pinned to
housekeeping CPUs and RPS/RFS is off. napi_consume_skb() frees its TX
skbs in a remote TX-completion NAPI. That path calls
skb_attempt_defer_free() because skb->alloc_cpu != smp_processor_id().

On such a CPU, wouldn't the reproducer from the commit message still
strand the counter with this patch applied?

  sysctl -w net.core.skb_defer_max=1
  sysctl -w net.core.skb_defer_max=128

The list is empty and the counter is large. Nothing calls
__skb_defer_free_flush() on that CPU, so the new clear never runs. When
the limit changes, proc_do_skb_defer_max() neither resets the counters
nor schedules a flush.

The same applies if the limit is lowered below the current count before
the half-capacity kick fires, for example from 128 to 32 with the counter
at 40. The queued skbs would then stay on a kick-only CPU's list
indefinitely.

The commit message says:

  "Clear the counter on the empty-list path as well, so no count can
  outlive an empty list and an already-stranded counter recovers."

Does that hold when the owner CPU never runs net_rx_action() on its own?
The cross-CPU TCP RX test would not show this case, because there the
alloc_cpu is the NAPI CPU.

Could the producer side change as well? One option is not to leave the
increment in place on reject, either by undoing it or by checking before
incrementing. Another is to make sure the owner CPU gets one kick when
the limit is reached.

> -	atomic_long_set(&sdn->defer_count, 0);
> +	}
>  	free_list = llist_del_all(&sdn->defer_list);
> +	atomic_long_set(&sdn->defer_count, 0);

[Severity: Low]
This is a pre-existing issue, but the skb_defer_max documentation and the
sysctl range don't match how the counter works.

Documentation/admin-guide/sysctl/net.rst says:

  Max size (in skbs) of the per-cpu list of skbs being freed
  by the cpu which allocated them.

skb_attempt_defer_free() increments before it checks
defer_count >= defer_max, so at most defer_max - 1 skbs are queued. The
list is also per (cpu, node), not per cpu. The doc also doesn't say that 0
turns deferral off, which proc_do_skb_defer_max() handles through
skb_defer_disable_key.

The ctl_table entry has .extra1 = SYSCTL_ZERO and no .extra2, so 1 and 2
are accepted. With those values, this half-capacity kick never fires:

	kick = (defer_count - 1) == (defer_max >> 1);

With 1, nothing is queued and the counter keeps growing. With 2, one skb
is queued and waits until the owner CPU runs NET_RX on its own.

One part of this is new with this patch. A producer that lands between
llist_del_all() and atomic_long_set() now leaves its skb queued but not
counted. The list can therefore briefly grow past defer_max - 1. The
commit message covers this ("bounded by the producers in flight").

Could a short comment here say that this is intentional? The similar
qdisc path in __dev_xmit_skb() has one:

	/* There is a small race because we clear defer_count not atomically
	 * with the prior llist_del_all(). This means defer_list could grow
	 * over qdisc_max_burst.
	 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008220256.1844072-1-jkain%40nuro.ai
