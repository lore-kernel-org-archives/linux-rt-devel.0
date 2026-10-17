Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BE49481D
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266398; cv=none; b=e/SiLNt0hDJk1/8LzxB6ulcBV9YwAQBfanpWi00C6JZWu8vFSDNIquxsS5NtQvpnrrNfLLxthAtMTcl3pGP7d/rGqFQxvxy8UfEIBvoaGfyMe4CAjmBACnfFNkbVj9tzcvjovFCffUXAZW9+IKxVzZobO2rzbP25UIKiLD4dMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266398; c=relaxed/simple;
	bh=PdQeuH/q479pNV29WIA//obFJYFHNo7YpLv2PpGSleg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpMIiuohtKtv1MVhR6EZA+2A5O/DSNENhnSxRcoFbICR3ndD59SnGk3CbvOAf+xjtbHjaThuhik/Zm6A2mHbUS5tANVWPHqEXxDXH0Bwm+6AFhbItlkXofzX7A+DqhIDanxUPyUTZ93HduYgaF9CBAoul5iV8BsTM/vqKhlUwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA0EZyfT; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA0EZyfT"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4f59ea27bd0so336615b6e.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266389; x=1792871189; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/4qBmrvtH6EJsayupSppfu0h+5jh/KQVNPd30Ou/RE=;
        b=gA0EZyfToqW9Jsvnl5ShgSnQgjVmJvr28lOjhen6uiNzv7aJ5A09jTk6NSnZbvDVr1
         GrsXmyqEbUW8Adp8dxDVSfTy4ehIssZHQ22J5q/TEWu46QZQz6U7TdPM4vF8VLnlnTMn
         dF23H/dN8LlvxV0BVF84HQcB14jAAyFlGRxC1kT8gddacO+Bcahj0YTAxRdn7xxQyHlB
         JFoC8CmslUkZK4jMJxucfdW4RtD+WIenGZu5FPsdnEr+aldu1DN3A5PjJD5/34cseTYf
         JhGny86+kvyqrTedpsyo17p1tgpohC126Y2GTTWW12GkPOJA2+hLvrxjc+COi/oxPiMj
         +uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266389; x=1792871189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/4qBmrvtH6EJsayupSppfu0h+5jh/KQVNPd30Ou/RE=;
        b=ts7CmH82eYUEgsHrcTplwsUT7ZA/OLpyeGqhpSU4Glc+o1w6zu0sAATF0ElhfBFl+C
         zNld42WBsZCx4Aodo17E9X98JSm1ByNu3s3IvvcpO07JoxP7E8EgwrxKUOZcqck3uG+o
         Jn0EYQaX8pDQEga8ovfRKigyC3PplUu8Qnpvsb3dVkPqfXYH5olcDeDHpEIaTIkTn3Ex
         tReoi3QoWhss2XeU+XN+wf7h1zyMPjtQF6I1MHbGsRJKYDPGUOp8tGYzZRp7P2T7zn0W
         /lQJBHjqxAnCbFz2UdPkW8jVcd2tAxNneYcYtix7hfUUc97T0IEL9dzv20uXRv3mgpRW
         uzlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpToN4tMUFYSS+cYBO8KpNdYzVth1Hp1KQM6O5gn9+aH6GIDXxiJB2lrGBGnaUBjCkLmB05FXEJnz73SZ9zg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI2KJiME3L3TjkCgDYnWrGXW7sZO2Py1fXT6vDY/jjmclyyODYo
	iPd/0nD+F+HqRq+ht0AOT5F4eIqwvOHhMFIGrIaPw4cx5UwJuttgmbKV
X-Gm-Gg: AYBFou1bW3NRmR8qnNNKVvr6s/SMtAJXiAVyyLJqWbloSYai+WhRh1eQbv21k0Ia7hX
	yvMSzmv2OAgLLsgpz+VPNx9fFI9nxsJdPegqzxs/MtOcW/KlA3MipfJ0BWKNUwtv3uRQycezUDe
	GPCL7FsDxUs+w8/7fsOVwaLQJc8FdGetl23aIqDV85TxMevzHMr49dR8sXjmBhyBFzJZk3aLt/L
	X8J4U34TRE4YNAXOx9f6lWUHE0Z53VblkIr8U7W+KzS/uN1hx9RLSC+Jyjsbnp+1sUBMF7jk81I
	9Wi7M+6fup42RviKQF2ZvSXqJqxA8wJ8kSqCHDOQ8yARxh6/JZJVez3KJYe7QAAwdhYTLgXZZlU
	NlEmqbQ6+tIB0+B6XhTygOJQ4ItJ0VQaqp9l7O8+eMiavxkQT6t0rLSxdRogWsBiCvC2xbdX2qU
	SHdf96RvvilReXRI4MsmxZu4PmQ0AW+90SxWhiIGbwM08WSXtM4r+XKcXhPGP8caCPivIe+aGgG
	bYS12z5xK+7MJ5WmxqxsAbBetcQrDnr/IZTwRZZpwUI2qeAFFwtIwXQD6qRJ8f2NGqj57jjWWhx
	SESfZlYFfuEDAjh/uCV4WQHWLwFl/UK+VrMEy5cJJvpN24QMF4QaWaa+jwhB50hdvN6KO9kAg/h
	XKJ0uIq2X0E8xRcIhXqwg
X-Received: by 2002:a05:6808:c115:b0:53a:8c5:d7d7 with SMTP id 5614622812f47-53cd209d1damr2708997b6e.58.1792266389388;
        Sat, 17 Oct 2026 12:46:29 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388dd8b5a2sm4025321b6e.12.2026.10.17.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:46:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 17 Oct 2026 13:46:04 -0600
Subject: [PATCH v9 09/18] mtd: rawnand: sunxi: propagate buffer and column
 transfer errors
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-9-b624c09e3ee5@gmail.com>
References: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
In-Reply-To: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
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
 drivers/mtd/nand/raw/sunxi_nand.c | 174 +++++++++++++++++++++++++-------------
 1 file changed, 117 insertions(+), 57 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 82af3ccad885..b79a20158cd4 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -681,7 +681,7 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 	writel(ctl, nfc->regs + NFC_REG_CTL);
 }
 
-static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
+static int sunxi_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
@@ -697,7 +697,7 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
-			break;
+			return ret;
 
 		writel(cnt, nfc->regs + NFC_REG_CNT);
 		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD;
@@ -709,17 +709,19 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 
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
@@ -735,7 +737,7 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
-			break;
+			return ret;
 
 		writel(cnt, nfc->regs + NFC_REG_CNT);
 		memcpy_toio(nfc->regs + NFC_RAM0_BASE, buf + offs, cnt);
@@ -749,10 +751,12 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 
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
@@ -902,23 +906,31 @@ static void sunxi_nfc_randomize_bbm(struct nand_chip *nand, int page, u8 *bbm)
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
@@ -1169,31 +1181,39 @@ static int sunxi_get_ecc_offset(struct sunxi_nand_chip *sunxi_nand,
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
@@ -1243,14 +1263,22 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		if (read->oob_required) {
 			/* Keep the existing PIO and DMA representations of parity. */
 			if (read->dma) {
-				nand_change_read_column_op(nand, mtd->writesize + oob_off,
-							   oob, ecc->bytes + user_data_sz, false);
+				ret = nand_change_read_column_op(nand, mtd->writesize + oob_off,
+								 oob, ecc->bytes + user_data_sz,
+								 false);
+				if (ret)
+					return ret;
 			} else {
-				nand_change_read_column_op(nand, mtd->writesize + oob_off,
-							   NULL, 0, false);
-				sunxi_nfc_randomizer_read_buf(nand, oob,
-							      ecc->bytes + user_data_sz,
-							      true, read->page);
+				ret = nand_change_read_column_op(nand, mtd->writesize + oob_off,
+								 NULL, 0, false);
+				if (ret)
+					return ret;
+
+				ret = sunxi_nfc_randomizer_read_buf(nand, oob,
+								    ecc->bytes + user_data_sz,
+								    true, read->page);
+				if (ret)
+					return ret;
 			}
 
 			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, reg_index, !step,
@@ -1290,9 +1318,14 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
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
@@ -1311,13 +1344,21 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
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
@@ -1440,13 +1481,21 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
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
@@ -1472,27 +1521,35 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
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
@@ -1640,8 +1697,8 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	}
 
 	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
-		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
-						 &cur_off, page);
+		ret = sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
+						       &cur_off, page);
 
 out:
 	sunxi_nfc_hw_ecc_disable(nand);
@@ -1766,10 +1823,13 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
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

