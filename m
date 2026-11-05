Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904933;
	b=nWYakW7qZuIBY7+oxvQIRXsLOPOK9IjrZBz/ZnkZ7eElEmWrqcNpfZmEWo3amtSV3HFn
	 v7IyTiXtdFLB1/g17pt5OQz4CCN0bgM5flyetIwnA3L23BYtCHtOCZ5LrblIsgThE0Hz9
	 LalsipBBL9wpYI0LuJaNsUUYAGFq6yTOO1gI5rQtuSDBZr8Rb4QVtoJAhutxPllg9h597
	 7pB5N0dtw9JIUvHQVr6lelXK0ATmQy4pD03wt7ZZN92FImzjKT2fF6cVKdKhzRiAAsrlF
	 fwyFOvOOZrfugYWVNqqglv8I+b9izkPkV5w27YDIQYngBjfKGJrv7vCcZjTL2FNKTfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ex3VtA9PGW+lx4Jwo9zXOKsJ7tUqHQi29kWPU0YYtkI=;
	b=dswcOvKUnCHApkpP1TVN+dSzYmR0LRqgCc+NBbN0HcgVaxjCJ1s6xfosKHQTQ4kfZ6JE
	 fN1GGhHGGAHbE/4eRJ7+UbgCXPraVIhz6SXD3j5XNem8iEL2YeyezBKgb+RaeEWGy+Jr0
	 ws+kstp/Ys8vwujluJ+kCRxagyLlZog1daegNLQjlKIzbS5dzxDIhkqv5sj08vOG634Rs
	 /X2/ZxHyTaoWRuWJ+7DeUkA5ZXvKf6ld+AHbBbEVMIzNmbXRvK5kZ5AiELMICSkEk/xWf
	 FAmgyhk/aDRUQ6Xlz5ESwsF95iypvKW0Hwks3BCSsE31Vs/2wFoonwEooxdQLFcCqOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSH96Eqn;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB4606A326
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7DB4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSH96Eqn
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-704597ef1d8so982286eaf.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904932; x=1794509732; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ex3VtA9PGW+lx4Jwo9zXOKsJ7tUqHQi29kWPU0YYtkI=;
        b=xSH96EqnUtZq4/OLZtxBnMFDEanWN7BqopfSDQxulxuYUsyx2yGItshFpi6H5MqdHs
         XVJgwiTU0p6vPwa3gn/RsxEVXV4YqXiFjOY/PNTRMsWUWk5zzcxRCubYeKeVZieStWJ2
         TSAzrrf4GoC91CfgC08BxpjakNddXUZ7wJ21Aza1EFvaZ83uCYr/zhPev2jED6HlOVYv
         g++CER6Rl3t2BX3lFodKrCdXc6cShsIFbe4rOjK/3LCIRHJ8dSJZ/lxrG4gtvzqHBApj
         1nKdrt6dIlPJNV1SUvTsENj3d2KhKPvuJ/Jy6cFagycL+gyhE8lJ03bVssvGpboXxcEe
         tVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904932; x=1794509732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ex3VtA9PGW+lx4Jwo9zXOKsJ7tUqHQi29kWPU0YYtkI=;
        b=BRFYZar+ts3sTIG09DPJR39iXKYVTY7SlDRJBH6wtm2OnA7MoXVj0eMtfbgEdc6bvw
         8lrvDbFdzOmOxnnCK3KKQnHdqHECyQ8osj5BORXZe9TEtOSZGiksEGjLSSZdeJxFQq5W
         ZjaLSbQkPPmQlZ9tZ0fndt5gLHNQOqoA0/tsbtb6vcf6RUvmj+KXguw2PFmQCo54oGk4
         /j9qc6cFUIIZR6VFWA5AvcP5R/+PNB30VjFAZRjFI5Qcb0/CWM2T3yKQBL0gKCHIFkuN
         THdnPkWkBcYERM8/gd5dPo9stlI/ksDZARC3tcwRsQKqCCHVtBtJ4oQKI88Oa8u3VPWh
         gdaw==
X-Forwarded-Encrypted: i=1; AKwUvBwshI9TsrWhGiCVQVC1x4Uwqjsr0Dj7MEp7uWzRNR7mXek6Gjv/hJiI/kI8kpnV885RHxlnPO45GdZjVO6kbw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/OdZLSqFuGy8WsjlF7dhYPRlUBCh7x/xd/lUaDJTpzmVCB2146
	t6JE9lesvoj3DVsf0yaN/Av9RqgHgW+7Bj3pKKF359QIMmuH5iEL8L91
X-Gm-Gg: AYBFou0Umca2oEjJR7WROaqn4euAjwUwS1POq8m26xeDXhCGoiwyC0eKl5oz/oljH/w
	GhJdR/cLCQ8sguJb4DXE5RoKmg1CubxjEh9eB6zIccKzCi20h78ihzdE+qBEW2eZ+czuJmFkD2Z
	ZiDSeSPyRE9wbf2KIBCI/mJspH1isawZqkuVI+6O7pKnxcyIuMPV1Mvw1CbVzJrrJEhCaAiG6Wb
	BkGDaV6QUD8+uuGfHq/wblXmNS7RtUxlbEQ+DzyV1bNVZfdXQ2s0UW25GEgyUg5sqQPga/PK5Rv
	KNPXxaiLfa4ApLRpCIJvYFhlSlQ1a1elqmqH2I9sz1Bz5egJVPe/c8YrWMK3FfbZ9hTQbVjUtNb
	3Dy3DUOoyPDA4KnrIr1WHo51xeJz6qpOu7oZNjzIQJgoY+6mXjIRMIH1Cio9+NjaKtDQJfyibNY
	s89m/yA778O/3ECknzJICHzvgPsB7iEV9rSypevEaOWpunW22TrORcw21hIwvDdQpauu5SWkCKh
	RXvd8JPWA80SoFTTvquFt3ZruRd1E88JNMxgFeVVdkcjj7eedq2/4Jgv4yEb+PNBmLhO0Y8hKKN
	D5zt15WYLqtD6Kfi0wc9T01tkCqUv4FjToijGbnFBo2z60IIRD1x3lz1qS0qqqO8bVU4sdG3iiY
	WFSo1ervikqS76/jEVhYTbaAV4eHegaEHkWhN98fRs/zycizYsDEW+L7JXPvGkWHGmW/Cx1mqWP
	Z8P0MhpmeiU0DsJVdO3rRUuBLtgpgpZkp4cZKTGpzcqDPkHkZTjxmZ3uClWJkvZ4b/zUbm5pmBk
	A==
X-Received: by 2002:a05:6820:2484:b0:6dd:bc51:888d with SMTP id 006d021491bc7-716e79f15c7mr263473eaf.87.1793904931737;
        Thu, 05 Nov 2026 10:55:31 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:31 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:18 -0700
Subject: [PATCH v10 02/26] mtd: rawnand: sunxi: share the buffer transfer
 chunk size
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-2-dca1f6ed29a8@gmail.com>
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

Use one helper to determine how many bytes a buffer read or write can
transfer in a single normal command. Keep the existing SRAM-size limit
and command sequencing unchanged.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 80006d1a33d6..b75984961699 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -659,6 +659,11 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 	writel(ctl, nfc->regs + NFC_REG_CTL);
 }
 
+static int sunxi_nfc_buf_chunk_size(struct sunxi_nfc *nfc, int len)
+{
+	return min(len, nfc->caps->sram_size);
+}
+
 static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
@@ -671,7 +676,7 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 	while (len > offs) {
 		bool poll = false;
 
-		cnt = min(len - offs, nfc->caps->sram_size);
+		cnt = sunxi_nfc_buf_chunk_size(nfc, len - offs);
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
@@ -709,7 +714,7 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 	while (len > offs) {
 		bool poll = false;
 
-		cnt = min(len - offs, nfc->caps->sram_size);
+		cnt = sunxi_nfc_buf_chunk_size(nfc, len - offs);
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)

-- 
2.53.0

