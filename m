Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE834B1A3
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028079; cv=none; b=tNgPX0UJzX8mA6V9GpYC0n4jybaQld+guGcKSVAXjmRwLA2qcOPxoB4WG9O4vtIW5GkBnYvEWh0xza5a2MW5EdpFzLl+oWJMkkSOoYEBiAeTVz95y1khrKO6oe/H9PsUi++UX2BA/dVm9IWIQdMDtBthFK9tRu4W9Qiv4EgNIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028079; c=relaxed/simple;
	bh=0kxWl9QWVm1G3QyRQQoFBKdw9ex2r5DsXOknVXwQkMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbuxQ4y/IuR49u6Z4F2Igq8i7wk2AfmZ2NVYvbAniMhUjRupgIg5OXRhJ2SSGbGpUwBZFFoXmoFdR1zTu0WXlFdHCcaBXWY1ZZ2wsajXulyhj875RILaqCeT4VvokLIkUKiZuy7NhQP41JShNND8d8eyn48sUURYPxtOeJAK0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovy4rBef; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovy4rBef"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-48ed188ee81so575924fac.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028076; x=1792632876; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oafE3Y1G60hqD5AuR17ZSRtdy2A1IL7jrwTpft1hiNc=;
        b=Ovy4rBefm/Errtqc8IcIIRsZdhmBoCoWfCqfgD/Bquf1GLASwT1SocNTiAPzenmHyZ
         n3+cx7ml/h5iWk828trWqEuIIBOTcNy+r8q42n9g1jLTcT8aF0BCIedMmUQqIMvW9TQQ
         a+aaV0xqOH0tcOkwBEiI675F0V/HdtEXQgBkUvHh2bOf7JkW0p/Wh6gIOC804HhZVAdW
         c+GMA9SkN5Lij8wrmQHOCmVJaycJg8s1GgnHk94rgmID7H97e2LzqxfzJrGzK6rW9PvR
         qMEIS3n5x7xK8K5EXp1DC/xE44rPrP052nhedmwnaNcGGxQRFzR9P8DR8vYLc38U4bst
         /O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028076; x=1792632876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oafE3Y1G60hqD5AuR17ZSRtdy2A1IL7jrwTpft1hiNc=;
        b=vKMHNrTJYaobU8BB6neVu4f97wqhpKvpTfNA/arNC35yPxRhFXTRY7MWgnNqT9xtO5
         Xq+rawk8RM1JoR06E1siNgqNb5Vuxd6ph+dfoBmeffzBk1F0t8X/OMiLqiYQpo66Sqll
         vFjfAI5tYVLjHYKFIODmLxsM/U8Bfl6yZ/g4WjNNWjwsmowmW2uVgMGbiB8g9BTnU1YO
         0FdoiJyVSAIj5XkS3sye4/pkeKYKGuG/ih/v8aoUxgZmE+43UmCDYP/GY9bVcOMaIEb9
         c5Ty4w7WDlIETfml1d+fUGT39NrPEicQ0k0P8SmX3Y1mw4IkdAq1/rmBC/+6bfNHl4fl
         VFYA==
X-Forwarded-Encrypted: i=1; AKwUvBy/0ygeJUdU1sLhrlcpxA74F6tbuIXgJ429wxDYncMVDCOR7OFasJ33o82wIIb4tpFs9/O1wcUCtg51VAH/0Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYL7gFHiWAQpw7hZAX3hplAYc41TEjRzJFUDvwmFy6Y1w4w9Q6BP
	LM3mG9sUchm6qfwxoxYpFomsoJv1YUi+OjKfmRRkw2WEKR4XdLROsDVA
X-Gm-Gg: AYBFou3HFHbhdJLa4WmZsR1bcHGQb/we5ymP5SsgZsMwzls2w9+Q8J9Wp8YXmH5Nb2a
	FAs1JS5SJFwVYXGb9pgMB6XHAxocqAoJa2Mu2I/3cq8c4GurAj8z9eDmEJ5t2PeQsPPZjoD86hP
	appEjGI9ifMnG4d/7+lmukteg58oQuWFbItBaNnb/rNgK/1CmP8ZuB/mnlrVuwX9KEWFfw4cbqX
	R3gaAwNo5inUvdBuR60JkjqBHhq8Jf+Im2gkOTQZH26zdT7roh7Wj0Bzl9Ne/JHPNP8fsLKAXz+
	BVPVcIbCiN73wUiZoYKYDrVrtKRl3w+VkOcuFCVCNpIbKcCCGpm1Dzsfv1X2JldA0ILc/Vy1q91
	R/LGY16DJm7trNikwc2/Sj4B9g4F+O1cHCmQePXfS4tu3i4sojJORA/PqIskZd3R/RTQ8FeOsxI
	EP7M63r2Je7h9x9grpqUAtc5OAQwdkDv5/QJTEwrbu9cDPxoJRpg42Aed+AXH5ycXqmf7ItfWvR
	vsaYYqdLpRECX2uwOsKeWc8+dIletl+KfFILKlPQ6aSJlXiIjSEYzgJ2GXdRs4qpuwITz6tJFCL
	NduStmEBWQHFOnAXFNVVv1TRGrV6cOXrBkgKf5575HuXXn9vO/yI5ldSR8ELHoN5mGFner6iEeX
	Avvpn7Q3h+A+2iFZwmw/W
X-Received: by 2002:a05:6871:722:b0:48f:e0f6:bd5f with SMTP id 586e51a60fabf-4a2a8b0964amr15694991fac.48.1792028075784;
        Wed, 14 Oct 2026 18:34:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 19:34:00 -0600
Subject: [PATCH v7 13/16] mtd: rawnand: sunxi: avoid duplicate chip setup
 before page commands
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-13-5d3fc6ad2da1@gmail.com>
References: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
In-Reply-To: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
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

sunxi_nfc_select_chip() programs chip selection, timing and the
spare-area base. The page-read callbacks and PIO page/subpage writers
call it directly, then immediately call nand_read_page_op() or
nand_prog_page_begin_op(). Those helpers dispatch through
sunxi_nfc_exec_op(), which performs the same selection before executing
the command. No controller access between the two selections needs the
first one.

Remove the duplicate calls from those callbacks. Keep selection in the
DMA writer: it accesses registers and prepares DMA before program-begin,
so it cannot rely on the later exec_op() call. This removes redundant
setup only; selection still runs for each executed operation, with no
new cached state to invalidate after resets or chip switches.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 74fdca27ba10..4e6fcf1e7aaf 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1642,8 +1642,6 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 	};
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1669,8 +1667,6 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 {
 	int ret;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1696,8 +1692,6 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	};
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1726,8 +1720,6 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 	int nchunks = DIV_ROUND_UP(data_offs + readlen, nand->ecc.size);
 	int ret;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1751,8 +1743,6 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret = 0, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1796,8 +1786,6 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret = 0, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;

-- 
2.53.0

