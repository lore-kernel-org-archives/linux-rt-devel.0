Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282C3CB2FD
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266822; cv=none; b=ktW1fcv09C7KDK7osPpcUd3ecA0CL+dXRXGFKHef4dP0TfJbA5XdB8DSkoUHSXVuI6t5djOXGJ5mEFKqKukwMfVt4SmEN6yzRBehltu6bbFcC4vurTsflOR0+nuX3R+Ku7wzpqwU7f1m31WrEcfxh0ygGC+hd6WjM/PePZ2D9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266822; c=relaxed/simple;
	bh=Nd/PTAsUmsfvFKiGUyB1xYo/rMCCfj6VytCfy4wTcFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyMQgFTHgVtu2rmYeJRUK1HTcoAwNvuGj5x0eg+WMOIuhpJNKbkXQYvVj11jBllwSl2/LZ9iLsYGKJ4PKyBfiXjIozlIdxdpK9W/iA5YBgFWYogT6rJL1fsXNg1D9F5VrQ6drn/ZLEA7tFqhDNre5ZGwjo6023Tsee2OxA96v2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paxq1rzl; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paxq1rzl"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-84621d8c7aaso208919a34.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266819; x=1792871619; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1FyhwdcLvc7Hi0cJi3ietTvT1uU5sBD8ynqEwPpQzmw=;
        b=paxq1rzlegbmNeFryaZe+z4BDy60XZMrsqz5zZmPV0ZnSiw7AxtOxDx7K5LCAgTfh+
         LmILd1XwHQTXIFbspd6ce8Bmecnip/FO0RnDp+ic9sCsRo7VhAjMcKty1ZCTW0W4eR/t
         px0y5ik/tTLWEpkST5uGbIsKhANperLmZzEs3uCLs+lZwKI18FfVZfdgJPhSzr9ETrU2
         +PnG+2sJO6t9rsSAs8M7BlGnJafjNzrMc7x4A7Xy5m8aC28Fh6U6UHdScn6Ml+JnKDDg
         XxXUVxuzHQIvlXrL2CHKba6sg3DYd5eGKf99uTEFG5BW2Jh8nuOWtrJkICgAtgwKYS8j
         9sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266819; x=1792871619;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FyhwdcLvc7Hi0cJi3ietTvT1uU5sBD8ynqEwPpQzmw=;
        b=uY7WvqMxCX+JAUT0DikMH4LMJK/JXl9J3XeG5S8sDXtpvI37A3+F794VOe9A+Y0CCp
         PQGVx227ELayX5zQqAnqMpooqACrH1u6gnoOR9mbKgQcB+6JHFAJkKJj2S8F0ZviR3UR
         KYq1S5bOfnF9KKBAJuqktEWLTYp/VJVz4PUpE7QCXwv0fn8bmjjyxfUbIqY72fGwYlcW
         pY0PqrBx8Ls73hQ6Q2CTa1wbuNwIZAydfKhxxKOdtUXEh4haq3X0rOqju4T75vDEMlrz
         zp0XCKgeEE25i1fn4ZORQUfQrs3zyWR2fOSqRT4NxfBe7gr6fl0OivveboCWEN7d1cXz
         8U3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzxHp6Aa5BXL91S5w0fHGZwFwJattMbHGDPH1IuxNSEWbGjDkXcpvfICMsLqS6b09njhmytvVYas66D2uK4/Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIlxDsYn++uN5giieGmWMyi4tZSgZJjcEWfZZstzI/UnjWdMI62
	XYxPOKcOUcDzk0S4UZS6zO05vkSHIPToC7mcUZV8Rp4egie/5MkbV/54
X-Gm-Gg: AYBFou2Eq4r89Q2jwwez2Pf9a9dNfImGk+06/cahjcKLARl49Cz0vljDT/TZBOU+uKa
	TfZL8sMGLzE6vMIMvOjsbWmzV7ANR6AJjjiO12ApYyCAam+m/hCXyqtjC0hw87bHxqRt3xAJ3u3
	9HT8omIv3w4POxvVud6i/plW3aZ1J1AJZ4i5DjUwzc5AGye+OfZO6HrgA47nIDmrsZp1qv1nF8u
	1Zvt33Bdg11XUDqw9kfcUcBFleJfjLEc0Lg9iDpsLhrwaHlU61qBNIwRp+IB112FGYPWeXSNK4M
	APb3RedfoJ5cQJRwUjgrVAOxF8QBwpAtUrdsBvJ0hAeGN3bfSe+58OLZ1IMcFRpBG3CeBcAFOu3
	6Zf4T8otUK+5EmMP5afK1NrwGbxFHi/4CTPLINYw0V1KvJEqxUFs9duLopfCFBtR0AKQ1FKGrBd
	zW8shAga4X+NaLWGWytk2EwWUIDYImcjiZHf81IhNOqnPD/lE/svD4K9jAt1nPXH9l26kiTjEpB
	htOkCwPHLBrzIoHSa1PWhcgXuCM2n/K+cTPTdTQroG1ngrwpW26oBYEVifF1WKBpXKikXUOxvJZ
	pqVhnGOF1JYFF/VtMyajBm5v98z3dNiGAV6setCLbBxjGHUJkZw4EvIfCaCdgdfGyCPdnl1HPsf
	A/jw7QOxxQgxpE9v9ItW2X3nvdVNwE1Wc9IEtUm1LjKA=
X-Received: by 2002:a05:6830:67f4:b0:81d:c548:292f with SMTP id 46e09a7af769-844fe7827e1mr3438567a34.12.1792266819518;
        Sat, 17 Oct 2026 12:53:39 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-845b9e280dbsm2212064a34.19.2026.10.17.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:53:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Brian Norris <computersforpeace@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v9 16/18] mtd: rawnand: sunxi: reduce user-data length register accesses
Date: Sat, 17 Oct 2026 13:53:05 -0600
Message-ID: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-16-5af9a1be16ef@gmail.com>
In-Reply-To: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
References: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit

H6/H616 pack eight ECC steps' user-data length codes into each 32-bit
register. DMA currently clears all these registers, then
read-modify-writes one field per step, repeatedly accessing the same
words. Code zero means no user data; the other codes select lengths from
the controller's table.

Build each packed value in memory and write it once per DMA batch,
including zeros for unused slots. Take each length from the batch's
logical step but encode it in the corresponding batch-local hardware
slot. Rewrite every register on each batch rather than caching values
across resets or changes of chip.

Share the encoding with a PIO setter. PIO always uses hardware slot
zero, and its page callbacks clear all length registers before the chunk
loop. It can therefore write the slot-zero code directly, without a
read-modify-write. Keep the page-level clearing so unused slots are also
cleared after a DMA-to-PIO fallback. Older controllers without length
registers remain unaffected, and the chosen lengths and on-flash layout
do not change.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 79 +++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 45172175d4e6..a20886991975 100644
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
@@ -1036,35 +1036,60 @@ static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
 		writel(0, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, i));
 }
 
-static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
-					int len, int step)
+static int sunxi_nfc_user_data_len_code(struct sunxi_nfc *nfc, int len)
 {
-	bool found = false;
-	u32 val;
 	int i;
 
+	for (i = 0; i < nfc->caps->nuser_data_tab; i++) {
+		if (len == nfc->caps->user_data_len_tab[i])
+			return i;
+	}
+
+	dev_warn(nfc->dev, "Unsupported length for user data reg: %d\n", len);
+	return -EINVAL;
+}
+
+static void sunxi_nfc_set_user_data_len_pio(struct sunxi_nfc *nfc, int len)
+{
+	int code;
+
 	/* not all SoCs have this register */
 	if (!nfc->caps->reg_user_data_len)
 		return;
 
-	for (i = 0; i < nfc->caps->nuser_data_tab; i++) {
-		if (len == nfc->caps->user_data_len_tab[i]) {
-			found = true;
-			break;
-		}
-	}
-
-	if (!found) {
-		dev_warn(nfc->dev,
-			 "Unsupported length for user data reg: %d\n", len);
+	code = sunxi_nfc_user_data_len_code(nfc, len);
+	if (code < 0)
 		return;
-	}
 
-	val = readl(nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
+	/* PIO uses slot zero; the page callback clears all other slots. */
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
-	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), i);
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
@@ -1460,7 +1485,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, 0);
+	sunxi_nfc_set_user_data_len_pio(nfc, user_data_sz);
 	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
@@ -1489,7 +1514,7 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 	struct sunxi_nfc_ecc_snapshot snapshot;
 	struct scatterlist sg;
 	int page = read->page;
-	int ret, i;
+	int ret;
 	u32 wait;
 
 	if (first_step) {
@@ -1510,10 +1535,7 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
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
@@ -1623,7 +1645,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 
 	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
+	sunxi_nfc_set_user_data_len_pio(nfc, user_data_sz);
 	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, nfc_step, bbm, page,
 					    user_data_sz);
 
@@ -1890,7 +1912,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 			goto pio_fallback;
 		}
 
-		sunxi_nfc_reset_user_data_len(nfc);
+		sunxi_nfc_set_user_data_len_dma(nand, first_step, batch_steps);
 		for (i = first_step; i < first_step + batch_steps; i++) {
 			unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, i);
 			int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
@@ -1898,7 +1920,6 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 
 			sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, reg_index, !i,
 							    page, user_data_sz);
-			sunxi_nfc_set_user_data_len(nfc, user_data_sz, i - first_step);
 			reg_index += user_data_sz / 4;
 		}
 

-- 
2.53.0

