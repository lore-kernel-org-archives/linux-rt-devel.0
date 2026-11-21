Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223495;
	b=KEDFtlzLMp9DtJsDRTyiCY0HYAuz3bvOW97SLRnhmqQYmngc0l94+5bJew8FMS1KdY1A
	 EunYJtyvNiEt4Ui5/3O6497BiOot2fagMjSseX/fzTZ0SbDuxNkC94hAd3B/lVLUlAu//
	 /REPhBQtkj00Id5gRxP9al2At20ZZnnzhyJcDfyQL3X4KQuKGST43d8Sq+5lXhQw5fxYD
	 LgK4p6MzQlXuKd713hn0j7BZfK4ygZoPQ9kq5cSVo7XrfwTuRkBS1ifw5rFSDjooFsJA5
	 cwfNdu+MxWhXKi6Q1ls/Acz0FfLq6jL5w7G8f1T8t0669zU9EjGvfr1bPfBuCQUYR0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3n0HsVfrCilvrywczliXObPQ3Hlxg0mpvZCNssFAoKg=;
	b=bsTAx2X2K9Q88r8QBEsHx7rlk8JGiSsGqAMI2VqPS936EOKA5SVBkZhW+19/AY372DTF
	 IknYYHtANORHmhpam5uO9pVcu2m/ITsst5d+3qhywerEV/M4TXuFp3eq1fg9g/IoeKhI1
	 mE9dmRi7myTViS/HGI84/tu+Lc9GDOXqvq7Ly6GjE2sMdKwERxo89O6zwWcs2qebhZ96v
	 +8+vm6UaFb74G4GgMBp4RuAy3VWxJWnSdgw6grjdELjO+d4X0/mGZn/gTTwkhA0yj1jTQ
	 55mAbmuuNGJIfDsmbPuDr4ALrEKTJNV/huo00xM8NZRLY6cOmgYGmAhv2YxHqVWT4xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/6qSJIa";
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE5606C516
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70FE5606C516
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/6qSJIa
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4af173320f9so954490b6e.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223492; x=1795828292; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3n0HsVfrCilvrywczliXObPQ3Hlxg0mpvZCNssFAoKg=;
        b=c/6qSJIaA1m3ElVZwZ1AP7RuG5lHj/3VH+jeSCq3iEzpVZ3D0fEO3/28iBpkWXlGKo
         8aVeaH6SHj/XN3kZ8mXrg9L5bh1sPjMQnxAEcpXEd7OYXM5vrUz0TcKsJc599NCvjCrd
         Un/ZT9o0eqj/CVZq+Z1UgWKzd+5KAF+3Cr5AUxqH7ccjyOB/sITF1gRjiX8lY15abXYn
         0dunSI6oCdU2mSVT+IlQZn+14GX3FGKqfvVSsHs42nxtlNFA8AgFjhCe0uK0VufZ3VaZ
         WqV6jT/r8HBNo1IXibGp9+SEMfJKSJa5zP7sehzlQiTbICSjJq9EmK6D1zIUiVVAiEhQ
         jI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223492; x=1795828292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3n0HsVfrCilvrywczliXObPQ3Hlxg0mpvZCNssFAoKg=;
        b=Y4UBKGqLYkb0MASZOo+dy2gYWmp8xw0VGTZHrkL2i20IvOVIDK2nt1KkSkEDDLfYMl
         Oivqaw/N3pjHggUaJi05NfsLpKvlBHnEDx0WuOKgZ4IFHg9yjC+GxB904fWM46KBkhiF
         umXEneg2soeSQVK9K7/5vRPv1SEcJ0dn3MFmVVE708zcjkq1R0Ggn7d8r1OzdlBbApnH
         DR04WBy/1o8BRmuFa0EBV7Hh7wy68IN8VqRQq0xQWJwt7x+U9D+EmU7F0tO3HMUUEpq2
         XaUl8RbBYCOJIxj8BkUyagVAw1ftu1zhLXhmtezfupzCob9zMqwsKI4PYgRHiIEG64QZ
         Y2xA==
X-Forwarded-Encrypted: i=1; AL+hErHY0ve0JrEsnyOc3s8AlhyBC4cN76KlgclnBJ4m9q8I4PXbbBNo3IkiLmqTymmZ/JqW7nh5srl04/0qAkA4nw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9tME71diBMDb5PD+xIFun/NwJMBzrFL4jw/YobMrZrz+ZcZuLP
	+c+KMzQhtTyr/dZy0sijOsBKkntMVq7PWvzKOI7l5QtpQRZFYAaF+Kml
X-Gm-Gg: AYBFou3jR/XYyQ14remaG0V8XT/Dg9HgdWrEXOPUIM00J4n28g/Lxlyt63/ZDbEml9H
	77H9iA5doPYU/T5J9CP9ZGh7NNZuYVSuI7ixwGYykurTvw4UFcUFZ1E4u+fJE+x/zUDRflajP4W
	4GnvC4OIicFeb9cdHkoYRv+g6hs+vUODst7d51X+FbN+T4llaC4y4Nl+5SO/PF3epyez/FjkEEK
	br2gpm9HJ/EwkIzch7/6QnP9WtCuOVpo1MxX2aLigGcVUYKx5jOasXMt5ml5+zcdmO2FeSA473E
	3r+MaLN4vbAngUXFVMfEaMSfRx9OQTFfJ8s/k5wTYeSdiHv7ZckjG33Q4R1sYu7gCxuWxs2SXTk
	wDuEIYWpPxDYWC6+iL7pQcbPKdgFtXaF/5M+7f5LvM4i6MvkhDSyng5FqSoJzLt6vFGLTpnmTSB
	W6V1/o+uYP5D75fIo7TVn5RwjxOZvHjdgFpHVjHCcwoQMKQOS8LP7JCE1xsuOhPIX897cudGb7e
	49Lql/g0fxGfijxgaGE8sRYvVfrWI0SczFgdbVm7KHv+zfPOGFyL4Qc0ZMb6D28GVt5kkIuXehP
	u3UbHeECqzgZ/oKwZrsTCkoztb7eCf+VBmVsK0NqVdPlgcn2SjPqRH41/yjtrBgYmF+FParOJdQ
	lft66FXxoMrKVLf2yVQTWJXmgTliGrwQD6DzH59lSrwBNwlfMIEHre6fjmia3Xvt+LZqRTOxetw
	jStnqegbq0xKV5BPT93xRsd//YlCKF3YpIuiO6JjD9AMDheKhGj+qk
X-Received: by 2002:a05:6808:508f:b0:576:1161:cfeb with SMTP id 5614622812f47-57a0d4ed405mr6123275b6e.66.1795223492380;
        Fri, 20 Nov 2026 17:11:32 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:31 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:49 -0700
Subject: [PATCH v11 26/26] mtd: rawnand: sunxi: reduce user-data length
 register accesses
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-26-9721b1905ef4@gmail.com>
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

H6/H616 pack eight ECC steps' user-data length codes into each 32-bit
register. DMA currently clears all these registers, then
read-modify-writes one field per step, repeatedly accessing the same
words. Each code counts four-byte words; zero means no user data.

Build each packed value in memory and write it once per DMA batch,
including zeros for unused slots. Take each length from the batch's
logical step but encode it in the corresponding batch-local hardware
slot. Rewrite every register on each batch rather than caching values
across resets or changes of chip.

Use the same encoder for PIO. Each step writes the first packed word
with only slot zero set, so page setup only needs to clear the other
words. This also clears stale DMA slots before PIO uses the registers.
The lengths and on-flash layout do not change.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 59 ++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 37f01801cf48..31f995a1f5d8 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -57,7 +57,7 @@
 #define NFC_H6_USER_DATA_REGS	32
 #define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
 #define NFC_REG_H6_USER_DATA_LEN 0x0070
-/* A USER_DATA_LEN register can hold the length of 8 USER_DATA registers */
+/* Each USER_DATA_LEN register holds eight 4-bit ECC-step user-data length codes. */
 #define NFC_REG_USER_DATA_LEN_CAPACITY 8
 #define NFC_REG_USER_DATA_LEN(nfc, step) \
 	 (nfc->caps->reg_user_data_len + \
@@ -1061,10 +1061,7 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
 		sunxi_nfc_randomize_bbm(nand, page, oob);
 }
 
-/*
- * On H6/H6 the user_data length has to be set in specific registers
- * before writing.
- */
+/* The first PIO step overwrites the first packed word; clear the rest. */
 static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
 {
 	int loop_step = NFC_REG_USER_DATA_LEN_CAPACITY;
@@ -1073,7 +1070,7 @@ static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
 	if (!nfc->caps->reg_user_data_len)
 		return;
 
-	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
+	for (int i = loop_step; i < nfc->caps->max_ecc_steps; i += loop_step)
 		writel(0, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, i));
 }
 
@@ -1088,10 +1085,8 @@ static int sunxi_nfc_user_data_len_code(struct sunxi_nfc *nfc, int len)
 	return len / USER_DATA_SZ;
 }
 
-static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
-					int len, int step)
+static void sunxi_nfc_set_user_data_len_pio(struct sunxi_nfc *nfc, int len)
 {
-	u32 val;
 	int code;
 
 	/* not all SoCs have this register */
@@ -1102,11 +1097,35 @@ static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
 	if (code < 0)
 		return;
 
-	val = readl(nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
+	/* PIO uses only slot zero. */
+	writel(FIELD_PREP(NFC_USER_DATA_LEN_MSK(0), code),
+	       nfc->regs + NFC_REG_USER_DATA_LEN(nfc, 0));
+}
+
+static void sunxi_nfc_set_user_data_len_dma(struct nand_chip *nand,
+					    int first_step, int nchunks)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	int first, step, len, code;
+	u32 val;
+
+	if (!nfc->caps->reg_user_data_len)
+		return;
 
-	val &= ~NFC_USER_DATA_LEN_MSK(step);
-	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), code);
-	writel(val, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
+	/* Write each packed register once, including zeroes for unused slots. */
+	for (first = 0; first < nfc->caps->max_ecc_steps;
+	     first += NFC_REG_USER_DATA_LEN_CAPACITY) {
+		val = 0;
+		for (step = first; step < nchunks &&
+		     step < first + NFC_REG_USER_DATA_LEN_CAPACITY; step++) {
+			len = sunxi_nfc_user_data_sz(sunxi_nand, first_step + step);
+			code = sunxi_nfc_user_data_len_code(nfc, len);
+			if (code >= 0)
+				val |= field_prep(NFC_USER_DATA_LEN_MSK(step), code);
+		}
+		writel(val, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, first));
+	}
 }
 
 static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
@@ -1474,7 +1493,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, 0);
+	sunxi_nfc_set_user_data_len_pio(nfc, user_data_sz);
 	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
@@ -1503,7 +1522,7 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 	struct sunxi_nfc_ecc_snapshot snapshot;
 	struct scatterlist sg;
 	int page = read->page;
-	int ret, i;
+	int ret;
 	u32 wait;
 
 	if (first_step) {
@@ -1524,10 +1543,7 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
-	sunxi_nfc_reset_user_data_len(nfc);
-	for (i = 0; i < nchunks; i++)
-		sunxi_nfc_set_user_data_len(nfc,
-					    sunxi_nfc_user_data_sz(sunxi_nand, first_step + i), i);
+	sunxi_nfc_set_user_data_len_dma(nand, first_step, nchunks);
 	/* exec_op() restores the page's spare base during column changes. */
 	if (first_step)
 		writel(mtd->writesize + sunxi_get_oob_offset(sunxi_nand, ecc, first_step),
@@ -1645,7 +1661,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 
 	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
+	sunxi_nfc_set_user_data_len_pio(nfc, user_data_sz);
 	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, nfc_step, bbm, page,
 					    user_data_sz);
 
@@ -1900,7 +1916,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 			goto pio_fallback;
 		}
 
-		sunxi_nfc_reset_user_data_len(nfc);
+		sunxi_nfc_set_user_data_len_dma(nand, first_step, batch_steps);
 		for (i = first_step; i < first_step + batch_steps; i++) {
 			unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, i);
 			int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
@@ -1908,7 +1924,6 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 
 			sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, reg_index, !i,
 							    page, user_data_sz);
-			sunxi_nfc_set_user_data_len(nfc, user_data_sz, i - first_step);
 			reg_index += user_data_sz / 4;
 		}
 

-- 
2.53.0

