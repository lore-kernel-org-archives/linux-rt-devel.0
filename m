Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745063BADAA
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122353; cv=none; b=kdmXylNf0CgEwA23+7sMFIb94XXbDceSZ78Eh8YTcOJ3ICYdaeDB/jNCONLUjUVPgwpOd+1JRe5YXuEN7jsjJvFG6DknoYGd/A/NNPWKR0XhucVk6QQ8mm4MCcyl1i/v9P1CkCRfpFCUktbAPnh3UqkU9pSApcZex23ODIg+z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122353; c=relaxed/simple;
	bh=UVK7cpZsYvjLC/INqKEBYPgOs/fm62fXED+n3EHB9lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwKaIibQ34hEOA5MaDMKMJlxR3H3RtYdTJ1tYaNS0sl8vJ4pB590M3RLRGPmNNREexd/l5cd2GuVrGzadBLOwrJsRYFxhNd84ctcOVgzWda3wsLa7nNwWVw3anolNpfW4sgWZxKIscPvCQd266Usa4Fl3DUMZZOVt5NCjnoEdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9yHy6kE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9yHy6kE"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8244537ab76so2725578a34.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 20:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122348; x=1792727148; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djZlVdSi/YIckqFS7pyWE2GArCm4EkKkgRfSQpPp8jg=;
        b=G9yHy6kEkuARqAgigyma0b85p4Lx/Fx7nEnXgcbQ62SyneDxmPiONpkuZrdMA6P5c0
         EJATBNoPjqQ4ThjiPAPqVv6bVWDKnC3zc1D8JqFix0uHef1czC9REeU4p5ctK7o1B5q6
         is+8bio5s/F5KJpMUzSRHX/ZL2YVVYe1PHbv8US3Hfb4rHjlYuNLYw2v7eGEpCCzglnh
         dqJk4gtAzvoTzWvyaSKFxgJVxoPMEN92x+3ZD5o88TMa0PHO9/RpeZQ7czk4iZr/JN8p
         7LKGA/v8HdKW+OpAlAPuATLq4Iw2IVoKLFBj4uhmkpEHyxfh3taWhEwqGSxUq9uukAT5
         +LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122348; x=1792727148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=djZlVdSi/YIckqFS7pyWE2GArCm4EkKkgRfSQpPp8jg=;
        b=2oheRZ6tqibt6G0esBdoFZ/Kj8xzTxiyWWtGBmxQJkoIUQq51kiSYtUF6zTdejdm4A
         Im3VjHSSTDl86D9m/IVKUGSVgSdldedU7BBoyqmw5tLWKH7G4RFO4z9pcbSA8CBYmfv2
         G8SCrtZnJcSgLDBYe4niJukCW9QsuVC1O8t/BorgDZvFMyK9poJ7Z17hm/7Z3AS32Uxq
         8/dtXZHx8RwkGogWBaefOaAoBtFxtwpdTpr8GiGHnQyjoJfr455D/O6w9rV+3a5Zzj5Z
         N1aEq6PPkDmNo0E1qwo2OU3pMO9CPnj8cIVsIdg97lcsRIfHLL8Vj2mcEHpShID+5CEQ
         MOxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyVu+CktFM8x8OYzw6Quf1RwZZ7yv5/5jQHtHbk1YRgM3BRQHvELTIsssBnK95EUeTQcHHDgvhn+ROVpv/vA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJiyw3vkcwjID7XYa54yBBIwZ4KUL3cBPbZ5lWsvqWeMbwCUNRg
	lM+eNoGAU2211vvGJiRY5tUgYCKj2FsG9gUdURKxNaxpaGNYsjqB8bqE
X-Gm-Gg: AYBFou22exxT8K7HSGY8Hom79ps/Uwlh+B5sLFVd4oEsgAytRvbqzl91SCoAbzS/fhP
	NNXzrf9Cbx6zt4tNDYAye6Cx5ick9O5ainfag0DNzMbjrOPSIl19hgKSJrAaEliTOE1nlO0ktYl
	kNo8ZmSSK7xPj4ZBazONFlwgFLnIOT1ZWRt90z/0BYfSqmeSLXCRXhHHtiDY5INTdaMLTeK/NoY
	R1ANpJSesZKDF4rDxsEkrqwdUwYd3brg0oxYZBIkWXB3wtg8UDoj8W+nzV5HyB2rAIJ+BxAL1EL
	bBlY+KDKzuYr4UigzDBQjFDIJJd7+j9mET5+lkgf3rMOFSLIklo2UFOvzgoCa8uLHVodC0bzzcV
	pPBkG/8qZvL/APU1fKkIcrK8Paq/8uIVTs4XjjZtcD657IefcdG31I8+nYbrWDVX472vAePSN1i
	753U+y64Yk2uHm5+v/n/Jti7D2zZqxwN3HG/W/Tj59XShLvKzYGhVvl1JhFnr60S5L+hTWVY3ol
	hH3YOLfYhsnAJVuRIfRllTn+CulyrlR4T4AWbLU/d8BwwuxOf+h3XK/sZ+dJOleMECXDZphbdHq
	bL52rC2y+uKyM07tSwq91aC3Wao2cMvmQcxLR16I/PtHNsw3w3E4KIl3jC5zBtrXy3QMpbOluVw
	8mvLNstUGEK1ZZMdKOSsQDQ==
X-Received: by 2002:a05:6830:2693:b0:7fa:5c68:d053 with SMTP id 46e09a7af769-830993e87a2mr22826285a34.29.1792122348371;
        Thu, 15 Oct 2026 20:45:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm834402a34.0.2026.10.15.20.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 21:45:27 -0600
Subject: [PATCH v8 12/17] mtd: rawnand: sunxi: reuse ECC status within each
 transfer
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-12-8ba4881fbee8@gmail.com>
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
 drivers/mtd/nand/raw/sunxi_nand.c | 90 +++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 8d523dc43093..105374e93b37 100644
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
@@ -1143,23 +1144,64 @@ struct sunxi_nfc_ecc_read {
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
@@ -1175,9 +1217,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 		return 0;
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, step));
-
-	return NFC_ECC_ERR_CNT(step, tmp);
+	return sunxi_nfc_hw_ecc_read_count(nand, snapshot, step);
 }
 
 /*
@@ -1246,7 +1286,7 @@ static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 /* Interpret one PIO step or a completed DMA batch before reusing its status. */
 static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 				    struct sunxi_nfc_ecc_read *read,
-				    u32 status, u32 pattern_found,
+				    struct sunxi_nfc_ecc_snapshot *snapshot,
 				    int first_step, int nsteps)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
@@ -1269,8 +1309,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		bitflips = sunxi_nfc_hw_ecc_correct(nand,
 						    !read->dma || randomized ? data : NULL,
 						    read->oob_required ? oob : NULL,
-						    i, status, pattern_found,
-						    user_data_sz, &erased);
+						    i, snapshot, user_data_sz, &erased);
 		if (bitflips < 0) {
 			/* Preserve PIO data before the raw erased-page check. */
 			if (!read->dma && !randomized)
@@ -1279,7 +1318,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		}
 
 		/* Both patterns are already filled; only all-ones is erased. */
-		if (pattern_found & BIT(i)) {
+		if (snapshot->pattern_found & BIT(i)) {
 			read->has_erased_chunk |= erased;
 			continue;
 		}
@@ -1310,7 +1349,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		sunxi_nfc_hw_ecc_update_stats(nand, &read->max_bitflips, bitflips);
 	}
 
-	if (!(status & NFC_ECC_ERR_MSK(nfc)))
+	if (!(snapshot->status & NFC_ECC_ERR_MSK(nfc)))
 		return 0;
 
 	/* Finish consuming the batch's corrected OOB before raw error rereads. */
@@ -1318,7 +1357,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		int step = first_step + i;
 		int data_off, oob_off;
 
-		if (!(status & NFC_ECC_ERR(i)))
+		if (!(snapshot->status & NFC_ECC_ERR(i)))
 			continue;
 
 		data_off = step * ecc->size;
@@ -1360,10 +1399,10 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
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
@@ -1399,12 +1438,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 
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
@@ -1415,10 +1451,11 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
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
@@ -1474,12 +1511,9 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
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

