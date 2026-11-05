Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904934;
	b=XYHWGWaiCeMR6CAC1BlLn2B0TALcOKQSqEykATta7ASfPltoiFurBZDzH1dldqcMv+4o
	 M0S84ThZ+YPAu+GFER+U+wKkPZCLHGzz+fZ11ZRGLwFz0BwdSdUY/k7oV2ngmLni4eaTz
	 HY7svyr09BRLfNu68O7MtApnJSv1bjvvCDBJHpa1/e5aJ29iBMgZpnRCbxXZJ+y0nVDvV
	 nmOMrmoWQIA6zc/Rxj+pjifP3feboVlsY0D8kPdLEoMnqESsmoYECNljP1UFe0fma3qwF
	 R0Fx6XLdWqU8ntTjJq7jn45NqLaYXIo7lnbn7SUGFFN+31RMBFonKFdWvp0diKJs/iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=UPvgTlYh271ksxX8dw0Tb6RYwBWSB/xct0guWKo1nsA=;
	b=vfhcJTHpwO+LG4yAm2NDdpTSIpK6ndpDRsUJfZ9t5ytfkx2G7mvb/WZRsunXBBuiq5Ig
	 t120/fPVnTo69bv1uM2eKm9Pxtm3ctR2KTgz+HgZYTjqZMDCl1He0w2Iz0ZPZPYOu+Ocw
	 pj9qeX7ETw+3FrV5uPCsSESPf/iLwMVVCP7jCNghaahvSfDc0G/bIvDHsnjJxOD+/H1PY
	 +z8seJfS2fDhQUM7hsELIY6HjlQoJU/XjYNpYh6oejLipGBTv/JWiY+JtnDz1pqt737CG
	 EOSMPxcwNKOOlUUjBt9UAwDwIaSLpAu1Uy+Krjmhss92IvMloy5Eu4dbU2flLNj9LNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjkFtusj;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FD606D80F
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C1FD606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjkFtusj
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-716da696c1aso588858eaf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904933; x=1794509733; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPvgTlYh271ksxX8dw0Tb6RYwBWSB/xct0guWKo1nsA=;
        b=rjkFtusjOAHNq/ned4J5LW6Ltz7bAVhWQ2g6+jkXBmNOCqEv7W6P4YKN9CD4jaZ6O+
         5JSqOySdMCoT0IkiINMaNcc/vzgtd8lIdvVzpYOGiV0E+PO3tiYBu2m5fuSRNJ7gKSjD
         30dn1MlB97IX5mMPgUc4dYxeDHze9AkGorNyHC9mqlQMYUdeodFpNbx3OTGZf+IIH5H2
         cu/uJuctPoLvij1Sfn3TDkIorcQpF5Xp7SjsbeZ3vOUndtYcJXN5FE/kdGydpW+sS/VI
         D3wmibbHOP77LUnEkHsmrBk841ylCbM4SVGwD46SQtVPwSO42rQwmNTfAZg5Q8ytQ6lM
         RrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904933; x=1794509733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPvgTlYh271ksxX8dw0Tb6RYwBWSB/xct0guWKo1nsA=;
        b=S+A+c5lECvNQ7ZjvpxtZzosYCsNolA1e4hUajq2VunNV6PcjdoQOOJqAWUP84d1qqj
         0eL7RrfHeTqW5FXqh/I+gA+lSiRpnb2U/wlR3mkh6f8Hk7A1BWQ/zHSBmEyqL3GWY+Fy
         C1GybSWIosoZEBQZFb3AgE/BFo9GSyviCDfGYHlyx+zxCS1QUicPAf+lzbTUtywXyvEz
         fIktkfQiqQ1MmLLTkZG9wxg6vb8J6oZwK+K1i2U9vjHmT9re+SIE/3XzF9CgqCsifAyF
         EktfbOzXIgJFJNrSTvvALQ7V4JZb0uvrY/DA1lgWWAR5ZsgxXZNnU1MUM/qN/i0qAMFX
         MU5A==
X-Forwarded-Encrypted: i=1; AKwUvBz83QS67r/+r5Af4LdsqGrecftNfYS3WmwE7KvCA70UhCcIE4DCB1Sp22795PZHEggWN86bQqIGjfDks2lMUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z++TjntRBc1s0hMKLB7vEJPgBfobT8GztsdZw+gHKTEvoxzgJ+J
	wbUiHKH+udQtInfx/nfI2HGGdhdx/mA+IxAATi5mgR+n7avC3wSycutg
X-Gm-Gg: AYBFou0YhOEsK6iW1RgdP0+D5QjT2JUYEBitkocK852oJ9CtLLBoiPFnbFenEMONl0g
	vbeFR4GN3WM4VXfQ8VlvXEpHsxi/X+qX6bo+rrfj5ttzX0sMduOtbmwYCGC1a3jKPy4qeU3JjxU
	hFUiHgqkfuLsfKGkDmBPuapfrJxiwOXVKGnLM3SdeZG/lFKNwm3VHXoNZvXwvyowcn11P0ev3B0
	jNyYnm1VZ/mCJf/0YY7NlKHby79GgasnLPQeP6DSyUXMcspAfpzJaLesuhq6OHfjS6S2nfa+LLQ
	nX4ztNwUavPWp6ah9Wv+L0xRUuSA88gRj2Sxb1krzBAg7yI2xPajMkGR6PHWxT8Y+dlKzimPlGi
	L+3gwLc6lsmmohMfE2ZALuIK5fZ3uhNTrIXfzeK4t8Ga9iqU4AY0xm1Ai0JQHJkRxUsh9kirNsZ
	40E3YMBphUzQdvlTJCZWQsmDRAy89lM3TyfpRrvfg7joH5b9g/JdXZw/0wsMEQy2K5bocdUwIOz
	/MsfNiWOACmsFJvr6NFs4Jr35ZhW/gJ/OyP1ZjrFm+RbfzgjWKaH5hXpHPxW1tVmUwWcm+XLiJS
	kzz3SMunS3a0NOM5owLYLuRuNvWwnA2mTnp12rkCSrrUkqeqb8RaP/9S1szBVhvkVPjQF/OKE7B
	XzSPpo9C5gaVB8dIja2wN3JIyEAOuePP0xg2BSy6N/FHHBNQ6rSkOmjVKlpPaHQ/r+n6U++e4dE
	L7NyjavxQzBmfZfKkqe4RoHmnkjQ4VMZaIiTjOtEBQYAtrY2snDqwXjG0+wyzwaY/yeRKmNn7/K
	g==
X-Received: by 2002:a05:6820:7048:b0:6f8:2346:cd89 with SMTP id 006d021491bc7-716e73a98famr324182eaf.13.1793904933325;
        Thu, 05 Nov 2026 10:55:33 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:32 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:19 -0700
Subject: [PATCH v10 03/26] mtd: rawnand: sunxi: avoid duplicate chip setup
 before page commands
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-3-dca1f6ed29a8@gmail.com>
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
index b75984961699..662d96fc2535 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1513,8 +1513,6 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 	};
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	nand_read_page_op(nand, page, 0, NULL, 0);
 
 	sunxi_nfc_hw_ecc_enable(nand);
@@ -1537,8 +1535,6 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *nand, u8 *buf,
 {
 	int ret;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	nand_read_page_op(nand, page, 0, NULL, 0);
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, oob_required, page,
@@ -1562,8 +1558,6 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	};
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	nand_read_page_op(nand, page, 0, NULL, 0);
 
 	sunxi_nfc_hw_ecc_enable(nand);
@@ -1589,8 +1583,6 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *nand,
 	int nchunks = DIV_ROUND_UP(data_offs + readlen, nand->ecc.size);
 	int ret;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	nand_read_page_op(nand, page, 0, NULL, 0);
 
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(nand, buf, false, page, nchunks);
@@ -1612,8 +1604,6 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
 
 	sunxi_nfc_hw_ecc_enable(nand);
@@ -1652,8 +1642,6 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret, i, cur_off = 0;
 
-	sunxi_nfc_select_chip(nand, nand->cur_cs);
-
 	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
 
 	sunxi_nfc_hw_ecc_enable(nand);

-- 
2.53.0

