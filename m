Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223482;
	b=KhdHiEy/uT6slP+373RbPLdkVU1uEzmU5lYX2db1KP6YPbd3yyVYwR6lwbJLFrGFbj+q
	 05s1C7cgGc/1Aj4BVcIEXg8JrSvL6AJrrYB6JtYSW5SblLSFc0NYeiS+Gr51SNRlgSX13
	 fTyZfa+76mk3LsHJj69X8UutquMblERfGWcrfvFfYqXPzyQUpj+mbdTUvosn51kJIY4E0
	 YLWwGT+XYw4xrOIAFlGorobcdrvYIjsHgV//nXoMT8Bokk64vgmEQVxMCF3ONrfe/6K8v
	 uuWeYDFcK84O7xIvXl1lZuj6rfU1yW17WDH9T/T25nGrvrTQZedDJXtwvGMXkSBt+Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Rd+OJrfYC05spJgrrPaaw8Or0kLWD6WKtcmuDL8E++0=;
	b=080fuTxwqMHolhYRul0LoHq9c0XI7D0o1fCootsfxbgQF1T6piAnA8zEbVo1n0Qbqgel
	 uFKWsc/6Sl7k4SUF+OHfEyVE5/eZyw9AEPG/rWzXftFj9S7DC4Bw+8RoJPxxZfzksiXQm
	 Wu1conJHdnmCCFTIS57uRwuGpuJlvzXdHikElqSvxZOy3otKsTyR2PfW1tR12y///N08K
	 q7vvjBN0tXCXKEpKylA2ljw0Xcs5R1dnkSe03kFOluxmCyg/J1qP3GqNqRjuQ4bdXwKro
	 kxIQoujMS+E8boJgnzjYPUbQuzqp4YRWrssxbFAzMS0bNjkU9+ildexF44FuqZ0hnzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww+yVDRk;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A77606A68B
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A77606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww+yVDRk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4af173320f9so954424b6e.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223480; x=1795828280; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rd+OJrfYC05spJgrrPaaw8Or0kLWD6WKtcmuDL8E++0=;
        b=Ww+yVDRkJAR8dYKd9Nh1Z3+YJy6yvbaBcM8/PeRoMPWm/Y1vHcIi6R4SG4C1+gag4/
         35iaOvYhWR7kTS4LMJYm2S4OIgWKJp68fmQyMF1+0Urf/cU9IJKcqjfJlAYHfm240iWL
         bCcsv+R51Js7STF+MYXqAr/hz+Qv06btIy1JrbP72hhh1xUuE4nunflX62QeO2mSGbrH
         PGWAXG0zpwM2c4toVDAPlEz5JbIo87BBJB8IciK87SazHmVhURFOs3Vu0EN05xQTvXXA
         +fpXvT1S33Xii9T8xlmJ+WFp2CizviB6JvirKqKZBtDo2u1zNE8GMo9LZZ2nJc9Rfx4N
         L5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223480; x=1795828280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rd+OJrfYC05spJgrrPaaw8Or0kLWD6WKtcmuDL8E++0=;
        b=ziQnhbS0g1PjzhaUCLt6+skpw+NWaTM7bd4hYbPC33jQxZH6jDrlsD1ZdB7RDzihfB
         s3XMmhczJiGT7QwHQ3BRVVHwY0jTGdF+KigPdYNjoRJGovrTq1QY4psVktkltBAisdVS
         JKAZMcNjRY4Rn+zhP4bhvVL6n2ItQBEo8DFQXYE+BdQAbwouBGyq2OTLH+t+M4OUYuRR
         NR4gSF72m16jTf7WMW8jzlUgClrHvU8gxItq3135UqBFjzaqyKc6xLnk0bwb/xTt+SNM
         nlCT0FsPIj8mFaeSa89Dx+ivyX3YhaXy13F3QZ7QVIOJOkWVQLbrdbfAYqV23Ry9s/eS
         PzJQ==
X-Forwarded-Encrypted: i=1; AL+hErEatQxnR1X0zyytKWweTlPMn5YGgSSgJnCF9Gcd1lQyWctlEmCCjp8l0AnXpMelrcmiIM9oisyCcYGJRjEzVg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5OI9nWsGNVGcTZbk0Hb1bfAHkH4bZTWTsUfh5Y1dlYSfjtCFc
	ju0qQvhS+lQ1YqZf0Lsu2rdeDDqBxkGh+uKkVJzAi/VvdUaRaRxlACxG
X-Gm-Gg: AYBFou2RiVkvqWAqqLmwMoyZjkix3BdNkcuubUPVhKPT0rzLM3MIIkdkqTdTGQb6naX
	72+uauEPudW699YViyvt2BLLs6v8A1d2xVt4lg8CZpteyVEJH1llCDobh0va/a8ZlvWlrIvDQVy
	vVt65qUHUZyTkNzMQm/7MhP1QknIN/AhODhLb1hYQx1tHV1BobX5fIg5HZIpORA4p43gkXGSODg
	5VHWum/eMwAEAA8DROLgVxlYJ4QNb7n1tL3Cgt4OO35FYWeQjLoJ31JR14mNsgj24YvTnEpF28N
	tdqpjGfh0z0r+INsAByQiZVwtm0esMrtJW0/Sx/imy4DKqa8/vdbImmK/ahCOspvSGfN1jphkXU
	gsDmq21cjNlMZZGJnCkPu+UJ3fxwENNyoJMcWOahmHKE50Vj3gBZAr0lVdJzXL0oyBLbpmUPebk
	E4PLiMF1nu3aIM0JhSwtp3ZcBiJp2fXPyzJFn7uKv0J/IXGbwf9xMpfm2DAqRSJi8IsY3QC50Pg
	VWVC5PTFiWTbFUfWOgXINoI1r7zabMr20dfXt8wd3gtIczTtJmDDfjOU4AD51ENNZa4M03wKa95
	hbWEGGTTAqnWA20Wb0CHpdVkZfQ0912ICG8o7tLH6GGG+WoTKgfZ90vWbh2ZosGTvFiY8TdgdpT
	8bKpIKtnhDLQPcSTvdcqeBzkGsZEhYk1+PdePDKaTiS5FK9KbdM7bPHX3pg4X/PDMs3CqXbpY7A
	ka8aiu/zW2LFs4oE9VKDL40N4BrfcxBZddRw/EumCh8T5wWvFdbK3u
X-Received: by 2002:a05:6808:4f0e:b0:54e:7cf0:c0b9 with SMTP id 5614622812f47-57a0d2f1a5emr5946703b6e.64.1795223479754;
        Fri, 20 Nov 2026 17:11:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:40 -0700
Subject: [PATCH v11 17/26] mtd: rawnand: sunxi: preserve bad-block markers
 on erased OOB reads
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-17-9721b1905ef4@gmail.com>
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

A bad block can appear good if its marker is the only programmed byte
in an otherwise erased ECC step. If the controller reports that step as
uncorrectable, the erased-page check counts a 0x00 marker as eight
bitflips. With BCH16 it replaces the marker with 0xff in the OOB buffer
that the NAND core uses to check the block.

Leave the reserved marker bytes untouched when checking the physical
first step for erased data. If a hardware pattern supplied the OOB
contents instead, read those marker bytes from flash after the OOB tail.
This preserves the column for sequential reads and leaves the normal
corrected path and data-only read traffic unchanged.

Fixes: 146b503e1027 ("mtd: nand: sunxi: fix bitflips in erased pages")
Fixes: 4be4e03efc7f ("mtd: nand: sunxi: add randomizer support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 5415ac6960b4..f8bc6e3c3ac9 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1111,6 +1111,7 @@ struct sunxi_nfc_ecc_read {
 	bool oob_required;
 	bool dma;
 	bool has_erased_chunk;
+	bool read_raw_bbm;
 };
 
 static unsigned int sunxi_nfc_hw_ecc_read_count(struct nand_chip *nand, int slot)
@@ -1167,6 +1168,12 @@ static int sunxi_nfc_hw_ecc_read_error(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
+	/* A factory bad-block marker is not an erased-page bitflip. */
+	if (!step) {
+		oob += SUNXI_NFC_BBM_SIZE;
+		oob_len -= SUNXI_NFC_BBM_SIZE;
+	}
+
 	ret = nand_check_erased_ecc_chunk(data, ecc->size, oob, oob_len, NULL, 0,
 					  ecc->strength);
 
@@ -1251,8 +1258,11 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 
 			if (!read->dma || randomized)
 				memset(data, pattern, ecc->size);
-			if (read->oob_required)
+			if (read->oob_required) {
 				memset(oob, pattern, ecc->bytes + user_data_sz);
+				if (!step)
+					read->read_raw_bbm = true;
+			}
 			if (pattern == 0xff)
 				read->has_erased_chunk = true;
 			continue;
@@ -1321,6 +1331,14 @@ static int sunxi_nfc_oob_finish_read(struct nand_chip *nand,
 			return ret;
 	}
 
+	/* The pattern supplied no marker bytes. Read them after the OOB tail. */
+	if (read->read_raw_bbm) {
+		ret = sunxi_nfc_read_column(nand, read->page, nand_to_mtd(nand)->writesize,
+					    nand->oob_poi, SUNXI_NFC_BBM_SIZE);
+		if (ret)
+			return ret;
+	}
+
 	return read->max_bitflips;
 }
 

-- 
2.53.0

