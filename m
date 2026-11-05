Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904958;
	b=uJQC+vDOoEHeBf4GB9+RPHzNMpS+lNnn5R3QA6QtA1t1mIDMNNoJ+M2f7VJQbzceEWGK
	 S5Uor1euewkYIy3aI2CqSgX7bqxra50s3/iNnPWSd1EYP/uFDoBXwj1OEae7aBDkdWBQG
	 xAa1C94uFC1IzAdE/7HLPwqgjEbfR407qeaCUneQsXFMdUwM8yU62+ufTaaYY2suEZlQN
	 eNZZhG+eCwT+SLoQ/mNQK4q6WSPXynj/cpXbfnIc8GbOFlBs8S+0SNiHZvjiZiqveVdDW
	 DGltG5PWTe953WjjbxW7itcnOeyoEPWLsBLYIQYtxrDheV6OLnGiTrkYTfF+e53vkRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Du4EE64glD0wtWCQ+qs5atx2KYOu7ZM2ZnRx2xMlHc8=;
	b=bDEZaYxV9julfuaiRyt4jp2T015a4OVO2bhnfbssJfX/LUw80iQjYL4uxtaZBZgcXTch
	 JZotiQo2xpbI/JGA4raKD4/K4dShSEgLu+C7qJt5InyJ4HhF9grgFW6t70Z86GAkdLGi4
	 gaySPFoJphktofTkUd1DBGUeSd2N4nJbBK8fFsnc1pPtGSQbvypeZlgTaa5y99DXCsLI8
	 CQFWxctgwJ8RG7n+gmzx3cKDoBgf5Qfe5sSQkyl7v/Xfs9eH3bOdUan8/W6T/BEgF5J/0
	 g3lnPsVJ55MLvvPzpbZYyMwDeyI2l39PQBcp3sKwlVpKe2adSWDOuOhVTlkP8tLoJ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqJyOG6c;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E3606D825
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 931E3606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqJyOG6c
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6dde81a6820so1436671eaf.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904957; x=1794509757; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Du4EE64glD0wtWCQ+qs5atx2KYOu7ZM2ZnRx2xMlHc8=;
        b=UqJyOG6cD19OXImSymO2Q7BQFqNKOWl1H5Qf/4LuJcHj36Mj5SmOxHdlB3A7C/T3oV
         GhWa9zcu60NabvGy/C7VtVI7QNvmHQiF1Nb9dmNc9frvOsMlrirFEcbNv0ZqReIC/KtI
         rVzpDWQgZ6eSwRCuLNR1315PC0btnxFRJJicA2Y4mzEgs6k4oTI5yx9OZUznnaahehzP
         aTlquLjQa+x4+0KHzXbSWUsBonGB2snHmLgEfcR8VZejPdPBj5UKQypFnd/3AuNzHJ/g
         e1I0W/LjiaCDFNX2b238Me968OcAqXF5+IAKXolsC4WFfefbKUD15sDt+tNR2NO9n4ja
         lIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904957; x=1794509757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Du4EE64glD0wtWCQ+qs5atx2KYOu7ZM2ZnRx2xMlHc8=;
        b=aDz2Kwx3ILvLRYbMG89vWIGq2cYh92bsrgP5NMp5jXHHY21MXPvQVw0mkAleR6K9nA
         xYEfFyydaYK8UGj0wSh0bx52RBgvRUFo/XaVOptzVHYbdMz0clDxcwdKCCV9jmxcccHi
         W9rlcnj9AvuwAVSmSYx6RvaX56pxNgtRE/0RfCS+cnqAMieYeiGo9PQZ0A/VDoCItxeO
         v4Z9cDHjhIDhdsbxDXaaCAIBA9za2LtybHsaEx05elnUTCpAdd0k0bGkzRvXO0vqIP/g
         yuHCTLQyselWErtj5aLfkJ8JyEJ8uPMIxkED8e5P1eC+fePWobRuyYzTyb0E74jyBGdj
         tc4A==
X-Forwarded-Encrypted: i=1; AKwUvBxzRMh/QRRL6eTAbdwMOjVCb3zIsobuDdaTOVIo4mSuQIL/Nf+1s2ADc/eIjOTMH9q3U9c7pKovNS5ZsisFBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+eEPKB4Fw4DfMP66Rzswv7/tAs5uz/yPDYeOmm+L//gfr49kh9
	BsmmvrZHABlqW/ViPGV38tQLLM7OJjNqvFYYv/SPRTphYcXTGYSrEE3Q
X-Gm-Gg: AYBFou3xhjXT1ZgKY7ZXelhB0XUq/JJw2D11UyHbM//XiWJzOo/azy1LS+4Vex1luVS
	K+ioz5+QxXdaKbson6i3HSRSkYAHaleZulnOCuNEiTYX6zhgvKFRCuabR9jNDD+NdNqCZsx2yLb
	Besa8Dk6EVimgB1yMrZBKf/gNJ6RiNxeCsy/HM2qclq403PErAaUFE54LwbLjPwCWstNppP7khm
	uHwsqtUWSQr5efYUlwDA7ZbGlRgkxZOF2yHZp3FFfs1rcWyGAPu0CJzBaGDS+UUCTsKT2yEEwoo
	G+TlfnQb5Pc76uXOzrkuELUBl1JFMkJhmAm+whN4smC9xFeTlK9p3wWOdLutvWtxg7T/MD+TFhW
	y2047c2bRsdacklNdIaXf16GPoZD9SjX7ppjKFYy9RctIHz7zefg1LeeQ+YKdUlyYjVC1SP3D6c
	5e5mMY9P5oHTlUZqlZ0l6lxcjNxw8HVUo2j/zsBfml/XY//gEqv38SVyLcWvXxaY0BXmssI5GZd
	9dVq1+xkXS8gA3L843wz2M6Fvk3w/ZT2uG7IA2jfkZfiEZsAprriDB4WzW3HsZEOPgAXMhtPXe8
	trV08FySak2Om3a2pw0pbT48yoNgJvRG2JVxZB3AYzKxiBERRHm3oju5qaQHT896FjakcgTZ6HG
	hmApRZCnf9My0Rjh/g1jM+Ofytaky65SLYrA7Q1o7aZQ592niKwKfGx+n6anwe27CFF6hQ8Dvyi
	uUObrG2GdBWGvsu82zz01hZ9xa1l7WQr8rnencV1g/NY9G4DykBFk7
X-Received: by 2002:a05:6820:a513:20b0:6fc:4051:d2d7 with SMTP id 006d021491bc7-716e78ed246mr305545eaf.38.1793904957427;
        Thu, 05 Nov 2026 10:55:57 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:56 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:32 -0700
Subject: [PATCH v10 16/26] mtd: rawnand: sunxi: propagate chip clock setup
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-16-dca1f6ed29a8@gmail.com>
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

Chip selection ignores clk_set_rate() failures and caches the requested
rate anyway. It then installs timing registers calculated for that rate
and proceeds with the NAND operation. Subsequent selections do not retry
the rate change because the cache already matches the requested rate.

Return the clock error before changing the controller configuration and
update the cached rate only after a successful clock change. Propagate
the error through exec_op() and the DMA page-write path so neither issues
a command with timings for a clock rate that was not installed.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 0b92bbe19c0a..7c80f52c517d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -651,16 +651,25 @@ static void sunxi_nfc_dma_op_abort(struct sunxi_nfc *nfc)
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
@@ -672,14 +681,11 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 
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
@@ -1824,7 +1830,9 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 	u32 wait;
 	int first_step, batch_steps, ret, i;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
+	ret = sunxi_nfc_select_chip(nand, nand->cur_cs);
+	if (ret)
+		return ret;
 
 	for (first_step = 0; first_step < ecc->steps; first_step += batch_steps) {
 		unsigned int reg_index = 0;
@@ -2627,9 +2635,13 @@ static int sunxi_nfc_exec_op(struct nand_chip *nand,
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

