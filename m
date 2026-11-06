Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969427;
	b=LfZKX1/CbGrJwk/xzztUhLe0KC5R1/OaknAClcB0Bw0GzE3Bek/QqDVX8awpf4TGSugn
	 Y6LG3X64PZMZeIfSRW8dyq4QxZcwp42uUiOLNUoXyOEv1Km6Wk3+dGZENX2rvamPeHl3y
	 d/1IkDw/hN1WIUj1AM1NaKjX3GDrIm4jdBNQ6Nrbv7iIp6qyCDwIwFbaz7V18MThwN5Gp
	 3hnupOVU9J13SHzwlB0mHiuFQFxKVaFhaClmx6mQDuoA5IXDfxBXh3+gcKv4sDZqgqaze
	 Mpauu5MgdA3ukMyN7mYofJmctZss2hAtxCE06Eu4RSIcgZtcGWXP9YwOj7On8kjKMlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NmfONnVAgnIm9TDYhz5jCtE3KY9ukbde4Xt5kgK1j5E=;
	b=OS1hJSANgvPQNydOfkkffIX+ndrapyZ4iJ72oXU/590467d/YhmSyNqLqul3gqu0/sn0
	 Wsj2CP1tP2oDdy5gfgax+7f/gjtI0F2Q54X/0IBZo7cP6U+Hq3S8A/oldeShmO7XXcQKl
	 MszthYQ4mHFPZnxd99y+ywwaxcRyYocVtQ0NiVqHM2hvuk8As9yDgYI9k358rO0hZkXI6
	 sm37EUyoHFAXzZ92K9Sg/cVYi5QxBYTxE5qa9L6iib0jjmVud2Ai1NEuT3QmRhDTFs2JT
	 33hSquxHi09MDLI0RlDQE08F7NCi66qhDua1qzms5+XZC/4m5qU6FSLWEP2WpIXfyWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/SnfQb2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA0606A326;
	Fri,  6 Nov 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/SnfQb2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9821F008A1;
	Fri,  6 Nov 2026 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969426;
	bh=NmfONnVAgnIm9TDYhz5jCtE3KY9ukbde4Xt5kgK1j5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T/SnfQb2On6cE/syWXCIgtHugDJ2OQctD28zCkBH0yCkLta+BxnfK7Z+MG63vALxj
	 fQ6gQE/iFV97oOCZG+i6Wag0x3zCWcVMiKqoDksYp3qPEB0DSHAET4EbqfWC2cIPHf
	 QQvejjV6t+eMqtlZL+ZNzLXt6baxqvIX7NqiXcy+vPOzYBmpRjfj6Bp2wWOFqtVjbA
	 3NfZXiCnRWoBw+SGrPp3O3QKgv0JNkwFUddy1TE90MeQEyHMHM0rR3Wmoejo5l5Rie
	 tjsa4XHUzAbJrTVWHWT+Yp1vv1Kj9TuRnOTtDBQ4/BoOQYBQMYFsRpy6LTtiRqfWAG
	 iQU3Hn38PXV5g==
Message-ID: <sashiko-outbox-201417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/5] amt: fix use-after-free when a Membership
 Update re-arms a freed tunnel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Ramadan" <omar@blockcast.net>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105125010.1107546-2-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
 <20261105125010.1107546-2-omar@blockcast.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 12:50:25 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] amt: workqueue deadlock in amt_tunnel_expire() and
  __amt_group_gc_work()
- [Medium] amt: jiffies underflow in amt_tunnel_expire() when re-arming
  gc_wq
--

commit 96e3ef58f0da0bec1417666e7bc125f374740408
Author: Omar Ramadan <omar@blockcast.net>

amt: fix use-after-free when a Membership Update re-arms a freed tunnel

This commit fixes a use-after-free where amt_update_handler() could re-arm
gc_wq on a tunnel concurrently being freed by amt_tunnel_expire(), by
tracking tunnel liveness via last_seen and deferring re-arming to
amt_tunnel_expire(). It also updates tunnel, group, and source teardown to
mark objects dead under tunnel->lock and defer freeing via RCU and dedicated
garbage-collection work items.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 81d26ef82cf5c..d8914d811f928 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
[ ... ]
> @@ -106,6 +111,42 @@ static void amt_source_gc_work(struct work_struct *w=
ork)
>  	spin_unlock_bh(&source_gc_lock);
>  }
> =20
> +static void __amt_group_gc_work(void)
> +{
> +	struct amt_group_node *gnode;
> +	struct hlist_head gc_list;
> +	struct hlist_node *t;
> +
> +	spin_lock_bh(&group_gc_lock);
> +	hlist_move_list(&group_gc_list, &gc_list);
> +	spin_unlock_bh(&group_gc_lock);
> +
> +	/* Group deletion queues all of its sources first.  Flush that queue
> +	 * so they are reclaimed promptly; a source callback cannot reach a
> +	 * freed group because it resolves snode->gnode under RCU and the
> +	 * pointer is cleared before the source is queued.  Flush rather than
> +	 * cancel: source_gc_wq re-arms only itself, so cancelling it here
> +	 * would stop periodic source GC for good.
> +	 */
> +	flush_delayed_work(&source_gc_wq);
[ ... ]
> @@ -1342,14 +1415,40 @@ static void amt_tunnel_expire(struct work_struct =
*work)
>  						      struct amt_tunnel_list,
>  						      gc_wq);
>  	struct amt_dev *amt =3D tunnel->amt;
> +	unsigned long deadline;
> =20
>  	spin_lock_bh(&amt->lock);
> +	/* amt_dev_stop() has taken ownership of the teardown. */
> +	if (READ_ONCE(tunnel->dead)) {
> +		spin_unlock_bh(&amt->lock);
> +		return;
> +	}
> +	/* A Membership Update may have refreshed the tunnel after this work
> +	 * was queued.  Re-arm from last_seen rather than letting
> +	 * amt_update_handler() re-arm gc_wq: this handler is then the only
> +	 * context that frees the tunnel on the timeout path; amt_dev_stop()
> +	 * still owns teardown during device shutdown.
> +	 */
> +	deadline =3D READ_ONCE(tunnel->last_seen);
> +	if (!deadline)
> +		deadline =3D jiffies;
> +	else
> +		deadline +=3D msecs_to_jiffies(amt_gmi(amt)) * 3;
> +	if (time_before(jiffies, deadline)) {
> +		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - jiffies);

[Severity: Medium]
Can jiffies advance past deadline between the time_before(jiffies, deadline)
check and the subtraction in mod_delayed_work() in amt_tunnel_expire()?

Since jiffies is volatile and spin_lock_bh(&amt->lock) only disables softir=
qs
while leaving timer interrupts enabled, reading jiffies twice without
snapshotting it into a local variable allows jiffies to tick past deadline
between the two reads. If that happens, deadline - jiffies underflows to a
value near ULONG_MAX, scheduling tunnel->gc_wq far in the future so the
tunnel is never expired until device teardown.

Would snapshotting unsigned long now =3D jiffies once before computing and
comparing against deadline avoid this underflow?

> +		spin_unlock_bh(&amt->lock);
> +		return;
> +	}
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

[Severity: High]
Can calling flush_delayed_work(&group_gc_wq) from amt_tunnel_expire() and
flush_delayed_work(&source_gc_wq) from amt_group_gc_work() ->
__amt_group_gc_work() deadlock amt_wq?

In amt_init(), amt_wq is created as a single shared unbound workqueue:

    amt_wq =3D alloc_workqueue("amt", WQ_UNBOUND, 0);

which has a finite max_active limit (and per-node active limits) shared by
tunnel->gc_wq, group_gc_wq, source_gc_wq, gnode->group_timer, and
snode->source_timer.

Both group_gc_wq and source_gc_wq normally sit on their 30-second periodic
timers and do not hold an active workqueue slot. When flush_delayed_work()
runs from a worker already executing on amt_wq, it deletes the timer and ca=
lls
__queue_work() to queue the target work item onto amt_wq, then blocks in
flush_work() -> wait_for_completion() while still holding its own active sl=
ot
on amt_wq.

If all active slots on amt_wq are occupied by concurrent amt_tunnel_expire()
or timer work items (or if pwq->inactive_works is non-empty), the newly
queued group_gc_wq or source_gc_wq is placed on pwq->inactive_works and
cannot run until an active work item finishes, while the active workers are
blocked waiting for that inactive GC work item to complete. This will also
stall amt_dev_stop() under RTNL when it waits on cancel_delayed_work_sync()
or flush_delayed_work().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105125010.1107=
546-1-omar@blockcast.net?part=3D1
