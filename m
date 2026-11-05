Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904948;
	b=NPiivYMRPY6giZLHUDsJWGNDdIV5IyAdZFdaSZvUDcWQT35+EiMJEGBUMmwd5hBDnz60
	 mS4fIVXucjbMqr59yziEPZVkDUa788H2BbYM5snL96Apk1yzckYWxCK6t5CrLXvqwu1eF
	 M2/bYhSt787TsZ3DH4m6fyLT45+11IeCh7cBJT3Hx1iyLYabUDxwbw0c3QEjVg6iFhIfW
	 HGI3kFi1vvMlgtvGeEnjeXsyTk+ow2HgBQBJXDqjgEAcPVtTl09AkGs/+luA6vg68l/oH
	 t/MovlyasVl6x2t4pWe8SxqarGLbputfAVSCFvTuqkU5I03kt6mOlBYMiP452DRDRiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=kjkwKej/qk52hMyec5U0ZIa7X3INzm/Y08ET6LW7Wyg=;
	b=VYINwvxwg+ft0YB0w/W9CBTWzCofhuXmURxCQH1xRQrEVQvMrr3YkU3dGn09dOCYX9KO
	 vClTZ/FJUts0DVUHaZ1vYaVRcVJOoBsdsJKXoXPftjjSrnynKdToVPW6zJaqbGtZdAEPm
	 msyjLN1SlaIxt0KrOxrk1qNr82cci6RAQQzBqjVI6cnbS0usWF8c0fqknnepGUvrB1c2d
	 EHrON0Jez15mBJMf90VTO4o5uL1Ppns8qBLxu2wnpsIOAZ1jkbR5LEJGGXn+Jgw/JAIIC
	 5eM1z5M38T21aub99rob0LRX0sWvSPFp44BIt43j/pjb/IR3g6sF/WMfwfCaxJyCNeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rF/qN3Mn";
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE8606EE9D
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66AE8606EE9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF/qN3Mn
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6f8a519e215so1084203eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904947; x=1794509747; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjkwKej/qk52hMyec5U0ZIa7X3INzm/Y08ET6LW7Wyg=;
        b=rF/qN3MnuFpHWAY+cClqvLEhlfpt3Wtow8s2iNBZbzdZ4U7JBx2bnzWGZTmWe6Jf9E
         jBIYaL2Zf0A0LoMoE++jtPGqA+36y1+/5HBHkbSLtPPtPsDtcufMDwCMujda7nkUKY8H
         LOPeup1Npb52DQTPPDsVNRX/dCW/BBlGqe/dmfFBAOKtGHQ3iHsK2JP39YjrpzpiE8GX
         iA3mXYC5p3EQK24lYR/cxPdUZWvcPOFVJV2m3oSC4srJXvtx+wURJx/SWqxFAn3hXnkk
         5n4uzCfsmnWBrRDs0U22wNDwdDG02mSeaqNumVI/oH58tmoU2PQvcEbmXwDwEB08CNsI
         iGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904947; x=1794509747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjkwKej/qk52hMyec5U0ZIa7X3INzm/Y08ET6LW7Wyg=;
        b=V80aWHdfrVRWdPkFPlzdTT1LdlSXwpee1xbaNw98t+X7/AzsXvTm+72pc/2ZFtwbnU
         EfDSCnJ4ohQD4Xu/68BlS7pk+WvlxPJiXzuwr+ipvzeXoWHYhjyK7KOVLFTqX/4wDpT4
         2hI6SQrknjV6kspfvE0RyTlGSz+UVyxnqSkS8AV1GkV6S80vOtzvosM2eJcfuadt5U/t
         DEEEXYSf27XVWF4ZPV81/BWh9d7+AKMGtigPj2+cwufN1XH9+/h8QIA15F5CTu0B6vly
         WnHEIznRYLabO575mqvM3r3XOhZIpyBGgH2i3YYv+SW+I2lbuc/pIKHmone1QOCASXeb
         woJg==
X-Forwarded-Encrypted: i=1; AKwUvByc5vGoa6vQfWiT4HuIDnMnWgN3nCEBlgUTxlz+HwWNHA/RGpWrDN5plOL8jWQiMTBjdG0SU5v/4tIZAnP80Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8WLeCOpXxhdPYB6P0vOdwEwQ3088yEBholW0cqqTQrJedZfLWS
	MbTx+DX7VX3fYYUpUbMAOK8REvCPJWezt/oquYpkXLA2g0qx6JfZD+tS
X-Gm-Gg: AYBFou1oJkyk4uaWEP1JL90PXCk4yojleYKvkkX9nYBPbxtcPAbddSfZUjAlszca2BL
	fx5VRSg+yVFYtMhvPxhpE2IutHtjXkKKPfAQd956GpZC2w+LnX9cE84zDidJjPyz7Ub+8gKQMJH
	nEn5hV2z9Zc+yhKwavbOZkeyTVcFQW3RH1S2ToRhUGJGAb9rZ3jhwoZx3iazU0w6f3jdckEcP/J
	CsvLe70nfoot8sItCiOu1ZjmzqDaFwDq6M4dNrqIvhhn6sUXs9s4VTFMy4pr/1RnP5fM7AbEvbK
	VpgtRYNKbk9Fw3V6Da9EZW2PaQp9gpX8RqFu8XukF2whkhZDp43R5enqGyZass3DFVRYp6amha/
	HM7g/N4QoaBB1KgOVSKxlYIFHT/65/c+EDTL/vA+UbjOZbZ0S0lpCxXUimrMxzaqRzwj38FYx1M
	El0C3EA0mImnMvhWKPmdRoQo1Cgok/RA6yNVzw7PG1mJfCUTOzJN2C76pGLLaTq17f8jQG1UTMB
	O3JXecTg9xz2Mcfb6SkDY228XPHnpqyWAIz3HI5w5xkLbbk6CrdiUCNN1Th34FvHakmbi8KHc77
	jOowppzKQB/rj2iWrQRURFlQ7i8fTnnoft8jF8oNBTXxClydrk/6WbxGlwWfRuENKZQQyUSwrEd
	rHIYWg+xbxRt1tWsAQsnavjK1JqY8gKIcineHPEvVI0BeuUdVlHJns8cslOmFGHsteGpNc144n2
	NPG8h/eHeeRbZB9dbKZ12mELIa0n/J5Nb/4gVgcFcS91lKuOAb1GzY
X-Received: by 2002:a05:6820:2308:b0:70e:177b:eafd with SMTP id 006d021491bc7-716e78881b2mr244556eaf.16.1793904947324;
        Thu, 05 Nov 2026 10:55:47 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:46 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:25 -0700
Subject: [PATCH v10 09/26] mtd: rawnand: sunxi: select the pattern ID for
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-9-dca1f6ed29a8@gmail.com>
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

ECC exception mode recognizes physical all-zero and all-ones data
blocks. For each hardware ECC step, a pattern-found bit says whether
this happened and the corresponding pattern-ID bit distinguishes zero
from 0xff. The correction helper checks the current step's pattern-found
bit but always reads pattern-ID bit zero.

PIO processes one step at a time in hardware slot zero, so it is
unaffected. DMA processes several steps at once. For example, if step
one is all 0xff but pattern-ID bit zero is clear, the helper treats step
one as all zero. On scrambled DMA reads it fills that step's main data
with zeros and reports success. Requested OOB is also filled using the
wrong pattern. Conversely, a zero step can be classified as erased when
bit zero is set.

Test BIT(step) in the pattern-ID register, matching the error and
pattern-found bits already selected for that hardware step.

Fixes: 614049a8d904 ("mtd: nand: sunxi: add support for DMA assisted operations")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 02aa02d2cdb9..e952d7f6abef 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1125,7 +1125,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	if (pattern_found & BIT(step)) {
 		u8 pattern;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1))) {
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
 			pattern = 0x0;
 		} else {
 			pattern = 0xff;

-- 
2.53.0

