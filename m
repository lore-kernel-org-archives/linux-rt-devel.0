Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA531ED93
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028064; cv=none; b=GWNJAMTc/I6en84c2v6Bb7vjood3/VgXXDC0y/rRpKykE+7jHOpiE+9CKODjuZKY0xOoV5/9haNh8VHsrbvs229zAj7WYyDlZAweA/952uWRpSOySzk8hllMo4Sy/jq/+ueo5dTJkFGlD2Aar/TQ/GFOPtYOvcJBPtF4P/57HWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028064; c=relaxed/simple;
	bh=pp2SixJcCNbM9ouP1cQ4wZ06wECMdT8iJOt4pVovses=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAi94J4LdAu3vxg4Ck+SVkKKwgYgAQTulwnSL6+5+Eth9EJpfI0acaMbJc1l2E/NZlVxiaGHx8tsZfFWxLpOmmgT5GpCv2RR0daHrNS47GyNEZyjHM+arESCg8ev59B2l3LbQfT3ZEzzrEDyRJVBBY0M5wlNPUHk4767U39xnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngjjsKZf; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngjjsKZf"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8256106635eso2337573a34.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028062; x=1792632862; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vV+y+As1/xEWZJVIUOnWi1zmF397GSE51b2dM1xKJWs=;
        b=ngjjsKZfspSZj6yjtwMioBtW66GDq20MlvNF10Ltaxtq9jMKZ0fVLljo0jlrj5sxxI
         fTCMoYIpQIj9GuDZe4atHQmgUzpKGoxBXTTx/Mag3IPFJYv58iZIi4o63qcsoxMVZKx5
         DoIk+Vci9RrTrJIaWEfYJ2T4Yb5SM0r3u+VpT31+XOTwTU+JI//fbl4lzJawWKCyfK9B
         pFNL58dI41kiERcs2DY192w6CT/wvJBWHmpGecAkgqFizyTStx/KtKp3Gv9KEUGd5y7c
         Ey9oR5RnOIzzjqGJ4OSKLD0K0nHkZ7coOUuFHZLPIoRWOYjUd4Lg7NKEsIOhPjOGQ4ST
         C9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028062; x=1792632862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vV+y+As1/xEWZJVIUOnWi1zmF397GSE51b2dM1xKJWs=;
        b=Lv7RBZQXLocOZ8tezWxvQQzd8sKz6jwpPp1a/uH2sNtjusmHuP2hnrd+lFerFatiq0
         GMdcFIB4J0wytuocY5SyI6t6qUdOy+HIg4DkeHocZBh3kKScqi3IgbV61+Ktsy1pllcw
         6VHRrd6l3fFFGGfQ7pM1y/lh1o2BxLZupRK0m37RJsWKN0uxCJSsarK4Ib7F6LV2ilYR
         nf1VFvsMKAVLicWsgvMcUes0uHE+ossy1MKwmAJ0qxCsEgZetBrJmLcTKKZYRMgt1Pvd
         O5syGPBWtM9U/1DbL29Cy79dy+nsJ0odl9tCAXGSXeykhMzXuSD6ngeygGhjOmi/npla
         yxKA==
X-Forwarded-Encrypted: i=1; AKwUvBxqMtEf+Ea4LZOZcDSgW1Va1M0zmrLmbmeda9Lww4nArb1Kz0fV9iOQRp6XXWpAlBZuKF0S8KHez74TMEEkyA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJLxPdMpxlrbhn9xVlK3tLRT+gqdKdtwaTebsg2S9Dn6+A4Zww/
	GECSLBBCz09WEIPd0+ep1q/1XgAbI5MK0S0K2t2mCyl/gKAZFaC6is0R
X-Gm-Gg: AYBFou2C93Sk8cqftRdPWphztgPEyZWtivNYn2tB5Ncz60QSJ+ltxfX3+tE4wstxqVd
	JOr5OYowbLWV8WBWisLZiE6ym79F/RKBflY54IFAboPV7yhGtm59OSRWDiVEVZ5x6dnxr78fbNC
	9N0WiiZwrPo8TTpDiQlztqc76VqtfCgnm+RiZ/BPIpRCWsH0fZ+tTf442ErCebcEAi41bgO0R5S
	tlcFISOHFlWZU1G+y2X4p2XSD2wsCdPXpX3tr2AyHLh2eLGdcCpMlDfozNSDln81RvthKWWIKap
	XO32MIvd0G5FKdfffQjgHVeScSBSHS1WM7c5Om4NchfOqvtikNgJQ6XGpfnSiI23wlspJ0EXCG/
	Hm8TBHOrRgZWnC/qwJ/mBV62yGOvDAywLwKYo8KA4B6xk8Ore6l7AZRQSp/Fm7h7z3CEgS6RmjI
	qfjkqWhQrW+futsV38XUxPVjPXmX9Lo6RnK/HnGcSGdAD8mQZNSGfNheREg4yNgEkFdjCBTxwef
	xLnBSncewJecxJI8B6cNzXynql4Rs3WURZuVAaAq0ZbbCZVQwJnz3vXTGgRlXiYijkGOUS0pSmU
	YmxNk6cI0NZdhg2CgPJfZNj+bfUPQi0CS4+2i9OaBx3lN20Ak7HGPMY0zR3+E4sw4FmermKjI/u
	Tk12B7gfCVMs3PbgvPeoS
X-Received: by 2002:a05:6820:1517:b0:6cd:3fdc:a936 with SMTP id 006d021491bc7-6ef1144ff66mr12723501eaf.83.1792028061915;
        Wed, 14 Oct 2026 18:34:21 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 19:33:53 -0600
Subject: [PATCH v7 06/16] mtd: rawnand: sunxi: select the pattern ID for
 the current ECC step
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-6-5d3fc6ad2da1@gmail.com>
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

ECC exception mode recognizes physical all-zero and all-ones data
blocks. For each hardware ECC step, a pattern-found bit says whether
this happened and the corresponding pattern-ID bit distinguishes zero
from 0xff. The correction helper checks the current step's pattern-found
bit but always reads pattern-ID bit zero.

PIO processes one step at a time in hardware slot zero, so it is
unaffected. DMA processes several steps at once. For example, if step
one is all 0xff but pattern-ID bit zero is clear, the helper treats step
one as all zero. On scrambled DMA reads it fills that step's main data
with zeros and reports success. Requested OOB is also filled using the
wrong pattern. Conversely, a zero step can be classified as erased when
bit zero is set.

Test BIT(step) in the pattern-ID register, matching the error and
pattern-found bits already selected for that hardware step.

Fixes: 614049a8d904 ("mtd: nand: sunxi: add support for DMA assisted operations")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 57df88099206..8256982d1d56 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1101,7 +1101,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	if (pattern_found & BIT(step)) {
 		u8 pattern;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1))) {
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
 			pattern = 0x0;
 		} else {
 			pattern = 0xff;

-- 
2.53.0

