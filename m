Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D06340283
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028075; cv=none; b=UmPIH+9Ur8qVnFTjTZ17Xkl/QTnWc3ktm1/RsCjrEm5m+OUp1GgXvnMnxCrTphtlkjXHb8xCGFqya8b9A7OP8sfYszcoEJVMUnvASKcH0ai7+MBa/5ws2GOvSFMFImV63K4XmLY7u6spjgKwJ3RT5X2krjdx5i05PAqAn0NXbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028075; c=relaxed/simple;
	bh=fIW/vMdm44Bsxi2J9pSdPVSnRlU2o1NOr7LGQ9C8GmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzddHAFkA5yvVmVVm7YIcP6MChCl93fnORRIvLfXdMRql1mySuImAxMoFhAg5+ZbKkeS7UKHXz5teghryk++ZLB1LZPKibF28WJrCL222zg83lZt7FfYohprNkcRom5X+X+03sgLGuJ5tEHBzMGoSrKd/Qjl2NP/tGp5TbX7ysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geWe5OIP; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geWe5OIP"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-483a66818edso558903fac.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028068; x=1792632868; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8zDMiUEBwO1gulkBzoLNFoNTmgcXEIIu2kuyTI/+xI=;
        b=geWe5OIPpDAUNyTYZ9ElAWoZ/Pst27/zosGYyO+KlO/jwiFaIScc4/6ZWZjXtnnReY
         XAj4nDnca88mtRf1FBpuexVCmUwwnmyV7x0GhVNQBZyTnZ8eWn/SAdJ5hvQZ59VDEpR3
         bPy8G8e4YwIQfMtmcmOrVZDK6R6O3jVsjpUGSoL3DcXTj/atj2djqG2ZlJK2YDJEog7P
         AjYCkwI4keBwGJIszsHXK8Fi32JxN+G8tiOtoO2qomdQlIjlZvfckDOwPgttz6pecwK8
         sPEBANClDYjpP9vFYzttiTGfwuoBGs5tbjafa8CWlHxFCgE0yUVw0BadNB0bl0O2KDGY
         Lx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028068; x=1792632868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V8zDMiUEBwO1gulkBzoLNFoNTmgcXEIIu2kuyTI/+xI=;
        b=wkrZBd+daIRwd1l4egs7/PRqP8ESybO6iO8/h2WLouISZiCEnhmZZrJ+X6yoKU8KvL
         xWXrLOtkL+x071mnBIBuxzimGnSpGoNQPvvbw+C7r0f798KN+wqh1sjXDd/Bk4uM2+la
         2Wx5XWDD48IamZwo+tlfk5RASooAQmHDkQqX/3HWEfvQEg9YZEfnVqepbV0Qf6Gho9lh
         mZqQF1g48vWoZ5db0IGqTVhH3LHgrI1tuQPBSt3DR1SP0dByATVo4X4LgvSW8I3563P5
         DobrrpWfrQ4B6ZU5pb2WyvHfWdLfG2VFFgRZCDaKQeJRUxtfp332Un/SuRP//SwSIm+8
         s07A==
X-Forwarded-Encrypted: i=1; AKwUvBydUC1TUF3vhHQt4bf67uhHGxmjMUqvIDweXuZg6NGpv3bSsf2iLOB58lT/PK77zovtR1S6yU2HGAn5AuPm2g==@lists.linux.dev
X-Gm-Message-State: AFq9FYINt86IEqK6JZ75rM5p5mZoMBebeN9M8I4QsuDwTw9gED+jxmR6
	x3gFT8nDj3Zk/kpEIbTQFF7txYv0PVaNWkwtzq/Wf92fWYqZ25hF+KpW
X-Gm-Gg: AYBFou1/rnNdpgBm1nhMiLR6Nb7AsAAWu/4qfluhcMyqXEnUiQpSLHuMGDBRmMEObsy
	ksPWy0xIt+gWwBJy6h/x81Gsgar8M5rryv7Sr341v3B833o5oV52CzZtf3cjOpHEnffmP9wZC37
	DPwo8EqOTfYuK2dH9dPWW936Gde9rgflEPip24DYt2melmHuQwOOEqbA3sPgtzZLHv++BkBrlXe
	LHf1XaHBgoNfuQIqDABMOwFhMfYRB3fYWL73wJBv/cBI2powwtACOQABWWCC4et4qSXO2rMskxN
	yqGpN3DFHCUGAGv3FPQq0cdy9EziR1/YbtGFfZg7EI6b/KMQhWcicEnSMlmolfZ44rTJbFwBFEf
	ATYqnPOIlgnQ3+N6puLUumZHe/Xd6GvtefgkIrNWchomCSk2D3tDWII0O/Fu5PEcAlh3GX/pCTV
	lwLMLtWSLrtnNzt3oswsJYQm2fymWk/WqV/EG5Ufn2xp4yI1p3RSPfMxCXG/UCv26ZmE0Be4oAz
	llA4gnE+Jq0S/EKh6AH3uii/zzp5MxovqeHEv8/qX7hhSOIQ+Oxxmscao5/0ThX/dOF+EKXtmou
	o9XJz2KHeVdtvcH6CQEMugvwyBz8Cd+mGHNpkDqlR2jPR20piAlAOi/iThDnPhpNZGTtT68dA6e
	nGARyCovG/Nav+VSJYSmu
X-Received: by 2002:a05:6870:a40a:b0:494:76db:2aa8 with SMTP id 586e51a60fabf-4a2a86a7ebemr15214415fac.5.1792028067725;
        Wed, 14 Oct 2026 18:34:27 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 19:33:56 -0600
Subject: [PATCH v7 09/16] mtd: rawnand: sunxi: use page reads to reposition
 small-page NAND
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-9-5d3fc6ad2da1@gmail.com>
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

The hardware-ECC reader moves between main data and OOB, and rereads raw
bytes when checking a possibly erased ECC step. It uses
nand_change_read_column_op(), which sends large-page random-output
commands and rejects NAND pages of 512 bytes or less. For a small-page
geometry accepted by hardware-ECC setup, these reads therefore fail when
they need to reposition, rather than using the small-page read commands.

Add a read-column helper that uses nand_read_page_op() on small pages.
The core selects READ0, READ1 or READOOB for the requested column and
sends the row address again. Pass the page number through the
erased-check path as well, and preserve errors from the resulting
operation. Keep the existing random-column operation for larger pages.

Select PIO for small pages even when DMA is available: the DMA PAGE_OP
sequencer uses large-page random-column commands internally.
This corrects read-side repositioning only; the write-column helper still
rejects small pages. Software-ECC and raw callbacks are unchanged.

This is a command-path correction found by inspection, not a claim that
ordinary 512+16 NAND becomes supported. The existing controller-ECC
limits still apply: it needs 512-byte ECC support and at least 28 parity
bytes plus four user-data bytes, so 512+16 remains rejected. No
small-page hardware validation is claimed.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 6c4e1740a245..f8abcb46f7f0 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1054,6 +1054,16 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 	}
 }
 
+static int sunxi_nfc_read_column(struct nand_chip *nand, int page,
+				 unsigned int column, void *buf, unsigned int len)
+{
+	/* Small-page NAND needs a new READ0/READ1/READOOB and the page address. */
+	if (nand_to_mtd(nand)->writesize <= 512)
+		return nand_read_page_op(nand, page, column, buf, len);
+
+	return nand_change_read_column_op(nand, column, buf, len, false);
+}
+
 /*
  * Return 1 for an erased chunk or 0 for an uncorrectable chunk, with ECC
  * statistics updated in either case. Negative values report transport errors.
@@ -1062,7 +1072,7 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
 				       unsigned int user_data_sz,
-				       unsigned int *max_bitflips)
+				       unsigned int *max_bitflips, int page)
 {
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	unsigned int oob_len = ecc->bytes + user_data_sz;
@@ -1070,13 +1080,12 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 
 	/* Check the physical representation for bitflips in erased pages. */
 	if (nand->options & NAND_NEED_SCRAMBLING) {
-		ret = nand_change_read_column_op(nand, data_off, data,
-						 ecc->size, false);
+		ret = sunxi_nfc_read_column(nand, page, data_off, data, ecc->size);
 		if (ret)
 			return ret;
 	}
 
-	ret = nand_change_read_column_op(nand, oob_off, oob, oob_len, false);
+	ret = sunxi_nfc_read_column(nand, page, oob_off, oob, oob_len);
 	if (ret)
 		return ret;
 
@@ -1177,8 +1186,8 @@ static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 		return 0;
 
 	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
-		ret = nand_change_read_column_op(nand, mtd->writesize + offset,
-						 NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, mtd->writesize + offset,
+					    NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -1242,10 +1251,9 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 
 		if (read->oob_required) {
 			/* Keep the existing PIO and DMA representations of parity. */
-			ret = nand_change_read_column_op(nand, mtd->writesize + oob_off,
-							 read->dma ? oob : NULL,
-							 read->dma ? ecc->bytes + user_data_sz : 0,
-							 false);
+			ret = sunxi_nfc_read_column(nand, read->page, mtd->writesize + oob_off,
+						    read->dma ? oob : NULL,
+						    read->dma ? ecc->bytes + user_data_sz : 0);
 			if (ret)
 				return ret;
 
@@ -1281,7 +1289,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		ret = sunxi_nfc_hw_ecc_read_error(nand, read->buf + data_off, data_off,
 						  nand->oob_poi + oob_off,
 						  mtd->writesize + oob_off, user_data_sz,
-						  &read->max_bitflips);
+						  &read->max_bitflips, read->page);
 		if (ret < 0)
 			return ret;
 		if (ret)
@@ -1321,7 +1329,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	int ret;
 
 	if (*cur_off != data_off) {
-		ret = nand_change_read_column_op(nand, data_off, NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, data_off, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -1331,7 +1339,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 		return ret;
 
 	if (data_off + ecc->size != oob_off) {
-		ret = nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, oob_off, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -2304,7 +2312,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	ecc->write_oob = sunxi_nfc_hw_ecc_write_oob;
 	mtd_set_ooblayout(mtd, &sunxi_nand_ooblayout_ops);
 
-	if (nfc->dmac || nfc->use_mdma) {
+	/* The DMA page sequencer uses large-page random-column commands. */
+	if (mtd->writesize > 512 && (nfc->dmac || nfc->use_mdma)) {
 		ecc->read_page = sunxi_nfc_hw_ecc_read_page_dma;
 		ecc->read_subpage = sunxi_nfc_hw_ecc_read_subpage_dma;
 		ecc->write_page = sunxi_nfc_hw_ecc_write_page_dma;

-- 
2.53.0

