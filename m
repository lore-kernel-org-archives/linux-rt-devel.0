Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D28257437
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379380; cv=none; b=EGxztnD+c3FDJDFMYTiC2HxkNM/+H5MMWvwqzQg+D8JDk/nYGStuskmibplRpP/ITmusOif33NdUioROJlxcGoA5icu4MLAU9kiYqRw+k4TqK3JU7EI8hNgIaqReiJyDaWSfLQ5+GwIJYEE4voeMPBwaL4NNS8f7HKquFchewek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379380; c=relaxed/simple;
	bh=srdOMs6Z1fqbHiicpJ8BEoIR+QLQr5sODhL7FxjljfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqLaHzk4caYs18WX7LPvZ1Gv3vOZko8tXMdl1NkF+oRBGTQOCa3p18QBVOxX/EdJmon9IB9YokFAJTEGKmrX68BMOSsvyFP3yoOxyD03DtFk0YMUUXYg3SbOKLulwJK56mKmpagjs5nMusFf4GJtRE+pXGgoazhCNMeXKkiKIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IhLdjxX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rydGd+JU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IhLdjxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rydGd+JU"
Date: Wed, 12 Feb 2025 17:56:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739379374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUCF4XIcItfRtlThbcPdoyY48xIzwN3Hg4Ihdo9GQDg=;
	b=4IhLdjxXcRYbhY/Qlr8Yjot0fAdRaHIYWx+IQsuA69eM/4dJbxRITkhHYM2SDnK81+IkGH
	cMbcRKzgs0u2Cc/xgBVFdlS0J8g5q3oTDw0wUZvbEgIznsuM/dmt1QYZwKYmW0s+vwZMH+
	LqQOeNU1+fGDIK0/Z5YXMK//a4RWtoVGweUcSe4H3dSPsgcscz6uYVMqtJL6MzCgrSIcgc
	SkoZ4SGyRIyi1iCFyjNR75/vI8qdK2c1e9V39CGUdrE0laAIp/8yWI6cUEb3bDVjGmwh1v
	nrjVbousMNkIDMKPu5acUhShXJMgroJJpDvsfn4amq8WSyJFiy46Xfanhm4SQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739379374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUCF4XIcItfRtlThbcPdoyY48xIzwN3Hg4Ihdo9GQDg=;
	b=rydGd+JUICxI/iiYOeuEc4Cet2/IQG+BXR9p150WIlgrUFgaADTJJmN/3S7obj4ot31DZb
	0JikZqsJuk/02oCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212165612.ogWjReMW@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>

On 2025-02-12 07:56:44 [-0800], Guenter Roeck wrote:
> Hi,
Hi,

> when enabling PREEMPT_RT together with lock debugging, I see the attached
> "possible circular locking dependency" warning when instantiating the pcnet32
> Ethernet adapter with qemu.

I may buy you a virtio adapter :)

What about this in the meantime:

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index c6bd803f5b0c1..c7648045917a6 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -754,6 +754,7 @@ static int pcnet32_set_link_ksettings(struct net_device *dev,
 	int r = -EOPNOTSUPP;
 	int suspended, bcr2, bcr9, csr15;
 
+	local_bh_disable();
 	spin_lock_irqsave(&lp->lock, flags);
 	if (lp->mii) {
 		r = mii_ethtool_set_link_ksettings(&lp->mii_if, cmd);
@@ -789,6 +790,7 @@ static int pcnet32_set_link_ksettings(struct net_device *dev,
 		r = 0;
 	}
 	spin_unlock_irqrestore(&lp->lock, flags);
+	local_bh_enable();
 	return r;
 }
 
@@ -890,6 +892,7 @@ static int pcnet32_set_ringparam(struct net_device *dev,
 		pcnet32_netif_stop(dev);
 
 	netdev_lock(dev);
+	local_bh_disable();
 	spin_lock_irqsave(&lp->lock, flags);
 	lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);	/* stop the chip */
 
@@ -921,6 +924,7 @@ static int pcnet32_set_ringparam(struct net_device *dev,
 	}
 
 	spin_unlock_irqrestore(&lp->lock, flags);
+	local_bh_enable();
 	netdev_unlock(dev);
 
 	netif_info(lp, drv, dev, "Ring Param Settings: RX: %d, TX: %d\n",
@@ -988,6 +992,7 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
 		pcnet32_netif_stop(dev);
 
 	netdev_lock(dev);
+	local_bh_disable();
 	spin_lock_irqsave(&lp->lock, flags);
 	lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);	/* stop the chip */
 
@@ -1065,7 +1070,9 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
 		rmb();
 		while ((lp->rx_ring[x].status & teststatus) && (ticks < 200)) {
 			spin_unlock_irqrestore(&lp->lock, flags);
+			local_bh_enable();
 			msleep(1);
+			local_bh_disable();
 			spin_lock_irqsave(&lp->lock, flags);
 			rmb();
 			ticks++;
@@ -1125,6 +1132,7 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
 		lp->a->write_bcr(ioaddr, 20, 4);	/* return to 16bit mode */
 	}
 	spin_unlock_irqrestore(&lp->lock, flags);
+	local_bh_enable();
 	netdev_unlock(dev);
 
 	return rc;
@@ -2106,6 +2114,7 @@ static int pcnet32_open(struct net_device *dev)
 	}
 
 	netdev_lock(dev);
+	local_bh_disable();
 	spin_lock_irqsave(&lp->lock, flags);
 	/* Check for a valid station address */
 	if (!is_valid_ether_addr(dev->dev_addr)) {
@@ -2305,6 +2314,7 @@ static int pcnet32_open(struct net_device *dev)
 		     lp->a->read_csr(ioaddr, CSR0));
 
 	spin_unlock_irqrestore(&lp->lock, flags);
+	local_bh_enable();
 	netdev_unlock(dev);
 
 	return 0;		/* Always succeed */
@@ -2321,6 +2331,7 @@ static int pcnet32_open(struct net_device *dev)
 
 err_free_irq:
 	spin_unlock_irqrestore(&lp->lock, flags);
+	local_bh_enable();
 	netdev_unlock(dev);
 	free_irq(dev->irq, dev);
 	return rc;

Sebastian
