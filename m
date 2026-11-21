Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223478;
	b=aCVAqdP3lFkbVZcyQu7idKflMUMcf3MhYQVjAu3+nj5VDFRkfTiZDE6VCks8AoK9Tvqf
	 tVRv9pLeUIYJCMmE88PxcxKSUSyTK5eF6nrkzj9Qm5q5+TniDFWcIcu8HrSJoS+BDfl8P
	 jpriG4+rA8VCwYv4amO6E03m7mk46KIUU93dlRcB0GhdWu24iIG54S2BE069wduu8gABB
	 V1rQwM7DeTX3poLGezLDmlPFy9OAECiHjsOEs8wKOEXf+qbhoCTLnGmLtWlbbb80v9VH1
	 6KS+fmQXQBb3VE8USUlZLYEmkG+lgBvrndMS33kfpQ73d+tnbg8KfjTQn5K6f4xfcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=V/ZOEZdBIX9Ht5ZtaAIcNRRvXcoTuAbgmishigtjssc=;
	b=UZbEj+sIGyH+roY8wbzFY4GCDz3+7puLgNFI6tE5NJBM3AAN+Sfa5l1BtreEiJZT9hRR
	 8AE4Vqw1AVJzF/uAzYvshmmX8zSmYVC6ygmWO+9o8US5fOdtdQQy5EMFg72rZOJ8CzPq6
	 2pMxpkAKcw/WlxzZvRDBkQv2EHfCoq/H7uaxbmdbrqpYF21E9v4B3XrEakaDHvQjBpOHq
	 MGJQRC183c8b6niZ6C6loQla+DeDIFB4mYc8jukXANk0edWDmQtcpn51F9TdvJgQTm7/b
	 KT220vStlQLd1YWcswxiFjzF7nLXpifraFY3pHwtPfOuH03hUcMQ5mknRcG82lNbpeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4aJI0Jc;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973460A5BCC
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5973460A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4aJI0Jc
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-53c156ba662so884515b6e.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223474; x=1795828274; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/ZOEZdBIX9Ht5ZtaAIcNRRvXcoTuAbgmishigtjssc=;
        b=v4aJI0JcfuEB8CsSkCsuUjD3GgUkXBC0u/cHK6Mwl+TgrdNiQMG/iriB1SoWIGzDMD
         +dXGvTtLb+pEWw4ms2U/ko+fua2BSTXMV0P8pl8roVyiMjlTorIEfDrzqr6JxQ5n7JWS
         H8kKiAPMzN2FyophA5BNTV9FQRoyJM2YL5a4FDn+7xBwvIL2zmPj1vbK6PR8sxgodvxc
         TSDZcHesNUcDUgeB+Gon6jAQOKcBBZoKAtcPQDGI+ZTpRK6HYYnpaXYj2m6TBgSfc0tI
         p/HAcrKmgRrFzCEOEioyyF2LT+QetIw+i+dibLGPVEsmqUwDFQ2UxLFxa/eJ2dvKHe8C
         m+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223474; x=1795828274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/ZOEZdBIX9Ht5ZtaAIcNRRvXcoTuAbgmishigtjssc=;
        b=xt3FyEHJ3Ejej+t6bzcjg5M5Xyt6VBvo9uHZqH2fDVuhDDpiqrX0Kei+sSORpLddvA
         sTgIx6+CdE/viIdXOnZeQeBizkjOabFjaWvfvpFccCx2c2byD2PAijyP1Xpq/2jTUqHI
         p8Lre7xPcq/dUuHtt8ZENyNOvKN9+e29xwGcI2U89q6FMfeOLbCWZ600+5gFCygGW+IZ
         VhMD/P2Saj/gpeKrOgriCkGYRUPPVJJ4jp7sYahtSIppKMVBVpHjha0I9tHvIUmM3cM9
         hTPE1KcUYt8wQi1bzOIsNmYotHZBFX2USq4ScDA+Iaf9M7824HzTPe5iUt/kLl/wOPUY
         +uxw==
X-Forwarded-Encrypted: i=1; AL+hErF/gWGgcpMllPWCfCfjfSp7Pyu817LoXVTpP7fQfwenud+c1s47bq8sRtz2YczWhjNlYH8t8KkWZzsxSjsKnQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Jyp/7fIMkDSwHBrkiLFv2JHqkJI6VH3gvGLwfEooWE+vMDc10
	54qjCgyApa03e4U92W2HXuSCeX1BS+x1zVlQ+uF2aeR++XQKcuxAyw8l
X-Gm-Gg: AYBFou3MzhBaAuFSabnAPEwzE1wtDTipS+9HnR1GtJOrLPp87oqzcfo6cSV8VGP+OFi
	ThAFGP+kEmf25X/wmViV2ooFxDfccGxoRTePeQbwetAuDAmjWqkM8CuSU8RrUGPQd90068MvplF
	tl2X6bjtrebgHpNvfkmKczzsCQD9afKkHcWU+uG49kVIcWplv0b7XujI9GaAgFeGc+wsT9wmAIy
	BxVJ/5ADxx4/haG2009OIC03IzGxZzsx4eC8VBgbd/FpLmGBhUk7dtpWKGe3p2BNU1zWEQqjLHY
	EAaTH0HXnuvTDF1ABY2VbhPZT0BnIJAE1XxoA6BROOZE1lPu2kflwTaSXCpI0K/y9Df9Fbryu2T
	HtuLXLTatxT/8+FtGmDFwuwqaxjK6IGac+G17LdGmAfUeQyzv+BlfC1JpGeA8q8Pn3iZ0IbmntS
	5nRoeIb3ypThkkjQNKKNab4gMy+MPlyYub0jvIlA8in6BJ/oVHemzOY1Jj1xvVR/qr+hkV7Hoo7
	nWpPwzERJwY4TMXNPVxRKL8BmMy5C3mrpPpmvXWkpCQKZRI6FWS+tdvO5zFr5xoMxn4/pX0g+ym
	8DPL1CIgEwwgZ3Z6DBlN/GdK2hXe7kBap9XBeiYwKuvjntYZ5sRoY8Hvzppdg3rvYpzn3sKZmXL
	/PhJxzpmHMdWO8xNmMau04SpwoPHk4v7bv8BVQfPC5GKjgapCH1+9TwvGlRggg7buLqlsEM7OBK
	IkcL8r66TbGssVwr4pi0BpZ2voJqbpnlL7fuVwmkPOLdNseLcpSgcA
X-Received: by 2002:a05:6808:130a:b0:573:7a6b:f32c with SMTP id 5614622812f47-57a0c4b923bmr5275123b6e.50.1795223474187;
        Fri, 20 Nov 2026 17:11:14 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:13 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:36 -0700
Subject: [PATCH v11 13/26] mtd: rawnand: sunxi: propagate buffer and column
 transfer errors
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-13-9721b1905ef4@gmail.com>
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

A NAND read can report success with missing bytes or bytes from the
wrong column. A write can send PAGEPROG after transferring only part
of the intended data. The SRAM transfer helpers stop on a FIFO or
completion timeout but return no status, and the hardware-ECC paths
ignore some column-change errors, including when fetching OOB after
DMA.

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
Compare the tracked write column against the absolute column of the
OOB tail. Otherwise a small-page PIO write that has already reached the
right column would now fail on an unnecessary change-column command.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 175 +++++++++++++++++++++++++-------------
 1 file changed, 117 insertions(+), 58 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index e76f7cc67081..712648864407 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -663,7 +663,7 @@ static int sunxi_nfc_buf_chunk_size(struct sunxi_nfc *nfc, int len)
 	return min(len, nfc->caps->sram_size);
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
@@ -1135,31 +1147,39 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 	return 0;
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
-		sunxi_nfc_read_column(nand, page, mtd->writesize + offset,
-				      NULL, 0);
+	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
+		ret = sunxi_nfc_read_column(nand, page, mtd->writesize + offset,
+					    NULL, 0);
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
@@ -1212,15 +1232,22 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		if (read->oob_required) {
 			/* Keep the existing PIO and DMA representations of parity. */
 			if (read->dma) {
-				sunxi_nfc_read_column(nand, read->page,
-						      mtd->writesize + oob_off,
-						      oob, ecc->bytes + user_data_sz);
+				ret = sunxi_nfc_read_column(nand, read->page,
+							    mtd->writesize + oob_off,
+							    oob, ecc->bytes + user_data_sz);
+				if (ret)
+					return ret;
 			} else {
-				sunxi_nfc_read_column(nand, read->page,
-						      mtd->writesize + oob_off, NULL, 0);
-				sunxi_nfc_randomizer_read_buf(nand, oob,
-							      ecc->bytes + user_data_sz,
-							      true, read->page);
+				ret = sunxi_nfc_read_column(nand, read->page,
+							    mtd->writesize + oob_off, NULL, 0);
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
@@ -1251,9 +1278,14 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
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
@@ -1272,13 +1304,21 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	u32 pattern_found;
 	int ret;
 
-	if (*cur_off != data_off)
-		sunxi_nfc_read_column(nand, page, data_off, NULL, 0);
+	if (*cur_off != data_off) {
+		ret = sunxi_nfc_read_column(nand, page, data_off, NULL, 0);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+	ret = sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+	if (ret)
+		return ret;
 
-	if (data_off + ecc->size != oob_off)
-		sunxi_nfc_read_column(nand, page, oob_off, NULL, 0);
+	if (data_off + ecc->size != oob_off) {
+		ret = sunxi_nfc_read_column(nand, page, oob_off, NULL, 0);
+		if (ret)
+			return ret;
+	}
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -1401,13 +1441,21 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
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
@@ -1433,27 +1481,35 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
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
+	if (!cur_off || *cur_off != offset + mtd->writesize) {
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
 
 static int sunxi_nfc_hw_ecc_read_chunks_pio(struct nand_chip *nand, u8 *buf,
@@ -1574,8 +1630,8 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	}
 
 	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
-		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
-						 &cur_off, page);
+		ret = sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
+						       &cur_off, page);
 
 out:
 	sunxi_nfc_hw_ecc_disable(nand);
@@ -1698,10 +1754,13 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
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

