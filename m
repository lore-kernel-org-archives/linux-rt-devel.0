Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223471;
	b=natqGXQ8oUQBtbWO1a7Jmp6cqRI87gSJnP6uVYeOlLYbn3ajTWyBJD6a2jHdgd+bXzW9
	 RvpMjjpJxzjmydBDmUmUn2apffDNnKYkN+s/jJbf7yXY6SZSebV3MNOYb/FxA+2Xp7j/b
	 PM4M0i6J32m4EYbgXbpThCDMX0z/B0sZmvck6lrlQ7gTXFR5bnllx3/ep9ZgjHanEGzoe
	 S/68GE6KmgRFGclClVEccKnfy8O/pjXn36Nv/Fu8dtJh7zwMeZgs7QDs71CCroY4aGTbD
	 v6ikxJp5d+1SVchwKXV9Cuevr9XY7IKbUrXVpaXlRIjCZ4D/PKvW9RbS99m7EJailRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8/B8gGukZxMNCk9kG+bQ03cwup62u0VomkG0JFdqRS0=;
	b=LOMcysexbyqhFdTEaoSJoQa4+54qaLuR+srWDmF8MkClGsiRQixEHMfFG8k78qUxwzge
	 CZRYY4CHqN4ftRp3ZJZAxPaXtXp4oCohI+O1M9lTw0cI71sbV2A8IZ5OvwvCZ2Oqp6Dq9
	 fQBxbrNPcTNm0cWIPUQ+VuyHsbVlGUWDbESCBHbQ7IphMMaxMP8eLXJZP1H3KaVBFSQoS
	 qwv0C87AuzIwZiBv/PGp2q4Mra4CKubq3vBR0SLsT8EVohIllrB1QQ7HNjIzKEK9WYUcA
	 wfCkxQVacvC9AyL/tNLbtvGR7VSjIl15JaXv2NInIVlfyTejZQLFUIfEhMWXTKTJ9/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lxYFEE2Q;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEB606A692
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AFEB606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lxYFEE2Q
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-862a19300b7so583562a34.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223458; x=1795828258; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8/B8gGukZxMNCk9kG+bQ03cwup62u0VomkG0JFdqRS0=;
        b=lxYFEE2QTJ0dop1GVTr3RgEd5lXVpIeJDxoQ4PsMmjH4fds1kZFx4wL/j4utqfXR2u
         dXIRSUV4Fro/Qx3WQ1PQ6L3tqGsMicRtxvu7xc1n0CxYNry3heVsXN/3gI00r6hzJsEw
         d1FESDDnKgAl1Khxn3w1QQBc312y9cscYkR7wbJSJpaWBY0Q9VmgBj4UHL5kmOehttZe
         OrN8tk64XJG7xV7JHNPOXR/NmIWxFnBkajplLnkb3aABJYyuWwz50TaX+IWadAiQj/1M
         Hp/yQUs4ydGKr1Z6/v27BnP8bbXm95TV7qsAoFO1JMzxZ0QkYu5uyKbVc/TxvaBQEJqR
         T1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223458; x=1795828258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/B8gGukZxMNCk9kG+bQ03cwup62u0VomkG0JFdqRS0=;
        b=2yLPshlrznfzBPmbzp9qvOCVHbF3eXCcmfm4rX83A6571jL/emezRl8mx7FpFrzU9i
         1zJLhCc3nTJCNqNtooV2HkJt24qo4KOiaT8RY+Mkdx36fLpsDo3CbRw13odQhCDc6wrr
         zTIeDOAOn3kB/5dak6mBava/zJxzUiNzgNWxxIxli2GqLKOmOvSBMtsgbSarEo5qan2Y
         3QN97Kajw9vj4pBsAzWURdvS12Xb/6I4Sh9EawvTkGDh+gonbSBWnQMKzPt/TGzcYvPW
         4Y7cOZ+6Usm2OANm10n//Kmdq9JlfuCBKfTCq42uBVu3E2gNlnCdWwnPmvhVcH/3T4+N
         c3hQ==
X-Forwarded-Encrypted: i=1; AL+hErEA9FAWkzthVhg9IHAx3Y69d5Kl1+SzpJ6iz7Xo/Hwi9DNOgWsn6qdB9DmM2OcwdG5DEEkmuiQFn50Al/oeUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/2c6ARoLyC/ncwigC1j77fcEkp8YP93wObnirDYo00rEQVbrdU
	6/n0TmfKB1Fmru4gFCCJYCvE6DMxEdPNxX8untvE2PaYUf8WjqC7P2u9
X-Gm-Gg: AYBFou1rZRD1WVwUlx5z/IMKyd8J94zDFuDTOpzF3YeuoteLP/g4GLi+sCXbbdzz2Nm
	sPtEO8kFTcVpIcm7epNprQdYP8u1h0xB6A+JQQwUNr51+kd09EQI0XMTUFG6NozpsOe2Gm1Om0Y
	RSinBpziFqni5s2BOLpYZWnH663rtPkSj/Q390RaDumv03IDg92a+lH0ZGV/P0MfLpCNWL5ya1u
	wPVhB5F9OeExRyvFCRgLfshxtFW/j59BMKV7c2zBo5tm/+M92YsH5FpbBCIMFvSz7oZwKYPbjfO
	5ad/xbRCFVHePopJPu0yJGNrkV0B5d5K/j781lvRqci184n/TbDaIycbzN6HBqAtwkP1mGyjZQc
	6ATJlipvoydXGAA43xiAyRH/dGspHD9Pu3aRpihog30UOWTKrTrCIx6HacuikfFkzjTrX6SHqnm
	9KHj6c1V9/bwWn2bp1krNzzu4PIjUUYT6lHpxJOMLWRnirb40PifEUWX/tmnvS4qWf47sQ5Wzkl
	UgR/IibGvoPKxg+zfSmZRVX6Xwi6C4mKheqJ15xnLOFZUhj6VEhSwlpgHDpq2Ua1DtgrYTDlS3H
	9fIZ7WRzHE2ompVsS56FLS0zJnKlLCZB7sQ+yjH3VHKWLNMganhIwd/VZyoDtzNmrLm5DTgUocM
	1G6cM7w78rFWuWmTUI72spPppGjEjOgnrwuI2XHwksKgkiuB9QuS7P3GLfm7LGBAYXjUnRoyF9N
	tUrAYrN94HLPxKwIO76geS/t71fgq4eAuaRsKvNJLbq3D3gZb7ELbXRbs31BbtiA6GGXhtTt21P
	Q==
X-Received: by 2002:a05:6808:4f46:b0:4d6:90f3:74b2 with SMTP id 5614622812f47-57a0bb54161mr6128010b6e.50.1795223458025;
        Fri, 20 Nov 2026 17:10:58 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:10:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:25 -0700
Subject: [PATCH v11 02/26] mtd: rawnand: sunxi: compute protected OOB
 offsets from page geometry
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-2-9721b1905ef4@gmail.com>
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

PIO and DMA need the OOB offset of each ECC step. The driver finds it
by summing the protected lengths of all preceding steps, repeating the
same walk across a page. On H616 it also allocates a length array when
the chip is attached, although its entries follow a fixed rule.

On A10 and A23 each step has four protected bytes. Keep that rule
independent of the step count chosen at attach: the NAND core can fall
back to software ECC with a different geometry.

H616 assigns the available space to the earliest steps first, in
four-byte units up to 32 bytes per step. Store the total and the
per-step limit. The number of protected bytes before a given step is
then its index times the limit, capped at the page total. This gives
both the OOB and parity offsets without walking an array or allocating
memory at attach. Use the same four-byte encoding to program the
controller's length fields. The ECC strength and on-flash offsets do
not change.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 132 ++++++++++++++------------------------
 1 file changed, 49 insertions(+), 83 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index c6001349266f..f57184927fe9 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -267,7 +267,8 @@ struct sunxi_nfc_timings {
  * @timing_ctl: TIMING_CTL register value for this NAND chip
  * @nsels: number of CS lines required by the NAND chip
  * @sels: array of CS lines descriptions
- * @user_data_bytes: array of user data lengths for all ECC steps
+ * @user_data_total: protected user bytes in a programmable layout
+ * @user_data_step: maximum bytes assigned to each step, zero for a fixed layout
  */
 struct sunxi_nand_chip {
 	struct list_head node;
@@ -276,7 +277,8 @@ struct sunxi_nand_chip {
 	unsigned long clk_rate;
 	u32 timing_cfg;
 	u32 timing_ctl;
-	u8 *user_data_bytes;
+	u16 user_data_total;
+	u8 user_data_step;
 	int nsels;
 	struct sunxi_nand_chip_sel sels[] __counted_by(nsels);
 };
@@ -327,11 +329,7 @@ struct sunxi_nfc_user_data_layout {
  * @nstrengths:		Size of @ecc_strengths
  * @max_ecc_steps:	Maximum supported steps for ECC, this is also the
  *			number of user data registers
- * @user_data_len_tab:  Table of lengths supported by USER_DATA_LEN register
- *			The table index is the value to set in NFC_USER_DATA_LEN
- *			registers, and the corresponding value is the number of
- *			bytes to write
- * @nuser_data_tab:	Size of @user_data_len_tab
+ * @max_user_data_len:	Maximum programmable user-data bytes per ECC step
  * @sram_size:		Size of the NAND controller SRAM
  * @timings:		Controller timing characteristics
  */
@@ -357,8 +355,7 @@ struct sunxi_nfc_caps {
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
 	unsigned int nstrengths;
-	const u8 *user_data_len_tab;
-	unsigned int nuser_data_tab;
+	unsigned int max_user_data_len;
 	unsigned int max_ecc_steps;
 	int sram_size;
 	const struct sunxi_nfc_timings *timings;
@@ -911,12 +908,21 @@ static inline u32 sunxi_nfc_buf_to_user_data(const u8 *buf)
 	return buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
 }
 
-static u8 sunxi_nfc_user_data_sz(struct sunxi_nand_chip *sunxi_nand, int step)
+/* Earlier ECC steps take their full share before later steps use any bytes. */
+static unsigned int sunxi_nfc_user_data_before(struct sunxi_nand_chip *sunxi_nand,
+					       unsigned int step)
 {
-	if (!sunxi_nand->user_data_bytes)
-		return USER_DATA_SZ;
+	if (!sunxi_nand->user_data_step)
+		return step * USER_DATA_SZ;
+
+	return min_t(unsigned int, step * sunxi_nand->user_data_step,
+		     sunxi_nand->user_data_total);
+}
 
-	return sunxi_nand->user_data_bytes[step];
+static u8 sunxi_nfc_user_data_sz(struct sunxi_nand_chip *sunxi_nand, int step)
+{
+	return sunxi_nfc_user_data_before(sunxi_nand, step + 1) -
+	       sunxi_nfc_user_data_before(sunxi_nand, step);
 }
 
 static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
@@ -977,34 +983,35 @@ static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
 		writel(0, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, i));
 }
 
+static int sunxi_nfc_user_data_len_code(struct sunxi_nfc *nfc, int len)
+{
+	/* Each code counts four-byte words; larger codes are reserved. */
+	if (len < 0 || len > nfc->caps->max_user_data_len || !IS_ALIGNED(len, USER_DATA_SZ)) {
+		dev_warn(nfc->dev, "Unsupported length for user data reg: %d\n", len);
+		return -EINVAL;
+	}
+
+	return len / USER_DATA_SZ;
+}
+
 static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
 					int len, int step)
 {
-	bool found = false;
 	u32 val;
-	int i;
+	int code;
 
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
 
 	val = readl(nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
 
 	val &= ~NFC_USER_DATA_LEN_MSK(step);
-	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), i);
+	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), code);
 	writel(val, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
 }
 
@@ -1204,13 +1211,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 static int sunxi_get_oob_offset(struct sunxi_nand_chip *sunxi_nand,
 				struct nand_ecc_ctrl *ecc, int step)
 {
-	int ecc_off = step * ecc->bytes;
-	int i;
-
-	for (i = 0; i < step; i++)
-		ecc_off += sunxi_nfc_user_data_sz(sunxi_nand, i);
-
-	return ecc_off;
+	return step * ecc->bytes + sunxi_nfc_user_data_before(sunxi_nand, step);
 }
 
 /*
@@ -1221,8 +1222,7 @@ static int sunxi_get_oob_offset(struct sunxi_nand_chip *sunxi_nand,
 static int sunxi_get_ecc_offset(struct sunxi_nand_chip *sunxi_nand,
 				struct nand_ecc_ctrl *ecc, int step)
 {
-	return sunxi_get_oob_offset(sunxi_nand, ecc, step) +
-		sunxi_nfc_user_data_sz(sunxi_nand, step);
+	return step * ecc->bytes + sunxi_nfc_user_data_before(sunxi_nand, step + 1);
 }
 
 static void sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
@@ -1991,10 +1991,7 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	unsigned int user_data_sz;
 
-	/*
-	 * The controller does not provide access to OOB bytes
-	 * past the end of the ECC data.
-	 */
+	/* Only ECC-protected user data is exposed as free OOB. */
 	if (section >= ecc->steps)
 		return -ERANGE;
 
@@ -2023,15 +2020,6 @@ static const struct mtd_ooblayout_ops sunxi_nand_ooblayout_ops = {
 	.free = sunxi_nand_ooblayout_free,
 };
 
-static void sunxi_nand_detach_chip(struct nand_chip *nand)
-{
-	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-
-	devm_kfree(nfc->dev, sunxi_nand->user_data_bytes);
-	sunxi_nand->user_data_bytes = NULL;
-}
-
 static unsigned int sunxi_nfc_fixed_min_user_data(int nsteps)
 {
 	/* Preserve the ECC strength selected with the legacy BBM allowance. */
@@ -2048,31 +2036,19 @@ static int sunxi_nfc_variable_init_user_data(struct nand_chip *nand, int nsteps)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	const struct sunxi_nfc_caps *c = nfc->caps;
-	int remaining_bytes = nand_to_mtd(nand)->oobsize - nand->ecc.bytes * nsteps;
-	int i, step;
+	const struct sunxi_nfc_caps *caps = nfc->caps;
+	unsigned int oobsize = nand_to_mtd(nand)->oobsize;
+	unsigned int parity = nsteps * nand->ecc.bytes;
+	unsigned int available;
 
-	if (nsteps <= 0)
-		return -EINVAL;
-
-	sunxi_nand->user_data_bytes = devm_kzalloc(nfc->dev, nsteps,
-						   GFP_KERNEL);
-	if (!sunxi_nand->user_data_bytes)
-		return -ENOMEM;
-
-	for (step = 0; (step < nsteps) && (remaining_bytes > 0); step++) {
-		for (i = 0; i < c->nuser_data_tab; i++) {
-			if (c->user_data_len_tab[i] > remaining_bytes)
-				break;
-			sunxi_nand->user_data_bytes[step] = c->user_data_len_tab[i];
-		}
-		remaining_bytes -= sunxi_nand->user_data_bytes[step];
-		if (sunxi_nand->user_data_bytes[step] == 0)
-			break;
-	}
-	if (sunxi_nand->user_data_bytes[0] < USER_DATA_SZ)
+	/* The first protected word must contain the bad-block marker. */
+	if (!nsteps || oobsize < parity + USER_DATA_SZ)
 		return -EINVAL;
 
+	/* Use as many complete words as fit after parity. */
+	available = min(oobsize - parity, nsteps * caps->max_user_data_len);
+	sunxi_nand->user_data_step = caps->max_user_data_len;
+	sunxi_nand->user_data_total = round_down(available, USER_DATA_SZ);
 	return 0;
 }
 
@@ -2094,7 +2070,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	const u8 *strengths = nfc->caps->ecc_strengths;
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_device *nanddev = mtd_to_nanddev(mtd);
-	int total_user_data_sz = 0;
 	int nsectors;
 	int ecc_mode;
 	int ret;
@@ -2179,10 +2154,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 			return ret;
 	}
 
-	for (i = 0; i < nsectors; i++)
-		total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
-
-	if (mtd->oobsize < (ecc->bytes * nsectors + total_user_data_sz))
+	if (mtd->oobsize < sunxi_get_oob_offset(sunxi_nand, ecc, nsectors))
 		return -EINVAL;
 
 	ecc->read_oob = sunxi_nfc_hw_ecc_read_oob;
@@ -2413,7 +2385,6 @@ static int sunxi_nfc_exec_op(struct nand_chip *nand,
 
 static const struct nand_controller_ops sunxi_nand_controller_ops = {
 	.attach_chip = sunxi_nand_attach_chip,
-	.detach_chip = sunxi_nand_detach_chip,
 	.setup_interface = sunxi_nfc_setup_interface,
 	.exec_op = sunxi_nfc_exec_op,
 };
@@ -2712,10 +2683,6 @@ static const u8 sunxi_ecc_strengths_h6[] = {
 	16, 24, 28, 32, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80
 };
 
-static const u8 sunxi_user_data_len_h6[] = {
-	0, 4, 8, 12, 16, 20, 24, 28, 32
-};
-
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
 	.layout = &sunxi_nfc_fixed_layout,
@@ -2781,8 +2748,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_h6,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_h6),
-	.user_data_len_tab = sunxi_user_data_len_h6,
-	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
+	.max_user_data_len = 32,
 	.max_ecc_steps = 32,
 	.sram_size = 8192,
 	.timings = &sun50i_h616_nfc_timings,

-- 
2.53.0

