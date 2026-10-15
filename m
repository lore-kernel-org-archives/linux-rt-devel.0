Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609233F8D4
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028066; cv=none; b=C2lD3ZrotGaC3Rsiq7WFyJzmW9UTEQdZS6LLOK/WWZrBaYDr06g2oFB/bIhqKF9loawWJULRa19WaQzxcl9p4nm1jhHiVIZ0MNjbEHTVAjGBMdc+mhkZKNj1misH1G36pjEGPPvT6aiqKWGxucmdx5GoYAeMsW8i+OFQyYz2/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028066; c=relaxed/simple;
	bh=3inu8PcvWtNWB4hfZexNO9HD0p5ZfghyPzBUWdP/498=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMQFiCs9cErs68UOOPZfd09+d5x6zzyw30cGuSiU9DNgRbr3LckShjKFYOIVr/ybT1Gxx2nif4clxl709IGEIc/oikYG6JxQKVSgdi5ahpBbmPAVTAsjrFuBAyI1wYX3LILB+sT3TOSMSu8p40QdhgGW6/LhSL+8unCFCZ0v4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3gwpfvD; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3gwpfvD"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-490d838b425so2770159fac.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028063; x=1792632863; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cx9GKNoh1ry+92yCt58yhjO9StAttIXiG8BntxokAOc=;
        b=S3gwpfvDpeASXwpWacqlZwSBRUjQrjqqaxWmOg7t0InPLrgBjsrgi0NWuYDq/TdAlt
         lUFsaHQJF3L0cUrYFvI6DxIRHZpLjtd7o2lHTPs3c8/VQZewRxWHpeyvf5WmMMvMXmws
         Htee5V0AT3bef2pjpzawY862A1X6Ju1rlv/xoIZHa7JmWE2pKfq+HrISgAmtv/GblFkG
         sXBXixsUXe41Ijespm9h0sWMMgKmCWxUgu/5zFjSIG60DtO6MOMOQEaV4mc9zh2YH+Em
         dn0y1icnckrTEleTljzzuhBOxMFtGeHyCAVvil8/ANoLqgA0Y+XQpWaa+yyLCb8i17A2
         VRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028063; x=1792632863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cx9GKNoh1ry+92yCt58yhjO9StAttIXiG8BntxokAOc=;
        b=iLdi6yepXqZNwxfRnrn6ZhNywL4zFGyF8KHF0PPwXFwrKuecYOc+zqX/LY/7HZpij3
         H0m76XKYVdEhqFTH37XRFp1RP8NBfnMzrFKmDVfTgtrP+BTDS8QK5yDk5xbZj1wfnNxZ
         xBDZB6F/qGC4qXsALL+dC9ILhoFT9CQmWsPTJIC4GjgQh5FOy8FiApYPvWqdH+CTdzeh
         D7jJOEnwoebc88gdcZAXDqSN68j0zX41iI3XQoCxuQVP012Gk8poSlspdm32wQ0RfqL7
         9NpUNLSoEwrcqXlrC6sJw2bKz/wEGctfvUe0f/DDpNyUpkUu7xOgJW9aJzQ+QZtWIS76
         2jLA==
X-Forwarded-Encrypted: i=1; AKwUvBwDOpBaVNa5r1I/S1gKb+9zgK5osRz0mf8998mSvDWhu73fr+/kGKuZTCEyTPzzrBikDWgn6yuBClGPrq4gKA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJi+DGSzzyM/2BmXYzNUXi21luWT0fUT1H/YUdGwkaYzpbEYJtR
	nlkjfV7AtCurtIi+t6Wf2sGrZXK7nUHEV8HBmQ3ZjQH1tVAAThHMERMa
X-Gm-Gg: AYBFou0Z/3+P2T1KsyVjhDPVRljeYo5fgcqtRJ3x2cgOlhI5qwasvf+k+FeGICXwMkw
	OkpdmODXGqNyQw8y9seSrRMyD+CzRW9tf9foJ+bx0PbFBQJAv/8ZDxeU2r/waCNGSIIjrXwYM/H
	cBz7b81jWOTwzl62n+yOZZyadp00912ckgan6d+LpFgLH62lG5yrZD//bt6aPaB7ndCZ2FcS4ff
	J5f8TllTdTjcUfWVEqgGo6GTowmrxzUtcLM1o3+ymCaixZbvNnOTIkmw5Oe86Ap0Zf5Wg1SVhlX
	83ubqo7YqBXpupgsPwe1O7ixFJKRjuCVHkCeXaViJgnfxD+XLRZj0jgDfP0OwkYY5THnJdOYRK8
	EnryXQfPcP83/WtoV0/KdiUxtxnY74UPL7T+QgOM1m+yyiUjojAcCh5ZYcEY9umLW+HQTCbw7Rl
	kTtmdDPlpT0OCnnb8t+eg/bHsiZN7196ofVWiH5ccW1qP9r7PHmQ94GX+p6ppRgG2HbDAO5HqGD
	3sNaCBudEAi+z5zMItuIkCJbly1dZiIwze1wRiZnC7oq12BxeYTB2PpSHJF/BtPb5ml0Abr7Txs
	xeuNNAIDyM68zom1HE32nBF7XfDHgazcWjvI4V+h3ZmZBrYqxljW+zkYvYZdydLNCWLLYBKFTGt
	KXDJxFYIoX5+kSjvXpR4Q
X-Received: by 2002:a05:6870:f622:b0:475:a1ec:961f with SMTP id 586e51a60fabf-4a2a8a0bf68mr15629287fac.33.1792028063354;
        Wed, 14 Oct 2026 18:34:23 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 19:33:54 -0600
Subject: [PATCH v7 07/16] mtd: rawnand: sunxi: propagate buffer and column
 transfer errors
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-7-5d3fc6ad2da1@gmail.com>
References: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
In-Reply-To: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
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

sunxi_nfc_read_buf() and sunxi_nfc_write_buf() move data through
controller SRAM, waiting for FIFO space and transfer completion. On
timeout they stop their loop but return void, so their callers cannot
distinguish a complete transfer from a partial one. The hardware-ECC
paths also ignore some NAND column-change errors, including extra-OOB
transfers performed after DMA. Reads can thus succeed with incomplete
data or bytes from the wrong column; writes can issue PAGEPROG after
failing to transfer all the intended bytes.

Return the transfer status through the randomizer and OOB helpers to the
page callbacks. A read with a NULL destination still fills controller
SRAM for ECC and must report errors even though it does not copy to
memory. Disable the randomizer after either transfer outcome, and use
the page callbacks' error exits to disable ECC and skip program-end.
Update a tracked OOB column only after the requested transfer succeeds.

Keep transport status separate from the maximum corrected-bit count:
zero from a successful OOB read must not erase a positive correction
result. If an OOB read after DMA fails, restore that attempt's
corrected/failed counters before the caller retries the page in PIO.
Leave successful command sequences and the returned OOB representation
unchanged.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 170 +++++++++++++++++++++++++-------------
 1 file changed, 113 insertions(+), 57 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 8256982d1d56..dfdd8d8aaa6f 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -663,7 +663,7 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 	writel(ctl, nfc->regs + NFC_REG_CTL);
 }
 
-static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
+static int sunxi_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
@@ -679,7 +679,7 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
-			break;
+			return ret;
 
 		writel(cnt, nfc->regs + NFC_REG_CNT);
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD;
@@ -691,17 +691,19 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 
 		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, poll, 0);
 		if (ret)
-			break;
+			return ret;
 
 		if (buf)
 			memcpy_fromio(buf + offs, nfc->regs + NFC_RAM0_BASE,
 				      cnt);
 		offs += cnt;
 	}
+
+	return 0;
 }
 
-static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
-				int len)
+static int sunxi_nfc_write_buf(struct nand_chip *nand, const u8 *buf,
+			       int len)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
@@ -717,7 +719,7 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
-			break;
+			return ret;
 
 		writel(cnt, nfc->regs + NFC_REG_CNT);
 		memcpy_toio(nfc->regs + NFC_RAM0_BASE, buf + offs, cnt);
@@ -731,10 +733,12 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 
 		ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, poll, 0);
 		if (ret)
-			break;
+			return ret;
 
 		offs += cnt;
 	}
+
+	return 0;
 }
 
 /* These seed values have been extracted from Allwinner's BSP */
@@ -884,23 +888,31 @@ static void sunxi_nfc_randomize_bbm(struct nand_chip *nand, int page, u8 *bbm)
 	bbm[1] ^= sunxi_nfc_randomizer_step(state, 8);
 }
 
-static void sunxi_nfc_randomizer_write_buf(struct nand_chip *nand,
-					   const uint8_t *buf, int len,
-					   bool ecc, int page)
+static int sunxi_nfc_randomizer_write_buf(struct nand_chip *nand,
+					  const u8 *buf, int len,
+					  bool ecc, int page)
 {
+	int ret;
+
 	sunxi_nfc_randomizer_config(nand, page, ecc);
 	sunxi_nfc_randomizer_enable(nand);
-	sunxi_nfc_write_buf(nand, buf, len);
+	ret = sunxi_nfc_write_buf(nand, buf, len);
 	sunxi_nfc_randomizer_disable(nand);
+
+	return ret;
 }
 
-static void sunxi_nfc_randomizer_read_buf(struct nand_chip *nand, uint8_t *buf,
-					  int len, bool ecc, int page)
+static int sunxi_nfc_randomizer_read_buf(struct nand_chip *nand, u8 *buf,
+					 int len, bool ecc, int page)
 {
+	int ret;
+
 	sunxi_nfc_randomizer_config(nand, page, ecc);
 	sunxi_nfc_randomizer_enable(nand);
-	sunxi_nfc_read_buf(nand, buf, len);
+	ret = sunxi_nfc_read_buf(nand, buf, len);
 	sunxi_nfc_randomizer_disable(nand);
+
+	return ret;
 }
 
 static void sunxi_nfc_hw_ecc_enable(struct nand_chip *nand)
@@ -1150,31 +1162,39 @@ static int sunxi_get_ecc_offset(struct sunxi_nand_chip *sunxi_nand,
 		sunxi_nfc_user_data_sz(sunxi_nand, step);
 }
 
-static void sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
-					    u8 *oob, int *cur_off,
-					    bool randomize, int page)
+static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
+					   u8 *oob, int *cur_off,
+					   bool randomize, int page)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int offset = sunxi_get_oob_offset(sunxi_nand, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
+	int ret;
 
 	if (len <= 0)
-		return;
+		return 0;
 
-	if (!cur_off || *cur_off != (offset + mtd->writesize))
-		nand_change_read_column_op(nand, mtd->writesize + offset,
-					   NULL, 0, false);
+	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
+		ret = nand_change_read_column_op(nand, mtd->writesize + offset,
+						 NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
 	if (!randomize)
-		sunxi_nfc_read_buf(nand, oob + offset, len);
+		ret = sunxi_nfc_read_buf(nand, oob + offset, len);
 	else
-		sunxi_nfc_randomizer_read_buf(nand, oob + offset, len,
-					      false, page);
+		ret = sunxi_nfc_randomizer_read_buf(nand, oob + offset, len,
+						    false, page);
+	if (ret)
+		return ret;
 
 	if (cur_off)
 		*cur_off = mtd->oobsize + mtd->writesize;
+
+	return 0;
 }
 
 /* Interpret one PIO step or a completed DMA batch before reusing its status. */
@@ -1222,15 +1242,19 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 
 		if (read->oob_required) {
 			/* Keep the existing PIO and DMA representations of parity. */
-			nand_change_read_column_op(nand, mtd->writesize + oob_off,
-						   read->dma ? oob : NULL,
-						   read->dma ? ecc->bytes + user_data_sz : 0,
-						   false);
+			ret = nand_change_read_column_op(nand, mtd->writesize + oob_off,
+							 read->dma ? oob : NULL,
+							 read->dma ? ecc->bytes + user_data_sz : 0,
+							 false);
+			if (ret)
+				return ret;
 
 			if (!read->dma) {
-				sunxi_nfc_randomizer_read_buf(nand, oob,
-							      ecc->bytes + user_data_sz,
-							      true, read->page);
+				ret = sunxi_nfc_randomizer_read_buf(nand, oob,
+								    ecc->bytes + user_data_sz,
+								    true, read->page);
+				if (ret)
+					return ret;
 			}
 
 			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, reg_index, !step,
@@ -1270,9 +1294,14 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 static int sunxi_nfc_oob_finish_read(struct nand_chip *nand,
 				     struct sunxi_nfc_ecc_read *read, int *cur_off)
 {
-	if (read->oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, cur_off,
-						!read->has_erased_chunk, read->page);
+	int ret;
+
+	if (read->oob_required) {
+		ret = sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, cur_off,
+						      !read->has_erased_chunk, read->page);
+		if (ret)
+			return ret;
+	}
 
 	return read->max_bitflips;
 }
@@ -1291,13 +1320,21 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	u32 pattern_found;
 	int ret;
 
-	if (*cur_off != data_off)
-		nand_change_read_column_op(nand, data_off, NULL, 0, false);
+	if (*cur_off != data_off) {
+		ret = nand_change_read_column_op(nand, data_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+	ret = sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+	if (ret)
+		return ret;
 
-	if (data_off + ecc->size != oob_off)
-		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+	if (data_off + ecc->size != oob_off) {
+		ret = nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -1420,13 +1457,21 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	/* From the controller point of view, we are at step 0 */
 	const int nfc_step = 0;
 
-	if (data_off != *cur_off)
-		nand_change_write_column_op(nand, data_off, NULL, 0, false);
+	if (data_off != *cur_off) {
+		ret = nand_change_write_column_op(nand, data_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_randomizer_write_buf(nand, data, ecc->size, false, page);
+	ret = sunxi_nfc_randomizer_write_buf(nand, data, ecc->size, false, page);
+	if (ret)
+		return ret;
 
-	if (data_off + ecc->size != oob_off)
-		nand_change_write_column_op(nand, oob_off, NULL, 0, false);
+	if (data_off + ecc->size != oob_off) {
+		ret = nand_change_write_column_op(nand, oob_off, NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -1452,27 +1497,35 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	return 0;
 }
 
-static void sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
-					     u8 *oob, int *cur_off,
-					     int page)
+static int sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
+					    u8 *oob, int *cur_off,
+					    int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int offset = sunxi_get_oob_offset(sunxi_nand, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
+	int ret;
 
 	if (len <= 0)
-		return;
+		return 0;
 
-	if (!cur_off || *cur_off != offset)
-		nand_change_write_column_op(nand, offset + mtd->writesize,
-					    NULL, 0, false);
+	if (!cur_off || *cur_off != offset) {
+		ret = nand_change_write_column_op(nand, offset + mtd->writesize,
+						  NULL, 0, false);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_randomizer_write_buf(nand, oob + offset, len, false, page);
+	ret = sunxi_nfc_randomizer_write_buf(nand, oob + offset, len, false, page);
+	if (ret)
+		return ret;
 
 	if (cur_off)
 		*cur_off = mtd->oobsize + mtd->writesize;
+
+	return 0;
 }
 
 static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
@@ -1620,8 +1673,8 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	}
 
 	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
-		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
-						 &cur_off, page);
+		ret = sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
+						       &cur_off, page);
 
 out:
 	sunxi_nfc_hw_ecc_disable(nand);
@@ -1746,10 +1799,13 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
+	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING)) {
 		/* TODO: use DMA to transfer extra OOB bytes ? */
-		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
-						 NULL, page);
+		ret = sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
+						       NULL, page);
+		if (ret)
+			return ret;
+	}
 
 	return nand_prog_page_end_op(nand);
 

-- 
2.53.0

