Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32109395AC5
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122337; cv=none; b=B/engPjWkwSZpVz3LjiJd+l6058InrxWH11addjSYP1gAe+GuUA/HUA1gMRNCUP9Ew1RLfAr9dP5e5lp4DX6GIIdwWrfPxiiFZUXNzFJH8PPKNj31/sgif7bNzEswqUYFSMGsNRZ3jpSm9K3hnTPLRLfLQicCeWRJzCzMtbtHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122337; c=relaxed/simple;
	bh=rEuLYDr43bv01Uvpdc+7lvdWEzGSSi8n2u7CVCX1ggM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdSwh2ofk4km086aSWpv/SfLHPddGhyJsx/oouFgSMJEzg0HRrfgCtNsrzleLLgxcEJdDJh2cq0Oo+/3V1B7GMqv7qYOcn0gkMRQO+n+LbiOf8TOxIKo8vZWW0N7hInHcWKlBQc5zkQJa8WxduJVbd6SBOb6J8PPz5vg6z/W7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNDeZj4W; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNDeZj4W"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-823e4047037so4571152a34.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 20:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122333; x=1792727133; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=piZMAcnvcZQBNALlEjasAqt9FGU3IFC9Bc/Ax/PGx1o=;
        b=kNDeZj4W86sVQky2jPxnJPGFzgx48LJyzOKK6lbJWJqnNPpRb689ttpDHJNDDoh0B2
         JJn0pt1DG3QdH0JHZTTHpzuIhWRy84VVF/1rBKuXQ9iOYoL9iffE2waLNN3eN82YB8yc
         TjrnoGgmxKj5NM3Vd7HvqXC9xQRHNLBeGy4VpLZQnRv/IubfRBFdscANvt7zyngTJdU4
         FYLo0YT3spnUnaFvkIDjUkPQsdy0z+8ijCbfDQds0l466GLGfgSBvijC+PfpV7cjVjAR
         eF3NswwXFeAjmKiUviZi4I8CyLxGF96XLZw+zLq9OQXTrhUzHFFX3lKCmccg+4wTZ2As
         XoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122333; x=1792727133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=piZMAcnvcZQBNALlEjasAqt9FGU3IFC9Bc/Ax/PGx1o=;
        b=LpCD5u0qAAK7j5lpMLLm4xiBIsmN4Yd6kbHhDPb8aUSmj/realGF5857DXXI9uSUUh
         uW2k8vbK4QWpAOinpnx1XzU17C2ywNIHg871dxIgAa4mOKWdK51YSAFrenEsNAm00sKT
         Y7gESIF948yqzXYOIugHU9h8snO7UDnfQ3OK50LnySeLsgGwybi+KVmUBIlCLwUPdyJP
         ARxAQtAbj2vjnZ/Pvm3syRckIx42IRvqt1gD8wQC5LtX79X+hhaZfIrW/mI4Bf/XoEGm
         /bJVHggbg3Fcj1mawJ9KQ6q8FEOuMUqBOcE7gZqtIJxZ5qWF38Wi5bxSkGomsuLx63fQ
         VrtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVvh9Sv3zethwJDdhQgUUh49GJN7lFQelVGSD0M7GWqv0DjopFSnjz4R/w5xBstqMlG5bSIhdUfYiupLonAQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLeIoamj5GllmTtr10pwzdyEgTHrMNxYHLji/1ziRIkX3OvGsP3
	lsrzk12duVcSYXqD1P2QpMZUGF+HHIf8keNoNDoHMt3YklzC5OizTdWA
X-Gm-Gg: AYBFou0AeRMsct3M1bb0pzSt35ohKUdTdugr32JbRd0gU90V0n68SdAR+n5DhzhajPg
	eWlpQOyrOz8i0wR/n9E4t5JKPs8Vfq+b6OG6PxPxSGb7AfbdevM0DY/4aZfFllNXGPzTDtoeDzA
	LJ+bEbuNALZ7DkODYOJRAnWT7cU9NQke4nV1hxftUg6rkFuyW4ZUmBLdACHt9ZJR0deEPzB7l+8
	I96ca/S23GXIMRip87237mOj0r6pzsGL4Z81oEYTsEM5fHn6D+29nQEVBvaIkVmRW7fTl+UXu39
	PMo47RjPl0M+T8DV/bn89WiKp5WKlwEc002Fd3XJjlyiG0INJya3EOETvCB1a8z/Bcxa3eDeaPJ
	+AFlWiqx6LJLKdZ2MMk/zo7mrqmRsRQWJvZ4YV+WX1xc50U9YniDUXiUrGciQVAFYN9vqphCu70
	rAZriEidk+Zz7s5IXsodSxqplLD5zKxsfgZPBtoBcdl48hmrEaG67gsXO1KR7XmJYsHfIg9o/fh
	QF63SGME3dR29SamIvtd/R6M2L4m2hAD1rmVfsZT4fTwU5+snKcngBb9F3/hFybyldQ8fWO7ktS
	/e3RftSDpZE0ZIW/WSnA+jZ6FN1rUhYIbVaovWmp+8OWbFKpGGo0tRcXJnH6owtylnVj3uzcTqA
	VR32y09w0cyxmJkGy8yzOquwOuuoy3zwH
X-Received: by 2002:a05:6830:270d:b0:80c:d34f:5f63 with SMTP id 46e09a7af769-8309814be28mr19957456a34.28.1792122332994;
        Thu, 15 Oct 2026 20:45:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm834402a34.0.2026.10.15.20.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 21:45:19 -0600
Subject: [PATCH v8 04/17] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-4-8ba4881fbee8@gmail.com>
References: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com>
In-Reply-To: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 6c0d3e2d2be2..f7ddd4116bf4 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -393,6 +393,7 @@ struct sunxi_nfc_caps {
  * @chips: a list containing all the NAND chips attached to this NAND
  *	   controller
  * @complete: a completion object used to wait for NAND controller events
+ * @irq: NAND controller interrupt
  * @dmac: the DMA channel attached to the NAND controller
  * @use_mdma: use an internal MBUS DMA backend
  * @mdma_desc: H6-style MBUS DMA descriptor
@@ -412,6 +413,7 @@ struct sunxi_nfc {
 	unsigned long clk_rate;
 	struct list_head chips;
 	struct completion complete;
+	int irq;
 	struct dma_chan *dmac;
 	bool use_mdma;
 	struct sunxi_nfc_mdma_desc *mdma_desc;
@@ -433,18 +435,20 @@ static irqreturn_t sunxi_nfc_interrupt(int irq, void *dev_id)
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
@@ -454,16 +458,25 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
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
+			/* The handler removes acknowledged events from the mask. */
+			pending = readl(nfc->regs + NFC_REG_INT) & events;
+			status = readl(nfc->regs + NFC_REG_ST);
+			ret = (status & pending) == pending ? 0 : -ETIMEDOUT;
+		} else {
 			ret = 0;
+		}
 
 		writel(0, nfc->regs + NFC_REG_INT);
 	} else {
@@ -476,6 +489,12 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
 
 	writel(events & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
 
+	if (irq_disabled) {
+		/* Flush the mask and acknowledgment before re-enabling the IRQ. */
+		readl(nfc->regs + NFC_REG_INT);
+		enable_irq(nfc->irq);
+	}
+
 	if (ret)
 		dev_err(nfc->dev, "wait interrupt timedout\n");
 
@@ -2650,6 +2669,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	nfc->dev = dev;
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
+	init_completion(&nfc->complete);
 
 	nfc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(nfc->regs))
@@ -2658,6 +2678,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+	nfc->irq = irq;
 
 	nfc->caps = of_device_get_match_data(dev);
 	if (!nfc->caps)

-- 
2.53.0

