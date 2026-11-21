Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223473;
	b=yLmtRY+Be+JblYkF52Laz/GMbiAiENN0RSKYNqY1xsKpLEnTy15XYA8E0T5iinLGLqq3
	 f7PsuRxAm5u6tAhmvtu9oHnTFhy6clPahk/su/ankHeLqIrxa4eEREYnoUOQCEa62aDLi
	 Qg78HXfJE1aHehH7Mpqx5R3h1I5K8lfa8r74DmT5gG8ENFLAfrunHCB1Ec6Dio0fafdQw
	 1HRch8N/KqvF2/DcyNIiJeUEalju9cBDTyikdUy/P1SOYtcPdw1qSQPuJhInVOfhg9kyN
	 tI/1LVXvdw3cQxjyGizFlRvaJXKJjoDZUVEi5Wt0dIrey6GKQudXnOmUVd5Bc4TK+XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=q43OtFOdNFKAPwH+oRkUo2vplhtOIciQt2V0N0tE52g=;
	b=HozFRbl7WV08/N3xqgQah+koZcfZNmN7um61CecpvCjYSjejDP6KseD5pb+9I0O2Pkf3
	 J+mKKdLzrVcI0CUvOiWEDsQzq2ZIvAu6LwAdmaQ5gyKOgeu4u3aQ8qiWqobKOghH3sNF7
	 iHS+y0LLlYglz3CzQnJVzO9U8mxOdh1pYuBc4MrC9N79jE1wb1Qs6720H2y/+mBlLbgKy
	 EUr17THW9f0o3DFR4SY5FWGP3rKRGqZJMDjBid9IGgPgA9bnu60QPZYe6WjHagWzbVfhS
	 wURGHoXB9fJF/a49Ly/1n3dWT0tI+6EcS4YubcC0lmDDZ0wZ7mugtWYtr110VO+Xs/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3k0ylQY;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303A60A380C
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8303A60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3k0ylQY
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-844a8bf7e25so884008a34.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223468; x=1795828268; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q43OtFOdNFKAPwH+oRkUo2vplhtOIciQt2V0N0tE52g=;
        b=l3k0ylQYNt+RjrC/CfafjggpM+6tZ1pAumluBHy4eNGxB1anG+KtpzOwHbIehJXFa4
         DEVsspwN9HAHHEe+2tjzB363R2Cboyw54MilRtuLQkHXC9b56LsmvOBM9Vve8nezy1OG
         sePetdDwYpMup8tx5W42iOyQN3yY23PexRf7iu8u6ZP3Rk3kr5zjrzR70HWsjvowI0J+
         wzM4uqnJIwb3wQJ5TTEvNK9VWvrBWSgEyT3WlkrHw4BapnfSPozgKgumMVXOtG2EG/wF
         UmjhejV1FHIJoBaQBJY61UY1klAt3riS6jsWNYJGUSCiZelfozFkbqciBJNVQuZBETEl
         HryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223468; x=1795828268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q43OtFOdNFKAPwH+oRkUo2vplhtOIciQt2V0N0tE52g=;
        b=EnWd3qYWBxc2NWMYofuTLogCp9rSiVZWybJ1JlazZQp+zHoB4R038KAxGmmpsktkjq
         fTrFxE9ftKyYlcXBm5wvLI26sVGjoz5AEgpZ5BhvSeqpG/8ziplk42/PT62XXNB1KXsj
         SYk5r9R85gQse06j/obYNsWio+il+aiBG07ydzdZK8TtYx/30yeNn0syMx7i7ltbxwiS
         4rLf9h8Y9bvxgoLDWKp5frPFJpamxNuXi5p2dSDl0rnde/XRJXetfLSKIUWv/byJ/S24
         +qD+adCXWa0HBb6b2oFB5AU3LhuIK95Ap1SLeJAH6I7EsuipVAeRtE25tMdVuwG6xB8N
         JoLw==
X-Forwarded-Encrypted: i=1; AL+hErFiDLlJ237ER3TFDK0j4AGUx9Rf55I9qi+hQqoJ2y+mVnId2OmZfVACYHTiXudjgxVCvFkr3yDJuwJ9rCrzCA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+LgoC//YmsKjTPSLnYirn8uWhiC2Bt/E+eOs+1LOV1zL2nsTl7
	Jh+J9ZdfHu/nMZW5y/Wy+ntDrW/wRJALDCEYiYNC26snBIFjTOXGwbQ9
X-Gm-Gg: AYBFou3oh3QzNyhUiTNzJ6DaLLaMjbSDzbEt8CmdqFZtewv8dCQJaChmsn9EEuLXnTU
	M24/B8WZ8gFVm+nTTdw8HltQQb05mgUUMohTjFc1UzPjOIc/UmBepdPnaIDudVYZVQmeJBL01mD
	yqHq62YnbURXEhSeErPyiVYbOTysWYdOYX71Eg6H13yu8SK73CZqhjOd4ku9y0/iRCpIZAsgevb
	5mAS1tDAkmxomLngxcO/xLlieXTUaRD8ImIur3CQWhxKE8YpLCBjupBSMWyYjGDYLnRwBMC1tw5
	ugtYXmXloYOrsY6rt4MlQfR5JKg52qck1Nbg++89lt9lDbfkoZ5k2fcvDeAwDIA1P5ibubi40+T
	ogWWWa+duYuwKH8d3XTRfhLaM8k4DQBhUJrRUIG+vV7KS3wOyeppYfo9+jm2K3P/1LZYGgfQ2X0
	MVA1xhBg9CwtkUqkayAyaLpRuYtP17AXJpNPB+a+3eqUMM3ALMDPanLYg6pskm8zyxH3A2cu3r/
	/BRpjEYZd4bRGWGklGffthrZRxnn3qvEdTA6EsCGNtFB+4DfAe0bB39zehFTHfo7iSIz3L4GxHK
	nc6T0P+ie4lvp/igczZLM6wamcvq90XmdkE4u+kS45pmKsBEYZ4f6Sdb5yWWnvYv+MzTvkO5BhV
	d66V7lUcZ7eZqGv78R/AcHmZZfrQjukW/pQOZbxlah85Yhl+445CFr47/JLTTe84kP5vG+3o1sk
	0obFqL15p7wY0vEzXrI+4/Jj7IfUUi2spVE2oYN5aqsHVeSDKLT73z6g==
X-Received: by 2002:a05:6808:4f6a:b0:572:75e6:1d0e with SMTP id 5614622812f47-57a06d1a870mr5691634b6e.5.1795223468341;
        Fri, 20 Nov 2026 17:11:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:32 -0700
Subject: [PATCH v11 09/26] mtd: rawnand: sunxi: stop failed program
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-9-9721b1905ef4@gmail.com>
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
 devicetree@vger.kernel.org
X-Mailer: b4 0.17-dev

A page or subpage write can issue PAGEPROG and report success even
though sending the setup command or address timed out. The PIO and DMA
writers ignore errors from nand_prog_page_begin_op(), transfer the data
and send the program confirm as if setup had succeeded.

Check setup before enabling ECC or transferring data. DMA preparation
occurs before setup and may already have queued a descriptor and mapped
the buffer, so use its existing abort and cleanup helpers before
returning that error.

The PIO writers also return directly when a chunk reports failure,
leaving ECC enabled for the next controller operation. Route those exits
through ECC disable, preserve the reported error and skip program-end.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 6d7384aac917..76f60fde7a86 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1578,7 +1578,9 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret, i, cur_off = 0;
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1593,14 +1595,17 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
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
@@ -1616,7 +1621,9 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret, i, cur_off = 0;
 
-	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	sunxi_nfc_hw_ecc_enable(nand);
 
@@ -1632,10 +1639,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
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
@@ -1676,7 +1686,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
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

