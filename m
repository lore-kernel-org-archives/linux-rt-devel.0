Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904950;
	b=oGSxt1e850aIKOco86TUegymzkFjhlNTL6LADput9TZur57ggPk9jxLddAXXP50SaLYv
	 xzvY7ZfKVKMg+7H5rjLrVEWzBUXMzGRAwK6Gd6zsCa0ICvoLh6T/uGp1zemlOY9TxiO/g
	 0/vOqZ1EQIEN2C5MI+50uOdZC2BAzjmnRdArM/gq3b0NmWpvqQVirWZ9mTLQCxlr8484r
	 0Z+e0W47bprnLZ9ZekqLVnS6RBltoOV+a24hKdDzlSwUS9XkCrlRGXLfXN2XEfXEXIP1A
	 A8jKPgn6aupXobBH5gtPUwOzLoE+jdmRDwQK5U2ks3Fy10oFo4rAa2gUdZboLb4g3lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=BTl2XZPhy5va2LFZZWNF4agNgxit/6PdmaEnjIQ29V4=;
	b=J6BWtztXuAOxdj5gY9N4CUzUpttCVY2ebeDI4QDrqfNjS9MZLW1LxLVQUkCjhFLxzxrh
	 sifKYhydkNPBPnT9pMX5HqZigrPJExBBz6xpcl1luzONBg38yg8G7bAI87OJB99oUWhzp
	 d6bg6nnx/PqPzMD8l3UjgmGp1NkaP17FSfAfRGVMYcOCxOfbpbi/X227Mw8yHiTUSIvJf
	 2eYGsGGXul/76GBTO9hB78S+8VvQoQj5pVzsCCHZefwLR/tmY7hTObJ2u8VAULLMfz9Fn
	 wMqSxQGcA9OeDOih/qjBoR1YDihqI6AkrQOFduqvVWIF4R9u7v+Fg7CJXFYD24rrkZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h6/FWWi9";
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F04606D80A
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F04606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h6/FWWi9
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6e560e00a86so1474508eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904949; x=1794509749; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTl2XZPhy5va2LFZZWNF4agNgxit/6PdmaEnjIQ29V4=;
        b=h6/FWWi9gCrCgPwyDgHERAragFEu8ncd1Un3n354F4ueu1Wa447bY+bfWwnVD9b9yI
         f6iaHDHvnJtYzX38F1SmgxSV2EFfqsWFvv09TZOhYfkqCy5X+l/64q2U+HKtH/blk+EC
         uHj46uoqGB5OR4YpAXEeft0++drfR8Tff5sBTnNx74Xl8dOO/gEoz3cffIMQT3TzIZ4W
         pQV0mc1xHsYtE+hqtdhY0fvzZ2hFoU1karCzcvNZf0pMDWN0l7+hcm7iK2rcYqtqYZn5
         zwq0slkTxe3PtoZGdl00N2QTjqx8klgUpqYxAx189A5mYESoiO+XpokGtY+tozyczv4o
         IDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904949; x=1794509749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTl2XZPhy5va2LFZZWNF4agNgxit/6PdmaEnjIQ29V4=;
        b=EOZu1gpff2beDqp/dsXyTh/PR969W/SS9eAVgxiXUZ2//Dd4rLeNszNl3a1C5ABFgJ
         cOhHiVsc8F3pfBTVFgbdvQT2B4jh6nZoPb9Vmpk5ln5s9QW6XGJNQowyELU9z/9XNjz9
         n2G6ZSqPJ1RGXtHZN2dVAs1B3Gh2NkXuomWpllOWfy2NkAFY34gDMDt/jJSPQ8SeHxmV
         ix9Z0KSuT7wtSxBEOCdoXd1AIaH25w8SSLeRtjxgtIBGJFmXxeaO9+IAcJGEJwkatM4M
         ZgE5MohzW5esPIb1zBFcrgmrSbkNxyaVlsC/SBe1jhiWLDs2DNIYscrs8xk/vGMDwORu
         xmQw==
X-Forwarded-Encrypted: i=1; AKwUvBwz0Ih6L/VhKxJcJv2zadiQnlfWnOjcZPcfYnU9aitICC5hWYDs2XqdKI2mIrtblEIwbwxaP98g8s4xMBIxXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+JqkA+kqrmc8iTUQIGjL5RnAFZLhFmz55/CkAmQgwMwIHGklTS
	tlTccmyRxHJdYiig8kHITaC+0NJIxhDxsggKFAO5ovBQgMEOyhc0IwFE
X-Gm-Gg: AYBFou3p77wI6CrK1u3Fbtp5cVKqTzAWa134tO1w4rMHLDls0SvWdC4UeUegJ7IUzfu
	8O4qMt18In34zSUNz1SyD8J/IkCm/77t5F/nG8njphIuz78GLfZHaTvMIRsHktseHbu32Fgmok6
	TxEZCl4WeVx3A2eDM2mT2Eqv6BEh5aOMat1tQJLa4njU2DSEwRu/6GEmXJZSLMh0mtByg2Hj1Ps
	e0SqY/vJHxz4VNcsmXakv0bvjl1IRhNd4tORwrStGoOWFMJftaXgu5B+DqQ2tL60JwOigJGCkXp
	qJZOM8EpA+hrONJDY7EJJQtX52503MNgoCqln1zdN4nZoYIjYF19DPixMvV1sxb1XAvqawV29TK
	ZWaLIQ1PXjPsHx85Dc3SNlRlqiq/8V6+SiI2AiPdMHws79WU1sRVe7IF+9VFelk45yI9UQr/DeI
	aizKbXjLr/ZDuUM/7lkdKs9prbQFksGiprD7fTpmZghI+kfOsa5lHifm1YXu3DXMXILhrX13i1l
	TEX1hWf+wtBtG4ZvBqQ/ExKpTYvWKiqxnlLiDeFaZvdtaccRX41BeevPFgoXy/wDxYldaot7kav
	0y/ODd2AhfRlvDpDo1JOuFQu6tqNn3esEHZ/UDj3H5t2oJerDrk2xpT3ZrvlJs1hRTUutB0appd
	ZCFBVNWytImpm7bBlkI7rpwuNEFp5EEDC3M5TklohUUzpfeFLva0XoePYpaQwL/SExBFil9ZZev
	59C4aEHcv79a24RYGA4d/+a7n3QmzDu6Q2jGjGkH0S7487gX343W6V
X-Received: by 2002:a05:6820:824:b0:6e0:fb60:d5c1 with SMTP id 006d021491bc7-716e744f8bfmr419274eaf.11.1793904948781;
        Thu, 05 Nov 2026 10:55:48 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:48 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:26 -0700
Subject: [PATCH v10 10/26] mtd: rawnand: sunxi: preserve synthesized
 zero-pattern data and OOB
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-10-dca1f6ed29a8@gmail.com>
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
 devicetree@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

ECC exception mode recognizes physical all-zero and all-ones chunks.
sunxi_nfc_hw_ecc_correct() fills their data and requested OOB buffers with
the detected pattern, but sets its erased flag only for all-ones chunks.

The caller skips normal buffer retrieval only when that flag is set. For
an all-zero chunk, PIO therefore overwrites the synthesized zeros with
SRAM contents. With scrambling enabled, those contents are descrambled
data rather than the physical zero pattern, yet the read reports success.
Requested OOB is also reloaded after synthesis, in both PIO and DMA.

After checking for ECC errors, skip buffer retrieval for either detected
pattern. Keep the erased flag separate: only all-ones chunks may set the
page's has_erased_chunk state, which controls randomization when reading
the trailing OOB. Preserve that state if an earlier chunk was erased.
ECC-error steps still take the existing raw reread and erased-page check.

Fixes: cc6822fb756b ("mtd: nand: sunxi: move some ECC related operations to their own functions")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-172123@kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index e952d7f6abef..e79fe46926d8 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1236,8 +1236,9 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
 			continue;
 		}
 
-		if (erased) {
-			read->has_erased_chunk = true;
+		/* Both patterns are already filled; only all-ones is erased. */
+		if (pattern_found & BIT(i)) {
+			read->has_erased_chunk |= erased;
 			continue;
 		}
 

-- 
2.53.0

