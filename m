Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223493;
	b=h6MdPGsTlsOjjTGa4a+L+vb0kMfWmmoALf8SAHJynlTNRzlTj7Eu5YfWsqjE6xsjG8nt
	 oee66XAkDBg6IsQFXEfnz5CRldqF1GQFQwbqsNiYvf2VsDsizG/lbKkI4ju8sna0OHHD3
	 TBO8+jZ8NDo+fXbabzrVOCBm+2eIKEZAxlQjtwQNGmTKWpd4HHK93xVBxTRLXyHgrY+4w
	 29735FL77eQpLBY+w/VBx7sX2wBdibeGi++j+QdB7E8fxuj/NVL4TAalFqImFiixs52wK
	 FM/ysSXaen1xV0go/riEK9wdhA3znIZ22XBCBibV/sG1zSGX2UQOQNG/LJCLqaDSXMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0eYZ3HbDY5x5zovptu6rAgNNSCJghwXhmaa/sCZVI9o=;
	b=YpO21Al/CTMMJ4V4CTdYo2pbUO79OBQ3C5F5BVoRELEARSmmUetUSoSO2C8wvOtqYUo2
	 PCgLi4CowJU/5TzBLPtzGBU6qHqQ66JANLEpBnW1unxA2RlEeQ080zK1QBpeJe206b3fg
	 WG5YvZ53xLkq8H/q/pR20XTLrEEYgueDkcErYvFD9j2MjXadL1sPwHrlHJnPL3I6kDtdF
	 vQbEkW6jdIlTH7wctI1mhs1ZkI993B5L8oWfsUGvCdceLZCOk7wvilY5LhhiCzatXJVMI
	 fCj/Cj87y3qWKYx9n/n55keZ1H4D0KFe0k3isEG9wy2p36Mll5+7SQZBaMFSxwuG7/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rnNiRU9/";
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A8606ACD1
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4A8606ACD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnNiRU9/
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-53c156ba662so884591b6e.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223489; x=1795828289; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eYZ3HbDY5x5zovptu6rAgNNSCJghwXhmaa/sCZVI9o=;
        b=rnNiRU9/bQq8ttzpXzYTOT0K5xMiEj8c7A3MEjhSLOqnPgyie34QMqiAFco0/hJpDT
         pdBIN7Zch8zBO3tIkzcevG+pwlKRjeQxQyJtdkOTY2ysHRHvpGPPQZYedeYp01vJoMZJ
         ydvL4u9MLmAWpaT3854HwKTSKOJ2+lqU+53KCuU+UrhlevV4oY+YIwLgStoz9N0ONQCx
         vh/H62DEwPjxFxX8qLDUoiFBjMAIf2OB9S8SiLH+/+VIFe5AJsRW6AJDQTPjnELeQt5g
         qoQSQyTcJ07qwFI9+ApwyIAxR5BtWQrdIHhedcnRzKjqwFi8nL0Kk+5nazYXtV/G3LFh
         VKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223489; x=1795828289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eYZ3HbDY5x5zovptu6rAgNNSCJghwXhmaa/sCZVI9o=;
        b=q8G6O+aU3ka8GolEBv6txzb48BamL7CRLvTDBKFYqs0g4simBjR1swZsHOQtwQJKls
         RAuTOYbcSK+4xkNLqrWQZINyvN3sEuP6T/K1KLT2dvY2mWIm77HtNog84N4J/c4Eeac1
         jM+gMCRMaFobafxIloIbEBet+F9vQI3CE5vwgoykq5mVOt8NVQ82tq4a6QcUZ6HXNbsU
         xrx+U5ArBk6LiefkQd/Ffg3VpGV6c01quguRfA9TBxsp2R5MZsQDBIsIe8RmKiFtXZIU
         IdwtZFE7VOa7CXH0QWhlHCMCatL+n5m5v56yNc2StDCyW6FkSSg2Yc3GIpGDq5OiWHaR
         IeVQ==
X-Forwarded-Encrypted: i=1; AL+hErHxsY75vMbQvkVEUYOh4dduWN+fWyyZvG3VSnln2W6VMIsu/Nnn9zkZ27AA9ZjZDOfeF4Bm5tWniuhnoAPQ4Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/qkTiH99J1wWsG9NwkyITCSCpTHca8STXp/gHP7LhYnwrQaIGb
	fYz+IQKZPIRL2RJ5SpQGjow3qaM/qUpvIF8VX+qhTCbqWTsGaf+C5red
X-Gm-Gg: AYBFou2C9yTN55a+iNinK3exG3JoF4B3ZEbAqlvtMBjSh7qRcrP0Jdw95ierKWHotgU
	Z42QGukkK8wCsSQSNtcuIxCtK0sD33GX+lfg23j+Y2WHjh89D5tWLTY6iwUM9ZfNosBcCPGGyh4
	oxDu0y80mJ6HgOuoU6Go9a3p9d1oWJNlQHPPNV+6k0w4vn5OMJQBLNX+JBTmhVAnjIaFdhBCDb2
	96yl8KEPzDYYgblJ4BREb8RNd6TvRUdiLbL5S55okHRRUoARA3nf851tkj4QtnO/V6Hh/Orq+mZ
	w1UpXW6jngqyYAa7Oa3Suuiya9kvM4bCWML7qORDWDmBiwfJlDKiP9WZKZdXQrsEXUT2oBqIiee
	kHBiupi8+AXOGSwzcLBep5CcsqEXNfOwzHpmBjsGI6sWmgk7U37Mb7kxLx7Rj1eZr1i7u0BcDVy
	L1gee7nAGRL/1S1NPTl0SOPGDiYaht8zhmjqr+55nW36yOSzhvIZlMQdX6EfMsuTNDYcz4IzYNU
	R/+cwbKVwYonmijOZcyqg9jXxaedAjC5gKXju54OUPdD1D51sEEOaENSJ4h4vo8vw/GQSo+gAYD
	gPzuGcxmeT6JXXRFjWQ4psXl5G4iXEVfcham5t/JFRdn0+1sToSOVuewL4LhigMo3vYQHUZCIza
	lOkAmuAjtEORChdWoc4ZmeVR6fCyGcu8nZLNpJ1BEMdKYhbcsiPQ2gEMeAgrMeBNkHV0HSeZBH7
	4VJqmIkcYQ631nMw9QLF2+iV1KgVxM5pUz/p27sUWDt9V8uyfdthx7
X-Received: by 2002:a05:6808:4f1f:b0:4bc:fbd4:2a43 with SMTP id 5614622812f47-57a0bb6eea6mr5839190b6e.41.1795223489248;
        Fri, 20 Nov 2026 17:11:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:47 -0700
Subject: [PATCH v11 24/26] mtd: rawnand: sunxi: reset the H616 data path
 after DMA aborts
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-24-9721b1905ef4@gmail.com>
References: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-0-9721b1905ef4@gmail.com>
In-Reply-To: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-0-9721b1905ef4@gmail.com>
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
 devicetree@vger.kernel.org
X-Mailer: b4 0.17-dev

Resetting an active H616 MDMA read with NFC_CTL.RESET can leave the first
1 KiB of the next read displaced. Both raw and ECC reads are affected,
including reads for which ECC reports success. Reissuing the NAND read
command and restoring the visible controller configuration do not correct
the internal data-path state. The DMA read error path can therefore return
incorrect data when it retries through PIO.

Pulse the controller's exclusive AHB reset after stopping an H616 DMA
operation. Drain interrupts before resetting the registers and clear the
pending events before accepting another command. The next operation
selects its chip and restores the page layout and timings; reads retry
from a fresh whole-page setup, while interrupted writes return an error.

Require the AHB reset at probe and exercise it before accepting
transfers. An H616 device tree that omits the named reset will no longer
probe, including for PIO reads and writes. Perform the AHB reset before
releasing the DMA mapping. This relies on the H616 CCU reset callback,
which asserts and deasserts the reset through register updates and
returns success. The reset handle pins the provider module, and the CCU
driver suppresses sysfs unbinding.

If recovery fails, return the reset error without retrying the read in
PIO. Leave the IRQ disabled and reject subsequent NAND commands before
accessing the registers. Error propagation is not a substitute for
stopping DMA if the supported reset provider contract is violated.

Select the stronger recovery through H616 capability data, leaving older
controllers' abort sequences unchanged.

Fixes: 5ee37db34637 ("mtd: rawnand: sunxi: add H616 MBUS DMA support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 98 ++++++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index abea2ab0cc42..a722636f2e15 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -318,6 +318,7 @@ struct sunxi_nfc_user_data_layout {
  * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chunks
  * @has_ecc_clk:	If the controller needs an ECC clock.
  * @has_mbus_clk:	If the controller needs a mbus clock.
+ * @needs_bus_reset:	Aborted DMA needs an AHB reset to restore data ordering
  * @layout: protected user-data layout for the controller
  * @reg_io_data:	I/O data register
  * @reg_ecc_err_cnt:	ECC error counter register
@@ -346,6 +347,7 @@ struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
 	bool has_ecc_clk;
 	bool has_mbus_clk;
+	bool needs_bus_reset;
 	const struct sunxi_nfc_user_data_layout *layout;
 	unsigned int reg_io_data;
 	unsigned int reg_ecc_err_cnt;
@@ -389,6 +391,7 @@ struct sunxi_nfc_caps {
  * @use_mdma: use an internal MBUS DMA backend
  * @mdma_desc: H6-style MBUS DMA descriptor
  * @mdma_desc_dma: DMA address of @mdma_desc
+ * @recovery_failed: reject further operations after unsuccessful recovery
  * @caps: NAND Controller capabilities
  */
 struct sunxi_nfc {
@@ -409,6 +412,7 @@ struct sunxi_nfc {
 	bool use_mdma;
 	struct sunxi_nfc_mdma_desc *mdma_desc;
 	dma_addr_t mdma_desc_dma;
+	bool recovery_failed;
 	const struct sunxi_nfc_caps *caps;
 };
 
@@ -621,16 +625,50 @@ static void sunxi_nfc_dma_op_cleanup(struct sunxi_nfc *nfc,
 				     struct scatterlist *sg)
 {
 	dma_unmap_sg(nfc->dev, sg, 1, ddir);
+	/* Do not access controller registers after failed recovery. */
+	if (nfc->recovery_failed)
+		return;
+
 	writel(readl(nfc->regs + NFC_REG_CTL) & ~NFC_RAM_METHOD,
 	       nfc->regs + NFC_REG_CTL);
 }
 
-static void sunxi_nfc_dma_op_abort(struct sunxi_nfc *nfc)
+static int sunxi_nfc_dma_op_abort(struct sunxi_nfc *nfc)
 {
-	if (nfc->use_mdma)
-		sunxi_nfc_rst(nfc);
-	else
-		dmaengine_terminate_all(nfc->dmac);
+	int ret;
+
+	if (!nfc->caps->needs_bus_reset) {
+		if (nfc->use_mdma)
+			sunxi_nfc_rst(nfc);
+		else
+			dmaengine_terminate_all(nfc->dmac);
+		return 0;
+	}
+
+	/* Drain the handler before resetting its registers. */
+	disable_irq(nfc->irq);
+	writel(0, nfc->regs + NFC_REG_INT);
+	readl(nfc->regs + NFC_REG_INT);
+
+	/* A soft reset alone can leave the first subsequent read displaced. */
+	sunxi_nfc_rst(nfc);
+	ret = reset_control_reset(nfc->reset);
+	if (ret)
+		goto failed;
+
+	writel(0, nfc->regs + NFC_REG_INT);
+	writel(NFC_INT_MASK, nfc->regs + NFC_REG_ST);
+	readl(nfc->regs + NFC_REG_INT);
+	enable_irq(nfc->irq);
+
+	/* The next operation selects the chip and restores its timing and layout. */
+	return 0;
+
+failed:
+	/* Keep the IRQ disabled and reject commands after failed recovery. */
+	nfc->recovery_failed = true;
+	dev_err(nfc->dev, "NAND controller recovery failed: %d\n", ret);
+	return ret;
 }
 
 static int sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
@@ -642,6 +680,9 @@ static int sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 	u32 ctl;
 	int ret;
 
+	if (nfc->recovery_failed)
+		return -EIO;
+
 	if (cs >= sunxi_nand->nsels)
 		return -EINVAL;
 
@@ -1464,8 +1505,14 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 	       nfc->regs + NFC_REG_CMD);
 
 	ret = sunxi_nfc_wait_events(nfc, wait, false, 0);
-	if (ret)
-		sunxi_nfc_dma_op_abort(nfc);
+	if (ret) {
+		int abort_ret = sunxi_nfc_dma_op_abort(nfc);
+
+		if (abort_ret) {
+			sunxi_nfc_dma_op_cleanup(nfc, DMA_FROM_DEVICE, &sg);
+			return abort_ret;
+		}
+	}
 
 	sunxi_nfc_randomizer_disable(nand);
 	sunxi_nfc_hw_ecc_disable(nand);
@@ -1514,7 +1561,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 	return ret;
 
 err_stats:
-	/* The caller retries the whole read in PIO mode. */
+	/* A PIO retry must not count completed DMA batches twice. */
 	mtd->ecc_stats.corrected = corrected;
 	mtd->ecc_stats.failed = failed;
 	return ret;
@@ -1648,6 +1695,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, u8 *buf,
 static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 					  int oob_required, int page)
 {
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	int ret;
 
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
@@ -1656,7 +1704,7 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, oob_required, page, 0,
 					       nand->ecc.steps);
-	if (ret >= 0)
+	if (ret >= 0 || nfc->recovery_failed)
 		return ret;
 
 	/* Fallback to PIO mode */
@@ -1677,6 +1725,7 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 					     u32 data_offs, u32 readlen,
 					     u8 *buf, int page)
 {
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	int first_step = data_offs / nand->ecc.size;
 	int end_step = DIV_ROUND_UP(data_offs + readlen, nand->ecc.size);
 	int ret;
@@ -1686,7 +1735,7 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 		return ret;
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, false, page, first_step, end_step);
-	if (ret >= 0)
+	if (ret >= 0 || nfc->recovery_failed)
 		return ret;
 
 	/* Fallback to PIO mode */
@@ -1828,9 +1877,10 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 		else
 			ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
 		if (ret) {
-			sunxi_nfc_dma_op_abort(nfc);
+			int abort_ret = sunxi_nfc_dma_op_abort(nfc);
+
 			sunxi_nfc_dma_op_cleanup(nfc, DMA_TO_DEVICE, &sg);
-			return ret;
+			return abort_ret ?: ret;
 		}
 
 		/* exec_op() restores the page's spare base during column changes. */
@@ -1856,8 +1906,14 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 		       nfc->regs + NFC_REG_CMD);
 
 		ret = sunxi_nfc_wait_events(nfc, wait, false, 0);
-		if (ret)
-			sunxi_nfc_dma_op_abort(nfc);
+		if (ret) {
+			int abort_ret = sunxi_nfc_dma_op_abort(nfc);
+
+			if (abort_ret) {
+				sunxi_nfc_dma_op_cleanup(nfc, DMA_TO_DEVICE, &sg);
+				return abort_ret;
+			}
+		}
 
 		sunxi_nfc_randomizer_disable(nand);
 		sunxi_nfc_hw_ecc_disable(nand);
@@ -2794,11 +2850,18 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 		}
 	}
 
-	nfc->reset = devm_reset_control_get_optional_exclusive(dev, "ahb");
+	if (nfc->caps->needs_bus_reset)
+		nfc->reset = devm_reset_control_get_exclusive(dev, "ahb");
+	else
+		nfc->reset = devm_reset_control_get_optional_exclusive(dev, "ahb");
 	if (IS_ERR(nfc->reset))
-		return PTR_ERR(nfc->reset);
+		return dev_err_probe(dev, PTR_ERR(nfc->reset), "failed to get AHB reset\n");
 
-	ret = reset_control_deassert(nfc->reset);
+	/* Exercise the recovery reset operation before accepting DMA transfers. */
+	if (nfc->caps->needs_bus_reset)
+		ret = reset_control_reset(nfc->reset);
+	else
+		ret = reset_control_deassert(nfc->reset);
 	if (ret) {
 		dev_err(dev, "reset err %d\n", ret);
 		return ret;
@@ -2908,6 +2971,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 	.has_mdma_desc = true,
 	.has_ecc_clk = true,
 	.has_mbus_clk = true,
+	.needs_bus_reset = true,
 	.reg_io_data = NFC_REG_A23_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_H6_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_H6_USER_DATA,

-- 
2.53.0

