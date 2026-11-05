Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904960;
	b=VLBQFN2ravThiUmE2lwDObBY7hpO8a2Cs98pxtSQh9RILsjLd+rcOfiL0w7if7tgEHBf
	 E7St2QV4LIMJwEIdFMakLzfAfCNhkqz5hqcE2tUqeOpEsHq/UYulySyOu/9p/O+AYFsvA
	 WJ7iQBoLpTVV6rmNnGQbGgy06xSJeG/h0Yjo6ykYk738JwKuRRTsgLyyerd09rJ/rN6Ts
	 2lm8cPnVPTwIUKTArLPl40XQuZXY6Jp9sH8+b+9kpX9IpTHBgv0fhGdv3tH4v9QSmwo+5
	 X1Dydbr5kuWoBLXOTpbs4jgrAbrd8UwuQEjXGvuyfbbjngVsApGL/HhrEdyVsZvoqOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=r8+AfGGSzvw+hGNMBk3uLeKXHLvj2EOr91SQHPXuh2g=;
	b=tgLTvJvtSrQq78ZVU2Y4a1jhzMYn6ntAP8RZTezldp6uRaw1bW5/otzt2eJy1kK6Uwib
	 h87l2MymYb9HAAudN4xfkpMqUGhgLm0EnwDjemqp91CEEQKMoDdwkD+vxhRdKchzNUzpg
	 UjclVU7doClTvMLTuUEr3I08Q+5kT8JuxJdQnnzCQTSyceFms7GPxENlkAZFeEWm+8YRC
	 fV/caPzHYGGUCmpXyBbpUHzviT3p0760vl6uqJxd3Oh4Nwe+ncO/6JZ0EXipIqV+Hxxql
	 t6vy+0Pc0WORbzePWaaWuZwC4GSvwhIngLcK0lMrfopjf/tdZGsJ+dWXMrispXJj/iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TP4VM6/4";
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925E6082BF5
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E925E6082BF5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TP4VM6/4
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-705cb6cedd5so593377eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904959; x=1794509759; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8+AfGGSzvw+hGNMBk3uLeKXHLvj2EOr91SQHPXuh2g=;
        b=TP4VM6/4Nc/Icr5K78I9ChfFj67CyvBJ3NqkudUwFzgqxE1HZ+xEzPe/5nWf12BLVU
         QxiPVj/L8SEpUiU07wfQnJ/8+k0+7p1uqYs+cqJCzy7MpJIs7lXCKfgVRn+Vh9XAFeKF
         qsf/rs1Kn+9aWt5WkYIcyI+sflOAC/vDA2DEEwnX2UVs2yWIC7ClNsuCydBR/Ynie8VF
         1SF0kF5fLwZgntiRMkshx+32oC7bIvnz/sylaXKJ5vJ9GY5PDykfASQhubHYA0jVe98X
         290HAvGxGvOukYgCB2EB9JlmDPMO9KKvuG1JDV6wYGTRZ63XRopSK+NoUuzoq+TociVl
         21GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904959; x=1794509759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r8+AfGGSzvw+hGNMBk3uLeKXHLvj2EOr91SQHPXuh2g=;
        b=ixFV5zAL7riilB67zH7BjMadEQ2X6LGJzPrvz8FTKoF3HFT2JfHTTCpoV3SutGMdss
         8V1oOea5K5fiqWTffSM2fwVOsFrpjKUbfhRxrlSDzAore0b63fYt44c3FaeUXAsDrwp3
         y6Wujf9Sob9JoA1x0yqw8EJDfGIj+y/gJLNQ+GzJoIAZrt5pv/lrqpSHmQBc+Eq2juJ+
         FoUYGlRnwpnwPR22cSgu7V+Ry3C7GJjjT4es0NJ7evsxHTDXjsJ8IdVpfQzMKdXgAFyT
         oJYLNRykTDVaNzrLJAtHLPtY6iIcsSa1wQIgjazMrH1GxEmTHzO5H3qO1bRUB/lCMUMt
         Enog==
X-Forwarded-Encrypted: i=1; AKwUvBxQnS9lvzdwS1QrooOTHGx8oYmjRAUyNXG8Y+HLRiokSj5qcRXYSNYVWnLtqA8tBM8gubbafqTUTSLRsC1Nfw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9gjYhTslfw0nW73J2kwIDkE8R0PppTNkOLk0FLAg00ckdfBpJP
	X0WAPshuj0pSjx+Oe0WhhQfX5k25nVcUgx7/0VsYy1T4J3pXt+vGPLj5MCcUPFiX
X-Gm-Gg: AYBFou1b6qHdjgtB9gO3d1W2Lq0Loi2m4n6orRLot5UKW5SkqP/aDkKR6skE0/3D0f/
	aV25wJsysV0G1lmc0rqiMzLOvwdAQoectGckwT5NAYHeakJ5c8//HklJ17roI36buuE0u5ZnSZL
	zgWvrxZH0k5ibBcRWa/Ad1rvqYTqTPdgQXFBm0uXPmfH/n8XBWd5iq4GRoMveDw0uxFqvPGfyjN
	+6SbRitGXqsJeMZJLnKRVlXhHMNLeErIONFJ4aur5xbVc7kxMiWifKQeEyYu7EYcRga4HMg3w6A
	0pJs76JKRIWpY74UYWBiqGsqCdxetW3xmSMzdX+OfskjLkanuSBS9Y65wKGz4zOWVQejha/Bhgm
	ZjJEmlLmaMlfNx+xSn2uC6FqUpJbneCCAySes3lOjaRc4070QHgoRCWFU+aM9ncQHIZOCBsA8ut
	8tecufcOYtfPnNiZSVDZKriRq5Zw/8upMI736NU51+U8qwn+2sUfNJItoYXRe3Oj8uE1XKU2AX7
	NhOaNuLp8lH4HxQ3/wwPA2F2djerhwfaOuSo8cXw0H2QRF5SCmKT5UmhTpyQizoTFzf3C5qQCPG
	vhKmwNRPdSS+uPDBzw2Tei/mRfvQrbYefbUG7byan8LpgsfxBwT0+54E6qVg/qGDJHHRpPa15gJ
	1kZGAa5vp71jwoKA7Vs/GpuUdAGXS/g7mRWSp3FLJvGWxhivudHI3noa+/UVqP+TtD6tp3ot4Yd
	iS0I/u1q3tH9Bg+jEEjP7LF8Yz5YDMey6ZO1Q9TllBeYyRyuf/QEiH
X-Received: by 2002:a05:6820:609:b0:70d:53f5:e5fb with SMTP id 006d021491bc7-716e7374b3cmr330726eaf.2.1793904958904;
        Thu, 05 Nov 2026 10:55:58 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:58 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:33 -0700
Subject: [PATCH v10 17/26] mtd: rawnand: sunxi: limit buffer transfers to
 the command byte count
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-17-dca1f6ed29a8@gmail.com>
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

The H616 capabilities advertise an 8 KiB SRAM size, but the normal-command
byte counter still holds only ten bits, with zero encoding 1024 bytes.
sunxi_nfc_read_buf() and sunxi_nfc_write_buf() use the SRAM size as their
chunk limit and advance the buffer offset by the requested count. A count
above 1024 therefore transfers fewer bytes than the helpers account for.

The operation parser already splits data transfers at 1024 bytes, but the
extra-OOB helpers call the buffer helpers directly. A sufficiently large
unprotected OOB tail can thus be read or written incompletely while the
page operation returns success.

Limit each buffer transfer to both the SRAM size and the command byte
count. Share that limit with the operation parser. Existing 1 KiB SRAM
controllers retain their chunking, and larger buffers are transferred
using successive commands.

Fixes: 88fd4e4deae8 ("mtd: rawnand: sunxi: Add support for H616 nand controller")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 7c80f52c517d..636a04f49418 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -89,6 +89,9 @@
 #define NFC_RAM0_BASE		0x0400
 #define NFC_RAM1_BASE		0x0800
 
+/* Maximum byte count for a normal data-transfer command. */
+#define NFC_MAX_BYTE_COUNT	1024
+
 /* define bit use in NFC_CTL */
 #define NFC_EN			BIT(0)
 #define NFC_RESET		BIT(1)
@@ -690,7 +693,7 @@ static int sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 
 static int sunxi_nfc_buf_chunk_size(struct sunxi_nfc *nfc, int len)
 {
-	return min(len, nfc->caps->sram_size);
+	return min3(len, nfc->caps->sram_size, NFC_MAX_BYTE_COUNT);
 }
 
 static int sunxi_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
@@ -2606,11 +2609,11 @@ static const struct nand_op_parser sunxi_nfc_op_parser = NAND_OP_PARSER(
 			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
 			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
 			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
-			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 1024)),
+			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, NFC_MAX_BYTE_COUNT)),
 	NAND_OP_PARSER_PATTERN(sunxi_nfc_exec_subop,
 			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
 			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
-			       NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, 1024),
+			       NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, NFC_MAX_BYTE_COUNT),
 			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
 			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
 );
@@ -2620,11 +2623,11 @@ static const struct nand_op_parser sunxi_nfc_norb_op_parser = NAND_OP_PARSER(
 			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
 			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
 			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
-			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 1024)),
+			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, NFC_MAX_BYTE_COUNT)),
 	NAND_OP_PARSER_PATTERN(sunxi_nfc_exec_subop,
 			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
 			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
-			       NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, 1024),
+			       NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, NFC_MAX_BYTE_COUNT),
 			       NAND_OP_PARSER_PAT_CMD_ELEM(true)),
 	NAND_OP_PARSER_PATTERN(sunxi_nfc_soft_waitrdy,
 			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),

-- 
2.53.0

