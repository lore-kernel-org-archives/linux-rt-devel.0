Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509003BBA0B
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122353; cv=none; b=njgCOGI35fCbh6nEGBaHplu3Wdq3Y1UHmHoXkM3vZ0B6378if6xiX124J+5Qxsfnl3d35lmJKPTJZBp/x5XwfV7Xqu4TKnA+LTuR4pDN9L36nd9W/QGSoxj7WJNHI0xgBqqDEYw8Fbq/pDdIYj8KMUOfNNBiqAuTIp1bCB8h8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122353; c=relaxed/simple;
	bh=8gBZUPMs/8ybH7J2DLSL0LxVyDkr8YFuS4UrXkubECQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2FvvcOh1l5/45eGPiiXa/BDBaFkvR+yU3rf2g/QaL5huBriJgRZHhCIRqEwmb6wAARp4zW8qkUPYk9pVRu8wW3fdKI3F1HjZMqeBFfOD2SBe08HexRyCfsv2k574GvCGarRqQYfP85DXkorpxRZ2YOR/0WjPPg/a2bO9k26Hwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1rEV7O1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1rEV7O1"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-823545ce223so2086478a34.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122350; x=1792727150; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2rczNXeActkyUZxhNs2zIIuhfq4VixMAxBK569RVDfs=;
        b=q1rEV7O18FTX1+tmSMSsXMF4Z+oe63gjeMUJNnyq3pK3dOMpjmCRDUvs1DGQA4jyb4
         yjjQuNapGEhPQPoDYjHvlQ11pILFOdw7vRcBn+vieu0BSMYcwPurhZpglCeaFv+vysPz
         oiIlc/Bda53wm96aL++zmlxguUS4y4r93qhLHUVDZHfTx8aVGcwbRsq0xIzmNhOApH0p
         Wtn/Q6IYBFTCaMuUzlOI/bQqXHz7LRoMVg0JZmrhsn9Yyp1fhdTIfTkwxnhIA4QBSQV9
         NYDz4MF/fY3VjMlTaG9vTyeroW2rop1L5xvRgJOvZWceM/yYxhKUW1MXMkabJDlgc3Nb
         3R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122350; x=1792727150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rczNXeActkyUZxhNs2zIIuhfq4VixMAxBK569RVDfs=;
        b=Dp27erYfs52VxhaV5DMeyoT/IkhpuFXbJoBmZCYzSQhSjGZUn+is6s0wE+y19ZWWsN
         kQY172rSpunUYtWNHizawzF3ZYSVvDC1fnj/v7G+EPniuDMDRajcCU1bIA6LxbDil3CK
         Cny1vGH3WGH6Gun2bCI4Ru4y+DACpaVcvvG4+gZ5KO7Fvz2sdeL1nQuYhww6mNCib0Oy
         gMqwCpKefa/umSH3lJ/nDd4NZOS2uIMOidq3cjF1In/rUA2CSwHBJUEvyKI+q4LEUojX
         gNCfKjwhfKiAIaW+9PftfSr4c3AJEIRPKnbdKrEYk7Kjd5RlVqKPOy7eTNKieATai0eT
         ARbA==
X-Forwarded-Encrypted: i=1; AKwUvBxdEl0yfoEIQ4EZyLajoOF8ySf9eROd+SJGlniYo0YQ/YtqE8AqWQITSXypPBuDJTr+9i9brpCQdXWIEDUwEg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKicnhNSf/zhh+xeA/ypsqHS0JO2GZSlD6nHbi8FBjspID15AuI
	qS2y067Ahokw3vq53oWT/YTHfWlYsKrCSdr1/aqIYFoJ5aDT5zI2EXbj
X-Gm-Gg: AYBFou35jr3epEKF9bzG2e+8tlTSNMt4HrFJbvyet/sbcqrW5kpAaVaFX9wlpGywHBK
	4G1QJoRCCaxqppCsjRDdlHJz6N0QGZc8+cASgIBNQnDPebw9o78HTC5dp/gPJMhpNRkqgUUufQL
	aiXz/tJGJ/GhB/uP///8zd7YR7EymRoGuYwwqKLswKzYNOU0oKGXYQ0AJAGlu9KACg0U3YLF1LW
	PwzxVd4ANpcq7dz2knXHRuMAUlm4Svr0kjnNd5l8Ya/r1iBVtlJ8hDiujm2qyCxJU1Ci/kh8jNM
	35oaTwTif8PyYaKJ1W/HF0PvZmInsVmSAXJPCofszA2HAUpyt2tT11dpEzszeyWtq4dUVVp5t1W
	C4IpWpmnBLhPHY+nO/MwactNQzsEUrvPwUI/E1LSl/PuMBNURFzbkN9e9zYAtmlGuvAgFjuey+K
	smx1qUnrwkTMwMR0CjQ53Wv6o7SkIiVZb5MFlVIp2ZICvIhy4ILhMJK3uPa6dgWCIeLH99lbVsX
	q1SftzKWfnwOwZNHqiQx6Tx4Lz/OHFCkx8ndIZl1MvAbcCx8DP9Oy/WIPlERxFrnDwaimd7/9pI
	Q2cUIVHJMKzf+Bax2DLNPxQi1Qt87y0j4rT4/Xa+b++lqzipITd2DbUUQ46qXOxvy4cs0qYWLh5
	UQYcjkSvlCtHzSNCe8GY6cQ==
X-Received: by 2002:a05:6830:640d:b0:804:ca33:4aff with SMTP id 46e09a7af769-83094e783f6mr19887903a34.9.1792122350229;
        Thu, 15 Oct 2026 20:45:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm834402a34.0.2026.10.15.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 21:45:28 -0600
Subject: [PATCH v8 13/17] mtd: rawnand: sunxi: avoid redundant column
 changes for extra OOB
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-13-8ba4881fbee8@gmail.com>
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

Extra OOB is the spare-area tail after the last ECC step's protected
user data and parity. The PIO write loop tracks cur_off as an absolute
NAND column, starting at zero in the main-data area. The extra-OOB
helper instead compares it with an offset relative to the OOB start. It
therefore requests a column change even when the last step has already
reached the tail.

Add mtd->writesize to the comparison, as the read helper already does.
The comparison and the column-change command then refer to the same
byte. Keep the command when the cursor differs or is unknown, including
the DMA path, which passes no cursor. No transferred data or OOB layout
changes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 105374e93b37..dfb2a64c6b50 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1620,7 +1620,7 @@ static int sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
 	if (len <= 0)
 		return 0;
 
-	if (!cur_off || *cur_off != offset) {
+	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
 		ret = nand_change_write_column_op(nand, offset + mtd->writesize,
 						  NULL, 0, false);
 		if (ret)

-- 
2.53.0

