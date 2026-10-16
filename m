Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AC3B5F48
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122347; cv=none; b=YD0FSDOxs3IlDI7Xj/JEgH55IyHF0WBg6wQvnAR0th/lzUSln41QK7EJMln8MvwpBq4VLh3h/AU/HgILMlRW5TDzqoasEFOIGPVlZok94W/NsfnxNGXeqnDE+41uTsh1kGquMDcez+M8kgUVVXCnEeLmu4iPCxEP0Np9qfk8L14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122347; c=relaxed/simple;
	bh=44SdB/unSRPSVYBoHP4dv/wWCcEp8Mtv+c+krHUUX5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jMSxV269GbEiHa2MBkCqDX43l3fe+PamoPMsqFKJ+LRk2bhPQ7jL2dbqnHtGloq3t0Dm/JV3oh7fgoELbcak+lMiaf62o1Du8/WMhIRjI6WtI2Hp+HEyxyh22n8vf67lJxQ5yrpt3cSlEDDbvtNoNqDDCpgsMLEnz4sGSeh3KGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6mBbqrA; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6mBbqrA"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-82478760557so2035333a34.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122344; x=1792727144; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/V8rc4CjnNbzKk1bJzDBVlS/8f2AkkYVi/FGYi/KHc=;
        b=R6mBbqrA+ki/phn+ERLRF1M14VxiAhblKWLkGnDk6hjCU0Kzu6UduF32xbDtk4IHn+
         zWjqolJyevnR6Q2opgpMQZqDnAeswrhg9SwLR42B4eHuXQgP5WQcu26gunZHf5a/GwlZ
         o98YXLqkyjnLC0Zv4LBoiALTKIiSBDnltvbLKXRLI0WqgLq3GB0ZPHlq7Cga7BedPWgo
         Jp6PIR8JXSBygGjTAnKMf1aMvW1qolRv/9TVwA+yZxztdKeT/wBqSDL4eWu23OBUvMOk
         VLQI1GGTp45vokQgFpQfXTkAOpDXVvMe/cYDmBEOZWkVOTinOnFEHwxTujnCZ2TdWqS4
         763Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122344; x=1792727144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/V8rc4CjnNbzKk1bJzDBVlS/8f2AkkYVi/FGYi/KHc=;
        b=s4k4vJZFaZJUKLB4t94IXXGyJ63mLQ5sHYd8NAf8ThdSO0mJNZxuujRV3ruZIouzLQ
         bGkgPN2FJB4acgMyO5L3dRdJ2ElqPiCnFAhybTPyy30DQgWl6f1HjUCMtcLJ09q6zf3S
         +yM7PfiHlcVSUuoFDVf/cnPiySOzwgtk4hbwCdohMPPB1QLL9wDjhZUR3bSMGqw6xsSl
         Yc3Sh2hFgr1nup/kUlVHY35KtTC0JKomuVA/Z6nlAQ0Aw1qTlCA3d6MGdZjc8B7ACw6t
         yeYZp2bXYpQZL1bN+InsCqcA4nnoSAd3D22+MD0Y5AaiEpYwA8n6rbjDjdGtaj9oQde3
         sEJw==
X-Forwarded-Encrypted: i=1; AKwUvBwLg+nSOZs0N7XynF6sw93N1kMOhzpK5aTPIxRczzmHwTIwulLap50zqPV2GKHr1bLHQgZzUcv6GG+Zr1Q01A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLJpBjIMq1Gat2jXzn064YmxzTG9xjrSr1ZJBn/1Di7HwdGHFUb
	nnJpbBD+GhHzDwJGJqIsEKiVrem3O2J0UhZAHL6GTZqWEYUs3TwyxMOO
X-Gm-Gg: AYBFou0Kqalkb9fw/SWjB2PMFzK2hlfKAdVf29luMunA4xRD+Q4Ue5dorrS39UMOmHG
	eZqRX3/S/z/FoIYaRwrG7qs26Xxcgg17GUdZKf85igLupa0FP6yE7T0amnDvUjGst9rSXslUlda
	yk0cp2hIJYSJ/Ox2nVPwcuna9sLfG2dRVNPHAfn0ZLt8gXPc9SKsGdQi7Otq79oFK8pwkCalpjh
	ROuSPjZU4yIKzCMRy6NsxrJB7yljGZ2msxXxDwTGaLSej64PStA6ZOK1/O+aJH1BufcHALN07i0
	mxPt/69b/xIDdKC2cdlAfSOLH4EEs9MtSJ6NSDYc1yGEh5RYBZPYNTQQGSWCA34KfZuHRhnV1on
	SPts8wrFKL6zDC23JXNujNbed35ROD7WfgAqm925vPzJSGsaaLmDwuMagNf8f5RjP1wPBFDpgoh
	yDb/PcAcj9vQH0k+NZkPh3brKbk6BXQjCCvkT522W/RQeEXiyV/czOX4JrMmm45Hg2uXu9+mNB3
	OsAHJFyNqxoRJ6lF79jVxKd2jxE1ee/UD2SmqejH0UoEgcS8O3w8FjlMpbc2hcVGv8fnq8D0FVL
	rO/zSdYeHmMYYpl/Nz+RtdOq/8tZncbRuyQ89vy/wVNQw24YBiVmN6Ny1cuVVmElF9WScdk8HlP
	w6KvPNzaQ6i3WTP1UmXyJ8w==
X-Received: by 2002:a05:6830:6816:b0:7fa:ac4f:79d with SMTP id 46e09a7af769-83097c62d97mr22209672a34.25.1792122344353;
        Thu, 15 Oct 2026 20:45:44 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm834402a34.0.2026.10.15.20.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 21:45:25 -0600
Subject: [PATCH v8 10/17] mtd: rawnand: sunxi: use page reads to reposition
 small-page NAND
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-10-8ba4881fbee8@gmail.com>
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
index 9f03ba22b4b7..34c1c5037b11 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1061,6 +1061,16 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
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
@@ -1069,7 +1079,7 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
 				       unsigned int user_data_sz,
-				       unsigned int *max_bitflips)
+				       unsigned int *max_bitflips, int page)
 {
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	unsigned int oob_len = ecc->bytes + user_data_sz;
@@ -1077,13 +1087,12 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 
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
 
@@ -1184,8 +1193,8 @@ static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 		return 0;
 
 	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
-		ret = nand_change_read_column_op(nand, mtd->writesize + offset,
-						 NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, mtd->writesize + offset,
+					    NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -1250,10 +1259,9 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 
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
 
@@ -1289,7 +1297,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		ret = sunxi_nfc_hw_ecc_read_error(nand, read->buf + data_off, data_off,
 						  nand->oob_poi + oob_off,
 						  mtd->writesize + oob_off, user_data_sz,
-						  &read->max_bitflips);
+						  &read->max_bitflips, read->page);
 		if (ret < 0)
 			return ret;
 		if (ret)
@@ -1329,7 +1337,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	int ret;
 
 	if (*cur_off != data_off) {
-		ret = nand_change_read_column_op(nand, data_off, NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, data_off, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -1339,7 +1347,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 		return ret;
 
 	if (data_off + ecc->size != oob_off) {
-		ret = nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, oob_off, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -2312,7 +2320,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
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

