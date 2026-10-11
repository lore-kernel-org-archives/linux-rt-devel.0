Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93235DA42;
	Sun, 11 Oct 2026 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791743741; cv=none; b=gTE7Q091iriDcMCmi3yTZS8nB6al1b2Myp0EfEWweAFL5GYwuQ3Qxz6FfhkHVRpoLvj1gWpn/nHYL5k4H8lPBHfe9iD7aa8Kz3NOcST9VOcU8SlEFysLTb/nzi5VEZU1fduD3Hvjrc/hBJAvwEp24Z++LWHy/287a9P+30iJg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791743741; c=relaxed/simple;
	bh=jkvgEiNmPdaIDXG7/7ega0mXbOBEbdWq2xBlCmsyy5Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+DQYfWECMD91I6r4tveDKp2I3pguyjMxaiKrtyAagRVPxM7a9FZQCDh++GzzvGE21YzTTA2vTP2kq8fLef9mLnaH0x5eLVrBftO28g1DOi2nvyOymF8eaHVY7JO37pVcR5UUmdLYo3yE2jdcVvYZYEW8sbHm5Yf3D8nKedN95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6O6dt1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6O6dt1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D981F0089B;
	Sun, 11 Oct 2026 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791743740;
	bh=vadG8Jr+bOGNL9vaxNaELw49Sa1QcE71MooFeSTd670=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l6O6dt1XC6FBNVpzKz/UXOhas+N8H6xsLL+neM2G/dRyy7xV9YUT0bAD8kiypQbTX
	 nsrbXCtthM5HBklMESCd/7REwZXCnVCMJkRy1Xd9nLmGnehHifRbf+8LRxQ5GpFOGD
	 AJ0s9XrR7X4zX/xMv87l4wqdPyGhXG4s2Kx74VkiTS9+2el19+w3Y7DXDjiJLFXav6
	 tNH/Lypg5Ekjz6sxgSWPfIBtnLBtogQvuWlz9l8/8j3O3WFvS+76kF58Ip1m9YnLE9
	 MizxxMMW7c26HFhhnDmdFqvw5AaJsmK5Qh8xKqRw6DuLZlcx3xFyoP+yE/zk77OOO0
	 3spsg8wrGiW5Q==
Subject:
 Re: [PATCH net] net: do not let defer_count outlive an empty defer_list
From: netdev-bot+sashiko@kernel.org
To: jkain@nuro.ai
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 18:35:39 +0000
Message-ID: <179174373903.434549.2352317203073383628@kernel.org>
In-Reply-To: <20261007180056.1394868-1-jkain@nuro.ai>
References: <20261007180056.1394868-1-jkain@nuro.ai>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix depends on __skb_defer_free_flush() running on the CPU
  that owns the list.

--

net: do not let defer_count outlive an empty defer_list

The patch reorders __skb_defer_free_flush() so that defer_count is cleared
after llist_del_all() instead of before it. It also clears a non-zero
defer_count when the defer_list is found empty. The goal is to recover a
(cpu, node) whose counter is stranded at or above skb_defer_max.

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
Does this reset run in the stranded state?

__skb_defer_free_flush() only runs for this_cpu's nodes. Its callers are
net_rx_action(), threaded NAPI, busy poll and CPU hotplug. The producer
side, skb_attempt_defer_free() in net/core/skbuff.c, increments and
rejects before it reaches the only kick:

net/core/skbuff.c:skb_attempt_defer_free() {
    ...
	defer_count = atomic_long_inc_return(&sdn->defer_count);

	if (defer_count >= defer_max)
		goto nodefer;

	llist_add(&skb->ll_node, &sdn->defer_list);
    ...
	kick = (defer_count - 1) == (defer_max >> 1);
    ...
	if (unlikely(kick))
		kick_defer_list_purge(cpu);
}

Once defer_count >= defer_max, every producer goes through nodefer and
returns. None of them calls kick_defer_list_purge(), so nothing raises
NET_RX_SOFTIRQ on the owner CPU.

napi_consume_skb() sends every alien TX-completion skb here. The owner can
be an application CPU that allocates TX skbs but does no NAPI, RPS/RFS or
backlog processing itself. On such a CPU, does the commit's own reproducer
still latch?

  sysctl -w net.core.skb_defer_max=1    # every free rejected, count climbs
  sysctl -w net.core.skb_defer_max=128  # count already >= 128, no kick

In that case the new reset in __skb_defer_free_flush() never runs, and
deferral stays off for that (cpu, node).

The same thing seems to happen in two other cases. With defer_max=2, one
skb gets queued but the kick condition (defer_count - 1) == 1 never matches
before the reject. It also happens whenever skb_defer_max is lowered below
the current count. proc_do_skb_defer_max() does not reset the per-node
counters or request a flush when a positive value is restored.

The commit message says:

  "Clear the counter on the empty-list path as well, so no count can
  outlive an empty list and an already-stranded counter recovers."

Is that only true when the owner CPU runs NET_RX for unrelated reasons?

Would a producer-side change also be needed to close this? Two options are
undoing the increment with atomic_long_dec() on the reject path, or kicking
or flushing the owner on reject.

> -	atomic_long_set(&sdn->defer_count, 0);
> +	}
>  	free_list = llist_del_all(&sdn->defer_list);
> +	atomic_long_set(&sdn->defer_count, 0);
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007180056.1394868-1-jkain%40nuro.ai
