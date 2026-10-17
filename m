Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9452F7EE9
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266388; cv=none; b=GQqyl8gHifnOZMz3IJ/t+c9p8RW9yAGdDOY+RwUqzeeFv96TwoNdMYKOSoy+V0SorPY7U0Cuol6wH6C9n1ir9CMdcPGaG0C7DDcJ5XRd+AShhpWnKSrmeIS1RInvgjqWX6Yh8pPeDx3f86dTj3W4RFxZDM1SxzrDpEIEw1kY36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266388; c=relaxed/simple;
	bh=a9bbrlPbxY2D97Or1Weh83hc/hd1sg2iaNGPjE+jr64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaVGmxvVOKMhim3+mS9JaHKtbtNJnDgJVIBv7P5DzKYNrbsNm+FTs5taWG/Dq6HD7yyRAXwiuapuKkR+iAlLwpFa6JL9b6xTpTHewWF4IV7YCTE57itokSuoS0FQCOpZgIIU8ScLUacBz666TPJD7X1j94knInbw5J5oL6aNDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ66kmNn; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ66kmNn"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b28d7c729fso502727b6e.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266382; x=1792871182; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9jTHHCWKanN7K8lakzXwANno/EOLzQpBktQemhjHz4=;
        b=eZ66kmNnRPMZqQgfMOnebyctlqKGEkg3C+OQC4FJC4UFdDr6GFLX0dbFtqlxdxv4L5
         UYsbd3c6YqCGII+aS7EjVFsD4PWAJmyUzA2jMrh/hBu/tVz18tc4m5mm2uxpl1q0cO+5
         +PYwTuFKOxOtrzvq7LhSKo0UMzq80d7vju61LoA1SvhEsohnuJBFT8yvhyXL2jpTlkcH
         WBSekGjKpyxnS9+P2AnSnStHItsPDZdTS2Ma7m5GQQzsjf7eh8irZ3Iz7+sgSVgQlCgH
         1T53vh/dTUDfikNiKL3IulwRjWod3vOXf4cL1d5g456cmo9PN981hDp+pmefCoQ5U0ff
         GS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266382; x=1792871182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9jTHHCWKanN7K8lakzXwANno/EOLzQpBktQemhjHz4=;
        b=0ciLUyMouzXiMEmg4k3eybv50qjq3VPYnLcYLfyBPvLgJFlGS/pKqF1WTnioqG3ihh
         AZSZFyagdy1m4LgThxrAek4rVGjXE/5R0CTnKgncnQg2BJe/D0WqOVBroobGal4HV9fW
         ZjIuD8nDgjogkSD3tDUTEZe7SzrISqREv9UdWvBAPM3LVsHkwiubB8YbMBOh7l4+igVp
         CSwOukwbIIeAb+B9kd7c2ZO/K/QHDjSzi4Ek/OsYyZOEpMhVUsoovdKyH3kkHYUCJX8I
         90ZoGwUKT89bye2YRfaAp3k+NeNT0UIqp0qTyYmyoiWlL1xm2+h8F+QoPAoo9qAJ6Kyw
         jmow==
X-Forwarded-Encrypted: i=1; AKwUvBzCo4rrMiX3bB0tUL5LKmmdtkK1dVR+AzGMfY20bd8e1pvGzFY7dQzLhecvjLO129fz9prxwTuSigbxsuU0QA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKxVHKV0X0WvOqJUWwLcni4LgaRbdUCnt5ZBBkT2lnL4oy8W15d
	6dXsERRubnblU36Nk3i8p8TjWX6ylu4mkrWsWXgJF8Lsl248SaVfZ9+9
X-Gm-Gg: AYBFou0N2QZ4sgzM2rc7gqMqiWshdMFcI/kWeUXNxhI+hJg5nUpbUiENFdhaodvgNji
	qp3w+qGBh8pphN37lgABPxJVVzT6QPBnHHNPBGw+YKBBoSV94aH95lH3I6XemdC743iB/qeooKN
	DetUFpmYdvAQbinMQ9ndxyeAC/xJDtDlNw3sbrHEapIKv0fRd2FtLb7KXu2gr8mJAkSK3yvPIwB
	eEByBBBndvN9WbcJbMQZ8Y8fomR1Pm8N+LMHy+kpmdoQv42xvF0LIxftatgTyybg10CjVSnwWGc
	3PPfKetLr4ZYwwV+QUQgs8BgYzei6rOlMkYbyH8gNBKgrPCrM+tKRjyOVt967+mpBd3twwJGy+Z
	rv+4XSjbxrAgPd7V6EwNigWkhr4XCN3l9ucwvuvJcdHQaxsWy+ilQ4j3F3owNUleC/NqvlwMdic
	PQBrSat0y/QDlZOxN2D9hCEawgI3vVo9p/RsqnrgbF/iq30KOpczG6HbcAXl+OBn5hiQz1BL+2J
	JWn3MkQF4kDD0vqG2hSrAq3ewqZdg3dSQ/g0WzrjC++1u2mGHA2tv63SuWuPBaAOrmvgT+zjbLW
	C8xcLu3C77A5JKQRJyZ4xdumYaVZMPDZUAP2iM57pHGOVK/rZ2UiFbaYVEZTtUGyj9g7EbZ3cMk
	9xdkTgtxK+LXuzMhW+Sq9
X-Received: by 2002:a05:6808:3086:b0:4c0:89e5:da46 with SMTP id 5614622812f47-53ccdca9f83mr2990622b6e.32.1792266381790;
        Sat, 17 Oct 2026 12:46:21 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388dd8b5a2sm4025321b6e.12.2026.10.17.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:46:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 17 Oct 2026 13:46:01 -0600
Subject: [PATCH v9 06/18] mtd: rawnand: sunxi: stop failed program
 operations and disable ECC
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-6-b624c09e3ee5@gmail.com>
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
index 5b736a4a7fe9..1db6ee18594a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1614,11 +1614,13 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
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
 
@@ -1633,14 +1635,17 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
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
@@ -1654,11 +1659,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
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
 
@@ -1674,10 +1681,13 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
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
@@ -1718,7 +1728,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
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

