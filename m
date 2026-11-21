Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223485;
	b=ROmN2OK1i2/NqmNbjBvfXlNfDFe6h9Fu6Z9MdYm4F35YKIbtI3FqqLMdxndu8RSTZ1fe
	 y8vTYML0FYBGGo+l/xPc8XvZ+WNmRnmig/kxHaK04ygtSyou4m5mcsJhuAGjHh0OBz4DS
	 gkWsVEQ678hyK9dAvHjxWQIvd1kreNF3SwKnbjfTN88vxaiBZFkx7kpkGpU9x6LACFrjz
	 2s7aqlPWDqAttu+6FVX8kw4uKqqdiUPQCpnnCEErAflfdW/sNCtHJQ9K1w9nkJUZRITBG
	 5TQEGnKAEu62nPY77/G4/n2Gpu8giFojFIhuIGaxjEoZVFhMgp2tPTqfZLWDjNu0/aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9EEb5bdabVEoMSRLLJqgNbBs659DuSJGBxR5aYGgxzc=;
	b=XTUBKLhlVpUEmRG6zPooC9xTaFifA+8iEtrVBsePNAriZEqcvFWKMqpimEDhBk6VTYpc
	 T4n8fIY6lXqcOi4TMiixuJbeR/4j7Z+zmWODsQrgw0KfeVu3C+HuN5Pf+Hoqiv6RhwUv+
	 HfOmkqZrz+RCcJbm5eteDCOE1J7cIyl5EeQ6Ai9UiNbvsb6FbGQ9TsDT4v1ZY5nyHWNIw
	 IL9srthQc18LnTklZzZMscmuOA+1ZzyEBxYU0qMW4DalnNd/2S7PFWNIV3y2SphdRkzwF
	 7UhCOUVftQy+mpFD6LDk54TXo1J5kOVaEz//R3Uo6D7E/05uILQ8R1q8AZ89W5iO2HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SmH7VPWq;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3D60A263D
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91E3D60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SmH7VPWq
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53ec2cc397aso981314b6e.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223478; x=1795828278; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EEb5bdabVEoMSRLLJqgNbBs659DuSJGBxR5aYGgxzc=;
        b=SmH7VPWq3yajKfahPou/akdqOJPLf+ZquBJdORd61zI3kjtZX0R3U2ndD3j6VccdwT
         jgGTcC4SYcGEG9MKxyyWOBcZQI+Yy+ccMvL4JMYvYmmDfLXJBVZziVCYSgNpy6lFEcCO
         FglYxGhlJF+bkWXuZnHiWvBsuN69zOM0Oi6HqkFVUVTVBaeQwXhzmvbBrw9rjwfxK968
         swVCiyAV++gDramaIVmod/sXP38TY5u34BHlXju2HvgbAtUM9YLflGRU5bbXs4ML2hMn
         cWC6mm1H/XTXVRpMO1HNFdgHxMiVaeHa+OhENKF1vs30L4SHLhwCHT23NVBC2Us3u+xj
         ejgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223478; x=1795828278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9EEb5bdabVEoMSRLLJqgNbBs659DuSJGBxR5aYGgxzc=;
        b=WtbpvEEPMuahllCpLWCgYc3Wi9mH4T6LgMop9TqLVK320vKN84ix2ASiELkU3Zq66C
         IUoZIDZRj2jK9caLDFyHQ2M5Ts4OsAvX4H2eHTgB0DfxBXKsCGEzmY2omKcJraLqia7d
         czKV1ReKUGhkXVC1LcwOEahRk6Cd/UrgciNyEoHc4vsAVwP46ImxTTxllsJtTsWxjhsI
         uO+8buR0S3kfRNAMICaFYEX6oPYJQ2nLAFIfZeQcp/Ivm/U3iekRlQn0CxE8oilvhwbw
         KbF3ziOC8ImcfySbm2tYJhoDCG5knhk/2IYQb7Bp7U7LVbnnSFCOCypEwvQtdCCr0X+1
         NS5g==
X-Forwarded-Encrypted: i=1; AL+hErEu38SHxgfyg+uAkRYIrzb0Dmh1pvDZLkMhUFNzjK34iC2KOqssbfFJ/h9R136Gczz5ld8sUogII5MskllViw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+eV2unEnQb4tzvEU28WLUOQyQdckLLMc+pEnQrG5tMKlR1Ens9
	P6eAPnpVHSQ5T+6X3N2oVky6HK4A8EV+XP4vQq+tm1w7k+XIrXPBSlxr
X-Gm-Gg: AYBFou1zbmmAdvQWLlwYMQRqWT80sru0xFw+tMbZzEKjUbrixpZcbY3gMfPpfI7id/J
	zXYoAQYau1FcCDiwT9NMiQxMtfQPFL+kMEND1VAtuUg812IBcoxXaXHfR9aafww7bkKAoqSci5d
	n4XdYV9Oy56nQjnLvc7HAO/6nAgAIsP8uVyDu1H/Lg5OdP3mGdoJsT4UPhGn4aEHYboNaM4LFCR
	YrHdfT+ETc19YQ68wrqnr2kLoEzJ/aOF8jmJxs0fTbIhYtVyOmSIrX3zOiJM6d2prm6yW9nINJF
	XZETL02mzdKj3l/pOt3+xSKBhBZDDqmUIripxVOI7DwLJ40jrlnsk8Ic1u+aAPVlkRRhKsjMklw
	Z/bjDqtA6ZBfg0G4LfTNQiG9nR7Lu9Y21dfv1i3fIoY7J5Nw7K3WYhQpcdaHOxvD49M8v2ahA0n
	Bkg39nL+6vyLBJw82om0V3prAHEuxQ0VdheqvIs6DfEPkmv4VGkeWUezbLwKk+KOVs7s87Cn48R
	X4LY6CPBMFvCh9Y+hcKeg+076CX7LYWw2x/IHQjVTZYm9Xnnx9a82IehCn1APaEmmKC4KeM67l6
	/WIFOu18JmyZbuDmfcSt6rS8y3LF0NwlsTghQgkrh3jAIG2rO2z8amrBvnOwci9rcRZNwYnbtQO
	FDe81TaxT/AozDqNIl00jO6JsweWt2TEsdMP07ClUu83Z+unw7JAewFvvYBmFYH2oboNFpBCQSU
	ZHLKvxHPlaWScHbW8YDL4XFr6N/49zMab23SZ1URqedvxSjdI2HSIV
X-Received: by 2002:a05:6808:4f06:b0:53a:9d3c:caad with SMTP id 5614622812f47-57a0a4079a5mr6188187b6e.25.1795223478418;
        Fri, 20 Nov 2026 17:11:18 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:39 -0700
Subject: [PATCH v11 16/26] mtd: rawnand: sunxi: limit DMA subpage ECC
 results to the requested range
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-16-9721b1905ef4@gmail.com>
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

A read of part of a NAND page can return -EBADMSG even when every ECC
step covering the requested bytes is readable. The DMA path transfers
from the start of the page and accounts for errors in that entire
prefix. An uncorrectable error in an earlier step therefore increments
the failure count that the NAND core checks for this read. Corrections
in earlier steps can likewise inflate the reported bitflip count.

Keep the DMA transfer unchanged, but only process ECC results and
perform raw erased-chunk checks for steps overlapping the request.
Keep hardware slots and user-data register indices relative to the start
of each transferred batch.

Fixes: 2de85e733601 ("mtd: nand: sunxi: Actually use DMA for subpage reads")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 7f93ce226f24..5415ac6960b4 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1106,6 +1106,7 @@ static int sunxi_nfc_read_column(struct nand_chip *nand, int page,
 struct sunxi_nfc_ecc_read {
 	u8 *buf;
 	int page;
+	int first_req_step;
 	unsigned int max_bitflips;
 	bool oob_required;
 	bool dma;
@@ -1234,6 +1235,9 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		int bitflips;
 
 		user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
+		if (step < read->first_req_step)
+			continue;
+
 		if (status & NFC_ECC_ERR(slot)) {
 			/* Preserve PIO data before the raw erased-page check. */
 			if (!read->dma && !randomized)
@@ -1294,7 +1298,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 	for (slot = 0; slot < nsteps; slot++) {
 		int step = first_step + slot;
 
-		if (!(status & NFC_ECC_ERR(slot)))
+		if (step < read->first_req_step || !(status & NFC_ECC_ERR(slot)))
 			continue;
 
 		ret = sunxi_nfc_hw_ecc_read_error(nand, read, step);
@@ -1451,12 +1455,14 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 }
 
 static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
-					    int oob_required, int page, int nchunks)
+					    int oob_required, int page,
+					    int first_req_step, int end_step)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct sunxi_nfc_ecc_read read = {
 		.buf = buf,
 		.page = page,
+		.first_req_step = first_req_step,
 		.oob_required = oob_required,
 		.dma = true,
 	};
@@ -1464,8 +1470,9 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
 	unsigned int failed = mtd->ecc_stats.failed;
 	int first_step, batch_steps, ret;
 
-	for (first_step = 0; first_step < nchunks; first_step += batch_steps) {
-		batch_steps = sunxi_nfc_dma_batch_steps(nand, first_step, nchunks);
+	/* PAGE_OP transfers a prefix; only the requested steps contribute ECC results. */
+	for (first_step = 0; first_step < end_step; first_step += batch_steps) {
+		batch_steps = sunxi_nfc_dma_batch_steps(nand, first_step, end_step);
 		ret = sunxi_nfc_hw_ecc_read_batch_dma(nand, &read, first_step, batch_steps);
 		if (ret)
 			goto err_stats;
@@ -1618,7 +1625,7 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 	if (ret)
 		return ret;
 
-	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, oob_required, page,
+	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, oob_required, page, 0,
 					       nand->ecc.steps);
 	if (ret >= 0)
 		return ret;
@@ -1641,14 +1648,15 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 					     u32 data_offs, u32 readlen,
 					     u8 *buf, int page)
 {
-	int nchunks = DIV_ROUND_UP(data_offs + readlen, nand->ecc.size);
+	int first_step = data_offs / nand->ecc.size;
+	int end_step = DIV_ROUND_UP(data_offs + readlen, nand->ecc.size);
 	int ret;
 
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
 
-	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, false, page, nchunks);
+	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, false, page, first_step, end_step);
 	if (ret >= 0)
 		return ret;
 

-- 
2.53.0

