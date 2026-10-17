Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87612391E51
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266818; cv=none; b=sw07tl9tFEufWOW/aMSSXk9WkejFiB6+cLtbUv88QklIOFPdCqOjN6THRgLB89EjedqeHXhgBXay72KhqSgl88TNS317s3hyHkizbOU044BU5BHjIvXnRTrg4excDW61FSQ4sBNFSXLhOIbfGn1e8Q8yInuiwaBzvb+gz4IIM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266818; c=relaxed/simple;
	bh=xZ0mPLMCwDzY8Ny6l4vz2klxVY5qj+EkWBSLeSH6W5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdU6Akmn4CoGNZ/8+d/32fpGdDzhP0TkzhFvOMSPJGgeIOQAOqsBy6z74MiZEQ/0lAKuIM0GFDcC5mf2oyEipeF4vJaXWL6+KXi0Az5KFA8WoYVrMF80by2/d53U+vn8Nim1RdoBkYHMtuzsEIrJb9KPI0XZE0d9gaH1/KaoY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSzZdMBp; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSzZdMBp"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-843a4ca671eso346797a34.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266816; x=1792871616; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xcmdGAknSlSB095s7l2UZ1pCIYoSMNB0vG29+Hnkm4I=;
        b=nSzZdMBp2mHe3UuWU5zklJn/+kjTMJajRCeiB9QVK+YiRFlYHEViSR1oNmYKBBIjYp
         erV5fv54N9ocEEYm+slTCL3D8SDHmAWq6vyZzh5gIi6FggRmkoOCe375EcVcLVyDaPqf
         NhDk7wLBZtog7apr8dj3tsYZnWjRL+Z9Caay12eXt4RWOWgLtFvvCwCVgouPeUrtMKJt
         r5B1/8nnw3S7NBY6M8o3bT3fk6JSI/6tW7mWjT1D59OT+Nm3dx18hL6awi8m/YndPp7L
         HQXnJdOlKzPXl6xgxEEr70e3sNbnJ81K4RfK/QHRNvM/Ea3+Gg6YBrcyWQNDbFxE5HsG
         hzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266816; x=1792871616;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xcmdGAknSlSB095s7l2UZ1pCIYoSMNB0vG29+Hnkm4I=;
        b=2tHPlrwPr3enp+YD/AovekY8fHMIcJFwcx4xh7FA0tR0qRh6C0yf1VKjUsA9WTEa2y
         bv5gzN6dq7vx+5VRzuFPYeSWsNfh4sbBnLCNJdehTbj7ylpQmEUy5PtW3goUfCEyuIaa
         utov/8p+pX6JPyspfpImVdXl96rzneYPbRoQDEWI1QOw7thtABGbWegnbhCOajCpkMUO
         zpjHEVllwa1aBYg5TRTo+QcdEJDn4zduRoERp+5cy41rkJ1YO6V3da7mP9XCDTCN/yYG
         ZPGO3y7KzGrlrpHJSF7VbsW9GVTU+4Bi+MUw1RklqLo/tWdPjsOf1TC2tHCvChZlTCgi
         xvTA==
X-Forwarded-Encrypted: i=1; AKwUvBzEytkeadGNhR6QKY0faMWZYQ0e/QyLH23grEtKW4MCGodycGutxWeRosroSbGcE/skDyyID10HJqOLj5/aLA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKCW3ymydaya+N/MamyPcdaLwiQJX6hhbHwYqs8p6g4uOmH23FW
	DPVfhnJLlh93rKyYL4XDYwKJ+U7LMmOp3bGS7z9t7CVBj9+z+tPLeq23
X-Gm-Gg: AYBFou3b3HYYmq2E1XKTr3YIm6/At68DWBI97ERS2FskzH/JIuoxLAPt0AsykjF8AmD
	N/B9him0IBLo2pSuQlbhl1SbiVwGrHwk7wsKFr7x9Z3qAT1yStkm7tv2MKAU4JmuJ9XBAmLqO6a
	szdxN4YyrxXzpRJDt+fVWOTd0tSp8658DkI1fM3/yLHZAqeVs08ICcfGOFlphvcz6wGfmqvdi4Z
	r4sDeCybJqMkZzb3Lsz1EUTqe17Y7zujmj3kMNSlHpFpU8IkVBy2tnU3tsKa2pull21MsP+FWB9
	96pcvY7hSfg3XnsS/wXCXXhndbvyFcrcuIf6YmcZoDsG9JcbuL2Fx+4RjDkf7tyl658H1ryE4+m
	cz84Qyj/lEFHIO6dcVkml5+y7P0SinniuVslTd/flgx+ZW+d7G+4U6CHlfgrU5iogeqIpjHitWF
	H/ARaoj4nBHboswlLkPECk4po54VSThHyxGARNt6HRVeKr7/7DnlpWdsTDw2b1GIfSQU6hIm6ZR
	/bpbS+Wb6ArPfaOhK2LFFPun/Aya+MS9o+EzoYVtqE59kqSTvOWzjpo9skBco/J5teeZSgENwzm
	pUT9/ePQ0SsNohHdHTGvS/F+zyWV8pCp8mcKU6IohmOA9OrG/xA+FrQdx0fnwEwUd2zv42owlbU
	3si10khvK4HKdYtpPiwRQQ+ORqIpK1lA1Chds1jMCcO+D8i6XAPW5KA==
X-Received: by 2002:a05:6830:4129:b0:83c:2a05:c65d with SMTP id 46e09a7af769-844ff4249d6mr3801148a34.18.1792266816507;
        Sat, 17 Oct 2026 12:53:36 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-845b9e280dbsm2212064a34.19.2026.10.17.12.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:53:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Brian Norris <computersforpeace@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v9 15/18] mtd: rawnand: sunxi: avoid duplicate chip setup before page commands
Date: Sat, 17 Oct 2026 13:53:04 -0600
Message-ID: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-15-5af9a1be16ef@gmail.com>
In-Reply-To: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
References: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit

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
index 993e2efcee04..45172175d4e6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1685,8 +1685,6 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 	};
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1712,8 +1710,6 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 {
 	int ret;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1739,8 +1735,6 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	};
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1769,8 +1763,6 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 	int nchunks = DIV_ROUND_UP(data_offs + readlen, nand->ecc.size);
 	int ret;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_read_page_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1794,8 +1786,6 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret = 0, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;
@@ -1839,8 +1829,6 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret = 0, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
 	if (ret)
 		return ret;

-- 
2.53.0

