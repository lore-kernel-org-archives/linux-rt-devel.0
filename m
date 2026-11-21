Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223467;
	b=nNln61952T8Vz8ZdQrjJXE7sjoyedVR9ig8/zHH8UM9YDIdYcvp9DnCaMKm8VF28M010
	 d+HUJ8DrYZlCtW/EgzgYmZehAMCvvir8q12UpzouxYHJ7NzrCmDnf/mPjBUe++2jGagIw
	 aFqxvxttkerkc/3Ng5A5X8Rw+etV8/tOtrViSbvDRyyeKmT+/BWnoILU/ol3MgLd8Mmrb
	 CNG0u22p1X+xRvixv7TzHH5en5sb3Izwm1yFIKCdPyOhAHV/6Js9SB1pXm3GnxrN6UWkz
	 hAtp4MtE4EsekFFSMQAnXCn74a/Cex4t293NDDYU5A8gfUg5A9P+NCk+dgQs8Fs0sGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0IrAGyQNQ+9vmexJ3HX+RGvKm7PP0ZR37lEcYjBayK8=;
	b=5NHTJZvVzaq0B5jUqZ6kgVBDkxmXOJ6DMoXapYoOUlyudOSc/5i7PewCb7+ukNPbxhrr
	 b1HlKAXNGkJVelzbs4xXN4zThefcmX8BZXokLpcIRkYlrmf8OrKSHXvL713ltWy9gb3wp
	 hyjLovps/P6Qf5PFPmputH5JMP0J9YldnXeaSAILt3QmWe43hB1WYIz1amZnFcmEs2qu0
	 StqxE/oXQMU3XLZTm+GalWi/Ya55l7n9ygBBsbbpL8E4x79Ee+OEzcQqgYKS+XW0HxmxB
	 DV/1bnFKRkjyYIs6V2D9IusbGpO0qy21b8eNJhbfS6VKy/kId6stly05DJXboMh96ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jk4sMuO6;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C16606A6B5
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C16606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jk4sMuO6
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4d7034a99a9so956029b6e.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223464; x=1795828264; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0IrAGyQNQ+9vmexJ3HX+RGvKm7PP0ZR37lEcYjBayK8=;
        b=Jk4sMuO65cf+WkxByHKVgx9u5D4IjgeiTaOxGVA59AWVi08g6KYWuOnIJ1yVjN3X9F
         KFQVtNHnBPZccuZ8OXrI4FTGuwo3ufCUko6BC4KWreCXRak8FhggyfmqxYp4D6bo12l2
         FiJouxRvSGDYn/hNShLzQ30YWS5VbBmv/9iRD9F31TPbyQfVGhd9tZLfiFZt3kzZPrqH
         t7wLzgdX1Om0a6o5d1/pLfFQStpiJ3daFt28Oh70FOG12CMpet5OSVyPYzpPzeDOcGLl
         D7F79EhU/28QzSOq6zm6v2xFtOCl9/HTWAO3HClZQceeySqra5yzkzOS29+R0oRdxT8o
         yTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223464; x=1795828264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IrAGyQNQ+9vmexJ3HX+RGvKm7PP0ZR37lEcYjBayK8=;
        b=C69na36xsyEii64vTlFbVKZ8a244rMSub1GF7ymiKw0iiGuVlQ8FQOmO4WzxpdqZhB
         qagk/imVPbVw4HKgiE09xRWjw9NOB6pfHUawvlSPJxy8NpqcDMGi0O2NkOKlkOr6x6ET
         CrZ6I7uCLIQ7GPGiHWmmXXwtYZdRhKXK2VqVQ4BgpdX7HLlbVvTtrhzAVFcp9EGaoFBw
         WqS0ZUvYeD1hp8HMiL9o2TwTMZ5S03DEQI5d2pfx1H9GqVX0w4HDeze1ZM06VuAkYBwG
         Nnykj+vvfWMa1OEhDctX5F6cVmLOxfjhOJWXAbOQ1zs02IQvtVvcUBtRRbef3yAEP6SG
         cLXA==
X-Forwarded-Encrypted: i=1; AL+hErEe/pYRc9hx/WeF92vs4pDLf62G4bZg3pyCKb7SbNMlhJv/B042S1uYOBj4Gmk6VXZtGRyp1QbtJZEF/YRAfQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ftaTkC75a7Dag84CzglPWaTV7akko9EeIWMoTo1NS2wa/l5ou
	FMU95ZX7PK+aRLrc29mwexmJVXxmZNZi+3yWntiptVbnWYCktCh8rmtA
X-Gm-Gg: AYBFou3aUAXIwtqbHy7Oasjpm6nAQgXsbVD4N4lCg0ujaPw+XbY31Vxh4dUTjAUlnae
	7lg3f6Pn4KgtOxxTSYGrPOyrXechhBMhwG6I2pIRj9hzGagssj52cnVic2tFnIqMc3WA16JWCVk
	JQ/8cP/4UkIPXLLwvMlrWRYXBQkTUlE9kw5D9V4ie3dwzxRPHn3VG8Q6i6iP7QXXrhqQOuM/ZrY
	ZJWeReNaOV0g0c2Zt/IJXPs6vzPXsr38gyWbwCN7D55y2DTmwYdk8FSQVOmME3xKdU4Y6fi5w87
	SrZBZnLpU3PiGeVcgrgiCPi5WxzZB1mJUimeURWYJzNuThexe3HY3KiEPo8+LDKNlk3ANlXdhn6
	X1I0KXZ7Rsxs9eNa/v7jq77DuCIAvw6SLCaGws1AJqI23pxOmZJEHTkSZXa9o5kv32tv+q7H564
	xKtXg8qIy2iy+yRMYGPMrbiTISVfHJlNsrWIEygICW0N3qej7uGYTjSFFvAyAj95zYBsLhvo0A8
	EOtD3JTciEodasUFR4uQDf9osLIEJp0oINOWCC1tLrMqV7/qeMHrjNK9hMK83QztNapVnlMQZ4j
	tfaKdM1cecQzxQeNp10XNtIr5YUYffrCRkq/jsKetnlJisFNBM2LAUBOqNQPAWeZWYijIstcJC+
	yIPXFWEoi90EPZOwsKbwWYZSiRZvQ/Wr9+XjPC5Nkaah0JbvKEKMDzvij4lIxHw0WBFRNIChOSS
	A5DzQFeSLgd+hqyAb4joS/SezLCHelCriXYtQeAFYioCW9M5yiyqv3
X-Received: by 2002:a05:6808:6d93:b0:571:4e99:7942 with SMTP id 5614622812f47-57a0b65aeb8mr5797462b6e.48.1795223464361;
        Fri, 20 Nov 2026 17:11:04 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:03 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:29 -0700
Subject: [PATCH v11 06/26] mtd: rawnand: sunxi: use page reads to
 reposition small-page NAND
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-6-9721b1905ef4@gmail.com>
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
 devicetree@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev

On a chip with 512-byte pages, an ECC read can fetch bytes from the
wrong column. The driver uses nand_change_read_column_op() to move
between main data and OOB and to reread a possibly erased chunk. That
helper rejects small pages because it uses large-page random-output
commands. Some callers then continue without repositioning the chip.

Use nand_read_page_op() to select the requested small-page column.
The NAND core chooses READ0, READ1 or READOOB and sends the page
address again. Keep the random-column command on larger pages.

Use PIO for full-page ECC reads and writes on small pages: the DMA
sequencer uses large-page random-column commands. Sequential small-page
writes need no change-column command.

This fixes the command sequence for an otherwise supported layout. On
8-bit small-page NAND the factory marker at byte 5 still lies outside
the reserved marker bytes. On 16-bit NAND the core uses byte 0, but
the driver does not program the controller for a 16-bit bus.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260913041642.E28F81F000FF@smtp.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 086618dee999..9d7e3e6f22b2 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1028,6 +1028,16 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 	}
 }
 
+static int sunxi_nfc_read_column(struct nand_chip *nand, int page,
+				 unsigned int column, void *buf, unsigned int len)
+{
+	/* Small-page NAND needs a new READ0/READ1/READOOB and the page address. */
+	if (nand_to_mtd(nand)->writesize <= 512)
+		return nand_read_page_op(nand, page, column, buf, len);
+
+	return nand_change_read_column_op(nand, column, buf, len, false);
+}
+
 /* Shared across a read's transfers; buf remains the full-page buffer base. */
 struct sunxi_nfc_ecc_read {
 	u8 *buf;
@@ -1111,10 +1121,10 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 
 	/* Check the physical representation for bitflips in erased pages. */
 	if (nand->options & NAND_NEED_SCRAMBLING)
-		nand_change_read_column_op(nand, data_off, data, ecc->size, false);
+		sunxi_nfc_read_column(nand, read->page, data_off, data, ecc->size);
 
-	nand_change_read_column_op(nand, nand_to_mtd(nand)->writesize + oob_off,
-				   oob, oob_len, false);
+	sunxi_nfc_read_column(nand, read->page, nand_to_mtd(nand)->writesize + oob_off,
+			      oob, oob_len);
 
 	ret = nand_check_erased_ecc_chunk(data, ecc->size, oob, oob_len, NULL, 0,
 					  ecc->strength);
@@ -1141,8 +1151,8 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 		return;
 
 	if (!cur_off || *cur_off != (offset + mtd->writesize))
-		nand_change_read_column_op(nand, mtd->writesize + offset,
-					   NULL, 0, false);
+		sunxi_nfc_read_column(nand, page, mtd->writesize + offset,
+				      NULL, 0);
 
 	if (!randomize)
 		sunxi_nfc_read_buf(nand, oob + offset, len);
@@ -1200,11 +1210,12 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		if (read->oob_required) {
 			/* Keep the existing PIO and DMA representations of parity. */
 			if (read->dma) {
-				nand_change_read_column_op(nand, mtd->writesize + oob_off,
-							   oob, ecc->bytes + user_data_sz, false);
+				sunxi_nfc_read_column(nand, read->page,
+						      mtd->writesize + oob_off,
+						      oob, ecc->bytes + user_data_sz);
 			} else {
-				nand_change_read_column_op(nand, mtd->writesize + oob_off,
-							   NULL, 0, false);
+				sunxi_nfc_read_column(nand, read->page,
+						      mtd->writesize + oob_off, NULL, 0);
 				sunxi_nfc_randomizer_read_buf(nand, oob,
 							      ecc->bytes + user_data_sz,
 							      true, read->page);
@@ -1260,12 +1271,12 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	int ret;
 
 	if (*cur_off != data_off)
-		nand_change_read_column_op(nand, data_off, NULL, 0, false);
+		sunxi_nfc_read_column(nand, page, data_off, NULL, 0);
 
 	sunxi_nfc_randomizer_read_buf(nand, NULL, ecc->size, false, page);
 
 	if (data_off + ecc->size != oob_off)
-		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+		sunxi_nfc_read_column(nand, page, oob_off, NULL, 0);
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -2105,7 +2116,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	ecc->write_oob = sunxi_nfc_hw_ecc_write_oob;
 	mtd_set_ooblayout(mtd, &sunxi_nand_ooblayout_ops);
 
-	if (nfc->dmac || nfc->use_mdma) {
+	/* The DMA page sequencer uses large-page random-column commands. */
+	if (mtd->writesize > 512 && (nfc->dmac || nfc->use_mdma)) {
 		ecc->read_page = sunxi_nfc_hw_ecc_read_page_dma;
 		ecc->read_subpage = sunxi_nfc_hw_ecc_read_subpage_dma;
 		ecc->write_page = sunxi_nfc_hw_ecc_write_page_dma;

-- 
2.53.0

