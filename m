Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904957;
	b=pRQXlxqm+HMCqmMZ7EPv/R2TiPp+oroBkL+st1oiWdF/w6+ijHpFxyuTS5lVeBid8pjS
	 xeXP3jGpGNt6QiXTxcdg5a776NFPl3It8DTbAVF66EP6wtxZjedgAeAliRIPf+MJyGRHp
	 /h1jSRIIMfgd6qUsc/MG6Y2aCqp+JG7kZ3pkW8G8USI6iX/kJw6wUN8tceMml3YEvW944
	 2lxAQnbAc2j7mzZAVzhSR5sYclGMVnqKq6Ira5ant6CmIWUGgl41IRVwzMIpM69E/JfkM
	 MS4/ubTuADga5SvDJhF5pXacelxolJem076JEooSoWkfvWHEjZLfhHes6ce49QrV0zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=GNH0XGnfrH2iAn+70wl7xaYoYGRxFKFBAJ40rbga/P8=;
	b=o6lg0Qs/BiLfuOe6qDwexBU9QaodLcT0/gOYGiLaQ0n9xynWYAwkHLU0XgPLYYjFZzin
	 LE29pxkxm2DfNXmAUVR05W460TLwGwxKxjfL5BGAK4gzhQ7amH72wl2WwYDqDxNbyq/YK
	 ABAR90MXnytuoyfYxVEJH+5xUD68XLa6ioThJRFNmzDs9XGaWWQtDOQ7AttUycIrLOOzS
	 MlCYtbBmZl3dXljpjquikiZT3lhd6KjU/2HYOPiv7CS7p5OzFZMWzlykU0IuMxyeECosG
	 lc3KWGZxwPqb+4W3vAdOgWSfaIu7Kplba6lVZ7L/CMXHbRtNl6HiKFK8VvGRpcgbPeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDZfSlXK;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E7606EE99
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E9E7606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDZfSlXK
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-854e904005cso718753a34.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904956; x=1794509756; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNH0XGnfrH2iAn+70wl7xaYoYGRxFKFBAJ40rbga/P8=;
        b=qDZfSlXKRudkyRHXJO1iZR00RQuH1Azytw9SL+Qj68Ax4q7PibUEnLWizaqVP7z/Ud
         l7uJakMe6uWH2XOW+HEUq9I5V3jovLF6gErkE24ZWmt8QcURMKNqwOMKfhrrF2Dx7g9v
         Oa+S19AsnMUomOfQVyUur3smISopI5B5is69dy4uH+jhYSI6sxbr7mes18vXL4QMDvJl
         wzG0d9QuMm7FLnX08OvXkvDZPQGk5sryzPxzgj5XiWr4IFj2g8EYJzTA5dr9naIwevzY
         429G4CFLrJnoVy0hXVYAbtYWTVqovJaySMqcwSd8W/oeG+krAGTh8/umvkwqqYtB4zJZ
         tMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904956; x=1794509756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNH0XGnfrH2iAn+70wl7xaYoYGRxFKFBAJ40rbga/P8=;
        b=Eecz83DYiaka7lD6UgXJEUZmhotoe8ukGcJF4oK1/dSp54Sre6NEdPBs8JYeD23Mka
         Unp8LfRI8LArhtAA0ZyBuvT3GK9XTG+ARiiayjMTa4RT7QwYWu8g1Ev6kU3ymCM6duOM
         6H2yjpBjnJCDXYKh/O0jDEj144Z0vWzo2sQ8ZIJAQLm5Mz7S6ZW5JZyc8wUTSCF+5+ZA
         xTB9dSCsZdlc6phjgiynLTJm+2TzS+TOxk3DcX++7NLv+sRP8FBqvY9tOzZvFv5BH30P
         ok8ZOs1pt2s+MIjPR+Cjz39HeuOPsRpRHeMI22xvvTolfl1OGPtuyaTrsKVthmgQYJxB
         MMuA==
X-Forwarded-Encrypted: i=1; AKwUvBwGXYnkUazTfLX75iKo7OiQrAxmdyh2odYmSyaVcDEgGd4GXkex5fXjQX2kiAgT1JQ0SGbTtq8jBgH4oruvBQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+31z9eMRD+liTRVyX9/aBJQZnJV0WcDZFfWx+SZYYxYkMHlguM
	JZMEC0hwQRcF2pD3Og70dr4LfKiSr2bRvzIo1kfkYavxBQlLIVPe9UW6
X-Gm-Gg: AYBFou2j1UMjbSvLzu7y6qOU6QsjnX5VZ0z+vxnUYpt0i1vL4gVBrsBjg7UktY2jvTb
	klYVNHsMPJhY9jcT75J9qJLZ/fibp4oM0eyWR6A9ZyzFbkqnC9gz/GgwQ1yv3jCSjGsREWGgjVb
	19vTFTQ1LVp1tQbX+MBSOLBrL87zg1qdsYoGVHDNAJryW3fhIqH+jQhrAHSZoKfWz23BrDOPnSy
	4aSZLOiG4WJ/XC+5jZdsXF2Vz0iGpahv0QQmvq0EFcqxlP4JZMdFqMZYbh/EBM3TgYoD92Pzdl5
	jN+eYqoEC3PcS4/NLpUUUAavVtT05vCmhNqpNVsWVDiZ/5d53+iEi8gKIQ71HvSLJBW2jayOH6R
	AoxMVV9pR1DrjUgS3ui3+bNAf09DnWVRIDRH89+UAw+6XJvQv6EIUFDyGUca/RBkWaDQK7prtFi
	fhJjSIJIaU91T6WqaOY21YBNqL3YjXsb/xMUExl6H1abGERtHeMxe/f1xRY6FWKU5uwgZLCxfsW
	7HSAuHXJPUdHa7LKAlmsyV06MistPL0durLFu0waCapke/CmFVNr17iLwjKGP7dmTxdpXy09e/s
	FVK+Q6QUSRAtREaJb3AGt+/mH8K1mS7NbYOKdp1yLFqbnIFMAd5u8rOW4CfzQPlkClItwP+2Ap8
	EoyrF976hukTJzG7vLmoNpomffRHgbHteugX3Kc5nklR6D9vD4wofrWwmMaUJxy5jlSo+bi2hqQ
	+mUYso1riI7nHF+KR+6fwJ/dRD0GLB3owpE7IO2+Nn83KLRZJqWtXkUg==
X-Received: by 2002:a05:6820:a03:b0:6cd:3fdc:2669 with SMTP id 006d021491bc7-716e79e8336mr261121eaf.42.1793904956099;
        Thu, 05 Nov 2026 10:55:56 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:55 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:31 -0700
Subject: [PATCH v10 15/26] mtd: rawnand: sunxi: send all address cycles in
 split operations
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-15-dca1f6ed29a8@gmail.com>
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

nand_subop_get_num_addr_cyc() returns the number of cycles in the current
suboperation, not the end offset in the original address instruction.
Comparing that count with the start offset plus the loop index drops
cycles when the parser splits an address instruction.

For example, an instruction with ten address cycles is accepted by the
parser and split into eight cycles followed by two. The second
suboperation starts at offset eight, so the old loop sends no address
at all while reporting success.

Use the returned count as the loop bound and retain the start offset only
when indexing the original address buffer. The parser limits each
suboperation to the eight cycles supported by the address registers.

Fixes: df5057999f8c ("mtd: rawnand: sunxi: Migrate to ->exec_op()")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 54377f1789a3..0b92bbe19c0a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2518,7 +2518,7 @@ static int sunxi_nfc_exec_subop(struct nand_chip *nand,
 		case NAND_OP_ADDR_INSTR:
 			remaining = nand_subop_get_num_addr_cyc(subop, i);
 			start = nand_subop_get_addr_start_off(subop, i);
-			for (j = 0; j < 8 && j + start < remaining; j++) {
+			for (j = 0; j < remaining; j++) {
 				u32 addr = instr->ctx.addr.addrs[j + start];
 
 				addrs[j / 4] |= addr << (j % 4) * 8;

-- 
2.53.0

