Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702673B6BE6;
	Fri,  3 Jul 2026 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071886; cv=none; b=BVDZkEpc2OZ4e27/+jY/JVAXiEvAwW5C78Vh8XAPH76Pm1NrbzqKGB20/CsbD9kRs3z1e9jScFxUlZSIMf2mvIPN+Je6indiULwraImSM+HjI0svnxgcrEG0m/22xE3e/+YywypLQhJZDmqBhJLzF2kUGUy3MUO8jSTFIVLcOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071886; c=relaxed/simple;
	bh=SKoUgoFIz4qrAp8YEBU0IfaLyGS67qKTcwiU5aK1wiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIk8pBieVeB5kX33jUIaGGUaacpDmot9HcpWXXf5rj8kxugfQ9+Luuy8x7LAk+MxZ44ngTG2zptbfUcLVyevEFhqtqLPIGIJa9YvrCHH0GlilatbTkpGWJslC5ToEAO5dlKw07HVSoPf7i/ajL0Jb+QuWuUKrKEqQI/1iX+7ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NuDaJzbq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YVjTG9Gy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NuDaJzbq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YVjTG9Gy"
Date: Fri, 3 Jul 2026 11:44:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783071881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHmWIGshZRWERtJne3J8n7oUnVrhNYFb2oWb7Q/SF5Y=;
	b=NuDaJzbqu2ahSstJ/ZlJfGuuaU+zi8/uNkY0fB7xLH9hsiecYI68v1hPtCPcrjrPy7N/UB
	gMtONSIjyMvk5nTpDaQWOVcmFZgtHSUjlGoU5kBvMoPXu8u1KlbeaoVum637U2H1VRxyH5
	8DP03KT7q7b39dTQfAFcTotpF0GUgoZNHM8HgqYDrBxLs/DlDLOachg7NSZOmndrMo+ugL
	/xRX3kxTxSb89fNgsCMJBiuyp0+8DgDhnQYhUuyKsbL3ieAqhI5QRSVir39LthCzS5gj8m
	DdKnJjUJbUysalzJ93APhGNoDcD20zW9ePPD+YvoHIVcrC2WfsnmEXTL3UK61g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783071881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHmWIGshZRWERtJne3J8n7oUnVrhNYFb2oWb7Q/SF5Y=;
	b=YVjTG9Gy9UDkNHAGcwmoGPND2rp/Ov+fdxjRb4VHLnGlxbgRhYkFaRlEUqyAqbMSYX0e7z
	jk3mDxYkddof2DAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, Frank.Li@kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v4] remoteproc: imx_rproc: Invoke the callback directly
Message-ID: <20260703094440.18xlPGEl@linutronix.de>
References: <20260703-imx_mbox_rproc-v4-1-67b10560a861@linutronix.de>
 <20260703084521.D8F4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703084521.D8F4B1F000E9@smtp.kernel.org>

On 2026-07-03 08:45:21 [+0000], sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 745ce52cd8226..a1f2b76ec8187 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> [ ... ]
> >  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
> >  {
> >  	struct rproc *rproc = dev_get_drvdata(cl->dev);
> >  
> > -	queue_work(priv->workqueue, &priv->rproc_work);
> > +	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this lockless iteration
> over the notifyids IDR lack RCU protection?
> 
> Because imx_rproc_rx_callback() now runs in a preemptible context (threaded
> IRQ handler), it iterates over the rproc->notifyids IDR using idr_for_each()
> without the rcu_read_lock(). 
> 
> The IDR API requires lockless readers to hold rcu_read_lock() to prevent radix
> tree nodes from being freed during traversal. If a concurrent modification
> like idr_remove() occurs during teardown, the RCU grace period could expire,
> leading to a use-after-free on the IDR internal nodes.

If I see this right there is no RCU involved. First the interrupt gets
removed (via free_irq()) which ensures that it is no longer active and
then the channel is removed.

> >  }
> >  
> >  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
> [ ... ]
> > @@ -1273,17 +1253,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
> >  		priv->ops = dcfg->ops;
> >  
> >  	dev_set_drvdata(dev, rproc);
> > -	priv->workqueue = create_workqueue(dev_name(dev));
> > -	if (!priv->workqueue) {
> > -		dev_err(dev, "cannot create workqueue\n");
> > -		return -ENOMEM;
> > -	}
> > -
> > -	ret = devm_add_action_or_reset(dev, imx_rproc_destroy_workqueue, priv->workqueue);
> > -	if (ret)
> > -		return dev_err_probe(dev, ret, "Failed to add devm destroy workqueue action\n");
> > -
> > -	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
> >  
> >  	ret = imx_rproc_xtr_mbox_init(rproc, true);
> >  	if (ret)
> 
> [Severity: High]
> This is a pre-existing issue, but could the devm cleanup order in
> imx_rproc_probe() lead to a use-after-free during driver teardown?
> 
> Earlier in imx_rproc_probe(), the mailbox cleanup action imx_rproc_free_mbox
> is registered via devm_add_action_or_reset() before devm_rproc_add() is
> called.
> 
> Because devm actions execute in LIFO order, devm_rproc_remove() executes
> first, which tears down the remote processor and frees virtio subdevices and
> their IDR entries.
> 
> This leaves a dangerous race window during driver unbind where the mailbox is
> still fully active while the core remoteproc data structures are being torn
> down. If a mailbox interrupt fires during this window, the RX handler will
> access the notifyids IDR and rvring structures while they are concurrently
> being modified or freed by rproc_del().

The notifyids IDR is removed by devm_rproc_free() not by
devm_rproc_remove(). This should remove the channel which removes IRQ.
This looks fine to me.

Sebastian
