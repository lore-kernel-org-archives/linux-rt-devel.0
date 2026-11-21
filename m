Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223469;
	b=gwmyjVtDMfbIKIL3KK5/B0pSavlQY1vqmU0jZN6tgDIPtSYaL3svK/I3+hQKyXzuoGrG
	 +sdfTu4Qv3SvE8Elmuy41gQiFIhBgc5baxTbpFfhJbvh59sAvEKe1hS84KlFlvkHgZvMg
	 aSDyhzb2uADaIrIXBdNb8wQITt5bpzgCF1OukRRZq2gmV0mI+NOk/AGm8h6hiO2CbGQ+p
	 K4j/Pl+Pw3kmGnud/7CDzcMGVYG2MHMN6I1fRPYqJlHBJbiNvupgUlJKug33Y57WXZoKJ
	 +CHz1iJerGMEmLVkPINUS/E/DtXcfd2wgMNpuZ9dm6GIgW4+hPBkADmZoy7BPd2L9+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tDxDnDKQmgOhb7t9CqFuoW8PN9zlg37X4nU+lrooV8U=;
	b=Wu397EcADBow56VqlMKTy2yQheJ3G4dnVaz7FPhM1zbMIAY1wGj87LRXf1/W+g4Skos5
	 6443/4r2GezV7jneVZPccEa4HdyLCUFOmGW+ZHWrOs5DaKxgwVrpCRhnby0l4vWyB1cQS
	 A6TxD9KnF9IiHq2Ut8YcWvbZMRrZPsW4FXkBP+umUkj1Yn6FAITSQ6gU1GdgfR7a/91u6
	 /lNki8pej4Z0lOBhmI/ezzoyIRCfipCYc7aJKvlAGZo0qcLxSJfuQUeKZRiR20ZXNeKVT
	 x9j365JMXP51j0oDAclRy5hZFmXmXnI7OWC/dyljhmkq88pUKYOVg5Ur1h6Tku5h7gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMFVrnH9;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ACB60A262D
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5ACB60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMFVrnH9
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-571eb508e44so785237b6e.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223466; x=1795828266; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDxDnDKQmgOhb7t9CqFuoW8PN9zlg37X4nU+lrooV8U=;
        b=SMFVrnH9geXlGcUq9vlrHJItm1hCYOoU4tgyw1Qo5RhbX71LsTlR0GlPNHS+LMTwVo
         ckWcvuSwjWXOl0lfcGXzriG1BjfYgbWpUFJDSJHV7/hCC3Dp931ceImxAMfq+V/2ZLOa
         umgUAn9gAh3RJRMJDLZf+1zGGpImPOLjGf6TmWVywLUJ3mIOijoDzVT7rVWSvwyDcWf7
         d0hzQeclAq4KNO+A5iTt0ld2csiHQWeA10jTTvIj/XR1IfhpIaQo77sYmcfWal1vJ8lV
         WxTn05S20gdfMCGwBu/yhHBAO9KUNwKdDo7luqbvaEEV5CTShlnjy+UvfHn7XcX1xcb/
         Cq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223466; x=1795828266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDxDnDKQmgOhb7t9CqFuoW8PN9zlg37X4nU+lrooV8U=;
        b=sXBOB10L6OfEvcXHB/MS5Ge8LIjKZtP89KYM3WeSCAFbOfwreoslP4QK5+QYHq6o6z
         mEEJTGY+OWvnmpq/6MVA14Tjr9Kswt7vQ5Qg1H+XQCwIDS29yJwlz0vDOZK4V2Xe9xsZ
         w7Y3Ioa5UlQJYrg2FHpuF1bo+CiDhj3FV8OOxhtceAyqQd0g1N0V1mNDB51bxfIvkyzU
         12VHYqcW1W0HC+ODeSPcCquV2wpSa4ITacZtZBHIcbAirbOtJd6vjZ0em2NGq50cPRJd
         zrYgpsvEEFBR7orNDoqBEGP+h3FL/4/ESH/iii7L2CnuSgIywFb6uBNj2bDkb/6lJ2UQ
         Gfvw==
X-Forwarded-Encrypted: i=1; AL+hErH+TqDtqz6z7U3HRh47yMaEkYhflVuMhd9qplFVCl4RwD5DwB4wyzvZ9lnDahD41gf2GTzPX8cj61uoqwoJqw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9nNgcsjW1TvyF98yuEbGILsOhZ12VFXaUWI2Vwn9sth/083C8d
	ogJuYovZWyjw+Vz0CZsNlU6aW9FI6Q3W18Cz7snFmuKN4/3NwhgwLdNg
X-Gm-Gg: AYBFou2Q0RUrA+WErY6Y8u49R/QKGZRLUpCXywue75qBznnehzSSas+WuV5SOywQ1vd
	aui0ilGb9mKR3hKo7uX83wigS6QlC0Rbgdw9KtRRpfvC4XhpmXIOdVipiqMj545rwqskYI1q/jI
	/tlCb1mm31rSrIwdrqyYjakEsSpoAeegdZ/D+qVTqjpnspE2Lf3x+UZyz5qgrmnoZcsl08a3p6D
	WzNDzzLq7+rhI3wVEEMaIkt0gkpen5I2Nq7o7BKLTAr4HUyK8yEc+GyWBFjCEy/vyZBgUuRO8GI
	MqOLQzzs4u81NhXcbDfXdZPgLcYkLdmBe08H/zQz/4tXX6SLYq+rD42llec3K9A/m45oS+nh5ly
	ssH1Bku4OscyehqzeVSQjmkHjrT3JjHv5Z4OeljJqApuysBukcQgcig6ex3VplBRaqZHNtXpFKA
	85BSJPiCnLcYZHOeOSD/6lREx5jcPBybNWQhXRKOZxXKNMd0ZjGkQz+czTgWZH54KMMbryWT+99
	nwaVKJ9CZqOsOLFfRcVwTgU8VRB+3eEfQLFf1lZ1k9M3w2+XN85Pu9IqHU71X42jbEKvvXYf4NX
	3ueHMvs48h3Gj65Hv5+pz26mWhQmmtlfSus2EpGahq/JVEnx39dNdGO5pzqxZhL8Q7D3uWNgJvt
	9kvn7tTEWD6qmeld90PY+BXy8usNJugi8zpOzKTlmALDjUhRgE1ad/ZlG1NlKx56rLYV050Y1+r
	OEn751OGkYVxGayzs45wwrOQHBePoBOp9c2FIoR5GBPMr6+9EN5oM1
X-Received: by 2002:a05:6808:244c:b0:557:4340:4d47 with SMTP id 5614622812f47-57a09400d0amr6720622b6e.35.1795223465752;
        Fri, 20 Nov 2026 17:11:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:30 -0700
Subject: [PATCH v11 07/26] mtd: rawnand: sunxi: propagate page-setup and
 erased-check errors
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-7-9721b1905ef4@gmail.com>
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

If the NAND read command or ready wait times out, an ECC read can report
success with stale data: the callbacks ignore the error from
nand_read_page_op() and continue with the page transfer. Return the
setup error before starting PIO or DMA.

After an ECC error, the driver checks the physical data and OOB for
an erased chunk. It rereads main data if scrambling was enabled and
always rereads OOB. If either reread fails, propagate that error
instead of checking stale data or counting a transport failure as an
ECC result. Leave uncorrectable media errors in the ECC statistics
for the NAND core's normal retry handling.

Route PIO read errors through ECC disable. DMA has already released its
transfer resources before interpreting the results, and its caller
retries a failed read in PIO. Restore the corrected/failed counters from
before that DMA attempt so earlier steps are not counted again by the
retry; leave bad-block counters unchanged.

Fixes: 97d90da8a886 ("mtd: nand: provide several helpers to do common NAND operations")
Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 45 ++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9d7e3e6f22b2..c5e429318de2 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1120,11 +1120,16 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 	int ret;
 
 	/* Check the physical representation for bitflips in erased pages. */
-	if (nand->options & NAND_NEED_SCRAMBLING)
-		sunxi_nfc_read_column(nand, read->page, data_off, data, ecc->size);
+	if (nand->options & NAND_NEED_SCRAMBLING) {
+		ret = sunxi_nfc_read_column(nand, read->page, data_off, data, ecc->size);
+		if (ret)
+			return ret;
+	}
 
-	sunxi_nfc_read_column(nand, read->page, nand_to_mtd(nand)->writesize + oob_off,
-			      oob, oob_len);
+	ret = sunxi_nfc_read_column(nand, read->page, nand_to_mtd(nand)->writesize + oob_off,
+				    oob, oob_len);
+	if (ret)
+		return ret;
 
 	ret = nand_check_erased_ecc_chunk(data, ecc->size, oob, oob_len, NULL, 0,
 					  ecc->strength);
@@ -1308,6 +1313,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	struct sunxi_nfc_ecc_read read = {
 		.buf = buf,
@@ -1315,6 +1321,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 		.oob_required = oob_required,
 		.dma = true,
 	};
+	unsigned int corrected = mtd->ecc_stats.corrected;
+	unsigned int failed = mtd->ecc_stats.failed;
 	struct scatterlist sg;
 	int ret, i;
 	u32 status, pattern_found, wait;
@@ -1366,9 +1374,19 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 	ret = sunxi_nfc_oob_read_batch(nand, &read, status, pattern_found,
 				       0, nchunks);
 	if (ret)
-		return ret;
+		goto err_stats;
 
-	return sunxi_nfc_oob_finish_read(nand, &read, NULL);
+	ret = sunxi_nfc_oob_finish_read(nand, &read, NULL);
+	if (ret < 0)
+		goto err_stats;
+
+	return ret;
+
+err_stats:
+	/* The caller retries the whole read in PIO mode. */
+	mtd->ecc_stats.corrected = corrected;
+	mtd->ecc_stats.failed = failed;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
@@ -1453,7 +1471,9 @@ static int sunxi_nfc_hw_ecc_read_chunks_pio(struct nand_chip *nand, u8 *buf,
 	};
 	int ret, step, cur_off = 0;
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1461,10 +1481,11 @@ static int sunxi_nfc_hw_ecc_read_chunks_pio(struct nand_chip *nand, u8 *buf,
 	for (step = first_step; step < end_step; step++) {
 		ret = sunxi_nfc_hw_ecc_read_chunk(nand, &read, step, &cur_off);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	ret = sunxi_nfc_oob_finish_read(nand, &read, &cur_off);
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
 
 	return ret;
@@ -1482,7 +1503,9 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 {
 	int ret;
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, oob_required, page,
 					       nand->ecc.steps);
@@ -1510,7 +1533,9 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 	int nchunks = DIV_ROUND_UP(data_offs + readlen, nand->ecc.size);
 	int ret;
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, false, page, nchunks);
 	if (ret >= 0)

-- 
2.53.0

