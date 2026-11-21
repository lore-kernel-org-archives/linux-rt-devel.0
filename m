Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223478;
	b=gwiHG+g0uNOYKnMHVfu16ngyrTkVxXB1A8Qm9YrNjOZgt/VM8/teStKJ076zfm9n6ddY
	 K8RyOVOQD29tgYJ9oC6pTNEvj2MGvXFFpaFHFMoIfjMRZ3lfs4vWogR1+b+P5rPU7LI4O
	 kHkS8wrQJZdrl5l2Wpgxy9+9iSXQSPRfMp4GLVE+ThUWa+U99WS5XzPYFGzSOi7u1Dm9c
	 rhtD1VmZYpGrUJ5HxRWwRLStpISnNrJz8bFNvnE8WRfz8cjaZL73nZd76Sb3tPYHo4rtX
	 nC0TO1M6fLIF3fgWTi5ufXmmdWDcyHJ3PQWcwdD4ZrCQ85b77MZ9gRp6TMZEv/W2rFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=CgxsAtXFuwPIOpoqITa/yCw7bucmWGSvP7CHXYFl5l4=;
	b=yfLZ/BRXNnAQUqkjW42rJfvPVid6PKpT44bGDiXMtzqEna4m1U6Wb00RrPB3ejRyYxyA
	 magCYZwzEWKlhOXeYrMN4U6lWbas7giK16U7mWrZ9EmFVCaTmpW3sZPmtZAv5oVH3Uwad
	 OFbEy2QvqIYJQJAV2FnajiINKj7H4oCPQoW1OVKYBZQgTH8ZhzYRUDy8tpHBtL+p6lPXR
	 hkmGl/fTaXVJw20lxZnSixSwm8oFg8Ef05HIRVqO77YqeHkR9hPCWf3qaUENLkMaKB3XV
	 5fN0IYf0WMlg31wg0TpKA5wkM4WrS3rfiAeemjnhvOcPmsOYuNZWpWj6Tyz5WQIoaCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TH3CWbiC;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904B60A261E
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7904B60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TH3CWbiC
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-833e671ee9fso1455053a34.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223475; x=1795828275; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgxsAtXFuwPIOpoqITa/yCw7bucmWGSvP7CHXYFl5l4=;
        b=TH3CWbiCrMbCZNyUW0OMS3B+p1NMxJvpNBa2USUEN7+V6soCc4bDk1CnydoeGUgVn4
         +6GgS0z9AZAtgLN+Og4qcFyvlZrfnj6EQEt18V14L3x7eDjxu8QGP2g7PZQ5KVJTv/6D
         Q/wYwf1O3x4WyzjUfUr7R6BFjWOXfMM8XKs/RMYA41XzXCOoIegkWJRhm68edXs8sT/3
         KZb6cKLol4bcaYU1Eyrb+BsR8halSUHLhgXnV3be8Rs79tchpRRA/Kfs0hWFHYa87C4M
         m9MEN+FVd+sQlTx49E33sYfHYreSsgdWz6Os7b35FOX4vfnkH5RQlIVhWk2qQn83+C3y
         BB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223475; x=1795828275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgxsAtXFuwPIOpoqITa/yCw7bucmWGSvP7CHXYFl5l4=;
        b=05IP8a/KZnhdMKCZAE35vcXblNCbY7sYHLc/Q8DrbJ3UALdm1pYh5S7J25ViYOnm6q
         Yzh4YMoGwZYt/5140Mbww2W7FYX3yPCvh3mVEceXCq7rKpmNOh6mpPnieI79ftXtXWqO
         WCzJPNlM2cLiDaLN9ObFJua0D8hHY8uv/oFDhiThiPiLJsHTgfq+0PFHfGEYm9nHzUcL
         DHM4lbBUFj7Tv/tN7XdQyX2D+j7LANKEW87SRhUVi3CYJE+KDhSgEpW5ESbP1K5vbDRZ
         WrbSMAXH4zjI+ODN0RgFGxRs2xgrobig9xQYdSsVjju2SU/PWBbXQ7RmiSn+ZgkuY+ig
         SMnQ==
X-Forwarded-Encrypted: i=1; AL+hErGbe4fXgE9JWnjXHp+lQgIahOXXiffJ8dQcemovIngROnQrtJ7EtXE10j3Q90Im2Oz998aVdhF8nGFdCAw4ZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/pQkvMLZ0icv+ly5gUvNB22uSTsaruf7EJaYzY5BcD0NVPC8Gm
	Jg6QYrcMHQO0Vmv+/qGZODhRFBSQx/dVp5SfhxHFrRXY/IP0C+HHAjGD
X-Gm-Gg: AYBFou2QLOp021QkkLAIn54EVwib59XRyIIe9m2Q7JKIfgnf/4WsjptF5q+Pnl1/2yS
	j0vgWXcQaOkghmP1U8HMcVhzSMrwmX90Usmbu+29mf1mtdbxGRE8TGo8U2NRZNTS8ualgLSC/zj
	kUEd6pq8c8a44QuIZGi+KZ4cHzF7YCNnkiGoqEsVi7p7G85Tc9dECCI6WEzVgEEKYJi01CGbahY
	gO+thX4uCCoLh5XNs0IzILfp9Re9pF0y6N7Iro/8bNDb4QC0DrDMnLaqyvMcMo71NGKpTL6/Ln6
	lvO/KZXL5XH4R94xiO8umZFogAV0eWm1HhbPvT64sqlW8g9HMqBubT5fdjdxFmiJvHFMyquBl2E
	QV/58+B/e0Tz+WPf0S0lDNAxC4vhUWKevurwlev1Cr8XG8Tu9fimgMfLJ6HHlB3CnkNhi7ivnKD
	ZYaM2Kapyt3T/9MRhhVyiarQHFwcBb5l59/7irLAsrWKYepdrIM/wFXAfB0DDsBkMnWq9Vuaj+3
	fUqqeo5JENiQ94PcWEdF4kufxgz80t9ksBieoUXWBhLX64jvBr5t2XGSIzpDsyJSy/Rh8in29lq
	+5lwHGiekaLgv+JrvnWn7juq/ALk3Kv946MMlertDEcft59Nio1eYo8GV+jrTRaN4Y4tL99efy2
	nO8T+wu1P7Op4cPi8PKWSCaMrgewVIjtnwkJXKtbPUGdTW9zo95qJoAI3/e9Acmo+wc8i08ecmu
	O+siF1WFVc5iAq/pUnei8nHyPUMDT+t/BWOOLiUsflH4nkg0Ytj6cL
X-Received: by 2002:a05:6808:23c3:b0:567:f5d0:741c with SMTP id 5614622812f47-57a0b959e91mr6046198b6e.34.1795223475472;
        Fri, 20 Nov 2026 17:11:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:37 -0700
Subject: [PATCH v11 14/26] mtd: rawnand: sunxi: avoid a second program
 confirm for OOB writes
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-14-9721b1905ef4@gmail.com>
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

An OOB-only write can report failure after the NAND has already
programmed the page. Both the PIO and DMA page writers issue PAGEPROG,
wait for completion and check the status. The OOB wrapper then issues
the same command without another program setup or data transfer. If
that second confirm fails, its error masks the successful write.

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
index 712648864407..7f9bc0237cea 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1779,15 +1779,10 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
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

