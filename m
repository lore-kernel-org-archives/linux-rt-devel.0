Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0059495534
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266399; cv=none; b=uGsVGYfb+Zco9w8l0YmrBHtkCDNh2gnKrIjcPW+yqGnO5NbpAmH7QSYGbWmxfSFtwXi8bDFvvJO2QaCjShxiuYsh5CkSkZmryq3128TITcw4J4lB4+NUaSIBYLsjpnwQP9BmdWYKV0E2LKnhKYWxXYa16L+zgI+Zx7t084rjyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266399; c=relaxed/simple;
	bh=m1ZuakMOOcoJ2UTtQA9uEqk1ka8SS9czOwQlxYyqTGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxAb0qG42FUpk9oLagGVssh7mbw7B5ruZzGFJyj4t5l5f8OZbB2K9owkkHFQpC9ouMdfqghlkl+9z2I2Kp8sVxrOjPJEV9QcEveHD2pOIAkv++6nqukNiCS7imxbJK2vYRT2MUw6IYtg10q2CiZ3gjI15APhbU9V/Xpvlg/U1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/+TLI6Z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/+TLI6Z"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6cfed5dd083so661923eaf.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266395; x=1792871195; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggIlYqb11US26O5sA+ImWPEli5zTJui5OSrJsvz0LFw=;
        b=Q/+TLI6Z6vTjuZFNh6jl8t1wkOW9gPvIchMI0jtgt8OzBIuoSlG0YybJxcOtkWxx/B
         3BitDku3DAhdKMZvBreKnMPWZ8/IGGvA/MKoQnkauf3JhPc8LrXuJiHxzp+D8dP8kOJM
         cfHOPpO1uHJUIdA1HW1oQHXnfJyqxMdDxwhDCpKLrM3kpP4ie1KpDrrEVl/9vQGj7rz0
         k4FQCB3bVwnv7Vjo0PlsVSJ6r1SsQtBA8Ps2qt0oihHurooEQNln5W6BcoFeroTUGQZ6
         x3yllWtML1d31s68oMi+PmFjS0bVOPeaGKlK9lmNPl15ORPWfApGin26eXN5B5iEPyZr
         dNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266395; x=1792871195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ggIlYqb11US26O5sA+ImWPEli5zTJui5OSrJsvz0LFw=;
        b=ZoewcvVS1XQv3QdV48cTs2BIWuXDstridXgQBAbOOCYVfG+ulcuB2ZePo1hfll3uk0
         HuwuhSqeMHCPJLK3CCHAZckOJ1MpTMUnt3pLOon11rPbZweH44L/ifood3hlI1nDeYOP
         GkSLEbwweEX/tS9aZjwjEXzbIuK6PKaD5eiYeXQREsa+0LOz1WhIAjlZoREGcoPjCfzt
         f2W6E/oH+Ku5L34ituVivrv1S1+jBP0I6AdTIVBptvyZlMrzzcS1uFaYu2XWg2eutoPv
         TeA3D/jnZSyMOlSA+h19TQ6zdWrE516qV387kW5g+4VBRO7Hte5y85kBCx318TlZDIa+
         x1sg==
X-Forwarded-Encrypted: i=1; AKwUvBzeI4aA/LkpmNTednlLN7F23GdNTeOWBlBN5KO5muQg4uZCHKqOuIv590QpfsXLVogin79biqKkISJSd6EPhg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL9Jl2LRf6OfetLZPeYp+O2hNwZS6rDrknK8Mlk9qBWrfzil2GJ
	6Cc+im5IKN+NHGW080kHYogTyKGvRRD/6cQfD+8LVS9k1Q420Qpf0Sih
X-Gm-Gg: AYBFou2SHR9kZs1cMs3aoNJPbRMSBY3o4NkqT6ekQ6zdDdv2Jm5QkfDttbeqP6F/ntV
	yfOZJRBc8pH5kIOLjt439+1nxifhrwyI/iwvoKf6g9a9up9H1nSpmEen6W+BjYud1SBxW5V9h8n
	Stk4B9SYSic9gTRbqg8RNcW+8XxlY4hCh+dtzwx7V6tm8GigCuYFGd2TOgfKMLeRqXP1ON6LfGr
	DZmEywgZlwMm/FuFI54OggtsyBwIYkV9+0WHFeJ3VMYs0DJSW2iMIMBynPTk2cqgSNr6vYloqbj
	Axcny+0/mfwS2TsS3Eji821ZZJcSnErDjOkbOzFZIhfBbiIfKU/3zCVr+ezTYGdANwXL4kgUZG9
	nFmkmIpavnXaCZ7fl/nhvJ80n0Ckw+9xOCLJWJcyFltG18J2s9XQBsNOTDuGaLwT+6p5fpRN3g4
	Oa93r+7QSUB2ezJIuZb2Gz/P1Z2v7E2UjTT2dKuVnjfKYaaLuVT1ZHrpQc35nMG70ZgZJhI2Rao
	QpdP/tdk1XEm6w0tJokJ0+bwIsnXA+ExYk7BIBSZA37vGnhqzAWEKQfr6/pqfIigPB5kIFeMqAs
	QKNaIbYrusWREaKyPfppZVxqPABFLzubZbasMNEPaukwvFwjyM7v7EGsgMuKvbkVH84FJ3RDUKk
	D5IM0L/SZSWhoDla9y+yO
X-Received: by 2002:a05:6808:238a:b0:4c3:9892:96c3 with SMTP id 5614622812f47-53ccb300dfamr2614650b6e.22.1792266394712;
        Sat, 17 Oct 2026 12:46:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388dd8b5a2sm4025321b6e.12.2026.10.17.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:46:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 17 Oct 2026 13:46:05 -0600
Subject: [PATCH v9 10/18] mtd: rawnand: sunxi: avoid a second program
 confirm for OOB writes
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-10-b624c09e3ee5@gmail.com>
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
index b79a20158cd4..f00f9a8ff66b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1848,15 +1848,10 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
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

