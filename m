Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794722859;
	b=i+BvhvgqjGlclKe4B4ebHIMTanvepI9Z3KyNApFBfftygSFTqtc5i2SITXZVs6n0TWba
	 fgBTOlNTrJ91bkMR/xVvgYRc4BIL/5OQwsFPobO1r9OY1gfZBxFtx2PSejSu71ZJ52hkh
	 Q71l9nvY+wNqgjWUaoA7bOIcHDAO9j6cYXj2ix8jjwrYnNClXFTrcQDY1w7F7qPvR1ku2
	 BGGaTHED2o8EnXk6Zg1chVRZQ7xZ/xaUgjt9sSDA2avulqJGXoX4cwZCdksKflTHwqd6Q
	 9QqN1eEMy7FnCzTr8NDsZ9hkeofbsi+BQyng3aPNJUjXrhBcTl1LnEUTB0bbqmksZqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794722859;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZdGWU1xDsfsW7sNtgyXBAi046XdVD06gOAW+d954Fvw=;
	b=N+grmT/N/kPI43+8gTUYHZs18XijYmDFQ+qZNNTNeUVCyV7Bi+OLeRC0ZCpjJTXBkO4L
	 T0VLtB+ooTPZXZ56aI8JHIPfRvaX5SGckJDQYQbVzQY8Uai8F/5pNAL8NOjIMhVYxwtgt
	 ISiKMOwH7F4MV5YArF9os7Ip5FSvTQf4YDhm7q87Yt+RFmj14PYeoqCR7e56y23n8qc5g
	 ZwBx508F1puPt5wn4N31w4Jm1fvIh36hjhS3Gs1h9B+lsyTm8LJyg9u/IME3k33Ji7HbM
	 CtOTSQPwHzYsGlxRtGfDI84SJGBEZ2fsIpKZ5JZ9LPw4+HDhSV8FnnzU/nL4dl8RibA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fCicJp5/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85348606A323;
	Sun, 15 Nov 2026 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCicJp5/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAF21F000C4;
	Sun, 15 Nov 2026 06:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794722859;
	bh=ZdGWU1xDsfsW7sNtgyXBAi046XdVD06gOAW+d954Fvw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fCicJp5/S2leanAXVxExUMcrj2N5Jxq4uTRUvLk5AzCcWAZj7kuFBAki1wK0Da31R
	 N0fKdPUvXAd++kMWpNZWOQe+qBeUN2JYsH58kO6g/L46VsLlVSv3N5BPmo97oOc3PE
	 sKrPfXwqv00+sd/1+KPngdbe9mBkIbN2BAA+PjNomsOUD6dix4d6V055o9hzYIom4/
	 v7ELF20lNQInUR26YgIRUMPr72Ir0+A559rJKNfpXIxW888pHNi2R3tQeE/mMZlsVL
	 B4l10C++BGzMkwQyGR3Aue3+uQVFiYRcWt/36JA8Ie63R9WilunVyQlUecshF//t8v
	 imT91m0bxLqOQ==
Subject: Re: [PATCH net v7 2/6] amt: fix use-after-free when a Membership
 Update re-arms a freed tunnel
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, kuniyu@google.com
Date: Sun, 15 Nov 2026 06:07:37 +0000
Message-ID: <179472285784.2199510.18288706993986643464@kernel.org>
In-Reply-To: <20261110210538.217936-3-omar@blockcast.net>
References: <20261110210538.217936-3-omar@blockcast.net>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds a parking stage for group nodes before they
  are freed, and nothing enforces a limit on how many can be parked.

--

amt: fix use-after-free when a Membership Update re-arms a freed tunnel

This patch reworks tunnel, group and source lifetime handling in the AMT
relay to close several use-after-free and double free races. Tunnel expiry
now re-arms itself from a last_seen timestamp, and nodes are marked dead
under tunnel->lock. Deleted groups and sources are parked on global GC
lists, and once AMT_GC_KICK (2048) nodes are parked a drain is queued
immediately.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 3a703b79f2c9a..fc3900e255ca2 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -106,6 +120,62 @@ static void amt_source_gc_work(struct work_struct *work)
>  	spin_unlock_bh(&source_gc_lock);
>  }
>  
> +static void __amt_group_gc_work(void)
> +{

[ ... ]

> +	hlist_for_each_entry_safe(gnode, t, &gc_list, gc_node) {
> +		cancel_delayed_work_sync(&gnode->group_timer);
> +		hlist_del_init(&gnode->gc_node);
> +		kfree_rcu(gnode, rcu);
> +		cond_resched();
> +	}
> +}

[ ... ]

> +static void amt_gc_parked(void)
> +{
> +	if (++amt_gc_queued == AMT_GC_KICK)
> +		mod_delayed_work(amt_wq, &group_gc_wq, 0);
> +}

[ ... ]

> @@ -266,10 +347,11 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
>  		hlist_for_each_entry_safe(snode, t, &gnode->sources[i], node)
>  			amt_destroy_source(snode);
>  
> -	/* tunnel->lock was acquired outside of amt_del_group()
> -	 * But rcu_read_lock() was acquired too so It's safe.
> -	 */
> -	kfree_rcu(gnode, rcu);
> +	WRITE_ONCE(gnode->tunnel_list, NULL);
> +	spin_lock_bh(&source_gc_lock);
> +	hlist_add_head(&gnode->gc_node, &group_gc_list);
> +	amt_gc_parked();
> +	spin_unlock_bh(&source_gc_lock);
>  }

[Severity: Medium]
Is there anything that actually limits how many groups end up on
group_gc_list?

Before this patch, amt_del_group() passed the group straight to
kfree_rcu(). Now it decrements tunnel->nr_groups and parks the group on
the module-global group_gc_list. Each parked group is sizeof(*gnode) plus
256 hlist_heads, so a kmalloc-4k object.

amt_add_group() only checks the per-tunnel count:

	if (tunnel->nr_groups >= amt->max_groups)
		return ERR_PTR(-ENOSPC);

nr_groups is decremented before the group is parked. That means an
authenticated gateway sending IGMPv2 Report/Leave pairs, or the MLDv1
equivalents, parks one group per pair and never reaches max_groups:

  amt_igmpv2_report_handler()->amt_add_group()
  amt_igmpv2_leave_handler()->amt_del_group()

amt_gc_parked() never refuses or throttles parking. It queues the drain
once, at the moment the counter equals AMT_GC_KICK. A single work item does
the draining, amt_group_gc_work()->__amt_group_gc_work(), with one
cancel_delayed_work_sync(), kfree_rcu() and cond_resched() per node. With
several tunnels (different source ports or addresses), groups can be
parked from softirq on many CPUs at once.

Can the backlog keep growing if parking outpaces that one worker? Two
examples would be RSS spreading Leave or Done floods across CPUs, or
softirq load starving the unbound kworker. The per-CPU kfree_rcu() batching
used before had a shrinker. This list has no shrinker and no high-water
mark.

The commit message says:

  the kick keeps the backlog near that instead of letting it grow for
  up to 30 seconds

Is that enforced anywhere, or does it rely on the drain keeping up?

The lists and counters are also shared by every AMT device in every
network namespace. Churn on one device grows the backlog for all of them,
and it also lengthens the __amt_group_gc_work() drains that amt_dev_stop()
runs under RTNL for other devices.

Would a hard cap on amt_gc_queued, checked in amt_add_group() where groups
are admitted, fit better here?

Later patches in the series don't seem to change this either.
amt_gc_parked(), amt_del_group() and amt_add_group() are still the same in
"amt: create relay tunnels only from authenticated Updates".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110210538.217936-1-omar%40blockcast.net
