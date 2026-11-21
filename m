Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223486;
	b=vggjWDP3ktwlGSY8abBPb6NbZVONHXNQ1Z79/umvjLZHHgvoc1ZW7eh1H/Zbsgtr4lO7
	 o/fznbL5VU2H+h/GST8xTCyMYKwO8uzZMStlITVFACvIoJJiac/EQaKbRuEjVsNoS96It
	 op1nDkH+7kXZQUfa4JYi1XJ5WPSyt8xUH05FAM0XtNdCGaXmoueWvUdEatzPMaDH45riq
	 st3TvnAe7yxZLzrCoIuMmPGuWhJYvWM5czzc7IGuaDKXqkpfN+73JVK17KpNH8CEhtQgF
	 Mpjj5d4348BMxggqNIbnzm3Y+TxkebcURAdcJrfzGWCpRQM0Ow/a3ssB4GHMFrtlBdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=dWkb9R9dFJf53WgY0/fb7qetN7PVplL4lJbH2mVBctQ=;
	b=gOdONaNTR6D731OLab/IhS7J7NNjW4AEST2xixiRASzLtldIoB2dlNFEkFsNWGei3K7X
	 4BTdC3f+EVixhsSKHN4Z2pY+k6+/Q7hIn5zhVmwFASH1m4ukV2F7EfebAfWIFeLv48OQe
	 BXT5GAF+oJkpxuHP9sSQiRyVSQ0ULLulEpK/EYgQHJKcLHix4imJHm4o7SxL+ZS0vWu1G
	 CemD1x6n+ipiNTOpfNRPI9ALsgL8wAFXOMgoqM5OOnZS05suxpJhJgta1Wk2nZhT1Un6H
	 gcUy2OopTQBvfskUeFfeWEtvaKVBPlPfD8YerUXGiTGF8nfdrN2kmBGnj5zlciPObAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4dNc7KP;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F93606ACC0
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F93606ACC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4dNc7KP
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1029049b6e.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223484; x=1795828284; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWkb9R9dFJf53WgY0/fb7qetN7PVplL4lJbH2mVBctQ=;
        b=o4dNc7KP7hrqB5AW0L07UCEdUqWPT9AJ+74zVETvVBAsPGdILQ/TODJ2NShKJK0UYw
         gQ2m2uJnt07V+F1Z4og3gDtNIz64CDJ9UJJbWx0Q5Vlwvr5WL28RrVY5wY3gJL5jIxkD
         1CMxEEpHg/tzQRXlwEJgPm8QicowwhufmDdxXYtr0uB1s42d5zx1IM8EatPu9bBK8Rtn
         uvzpe0X0uQC8DzcHnSu6dGfWs0WM+Gm2jYuWbesOXyRObQ8mvT5ma+i3FktILj3LKQdU
         DrXwhcXhIJva4MX/DMCk8KSmmmlyklD9yPUdEpk32uAf7fuKEwIhTzUtyuGGVgjsBI7e
         7AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223484; x=1795828284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWkb9R9dFJf53WgY0/fb7qetN7PVplL4lJbH2mVBctQ=;
        b=0Pbw5YfX+dLfYj7Rb15va5oULNiauLGiZQDQeoI7viHftMHlErDPa3Gt60N2QpZ0sp
         NhZuYFEKeSUWmUjkcVjE12Ujk7gtF89xUEqI7Yk16gPF8Xs6wMZ2EojlLK2y/nibgNji
         FlQiR3YkcCL3zrRxpXdwjwdNqXNFYM0jmwjMK23/AmR30qANOIt4FvLZef00JuufE1Ud
         ampAWOMsXbyAGuUCwt530XxJK45U826+NldXrh5FLZ4xGDDN7eyrzgPq6nhghsgOrDn7
         vWhHzzLdd1YrjpUmgNpqRD7O3oBPE+hi+6I9t6afIb4zjFVaZO85299yzN+XcOYQBIVK
         yHyg==
X-Forwarded-Encrypted: i=1; AL+hErGXvow/+CwonCHXXHuTlRAXWdEcdnE8IQIk/syXckkFZVznNqJk1Qb8P2IjBvF/NNZg5wy4y2jYhV8x4WZVlw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+lTn3Qhqf3k/e930j/dhsa0+kg579gA0RqCHTOqrJnAzunSirC
	I1Po+8ZlvabSf0bjTHA9kW5Jki/sslRUXCaogbc6TGzz69l+cWJ1z3wC
X-Gm-Gg: AYBFou2mq9m3K1eO+Ho8rZoi3qd0gxDj8RT48z4QKv0LgljeMa2xisulzWplOwJ6Pln
	96579bUprElAR7GJqJQCm4SD33vo3CyGHPpJJkS+EnDeLfxVXzDbbl7d1N2lvgJzcv3y6T0c0FJ
	GRyLbGax9bCPPMabc1aWkUia2bYGPw1iRaLNppabZtxV8yYfpPX/sUE0A8825a8ph+EwEfV+b2S
	HH5hEgGVy2sGCStRY3lHSBdEYu8mBaHk7v+VVFoL4HVH1Nfm4hNfv5GPTO+nQF2R2SkeFIbJ6dV
	aWFxZ2vQy3t8lU4OiuoqWOR4Zoc6b8jFowOPdsiFATSfs7DTZ+359u1RpVkvSYY0X5ovR+G9F1l
	SXlTNy6v94X/hIway5NodSf4mwOhFcT9/O+1Vd7r4JRn2XxvJZT780cqiK+wHqBoYle2Q+gBrIp
	6XWqcgSJCD9znEYwbA/GWFv2dUHgcyTvSIhUxyDJ7pboxsKWtu4zJg2orwJHm9xXZPo1iHv2Ee/
	FrnKG7y0KYKj9thgdookkfp9qfZRLpAhdVZB3NAa9mspgICg4rOtzhuBXQrDGNnD7QINS/ZE+9V
	8FxSVLKRwDP+XjzYfU4LECYkoezilfVC2BQfN5xlEgzhrA3pQCLKpEE9kQFdOjFXAPoa9iaXjw+
	56aLJ2+7uiwAgLBaHLChgyQK2vNLWUiob1Tz1NOWs4+PROV1vcRIUEzFbhoC1lBSItT/xnYzhtB
	/+OPzBqSNBQpQxb68V7eKvQam7Ojso0yiuAIS/MHmsNiRFLbQ0f+wM
X-Received: by 2002:a05:6808:4fdf:b0:571:b166:3d77 with SMTP id 5614622812f47-57a0af33b0amr6477590b6e.27.1795223483689;
        Fri, 20 Nov 2026 17:11:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:43 -0700
Subject: [PATCH v11 20/26] mtd: rawnand: sunxi: limit buffer transfers to
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-20-9721b1905ef4@gmail.com>
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

On H616 a page operation can report success after reading or writing
only part of a large unprotected OOB tail. The controller has 8 KiB of
SRAM, but its normal-command byte count has only ten bits, with zero
encoding 1024 bytes. The buffer helpers use the SRAM size as their
limit and advance by the requested length, even when the controller
transfers fewer bytes.

The operation parser already splits data transfers at 1024 bytes, but
the extra-OOB helpers call the buffer helpers directly. Share the
parser's byte-count limit with the buffer helpers and keep each chunk
within the controller's SRAM. Larger buffers are transferred in
successive commands; controllers with 1 KiB of SRAM keep their
existing chunk size.

Fixes: 88fd4e4deae8 ("mtd: rawnand: sunxi: Add support for H616 nand controller")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 37cc023db74e..4478189bf920 100644
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
@@ -667,7 +670,7 @@ static int sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 
 static int sunxi_nfc_buf_chunk_size(struct sunxi_nfc *nfc, int len)
 {
-	return min(len, nfc->caps->sram_size);
+	return min3(len, nfc->caps->sram_size, NFC_MAX_BYTE_COUNT);
 }
 
 static int sunxi_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
@@ -2498,11 +2501,11 @@ static const struct nand_op_parser sunxi_nfc_op_parser = NAND_OP_PARSER(
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
@@ -2512,11 +2515,11 @@ static const struct nand_op_parser sunxi_nfc_norb_op_parser = NAND_OP_PARSER(
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

