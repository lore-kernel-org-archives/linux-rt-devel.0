Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235758;
	b=F2X0NsmYrjqh+K6rRS+Ad57eqa4J8CF2EOwdYlW4+nLwXT7tDic1bRolhbChVOvudUtx
	 MofDWG6RhckkIZC6+UA5R9ASNEN5Px2cpD/s2tZg4MAi1BvcV9qVbH/r5m91RPEDuPLMf
	 geWrmTdnXCexmAyoDiW+nkk3Q+v7yo+N/DgQXwxHOce1fDh9X1dRr079vHYZmzqmOVnWZ
	 elY0sUxGbjuGsKRvFH1bimf2fk1ptUVVwniDmyPCM583Q28LXvazMLc2zb0XIF8LsFoOr
	 f/d4+8KufRscZVH3vOgvhu9olKWeRjna/sraIhPRhUj6IGH1+x6xFVduvnzezOgjg7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235758;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gxpyvkqUvi0Bq8DLGlGvEz5GbXR1dt2OAgTXG+P00aI=;
	b=tntkPyJMVug8SKSDY/LtU+n5h9vf7pXuWwbk665JecC3bLmUmC7h1k7NexwoLR7gk30E
	 yFksO0kHVUKPKDyQCXnz0mTgpBG459d/ymX2lij0ytsKnPe+RuV7CS8yRfH+HFlHeHWKz
	 S+7JGbd0NmI76AVmqX1FAAOOS7oCLdm7w/rvUdNyVC+Rqv0Ns0tPWG0dD47UGQ8BeKMxm
	 NSV7bw0F6cfl+3QkM7h9xqU9wSzYEyPeFwta59t5SgbVQnK8mbeZFRnXPueTKNe3ZApbv
	 B3rhqEhzXdGc3yw8Ru5NoP2h6ojUiYZ0GMLgR7zjqV11lAzjf25IUtrhfikoJMUMbcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTaIzhqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70F606A31C;
	Mon,  9 Nov 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTaIzhqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622251F0089F;
	Mon,  9 Nov 2026 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235758;
	bh=gxpyvkqUvi0Bq8DLGlGvEz5GbXR1dt2OAgTXG+P00aI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FTaIzhqCV3BnBwkrKrrkDWBYl/HVMC7y8ivrIUVLZ0wyly8sD4aM95tPCt94bTOtT
	 83mywNfjJe7faVHHjMOjfFATxlgA8Tk9Jh/3XIOIcLP69+3ZN1PWauKMaAVaKNJHUw
	 RwS2Xz06rM5kYTo89gDauq3XOvyP3qBLJS63x8d3V5dtSlCuAXpuhePyEnAD2lUwS9
	 UssjzZrkdckE+imQcEC2gMljtcyBhLTJ3ob+9qW4Q/ce5QDigWhwDiHmf73jBmYW4o
	 W/M8JwNJm5FAUDYS/3MjHj5bU5CSB5c22EJ6XvU2bbH7f58c6jt2WpwhqhoMS4AQjA
	 OTljdz1qsaMHg==
Subject: Re: [PATCH net v5 1/5] amt: fix use-after-free when a Membership
 Update re-arms a freed tunnel
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev
Date: Mon, 09 Nov 2026 14:49:16 +0000
Message-ID: <179423575689.994134.7687724928848317687@kernel.org>
In-Reply-To: <20261105125010.1107546-2-omar@blockcast.net>
References: <20261105125010.1107546-2-omar@blockcast.net>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] amt_tunnel_expire() (drivers/net/amt.c:1412) runs on amt_wq.
- [High] amt_del_group() (drivers/net/amt.c:293) used to free the group
  node with kfree_rcu().
- [Low] amt_tunnel_expire() (drivers/net/amt.c:1432-1440) treats
  tunnel->last_seen == 0 as 'no authenticated Membership Update seen'…
- [Low] The subject and opening paragraphs frame this commit as a fix for
  one race the author calls theoretical: amt_update_handler() re-arming…

--

amt: fix use-after-free when a Membership Update re-arms a freed tunnel

This patch stops amt_update_handler() from re-arming a relay tunnel's
gc_wq. The Update path now records last_seen, and amt_tunnel_expire()
uses it to decide whether to re-arm or free the tunnel. It also adds dead
flags for tunnels, groups and sources, and defers group node freeing to a
new global group_gc_wq.

> amt: fix use-after-free when a Membership Update re-arms a freed tunnel

[Severity: Low]

The subject and first paragraph describe one race, which the message
calls theoretical. The diff also fixes several existing lifetime bugs
that the message never names as bugs:

1) In the old amt_dev_stop(), list_for_each_entry_safe() calls
list_del_rcu() without amt->lock, before
cancel_delayed_work_sync(&tunnel->gc_wq). A concurrent
amt_tunnel_expire() can list_del_rcu() and kfree_rcu() the same tunnel.
amt_dev_stop() then calls amt_clear_groups() and kfree_rcu() on it
again: list corruption and a double free. Only an ifdown racing a tunnel
timeout is needed to hit it.

2) The old amt_destroy_source() reused snode->node for
hlist_add_head_rcu() onto source_gc_list, while RCU readers could still
be walking the group's source hash.

3) The old __amt_source_gc_work() freed source nodes without a
synchronous cancel of source_timer.

4) The old amt_del_group() called kfree_rcu(gnode) after only
cancel_delayed_work(), while group_timer or source_timer work could
still be using the node.

The message covers these only with:

    Device stop marks tunnels dead, unlinks them with list_del_rcu(),
    synchronously cancels their work, and frees them after lockless
    readers have passed.

and:

    Review of v3 and v4 raised the races in the group and source timer
    work.

Could the commit message describe each of these failures? Alternatively,
could they be split into separate patches, each with its own Fixes tag,
to make stable backport selection and bisection easier?

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 81d26ef82cf5c..d8914d811f928 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -266,10 +316,10 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
>  		hlist_for_each_entry_safe(snode, t, &gnode->sources[i], node)
>  			amt_destroy_source(snode);
>  
> -	/* tunnel->lock was acquired outside of amt_del_group()
> -	 * But rcu_read_lock() was acquired too so It's safe.
> -	 */
> -	kfree_rcu(gnode, rcu);
> +	WRITE_ONCE(gnode->tunnel_list, NULL);
> +	spin_lock_bh(&group_gc_lock);
> +	hlist_add_head(&gnode->gc_node, &group_gc_list);
> +	spin_unlock_bh(&group_gc_lock);
>  }

[Severity: High]

Before this patch the group node was freed one RCU grace period after
deletion. It now waits on the global group_gc_list, which is drained only
every AMT_GC_INTERVAL (30 seconds), on tunnel expiry, or on device stop.

amt_del_group() has already decremented tunnel->nr_groups by this point,
and amt_add_group() only checks:

    if (tunnel->nr_groups >= amt->max_groups)
        return ERR_PTR(-ENOSPC);

What limits the number of deleted group nodes waiting on group_gc_list?

Each node is kzalloc(sizeof(*gnode) + AMT_HSIZE * sizeof(struct
hlist_head), GFP_ATOMIC). That is about 2.2KB, so it lands in kmalloc-4k.

A remote gateway with a valid response MAC can alternate IGMPv2 Report
and Leave (or MLDv1 Report and Done) inside Membership Updates:

amt_update_handler()
  amt_igmp_report_handler()
    amt_igmpv2_report_handler() -> amt_add_group()
    amt_igmpv2_leave_handler() -> amt_del_group()

Could this pin about 4KB per Report/Leave pair for up to 30 seconds? At
20k pps, for example, that is around 1.2GB, and pinned memory grows with
the packet rate.

When the GC finally runs, __amt_group_gc_work() walks the whole spliced
list with no cond_resched():

    hlist_for_each_entry_safe(gnode, t, &gc_list, gc_node) {
        cancel_delayed_work_sync(&gnode->group_timer);
        hlist_del_init(&gnode->gc_node);
        kfree_rcu(gnode, rcu);
    }

amt_tunnel_expire() and amt_dev_stop() (under RTNL) both wait behind
this list via flush_delayed_work(&group_gc_wq).

The deferral is still there at the end of the series.

[ ... ]

> @@ -1342,14 +1415,40 @@ static void amt_tunnel_expire(struct work_struct *work)
>  						      struct amt_tunnel_list,
>  						      gc_wq);
>  	struct amt_dev *amt = tunnel->amt;
> +	unsigned long deadline;
>  
>  	spin_lock_bh(&amt->lock);

[ ... ]

> +	deadline = READ_ONCE(tunnel->last_seen);
> +	if (!deadline)
> +		deadline = jiffies;
> +	else
> +		deadline += msecs_to_jiffies(amt_gmi(amt)) * 3;
> +	if (time_before(jiffies, deadline)) {
> +		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - jiffies);
> +		spin_unlock_bh(&amt->lock);
> +		return;
> +	}

[Severity: Low]

Is 0 safe to use here as the "never refreshed" value for last_seen?
amt_update_handler() stores the raw value:

    WRITE_ONCE(tunnel->last_seen, jiffies);

and jiffies can be 0. On 32-bit kernels INITIAL_JIFFIES is
(unsigned long)(unsigned int)(-300*HZ). So jiffies is 0 about 5 minutes
after boot, and again every 2^32 ticks.

Suppose a tunnel's last authenticated Update arrives in that tick and no
other Update follows. The next gc_wq run would then set deadline =
jiffies and free a live tunnel up to 3 * GMI early, tearing down its
group and source state.

Storing jiffies | 1, or using a separate flag, would avoid the collision.

The check is unchanged at the end of the series, where
amt_tunnel_get_or_create() also sets last_seen = jiffies.

> +	spin_lock_bh(&tunnel->lock);
> +	WRITE_ONCE(tunnel->dead, true);
> +	spin_unlock_bh(&tunnel->lock);
>  	rcu_read_lock();
>  	list_del_rcu(&tunnel->list);
>  	amt->nr_tunnels--;
>  	amt_clear_groups(tunnel);
>  	rcu_read_unlock();
>  	spin_unlock_bh(&amt->lock);
> +	flush_delayed_work(&group_gc_wq);
>  	kfree_rcu(tunnel, rcu);
>  }

[Severity: High]

Can this flush deadlock amt_wq? amt_tunnel_expire() runs on amt_wq, and
so do group_gc_wq and source_gc_wq. That gives a chain of three
interdependent work items on one workqueue:

amt_tunnel_expire()
  flush_delayed_work(&group_gc_wq)
    __amt_group_gc_work()
      flush_delayed_work(&source_gc_wq)

amt_init() creates the workqueue with:

    amt_wq = alloc_workqueue("amt", WQ_UNBOUND, 0);

so it has no rescuer. wq_update_node_max_active() splits the default
max_active across NUMA nodes: about 1024 on a single node box, about 128
per node on an 8-node box. The workqueue code documents that an unbound
workqueue is only guaranteed to process min_active (WQ_DFL_MIN_ACTIVE, 8)
interdependent work items.

Each amt_tunnel_expire() sleeping in flush_work() keeps its active slot.
Gateways can create tunnels remotely, and gc_wq timeouts of several
minutes fall into coarse timer wheel buckets. Enough expiries could then
run together to fill the node's active limit before group_gc_wq is
activated. Would group_gc_wq (or source_gc_wq one level down) then stay
inactive, with every blocked expire waiting forever?

amt_wq is shared by all AMT devices, so this would also stall event_wq,
the group and source timers, and secret_wq for all of them.

amt_dev_stop() calls flush_delayed_work(&group_gc_wq) with RTNL held, so
a later ifdown would hang while holding RTNL.

The commit message says lifetime "does not rest on the flush". Are these
flushes needed? They are still there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105125010.1107546-1-omar%40blockcast.net
