Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46C345CBC
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028068; cv=none; b=NXB2iZ9kwDxqfY9dUajFcessx9fy2CT+mExyBAIZZr2UH4oS0xVGeIsilWgJ0YL8STucGnCW0qpPPqnJBABAFrAZ0jFnEkBn/Tqgu7/y82wkQ2EFapHCL1AdJUccKBazS/DiIH7nalUR7runV6BJbPjUrVJ8cvjrb9n+X0hn7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028068; c=relaxed/simple;
	bh=UsPtr5D7TcSTYM7m33I6oYw05r53iguxnK0xi3GQO2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sv9RhYPyaatkcELWFrTiiu06Juxn4fZAj/NNiSBSlylYl0XdGfwPNcUL6fZ/utRLHg+EZ50UKCpWf5bt5qNFJhCAaF+Ftj63X4TiqABd1oS6WVHwL3N8aECyxn3Gb6iNm3hFpSsTTWzPffWG/6te3KBypb4rpO75d0WvgtgeCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz+zAgFm; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz+zAgFm"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a691d29614so1673405fac.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028065; x=1792632865; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8HSeNHmGWx6gPVnRbfeK4ulo5XYre5+Djy0Qjqqgio=;
        b=dz+zAgFmWXbu0HgJ6KsOJ3eo1se//21mko8ZsZBi1jDNKiCYutVo7/modwmNFTAwge
         4P/IV1jUuVcx3mHbiootnJfnF+vOitq81Pd6yxle+CxJnYtn5oAuVFzpASm+J7Z0ctbi
         JRJbV4xUu3RRjZMFEB95aW2GlrLxjZXEhLjpVGqi/hsW5lKo/h2gr4M0fainBluWkaLQ
         JFb5kb6dVApRSEgdB2DoW/Qk09DDYnaWgKMF3GkWmvHhE084LuSiJhcHEQFDSMz5KIqM
         XxL4qvZ3shPTK1sq9GPruEcBFgEsICAKGPuwctr2TPuHwJ3ntrCbrs0KfnREaJqUU28r
         HFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028065; x=1792632865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8HSeNHmGWx6gPVnRbfeK4ulo5XYre5+Djy0Qjqqgio=;
        b=k3Hl+hBq8ejpiSpEq5EZd5VSIJN2wU/PNcBZImuBV4QHTkCGe86gOBf+eZi9XbkcWz
         RW+8tbQlUIcJC7SBGVrw/+ewVzU2vTomUzqg9cCqE3peCXt/0knRReFm6yg6NxAPQvs8
         WJ9ICyZmjhinrZINAlXKolL9tahWdRTysfVQy7oE/ciK64Am55NXiWTziN98iNSqx9hL
         FAkG36YPgpg6EDPjLdjYspBwVsyvvUDheN/eUqPCstuzKEhPYMWVjchPlwExUewwaMhZ
         3Aw0okZWRR+doj8IQHv3jAEqugX+n4PqyHe0B6PUhXKNbDjkyC0608TejQz8g9L1PYnm
         kXOA==
X-Forwarded-Encrypted: i=1; AKwUvBz+rIdbfClceyh4aFuXpnpFNc7yD/nZNLX0osfHUj2mSOw9SZJmyLJ/Kmx60WpIqkm+b9z3IXl6LNxzkx/V9g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKbco9uymBGqdm5U+/7AZZIz3wqKkzgv5C9r75hvwYotIMVPBgy
	BmM6cg6iLB/QJGIeN1tX5qXOCcXBvZLOe6qa45yu9jMjVKag+9TW+/p1
X-Gm-Gg: AYBFou0Gv2/MW98y6nKFLQUtNTextk1TpZzyRb174AOuF6Grh/NJhbNnpJByjdXpTgI
	WQ9JE3HQ5CYQmxzejEACGmai/tnEuM99T2RX9iuKjgM+nWPkGieiopdyLKqPg5BnR7subZB1TLC
	RFqyO0Opo7VhVCAFuM8MHt5wsF2Oefb/XCiSmElX34RIWks4+kTG1Y/XbffjE1KJj0mauKDhMpd
	BFCkq3YyDe/0BWal1il3w7hUVqqi6OhOTDD7LpkZTKs4b7tfS9IBn3igmeNqP4JNfAcYJ7ghltj
	4jXd5zd0zDzi6U1fKP8ljpCkFSmFw/AzoHoka+JWCJ+EcSJ8HNOxlYI+HVA/UZfb+4E1+8WwKbV
	2GIxQ0mHby8ZpeojNjnfhrGlKJVy8loYqnJT5/TdgeJvDyHiDzIYa7E5CONTDO0HB7qmwvr2LPf
	J9HAwbK9M8I5UDUUH60EjIh20YuZLuU7v0MMUlqGdTvpPnJjOTLYVJ8yR5riHc+XL7AiEIKnaHq
	/PHoJlj7WSQ2wGy5Lck61L135OgXlyPhq5zfOBZkS/44mnOx5ctyltYm3wawgmfcECKpQw6uD3c
	R312AgAeSWAB/AnV+zDMRATIhgSybfY7ZPEoHbbWq7qbXQPaWgGXv5z0ETUWharB6EbuwRuGiNl
	NLWvCf7Z/h/d9j2PiZz8o
X-Received: by 2002:a05:6870:4066:b0:4a6:c1cc:e1 with SMTP id 586e51a60fabf-4a6c1cc0336mr6240528fac.5.1792028065404;
        Wed, 14 Oct 2026 18:34:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41452sm3428139fac.4.2026.10.14.18.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:34:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 19:33:55 -0600
Subject: [PATCH v7 08/16] mtd: rawnand: sunxi: avoid a second program
 confirm for OOB writes
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-8-5d3fc6ad2da1@gmail.com>
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

The hardware-ECC OOB writer fills the main-data buffer with 0xff and
calls the selected page writer to program it together with the requested
OOB. Both the PIO and DMA page writers already finish with
nand_prog_page_end_op(), which sends PAGEPROG, waits and checks NAND
status. The OOB wrapper then calls that helper again, sending a second
program confirm without another setup or data transfer. A failure of
that extra command is returned even though the actual write has already
succeeded.

Return the page writer's result directly. It remains responsible for the
single program confirm and status check, including on the
bad-block-marker write path. Raw OOB writes use separate callbacks and
are unchanged.

Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index dfdd8d8aaa6f..6c4e1740a245 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1824,15 +1824,10 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	u8 *buf = nand_get_data_buf(nand);
-	int ret;
 
 	memset(buf, 0xff, mtd->writesize);
-	ret = nand->ecc.write_page(nand, buf, 1, page);
-	if (ret)
-		return ret;
 
-	/* Send command to program the OOB data */
-	return nand_prog_page_end_op(nand);
+	return nand->ecc.write_page(nand, buf, 1, page);
 }
 
 static const struct sunxi_nfc_timings sun4i_a10_nfc_timings = {

-- 
2.53.0

