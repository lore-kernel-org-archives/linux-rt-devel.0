Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904962;
	b=vg6i+SJYyKLGKFnqYgFcG1F9vJOzGbSKAhsCHn83mtDriYOTG8A3CqGgQ/loskza7YoV
	 QWXOQskvmVynXF1zP1zxL7uH4i1ozhzkc2+QVXpEcoHMsswFPIkBcfRXExiDu6gnQieqO
	 1NgpDjUnHysjUjrRk4GWM1Dw9fVeGqpai7vs6x4KLxcdu/m2XIES5GDRj67eGIRn6rey1
	 mCco25fijAnYNyfuT6wUiUow7beuPIRI5hOyV3LStbTaacx3OpSFfJNNsM/ZjBPYkQvwa
	 VRWyilkEeian93fNLxSLrBuatKxmkDL49D0QWYvu430SqO1lytLsYP4PRit9Q6KVeBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0o9Q25n23ckZBCXpljiM9GoL2XJxqzEiWbXDgW42slQ=;
	b=asiuou7RUmB7jvM7i65MfXgYjajzejrUO96G/sSzSM/Ebih42X5ZDm2O/MTyfTj+e80G
	 sk55qyI21772lisJI58NQwjvGSancSHo83gHX0qUPhKY4VKVNMbCE2Hlit1KdV5bCTh0H
	 TdQL7EV34nr64fN5YarNXMV0UswNGILLMxR5iXlhOEuHdpuZl16RpDF2qMMX5jt6lK8mq
	 ps8inl5rfWGwNmOQ+kDveCCeH/21xuyEiLoBlx6KncxjiepMhrX7mjj9tksEsBY7dxgOJ
	 nigagh1UO40fq4+PHT/l27W8tEKhJMqNneO85OpyMtZVc9U4euXtbVhs/EHCQ8UrGBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vW13S7nZ;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D86083611
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 425D86083611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vW13S7nZ
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6de1fd5f572so1017666eaf.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904961; x=1794509761; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0o9Q25n23ckZBCXpljiM9GoL2XJxqzEiWbXDgW42slQ=;
        b=vW13S7nZtE5OC+TEc9iUsQh0H3bSAH8TlJYKF/J+n8ISE4/eZz4u8FR7A5nZKyIPIO
         VPvEIfUnXVrHPV5opobNN/EnH3VfgF7pixPGp/E9VY6AvUTF/jSyLtLULQNyTLXp7P/l
         aZNCQp2YX/IfZHCkv8P9lov2eVOs7uYKET8CqANLP6d9D/tntwaYWAvdztQBcEOQMhAO
         /7E+IrItKyKOXzGk10wRyVPQW6DnKz3B0IKlm+W5RGDyKmtcZysXeDWy3j5LiKZvGWv8
         Fxw2lDqvqbIWHb5207rHeu63AnNnkZlVZOMMslPZpUDhC0+o4TFqOqD0bxZdRwLylm3C
         tA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904961; x=1794509761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0o9Q25n23ckZBCXpljiM9GoL2XJxqzEiWbXDgW42slQ=;
        b=P3HCm1dEWNCjGwE0ytmoOQKxiEu4OUS4QEGD4w3FQ8cft6zqWgQrTlrj9wGKG5Gyfg
         T+IV4hyjQozoGZv1/dRgkMdcuVwxCPAJ0ZJdkRS/l7zSl4K/XIng2/lKyL3o/OTlXUn0
         c7AAzdhFuDhLmYNPX0wCfR8/hj9s3+wNSXYy2rerdZmUSITQOE4vxfkcxjlxB3COc/B6
         NdIYp7NozSmGjv3ORJQ4LtPoMqneFgQ1duy/wjexwPIctnzU+f4hIXiKmW/pOPZzQJzz
         TknJaUlfnlO98nlilhtY9bFsAoFyxlGJ3033Joyw3B9oWRidQoKrHzZr//dIuN+AqZ8p
         i7zw==
X-Forwarded-Encrypted: i=1; AKwUvBwAqqW+jYtUVG6sAEq7Uhvc93IjHcr/fp1QXIsgjDao8rdmkUVT3AiEmFaY9sZ498xd0BhHhTT1aGPxUR/Y2A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9BG/Yr5g73Q/t96fsAnvSwHxT+SQAvSJ2JPOS0nn8AVD1X4+jg
	mQ/VpfyKl4Obv8OopXWEoIkY3/W82YREoNqCzkrf0kuLG3FTiizC9CCw
X-Gm-Gg: AYBFou3leJvR0M0YBVDYNShcAHWbG3XvO8U2p0VCV9GnzmlHkRkhh45dGNwINJP4Oft
	HjQK+re47Txac82WFSSAN++2B/GL0+DKvhsXXuwNx3vlujm/nc//AadMplXGlkSpIpgWjfdQIkO
	SVvimPVXcqh8zLhwytZxUOEcdGsK9o088z+tlqsnT0jO7LblHg23vg8jqVygM35tLugjPuNebLQ
	p8jfVD2fne9zewhlsR5zMnI5TWe5EHco2OZp2K4jVd+2tLU6xJCxisbnwAKhwrS5STIyBxcoNgn
	X5+B74IABGIClYn5GHWqKr207XdA197okY8i8MKsW/dK57uoaGlioIeO/SupCdXcfRxA6bz7Y4H
	hsEZJaGoUeEXlmcODO8wDEh+wSEQJirue1qfLFtXgYx7YZxRwBnZu7P/rhcyujovvaBSA1+UyWx
	IWFb1Qfj8fGQf78f9hBUI8DVVlY72PHZiUS0rdP0FMIwl7swWvgqYbPNZwKKN5F9jOFD3epm+Tl
	ejnH66xOQR5rme91vHdSAT9zrPJxbMnYSdMPBVYgxEUWO6Miw1pOaBtiVn0mzDZZpG1JXOPD8vb
	TiYaiMv25asyXyFR5cGvAJXaEAkwdz9Ibj9K+XBj0dbXLJS3Y5qeqhsD22dNbQ6z2NGIRTdKYYm
	L66c1HaeSd+n0uNUW6ezcvS4bbqcVwU3a/XaYyZlZTycbS7ruQkzSzP324syVsw8dpeQGniOHtS
	7pek6vc00PMPAAmPGjoUz3XZqtYzAf8eKil/8gJER/6ypB6fyKd4Mm
X-Received: by 2002:a05:6820:4812:b0:713:da3b:901e with SMTP id 006d021491bc7-716e794cfa5mr279031eaf.48.1793904961203;
        Thu, 05 Nov 2026 10:56:01 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:56:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:35 -0700
Subject: [PATCH v10 19/26] mtd: rawnand: sunxi: scan all chips before
 registering MTD devices
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-19-dca1f6ed29a8@gmail.com>
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

sunxi_nand_chips_init() scans and registers each NAND child before
starting the next one. Registering the first MTD device allows users to
access it while the next child is being identified on the same NFC.

Normal NAND I/O holds the controller mutex, but nand_scan_ident() does
not take it. Its RESET and READ ID operations can therefore change the
shared chip select and timing while an operation on an already
registered chip is in progress. The normal I/O can likewise interfere
with identification.

Scan all chips before registering any MTD devices. Add each successfully
scanned chip to the controller's list and track whether its MTD has been
registered, so a scan or registration failure cleans up every scanned
chip and unregisters only the devices that were successfully registered.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 3de9ed6795fe..e1306d14ab3a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -298,6 +298,7 @@ struct sunxi_nfc_oob_ops {
  * @nsels: number of CS lines required by the NAND chip
  * @sels: array of CS lines descriptions
  * @user_data_bytes: array of user data lengths for all ECC steps
+ * @registered: whether the MTD device has been registered
  */
 struct sunxi_nand_chip {
 	struct list_head node;
@@ -308,6 +309,7 @@ struct sunxi_nand_chip {
 	u32 timing_cfg;
 	u32 timing_ctl;
 	u8 *user_data_bytes;
+	bool registered;
 	int nsels;
 	struct sunxi_nand_chip_sel sels[] __counted_by(nsels);
 };
@@ -2672,8 +2674,10 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 					      struct sunxi_nand_chip,
 					      node);
 		chip = &sunxi_nand->nand;
-		ret = mtd_device_unregister(nand_to_mtd(chip));
-		WARN_ON(ret);
+		if (sunxi_nand->registered) {
+			ret = mtd_device_unregister(nand_to_mtd(chip));
+			WARN_ON(ret);
+		}
 		nand_cleanup(chip);
 		list_del(&sunxi_nand->node);
 	}
@@ -2754,13 +2758,6 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	if (ret)
 		return ret;
 
-	ret = mtd_device_register(mtd, NULL, 0);
-	if (ret) {
-		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		nand_cleanup(nand);
-		return ret;
-	}
-
 	list_add_tail(&sunxi_nand->node, &nfc->chips);
 
 	return 0;
@@ -2768,6 +2765,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 
 static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 {
+	struct sunxi_nand_chip *sunxi_nand;
 	struct device_node *np = dev->of_node;
 	int ret;
 
@@ -2779,6 +2777,18 @@ static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 		}
 	}
 
+	/* NAND identification must finish before MTD users can access the NFC. */
+	list_for_each_entry(sunxi_nand, &nfc->chips, node) {
+		ret = mtd_device_register(nand_to_mtd(&sunxi_nand->nand), NULL, 0);
+		if (ret) {
+			dev_err(dev, "failed to register mtd device: %d\n", ret);
+			sunxi_nand_chips_cleanup(nfc);
+			return ret;
+		}
+
+		sunxi_nand->registered = true;
+	}
+
 	return 0;
 }
 

-- 
2.53.0

