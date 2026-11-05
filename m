Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904955;
	b=WHhgNSzDltwyWohgtKdZ8vgXS7B05Yx44MAN6wXkI5tSsuFjrX2wc5eP/GH1KV4gx28o
	 VdaEbLfR6FAsDRrsHYuq7mRbHifw5rEBU8+UG296byb4MP7DhunJWDPjVaZUj7h6vUANe
	 h6KVafkKuq6x+q0puIw24zzML4EgZHx2J4fXItRTsP6ZjC4ROB4qAiZIhEZJGvDfamvB8
	 IfRpfneohoxfljfPUIEoqqLYktw7QQmnR3SL66PSH3ZMWcDkvYtlqYNl24Ae3I9r1GPpE
	 tfrB3Q5HopN1UWktJoEI4d04/ShZLa7tTTYWpTDs9mSuNdCB5ibTCfQcTD6GT3LjNRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=TewWxDRlBExCimd2doTjt5ku/ZOc7YaK3BqCExDTIIk=;
	b=SAY+J7sLwpMPy8udRDMSgqLrK0tVTN+88p8LvJDlN6nNydVtlVvX39lu71aMZ2qstayQ
	 7Thy1cXmIwDN0XlJoJMGJ+DZb7MHFBJpa3FE/lNVIxwFdJgKKXxK4RC2c6DutIdUhlNuj
	 JHN0aDyeuibS9nNsNcOoZYJ1/uzi3Xgh01jlUs8wvwY7BWDMhv5MENKWkTLb/uLYHSHYA
	 3bKe/3BGOuDjh5ARI6w3Mv4MldsbgSFPtPCAvsoOV6VImL3x/TN799r6NKZuCIQ46ofsq
	 hXfc3AIHgmUa6WIlFdB5lMfErIubiC6Ukmv/8Uelhgg+BD5ArG0sDPos9RL5aP2pgTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="d/v+FahZ";
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24B6082BD0
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E24B6082BD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/v+FahZ
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6de2f213b7aso1047854eaf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904953; x=1794509753; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TewWxDRlBExCimd2doTjt5ku/ZOc7YaK3BqCExDTIIk=;
        b=d/v+FahZhW7GnTuC+eaQgIu7UwPOo0PzDvbDOVLaFlajd4m7mrc2e3CgxZHRWv4j/I
         aJRodNTm/zRQl1bKhpHnpBHy06fmSkAymLCDBf9YSzdcDCJ3oEfUYin/1HOiYaOrkjuP
         H8EmyKxP2oTPtmBcTneOd2mljwmU1xWNP04ViOYeSWm5RmNZYAJF32N8mkdgZQ73uv5Y
         7G/QlhvS2nG+31uNgp3YnMm49Ha6uzJmsoL+yXiphs2InmYw8OrRdwlqjYRrUHddBA7S
         XNxkNfesz2HOtA80Ey4HF36bDhV9OFr1Y1wRocgwTjrLLgQfd91yqxVK0b2iLGOGQMgP
         nKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904953; x=1794509753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TewWxDRlBExCimd2doTjt5ku/ZOc7YaK3BqCExDTIIk=;
        b=nbwcG3p+nKmmPtgOaOwn5PwCzZ/f3Mv1uVACvNnp86mtBq1u5ZFhG8z5TacCojBA8p
         wYG77LPszvjlocri7G6epteZIeJHr90RDVAGwKmesZ7k+ehvD3RLzzO5kCf3OEz1Vuqa
         iX7xyzO+Ksq2uAYqUB3ooh4HKFuTnmGs32gSr3AXxPR2h0pkBWgaQ8SITpoL0MA+7veT
         lcqV5BDOo0FeRllfu200U6OLeFLwDJNLtQSnZp684X6VXj4KyQZRwH7l0gwE/QYaWfOj
         iradmrY0KdvpUzg0sbiklAgWxIhN0p0NqDkZOQjPFSb5mYyiwihdJo/sfdSS08Wo4TmC
         ae9Q==
X-Forwarded-Encrypted: i=1; AKwUvBy2sBkoZT6/xYORIq8VrSKwsWXTiogakcgv5hFJ/HTLYaGq/QpBhbiFy2Bwq+vhH14m+r9fTC+WJYL9WohmWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8CEpeMNAz66j3g9PYz2KVROD4vfXSgAbgUN/HyZdvObwcGigrU
	pv5YeguMWdbLNyUOSrgaI8SdavY6VCgvAaNoVwnr2Iojwv3Mc4/8qHwV
X-Gm-Gg: AYBFou0p7xdbNY2qfC9u7+ZzBZPapAA1MpiLOGDjYirxUjxHaKTbv4In68dSy6uSg6T
	UfQh6FGgFNahPabMudx+PPTotuJP4EwminSR5T+PhH/LvlNuZH9X70KPEaY7szz96La9Fwz9gLl
	jyD1Dtn0nAM7ZFkyv6k9HaIGetA9Vp4kaYGZw+lSY61IRIvTYWysKazT9H+qTkw5gW4GZShdNoa
	QZbUwP/0L4I6EYgySYDmpGys7xaJdojSMhrAfl4Hd34BZZSGsz1/4QGkJjDVpifyJYyIQTX+zNZ
	0Kat5vErdGY8ZhMdEeHQtfR+UCS97J9V2WViGggXOQ6EQ7kNfmLZhvh+wcZurCeAlftlZd/dZ/H
	rLusZTnMeoKcMhE5SqDr9/NOaXQnqJYg3AphjO1htWrMSvJ/Ikjwxktu3vsDMsPcabx0awx0OI1
	moGVWeHaVOUdJ3ExpbOc0IhpIL3+EtlLGKZH1n5LXQh+zGSXQ8no/Wg7HKv1tsDCz3sh+omHMwb
	+Eeov+vyhuZ6npcVNbsYcNzNvsPiLVK1lhThlsiSRmMwmayHaty4DOgQsw6QRcVp5zqdF+4+FRu
	bIe0Ttw5qfVeuQgafl2Oz9N9BOzWKL2cV2IcLCLCL8q5CHS2M84NYP7wge4YD04lrXI/guRwkFY
	KQhK2LiVWRZmTi5FE/Fbj39VxJVx8FIUA/+bne1QIdVF+ueP2r9f7SnLaXXVZ8WSGbpJr6jIRRC
	Qb57VHiw2kLmWEplLz0yF/gj+chkp9d7EKcrxWZr4XbgKJA7qZqXpn
X-Received: by 2002:a05:6820:340b:20b0:708:ccf9:886b with SMTP id 006d021491bc7-716e79e8540mr267932eaf.84.1793904953478;
        Thu, 05 Nov 2026 10:55:53 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:53 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:29 -0700
Subject: [PATCH v10 13/26] mtd: rawnand: sunxi: use page reads to
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-13-dca1f6ed29a8@gmail.com>
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
 devicetree@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

The hardware-ECC reader moves between main data and OOB, and rereads raw
bytes when checking a possibly erased ECC step. It uses
nand_change_read_column_op(), which sends large-page random-output
commands and rejects NAND pages of 512 bytes or less. For a small-page
geometry accepted by hardware-ECC setup, these reads therefore fail when
they need to reposition, rather than using the small-page read commands.

Add a read-column helper that uses nand_read_page_op() on small pages.
The core selects READ0, READ1 or READOOB for the requested column and
sends the row address again. Pass the page number through the
erased-check path as well, and preserve errors from the resulting
operation. Keep the existing random-column operation for larger pages.

Select PIO for small pages even when DMA is available: the DMA PAGE_OP
sequencer uses large-page random-column commands internally.
This corrects read-side repositioning only; the write-column helper still
rejects small pages. Software-ECC and raw callbacks are unchanged.

This is a command-path correction found by inspection, not a claim that
ordinary 512+16 NAND becomes supported. The existing controller-ECC
limits still apply: it needs 512-byte ECC support and at least 28 parity
bytes plus four user-data bytes, so 512+16 remains rejected. No
small-page hardware validation is claimed.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260913041642.E28F81F000FF@smtp.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 40 ++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 5f57c5998f03..931d437e196b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1077,6 +1077,16 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
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
 /*
  * Return 1 for an erased chunk or 0 for an uncorrectable chunk, with ECC
  * statistics updated in either case. Negative values report transport errors.
@@ -1085,7 +1095,7 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
 				       unsigned int user_data_sz,
-				       unsigned int *max_bitflips)
+				       unsigned int *max_bitflips, int page)
 {
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	unsigned int oob_len = ecc->bytes + user_data_sz;
@@ -1093,13 +1103,12 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 
 	/* Check the physical representation for bitflips in erased pages. */
 	if (nand->options & NAND_NEED_SCRAMBLING) {
-		ret = nand_change_read_column_op(nand, data_off, data,
-						 ecc->size, false);
+		ret = sunxi_nfc_read_column(nand, page, data_off, data, ecc->size);
 		if (ret)
 			return ret;
 	}
 
-	ret = nand_change_read_column_op(nand, oob_off, oob, oob_len, false);
+	ret = sunxi_nfc_read_column(nand, page, oob_off, oob, oob_len);
 	if (ret)
 		return ret;
 
@@ -1201,8 +1210,8 @@ static int sunxi_nfc_hw_ecc_read_extra_oob(struct nand_chip *nand,
 		return 0;
 
 	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
-		ret = nand_change_read_column_op(nand, mtd->writesize + offset,
-						 NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, mtd->writesize + offset,
+					    NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -1268,14 +1277,14 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		if (read->oob_required) {
 			/* Keep the existing PIO and DMA representations of parity. */
 			if (read->dma) {
-				ret = nand_change_read_column_op(nand, mtd->writesize + oob_off,
-								 oob, ecc->bytes + user_data_sz,
-								 false);
+				ret = sunxi_nfc_read_column(nand, read->page,
+							    mtd->writesize + oob_off,
+							    oob, ecc->bytes + user_data_sz);
 				if (ret)
 					return ret;
 			} else {
-				ret = nand_change_read_column_op(nand, mtd->writesize + oob_off,
-								 NULL, 0, false);
+				ret = sunxi_nfc_read_column(nand, read->page,
+							    mtd->writesize + oob_off, NULL, 0);
 				if (ret)
 					return ret;
 
@@ -1310,7 +1319,7 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 		ret = sunxi_nfc_hw_ecc_read_error(nand, read->buf + data_off, data_off,
 						  nand->oob_poi + oob_off,
 						  mtd->writesize + oob_off, user_data_sz,
-						  &read->max_bitflips);
+						  &read->max_bitflips, read->page);
 		if (ret < 0)
 			return ret;
 		if (ret)
@@ -1350,7 +1359,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	int ret;
 
 	if (*cur_off != data_off) {
-		ret = nand_change_read_column_op(nand, data_off, NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, data_off, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -1360,7 +1369,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 		return ret;
 
 	if (data_off + ecc->size != oob_off) {
-		ret = nand_change_read_column_op(nand, oob_off, NULL, 0, false);
+		ret = sunxi_nfc_read_column(nand, page, oob_off, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -2326,7 +2335,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
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

