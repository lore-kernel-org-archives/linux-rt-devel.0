Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904946;
	b=2QWEbLf8eVlm9lZKJtWpda8GDUhhKBYx1Y5n6W44wBjOT5NBbNgatqYCRUOI7RCfhV6O
	 HWnyRcQV8j6VvKAWuzKPfX5CZ6pLGi46sEMXNu4zpqrxkV6sTE6tnuZ4FUF2nsQaXmDxu
	 IdTXKpYoPlX0nWFN0vhRtOHe0C2hXJ8zNK1hX6e4+Z232pYlT5UDASwQLhr0S/0/gwSjk
	 01sQtvBIZKuyLYlr7GfWHOTBnZBOrVoMOMHzxUKEu9nbcfyDeqWm/jK4q+Xvfd2bph2fA
	 lbqf0YrwVevlI343tLQmuVc1Xfv8wiU4PSfE8pl4RA3b+koxQvk/ZfceewTybGRxiTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nG4n6RbhRtbsAmKm5luV95OTsd5m2vOsTQEC1Oq46ng=;
	b=VWDSOlAN2Ei8LMRXwO94zk1dWLJWLMoil8SKJ/lXD6FxrLGAahTtEAksb7zCvJTSuPFC
	 wHJa81L5AV4hk7Fqae0jccHzAoGV8+re7vVqcZFvml5BFsY+qhOcCaN0leeMOK0+Slj1R
	 AqLk3uFIfkDwVsWArqi9WG7kgRhxzQ3ZXmEkM6Bgda3JOWUG46HJ1++hk90pyvUsdlSUO
	 8jFAVckoWmlFoUqJkfXKuKsQaDz+7GI0feLosf84+KOHluLbEHQBepkdIeNHUKR72gCDD
	 2UBH0NkFUK3HQR7MvbzI1Ad/o44hkw8rbSNqQB8r58wQzg0sWkb0GLqa2nB3r8it7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aECHn9uP;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C62606A337
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C62606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aECHn9uP
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-716d052dc23so686014eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904944; x=1794509744; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nG4n6RbhRtbsAmKm5luV95OTsd5m2vOsTQEC1Oq46ng=;
        b=aECHn9uPqcMl6BPYhSbBc37J2aOe+PLlf7Bv85jLqU+ylqYVWmFSitgM6XxExH3yD2
         GdbstRhWCgojIS0cuishvFTiv4a1P6iKN92SPDvDPdNmlSzm9c7s4kEDL6lGwMNF1N8L
         ZZ+4sDwrBJrKW0BaiYm1vnKXqnEkNufXcEwqbmpJTDATgydmgfbgTiZ5Ja6GxzuKVW7L
         keudZG+ne+mawNaGDD+H3qROnKhpxJB+H81LF5CMZEcPQApVKNf7q+EZUb8Llho3L3Ce
         JUu7RnW7mRHPd7JRqrsbXhX0hlzSEtqGyajESNSY1kstfxQhgqe+InRoCazaGCljhJoO
         +8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904944; x=1794509744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG4n6RbhRtbsAmKm5luV95OTsd5m2vOsTQEC1Oq46ng=;
        b=WOXNluvT5drrGoFpYyYfHgU2vKZZyLZl1xJnx+CrzbovMwGBrs42UVS+4zJWccOsFu
         iLqB7TcBPv2UmcOLrrFNlS3dFzY8OaswqpIhkCbO+0uiN4xLGoK4y/jHf2gfdoVr5m31
         U4BCWjvSqQQW7M4HZ1rRuuhAL7SjtXNzZUyh8jFTEzIaGb9JckBx3jvFky9ZhS5kad4E
         x4Tk/LF6/nmXEACjy6f5jT7z/FwRimC08cXTYH5OcjWVE+3We6rJRzS4lH/EUYS3xftP
         XmkQyy0Cmb92fXKm4N7+DF89gYJEYaTpTRHC9MhL02XMN/6YFOuzlfA0adC3Tckhsocu
         L8xg==
X-Forwarded-Encrypted: i=1; AKwUvByV0tqZwUxABVPvgry/chKU3XbFQjg7yiTZg2ya/1umCl5PXXDbU7UMiLi3nkvqE8VOHOkaTv+sHgj3C/MEeg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/V3g1qny8yqmbXNsl1BvW6MQv8+5gYXxjoM5z2au4nwIxRtDH5
	BckigeKVA7RSJfWM9Bb0NisIcsOqacQP58iGGwmyASDAkeBbVXUxOQWp
X-Gm-Gg: AYBFou2gg3qa8mN+i1I/zq8yqJ8msytFRI9YPB7+SEzNK/EUpGW/ZeNXY6np1RatFHR
	zhYFGCb09l/pa733sDltaydWAikkJ1ezSy9HAgwMg8Mh+4jEZI8Ln/EbI+YTdbRKNZEZakeej+I
	O2RvLI3sYOrnJeIipgzy6kEaRClfVJgICPVlMPG0jtABer5WHe5K9vPQWWceNmq3lpY1EV1WpVc
	M1H9Mnxn11gkKEBZy//SmwPtRSVn6cM0Q5Dlr4n6POgFsOSzLXfD4iky3fKs6YzrGXvjSMbCoyu
	rtyEsv8t8Z8XsjxkDUfzkPxVEPezHytQ4sx9/NkUJxQAah8OYNWGVJLup/ZVJGrJ3USzFgdobKB
	KGQrJknKvqGu6XijO7PRFuVFNNEYSjUtLLKsMyaTQ8u3zKg+2M1poiIaPEFHYMP0NPUFY7a3ic0
	zOEeeIIgiImwgkpZ/miwilvW1g4TQv62KGbgcIPwKXnTmq5xzyPwXahoCUpcYa12HNju4DCJAol
	9uhRPLPU3w7GVOQ9gG7BIahGR0M/p9+hcDRj5epUkrcJ51IzmwkIsj6sD0yerUqTswuz9xCSdDU
	Ux39+XHnNoI41jIJD+0Y3vx13620d6AAwSmSTmkpfbXQtDCxnPXQkp+gEIFxRp4N974NmGzDFUu
	dfvc+4xR3+UcsHBgMfPldODfXl54w5oLbRVycA8+Hr/W6CPUZOqUGL6SvA3y+1jnUNSzUb+jnfG
	ZJYjChWK7WU7Y9Fxu41p0o26uCo2of1SkNkMjkgtD7f+RLC4wZpm8y
X-Received: by 2002:a05:6820:1c8b:b0:712:c751:22eb with SMTP id 006d021491bc7-716e73dea8fmr352195eaf.11.1793904943944;
        Thu, 05 Nov 2026 10:55:43 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:23 -0700
Subject: [PATCH v10 07/26] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-7-dca1f6ed29a8@gmail.com>
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
In-Reply-To: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

The controller uses one completion for successive interrupt-driven
waits. Some transfers wait for both command completion and DMA
completion. The handler acknowledges each event and masks it, leaving
any outstanding event enabled; it calls complete() when all requested
events have arrived.

sunxi_nfc_interrupt() currently calls complete() before updating those
registers. A successful waiter can wake on another CPU and start the
next operation before the old handler acknowledges status or rewrites
the mask. Move complete() after those updates so waking the waiter
cannot precede the handler's last controller access.

A timeout also needs to exclude an unfinished handler. With PREEMPT_RT,
the flags-zero IRQ request is forced threaded. Near the timeout
boundary, that thread can be preempted after reading status and enable
bits while the waiter times out, clears the device mask and rearms the
next wait. The saved snapshot can then restore an obsolete
remaining-event mask or, if it satisfies the old wait, complete the new
wait. Masking the device does not invalidate the running handler's local
values. Repeating init_completion() can also reset its waitqueue lock
during complete(). This lifetime problem was identified by code
inspection during review.

Initialize the completion once in probe and use reinit_completion() for
each wait. On timeout, call disable_irq() before clearing controller
state so existing handling finishes and no new handler can enter during
cleanup.

The hardware may have finished before the delayed handler runs, or the
handler may complete the wait while disable_irq() drains it. Recheck
status against the remaining enabled events before clearing either
register. Events already acknowledged by the handler no longer appear
in that mask; if none remain, the wait has completed. This also handles
command and DMA events arriving separately without requiring an
already acknowledged status bit to be set again.

Then mask and acknowledge the events, read back the mask to flush those
writes, and re-enable the IRQ line even if the recheck changed the
timeout to success. Keep partial-event handling in the IRQ handler and
leave polling and controller/DMA abort handling unchanged.

This keeps additional synchronization on the timeout path, without a
driver lock in every interrupt and wait. The caller can sleep, this IRQ
is not registered as shared, and the handler does not acquire the
controller mutex held by the caller. The tradeoff is unbounded cleanup
latency and no priority inheritance: a starved IRQ thread can prevent
timeout cleanup from returning and block other operations on the
controller. This is a handler-lifetime boundary, not an RT
recovery-latency guarantee.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260909085434.C8F201F00A3A@smtp.kernel.org
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9a7b365e998e..111094b1c64c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -401,6 +401,7 @@ struct sunxi_nfc_caps {
  * @chips: a list containing all the NAND chips attached to this NAND
  *	   controller
  * @complete: a completion object used to wait for NAND controller events
+ * @irq: NAND controller interrupt
  * @dmac: the DMA channel attached to the NAND controller
  * @use_mdma: use an internal MBUS DMA backend
  * @mdma_desc: H6-style MBUS DMA descriptor
@@ -420,6 +421,7 @@ struct sunxi_nfc {
 	unsigned long clk_rate;
 	struct list_head chips;
 	struct completion complete;
+	int irq;
 	struct dma_chan *dmac;
 	bool use_mdma;
 	struct sunxi_nfc_mdma_desc *mdma_desc;
@@ -441,18 +443,20 @@ static irqreturn_t sunxi_nfc_interrupt(int irq, void *dev_id)
 	if (!(ien & st))
 		return IRQ_NONE;
 
-	if ((ien & st) == ien)
-		complete(&nfc->complete);
-
+	/* Finish updating the interrupt state before waking the next operation. */
 	writel(st & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
 	writel(~st & ien & NFC_INT_MASK, nfc->regs + NFC_REG_INT);
 
+	if ((ien & st) == ien)
+		complete(&nfc->complete);
+
 	return IRQ_HANDLED;
 }
 
 static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
 				 bool use_polling, unsigned int timeout_ms)
 {
+	bool irq_disabled = false;
 	int ret;
 
 	if (events & ~NFC_INT_MASK)
@@ -462,16 +466,28 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
 		timeout_ms = NFC_DEFAULT_TIMEOUT_MS;
 
 	if (!use_polling) {
-		init_completion(&nfc->complete);
+		reinit_completion(&nfc->complete);
 
 		writel(events, nfc->regs + NFC_REG_INT);
 
 		ret = wait_for_completion_timeout(&nfc->complete,
 						msecs_to_jiffies(timeout_ms));
-		if (!ret)
-			ret = -ETIMEDOUT;
-		else
+		if (!ret) {
+			u32 pending, status;
+
+			/* Drain the handler before it can restore an old IRQ mask. */
+			disable_irq(nfc->irq);
+			irq_disabled = true;
+			/*
+			 * The handler removes acknowledged events from the mask.
+			 * An empty mask means all requested events were acknowledged.
+			 */
+			pending = readl(nfc->regs + NFC_REG_INT) & events;
+			status = readl(nfc->regs + NFC_REG_ST);
+			ret = (status & pending) == pending ? 0 : -ETIMEDOUT;
+		} else {
 			ret = 0;
+		}
 
 		writel(0, nfc->regs + NFC_REG_INT);
 	} else {
@@ -484,6 +500,12 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
 
 	writel(events & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
 
+	if (irq_disabled) {
+		/* Flush the mask and acknowledgment before re-enabling the IRQ. */
+		readl(nfc->regs + NFC_REG_INT);
+		enable_irq(nfc->irq);
+	}
+
 	if (ret)
 		dev_err(nfc->dev, "wait interrupt timedout\n");
 
@@ -2657,6 +2679,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	nfc->dev = dev;
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
+	init_completion(&nfc->complete);
 
 	nfc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(nfc->regs))
@@ -2665,6 +2688,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+	nfc->irq = irq;
 
 	nfc->caps = of_device_get_match_data(dev);
 	if (!nfc->caps)

-- 
2.53.0

