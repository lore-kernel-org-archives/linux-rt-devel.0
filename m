Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223485;
	b=ATgRlyyQHHTUnbp4+TPbK+3/mHDpygyTieRq6252MgNJrA5x7y9H609DWxcmS0V3d01t
	 5qXBoR78TAFRS9zn5RrijTrgYb7GphEUEkEYxNNvwyU+Aw95HMZTqBIA2JhlSepqMAqaU
	 q9gbf+6xprI5ndpoe0o32Y4Xrf7yMskrKtzIKNJ759OSaReGSHdFKkFvLsewj49CYR1CX
	 HvaXzA55lOR6XVD2dmAVsXK+7NBLz4Y5wtsR9HX/WvV+0w1m4Gv4wCUXHl0RDXypkacCM
	 5JeWvG7fdn9aCtxZLI3zqEH7znwlE1sbf6bSl3RsR7L57H7zHgfbYdtxrZcmVo5Qf9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=25Y0T/EWWqPPUndC1dVyA3/WPrprnkSUm6qbYkkV3TY=;
	b=UCJSAURPFZRqwEzmIHesb4yeVuMgMjhBP1yoMbjClW+LlVQkASceldCdVRCWlMwdNVKL
	 k5Jz2Fj+sqjMRRu3FtweW//oLqjILCNzyt3qa0CcgATgV4/44UZE9gvhhz4yCGzwQn30r
	 lnoksPEnkgKQzfFkC830MCP02zC5DSt2niClUvwsmUKDC4M+isiM8hJuOBni2IyD5tiSE
	 hQ9hDWE3HawICluSWaf16W3dCKw3DNQMlHiSnGP0g1xEqRE3zEAwZ6n0OkMS+V0FKAnO8
	 JOi7t01PONJpzyx3K16gea2Rrf3Us6yQVGAgSK4K8nDHRZflyJg8lyddt8m4a13eQeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=izAJxhhg;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6F60A2611
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE6F60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=izAJxhhg
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-85c1135c286so1127808a34.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223473; x=1795828273; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25Y0T/EWWqPPUndC1dVyA3/WPrprnkSUm6qbYkkV3TY=;
        b=izAJxhhg/HCeHqTeGMwPXz+N63Rg/0mQUeBVuAZ/AqkGv5Jyg8zgiGaGPUJyjcSBsq
         XYVOM2NnWtOTk1uY57M0MAguKaL/yOFd7ZcPboy5gLXtB9/0mD5Z9feu14IxE5C8P3w9
         LGWeUzJBKME6/APlDb00wN+UBDXXJLljKlrs2sUOp0kKz/0RWnOr2IFZfQ+uvPV3dO21
         dHT3I0PhoSyYx4aygHQBLGPUfN6A7iUvM9j1RilLCdEE4Vd7fC42IMVyH16sfxbIL3Zo
         uVkLqMMjvdsPSTVB+2e900HBH6JtauA6KBp6/g8+44UTNXcVgSn1yPkygoM/K7w7Jzlm
         9wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223473; x=1795828273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25Y0T/EWWqPPUndC1dVyA3/WPrprnkSUm6qbYkkV3TY=;
        b=rbofVbTp9trejqRZ8VD1rAL7so9U28iwfJHZg8IunwQomlyEEy3fNFE2VDZEfsPM53
         eKIPK85RIblJou/396ej8jY5K2fHEQZ1l/IW2u0Ss1b3e+rk2zhY1uFNR3ao6ckQY8PF
         arytxxDYVaASPY6ofFqebwVs49I368C5EzzHI0CG90yEv/eK9MAiGqDqJrORAhO4eW0H
         WGSQf/0OYkbvKGcWmXUlwMFtIqRK9p57bjti3UwTVt7O65rtsOpVp5ADFLtPyeX5T3tK
         VnDbwWEkeZct6eMQlDb75PQQy54CuVJaHxmAs/euf147r0zZ0Qt0ZWUndR3J8esmCKGZ
         A/QA==
X-Forwarded-Encrypted: i=1; AL+hErE3U2yimNIUuobPJaaOxPF2N3EjcZDq/lp4ph28wAVPJ7xLkY8h62pyLNcoV4VyqFfAbw+GYi4ra+sVRSNbRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ZzLdpDz7XM+2WqiSQ6n3Fuk00sKikPq/o1WN5lyzR71tvs9MD
	rRlM3zHtN1sZKUBdyofbgEerTdr5Lz8m5TTkj4Z+H/YMFvfaKvHNSV2C
X-Gm-Gg: AZFdTZe4M/GPEuHtjTpV5FJF5I5P1mIzcoiKvDBjojhWHJxrDuS51YAC4oaucJuMMiF
	meoGtzlwbwSoZsp4uTBhoPjuDuiKtuupLlklmH5e9LUfD5Jk7Y3zdr3NNzt/ju7ncUbZ+GrLVl8
	PvC3JEDTQfH01LqPh6jYIXc3v2+DKY+Rf3qJWSSciodid8mwre28Bzka+YqKzDOH9dnMmu84m+4
	BMpfMXzkhIrPAMRpeYezJgEHK57AYGJKuYmWL0bJApUB9H3E96UjwFC1E1MpTdUgjETAGvs0u+j
	GuOpniF69CKwctOW5iz+LT3GJwPePN0383af3sU/BdXb8pOYyy0G7m1ag1JLTgnJ7Ddq+flccvk
	/6mQ0L9QKy71Z8nvz3D6uZfpR/Ic8VBzh+Da9erUHS9UPYlUe0UyzN/oBXXM41zt2hR5jbThSJc
	CQjyA7qSvWfagqnpG70ubX+9tl7THhr7U8R2QtQVYjpEeTwBQ2w2rEHFuQo+qmK1WHxbXVlvISq
	t0rx27FuqUoEZlq9VVDagCrLJSd80t3rJnkpvRZPfMx7qizGrIdOw2S7j6OFv+XBjiMbqCPa+Dp
	CZvSauooV7xIJNVBTV6w1qW0Hlis46NO6Y2RhTkPj8MuUYTyNJ9W9tbWOEnkiY5DctKnYSNJWAu
	k60v9RCxiIq/Knqpndo7eqASjHLm/fTyRuwZFi2Ow615Wgjn8Gz7tyviSsWOdMUWWsKTTZGSsxb
	vBuOuO54PT6QQ3TKeskEMyYIeT4bJvMsQ1E/SlSD1hbYqfK1mTPhez
X-Received: by 2002:a05:6808:1986:b0:572:72d4:9ac9 with SMTP id 5614622812f47-57a09e0d7c4mr6351251b6e.27.1795223472625;
        Fri, 20 Nov 2026 17:11:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:12 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:35 -0700
Subject: [PATCH v11 12/26] mtd: rawnand: sunxi: handle ECC results in the
 batch reader
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-12-9721b1905ef4@gmail.com>
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

The batch reader must know whether the corrected bytes are ready to
use, need to be filled with a hardware-detected pattern, or need a raw
reread to distinguish an erased chunk from an uncorrectable one. The
correction helper returns zero both for a pattern and for data with no
bitflips, so its caller tests the pattern bit a second time to avoid
overwriting synthesized bytes.

Handle the three outcomes in the batch reader. When a slot reports both
an ECC error and a pattern, keep the existing error-first ordering.
Preserve the data for the raw erased-chunk check and run that check
after collecting corrected OOB for the batch. For a pattern without
an error, fill the applicable buffers once; only an all-ones pattern
marks the chunk erased. Read the correction count only for an ordinary
step.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 70 ++++++++++++---------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 538ffcc79108..e76f7cc67081 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1070,41 +1070,12 @@ struct sunxi_nfc_ecc_read {
 	bool has_erased_chunk;
 };
 
-static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
-				    int step, u32 status, u32 pattern_found,
-				    unsigned int user_data_sz, bool *erased)
+static unsigned int sunxi_nfc_hw_ecc_read_count(struct nand_chip *nand, int slot)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	u32 tmp;
-
-	*erased = false;
-
-	if (status & NFC_ECC_ERR(step))
-		return -EBADMSG;
-
-	if (pattern_found & BIT(step)) {
-		u8 pattern;
-
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
-			pattern = 0x0;
-		} else {
-			pattern = 0xff;
-			*erased = true;
-		}
+	u32 count = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, slot));
 
-		if (data)
-			memset(data, pattern, ecc->size);
-
-		if (oob)
-			memset(oob, pattern, ecc->bytes + user_data_sz);
-
-		return 0;
-	}
-
-	tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, step));
-
-	return NFC_ECC_ERR_CNT(step, tmp);
+	return NFC_ECC_ERR_CNT(slot, count);
 }
 
 /*
@@ -1203,35 +1174,38 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	bool randomized = nand->options & NAND_NEED_SCRAMBLING;
 	unsigned int reg_index = 0, user_data_sz;
-	int i, ret;
+	int slot, ret;
 
-	for (i = 0; i < nsteps; i++, reg_index += user_data_sz / 4) {
-		int step = first_step + i;
+	for (slot = 0; slot < nsteps; slot++, reg_index += user_data_sz / 4) {
+		int step = first_step + slot;
 		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, step);
 		u8 *data = read->buf + step * ecc->size;
 		u8 *oob = nand->oob_poi + oob_off;
-		bool erased;
 		int bitflips;
 
 		user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
-		bitflips = sunxi_nfc_hw_ecc_correct(nand,
-						    !read->dma || randomized ? data : NULL,
-						    read->oob_required ? oob : NULL,
-						    i, status, pattern_found,
-						    user_data_sz, &erased);
-		if (bitflips < 0) {
+		if (status & NFC_ECC_ERR(slot)) {
 			/* Preserve PIO data before the raw erased-page check. */
 			if (!read->dma && !randomized)
 				memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 			continue;
 		}
 
-		/* Both patterns are already filled; only all-ones is erased. */
-		if (pattern_found & BIT(i)) {
-			read->has_erased_chunk |= erased;
+		if (pattern_found & BIT(slot)) {
+			u32 pattern_id = readl(nfc->regs + NFC_REG_PAT_ID(nfc));
+			u8 pattern = pattern_id & BIT(slot) ? 0xff : 0;
+
+			if (!read->dma || randomized)
+				memset(data, pattern, ecc->size);
+			if (read->oob_required)
+				memset(oob, pattern, ecc->bytes + user_data_sz);
+			if (pattern == 0xff)
+				read->has_erased_chunk = true;
 			continue;
 		}
 
+		bitflips = sunxi_nfc_hw_ecc_read_count(nand, slot);
+
 		if (!read->dma)
 			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
@@ -1260,10 +1234,10 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		return 0;
 
 	/* Finish consuming the batch's corrected OOB before raw error rereads. */
-	for (i = 0; i < nsteps; i++) {
-		int step = first_step + i;
+	for (slot = 0; slot < nsteps; slot++) {
+		int step = first_step + slot;
 
-		if (!(status & NFC_ECC_ERR(i)))
+		if (!(status & NFC_ECC_ERR(slot)))
 			continue;
 
 		ret = sunxi_nfc_hw_ecc_read_error(nand, read, step);

-- 
2.53.0

