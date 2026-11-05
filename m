Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904968;
	b=IL29i4qjqarKdXh4+9HuquYRSpNDHZAUnmqAZXCHsgKHiJhVGiQYRqz07k7AY10pwrAx
	 Su5pYaRYxLAErUdT0DS98Yh0QgyWiRAvMLELoAS0iFBV8qxF1qdN6784OG7zow7Z3p9i1
	 wmQEe95yYB09rETmBw/aVgowIlg7ISLYmJn1Ksw+S+hRAacCoBtOp5cZoCxDnKpduIS+h
	 UI4o3wQg5Af+6Lf8qmMVy+Dzy2auzHiwcEUrjKSo4jdprZ6Vw1lNeC58ZJX3kC7z540gw
	 jx9tISu5g1FSvo73IrpJS06NyT/THho//TrYeb6WubnWXymW8bY0XY+a+tCAiE0OfWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Kyb9Vh//GYgUYYgsTf0Rac6RrMspxNg0WSg6hXKbfA4=;
	b=mSciU4HJoamvUiR7qb0MhJlDfOGKK3FhmlcDgJ99HSbTYgvq3ChwwM5xZWBecPO0HbA3
	 z0EX6G94GUQoBAZDDELNVnYJWn5V5iQ6mvm/zJ6315eIFvylh1ciqNel1Ky6BIMQX52SZ
	 8DhM7bk4ruPVZZCoPTraCMRDfHtowgQDHSO2Q9ToeZZSUjOiQ5yKg1hm+KUTsA113+Tgz
	 BUhu1JFCrPhM/YK46WcIlmVOPzyIVAiANDYMvNaU2MsP+DxqxXKpqZ0iBvNLWTFhH2NLf
	 yUb3JMbcAiwx1ioo37ybBXnWFo1o1XiGpGsEtl35bL3l850772/K+KBPMoxtugrbwIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AJ+qVKXA;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2560A260E
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E2560A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AJ+qVKXA
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-70059e4dab6so1352181eaf.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904967; x=1794509767; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kyb9Vh//GYgUYYgsTf0Rac6RrMspxNg0WSg6hXKbfA4=;
        b=AJ+qVKXAUrj+khNAk5Bz/7tp5erSiWVPU4PafTfe6CnulI520rC8keZjqYe4LGqIJU
         6aSfMHB7JxAXFD1cYI9qbk4UqIXCqzfthJoHjCkxpz9cz4pKJ3UzpQ9sBltQWgbY3j1y
         RztHpHDtl6F1MURINYn/AMzF5FOVSzf8WXKoUJEI7M4u+V4XKS/9tI4QXJgMvbUgirww
         xWmZ7wD0KNB5eDFgQY6hcwk/kUlM/9YUfdQIL0X5g8BapywaaegilqtqQy1FOolDg18R
         87zLF5Da92pDl+n6PjgMs7UhVRP1BfTJeTIn2+wPWIq0PEDI/5e54jQPaKwSokRrI1ZZ
         7oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904967; x=1794509767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kyb9Vh//GYgUYYgsTf0Rac6RrMspxNg0WSg6hXKbfA4=;
        b=CaPmeltJWMrew083y69tlB9tAyXRPciBoTKgODpUFR5uz7C5U6ykKKEHuda7Tqknoy
         VisCxdv2sutaCjRNzk1Y0WhV5hN+6jYqmzVBxBd/9jGfvEBJTmW8O238OwokxJoU0TpE
         jkzUzUUSCXynUBJtChSUGnEE80gKR+AU/6RJj/22Qlzu+ekv390UTEUekHzzl9+okgxy
         WnZS0dlrc172a+XH2l3c3QjorRXRX/iypAyeZW13OGaL4KicIAFt8eyFdpe6BZk/h1SI
         1WNr3gPOtM700uJ0RSj/UnkvY3GOkhUk/KGC4SW8lZHLpPmMFMRyOn82uyjuezJ2WuZu
         ZBdw==
X-Forwarded-Encrypted: i=1; AKwUvBwFW/mJkANbSoLALNPOuxIo3xzR6He5O4RbLnQFXVbdwxPY0kaF3q9CrZjQZt6UXyVQ94rOy1l8pRc4jmS47Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+/m62ixZVKeCn99ORcWdXmG4e4rx7V4iIwPmk4FFkW9SxcC2HB
	MCBAw0YXQ3P0zCM2sBmqQtjzAOkKRN1mFKCtFkGNpKQ0/5ClyXg1xLzE
X-Gm-Gg: AYBFou18jR5B/05TcPfH9CydtCNq1iSyToWIrldw2wxKH4W3lb55m/gm3Z7IrWNfb+9
	qBVnw78cSOhu6SeDAFarA52Mwy+Q/HOuTBnsm9pZnokwIXR+rQ9Ys/Ky7v4D/MZYJZ0fWGsDUkF
	9+chhh4Hp3P/FSN7H/8vvNqzEI/5ZvZuaYiKP+ryfHjrqy4fuNQh5+AHQ7/StHMzF6I5gKtTyjD
	hfRl3xHkH/te89pebhnY7BVsYwhH5b+RrT34EDWPZ/4zpjH3ukkcRwUTM9PUK77mjhv49Jou+zU
	xjynXogswDi0Zv5qxDkkZFzYRIV+ZenNmzA6mU1wiC2aGowPIBk0xivh6gZ/PLiQaSvJva147nN
	qR9oaQMs3XL+j81urMxsH3FrnNJH7hH82+HbTVUPUe++MfEBnpcLC+wLTRUUnp1KgG3QMWqcqDO
	DmCXfx5UeSdMFKQfIDGIt+mRDBSRMtlCuHtWcbjjcnf7HUbH84vsZ4ohqqAdNtdHTbfrDwdcBhg
	1rrMcqtV0HJyiMVztI+SfsqRxPUq4ANtv9dTXUgcIrY8MsQzasX/H/pHomncw2G616rLtIASkEz
	zj8ppdjdno9f2B63eF2GSAtqwgoflmjkUmsQHKr9CccsOHkm+Jwnwyehv+gpfkMKkPbu0nCyeV9
	ntYOWjKG5W5Ipgc+jrXYN6kR5AwL/fqqtLPstJGq/DpqcD3gks8smDQ/2o64Mi4xTC47NhR0OhY
	WpXpGqZv2c+uGujKW2YYNG/poz55ZKTIO/gfIpHQsleooy5/VSL2HP9KsgqyEGV/pm5341bL916
	g==
X-Received: by 2002:a05:6820:7408:b0:6dd:4f30:258f with SMTP id 006d021491bc7-716e79ad995mr250479eaf.56.1793904967200;
        Thu, 05 Nov 2026 10:56:07 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:56:06 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:40 -0700
Subject: [PATCH v10 24/26] mtd: rawnand: sunxi: reduce user-data length
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-24-dca1f6ed29a8@gmail.com>
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
index c9135c8abf54..814331e16bce 100644
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
@@ -1093,35 +1093,60 @@ static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
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
@@ -1517,7 +1542,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, 0);
+	sunxi_nfc_set_user_data_len_pio(nfc, user_data_sz);
 	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
@@ -1546,7 +1571,7 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
 	struct sunxi_nfc_ecc_snapshot snapshot;
 	struct scatterlist sg;
 	int page = read->page;
-	int ret, i;
+	int ret;
 	u32 wait;
 
 	if (first_step) {
@@ -1567,10 +1592,7 @@ static int sunxi_nfc_hw_ecc_read_batch_dma(struct nand_chip *nand,
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
@@ -1686,7 +1708,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 
 	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
+	sunxi_nfc_set_user_data_len_pio(nfc, user_data_sz);
 	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, nfc_step, bbm, page,
 					    user_data_sz);
 
@@ -1955,7 +1977,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 			goto pio_fallback;
 		}
 
-		sunxi_nfc_reset_user_data_len(nfc);
+		sunxi_nfc_set_user_data_len_dma(nand, first_step, batch_steps);
 		for (i = first_step; i < first_step + batch_steps; i++) {
 			unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, i);
 			int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
@@ -1963,7 +1985,6 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 
 			sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, reg_index, !i,
 							    page, user_data_sz);
-			sunxi_nfc_set_user_data_len(nfc, user_data_sz, i - first_step);
 			reg_index += user_data_sz / 4;
 		}
 

-- 
2.53.0

