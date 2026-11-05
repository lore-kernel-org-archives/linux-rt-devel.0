Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904947;
	b=sJs/EeGLE5nmw6rg8Mkh60aDmCrGJUzRS/Hu13H3byywPhsvVaxNx3Gi+vkK7GcOD0Ot
	 Vry34Xg/cvST5Sk/ErG9T3pGlthhwdnNOO5LV4CvED80IHbS7aBQfmxDZuTjQiiOhpDsR
	 pQ9vrLBpAO0/OklGaAfiXdEFjFRKk/rMNjkVs8DWTCnn9TDy4esbkhOq6jb+FB2smL6Uv
	 E/H3+uU07Vyo0G4M8ZYjXGAgtlFhiUvKJSSyxM0YyizB5m1zebdJZsrLMf/X98uANl1i4
	 ce0hx5GC9w4trC3bTcA2l6EkfxsySjoCW7bRbWbrH/pFTnqiXBuQCOPIaQj0CBlqaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Km1F4VU7EFf3gMbcR27k+iCcZ4YJytvSjdEZeNVUaRo=;
	b=WX4RHwgvnzrQj7nM3QBRxD2+AoQeoYRIB0avzDqbxmiMkzyfPlQolTK2Y5hU6ZItCKuu
	 vP0R19CNevcN7UBWI0EP1hjn3p36sdwrjOarvcMGoL2vSf844361wL3DSa5+DWFMQtfD/
	 tXaNgLWQgccZ8YT4O+5JubaqBuLAPkapJP24Z4thOdiVtxcrXjRjDN+HzJ1YpyahVtWA7
	 Qlq2s58V9rl7H5AH6bb5bBdcMMH41OShAuuJapk6TNTbTurn0+rggoYzWHqWWcm+heEV5
	 lss/5mBm1kHzFPxZvPEYha70ZXoqfj0cGt46+vJlXhH55h12aM43G7g4h0RzWtF49bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEzWca7y;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E88606D81B
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E88606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEzWca7y
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6df5e315bd1so1891449eaf.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904946; x=1794509746; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Km1F4VU7EFf3gMbcR27k+iCcZ4YJytvSjdEZeNVUaRo=;
        b=YEzWca7yu+tGs5DLO9SRzo6hjdNmHmzhWQzVdFXpkkTf9Dfm9cuh8kEdJZ85/c9XX+
         qKZ3lxGhuxHbuhPjJtsWEMLXzqMY3g0sMNKNKJMPYZYxzLD6xUen6m8qoi1c7LWHnXhg
         /MPwiRllLRm8AzYIkn2KpxlEa3gbju4UiW+vlsJ049gXqk75ymRhuRwggG7kNJPqkapG
         izMY/rykNjWIwyZWZ5eoQbWAp0eDcB0tmJRdo+/7fv0OWHmYADapCb1VmZIDIpYgElq8
         pZE5fzeDBCn49unJkcFkAYwvKpaOsi6LHwxbu1KxYPWWW7lHsmJCuQCWLWSiM1O83m6W
         V20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904946; x=1794509746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Km1F4VU7EFf3gMbcR27k+iCcZ4YJytvSjdEZeNVUaRo=;
        b=iRV0P2hDMqEgvcC3p940mwkTmd7Tgek5JMUIiUAIxmPPn1xIQmDgqOMVeUvw7YL+pR
         bA/v0OZww0Ox7blXPvpVX25xnMCt/OcwVxaCKdBHhgWaon3bAcPHfOxfUdyp/D16Qtuj
         QMyEA4fZ03a6aA1ztG8QpAScpUGPehJmDBW+eOcYvhHAsdiJzi8hWIBhjLKP/36OlyVj
         t+udc9U4Yxb1oG9U7LKYT2tJdAj5DffDV2S8u+hYUagJtvH+wTDOrS0CGKBSI341vZ8m
         egxHS0C3z/6sd54bxC1LD4NEd9HQK1RteJowSb0UWEizpdwxhWpHsLnziitxePiUw3wA
         IwIw==
X-Forwarded-Encrypted: i=1; AKwUvBycaKYpZDVmzatdcnKTPNQh3pSmoj0PSuU/fnAJW3Z5kpozmQp8/7WVOnRpclGgxbni6q9/EQJgGclvvLEppQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9cKEV0yrmDPyMUNqIWR4//FVQ33UIT7ys9incROxw9QK5jm9PI
	8a/GhpHg084BUgRajvPjhNwGDSpqHERNpN/78xfPbcZ3M3Gj1toBIu+r
X-Gm-Gg: AYBFou1twQNngI5PQuKzdZIZvblCgrTtN4cE0ehUPutkYWcvrJUnAk7yHqdnV8oHL/z
	A3K2kzhxBtTdmx8+eNA7pvqflw18yojU+tg9bWTqLfFW4ZFT059GabOwmUQRniFiYrWLG/nTjA5
	OK0mW+26yUZbUi2mnQ5HFUMfgE98mUpii4II6a8huD9WOFLvlZlHBcSLMTTjcSlwLUYZ5KDWJpk
	ypYfs2IhBvGrR/AYJmpGXiNZHd1fhcatlVk75zqNYmGoRkLBQOJQEAWH1jeAHiKZiy4PvZt4Fh5
	5TPxka64uPIQ1wa9UbBoeu9ukWCgaRUKrT2FTWIjeK1TLD8SNHb/79OUsWCXAw0mWOhniNMaE/j
	31B0ZlcMZ2fA8np/7jT/gfQTx2g7LuAW8UBV1DGSJmkazo48MeWeIxNLh1pJzQyU6dTkJmKKZQ8
	Og+/UAquUYBhTK6m7jiG17rEBpuSR8xQmv/u7xCXLbp5mLhfaZVHZTtCxdIDSGcgJ0dBecm+WWK
	uAfOarMwDPm9gLUHa7um0Ap50hPWke++QiFsvlyrEWmBOt/ulKfzukLKrRSJeZYqfer0/siP99U
	0MH9QWbnhu6UyYI3RjtDOVQge/EXUtrGI+4ThIHPssNToqOh0SfgOdpQxH57fskeTYxxDz0iDYc
	KJ6RYwipw0+sCgCVF+uE/m3CGqSWThBmUVwCP2zhqMj8KQ7nI2ktWHCdO0DpZ8pxC1SOATvuA77
	dTzHcZWIsFVWEacADJkmOoBc6/m0U9noH6bwLw0zzcf3QahcA6qnyc
X-Received: by 2002:a05:6820:2d04:b0:716:cbdc:4fa8 with SMTP id 006d021491bc7-716e796f91fmr333364eaf.41.1793904946065;
        Thu, 05 Nov 2026 10:55:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:45 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:24 -0700
Subject: [PATCH v10 08/26] mtd: rawnand: sunxi: stop failed program
 operations and disable ECC
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-8-dca1f6ed29a8@gmail.com>
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
index 111094b1c64c..02aa02d2cdb9 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1611,9 +1611,11 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int ret, i, cur_off = 0;
+	int ret = 0, i, cur_off = 0;
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1628,14 +1630,17 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
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
@@ -1649,9 +1654,11 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int ret, i, cur_off = 0;
+	int ret = 0, i, cur_off = 0;
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1667,10 +1674,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
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
@@ -1711,7 +1721,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
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

