Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8F331A56
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028056; cv=none; b=M9DP29n3XND/dG30grzjzWiqBLpAVOJuYrAFiNtF/AO+srhssy82kWXo+kcJF6wWrFsZcIa74wyLUymAUsBgTumTwqMsN8wND7wieUOl48HQDP9L/1qMJ9t4NWiRCuBxqZspWohlIlHuJzchSh4XHIvW+qlJ2ZYCuhkMgiG/BXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028056; c=relaxed/simple;
	bh=a8ql8pZvfkQJaeQ7cy57dwhSEFwwh0JZjOipei5GbpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OA604kQSgLWdEizGi2A1EybkDPLVqMrjbBNTQUhYaeREizrFw3MsiA/zJL0ybToXFGity8xUB0QQwOVzQrJ0A26rDC1qqLGJbj8JKguSgupyTw3R7WosZfd+a3LeZAF4JIF7xulTxjcGBOEkvpEB6oI5xYv+EX1uphAMZ0PKUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4kyLTis; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4kyLTis"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-5058b105df7so1705769b6e.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028052; x=1792632852; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3QlrVAtVf/XpX+ZsmjMjSLBH4hnwCKgBumw+s30nkM=;
        b=e4kyLTishfC/qHocSiLCBXc87V2sjA/qazZ1lmDus4GLCugECko6ue+NOAO/ERBV1x
         X75rfngxC9L1RGSN7TRzCnFsratpt49d+Vz6bcL4jJSu/PHIcCV9jC11K55gARBuBP47
         qT8VaAlrTnyiVxJrT6vk5vhL0JHYGwRwmrqcgpUa/SFFqrylK/OE5Hoq0xkUz8LyAh7j
         GTOLph6WwybT44PWOVuOOEZC0PZdIpLWNgq1xiTz9/R8sHbueghRXZImBAnP8JzJuamf
         0jN7UYXkqaWrKa95X3mZqc/eZ7x4/Nijn6W0R28MmIkfPA6UMvj01/rV+qRULkptw8H7
         PNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028052; x=1792632852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3QlrVAtVf/XpX+ZsmjMjSLBH4hnwCKgBumw+s30nkM=;
        b=x+4bH0GwS1YCOSISyvKgT1Wji+maN/AMKG3KlceKcKvOWqX8HJCVl5UBrk/78ZQc/0
         salU7d3ntd4q4qz/31CX5DrVCIBHATuFPfiAcpk4HPSJls2P5kTsF2/JRgAVb3KAbiQu
         gMib4BvoVtJdp1XFWWXJGCNA1eFzEwLb03DUxfFMylywg+hnmNKpXxaQSqR158vZHSuq
         MSmNhC6HlJp3dLDZWHUbKQOqIp7EoXmpKY8rPNTsLnwRnSfjK6dEypMUWOfbI7O2hSxi
         c/7Fk6Qk936SjFrT7KuIyUYPw7gNTa1OOtOC2jdJn97L8Obwbw994CmLp8hY+gZaVHAI
         sczA==
X-Forwarded-Encrypted: i=1; AKwUvByn8mzGaSQxuNl4fyNNvQ5esymzhUdk4hQd+w3StK3r3497Tf7PCdoTOs02aArkvumZC5bJZQqmr+RjEKMu6Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIb64VAwQGLCV2Nca6lmQCFihQu7o2x7Y3Hl/v4UQy1+Go4Wl9w
	hMdKr3dbfwnvQNygIHqdsdNwcO9aq6W/n+1GRC27mfGvdbkyd3NTe3w7
X-Gm-Gg: AYBFou37TCGyIuQYGWa1r7phHqgp89OpNQBUDJFq0VoKEq72iKCxJEDd2PlUxeTzqvV
	5OXBBDddwmkcVZqnRBt6ZKPzqjOZJaPda1RIkj/m8p+IcaEwPjDWasmwE8AHvMT0dgv7lytGSoz
	22GVtqI/LltLzYunBW4fY0VXYX6/OSFARM++REZV64GvZX7fiGirq0iMcqH6gDOVqxP7VLqQgB0
	anuXSmaKlA5AHMSWtn4yyEtwghl/0Iy/gQK7+kpHPu1Q2QD1DuNT6l9mW32iMge267THmCmafT5
	g7wZJ+ZfL4TnEVO+/6NeMOlLEbtyLggBNGw9T3ocCPO78Y33Bzn/7c2IgZcZgPiy6gf0Zh4s8X/
	wxuAn5x3plTc7VU5bbTbR8y/vrTSfbuCRuiM6CnKp1aHhC7QXJ9yqKkbQuLD6Xnjv0EdSUZZW/U
	apXD1NgcM30UoVsrN/wO4Tcq3I1dyAU2yHjNKDfRC6bgA5N1waAgpouCxR8tN8fs2DL0APV7ffn
	310LlUFXDrX9lUMX+SNtabqSQx0zxg6+nQaCBl9vYEmtjJ7qAirK3jHlx2dRVoaouAmkN9zykgO
	lgq/p3sf/fRaEE/xu8yirsJFJDcOYETOKjFU39hYShH32ELYrZVr7A7tAVbuZ2nMerH1HLPM3+J
	8ji5wLjsm+lHX7YveuZAW+g==
X-Received: by 2002:a05:6808:c1f3:b0:4f4:b5ba:a236 with SMTP id 5614622812f47-50c4e68002amr16797862b6e.10.1792028051591;
        Wed, 14 Oct 2026 18:34:11 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 19:33:48 -0600
Subject: [PATCH v7 01/16] mtd: rawnand: sunxi: centralize OOB handling
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-1-5d3fc6ad2da1@gmail.com>
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

PIO and DMA interpret the same hardware-ECC results, retrieve protected
OOB bytes and check unreadable chunks for erased data in separate paths.
Keeping that policy in both transfer paths makes fixes easy to apply to
one path but miss in the other.

Share the processing through per-chip OOB operations selected at attach.
A read callback consumes one PIO step or a completed DMA batch. A finish
callback handles the OOB tail and returns the largest correction count.
Keep command sequencing, DMA ownership and randomizer control in the
transfer functions; carry the buffer, page, correction count and whether
any chunk was erased in a per-read context.

Move user-data reservation and layout setup behind the same operations.
The existing plain and scrambled-with-plain-BBM modes share geometry and
read handling. Only the scrambled mode transforms the first two user bytes
to compensate hardware randomization and keep the on-flash marker plain.
Preserve fixed and variable user-data allocation, including the older
controllers' extra two-byte reservation when maximizing ECC strength.

This preserves the existing register accesses, transfer ordering, OOB
length selection, error handling and ECC accounting. In particular,
retain DMA's two passes: consume corrected OOB before raw erased-page
rereads. PIO keeps its current parity representation and physical reread
behavior. OOB-length fixes, read-error handling and register-read caching
are separate changes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 545 ++++++++++++++++++++------------------
 1 file changed, 294 insertions(+), 251 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index f41feebe4257..27d6ae635e9c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -256,12 +256,30 @@ struct sunxi_nfc_timings {
 	s32 tRHW[SUNXI_NFC_TIMING_STEPS];
 };
 
+struct sunxi_nfc_ecc_read;
+
+/* OOB interpretation is independent of PIO/DMA command sequencing. */
+struct sunxi_nfc_oob_ops {
+	/* Reserve user data before maximizing ECC strength, then set its layout. */
+	unsigned int (*min_user_data)(struct nand_chip *nand, int nsteps);
+	int (*init_user_data)(struct nand_chip *nand, int nsteps);
+	/* Optional symmetric conversion of the on-flash bad-block marker. */
+	void (*transform_bbm)(struct nand_chip *nand, int page, u8 *bbm);
+	/* Consume one PIO step or a DMA batch; negative values are I/O errors. */
+	int (*read_batch)(struct nand_chip *nand, struct sunxi_nfc_ecc_read *read,
+			  u32 status, u32 pattern_found, int first_step, int nsteps);
+	/* Read any remaining OOB and return the maximum correction count. */
+	int (*finish_read)(struct nand_chip *nand, struct sunxi_nfc_ecc_read *read,
+			   int *cur_off);
+};
+
 /**
  * struct sunxi_nand_chip - stores NAND chip device related information
  *
  * @node: used to store NAND chips into a list
  * @nand: base NAND chip structure
  * @ecc: ECC controller structure
+ * @oob_ops: OOB geometry and ECC-result interpretation
  * @clk_rate: clk_rate required for this NAND chip
  * @timing_cfg: TIMING_CFG register value for this NAND chip
  * @timing_ctl: TIMING_CTL register value for this NAND chip
@@ -273,6 +291,7 @@ struct sunxi_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
 	struct sunxi_nand_hw_ecc ecc;
+	const struct sunxi_nfc_oob_ops *oob_ops;
 	unsigned long clk_rate;
 	u32 timing_cfg;
 	u32 timing_ctl;
@@ -908,6 +927,7 @@ static u8 sunxi_nfc_user_data_sz(struct sunxi_nand_chip *sunxi_nand, int step)
 	return sunxi_nand->user_data_bytes[step];
 }
 
+/* PIO uses register zero; DMA concatenates user data within each transfer. */
 static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
 						int step, bool bbm, int page,
 						unsigned int user_data_sz)
@@ -946,8 +966,8 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
 	}
 
 	/* De-randomize the Bad Block Marker. */
-	if (bbm && (nand->options & NAND_NEED_SCRAMBLING))
-		sunxi_nfc_randomize_bbm(nand, page, oob);
+	if (bbm && sunxi_nand->oob_ops->transform_bbm)
+		sunxi_nand->oob_ops->transform_bbm(nand, page, oob);
 }
 
 /*
@@ -1007,9 +1027,9 @@ static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
 	u8 user_data[SUNXI_NFC_MAX_USER_DATA_SZ] = {};
 
 	/* Randomize the Bad Block Marker. */
-	if (bbm && (nand->options & NAND_NEED_SCRAMBLING)) {
+	if (bbm && sunxi_nand->oob_ops->transform_bbm) {
 		memcpy(user_data, oob, user_data_sz);
-		sunxi_nfc_randomize_bbm(nand, page, user_data);
+		sunxi_nand->oob_ops->transform_bbm(nand, page, user_data);
 		oob = user_data;
 	}
 
@@ -1055,6 +1075,40 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 	}
 }
 
+/* Return whether the chunk is erased, and account for its ECC result. */
+static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
+				       u8 *data, int data_off,
+				       u8 *oob, int oob_off,
+				       unsigned int user_data_sz,
+				       unsigned int *max_bitflips)
+{
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	unsigned int oob_len = ecc->bytes + user_data_sz;
+	int ret;
+
+	/* Check the physical representation for bitflips in erased pages. */
+	if (nand->options & NAND_NEED_SCRAMBLING)
+		nand_change_read_column_op(nand, data_off, data, ecc->size, false);
+
+	nand_change_read_column_op(nand, oob_off, oob, oob_len, false);
+
+	ret = nand_check_erased_ecc_chunk(data, ecc->size, oob, oob_len, NULL, 0,
+					  ecc->strength);
+
+	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, ret);
+
+	return ret >= 0;
+}
+
+struct sunxi_nfc_ecc_read {
+	u8 *buf;
+	int page;
+	unsigned int max_bitflips;
+	bool oob_required;
+	bool dma;
+	bool has_erased_chunk;
+};
+
 static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 				    int step, u32 status, u32 pattern_found,
 				    bool *erased)
@@ -1094,98 +1148,6 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	return NFC_ECC_ERR_CNT(step, tmp);
 }
 
-static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
-				       u8 *data, int data_off,
-				       u8 *oob, int oob_off,
-				       int *cur_off,
-				       unsigned int *max_bitflips,
-				       int step, bool oob_required, int page)
-{
-	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
-	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int raw_mode = 0;
-	u32 pattern_found;
-	bool bbm = !step;
-	bool erased;
-	int ret;
-	/* From the controller point of view, we are at step 0 */
-	const int nfc_step = 0;
-
-	if (*cur_off != data_off)
-		nand_change_read_column_op(nand, data_off, NULL, 0, false);
-
-	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
-
-	if (data_off + ecc->size != oob_off)
-		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
-
-	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-	if (ret)
-		return ret;
-
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
-	sunxi_nfc_randomizer_config(nand, page, false);
-	sunxi_nfc_randomizer_enable(nand);
-	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
-	       nfc->regs + NFC_REG_CMD);
-
-	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
-	sunxi_nfc_randomizer_disable(nand);
-	if (ret)
-		return ret;
-
-	*cur_off = oob_off + ecc->bytes + user_data_sz;
-
-	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
-	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
-
-	ret = sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL,
-				       nfc_step, readl(nfc->regs + NFC_REG_ECC_ST),
-				       pattern_found, &erased);
-	if (erased)
-		return 1;
-
-	if (ret < 0) {
-		/*
-		 * Re-read the data with the randomizer disabled to identify
-		 * bitflips in erased pages.
-		 */
-		if (nand->options & NAND_NEED_SCRAMBLING)
-			nand_change_read_column_op(nand, data_off, data,
-						   ecc->size, false);
-		else
-			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE,
-				      ecc->size);
-
-		nand_change_read_column_op(nand, oob_off, oob,
-					   ecc->bytes + user_data_sz, false);
-
-		ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
-						  ecc->bytes + user_data_sz,
-						  NULL, 0, ecc->strength);
-		if (ret >= 0)
-			raw_mode = 1;
-	} else {
-		memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
-
-		if (oob_required) {
-			nand_change_read_column_op(nand, oob_off, NULL, 0,
-						   false);
-			sunxi_nfc_randomizer_read_buf(nand, oob, ecc->bytes + user_data_sz,
-						      true, page);
-
-			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, nfc_step,
-							    bbm, page, user_data_sz);
-		}
-	}
-
-	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, ret);
-
-	return raw_mode;
-}
-
 /*
  * Returns the offset of the OOB for each step.
  * (it includes the user data before the ECC data.)
@@ -1241,18 +1203,166 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 		*cur_off = mtd->oobsize + mtd->writesize;
 }
 
-static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf,
-					    int oob_required, int page,
-					    int nchunks)
+/* Interpret one PIO step or a completed DMA batch before reusing its status. */
+static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
+				    struct sunxi_nfc_ecc_read *read,
+				    u32 status, u32 pattern_found,
+				    int first_step, int nsteps)
 {
-	bool randomized = nand->options & NAND_NEED_SCRAMBLING;
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	unsigned int max_bitflips = 0;
-	int ret, i, raw_mode = 0;
+	bool randomized = nand->options & NAND_NEED_SCRAMBLING;
+	unsigned int user_data_sz;
+	int i, ret;
+
+	for (i = 0; i < nsteps; i++) {
+		int step = first_step + i;
+		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, step);
+		u8 *data = read->buf + step * ecc->size;
+		u8 *oob = nand->oob_poi + oob_off;
+		bool erased;
+		int bitflips;
+
+		user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
+		bitflips = sunxi_nfc_hw_ecc_correct(nand,
+						    !read->dma || randomized ? data : NULL,
+						    read->oob_required ? oob : NULL,
+						    i, status, pattern_found, &erased);
+		if (bitflips < 0) {
+			/* Preserve PIO data before the raw erased-page check. */
+			if (!read->dma && !randomized)
+				memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
+			continue;
+		}
+
+		if (erased) {
+			read->has_erased_chunk = true;
+			continue;
+		}
+
+		if (!read->dma)
+			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
+
+		if (read->oob_required) {
+			/* Keep the existing PIO and DMA representations of parity. */
+			nand_change_read_column_op(nand, mtd->writesize + oob_off,
+						   read->dma ? oob : NULL,
+						   read->dma ? ecc->bytes + user_data_sz : 0,
+						   false);
+
+			if (!read->dma) {
+				sunxi_nfc_randomizer_read_buf(nand, oob,
+							      ecc->bytes + user_data_sz,
+							      true, read->page);
+			}
+
+			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, i, !step,
+							    read->page, user_data_sz);
+		}
+
+		sunxi_nfc_hw_ecc_update_stats(nand, &read->max_bitflips, bitflips);
+	}
+
+	if (!(status & NFC_ECC_ERR_MSK(nfc)))
+		return 0;
+
+	/* Finish consuming the batch's corrected OOB before raw error rereads. */
+	for (i = 0; i < nsteps; i++) {
+		int step = first_step + i;
+		int data_off, oob_off;
+
+		if (!(status & NFC_ECC_ERR(i)))
+			continue;
+
+		data_off = step * ecc->size;
+		oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, step);
+		user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
+		ret = sunxi_nfc_hw_ecc_read_error(nand, read->buf + data_off, data_off,
+						  nand->oob_poi + oob_off,
+						  mtd->writesize + oob_off, user_data_sz,
+						  &read->max_bitflips);
+		if (ret < 0)
+			return ret;
+		if (ret)
+			read->has_erased_chunk = true;
+	}
+
+	return 0;
+}
+
+static int sunxi_nfc_oob_finish_read(struct nand_chip *nand,
+				     struct sunxi_nfc_ecc_read *read, int *cur_off)
+{
+	if (read->oob_required)
+		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, cur_off,
+						!read->has_erased_chunk, read->page);
+
+	return read->max_bitflips;
+}
+
+static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
+				       struct sunxi_nfc_ecc_read *read,
+				       int step, int *cur_off)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int data_off = step * ecc->size;
+	int oob_off = nand_to_mtd(nand)->writesize + sunxi_get_oob_offset(sunxi_nand, ecc, step);
+	int page = read->page;
+	u32 pattern_found;
+	int ret;
+
+	if (*cur_off != data_off)
+		nand_change_read_column_op(nand, data_off, NULL, 0, false);
+
+	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+
+	if (data_off + ecc->size != oob_off)
+		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+
+	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+	if (ret)
+		return ret;
+
+	sunxi_nfc_set_user_data_len(nfc, user_data_sz, 0);
+	sunxi_nfc_randomizer_config(nand, page, false);
+	sunxi_nfc_randomizer_enable(nand);
+	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
+	       nfc->regs + NFC_REG_CMD);
+
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
+	sunxi_nfc_randomizer_disable(nand);
+	if (ret)
+		return ret;
+
+	*cur_off = oob_off + ecc->bytes + user_data_sz;
+
+	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
+	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+
+	return sunxi_nand->oob_ops->read_batch(nand, read,
+					     readl(nfc->regs + NFC_REG_ECC_ST),
+					     pattern_found, step, 1);
+}
+
+static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
+					    int oob_required, int page, int nchunks)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	struct sunxi_nfc_ecc_read read = {
+		.buf = buf,
+		.page = page,
+		.oob_required = oob_required,
+		.dma = true,
+	};
 	struct scatterlist sg;
+	int ret, i;
 	u32 status, pattern_found, wait;
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
@@ -1299,83 +1409,12 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 	status = readl(nfc->regs + NFC_REG_ECC_ST);
 	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
 	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+	ret = sunxi_nand->oob_ops->read_batch(nand, &read, status, pattern_found,
+					    0, nchunks);
+	if (ret)
+		return ret;
 
-	for (i = 0; i < nchunks; i++) {
-		int data_off = i * ecc->size;
-		unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, i);
-		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-		u8 *data = buf + data_off;
-		u8 *oob = nand->oob_poi + oob_off;
-		bool erased;
-
-		ret = sunxi_nfc_hw_ecc_correct(nand, randomized ? data : NULL,
-					       oob_required ? oob : NULL,
-					       i, status, pattern_found,
-					       &erased);
-
-		/* ECC errors are handled in the second loop. */
-		if (ret < 0)
-			continue;
-
-		if (oob_required && !erased) {
-			/* TODO: use DMA to retrieve OOB */
-			nand_change_read_column_op(nand,
-						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + user_data_sz, false);
-
-			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, i, !i,
-							    page, user_data_sz);
-		}
-
-		if (erased)
-			raw_mode = 1;
-
-		sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
-	}
-
-	if (status & NFC_ECC_ERR_MSK(nfc)) {
-		for (i = 0; i < nchunks; i++) {
-			int data_off = i * ecc->size;
-			unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, i);
-			int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-			u8 *data = buf + data_off;
-			u8 *oob = nand->oob_poi + oob_off;
-
-			if (!(status & NFC_ECC_ERR(i)))
-				continue;
-
-			/*
-			 * Re-read the data with the randomizer disabled to
-			 * identify bitflips in erased pages.
-			 * TODO: use DMA to read page in raw mode
-			 */
-			if (randomized)
-				nand_change_read_column_op(nand, data_off,
-							   data, ecc->size,
-							   false);
-
-			/* TODO: use DMA to retrieve OOB */
-			nand_change_read_column_op(nand,
-						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + user_data_sz, false);
-
-			ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
-							  ecc->bytes + user_data_sz,
-							  NULL, 0,
-							  ecc->strength);
-			if (ret >= 0)
-				raw_mode = 1;
-
-			sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
-		}
-	}
-
-	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi,
-						NULL, !raw_mode,
-						page);
-
-	return max_bitflips;
+	return sunxi_nand->oob_ops->finish_read(nand, &read, NULL);
 }
 
 static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
@@ -1452,11 +1491,13 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	unsigned int max_bitflips = 0;
+	struct sunxi_nfc_ecc_read read = {
+		.buf = buf,
+		.page = page,
+		.oob_required = oob_required,
+	};
 	int ret, i, cur_off = 0;
-	bool raw_mode = false;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
@@ -1466,28 +1507,15 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 
 	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = 0; i < ecc->steps; i++) {
-		int data_off = i * ecc->size;
-		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-		u8 *data = buf + data_off;
-		u8 *oob = nand->oob_poi + oob_off;
-
-		ret = sunxi_nfc_hw_ecc_read_chunk(nand, data, data_off, oob,
-						  oob_off + mtd->writesize,
-						  &cur_off, &max_bitflips,
-						  i, oob_required, page);
+		ret = sunxi_nfc_hw_ecc_read_chunk(nand, &read, i, &cur_off);
 		if (ret < 0)
 			return ret;
-		else if (ret)
-			raw_mode = true;
 	}
 
-	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, &cur_off,
-						!raw_mode, page);
-
+	ret = sunxi_nand->oob_ops->finish_read(nand, &read, &cur_off);
 	sunxi_nfc_hw_ecc_disable(nand);
 
-	return max_bitflips;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
@@ -1513,11 +1541,12 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 					 u8 *bufpoi, int page)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	struct sunxi_nfc_ecc_read read = {
+		.buf = bufpoi,
+		.page = page,
+	};
 	int ret, i, cur_off = 0;
-	unsigned int max_bitflips = 0;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
@@ -1528,23 +1557,15 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = data_offs / ecc->size;
 	     i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
-		int data_off = i * ecc->size;
-		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-		u8 *data = bufpoi + data_off;
-		u8 *oob = nand->oob_poi + oob_off;
-
-		ret = sunxi_nfc_hw_ecc_read_chunk(nand, data, data_off,
-						  oob,
-						  oob_off + mtd->writesize,
-						  &cur_off, &max_bitflips, i,
-						  false, page);
+		ret = sunxi_nfc_hw_ecc_read_chunk(nand, &read, i, &cur_off);
 		if (ret < 0)
 			return ret;
 	}
 
+	ret = read.max_bitflips;
 	sunxi_nfc_hw_ecc_disable(nand);
 
-	return max_bitflips;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
@@ -2066,6 +2087,58 @@ static int sunxi_nfc_maximize_user_data(struct nand_chip *nand, uint32_t oobsize
 	return 0;
 }
 
+static unsigned int sunxi_nfc_oob_min_user_data(struct nand_chip *nand, int nsteps)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	unsigned int size = 0;
+	int i;
+
+	/* Variable lengths reserve the first word, which contains the BBM. */
+	if (nfc->caps->reg_user_data_len)
+		return USER_DATA_SZ;
+
+	for (i = 0; i < nsteps; i++)
+		size += sunxi_nfc_user_data_sz(sunxi_nand, i);
+
+	/* Preserve the older platforms' extra BBM reservation and ECC strength. */
+	if (nfc->caps->legacy_max_strength)
+		size += 2;
+
+	return size;
+}
+
+static int sunxi_nfc_oob_init_user_data(struct nand_chip *nand, int nsteps)
+{
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+
+	if (!nfc->caps->reg_user_data_len)
+		return 0;
+
+	/* Prioritize ECC strength, then use the remaining space for user data. */
+	return sunxi_nfc_maximize_user_data(nand, nand_to_mtd(nand)->oobsize,
+					  nand->ecc.bytes, nsteps);
+}
+
+/*
+ * Both modes use the same layout and ECC policy. Scrambled transfers also
+ * compensate the first two user bytes to keep the on-flash BBM unmodified.
+ */
+static const struct sunxi_nfc_oob_ops sunxi_nfc_plain_oob_ops = {
+	.min_user_data = sunxi_nfc_oob_min_user_data,
+	.init_user_data = sunxi_nfc_oob_init_user_data,
+	.read_batch = sunxi_nfc_oob_read_batch,
+	.finish_read = sunxi_nfc_oob_finish_read,
+};
+
+static const struct sunxi_nfc_oob_ops sunxi_nfc_scrambled_plain_bbm_oob_ops = {
+	.min_user_data = sunxi_nfc_oob_min_user_data,
+	.init_user_data = sunxi_nfc_oob_init_user_data,
+	.transform_bbm = sunxi_nfc_randomize_bbm,
+	.read_batch = sunxi_nfc_oob_read_batch,
+	.finish_read = sunxi_nfc_oob_finish_read,
+};
+
 static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 				       struct nand_ecc_ctrl *ecc,
 				       struct device_node *np)
@@ -2090,33 +2163,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 		ecc->size = 1024;
 		nsectors = mtd->writesize / ecc->size;
 
-		if (!nfc->caps->reg_user_data_len) {
-			/*
-			 * If there's a fixed user data length, subtract it before
-			 * computing the max ECC strength
-			 */
-
-			for (i = 0; i < nsectors; i++)
-				total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
-
-			/*
-			 * The 2 BBM bytes should not be removed from the grand total,
-			 * because they are part of the USER_DATA_SZ.
-			 * But we can't modify that for older platform since it may
-			 * result in a stronger ECC at the end, and break the
-			 * compatibility.
-			 */
-			if (nfc->caps->legacy_max_strength)
-				bytes -= 2;
-
-			bytes -= total_user_data_sz;
-		} else {
-			/*
-			 * User-data lengths are encoded in four-byte units. Reserve
-			 * the first word because it contains the two BBM bytes.
-			 */
-			bytes -= USER_DATA_SZ;
-		}
+		bytes -= sunxi_nand->oob_ops->min_user_data(nand, nsectors);
 
 		/*
 		 * Once all user data has been subtracted, the rest can be used
@@ -2175,20 +2222,12 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 
 	nsectors = mtd->writesize / ecc->size;
 
-	/*
-	 * The rationale for variable data length is to prioritize maximum ECC
-	 * strength, and then use the remaining space for user data.
-	 */
-	if (nfc->caps->reg_user_data_len) {
-		ret = sunxi_nfc_maximize_user_data(nand, mtd->oobsize,
-						   ecc->bytes, nsectors);
-		if (ret)
-			return ret;
-	}
+	ret = sunxi_nand->oob_ops->init_user_data(nand, nsectors);
+	if (ret)
+		return ret;
 
-	if (total_user_data_sz == 0)
-		for (i = 0; i < nsectors; i++)
-			total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
+	for (i = 0; i < nsectors; i++)
+		total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
 
 	if (mtd->oobsize < (ecc->bytes * nsectors + total_user_data_sz))
 		return -EINVAL;
@@ -2232,6 +2271,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 
 static int sunxi_nand_attach_chip(struct nand_chip *nand)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	const struct nand_ecc_props *requirements =
 		nanddev_get_ecc_requirements(&nand->base);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
@@ -2254,6 +2294,9 @@ static int sunxi_nand_attach_chip(struct nand_chip *nand)
 	if (!ecc->size || !ecc->strength)
 		return -EINVAL;
 
+	sunxi_nand->oob_ops = nand->options & NAND_NEED_SCRAMBLING ?
+		&sunxi_nfc_scrambled_plain_bbm_oob_ops : &sunxi_nfc_plain_oob_ops;
+
 	switch (ecc->engine_type) {
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
 		ret = sunxi_nand_hw_ecc_ctrl_init(nand, ecc, np);

-- 
2.53.0

