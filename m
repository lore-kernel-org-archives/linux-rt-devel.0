Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223476;
	b=mhqSFl10edM5ljchVgALrRa7BzEnlWeqJiKU14heUeH94hI9JywPjVVnWcV9w8BpFKXp
	 1YJ2LBvNoIQnnUYfY3hDEcaVJqq99tIPr9IFSagad027hTk/OeRwyHp4ALmzxLZyGlutq
	 md3qqGGzmQVbc/PVZIynF/nU3qlbKTvNIkOg4Dp5qpWRSs4X4rO7y7Sy/B+8oYmRuq46c
	 moYnnLDCcbwgSQZ3NEXIjJYGZIov1Yo6tstJ5BqKhtn1/vVKp5mg15ZvOCkwdOB1jLsFh
	 VDJUvouPBasPpxZKrfytkmOkzN8ohoL/jg6tydfLr7BAqMITnOk08lSgjIiAbYwrJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=T83jSZtlzKtrASqdJI86cD7q3EhrQGMc7SvJoDp9Zl0=;
	b=w+6dk/izfNdYUAQ6u5kcoGS1n7NeNTSsk4ugmY+nOjcuAoK74VFGr1YQL2TGyAJMKjAU
	 WGmnF4NMWcaQfoisifgwJHGvorng6xc7DseBvoN/GB6h2jtm2nOA2TfE3mivHMZSquFEj
	 b7gIoSNh6kr+qlelKWxnozEuDRnFYgvR5GbCDHc6VPIkCmXHCZUM3yZecP4ye/FCyls9A
	 2YdymKQ4vpC4EUOxXveQMXH4lN6j6wjiao5uEjS9zAlHfkEAz/Rwq7QBJCWQyj+5EboY4
	 1nh+OQAMeKDuMrQVwgJI+Jrj1IlHhRCTxr5mSbobaC9zDZuGfDdVEzhaB5Ae+cCuUBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wn2S4Zk6;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99E60A3819
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA99E60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wn2S4Zk6
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-862aca1ed4dso703066a34.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223470; x=1795828270; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T83jSZtlzKtrASqdJI86cD7q3EhrQGMc7SvJoDp9Zl0=;
        b=Wn2S4Zk6Qj3woLe1216iSseJ2TO4r1ssJY8XMuWB3jx7T+8UvWey5AI+1JvMJDTYxc
         S9zWXq1GCMIVbumFXyTVA3X+Xw2nZqAOfRzRAdFtDFv/D4fybsU7FBxp8vdAZ72gt+aF
         J0QRG+cgPNp/ODhpnbedw0xnNBT9MhaJRxXrjS+8YJLtj8Hvn9LXh2CLL7OaAMAqhKZV
         fSW2kyOq4VvPTuThuUtNeRbUa7hDNmaZ+6XKs0r+wVy+rrv23f8ronyz1DqdzswQBAPl
         X1wNiKJVJkAYg5LiRUOJzx8W94tKdMt1Z6s4a0QSNyvlbQXuWuYAzJDB0uWRpIMCUDQF
         J24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223470; x=1795828270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T83jSZtlzKtrASqdJI86cD7q3EhrQGMc7SvJoDp9Zl0=;
        b=aYbFfZIWxk49oCqDZWXLEuoDry9lKtrt7p97MHbgwWCZxMVsihTCr/kYaQCrUxgFQr
         ww3ibX70EU4OesB9XU9gkPoDv4gsVSWQhExzJwb3FRR6p2KOrPU9r/8OMfu8wGW+gXHU
         99d8496yXiS3USHNdukquY6SeWEOgHxJ7PGWW4A3+npmIslrIDP3XU0RXQ7jMijO96yE
         iNv9FTyZ/1cBRcvE6iPRKbH3lbowlJTxw0wpa5XESPU0JnAzAW/qBcbcXPpxDIEE+5Qs
         DxDzburk0OS6YqRCGuQK1XbrytLbZOsOcYHeTDoF08CR3ELsC4LuRLs2GFROVBKyijgI
         9K2Q==
X-Forwarded-Encrypted: i=1; AL+hErEsdOReDq2JpZHWxaYhccPo4ad9+PfaM6vIxHTXDQSYZZgy9A2aCY09xDCx82XWTHEjnyZE+gkqLAvZZ5wSiw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8vNR49Vp96rNdaftHuTKRfSq98kAb4A/04i9XhIBsqliFbV4dF
	FRyhF/yf2/fhqBxQLBKbD5DA3In7GSU9o+Ub6IHAw16kbCY3wG/ABuch
X-Gm-Gg: AYBFou2NlOoEl6mV4scF04bXIdpSUgv0xFYoYONYATD9E8cerVMGtJdlrKyXOPfncUl
	0CEbyGn4cnN3IkKso6qyrOaJS5jPZi/tN3j2kguU/fhBBi23iC6Sy162o4SHwIDHALW6kN8kuk1
	JHhpJCSF/VtYcoiugLzKHGgtdtYOdbyh3HFiDvF0dXgULda3qSCJOBFlVSuX2Fs/ZXUE3yI3pyx
	OgPPH5rSPFMycVoHagPKoMRp/vTp78GEUuQc3KXMbaTa4Y2E5cqsCIcVaOZ+akO9cJvs8k7u6Q2
	/hSSe5w3DnwAtER2SuUj2WoOeQ++U0CBBfn0w46RvSrZe3RYbGXYqmX2QkfL8pKHpjTiOizVpIg
	hTp11ruDV7YoVyR9YdbM8KoMChAs6yixA+DjI5UWo4cNdELHZJluio8ERgofyf9qn+DQD1C/aVB
	lZ9ahiYI1+Ze1EmO9jd9MorC5CXCzY3/FKIxYpN91VHV8PWhuE2qpcUiOBjvEqCx+Ke3/to7X/O
	Epb+r9638ZC7ezMX/jaWbRyy+x4AloQb+ETB7LA9NrXj1WU0yfVfBtirp/q92YU62txn2OI35lY
	AKrQquVgmGhyL6/qrRi34ZYmaPkeZykrZCLM3ThBR9K5tWhO317/9bZyolQ+dszyanT3oq5UyqR
	JLd8jvn6J07c9CNpTH0/Skv+mah/ZLI6lnUWxP6jGlUywLRq6YEGsEkrzIMH2W8gT5VWSiWMIYP
	2XW42HfoVI3+D7YWyvzt32AbuzRB1UHAoKfjHzlGBQzBcP49uJ6G4Q
X-Received: by 2002:a05:6808:19a7:b0:55c:844:98b3 with SMTP id 5614622812f47-57a0bb53de5mr6320056b6e.50.1795223469671;
        Fri, 20 Nov 2026 17:11:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:33 -0700
Subject: [PATCH v11 10/26] mtd: rawnand: sunxi: select the pattern ID for
 the current ECC step
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-10-9721b1905ef4@gmail.com>
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

A DMA read with scrambling enabled can report success but return zeros
for an all-ones ECC step, or all ones for an all-zero step. Requested
OOB can also be filled with the wrong pattern.

The controller reports a pattern-found bit and a pattern-ID bit for
each hardware slot. The driver tests the current slot's pattern-found
bit but uses slot zero's ID to choose between zero and 0xff. PIO only
uses slot zero. DMA can report several slots in one transfer, and
their patterns need not match.

Use the pattern-ID bit for the same slot as the pattern-found bit.

Fixes: 614049a8d904 ("mtd: nand: sunxi: add support for DMA assisted operations")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 76f60fde7a86..43c0796d953a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1086,7 +1086,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	if (pattern_found & BIT(step)) {
 		u8 pattern;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1))) {
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
 			pattern = 0x0;
 		} else {
 			pattern = 0xff;

-- 
2.53.0

