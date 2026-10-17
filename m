Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BC3D6487
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266376; cv=none; b=p64RDweTWGRNNSfp9lsYYbnL+nw4mPV7PpM4GrTBrkTP3itwshA85bpUbf+DjaWr0dU86Kaa6X4Dh70rHjpg/Ijm7lSHGU6Hkt/TggXlcECKiDfUDAjX6OPLazbd2Idx7ZRGd5bWJ/pJx5l/nOclk0gfg8qjZN1e/HTkc+GjAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266376; c=relaxed/simple;
	bh=mN53hNOFiAzhWVgJjfpGtTS1jmZz/HpF/K3uG0lAfxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elIKozl5wS+3Z4l3CfsxxTh8eLXqnr1v3NYb4Q2O9XsgaW/U4uqm3e1l2AHUTUjqZcP3/4rxJR9raZJiv3+uxMwX8fNYikD5UT/z7quTTImL3FM8M9mH27sK790KHfILX8KUEzrc0r6YmKaQhSievAg8ukqvFz/bJrwQY+UOEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwbDWKkJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwbDWKkJ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843b6f8e2c7so795319a34.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266374; x=1792871174; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0p7Kisx6irolstjhcUjO1VMqHlDNV2glsnd/sNiGR4E=;
        b=GwbDWKkJeKoNJxiZgBGhCN/xXt32p0Frlbrfb9kaJh8Mx4/3vXcQzSxhk+kymDFlA9
         ++bc/ihlbW4uLDn0e8jAmSfIvkhPzg6KigTMK0SX5Z1td2y/mHb9O1erq8t+Nqq3kjKq
         RRnSuFeNbw81UBkEIuX2fgw3Do35vA/7H9+X4O0NRlVdJTFc1bWbUFq2nhyFtYnwRbDV
         fkg3e8G+xIComwPz4P8B9BlqV9uIIXIM6yqL9oO0eFDhZM6RzgmBl5IhmBxifZk8YDU5
         F0HfwJ1pqumflmKRhBhbEI5Sxa+jtG69LyPg0oQCVzPiZG+xxPsVQPVtgyo1fgzKOlcT
         QxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266374; x=1792871174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0p7Kisx6irolstjhcUjO1VMqHlDNV2glsnd/sNiGR4E=;
        b=a5q55Vy5xXY/M7+uOcVzkB00fMPHnQpB1pzGUHkHn9gr46KA6wWb8vu8lF341HjdJX
         er/5gKajXMwgZCIki75F3G6pvPnwa0i2GW+ICKz6K8Boa3vSbqvZDPAwlLTPELnOulb2
         Ci/+gFILrpprBF/beZpA/A9fG6aFiHWwrLjLkgsBKpVUxF1wo8UppZJjHHDZ6PpnBbma
         eM52kr+++CIe6ibKbK6gOtIhoQLGaYL4DwUUaG6d03ClOHhGtTc5MxZqtaK2NvNHTaS7
         lk2VemRoWQUkD720ENNB1ximspn3cwUal5Bjofgv7KSk6JdOsZ5mUiyjRvTpieEw6jAZ
         IM+A==
X-Forwarded-Encrypted: i=1; AKwUvBwdskrIh/5+o+WZcjAAEzqBpd/bATMbdgJXB/E616MvGOhMzOhVNAKL1I7muwWkc5+dTAlsixEGnaMQgNHBHw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKt66hEuljFvSOFh2Fak9KbYLd/66T3SQNV0tE9MN28T3EJDIpx
	flVpNgeRZeQK/EruUmjz71kAW4AbKIvJw9vZXGat6xw+YZYKpqq6UC8Z
X-Gm-Gg: AYBFou0SdnCvs54KXi8NLebuLL0ZHIGfPfgctq34OyFLf8oqLYCpljeuoiG/9Ab1qa0
	I4g9RwTiJF3KxYSaUPdXy9034aL8wqeUvV+5fJHyXDX+5qW70772VgfgyR7rcnjs6MGaz74KW0c
	hsd50XpDbeEQzlY2qncfs3G1qIHMs93oYsAuFEKR//TDa4TmQ3+LEt8vA1bVA5WsN3rtVvueBl9
	0fmes7r51S54BfXwqIGW8mlW8Bpd/XV4bw17X/Nh2JLkSno2ocTYEYhrDJzXGsdoQg1yuXzv4J+
	RycYZM1dpBtd+A79LzW9+OFfYbepLu28eOQXja7fehuxwY+MqldA8R7qo7ji9lBgJDW1nfJYu+2
	EYILXj9xc3Ab4B3NJKjojoKhCySE8NaPUevTgLC0QJ5vq7NMEmrDCsoTHIMbvKzDO2L2cVYOG5r
	dyXz3IHtKMQ4udng9v58hp3dRPikRjqzphSH0HUpWVjTXWAMhgj5w3zEbTXs2tasVo3hnrOBQ8+
	fh4jEXpsz1zRLHkH61stc+XuQZc9vv0OLIpZKRZaZV8fxddJvh9LnOYQ0GKyGvESDL+IKQh+U9z
	bIETe8GwSjLMwOt1rOwkAg7Hmcts/M77N/tu/y7A01/VhBzsJon+atr1RLQhszQZ0e6Zb/ZYod+
	HU+KsWF45VyVU/oi7u1C/
X-Received: by 2002:a05:6808:30a1:b0:4f0:a3f9:9f89 with SMTP id 5614622812f47-53ccaf1dc47mr3423128b6e.18.1792266373854;
        Sat, 17 Oct 2026 12:46:13 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388dd8b5a2sm4025321b6e.12.2026.10.17.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:46:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 17 Oct 2026 13:45:57 -0600
Subject: [PATCH v9 02/18] mtd: rawnand: sunxi: reject pages exceeding the
 ECC step limit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-2-b624c09e3ee5@gmail.com>
References: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
In-Reply-To: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
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
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

The controller has 16 ECC status slots on A10/A23 and 32 on H6/H616.
Hardware-ECC setup checks the strength and available OOB space, but does
not check that the page fits those slots. NAND identification can supply
a larger page size, and the NAND core does not enforce this
controller-specific limit.

If enough OOB space is available, an unsupported geometry can pass attach
and reach DMA code that indexes status and user-data registers by ECC
step. H6/H616 also represent enabled data blocks with a 32-bit mask. The
number of steps must fit the controller even when their user data fits
the register bank.

Reject excessive step counts before allocating user-data lengths or
installing the hardware-ECC callbacks. Check the final step size, after
strength maximization and the conversion from 512-byte to 1-KiB steps,
so valid geometries retain their existing layout. This also keeps PIO
fallback from accepting a page that the controller cannot handle.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-173724@kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 80006d1a33d6..bd2193d7259d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2230,6 +2230,11 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	ecc->bytes = ALIGN(ecc->bytes, 2);
 
 	nsectors = mtd->writesize / ecc->size;
+	if (nsectors > nfc->caps->max_ecc_steps) {
+		dev_err(nfc->dev, "unsupported number of ECC steps: %d (max %u)\n",
+			nsectors, nfc->caps->max_ecc_steps);
+		return -EINVAL;
+	}
 
 	ret = sunxi_nand->oob_ops->init_user_data(nand, nsectors);
 	if (ret)

-- 
2.53.0

