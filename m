Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03413D3326
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266800; cv=none; b=lEGp4DP+5y1JVNOPeSfNkIaj4mV0iywYXIaWwbGCm/5zWlOiKWMgOdwa1ciTaKxB9MmurDTdIV+9Fm8Kkk5YYwhrCXvzQnFA4Asd7ZYf936Kq50ahQRRr7zdgTh5UfdF4gae/Lv2GI5yEFYp9l+EZjh81in58iIwisk3IMHRUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266800; c=relaxed/simple;
	bh=53QYWE27UsXxj+fYmOb0Pfq2oxCp5h+os5EvQeG7UFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMoPwPwSTALjE4yyM1FCeBWtuJjSOBJIsftV2/xDgEYibXdmGO/tjwKPF598gp1AAUT3/XjnzstCer3cIbVIswm8f+PS448gkxhKWWc//He3H8Bv80YF4oIJ34Wuh6Zy1L99Fo974XYg0J/UuhV9Nv9IZy0/A/faXJxrfm01/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3O0w4EA; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3O0w4EA"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b19e291cc6so1044928eaf.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266798; x=1792871598; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SAeoEq6yHDKt64XU8PioOz0s2+K/90/TohU+qG8Q+p0=;
        b=m3O0w4EAHmUMTbd3M2gRfgiZ1bcMYEfgFqq0CKa7wNXm8sBSMaQlXu1TmlbdyaY0er
         j1DKo+G+S1dtaBUg93cBl43jRlfrJsFX3UWmUA6yr1xQHII20hUOvAZ/fbhpF/DUlBPw
         DKQ+jn9AHyCUJmmnMR/cQAb9zYJ6y6HTqw8QlIS3TaVY4DIs8Lf7DXvIAO9LxpEb+W5E
         /+KRBXglaXStbK2e3k9AEY1OUffvNZyzerOwYaTgghd+MLRZ4Q5nyz/rjWB/MjqeBEEz
         0Q0RSbPtAJi52JuL7x64yMJLx8b0pmSZdn2aF/3e+zoJP+4HU2RQ4r6OsiUhA2KlIaqL
         NT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266798; x=1792871598;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAeoEq6yHDKt64XU8PioOz0s2+K/90/TohU+qG8Q+p0=;
        b=wajNqX8BjACY7P7WLB51Ls9Tft3LceYH/mGpo+Z95ZK4VnPU13ysL1w7oXaGmhSISo
         OT914BpC8lNoS+YmROXiGcZxPLmKBA5YMSKw/yi0zqXnegsEtKLgLYcB4vFsIMZqiago
         W9nK/n9r0/6NWZkdLzj1PKJatWTMSZWGx8vV+zew/ixz6+3KrPBwGuLrcpd8Ik9hYlml
         9qep4ZCMQeG5cYmdL8+omXBXRI+U/L9vWFXLnHkenBQivp1lOvGo8A2vga7HWpx2ZKPZ
         gxIuj6EelGlSEzY+5jf6Ef88y/suzXmkCBL1YQSxwv2PBHbdwwB46sG7GbHosaie0ru4
         wZXw==
X-Forwarded-Encrypted: i=1; AKwUvByvJxM0Sm8PcYD5hDsdBrAPddGnjbHr7k0sQbMyPdPjHxWMC+VYC87A8Z+UTiRa3IKwzvCcLLP29sOmMUmSIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJYf7moFIstbvBk1QDqRQUrN4a9X5McwiNRiHzNEfO9RLFs05IN
	gqbG7qnfbepXsBILgX5b3q9ebFjWytMYTPIB5RJN888p90QPlU29lW7S
X-Gm-Gg: AYBFou38fNjoeEX5Q2I589N4e9wRfyjp7iU/bszXXNNUgBa4/F1mVT15/UMZmrXtTTB
	GGZ+uZ8Z3knDexCdpEskzkmbOGqrqqo5UhA4MJ7wQ8u33+6FzLE2ETMQeiOaWeQfOSZHMwV+Tkq
	6DQLrPpk00bKorV0KuwR/U1BxKhlwEibUToPRtehmPlewXmXIln6bFIhqhO8XTffVglCfc0TyTV
	GqBWohsL8SlRbbkfdUNMMXD9GW2PQGKNfPHO3zVrYh2PcEoCRYSIuWY/yHikqdm2gDxhgE+/s74
	RH9eXq79w+uEFY9VfXt7DtzzSUxU/L6q9yT30YbZzxzkGxdXfRwGxGFKbvY1+zCfcS/IZZppMlH
	dHiHXLf8QhKoQy9f4d4VG/UPOA1zkRjLaznE30LVxKHZkQMCBsF7iTYawfCd5SPH2xoFUdpptPi
	hJTHGziSyIakst0uu80DUVFWUBijm9I56SSZic1Ng5TEAZ7Ky0zw9yI9as50rvsAsSSdg6WBone
	jx4f/IMrZA6fFTmrbXbtC4zQ/dmUVoSw9ZqgWAnJWGobCFDn/AdQlgvBR9Df++bH2difFhSQ4Mi
	n1IhzpHf8Q9zwXmmNFVt6N2YMk9pIF3QJShGB6s+z8x9bBwlJqA1+kPT02ND+7CFs5ejBIzAEE4
	yCuzch4w+D5tR/2O4fDcZNxPO17/ghW/G7WL9KtXZrcUMBk65xGdhVg==
X-Received: by 2002:a05:6820:c2c7:20b0:700:da68:7396 with SMTP id 006d021491bc7-70357791d36mr1496668eaf.67.1792266797756;
        Sat, 17 Oct 2026 12:53:17 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6e12dfasm4829795a34.24.2026.10.17.12.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:53:15 -0700 (PDT)
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
Subject: [PATCH v9 14/18] mtd: rawnand: sunxi: avoid redundant column changes for extra OOB
Date: Sat, 17 Oct 2026 13:53:03 -0600
Message-ID: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-14-5af9a1be16ef@gmail.com>
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
index a12ec60c63b4..993e2efcee04 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1655,7 +1655,7 @@ static int sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
 	if (len <= 0)
 		return 0;
 
-	if (!cur_off || *cur_off != offset) {
+	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
 		ret = nand_change_write_column_op(nand, offset + mtd->writesize,
 						  NULL, 0, false);
 		if (ret)

-- 
2.53.0

