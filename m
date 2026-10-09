Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7E37FF67
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Oct 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561150; cv=none; b=RNWZuJOq2qSM4qj/xIEd+9IRzYOLzbuoXRp1yrvFko1U/aD0Jrf9cO1zlYsEHUjNPORW+fPVqFQgAQlsC49yEzcz6O40BZYj24weINASKOZVVGprrN41xzq6at2IA/H2pQhceON71FBRvixziTE9G/37nc1xCjza8A5db8e5spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561150; c=relaxed/simple;
	bh=Bp8Y3B+4k1arBEAPTQHV+Jezm+XIuoVKGwAJXnjuv9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsQoG7DNXVGRstNKiDgMd9MARgV25IZqm3SV1/WSee8uhsfrhvqqPILkmwrrEOeIDhI0Jbbm23zvIIIfyjyYLQuNFZWejCB5f8iWnTlWXxfQtwOh/GErArDb+hp7uzW/N3qzOvaNKKJUq1rxjceH3EmHDwJ/R2WuyNywcrMGxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0hK3+yrw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yMZxadU1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hK3+yrw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yMZxadU1"
Date: Fri, 9 Oct 2026 17:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791561146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80QEXrpzD+kFda3/t4OvfmIyHa2usi5G2SbXsA7Iaek=;
	b=0hK3+yrwjLIuBKWsevUjEqlQwGjIc1bngq037sYMRJadfTM6pWehYVHiL8wQoE/dW6w9xt
	bYVDKnraYa7sB0xO/OuinBr3i1iI3hJHi2G1940ynLPs3ELBknW5L2+RyWzoA8bt28r7yJ
	dvjm4IEuMhU9Qqyn8zvEYm34M5l44Tn4nVHV5U7znEJzsbNl3/2GY9qd3jHU8vL/m6lPhY
	yBOJDdtxPQFUCECQuToR2gFFlH6a/+QRGMg8H5f8RvlP0kZEl3D/eW6V/Kfh3/lj1i4SwX
	kFXCu0NxeVjJpFgIwTLRaKhx/2zCZ5GPKTQpQxrBWoGCL8O33Va+V0yKW7ww5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791561146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80QEXrpzD+kFda3/t4OvfmIyHa2usi5G2SbXsA7Iaek=;
	b=yMZxadU1OrZtchHsqw7H5PtHO4vxKtc1FDCeI9sB+ECH0vjq7LRfJOxAlO5nsNJyAabYlJ
	hzUHf1pkzHfvsKDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <20261009155225.6Uy7b0wd@linutronix.de>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001074819.gQ3w8q6P@linutronix.de>
 <ar7sTVun7mF-4nl6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar7sTVun7mF-4nl6@gmail.com>

On 2026-10-02 01:30:45 [+0200], Karl Mehltretter wrote:
> > >   BUG: sleeping function called from invalid context
> > >   in_atomic(): 0, irqs_disabled(): 1, non_block: 0
> > >   rt_spin_lock
> > >   skb_queue_tail
> > >   netpoll_send_skb
> > 
> > How is this possible? netpoll is only used by netconsole right? And this
> > is CON_NBCON so it only prints threaded. What is the missing piece?
> > 
> 
> The call is from the NBCON printer thread, but netpoll_send_skb()
> explicitly disables hard interrupts around __netpoll_send_skb():
> 
>         local_irq_save(flags);
>         ret = __netpoll_send_skb(np, skb);
>         local_irq_restore(flags);
> 
> When direct transmission cannot complete, __netpoll_send_skb() calls
> skb_queue_tail() before interrupts are restored. Its spinlock can sleep
> on PREEMPT_RT despite the caller being a thread.

We have netconsole as a user of netpoll. The netconsole user is nbcon.
There are users such as macvlan and dsa and this looks like not a real
user but just forwarding the netpoll packet. According to the history
for macvlan, it is just there to forward the netconsole packets so it
appears to check out.

So it is just netconsole which is NBCON but has CON_NBCON_ATOMIC_UNSAFE.

In the ::write_thread() case the interrupts are disabled due invoking
::device_lock(). In the ::write_atomic() the lock function might not be
invoked but due to the nature of the situation the interrupts will be
disabled anyway. So disabling interrupts looks like a lazy way of
letting everyone know that ::ndo_start_xmit() will be invoked from
netpoll/ netconsole.
I don't see anything that would mandate disabling interrupts in
__netpoll_send_skb() except BH need to be disabled before
HARD_TX_TRYLOCK(). 

I would suggest to untangle that local-irq-disable assumption. Then we
end up with the ::write_atomic callback on PREEMPT_RT which will raise
warnings. But those will appear only on panic() and as the last console
due to CON_NBCON_ATOMIC_UNSAFE so everything will go according to the
plan.
On !RT the whole __netpoll_send_skb() will be with disabled interrupts
due to the console lock. On RT it won't and I don't know if anything
down the call chain assumes that.

To illustrate my idea a bit

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1c6b1eec5efd6..3853611f672be 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -71,6 +71,9 @@ void netpoll_zap_completion_queue(void);
 unsigned int netpoll_get_carrier_timeout(void);
 
 #ifdef CONFIG_NETPOLL
+
+DECLARE_PER_CPU(atomic_t, netpoll_active);
+
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
 {
 	struct net_device *dev = napi->dev;
@@ -96,7 +99,7 @@ static inline void netpoll_poll_unlock(void *have)
 
 static inline bool netpoll_tx_running(struct net_device *dev)
 {
-	return irqs_disabled();
+	return atomic_read(this_cpu_ptr(&netpoll_active)) > 0;
 }
 
 #else
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index fe1e0cda5d6bf..8ecdac601ca13 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -73,7 +73,9 @@ static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 		}
 	}
 
+	/* local_irq_save() ? */
 	status = netdev_start_xmit(skb, dev, txq, false);
+	/* local_irq_restore() ? */
 
 out:
 	return status;
@@ -258,7 +260,8 @@ static int netpoll_owner_active(struct net_device *dev)
 	return 0;
 }
 
-/* call with IRQ disabled */
+DEFINE_PER_CPU(atomic_t, netpoll_active) = ATOMIC_INIT(0);
+
 static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	netdev_tx_t status = NETDEV_TX_BUSY;
@@ -268,12 +271,11 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	/* It is up to the caller to keep npinfo alive. */
 	struct netpoll_info *npinfo;
 
-	lockdep_assert_irqs_disabled();
-
 	dev = np->dev;
 	/* npinfo->txq belongs to np->dev, so retries must stay bound to it. */
 	skb->dev = dev;
-	rcu_read_lock();
+	rcu_read_lock_bh();
+	atomic_inc(this_cpu_ptr(&netpoll_active));
 	npinfo = rcu_dereference_bh(dev->npinfo);
 
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
@@ -306,11 +308,6 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 
 			udelay(USEC_PER_POLL);
 		}
-
-		WARN_ONCE(!irqs_disabled(),
-			"netpoll_send_skb_on_dev(): %s enabled interrupts in poll (%pS)\n",
-			dev->name, dev->netdev_ops->ndo_start_xmit);
-
 	}
 
 	if (!dev_xmit_complete(status)) {
@@ -319,7 +316,8 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	}
 	ret = NETDEV_TX_OK;
 out:
-	rcu_read_unlock();
+	atomic_dec(this_cpu_ptr(&netpoll_active));
+	rcu_read_unlock_bh();
 	return ret;
 }
 
@@ -332,9 +330,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 		dev_kfree_skb_irq(skb);
 		ret = NET_XMIT_DROP;
 	} else {
-		local_irq_save(flags);
 		ret = __netpoll_send_skb(np, skb);
-		local_irq_restore(flags);
 	}
 	return ret;
 }


and this did not even see the compiler. Plus queue_process() has been
ignored.

> Thanks,
> Karl

Sebastian
