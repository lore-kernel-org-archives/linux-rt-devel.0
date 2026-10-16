Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120E3B2FFB
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122345; cv=none; b=svP6PNdoyT+Uxnf3l9OcA4a8s2ZVXbOmV0g1ouLLtJaeAfk2z7lt/I9TnCMtsOa7hVGrs1ifb0Hy5vGPx6zXBBa6VuuFPbskIA0SDBQ+OgO5R2arOoqmeMPAuQ9pdyovGmnh4SnRIhrf8RWvZP+Db3wMlKm2p8iGwG6U4s9cJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122345; c=relaxed/simple;
	bh=L/2f/9mfvoIW49CSofbEAEVCbPChwciqXDpasHFoGaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TrBKaWFlPvH+hzeeOgve7CYpjXbR5bFCqF87jbdamHfbNWMpY2yrSHSyNmT0wQQscJ+YEuBPP/I/iPfUTRBiXFE+TaifESBbZ/GRrOylWZ2LCfOaMijVx3VGuBR4YX7COAyi9ruqziLvVsmuPT9193qts+LAsEXYQX5ftYTyeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIOQbFdP; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIOQbFdP"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6df93f00f4dso1434605eaf.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 20:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122342; x=1792727142; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSHtLPHY+Puvgtw6ujh03ffVT/c3YjQWJScgGpszE50=;
        b=IIOQbFdPPiBp5+ZmI4Uj+oi0zda+r+AAMIRlOH9qInWs5idpbIc9Za9i/pWg2VctiG
         FyHHkO9ndzQL+f7VgC5Tc7YSePDGd3Sj0DIJYULLJ5Ag2GDDUc5o0qHxWyp4NrNwZcwS
         1gFirkLuDIDYb2CxNSr083+060Z+zHn9Kg2wcPsUdFmgFbMMKGcjoGqO9FWZTyPYrAA7
         p3AKaGgeWvBeWTwo+aHzxt29+TPREDVyMTzvo0VXIr7ZJZK/Mz9ZSo2yIoyqVvk1TwnD
         44O7UEPON2E9thSYVrp22sQlgRKJI74kN7uk3gxMSPlW4qKKCiYkQRoeXBJZC1ChvdVw
         blYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122342; x=1792727142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSHtLPHY+Puvgtw6ujh03ffVT/c3YjQWJScgGpszE50=;
        b=UtdqskTQQoBiRRRBfJ49jZTRYR3j/kDDLKy9nIswIkjAi40JBdqlWGiBimNad0/IFx
         IiP8oU7yM+JCOMk1DCNybO0riTxzV2NlnhWhJh+0qjxUOWFSFRaOBmuber6HNuRUgOnJ
         G8qMjFKMDAZ+tpujwfvbQ+xsOWkebZMp08gnA3NzKtDM5B7900veTeSz5yeq/GF4oWXm
         5aCIUIenDqUOhzZxxw0S6gYcV7I8AuPy4dUegaLUHjvue6JSPjw7qNjIX0OvcAlLZdHj
         PjnFnaveCsfX9eMBQY0uEKgPDUuTneRR0oZEUZgvfticgFWGJBB8GJuFp4VrtL33lT4H
         4VfQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1yuLOUmSrjJJMA59e8picX+ha43UUwp55LDPHAbLdY31Bss3L04gNgpKk+tAVvFIt1u23fQSXeuUd+/uGhQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ/HWkw+Dz27wJhLY0vdXXOpdrL+aawpvpJbV4j3kbp8EtTfk/G
	tzH9AlJj/yaU4Tw+AYI6PVpOv80wAyn+gFZkzvov+NMFG+BZilQ0ljvj
X-Gm-Gg: AYBFou3cF2AvDGGHdmrUi/pBw3xls6yCLzhc+rXCU4tvnZx+n8hiJKPQPaXB9roObNU
	TRV8af7p8F50JsGrMN9ql18ranrlc0Da/zkTp8FDnh6DefQjvJiR8KF7Fe3km7BAIFGmBU4Xr0x
	+IDnNMep5loFbkilca66CC8a5NS/A9B4hPhpU1QRxNNRHTr68x9ZXWuSzr5heJNIR+kMc3cbyWX
	7y/BxSJ9kJndIwB5fjp3U2JvDWQnWPtcKCyjSe2G8K7I5fGybvU1cwIhiimGXiYOSOLMLGbEYQM
	tUNJ6zIzZ1dWsARrLvgPYZmLDUoMUexjw6VZj4oo5/fUwwMEvqxHYQBNZ3LCyUkq8ct5ejeersW
	Sg8/QcokxgSH45nS+BpECsKrB1K6B94LcgQtdVupxO5vQVDPvF56m4xdRaodJLq2cMvJpl+rQt8
	gbT2wHkW7VUl1RR+9eXU2YmaBuVWL8J3R2Fre0/sxQRuxdYgrtntZLBSUR1aj7sgkGGnR1ItpAK
	Vd58PT0k8g55Um/RPzpBtbM0G5JG2pGsLyC0k+SCyNoi/a/SY4jhgnJ05wyojmhocfF9vGt63w2
	vIH0XR4CPEcR/WoTP7kQgQr4ydlBtETWOrLoYduiYwb2yUdrNay/XT6z8k9PRi69E+Vu2vgGCxb
	mJMv9tUZVSxJDIRq/+MJH9WcBQItYHyDJ
X-Received: by 2002:a05:6820:4c14:b0:6c8:fb02:527e with SMTP id 006d021491bc7-6ef102aa365mr15532787eaf.39.1792122342481;
        Thu, 15 Oct 2026 20:45:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm834402a34.0.2026.10.15.20.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 21:45:24 -0600
Subject: [PATCH v8 09/17] mtd: rawnand: sunxi: avoid a second program
 confirm for OOB writes
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-9-8ba4881fbee8@gmail.com>
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
index fcb017f048db..9f03ba22b4b7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1832,15 +1832,10 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
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

