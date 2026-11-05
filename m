Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904932;
	b=j3YS31HljRb7mSt7TjSvKzysodW3YUXvuBM+cwbueNLKjd02TDcRXjFsSSDf7jABxGHw
	 /cHFqzR6qBzbrljGtfRGJ02e6rLOmH1D3cyzRcC/xpdgGMYGA75tFtKhG0RxflB4NT6P2
	 TEnTW+pw4d0piKOPkMsuJoaQ5ySqfg1kjHgF/jl0CJtGnJzQy+IuwvpiRu6i+qyQ+M6sv
	 dSLAscxsYIIuQ0MMkRIZCoT2+Wzp7DHOsjaqz+MWsyorZ+B3upAT+OOudEXeUBNl8jFVk
	 z+NpQL8zqKtMVSePV1Qh3JRNYeaJd38VL5MhxV8qnvn+uo/Bfc52DQlZ+9GtXc0CVVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8FLK5L4m7kGeWnbYjP4uSPNLUtTL4HW4u70VBTQSqv4=;
	b=bMjsTzTY2LF368hE0O1TzVcbi5No2ho81NeqAdT3bsLHejoaQLCDk0Hzcn/5nVr1PaNR
	 fcP1hSgiUiFuoLFGM/uAO6A+nlON8tpAB+S/9QsBwt+otfEL0fiJzvqm8yBZ67F4Yu0Ei
	 qG9HuIHyZMl2P1V/kbf7KgobpnphAirJ4Ae9Sgb6h4XIoe5ZizYYVrt/XREKkB+EziH66
	 pn+7mj0nXBYG/jTGOMXedmNXNXp6d1eGpA27P3FWoOnJKlOK6XJe1PjzRLh7+TYGxNhRQ
	 0LObQKYxasVL/AJP0VOI6sAGH6xpA2XSb91XRWld8OLvHn5q9xBsTm08QjUiax+l0Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGxTOrXN;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21D606A338
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD21D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGxTOrXN
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6d68de53053so1244656eaf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904931; x=1794509731; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FLK5L4m7kGeWnbYjP4uSPNLUtTL4HW4u70VBTQSqv4=;
        b=DGxTOrXN7pZdFYl8BLXHwfvtI9IFbhiemu3hPK6CoM1yVsTl0npJ7QMr5rpPgIS+uN
         K/ZVJFDfELBH/FKLwO2LYoXJPZvUR6oQy2PUI3RZMrL3FH+stE6MSvVCFMFvTTt2B8Kv
         ideA9uYUM7qfVGwEHYn45spM8+OmcEe56AuVSDFU7nAidp/Mr5oa0qrpmzbVjbVCtdOe
         OxhmhnmtrWcwq08E43qRyYxVeUKIU9tLLEm8ie/z4dz8QnMkeOE2q5rNoaGg6jn61Qy7
         +aAMWtsxXbPqZ5/C4a/+CijkdUN8BtcECOQk4zKQRyC6Z7PUTEejGOBttqAw984FPl66
         qcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904931; x=1794509731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8FLK5L4m7kGeWnbYjP4uSPNLUtTL4HW4u70VBTQSqv4=;
        b=BgDZEN8gQDCNzwDbKFFj8+wHbQCJWiYRAR62fSC1KmpK4IxtOZjURhgM014PosdkYL
         akKi5gwaqR/fElh7MQ4CznT4ciMPWRzZMdIgs3IhgLjZy1vEWIUi+W2bLGDlj4Eu8zIC
         J1tiKv6bHzOmlbw+3Omy3crfYzRWkaffWpOYGaVcfE0DwVu2kA8yqggr2fQaOakJX2U5
         +3lqOof+IlBtpWq4igYllB+UPkQNDiDMcTojO3bNpeRw9jEge2wzCgIsRr96mqYS1ERP
         8ynobAIUfmqO9fTNhDM6o1VSWyK5emIS8ppHpNfX6iEVdBtvNAijWeem2NSmGwyzjKRP
         SnDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXeGVKZbk3LuAMKT/rdj1VX+fm5L1w60NrhZVYLj2UevnEr8o/efYgqiR6Yf+XRVRksTVBQ3LhUoDyMhmqDg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9HY49DcHvovoLcBXg6+lF3D52YdR66tVbFRMOZexohQiPOMJWp
	9GM+Vr4Qi1r3lqB6N3Sa99Xfcq1r89iK7p/acpe7iDmkMSRPKOoNdOhJ
X-Gm-Gg: AYBFou3+35B/1wtqFqmM31MIDvfzRzifRY6xyGsvgLKlCBJ02xPu4c7w3A8lnhh75hr
	/OvYK3iwCGhNaCgO6aOuAtmpb5Xi7AD45vVr+z3+3jG+HWd5X7w7cINjtKUaJc68gsF9bc9GJfs
	lKdteMeOMHSSoNkzk658vddJrhUQxTc60nHTgy69YgNwH39HjWlbJr+7XJBKajiFEJKKUi1Zfv2
	/OBoAMWleI6D/j7mVFnMagpWUV0YoDbWwKul0LcsRW5a9GigbHUEqA5mfXE+w0mFNcIf5xM8RCG
	CeIaEc7SswK4WfH3EjCi5gmCY3HrLnv9QMltNB59cQ4M148WwgrbyR4mo3Fka2+aFhKs1FAKdpB
	fRWsNf9/cCmGz01jsfrGLCFDb8BEos1x7ADowQsG0Z5UsxCeo7wmeu1hQ0EpQtwWxX5JEC2Bfsh
	L1YXrSy01sour+58yCwkGpMux26DudLhqN82+EOErIbDvPehDPJUwHNEitvIXLTJZxK/8OLpuVU
	udDZiEaxC2qnlgu3Scp67BpaupzQVKZmqcwYtbeiz/Jn5xhaB/4nqWwCrcKbVfFMpeYvtCr+OYB
	uGUVO7YjGOTVM4t9vqIEQN5bWBzof1z7mZIzmwXJt4Z3XJwv7o2i3IOc1yiMiq8lnS/MIbUv9NY
	1cNhdDTXh0wQTb+OXKXZFSu2F3G6i09mYCQqERLEEGE5kA9nvyoBgyKiELHugYlClMTHuIRLHn1
	nwI2utUM4OJQMmjgvG3zkS9O4Exon9MjJAEsFF9Ac6fkYqnWQMZehL
X-Received: by 2002:a05:6820:1387:b0:716:c3a0:48db with SMTP id 006d021491bc7-716e78c0135mr318160eaf.25.1793904930446;
        Thu, 05 Nov 2026 10:55:30 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:30 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:17 -0700
Subject: [PATCH v10 01/26] mtd: rawnand: sunxi: centralize OOB handling
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-1-dca1f6ed29a8@gmail.com>
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

PIO and DMA interpret the same hardware-ECC results, retrieve protected
OOB bytes and check unreadable chunks for erased data in separate paths.
Keeping that policy in both transfer paths makes fixes easy to apply to
one path but miss in the other.

Share the processing through per-chip OOB operations selected at attach.
A read callback consumes one PIO step or a completed DMA batch. A finish
callback handles the OOB tail and returns the largest correction count.
Keep primary ECC-transfer sequencing and DMA ownership in the transfer
functions. Interpretation callbacks may issue supplementary OOB reads or
raw erased-page rereads. Carry the full-page buffer, page, correction
count and whether any chunk was erased in a per-read context.

Move user-data reservation and layout setup behind the same operations.
The existing plain and scrambled-with-plain-BBM modes share geometry and
read handling. Only the scrambled mode transforms the first two user bytes
to compensate hardware randomization and keep the on-flash marker plain.
Preserve fixed and variable user-data allocation, including the older
controllers' extra two-byte reservation when maximizing ECC strength.

This preserves the existing register accesses, transfer ordering, OOB
length selection, error handling and ECC accounting. In particular,
retain DMA's two passes: consume corrected OOB before raw erased-page
rereads. PIO keeps its current parity representation and physical reread
behavior. Spell out the PIO and DMA OOB-read branches so their different
parity reads remain visible. OOB-length fixes, read-error handling and
register-read caching are separate changes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 554 +++++++++++++++++++++-----------------
 1 file changed, 303 insertions(+), 251 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index f41feebe4257..80006d1a33d6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -256,12 +256,38 @@ struct sunxi_nfc_timings {
 	s32 tRHW[SUNXI_NFC_TIMING_STEPS];
 };
 
+struct sunxi_nfc_ecc_read;
+
+/* OOB geometry and interpretation; callbacks may issue supplementary reads. */
+struct sunxi_nfc_oob_ops {
+	/* Reserve OOB bytes for nsteps before ecc->steps is initialized. */
+	unsigned int (*min_user_data)(struct nand_chip *nand, int nsteps);
+	/* Install the user-data layout for the selected ECC geometry. */
+	int (*init_user_data)(struct nand_chip *nand, int nsteps);
+	/* Optional symmetric conversion of the on-flash bad-block marker. */
+	void (*transform_bbm)(struct nand_chip *nand, int page, u8 *bbm);
+	/*
+	 * first_step is page-relative; status bits use transfer-local slots.
+	 * PIO uses slot zero even when first_step is nonzero.
+	 * Return zero on success or a negative I/O error.
+	 */
+	int (*read_batch)(struct nand_chip *nand, struct sunxi_nfc_ecc_read *read,
+			  u32 status, u32 pattern_found, int first_step, int nsteps);
+	/*
+	 * Finish remaining OOB; return max bitflips or a negative I/O error.
+	 * cur_off is an absolute NAND column, or NULL if unknown.
+	 */
+	int (*finish_read)(struct nand_chip *nand, struct sunxi_nfc_ecc_read *read,
+			   int *cur_off);
+};
+
 /**
  * struct sunxi_nand_chip - stores NAND chip device related information
  *
  * @node: used to store NAND chips into a list
  * @nand: base NAND chip structure
  * @ecc: ECC controller structure
+ * @oob_ops: OOB geometry and ECC-result interpretation
  * @clk_rate: clk_rate required for this NAND chip
  * @timing_cfg: TIMING_CFG register value for this NAND chip
  * @timing_ctl: TIMING_CTL register value for this NAND chip
@@ -273,6 +299,7 @@ struct sunxi_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
 	struct sunxi_nand_hw_ecc ecc;
+	const struct sunxi_nfc_oob_ops *oob_ops;
 	unsigned long clk_rate;
 	u32 timing_cfg;
 	u32 timing_ctl;
@@ -908,6 +935,7 @@ static u8 sunxi_nfc_user_data_sz(struct sunxi_nand_chip *sunxi_nand, int step)
 	return sunxi_nand->user_data_bytes[step];
 }
 
+/* PIO uses register zero; DMA concatenates user data within each transfer. */
 static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
 						int step, bool bbm, int page,
 						unsigned int user_data_sz)
@@ -946,8 +974,8 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
 	}
 
 	/* De-randomize the Bad Block Marker. */
-	if (bbm && (nand->options & NAND_NEED_SCRAMBLING))
-		sunxi_nfc_randomize_bbm(nand, page, oob);
+	if (bbm && sunxi_nand->oob_ops->transform_bbm)
+		sunxi_nand->oob_ops->transform_bbm(nand, page, oob);
 }
 
 /*
@@ -1007,9 +1035,9 @@ static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
 	u8 user_data[SUNXI_NFC_MAX_USER_DATA_SZ] = {};
 
 	/* Randomize the Bad Block Marker. */
-	if (bbm && (nand->options & NAND_NEED_SCRAMBLING)) {
+	if (bbm && sunxi_nand->oob_ops->transform_bbm) {
 		memcpy(user_data, oob, user_data_sz);
-		sunxi_nfc_randomize_bbm(nand, page, user_data);
+		sunxi_nand->oob_ops->transform_bbm(nand, page, user_data);
 		oob = user_data;
 	}
 
@@ -1055,6 +1083,41 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 	}
 }
 
+/* Return whether the chunk is erased, and account for its ECC result. */
+static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
+				       u8 *data, int data_off,
+				       u8 *oob, int oob_off,
+				       unsigned int user_data_sz,
+				       unsigned int *max_bitflips)
+{
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	unsigned int oob_len = ecc->bytes + user_data_sz;
+	int ret;
+
+	/* Check the physical representation for bitflips in erased pages. */
+	if (nand->options & NAND_NEED_SCRAMBLING)
+		nand_change_read_column_op(nand, data_off, data, ecc->size, false);
+
+	nand_change_read_column_op(nand, oob_off, oob, oob_len, false);
+
+	ret = nand_check_erased_ecc_chunk(data, ecc->size, oob, oob_len, NULL, 0,
+					  ecc->strength);
+
+	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, ret);
+
+	return ret >= 0;
+}
+
+/* Shared across a read's transfers; buf remains the full-page buffer base. */
+struct sunxi_nfc_ecc_read {
+	u8 *buf;
+	int page;
+	unsigned int max_bitflips;
+	bool oob_required;
+	bool dma;
+	bool has_erased_chunk;
+};
+
 static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 				    int step, u32 status, u32 pattern_found,
 				    bool *erased)
@@ -1094,98 +1157,6 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	return NFC_ECC_ERR_CNT(step, tmp);
 }
 
-static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
-				       u8 *data, int data_off,
-				       u8 *oob, int oob_off,
-				       int *cur_off,
-				       unsigned int *max_bitflips,
-				       int step, bool oob_required, int page)
-{
-	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
-	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int raw_mode = 0;
-	u32 pattern_found;
-	bool bbm = !step;
-	bool erased;
-	int ret;
-	/* From the controller point of view, we are at step 0 */
-	const int nfc_step = 0;
-
-	if (*cur_off != data_off)
-		nand_change_read_column_op(nand, data_off, NULL, 0, false);
-
-	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
-
-	if (data_off + ecc->size != oob_off)
-		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
-
-	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-	if (ret)
-		return ret;
-
-	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
-	sunxi_nfc_randomizer_config(nand, page, false);
-	sunxi_nfc_randomizer_enable(nand);
-	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
-	       nfc->regs + NFC_REG_CMD);
-
-	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
-	sunxi_nfc_randomizer_disable(nand);
-	if (ret)
-		return ret;
-
-	*cur_off = oob_off + ecc->bytes + user_data_sz;
-
-	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
-	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
-
-	ret = sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL,
-				       nfc_step, readl(nfc->regs + NFC_REG_ECC_ST),
-				       pattern_found, &erased);
-	if (erased)
-		return 1;
-
-	if (ret < 0) {
-		/*
-		 * Re-read the data with the randomizer disabled to identify
-		 * bitflips in erased pages.
-		 */
-		if (nand->options & NAND_NEED_SCRAMBLING)
-			nand_change_read_column_op(nand, data_off, data,
-						   ecc->size, false);
-		else
-			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE,
-				      ecc->size);
-
-		nand_change_read_column_op(nand, oob_off, oob,
-					   ecc->bytes + user_data_sz, false);
-
-		ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
-						  ecc->bytes + user_data_sz,
-						  NULL, 0, ecc->strength);
-		if (ret >= 0)
-			raw_mode = 1;
-	} else {
-		memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
-
-		if (oob_required) {
-			nand_change_read_column_op(nand, oob_off, NULL, 0,
-						   false);
-			sunxi_nfc_randomizer_read_buf(nand, oob, ecc->bytes + user_data_sz,
-						      true, page);
-
-			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, nfc_step,
-							    bbm, page, user_data_sz);
-		}
-	}
-
-	sunxi_nfc_hw_ecc_update_stats(nand, max_bitflips, ret);
-
-	return raw_mode;
-}
-
 /*
  * Returns the offset of the OOB for each step.
  * (it includes the user data before the ECC data.)
@@ -1241,18 +1212,166 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 		*cur_off = mtd->oobsize + mtd->writesize;
 }
 
-static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf,
-					    int oob_required, int page,
-					    int nchunks)
+/* Interpret one PIO step or a completed DMA batch before reusing its status. */
+static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
+				    struct sunxi_nfc_ecc_read *read,
+				    u32 status, u32 pattern_found,
+				    int first_step, int nsteps)
 {
-	bool randomized = nand->options & NAND_NEED_SCRAMBLING;
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	unsigned int max_bitflips = 0;
-	int ret, i, raw_mode = 0;
+	bool randomized = nand->options & NAND_NEED_SCRAMBLING;
+	unsigned int user_data_sz;
+	int i, ret;
+
+	for (i = 0; i < nsteps; i++) {
+		int step = first_step + i;
+		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, step);
+		u8 *data = read->buf + step * ecc->size;
+		u8 *oob = nand->oob_poi + oob_off;
+		bool erased;
+		int bitflips;
+
+		user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
+		bitflips = sunxi_nfc_hw_ecc_correct(nand,
+						    !read->dma || randomized ? data : NULL,
+						    read->oob_required ? oob : NULL,
+						    i, status, pattern_found, &erased);
+		if (bitflips < 0) {
+			/* Preserve PIO data before the raw erased-page check. */
+			if (!read->dma && !randomized)
+				memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
+			continue;
+		}
+
+		if (erased) {
+			read->has_erased_chunk = true;
+			continue;
+		}
+
+		if (!read->dma)
+			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
+
+		if (read->oob_required) {
+			/* Keep the existing PIO and DMA representations of parity. */
+			if (read->dma) {
+				nand_change_read_column_op(nand, mtd->writesize + oob_off,
+							   oob, ecc->bytes + user_data_sz, false);
+			} else {
+				nand_change_read_column_op(nand, mtd->writesize + oob_off,
+							   NULL, 0, false);
+				sunxi_nfc_randomizer_read_buf(nand, oob,
+							      ecc->bytes + user_data_sz,
+							      true, read->page);
+			}
+
+			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, i, !step,
+							    read->page, user_data_sz);
+		}
+
+		sunxi_nfc_hw_ecc_update_stats(nand, &read->max_bitflips, bitflips);
+	}
+
+	if (!(status & NFC_ECC_ERR_MSK(nfc)))
+		return 0;
+
+	/* Finish consuming the batch's corrected OOB before raw error rereads. */
+	for (i = 0; i < nsteps; i++) {
+		int step = first_step + i;
+		int data_off, oob_off;
+
+		if (!(status & NFC_ECC_ERR(i)))
+			continue;
+
+		data_off = step * ecc->size;
+		oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, step);
+		user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
+		ret = sunxi_nfc_hw_ecc_read_error(nand, read->buf + data_off, data_off,
+						  nand->oob_poi + oob_off,
+						  mtd->writesize + oob_off, user_data_sz,
+						  &read->max_bitflips);
+		if (ret < 0)
+			return ret;
+		if (ret)
+			read->has_erased_chunk = true;
+	}
+
+	return 0;
+}
+
+static int sunxi_nfc_oob_finish_read(struct nand_chip *nand,
+				     struct sunxi_nfc_ecc_read *read, int *cur_off)
+{
+	if (read->oob_required)
+		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, cur_off,
+						!read->has_erased_chunk, read->page);
+
+	return read->max_bitflips;
+}
+
+static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
+				       struct sunxi_nfc_ecc_read *read,
+				       int step, int *cur_off)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int data_off = step * ecc->size;
+	int oob_off = nand_to_mtd(nand)->writesize + sunxi_get_oob_offset(sunxi_nand, ecc, step);
+	int page = read->page;
+	u32 pattern_found;
+	int ret;
+
+	if (*cur_off != data_off)
+		nand_change_read_column_op(nand, data_off, NULL, 0, false);
+
+	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
+
+	if (data_off + ecc->size != oob_off)
+		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+
+	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+	if (ret)
+		return ret;
+
+	sunxi_nfc_set_user_data_len(nfc, user_data_sz, 0);
+	sunxi_nfc_randomizer_config(nand, page, false);
+	sunxi_nfc_randomizer_enable(nand);
+	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
+	       nfc->regs + NFC_REG_CMD);
+
+	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, false, 0);
+	sunxi_nfc_randomizer_disable(nand);
+	if (ret)
+		return ret;
+
+	*cur_off = oob_off + ecc->bytes + user_data_sz;
+
+	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
+	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+
+	return sunxi_nand->oob_ops->read_batch(nand, read,
+					     readl(nfc->regs + NFC_REG_ECC_ST),
+					     pattern_found, step, 1);
+}
+
+static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, u8 *buf,
+					    int oob_required, int page, int nchunks)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	struct sunxi_nfc_ecc_read read = {
+		.buf = buf,
+		.page = page,
+		.oob_required = oob_required,
+		.dma = true,
+	};
 	struct scatterlist sg;
+	int ret, i;
 	u32 status, pattern_found, wait;
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
@@ -1299,83 +1418,12 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 	status = readl(nfc->regs + NFC_REG_ECC_ST);
 	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
 	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+	ret = sunxi_nand->oob_ops->read_batch(nand, &read, status, pattern_found,
+					    0, nchunks);
+	if (ret)
+		return ret;
 
-	for (i = 0; i < nchunks; i++) {
-		int data_off = i * ecc->size;
-		unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, i);
-		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-		u8 *data = buf + data_off;
-		u8 *oob = nand->oob_poi + oob_off;
-		bool erased;
-
-		ret = sunxi_nfc_hw_ecc_correct(nand, randomized ? data : NULL,
-					       oob_required ? oob : NULL,
-					       i, status, pattern_found,
-					       &erased);
-
-		/* ECC errors are handled in the second loop. */
-		if (ret < 0)
-			continue;
-
-		if (oob_required && !erased) {
-			/* TODO: use DMA to retrieve OOB */
-			nand_change_read_column_op(nand,
-						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + user_data_sz, false);
-
-			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, i, !i,
-							    page, user_data_sz);
-		}
-
-		if (erased)
-			raw_mode = 1;
-
-		sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
-	}
-
-	if (status & NFC_ECC_ERR_MSK(nfc)) {
-		for (i = 0; i < nchunks; i++) {
-			int data_off = i * ecc->size;
-			unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, i);
-			int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-			u8 *data = buf + data_off;
-			u8 *oob = nand->oob_poi + oob_off;
-
-			if (!(status & NFC_ECC_ERR(i)))
-				continue;
-
-			/*
-			 * Re-read the data with the randomizer disabled to
-			 * identify bitflips in erased pages.
-			 * TODO: use DMA to read page in raw mode
-			 */
-			if (randomized)
-				nand_change_read_column_op(nand, data_off,
-							   data, ecc->size,
-							   false);
-
-			/* TODO: use DMA to retrieve OOB */
-			nand_change_read_column_op(nand,
-						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + user_data_sz, false);
-
-			ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
-							  ecc->bytes + user_data_sz,
-							  NULL, 0,
-							  ecc->strength);
-			if (ret >= 0)
-				raw_mode = 1;
-
-			sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
-		}
-	}
-
-	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi,
-						NULL, !raw_mode,
-						page);
-
-	return max_bitflips;
+	return sunxi_nand->oob_ops->finish_read(nand, &read, NULL);
 }
 
 static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
@@ -1452,11 +1500,13 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	unsigned int max_bitflips = 0;
+	struct sunxi_nfc_ecc_read read = {
+		.buf = buf,
+		.page = page,
+		.oob_required = oob_required,
+	};
 	int ret, i, cur_off = 0;
-	bool raw_mode = false;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
@@ -1466,28 +1516,15 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 
 	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = 0; i < ecc->steps; i++) {
-		int data_off = i * ecc->size;
-		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-		u8 *data = buf + data_off;
-		u8 *oob = nand->oob_poi + oob_off;
-
-		ret = sunxi_nfc_hw_ecc_read_chunk(nand, data, data_off, oob,
-						  oob_off + mtd->writesize,
-						  &cur_off, &max_bitflips,
-						  i, oob_required, page);
+		ret = sunxi_nfc_hw_ecc_read_chunk(nand, &read, i, &cur_off);
 		if (ret < 0)
 			return ret;
-		else if (ret)
-			raw_mode = true;
 	}
 
-	if (oob_required)
-		sunxi_nfc_hw_ecc_read_extra_oob(nand, nand->oob_poi, &cur_off,
-						!raw_mode, page);
-
+	ret = sunxi_nand->oob_ops->finish_read(nand, &read, &cur_off);
 	sunxi_nfc_hw_ecc_disable(nand);
 
-	return max_bitflips;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
@@ -1513,11 +1550,12 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 					 u8 *bufpoi, int page)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
-	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	struct sunxi_nfc_ecc_read read = {
+		.buf = bufpoi,
+		.page = page,
+	};
 	int ret, i, cur_off = 0;
-	unsigned int max_bitflips = 0;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
@@ -1528,23 +1566,15 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = data_offs / ecc->size;
 	     i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
-		int data_off = i * ecc->size;
-		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
-		u8 *data = bufpoi + data_off;
-		u8 *oob = nand->oob_poi + oob_off;
-
-		ret = sunxi_nfc_hw_ecc_read_chunk(nand, data, data_off,
-						  oob,
-						  oob_off + mtd->writesize,
-						  &cur_off, &max_bitflips, i,
-						  false, page);
+		ret = sunxi_nfc_hw_ecc_read_chunk(nand, &read, i, &cur_off);
 		if (ret < 0)
 			return ret;
 	}
 
+	ret = read.max_bitflips;
 	sunxi_nfc_hw_ecc_disable(nand);
 
-	return max_bitflips;
+	return ret;
 }
 
 static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
@@ -2066,6 +2096,58 @@ static int sunxi_nfc_maximize_user_data(struct nand_chip *nand, uint32_t oobsize
 	return 0;
 }
 
+static unsigned int sunxi_nfc_oob_min_user_data(struct nand_chip *nand, int nsteps)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	unsigned int size = 0;
+	int i;
+
+	/* Variable lengths reserve the first word, which contains the BBM. */
+	if (nfc->caps->reg_user_data_len)
+		return USER_DATA_SZ;
+
+	for (i = 0; i < nsteps; i++)
+		size += sunxi_nfc_user_data_sz(sunxi_nand, i);
+
+	/* Preserve the older platforms' extra BBM reservation and ECC strength. */
+	if (nfc->caps->legacy_max_strength)
+		size += 2;
+
+	return size;
+}
+
+static int sunxi_nfc_oob_init_user_data(struct nand_chip *nand, int nsteps)
+{
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+
+	if (!nfc->caps->reg_user_data_len)
+		return 0;
+
+	/* Prioritize ECC strength, then use the remaining space for user data. */
+	return sunxi_nfc_maximize_user_data(nand, nand_to_mtd(nand)->oobsize,
+					  nand->ecc.bytes, nsteps);
+}
+
+/*
+ * Both modes use the same layout and ECC policy. Scrambled transfers also
+ * compensate the first two user bytes to keep the on-flash BBM unmodified.
+ */
+static const struct sunxi_nfc_oob_ops sunxi_nfc_plain_oob_ops = {
+	.min_user_data = sunxi_nfc_oob_min_user_data,
+	.init_user_data = sunxi_nfc_oob_init_user_data,
+	.read_batch = sunxi_nfc_oob_read_batch,
+	.finish_read = sunxi_nfc_oob_finish_read,
+};
+
+static const struct sunxi_nfc_oob_ops sunxi_nfc_scrambled_plain_bbm_oob_ops = {
+	.min_user_data = sunxi_nfc_oob_min_user_data,
+	.init_user_data = sunxi_nfc_oob_init_user_data,
+	.transform_bbm = sunxi_nfc_randomize_bbm,
+	.read_batch = sunxi_nfc_oob_read_batch,
+	.finish_read = sunxi_nfc_oob_finish_read,
+};
+
 static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 				       struct nand_ecc_ctrl *ecc,
 				       struct device_node *np)
@@ -2090,33 +2172,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 		ecc->size = 1024;
 		nsectors = mtd->writesize / ecc->size;
 
-		if (!nfc->caps->reg_user_data_len) {
-			/*
-			 * If there's a fixed user data length, subtract it before
-			 * computing the max ECC strength
-			 */
-
-			for (i = 0; i < nsectors; i++)
-				total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
-
-			/*
-			 * The 2 BBM bytes should not be removed from the grand total,
-			 * because they are part of the USER_DATA_SZ.
-			 * But we can't modify that for older platform since it may
-			 * result in a stronger ECC at the end, and break the
-			 * compatibility.
-			 */
-			if (nfc->caps->legacy_max_strength)
-				bytes -= 2;
-
-			bytes -= total_user_data_sz;
-		} else {
-			/*
-			 * User-data lengths are encoded in four-byte units. Reserve
-			 * the first word because it contains the two BBM bytes.
-			 */
-			bytes -= USER_DATA_SZ;
-		}
+		bytes -= sunxi_nand->oob_ops->min_user_data(nand, nsectors);
 
 		/*
 		 * Once all user data has been subtracted, the rest can be used
@@ -2175,20 +2231,12 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 
 	nsectors = mtd->writesize / ecc->size;
 
-	/*
-	 * The rationale for variable data length is to prioritize maximum ECC
-	 * strength, and then use the remaining space for user data.
-	 */
-	if (nfc->caps->reg_user_data_len) {
-		ret = sunxi_nfc_maximize_user_data(nand, mtd->oobsize,
-						   ecc->bytes, nsectors);
-		if (ret)
-			return ret;
-	}
+	ret = sunxi_nand->oob_ops->init_user_data(nand, nsectors);
+	if (ret)
+		return ret;
 
-	if (total_user_data_sz == 0)
-		for (i = 0; i < nsectors; i++)
-			total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
+	for (i = 0; i < nsectors; i++)
+		total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
 
 	if (mtd->oobsize < (ecc->bytes * nsectors + total_user_data_sz))
 		return -EINVAL;
@@ -2232,6 +2280,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 
 static int sunxi_nand_attach_chip(struct nand_chip *nand)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	const struct nand_ecc_props *requirements =
 		nanddev_get_ecc_requirements(&nand->base);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
@@ -2254,6 +2303,9 @@ static int sunxi_nand_attach_chip(struct nand_chip *nand)
 	if (!ecc->size || !ecc->strength)
 		return -EINVAL;
 
+	sunxi_nand->oob_ops = nand->options & NAND_NEED_SCRAMBLING ?
+		&sunxi_nfc_scrambled_plain_bbm_oob_ops : &sunxi_nfc_plain_oob_ops;
+
 	switch (ecc->engine_type) {
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
 		ret = sunxi_nand_hw_ecc_ctrl_init(nand, ecc, np);

-- 
2.53.0

