Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83C46E01D
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266797; cv=none; b=ulBzXu3awIMSIszePMyHu2UUBAB5dwPKmXpUhgfliQgopVbTVisqEwXb7q+5AFRLOADQ2qKrUOfraKZ/HkYkHe8jkrEl7HCAGCm/QWSi7WFjoBF/69H0Zj4CguDJP2eD1+yFDDj5WndL+5sAuYc9uZvcSuew6V5zjIzxJrq8/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266797; c=relaxed/simple;
	bh=y/k0+Vyv7GMZjSS1jO8ajLO2qrk157wIklTWriY/pDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umAHIdFyCdku0EKBMvFR32RIFkNQsT92tvUEfxwB+SlmxXQ/w+5QZ2WBrIHsUyfxFoUPZ5tR85b+MpmV/P2Ho5bZbhZyO9GL0nai8FNvg9x1qGFAEsQ7BB1xmeqSPfLq5aIM6OtdoaNp6QGUvF2ceULKvJ+VaqTZEyHLMJ8PjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtI6gqhe; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtI6gqhe"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6f5a0893610so693694eaf.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266795; x=1792871595; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nf9wESnWB/+K14vmtalekHavvufaIUlDxawFx43Br50=;
        b=PtI6gqhee3t4bQ09PO/oPA77lBYOqCCN1c3sIdQ1nrdKmX1/B1uUzDGpPodm6kASb/
         qIoj5s8FCd+XR2rEtS6KPzkGl7AfB2kBOkgA4daiVa6Mg2XNjRIjtYXFKVyGTRPz+hf9
         3Y2yu5fzE5MCXhhW5TkTsWwQm4ucwhAg9BqDZ0hJJXmYlQ0D3DxtGA0pbGoIJ0rco/Bu
         pJnJaS0JwDJAMrla9e9sfD5W5/R2levzf3IEMvzqIL1yR2PJRI7efH1/CJzOXdj2ykqE
         weWfWd+YAlDxtLXEIeDblvwUMhbTlGV8FaBVityIRX90u9zElotvfjGAG8l249d02at6
         xf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266795; x=1792871595;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nf9wESnWB/+K14vmtalekHavvufaIUlDxawFx43Br50=;
        b=ReQUNqpUICe0swa/DKYYeL4+hjpOH/uW/OhHSWKkIHcatavC7W7kz7A9NHy39ygL0d
         0wJll37NW17iJrvNLzZ71IfIV9kmdIvTRKzJF6zknNRfrsv/q8prgE56o1Xg40u3qK20
         pMIxpLY8ClOswtd4sA1FF+Euzuf7/eQAQD6vHk6bbP5vdRrpYBKJXIjLutmg+/QdprH6
         J1+K8EXDUjLzxjzY+K3ut0CMNONak7uWrz41JMO1p67f0d+p7/I/8iQYVETrFMRmckdb
         YP1AdXR1xShDJnkPBxCGAstdAY1kZ/+09Nri/xc9gnZGzsYbyJLo4hjbi/0yNR5PetaG
         gSaA==
X-Forwarded-Encrypted: i=1; AKwUvBw4ZyEGwXDmj22UHXbHOFGA6NBMYmxHJWsQezxvXUY5bA7bhrFGMrFhiC8WTl9QjRZdmrlNmVxXtZGY/n+5cQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLzQF3erkWrDtZSOqMJVoBkzgR5sxhfVZBWDWaYnk1AUBB9o3uj
	wbPNsjJbFXmEyPmKY7lOCtk461quSQkyzLGI8AuQXw58zGxPK1218t8p
X-Gm-Gg: AYBFou1/3stGlWWYJh9KFMxxz8PPJ4XQDFGImBRKPHxkr7gA4U3ByDkwsf3GqHc6vzM
	shDwjNo9MFR131e/QGA85JIAQsbg9KJ7Wg2RkevH9Gmt4+80KD5lmJG28vT8rEKdPwXRJDPhwj9
	4IPMrRLO5jhSVLWcVtjriU2YWGxL2GHPSNkGv3WYx2vxl1+d9YoH2Z8ooIsERTY2vafLbe6UVzZ
	Fr6QTkyrncHrK8E3rKQJE/+k1kyBL14iQ0iQI3iFGV2dz0uelRpZ1WsLHTyfPVbjjF5gDk/6PIO
	WNRfWfl24WlxAc1EPo1kPCIT52l+gSgyo7MeKpoN9KV5q3eTd3A12bCA8LzKxakgyRJmMNp8pDa
	+lcCBXUSnninOYfORoSJlFc0/vrSIJhOv9L/4saa0Pwgzhu6e/FJWCa4jGT+LI+7zfNHEe2TYaH
	Rg+y3UaNdjNbWeHjUcUOlUfFrcrIkw20pz8dQ2LqjWqpf+u05BaaP9AuyHhB4vneeZLYCMI2zI2
	/SdaEICsyaJ9NJF+NPzgPuMrhzR9B0slMGAX48dhSE41BzPrcq2LCanF1ZDo3kZp05Q6fcWoeyf
	UVecA83SW3t0ujzLHCr8TTAa0bQUK4d4dD8CaxQzh1enD1j7Ndj/PrHCxYbHiRo5TICeNf1yZry
	4nUVdZpcHlO6sgBK8P0gKRx4w7d0A2aveUe4gGTQVMzI=
X-Received: by 2002:a05:6820:1693:b0:6f7:b0e0:63c7 with SMTP id 006d021491bc7-70356495839mr2211954eaf.35.1792266794730;
        Sat, 17 Oct 2026 12:53:14 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6e12dfasm4829795a34.24.2026.10.17.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:53:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Brian Norris <computersforpeace@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v9 13/18] mtd: rawnand: sunxi: reuse ECC status within each transfer
Date: Sat, 17 Oct 2026 13:53:02 -0600
Message-ID: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-13-5af9a1be16ef@gmail.com>
In-Reply-To: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
References: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit

A completed DMA batch leaves one ECC status bitmap and one pattern
bitmap for all its steps. Four consecutive steps also share a packed
correction-counter register. Reading the pattern ID for every matching
step and the counter word for every corrected step repeats MMIO accesses
to the same completed result.

Snapshot status and pattern information once per completed transfer.
Reuse the status read when the controller places pattern-found bits in
the same register, and read the pattern ID only when a non-error step
needs it. Use a cached accessor so a reader can request pattern IDs
without knowing whether the initial snapshot already fetched them.
Cache each packed counter word while consuming its steps.

Keep the snapshot local to a single transfer and invalidate the cached
counter before processing it. Consume lazily read fields before starting
another ECC transfer; each PIO step and DMA batch gets a fresh snapshot.
The ECC decisions and returned correction counts are unchanged, as is
the page layout; only redundant register reads are removed.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 108 ++++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 69e92fe21040..a12ec60c63b4 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -258,6 +258,7 @@ struct sunxi_nfc_timings {
 };
 
 struct sunxi_nfc_ecc_read;
+struct sunxi_nfc_ecc_snapshot;
 
 /* OOB geometry and interpretation; callbacks may issue supplementary reads. */
 struct sunxi_nfc_oob_ops {
@@ -273,7 +274,7 @@ struct sunxi_nfc_oob_ops {
 	 * Return zero on success or a negative I/O error.
 	 */
 	int (*read_batch)(struct nand_chip *nand, struct sunxi_nfc_ecc_read *read,
-			  u32 status, u32 pattern_found, int first_step, int nsteps);
+			  struct sunxi_nfc_ecc_snapshot *snapshot, int first_step, int nsteps);
 	/*
 	 * Finish remaining OOB; return max bitflips or a negative I/O error.
 	 * cur_off is an absolute NAND column, or NULL if unknown.
@@ -1155,23 +1156,82 @@ struct sunxi_nfc_ecc_read {
 	bool has_erased_chunk;
 };
 
+/*
+ * Transfer-local ECC result cache. Pattern IDs and correction counts may be
+ * read lazily, so finish consuming them before the next ECC transfer.
+ */
+struct sunxi_nfc_ecc_snapshot {
+	u32 status;
+	u32 pattern_found;
+	u32 pattern_id;
+	u32 count_reg;
+	u32 count;
+	bool pattern_id_valid;
+};
+
+static void sunxi_nfc_hw_ecc_read_pattern_id(struct nand_chip *nand,
+					     struct sunxi_nfc_ecc_snapshot *snapshot)
+{
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+
+	/* Zero is a valid pattern ID, so track whether it has been read. */
+	if (snapshot->pattern_id_valid)
+		return;
+
+	snapshot->pattern_id = readl(nfc->regs + NFC_REG_PAT_ID(nfc));
+	snapshot->pattern_id_valid = true;
+}
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
+	snapshot->pattern_id_valid = false;
+	if (snapshot->pattern_found & ~snapshot->status)
+		sunxi_nfc_hw_ecc_read_pattern_id(nand, snapshot);
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
@@ -1187,9 +1247,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 		return 0;
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, step));
-
-	return NFC_ECC_ERR_CNT(step, tmp);
+	return sunxi_nfc_hw_ecc_read_count(nand, snapshot, step);
 }
 
 /*
@@ -1258,7 +1316,7 @@ static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 /* Interpret one PIO step or a completed DMA batch before reusing its status. */
 static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 				    struct sunxi_nfc_ecc_read *read,
-				    u32 status, u32 pattern_found,
+				    struct sunxi_nfc_ecc_snapshot *snapshot,
 				    int first_step, int nsteps)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
@@ -1281,8 +1339,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		bitflips = sunxi_nfc_hw_ecc_correct(nand,
 						    !read->dma || randomized ? data : NULL,
 						    read->oob_required ? oob : NULL,
-						    i, status, pattern_found,
-						    user_data_sz, &erased);
+						    i, snapshot, user_data_sz, &erased);
 		if (bitflips < 0) {
 			/* Preserve PIO data before the raw erased-page check. */
 			if (!read->dma && !randomized)
@@ -1291,7 +1348,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		}
 
 		/* Both patterns are already filled; only all-ones is erased. */
-		if (pattern_found & BIT(i)) {
+		if (snapshot->pattern_found & BIT(i)) {
 			read->has_erased_chunk |= erased;
 			continue;
 		}
@@ -1327,7 +1384,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		sunxi_nfc_hw_ecc_update_stats(nand, &read->max_bitflips, bitflips);
 	}
 
-	if (!(status & NFC_ECC_ERR_MSK(nfc)))
+	if (!(snapshot->status & NFC_ECC_ERR_MSK(nfc)))
 		return 0;
 
 	/* Finish consuming the batch's corrected OOB before raw error rereads. */
@@ -1335,7 +1392,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		int step = first_step + i;
 		int data_off, oob_off;
 
-		if (!(status & NFC_ECC_ERR(i)))
+		if (!(snapshot->status & NFC_ECC_ERR(i)))
 			continue;
 
 		data_off = step * ecc->size;
@@ -1377,10 +1434,10 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
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
@@ -1416,12 +1473,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 
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
@@ -1432,10 +1486,11 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
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
@@ -1491,12 +1546,9 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
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

