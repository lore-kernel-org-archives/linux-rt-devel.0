Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C973A1A35
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122338; cv=none; b=iYpssDTyK0vKBzo/79H3cbjIZ8pyhs4wXnto+W17kyaP0Ozuqak8TOpp696w4L7dpJloBIo/B9iTnH7jxUnsG9x3y9QAjLmBPNs1lkH9UuZJcygEpFxHkzr3EZmhEsR4cyRuGUDBIU8OzBeJwSIjdYX2XNzkzmtOXhkh+wFMqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122338; c=relaxed/simple;
	bh=QP1mT8TLRuJ9xSIvxqSG9BInMHYpQcC5zhAAnQdC80g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuvP/4CIPhNcxiUjp3zpCtK8lM5Pk6Wcj1FJlDy4BXqhTgfwiC9b+ZNYxWH0TAB47JTLHe5StJQXYcJan3c8n7MVDImtz5TqJ7D0KNT7wPuIkSKezdBj3wxBj/TZjIIm0LAEaW22l9fBSbmusoAaxi1xEmE065kOuzc8liObg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+EYXWQy; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+EYXWQy"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82478760557so2035281a34.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122335; x=1792727135; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xu2UIC5iJfecJVYRm44JjAaDQ7zuRMhXFx3hC1cl90=;
        b=Z+EYXWQy/hoXFteAWmiHxKgwLbFgtCdCWNPF8Y7oKWoI6EWPOuuHO4ySSSZ4WV46OK
         ITc1DZ3WLySMh1uVvC/XVT8skXxTnZD2m2uPOVllBUTWo9CAcCKu9dyJprPVyOlI0Seb
         JYnNdnFyaf3u9tn2022LwJoYeE2P4VcaRo6ibiwBGuv5LjbMfxC0ilPcMUyEfRV1XXKv
         Es1/C9xTTtcVsLtvTPjCUNQ2/X9U4LcDDR9/1Vg9ndJehiVUzeTGUDdKu5UJe6NbssWO
         K3Tx/2dX7c6vku1HJi2d4hOxm4tya8NI0p/MqVtZUdjbeCjitPKwRyh5UDaWIc/c0hCy
         lQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122335; x=1792727135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xu2UIC5iJfecJVYRm44JjAaDQ7zuRMhXFx3hC1cl90=;
        b=kwyDUw3ZvjDsyb9EJ8tVEWYByEUGDjNf8YbHmgmS83jbgCw7b9y/I1h4NsBRGDrUNM
         GO9OPZyst5JnVWizXUfm1M011SYNT7AtnuXOxgk75nVQ3yM0MbtCkiNjksudxMw++8p+
         9JFZd12uSDJZ8Tuh21qbo9GsOsVotTHR1b7WTiYuw1zmZOMFJum16Xd1hO/b+jdBkkfd
         MUnWCiw9a9PqePdIUDuuF3Vbdevme3AdNmusv7LqR4TwnDDmNX+8uofMYNNJAjaCaHz/
         zuocctUYWhzruTOzrCfWs2IQdTjHKwgkWLnTcHKbdN/DfQaiazsUYflrw/z5tT/Sa6FP
         G+vg==
X-Forwarded-Encrypted: i=1; AKwUvBwszrEJfG1iaINCVGvZV7AQoQi//tZ1Qpw0V4yl5+N2MkSk0X2x+kIbx8QiIYTNav+nym2yGbLe+1qtFIA5mg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLNfW1BSiuevEckT6+DWqydUEAnyzt5f4njCYhUkeTqQtBhZUcE
	wKsiFaNp1ZskbPZ7pvXsoP8pZt7LOF5rBJqpEqZLfAZR1CInzL0qY9ln
X-Gm-Gg: AYBFou1r3ZCry6JVm+QnJ+0vffRLJKVHZEZHMDHQSQ7jxaKF21olt+lg2koNhcpJysL
	hYSNJfl7BbZpx6SzML/xTEikfAJAFWzz/kFZlLtkAhkPO6xhRIOpDLfULJc/GZ/5A0iq64o7pB3
	VTjq9exOpPyNzFKSyCqQ+d8qmwY6M2iGiX8tvMT271sTY9DG1v6IEmBwxjIXo5OK46CT4RHdo3R
	YYp5TrROejV4aSgiXoAi2B1m3eAhHgcvU7rk2eSXMZT1tyVSPJpvYK9H2pbzfR16L2WIPsXoSK+
	tT8gKb9O2BOjmBAwCbolJCYyBqbhVGuP6SncPerS7gLVBmXF9feK8Y2/GuQtr8NbhxE8XiN5NNs
	Ue8JCzE8lLY+urWxXP4boVlWz69kFdbrdFC4YyW+lJBhE6r7zldNcFTL8plAKgDq+lMFJiaAKig
	0eWEjc6kSmYJtQMW+EazZTkSHJj1/DyICr915gLwaJS6QGasKilhsxNQg7jSCBFWU75aW4BGCW3
	58gsfh34GfWXVhyC/XMeJmnYesUnrCvU9p6OAugHEf1kZCxBqfjY6sZGR1sJFuZ4aGlSZd4ojh5
	yVNnnhrynVLaH/768TosEBeNubgwP1bxZ8YAkr4dClSj6Z5w1xCD5CVR0RE155nwpvLFF0+8TVD
	G3D4mG1HaWFpo3cSA3ziGDg==
X-Received: by 2002:a05:6830:4394:b0:81b:9d18:75e with SMTP id 46e09a7af769-83090e15541mr22707196a34.4.1792122334840;
        Thu, 15 Oct 2026 20:45:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm834402a34.0.2026.10.15.20.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 21:45:20 -0600
Subject: [PATCH v8 05/17] mtd: rawnand: sunxi: stop failed program
 operations and disable ECC
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-5-8ba4881fbee8@gmail.com>
References: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com>
In-Reply-To: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

A page program has three stages: send the setup command and address,
transfer the data with ECC, then send PAGEPROG to commit it and check
the NAND status. The PIO page/subpage and DMA page writers ignore the
return from nand_prog_page_begin_op(). A FIFO or command-completion
timeout can therefore be followed by data transfers and PAGEPROG, with a
later success hiding the original setup failure.

Check setup before enabling ECC or transferring data. DMA preparation
occurs before setup and may already have queued a descriptor and mapped
the buffer, so use its existing abort and cleanup helpers before
returning that error.

The PIO writers also return directly when a chunk reports failure,
leaving ECC enabled for the next controller operation. Route those exits
through ECC disable, preserve the reported error and skip program-end.
Keep the successful setup/transfer/confirm sequence unchanged; this
patch does not add a new controller-reset or NAND-abort policy.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index f7ddd4116bf4..d71b980ababb 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1602,11 +1602,13 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int ret, i, cur_off = 0;
+	int ret = 0, i, cur_off = 0;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1621,14 +1623,17 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 						   oob_off + mtd->writesize,
 						   &cur_off, i, page);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (oob_required || (nand->options & NAND_NEED_SCRAMBLING))
 		sunxi_nfc_hw_ecc_write_extra_oob(nand, nand->oob_poi,
 						 &cur_off, page);
 
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
+	if (ret)
+		return ret;
 
 	return nand_prog_page_end_op(nand);
 }
@@ -1642,11 +1647,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int ret, i, cur_off = 0;
+	int ret = 0, i, cur_off = 0;
 
 	sunxi_nfc_select_chip(nand, nand->cur_cs);
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1662,10 +1669,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 						   oob_off + mtd->writesize,
 						   &cur_off, i, page);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+out:
 	sunxi_nfc_hw_ecc_disable(nand);
+	if (ret)
+		return ret;
 
 	return nand_prog_page_end_op(nand);
 }
@@ -1706,7 +1716,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 		reg_index += user_data_sz / 4;
 	}
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret) {
+		sunxi_nfc_dma_op_abort(nfc);
+		sunxi_nfc_dma_op_cleanup(nfc, DMA_TO_DEVICE, &sg);
+		return ret;
+	}
 
 	sunxi_nfc_hw_ecc_enable(nand);
 	sunxi_nfc_randomizer_config(nand, page, false);

-- 
2.53.0

