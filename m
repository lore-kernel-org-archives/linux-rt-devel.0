Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904943;
	b=D3J5OgdjWk2PybBF93ewoH1Kk0W10X2PH4PNCj6pUIb0QQ91xe047lfaY9pLVXIMFdi9
	 cgaCUWp5yRRMC/NWr+ERPnnr5IkfgUuRDfYFlq2je3+1nOoFlYC2D1dSRWRi5LwRZop3w
	 O2DDhPTXtGGkmS/qiKTZ9Xdz1qaeps3c+KDKK30SXhGNl+FvaHhAoI4MrsdK/7mdIt9IE
	 df4SaGKDqnHlWPKu+JiHSTic4ldtNobzsuno6to6u72NircQ4dyz7MnGJITfeNFUIWldI
	 sp6ZkfgE+yE3A4e2EsE5DSczWZfXxwDs5xyXAVQJL4Net761nFfzuYjWi3KJQ46c8OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qc1K6dw8YZ5zOMaIssAlpVtWAd8Vswo/yLcW5TaoQ6c=;
	b=n3yNY7Xonq5+MhCNeJ521aMxLnPphJc0cma2OFSyax2ucKWqWn0Foql7W0tNTIMq9VDd
	 2F5kawK0Nh10G/2fVKRyqpQd8Ke3YsI6yYwb/Ofnzj0iCuHmOTteNdD/tt8phs2TlcGBR
	 pLUGnwdDdaQugG+bnVPx2embDj/iYm1BzPV2bredciq7t3S2hG5FFXxOy0YAo65hG35rY
	 mR9djNaWxp/aG7rlkGorgQxq6D3C6VPvsjSe9W/oBdHx7F1gLhOZPuvHE4Wyt+BYUXlD9
	 v4NhiChFeGD/60x0h1cEq1qUrD70Oz03g/ZaTNrrxWJOcDSdtp/S/e3C5q6+7kcKsEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URd4whpt;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36749606D805
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36749606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URd4whpt
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df0b02fe91so631912eaf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904941; x=1794509741; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qc1K6dw8YZ5zOMaIssAlpVtWAd8Vswo/yLcW5TaoQ6c=;
        b=URd4whptvDBUUPfaYFqlSqtPoqO5OEoMk3hhCIOuXGqCe1cd/hMgrhCJRtp+6EB8hv
         tOXfd/HUdazEBbRcuVJr/0aAay9b0h+o/FXTXfHhZPnJ1vgn+fD4VHlhhdoMRPRJudZG
         tOOksMCjUI79K79l/zMrqN4vosWmbN+oLqi6RLaxE6KOkJeASyX4oEHOqhsv0M3/XxhG
         fL9U7FC2YFwU9sQ3NauDhY8nQwBO2VFouEZKiE6ELGqXBI/Z+1lMKs6FPwqF9gGxa8vT
         hptX76pr67uDHUGp1W376lkAxFvBOfB9JJP9tezDaLG5LtqxwWAxc59IwXH4PYd8yVXw
         xTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904941; x=1794509741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qc1K6dw8YZ5zOMaIssAlpVtWAd8Vswo/yLcW5TaoQ6c=;
        b=lAR4wGGXuVuUv/AKzwC+dVKPWv2lQn+jB2JKGTfqOdpGXrBwQ4YCUq9rLdy5ahJcte
         l4hQsj+oB8KQBn66J69V2YLclORkslnAT3kpHEO/iZ5keHB19JfPihRQ2iidqAVBftua
         FB9rYAO2rL3qJTZ9xbpjkM3OLcedQZsszI3nYWVCy5vZxJtyIsRq8zgoIEsZfkahGlVW
         /TP2DaioXOg8HFOE3s1PM0F1c1LjUPnxMUDQV9xTlp88n/EkDfmFelcMAWVnpPmOrqNv
         b50/u0YZ0WvY1TG3SarpKMLh0p3rY74wRSKxtytqpYjyS2hMPlAP9kDo2diVkHhf64aW
         4Ang==
X-Forwarded-Encrypted: i=1; AKwUvBy2RuYysqmAGPEvEK4AG4ym4vApLLc7pAyHn1ixLJ8lG/aMSzEwIt9t142zkygQxobsC7tDwQJa5Z4C2hlYXA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+jPucSQIUm39o/5urLCJKgFnizDIszRln+SGCfl8Kchb0mP7gP
	iYf1AKeYpyCRF4pf0CZbSmcCNs/bj261z28OK7FBPcDGmhoR1vjWfs60
X-Gm-Gg: AYBFou0yHXRGVXD3Yi9maoofcTBmsmhdxQUxKHMmZc4abWctTXzpQZWAZpJUXdHG6th
	HjUqIYHc9pgzAWGImQDzqGjNFqJ/sUnC+K/vq9atEOd808MsFTloIdwFJTrolIDU+JxIxGdq+E2
	B/CT2wIn1r/ngnYQemJ89tIXeMf1B0RbTyKRzCvZvQfpSUNoKrOYfKtx7N8isb7BbVTtQf4NHyx
	kgdJKlRYQCnWsk9wuksbtfOCGeeKRKNPkObk4vnUImS72MZdRmZyrlehE7JhRS2bgW+9B2FGYFA
	jjCPutl6lyer2XmbaMspNEMOtWVkdqzHQiaHxBiJvyQzlM1PD8wHjnUqGK4LiZuX65uGLdy9ytm
	wEBLsbOuNzpIBwgG099+l0fxonsPuvOfsdbJ1kJyfc1BQbUF5VzW6caK4cubv70fj2aD2tBbBiN
	dGdI2HSPFD08HlgWOnlP3qJIkSblAoK5HcIpuK9CvwZcE3rKd/isPC9zDTJK5z7IJebn0gbx3C/
	y7Z0TvqiKem7YUaEEXyenFcX4HYrJYvKtfeUMAmrYzm8oL5GsfTOQftrZzfYiO3msBlWjNQ/Liy
	7uPLm71bwnihXSwcqw4FVBykrkdWeAQL+ap2bw8ha8M3mU/Fm3Wxyq2c3GZb95JfD+drAUA+uET
	Hn8fTiinNYFVvmHtDZ0kFP/51bDq0wXkDMVuwkH1b449t2SsytuQ6S9vIhDEv5GN6bxyGXeoSY6
	A6f69fgNhLO/q1MEQfuHLDzHLux8PqCuyXXLsmmlUWmv0rD3Nve5AY
X-Received: by 2002:a05:6820:c5ce:10b0:716:b936:7cf6 with SMTP id 006d021491bc7-716e73763e0mr260411eaf.4.1793904941072;
        Thu, 05 Nov 2026 10:55:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:39 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:22 -0700
Subject: [PATCH v10 06/26] mtd: rawnand: sunxi: propagate page-setup and
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-6-dca1f6ed29a8@gmail.com>
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
In-Reply-To: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
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
X-Mailer: b4 0.15.2

The ECC read callbacks ignore nand_read_page_op() failures. A command or
ready timeout can therefore leave the requested page unselected, yet the
driver continues with data transfers and can report success for stale
data. Return the setup error before starting PIO or DMA.

After an ECC error, the driver rereads the physical data and OOB with
randomization disabled to distinguish an erased chunk from corrupt data.
Those rereads can also fail. Do not pass stale buffers to
nand_check_erased_ecc_chunk() or count a transport failure as an ECC
result: return the reread error instead. Successful erased checks retain
their existing statistics and correction-count behavior.

Route PIO read errors through ECC disable. DMA has already released its
transfer resources before interpreting the results, and its caller
retries a failed read in PIO. Restore the corrected/failed counters from
before that DMA attempt so earlier steps are not counted again by the
retry; leave bad-block counters unchanged.

These unchecked returns were found by inspecting the read callbacks and
their NAND-operation helpers.

Fixes: 97d90da8a886 ("mtd: nand: provide several helpers to do common NAND operations")
Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index ae18a7fbca77..9a7b365e998e 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1043,7 +1043,10 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 	}
 }
 
-/* Return whether the chunk is erased, and account for its ECC result. */
+/*
+ * Return 1 for an erased chunk or 0 for an uncorrectable chunk, with ECC
+ * statistics updated in either case. Negative values report transport errors.
+ */
 static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
@@ -1055,10 +1058,16 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 	int ret;
 
 	/* Check the physical representation for bitflips in erased pages. */
-	if (nand->options & NAND_NEED_SCRAMBLING)
-		nand_change_read_column_op(nand, data_off, data, ecc->size, false);
+	if (nand->options & NAND_NEED_SCRAMBLING) {
+		ret = nand_change_read_column_op(nand, data_off, data,
+						 ecc->size, false);
+		if (ret)
+			return ret;
+	}
 
-	nand_change_read_column_op(nand, oob_off, oob, oob_len, false);
+	ret = nand_change_read_column_op(nand, oob_off, oob, oob_len, false);
+	if (ret)
+		return ret;
 
 	ret = nand_check_erased_ecc_chunk(data, ecc->size, oob, oob_len, NULL, 0,
 					  ecc->strength);
@@ -1322,6 +1331,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	struct sunxi_nfc_ecc_read read = {
 		.buf = buf,
@@ -1329,6 +1339,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 		.oob_required = oob_required,
 		.dma = true,
 	};
+	unsigned int corrected = mtd->ecc_stats.corrected;
+	unsigned int failed = mtd->ecc_stats.failed;
 	struct scatterlist sg;
 	int ret, i;
 	u32 status, pattern_found, wait;
@@ -1380,9 +1392,19 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 	ret = sunxi_nand->oob_ops->read_batch(nand, &read, status, pattern_found,
 					    0, nchunks);
 	if (ret)
-		return ret;
+		goto err_stats;
+
+	ret = sunxi_nand->oob_ops->finish_read(nand, &read, NULL);
+	if (ret < 0)
+		goto err_stats;
+
+	return ret;
 
-	return sunxi_nand->oob_ops->finish_read(nand, &read, NULL);
+err_stats:
+	/* The caller retries the whole read in PIO mode. */
+	mtd->ecc_stats.corrected = corrected;
+	mtd->ecc_stats.failed = failed;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
@@ -1468,7 +1490,9 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 	};
 	int ret, i, cur_off = 0;
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1476,10 +1500,11 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 	for (i = 0; i < ecc->steps; i++) {
 		ret = sunxi_nfc_hw_ecc_read_chunk(nand, &read, i, &cur_off);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	ret = sunxi_nand->oob_ops->finish_read(nand, &read, &cur_off);
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
 
 	return ret;
@@ -1490,7 +1515,9 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 {
 	int ret;
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, oob_required, page,
 					       nand->ecc.steps);
@@ -1513,7 +1540,9 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	};
 	int ret, i, cur_off = 0;
 
-	nand_read_page_op(nand, page, 0, NULL, 0);
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1522,10 +1551,11 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	     i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
 		ret = sunxi_nfc_hw_ecc_read_chunk(nand, &read, i, &cur_off);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	ret = read.max_bitflips;
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
 
 	return ret;
@@ -1538,7 +1568,9 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
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

