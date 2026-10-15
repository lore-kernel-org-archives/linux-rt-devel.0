Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292F33F8AD
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028079; cv=none; b=IZh/AFBkOx3/PsjMjOuFmKbxJMd3l7a9D9IpkRWpAZL83Dq4Hy/QofvIcVyDTBqg2Wn8733QuzgrME8Dx2mBTlUYOOLzivTXGWBFULq08pwPHbaEN7Ld7Dzj0Z1qsRkOe2ZDnQGfJ2kfwBv5tgubo+7JtXU6vGj8bNDj1eaXPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028079; c=relaxed/simple;
	bh=/BnEzNdJn0yCUc0/5V8pCZ/H7UotnnA6rAgc31gHaME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWXfchPUyYuPoHkmF0Go5cDNOjWFmS6AWzPo6QoahvHMJrAbeho3NFNIXo2ziYmeP51A9Ig/eqGd1VpxuDUpgpC5mYJPc5ZhnpkCNMW3JamAG+qv5nI3mzSy57wUO03jMdn9C0O0JYYawd+jy9QIHL9of8KFK4Pe0Bu4bRTbVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8VlXrwb; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8VlXrwb"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48ed188ee81so575890fac.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028072; x=1792632872; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNTA8wpqaz3QuKzYKJPWBZ0ACcTPYNOhXhk9kMH+rig=;
        b=M8VlXrwb50OLl1KxUbpZVyAg8R8XdFOaM2Lnvu0zlEDJtpAtTpPZV9F5zx1RJLXKdD
         33IyP2ck7geBvDHNn1YStdf4eXcpvpjx5U3uUh+fVpiCdcrlQFs7BT+uVjt6Api1db2B
         uWVEt+OrxSnXM7uj2wFKJyMpggYiD1XdMYs/WScxqHmNTIxOXj7/5e064j6xNlxLegwr
         7FdW1qsGeNW7JzFDdtjWM7a+M8JlcIMrwIVPMj/rWzMwfGrSSajiUBfPpKoYWHdwuVZD
         JlfYyORGUOsFv08+mRgsmwWOnvmFslVyNKlNnQRJv/gJ1zbv8XWKSi9UtaCA+R9CLBv9
         xcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028072; x=1792632872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bNTA8wpqaz3QuKzYKJPWBZ0ACcTPYNOhXhk9kMH+rig=;
        b=aQankf0QKPBkmcCG+BWLJq0saL6R0YqjhF5Qqp5XK4TwR7SCORo/lKRIeCitnkictj
         qEVnuwtRZE9cRkktXfcCkYXvqXWsFZaGDWE1IhPhaMDPQSZo+lgE1DZCqJt2H25+tgq5
         dosmSSthl0TKiemYvwcnPyu8Y+aE6RjUrkcgp1R0LZwPev3S32mwNeQi7JQUhqIEF79Z
         CZJwK1EFTQr/sepTKPEA70xesAqY9GmvjqecIi8Kaag/s/nP0eX4hrupWxjDaI+pPYlm
         3Eera0Lua4eh6kWaMVMRHP5SOBmVl75JxxIF8SDEQQCY5Q4/uxJBG0hYhtFR8SK9rFIu
         PgXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtl/cvvqOvPQoVy5dkZbRP+oGItgAQIyvBned2Wbw/kmVh1RAUaaG70DkOINMlzNmYOMz+5246Y/egTsPYAw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLGDIfADNfDrwFLdBi1WkJ3XBHutOtcMGNJUz8fF82hVG7DxknH
	1o4AW5VHavne+0ZIwYjGiumCs3OI66EdI4iVYRdZRap48npEg87C6zGN
X-Gm-Gg: AYBFou2S4moDQWTcNleDh7/OOADRGZWUIsIzVcehS3v7iO/TbM7k4dd0/o70DaFutf1
	+jWp3u7fvu3OVU3vXZVOBPm2PgKX2ku+UII0sYMdfELBRRa52puR533TpjqaNfWV+lSsnbH2k0B
	+lLw+s8CZ9m7q+yZp2eL/2j8TWlWuRDWDroCqyBFlTKJg00MYmsLA6udwyGOw5ylLFGEiboX+Rp
	qTXb/6e2wqbdlcX9fH2kt5FXJKt6N1yeohooeqpw1YT/redApCzCarvHgvxEBLfWGLs47IK/m/M
	uUOw4MTJKHKFlV4eEmbmq3OP1z/PKaSRFwT8t+5EF790R1iibJ86mxUTmkX/AYGj5JjVvDzSOSr
	+8VxlWCfR5gzKO1jcfj5ff0En2rJsmLg4xYeDxWkSZdRj4+Ch79K3/o/NkyKKhwiwO182kNHF8U
	O0Qbh+TiBsadKOKOFg4y8Ue79Q/qDpM22BfsnjXRWIa7dFyjuhoTKb3lXiDL3X8mN070AEBFuEC
	3U1ZSweOCETnGb7R2Rr7jV7iOQ2eo4P8EIDLxTRQK8H/n+H1LghnVtSah7SCoWboXABRCtizrUk
	lR6QiBuPnNQjpb2wLfMgd3CPE+Q77mZtkxIDqluWzlHfixtKgo1QphNs2wKe9apjwvahxabvHdM
	7UMlHDrfCKng+lt8S9KN5
X-Received: by 2002:a05:6870:c2a5:b0:493:8be5:4271 with SMTP id 586e51a60fabf-4a2a8a2a2f1mr15479440fac.33.1792028071864;
        Wed, 14 Oct 2026 18:34:31 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 19:33:58 -0600
Subject: [PATCH v7 11/16] mtd: rawnand: sunxi: reuse ECC status within each
 transfer
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-11-5d3fc6ad2da1@gmail.com>
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

A completed DMA batch leaves one ECC status bitmap and one pattern
bitmap for all its steps. Four consecutive steps also share a packed
correction-counter register. Reading the pattern ID for every matching
step and the counter word for every corrected step repeats MMIO accesses
to the same completed result.

Snapshot status and pattern information once per completed transfer.
Reuse the status read when the controller places pattern-found bits in
the same register, and read the pattern ID only when a non-error step
needs it. Cache each packed counter word while consuming its steps.

Keep the snapshot local to a single transfer and invalidate the cached
counter before processing it. Each PIO step gets a fresh snapshot, as
does each DMA batch. The ECC decisions and returned correction counts
are unchanged, as is the page layout; only redundant register reads are
removed.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 88 +++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index c27cd8e04739..8d83882592de 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -258,6 +258,7 @@ struct sunxi_nfc_timings {
 };
 
 struct sunxi_nfc_ecc_read;
+struct sunxi_nfc_ecc_snapshot;
 
 /* OOB interpretation is independent of PIO/DMA command sequencing. */
 struct sunxi_nfc_oob_ops {
@@ -268,7 +269,7 @@ struct sunxi_nfc_oob_ops {
 	void (*transform_bbm)(struct nand_chip *nand, int page, u8 *bbm);
 	/* Consume one PIO step or a DMA batch; negative values are I/O errors. */
 	int (*read_batch)(struct nand_chip *nand, struct sunxi_nfc_ecc_read *read,
-			  u32 status, u32 pattern_found, int first_step, int nsteps);
+			  struct sunxi_nfc_ecc_snapshot *snapshot, int first_step, int nsteps);
 	/* Read any remaining OOB and return the maximum correction count. */
 	int (*finish_read)(struct nand_chip *nand, struct sunxi_nfc_ecc_read *read,
 			   int *cur_off);
@@ -1136,23 +1137,64 @@ struct sunxi_nfc_ecc_read {
 	bool has_erased_chunk;
 };
 
+struct sunxi_nfc_ecc_snapshot {
+	u32 status;
+	u32 pattern_found;
+	u32 pattern_id;
+	u32 count_reg;
+	u32 count;
+};
+
+static void sunxi_nfc_hw_ecc_read_status(struct nand_chip *nand,
+					 struct sunxi_nfc_ecc_snapshot *snapshot)
+{
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	u32 pattern_found;
+
+	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
+	snapshot->pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+	if (nfc->caps->reg_pat_found == NFC_REG_ECC_ST)
+		snapshot->status = pattern_found;
+	else
+		snapshot->status = readl(nfc->regs + NFC_REG_ECC_ST);
+	snapshot->pattern_id = 0;
+	if (snapshot->pattern_found & ~snapshot->status)
+		snapshot->pattern_id = readl(nfc->regs + NFC_REG_PAT_ID(nfc));
+	/* A new operation, including every PIO step, invalidates the count word. */
+	snapshot->count_reg = ~0U;
+}
+
+static unsigned int
+sunxi_nfc_hw_ecc_read_count(struct nand_chip *nand,
+			    struct sunxi_nfc_ecc_snapshot *snapshot, int step)
+{
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	u32 reg = NFC_REG_ECC_ERR_CNT(nfc, step);
+
+	/* Four consecutive DMA steps share one error-counter register. */
+	if (snapshot->count_reg != reg) {
+		snapshot->count = readl(nfc->regs + reg);
+		snapshot->count_reg = reg;
+	}
+
+	return NFC_ECC_ERR_CNT(step, snapshot->count);
+}
+
 static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
-				    int step, u32 status, u32 pattern_found,
+				    int step, struct sunxi_nfc_ecc_snapshot *snapshot,
 				    unsigned int user_data_sz, bool *erased)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	u32 tmp;
 
 	*erased = false;
 
-	if (status & NFC_ECC_ERR(step))
+	if (snapshot->status & NFC_ECC_ERR(step))
 		return -EBADMSG;
 
-	if (pattern_found & BIT(step)) {
+	if (snapshot->pattern_found & BIT(step)) {
 		u8 pattern;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
+		if (unlikely(!(snapshot->pattern_id & BIT(step)))) {
 			pattern = 0x0;
 		} else {
 			pattern = 0xff;
@@ -1168,9 +1210,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 		return 0;
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, step));
-
-	return NFC_ECC_ERR_CNT(step, tmp);
+	return sunxi_nfc_hw_ecc_read_count(nand, snapshot, step);
 }
 
 /*
@@ -1239,7 +1279,7 @@ static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 /* Interpret one PIO step or a completed DMA batch before reusing its status. */
 static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 				    struct sunxi_nfc_ecc_read *read,
-				    u32 status, u32 pattern_found,
+				    struct sunxi_nfc_ecc_snapshot *snapshot,
 				    int first_step, int nsteps)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
@@ -1262,8 +1302,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		bitflips = sunxi_nfc_hw_ecc_correct(nand,
 						    !read->dma || randomized ? data : NULL,
 						    read->oob_required ? oob : NULL,
-						    i, status, pattern_found,
-						    user_data_sz, &erased);
+						    i, snapshot, user_data_sz, &erased);
 		if (bitflips < 0) {
 			/* Preserve PIO data before the raw erased-page check. */
 			if (!read->dma && !randomized)
@@ -1302,7 +1341,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		sunxi_nfc_hw_ecc_update_stats(nand, &read->max_bitflips, bitflips);
 	}
 
-	if (!(status & NFC_ECC_ERR_MSK(nfc)))
+	if (!(snapshot->status & NFC_ECC_ERR_MSK(nfc)))
 		return 0;
 
 	/* Finish consuming the batch's corrected OOB before raw error rereads. */
@@ -1310,7 +1349,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		int step = first_step + i;
 		int data_off, oob_off;
 
-		if (!(status & NFC_ECC_ERR(i)))
+		if (!(snapshot->status & NFC_ECC_ERR(i)))
 			continue;
 
 		data_off = step * ecc->size;
@@ -1352,10 +1391,10 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	struct sunxi_nfc_ecc_snapshot snapshot;
 	int data_off = step * ecc->size;
 	int oob_off = nand_to_mtd(nand)->writesize + sunxi_get_oob_offset(sunxi_nand, ecc, step);
 	int page = read->page;
-	u32 pattern_found;
 	int ret;
 
 	if (*cur_off != data_off) {
@@ -1391,12 +1430,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 
 	*cur_off = oob_off + ecc->bytes + user_data_sz;
 
-	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
-	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+	sunxi_nfc_hw_ecc_read_status(nand, &snapshot);
 
-	return sunxi_nand->oob_ops->read_batch(nand, read,
-					     readl(nfc->regs + NFC_REG_ECC_ST),
-					     pattern_found, step, 1);
+	return sunxi_nand->oob_ops->read_batch(nand, read, &snapshot, step, 1);
 }
 
 static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
@@ -1407,10 +1443,11 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	struct sunxi_nfc_ecc_snapshot snapshot;
 	struct scatterlist sg;
 	int page = read->page;
 	int ret, i;
-	u32 status, pattern_found, wait;
+	u32 wait;
 
 	if (first_step) {
 		ret = sunxi_nfc_read_column(nand, page, first_step * ecc->size,
@@ -1466,12 +1503,9 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	status = readl(nfc->regs + NFC_REG_ECC_ST);
-	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
-	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+	sunxi_nfc_hw_ecc_read_status(nand, &snapshot);
 
-	return sunxi_nand->oob_ops->read_batch(nand, read, status, pattern_found,
-					     first_step, nchunks);
+	return sunxi_nand->oob_ops->read_batch(nand, read, &snapshot, first_step, nchunks);
 }
 
 static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,

-- 
2.53.0

