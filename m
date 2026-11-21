Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223489;
	b=RhDF4WsprscbToWCoicGrYx5+3QBP2HB7dI6/DySLO78y9U1XFNZcJPuJUt76cn9rnXG
	 gauSVYkDh9FsQCOlX7Tr45Cs8BjT9gnS2wqmFI5sJxma8N3T/aWcdwWFXybzAKuKpR7N4
	 ZzQv7xT11z2DB+MQ6OyYc9ZZ9diu8iOkk4beNnS/f99chJVtB6LFsLUSAyNH/qK5/H/ko
	 hMYscho3M80AoN7r4xiL4JwibXOszISrUV1JjRJqebDyG08iGo7EFTmBDdmt2R61ydWRM
	 FIbm7Qi4h+WQwbYC6oIlcp7H/SkNE9x3t4MgtjmQbP0OK6SZUSfBd+R9r+uGhDad2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9R93eLtRuVCsdbuGEdtd6/wt6t26wDnU5PW4NiI4F68=;
	b=wMSLdjlW9zgufjtnK8nwL5/BBOjgaDL4bwj2qlQqDKJ9iPZCjT4XWmI/F3DIX8KNDbJL
	 JzlX2wxigXvhotjqAiH0gBxzvFoWXt5XeG4nJnzILe7/iOrixeVo4j46FKf+PnOMTVpiy
	 cgwPdqARGjLkhtN6PIKL90u4/JaWenZ591FrCrc7v4+mtUkaEfGAA8ZaPlQctNknB4O89
	 X0/l/u1h8JetW/N8RD2ESDEHvI+rc98dcX/Iv6SjnCTiMsklWzxsaVYq1E2AU1SRnUIT/
	 9XDiAYIhSgSQKyH2VRhCBsK9hv2zV4qWQL/gmzT736YBtKykLyhSu6bODTtfxNseSuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KDZeBMxV;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157160A6F6E
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8157160A6F6E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KDZeBMxV
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53dda625f63so913215b6e.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223482; x=1795828282; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9R93eLtRuVCsdbuGEdtd6/wt6t26wDnU5PW4NiI4F68=;
        b=KDZeBMxVEx4HoN7YujL7aEiUWU7miU0Un2hTrwuZn4evmr7NYmxTM/gSP+okWfRpy7
         bAfO2EKdMy7g5taV0Bfzzu1Q6xGaJWwUzZl/neUD79g4CKK5iCMD7gN/0ZWlkaiV9bqF
         /iW0UhKTbtHD45LOyikM5BtkuTLaNnpaGZeAvhtSbt2JNBui2QmtNz1+VsdwV2N6Kb3d
         EUGBntHm77Sk9RWC5tu0r8ymblFHFzocnNWofDeqx14T7iiQ/QHuIcIshsgRhmSL8TSS
         6wNsdj8lKDiTaxxkAeQ8rQBXx8a9tawmWrXER1R3s73iXQuIe83Hl3oxJ5kKZICgUFfE
         C0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223482; x=1795828282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9R93eLtRuVCsdbuGEdtd6/wt6t26wDnU5PW4NiI4F68=;
        b=ymdOjv/o/9VfP3PLYVbzsvt8a/buuqE0vajECQgK0X/KYCPBMa6ozeFyR5hkUUl/B+
         3/WoWZ2MvH3WtGzcGauOfvbN9FcdiPotf/hff5/9vx9Ls6nTI7MlfjJUDyn3z0tpYnCh
         OXLwfbeeaCTJkoP894lN+6xGqhs9WuRx6WxVZpSZ8HEjNE6URlXbMsuL7CNVJiUm+8UU
         INGbc2UmRm1fwPl77EXTFq4lc9Uof37pUb3TZ2ZicObUsWIFvszIbwHhczwfUSRhN20M
         gYWQgJgoK3tecLJis2+Kc7Ck5co2g++FZjZxyLGiYAXgfBkiZ0Kchzqvcz0LfOh1FwZT
         VSmw==
X-Forwarded-Encrypted: i=1; AL+hErHTzDowXGfvNUL83L7d6R34doXIRCw5zxFESPM2yyi4dBdIGURPDP+bPlpBX4JhneTPFFw3MK4p2EFl1YqVXg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3Wr6Ka9Wh5LtWlmu7ZQRji/BM9J/TyG/oyeCQOj6sI+qC74mP
	Wqd5PuXgEyfPkFmIIXSa6zWEooxPfx/mYsBocEYUw2sNewI2d+xZsz4KVMw4XK43
X-Gm-Gg: AYBFou37E5iaQOoBXD8av4WZQ8tj8+wFcceu79tagPzP8TGA22YWlqKhdjRNKrt9e91
	OHe47Dkay/HRrPZiLGpCwvV1I2qKcVRbOd1fZui6IqpceutBPw3nHXjOb1Fr7MUZuDZuz568JL2
	8x2OgC6BaYu3omwao8yRqd1EUPu67Krt4UYQqdCGmVl/gZFXZcHfQx/j/s3EbY8f1hsbFSV208P
	fDoyYdG1Dwfz/Umm78a8pmkf+1EXajrrbLehiLt1MyKtFiDfxPDxpVR62KMfSbej2TyWTkOaSly
	UsjNII8Nz0XQMK82WmekSFXUY2ROz4VcXbeDvLOjv1rGS3WMFxOpv9kVdFEk1NAfDDqLG6HyVdh
	sUW7/lxVc5JvGXIZgP8GfPM8LkGVsf2JcU7/b9AelwedQe+DNiDzGy1veKbIpGIiMh+QN/f3sLr
	14cTk5hS0Lz29csZ4oWpLERpzFddSgF/cICCgWcPeZw211GzQXnGFZQei/1My6gxipfJTGADwwJ
	BGdeG/3nJ9FGYyRiI+9EX4f5H/+c/wEowRMWdBwQEaSa2zcnRYq1fWQ3r6gS5TVlCtybwnYWz6j
	KN9T5wF7Cb+dr97tDnsCXYKZWOJcv+dEeX99WEF9dQ8bi9z0nBSWzUiZC48KOl+CGRJ8wjDlZ/V
	+r9MauGVXGz9qt+Bjn1/ZYO7hzXUvCCXs9L4L/hN2OjHZKol8z5UfydF/HAMQhW9EsScboK1Qqa
	7FY6O51LM3KUtpxhxoYJDTWWFbkNLuKeSJYU1rShqPKzLM+1JAKXWY
X-Received: by 2002:a05:6808:13c5:b0:573:52b1:bb00 with SMTP id 5614622812f47-57a09910c41mr6373784b6e.39.1795223482353;
        Fri, 20 Nov 2026 17:11:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:22 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:42 -0700
Subject: [PATCH v11 19/26] mtd: rawnand: sunxi: propagate chip clock setup
 errors
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-19-9721b1905ef4@gmail.com>
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

If clk_set_rate() fails during chip selection, the next NAND command
can run with timings calculated for a clock rate that was never set.
The driver also caches the requested rate, so selecting the chip again
does not retry the change.

Return the clock error before programming the timings or updating the
cache. Propagate it through exec_op() and the DMA page writer so
neither starts a command at the wrong rate.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index ee68ef9bba33..37cc023db74e 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -628,16 +628,25 @@ static void sunxi_nfc_dma_op_abort(struct sunxi_nfc *nfc)
 		dmaengine_terminate_all(nfc->dmac);
 }
 
-static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
+static int sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_chip_sel *sel;
 	u32 ctl;
+	int ret;
 
 	if (cs >= sunxi_nand->nsels)
-		return;
+		return -EINVAL;
+
+	if (nfc->clk_rate != sunxi_nand->clk_rate) {
+		ret = clk_set_rate(nfc->mod_clk, sunxi_nand->clk_rate);
+		if (ret)
+			return ret;
+
+		nfc->clk_rate = sunxi_nand->clk_rate;
+	}
 
 	ctl = readl(nfc->regs + NFC_REG_CTL) &
 	      ~(NFC_PAGE_SHIFT_MSK | NFC_CE_SEL_MSK | NFC_RB_SEL_MSK | NFC_EN);
@@ -649,14 +658,11 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 
 	writel(mtd->writesize, nfc->regs + NFC_REG_SPARE_AREA(nfc));
 
-	if (nfc->clk_rate != sunxi_nand->clk_rate) {
-		clk_set_rate(nfc->mod_clk, sunxi_nand->clk_rate);
-		nfc->clk_rate = sunxi_nand->clk_rate;
-	}
-
 	writel(sunxi_nand->timing_ctl, nfc->regs + NFC_REG_TIMING_CTL);
 	writel(sunxi_nand->timing_cfg, nfc->regs + NFC_REG_TIMING_CFG);
 	writel(ctl, nfc->regs + NFC_REG_CTL);
+
+	return 0;
 }
 
 static int sunxi_nfc_buf_chunk_size(struct sunxi_nfc *nfc, int len)
@@ -1778,7 +1784,9 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 	u32 wait;
 	int first_step, batch_steps, ret, i;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
+	ret = sunxi_nfc_select_chip(nand, nand->cur_cs);
+	if (ret)
+		return ret;
 
 	for (first_step = 0; first_step < ecc->steps; first_step += batch_steps) {
 		unsigned int reg_index = 0;
@@ -2519,9 +2527,13 @@ static int sunxi_nfc_exec_op(struct nand_chip *nand,
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	const struct nand_op_parser *parser;
+	int ret;
 
-	if (!check_only)
-		sunxi_nfc_select_chip(nand, op->cs);
+	if (!check_only) {
+		ret = sunxi_nfc_select_chip(nand, op->cs);
+		if (ret)
+			return ret;
+	}
 
 	if (sunxi_nand->sels[op->cs].rb >= 0)
 		parser = &sunxi_nfc_op_parser;

-- 
2.53.0

