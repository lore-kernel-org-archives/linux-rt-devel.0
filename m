Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223480;
	b=lzfybtoqI9eF8xQshOr7MOjQXnzZ+XQxbX85thcRKj5vhmT6TtN/xSNHoY0TOgaO+0as
	 1XYya5R3YvOb5bXdpyKngGEENdenZ3ug6SBE4WC67ECnZL6y/GoktjE8Cdq6OXuBoL3F4
	 CFyezK3yx/D8yPO8u9NqGpktA9c6hRXXLfUXEEfOKHJV09mBg4SrjkrU2Kda8bxqr/e+o
	 KJAmZcoiv2D1NV3Kb5HGijW8n8CmcSMJIbERkiS6+6nrWfXfFBecAeL5dOgz7Alz+xsl5
	 +SFAdLRrYkrjAj/BY/lmTkLWtJOoa5mcmQYd06VvMj8xkL1FKKQc9PW4jbvivjfumJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=u89IqnoAKi5kjnWBIZSz6wZn1oqd6Ypo53SPsotyUk8=;
	b=myYdmYXoiq1r31f44rLdKsweMXZspjzcT8xsYWVaBnd/gZyDJe4+OJEitTw8znxULqPx
	 Mlqkwu3ROi65YOVazhTmQyvkXcOrFm7C0OcED4utPwQrOR3eGIgw9OrCRtj9A2jwc8vp5
	 0/jtFB/vtqscaKOpYo2QBy9FM5wF8U41tSKpEAhFUsgmC4GAYr986zEHWB8d+Xxr73O84
	 PhG4Yc19RFg0h7e3oJGjc6O2oeF4GbFq7O7hTt0DC9xKxUkh06V+VFUhQ+nqgvTOD4ISH
	 dW6TSBEsdllgX2d/UPwAqlfRieipnBL6XXl0NM9jsBWHRk6gZRx8xVIaymzUrlma8dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcOn6EqE;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114E60A3837
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4114E60A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcOn6EqE
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451a49abd8aso1569429fac.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223471; x=1795828271; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u89IqnoAKi5kjnWBIZSz6wZn1oqd6Ypo53SPsotyUk8=;
        b=AcOn6EqEuTrh46YRUAgHrxCIOXmaP4c2vGk73HZlRKB7bxD++wLNCuP1dsPEnyQNEY
         /b9iKKjkjZyRnmzpbzveTzAdI20pmH/g+7VRk0Yt5jb3o4nqXLGn8Ca44LZP6Z3jOsWU
         zKPmBePmmqs+sxXaPBHzKy60dx+64c+ief9sv5d+Nr3DfMcnfC/HycHFcdlSiICBymuC
         4n9ZzwE39xExQgiuJvq9D8rYfXd6zFdZiQNZgZh+Z0ZE4ANY0x/xLzDVyCcHMfrJbJUQ
         uQgi8cEvCDpNDFn/Tnh3I7BUYoGed6CmlvVSc5VdIBwjlmNb5y5iXJn/weQ+ITtJUO18
         JeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223471; x=1795828271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u89IqnoAKi5kjnWBIZSz6wZn1oqd6Ypo53SPsotyUk8=;
        b=oBFbe5lEVMOHsj7jndQcVTzec5pY2qKqyjg3Vo4F0PD3p0JnCv45iPN+icRm3sI1A3
         5rfnYz4Qdc0/s/hibcEwzGUqvIj2GOXv1K9ZqVptvw+8K40Sm7q7AnYiq2vE9GnHbTME
         fr51aoG7L9qKA3My2o7nof2hgU+0pwtD8uO+PUGSbOnf7aAwewJYrjqGTHCKZg29Hdtd
         CNfvq/Y/ByENXQjLLAw57IwovFMrM4HuFple/257t5YcoobQDSUCL4iXZh2IPKzSAMW9
         xhvO5ka2mQeoUd57Ke789bXstbAemkcz4svlkaMwisAyw1dutBUshSwnm0WS7YWbi+HH
         NmXw==
X-Forwarded-Encrypted: i=1; AL+hErG2c+bz1h1SMKo3d/feyfc0j9eZUbvPbNIL84n+t/EISIJjz/VsmADo2ciOEEM/uCFj3GzrU6pLpbEjnsTGhw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GdtvW4MFQP4IO+g+g0i5eoh6joweDF7s9T2ScCcwgyJmm1v+i
	S+G/FreUlZ7bb0d0YSz1TheimdR+Ed/uenzUqkuV5ReRlysvPffS63yU
X-Gm-Gg: AYBFou2YIFm3uBFROXAaXD0++xRtKvuRiTsQUY9jItOklGFKmpLvEHH10bVvET8uZPr
	aUwyS5qAESYJJq0c7GxWf5lYA2+1Q4DNxajhtsRn8gnOl1P1e0WHdKt5LKZQMBhAIcFavrTTdr3
	w/0jTJUosA945LuO7fbBUZouLRAGaZC6AHnbaU8DKbpRbBWdFUXcm62bl8buGyOPtH/PMml4ybp
	VTthggDDBuxwAJU8esE87MNUkDGrg117Yc8co6YdUiWCbfcsfe/wIzCy3AkhAKlW+HR8ADOeqD1
	pGNbjD9q5bbrSXiu4gOXyjL6kUyS4LwHBRB/TGkJ9L4bF/F23+xLyNQDNEoI82JjYVdGepGQS4D
	ZJVZz4CfHAzRmFgu8diUwOPV4o2mzNRHjbC8KGWonY1WBZfoO9laP+E/qKhXq40AdXRxoyLquOA
	IWjSb3qdgVZkIbnm6qbnIbv6iUlNHjdupeTO4W0d8dBM7IWcnvuWp++H3qxAt38HE2s76zUuA7q
	yd4T9vS+VFRWnojSq0pXgAY8uNFpw3rLyrXfFt6eUJOGndYbYGCRoZiZyHaq8sNZGa6JLMzYN5F
	0qrPwBWJgKY+7UxU+gpXhkjXpUw+vuekftwK03W48gg1q8xqfcgksoIMNVfphVuTSRsIbu/0XdS
	qUVPgRPYbI1bbXkHxoZ418qhiq7FB5eJ47nPGlY1dR1IIBt6qAXoHFtCse4akPd7q7B7roVLYuO
	biFKY69opiBoDWTSVX7xvJA646xlWEQsU8LGmBJyNiYiuh8wjAucx45hDVO0y3p9NOsn4VKF1T9
	A==
X-Received: by 2002:a05:6808:244e:b0:574:6f37:671d with SMTP id 5614622812f47-57a056c81c5mr5959981b6e.5.1795223471048;
        Fri, 20 Nov 2026 17:11:11 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:34 -0700
Subject: [PATCH v11 11/26] mtd: rawnand: sunxi: preserve synthesized
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-11-9721b1905ef4@gmail.com>
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
 devicetree@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev

With scrambling enabled, a PIO read can report success for a physical
all-zero chunk but return descrambled SRAM data instead of zeros.
Both PIO and DMA can also reload the requested OOB after filling it
with the zero pattern.

The ECC helper fills the buffers for either hardware-detected pattern,
but the caller skips normal buffer retrieval only for an all-ones
chunk, the pattern it treats as erased.

Skip normal buffer retrieval for either pattern when there is no ECC
error. Only an all-ones chunk selects a raw read for trailing OOB; a
later all-zero chunk must not undo that choice. Keep the physical
reread and erased-chunk check for ECC errors.

Fixes: cc6822fb756b ("mtd: nand: sunxi: move some ECC related operations to their own functions")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-172123@kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 43c0796d953a..538ffcc79108 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1226,8 +1226,9 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
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

