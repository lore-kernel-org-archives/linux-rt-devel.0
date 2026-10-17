Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633AE483BC0
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266390; cv=none; b=D3c83Xz8EKGFBfCZE/MKyh/8Zvt9k9DRWbDkvkAPkMVfj3Rcp4UeJSY2LvtWAvSXFLMpYXMVEecyMvxHuRhA8cwV/DLsYnukisb6BEwPv5FJ34PGgc4D1dEApTvwtUYQTSJX2N9641buU//Jx4ROht/j8nuAMn2Nu+Qb9s02nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266390; c=relaxed/simple;
	bh=dbYKQMzyNYaKHf5LoY3DE8dfg/ieSUwcZADEtitOIW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVN+jJnZf1PNDN2CqZGb7ab/HTfqa/xvszynhkg3oH+jl/YhdrNvxBZ+12SqD9KRshH+c9YjJzPq1awDjNNvSZxT23bmVnx+lL0fYLMJsPyu82vU/B+tzP5rsv69nekhXQdpTJE15P0e4MvgJ8r5x/HbWRTfeVqTdCjMl+FO1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY7ircEw; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY7ircEw"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8479f46ecd8so67500a34.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266384; x=1792871184; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iygLDIgOD8rajawodvAmwVYRk5k/3RMou3i6AByPjMc=;
        b=gY7ircEw+Qeti+S4cT5fTLeV8r93LDfyxp+6YJKsOp45c7iSheo263dEYHm597Tqlu
         mt//peDxR/WWFNY+7zj1UnYL+wK7SNpmwB47Y2f/8mqHXsS5u4BqrjQqvLEcvt/hmYl7
         H53EEapDg1nZDJJQu0iQbV5SYrwIsuGuPV3nyduiaO6BLkf0jzPXmi+GfUf5yTwsdAb/
         e2PqxRgvt0RLSg6N4K9UkFKsbxX3AtUYWh1xKOE5yKXjhrFJTENBtSzmjl085w709kIn
         4i4Jq7UVDFlOUgn1sFXvFbvPWuBC+vldfHBtrfeqVvENPgAYDTAuZLLJQTVPFhEYAu/x
         udDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266384; x=1792871184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iygLDIgOD8rajawodvAmwVYRk5k/3RMou3i6AByPjMc=;
        b=ItltU1PP86XA62oSyuVJFvZxSmJYtxbFQ/JvOCHGUtG2HFgGQvc/0Ayg3REAkgzyE4
         vmYWYToiniNhxQsVSWT8tppQTNWMkEg89eGJwNmrRL2AwXvVBdah0HlnDP6cRDCj5PAY
         t4WcwkoyOP30XnjULvRuz1ZDkrrnGTe9Sh2N9NBqdepArBpVgLr+RsyZ1epUtQmy6xMM
         05TXFJF3WKnEVhDj452PZ0Sbu3sPkgewP5SipYJ6p5NkFSV2T2GsUYhu8b1hpAa1mBZr
         J06Uo3gfP6Fr7HSiPbo56UpM8v7oWKPSAWvOuhfF7l6qMv4fJECir76ePitmaW5LVKp8
         VPKA==
X-Forwarded-Encrypted: i=1; AKwUvBxCLNpuIaw2+nHj/kgL9oSZW7UK2LRpNAJemIu3taVlmQZxOSGYir5vWOxQlQr6a1ki1iaETw3fohxWkk0vsg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL6/YdpLktYBg8PwKowhsH29XvlTL3rBdhTfdJDTRPKpohr+yx8
	Vh6rCnq7AYFipPzaRchlTy6km9s8W5RIP7jYA89g56rqNeaKSc133pW9
X-Gm-Gg: AYBFou17CX5n8ClEISW0TK3aIiwU2l35/8bzo8VchJFvCNGtSDNKt0WOI4lDMPQUQgy
	5evKGXBFMkHjAgXIjJ9CTVuyrfAuX3PTLZ/Naec8fcpXs4f+Zq1N4kmpFdOglkb1Q6UZEIgBHga
	KswRVSpQykr9y2HPXuE3D11aelWLRSUL4DKZ4DMfHBWpz38zEU4tkvJrW4sZwnq8bNxmnOio5dT
	DjzgQmcQefhE8dcbpDs3Zdw+d2nAiuLY0iZVym1jxpAPOMgmr5UT0kG7MYtaHgXvL+EVDJbiIeg
	tJUc4Zf1aWk5Ny+Io6khnWBXPMuyXdSZSII+X7cRzj87sbg+8pFZqgXvEA0fp/vy9c9GbdVA3Gp
	Blu7Z/h6cJX34exsfvkm0IvXeGpmc3yUJLWTdI5+h9vHRYhJbQmq2hEtLuLZYnisjLi//1H1J9e
	nfReMywnPLrQZdiKBow2B7tGb1mtwW8l02Of/9mQGDFkP+EYRsS+rSMT05E5qa4b7kvxzq8iJ6k
	Vcc20Q/28fgt6P378N7mbAKptnv1+YSmXgCBvWKfqnn1h9Z0en8ZNL2b7iCY/ZjmDdfnOARN/1T
	X05GY8LeFFtPx8p1Z9PigeQSpcgpb4ti1JIkprD17Yln9V8GZO62BLutDo8wnNc7oj8EukAvVLX
	zp1n4P3rNIiWIjhl1F8K4uGzkYfqma8g=
X-Received: by 2002:a05:6808:ec2:b0:503:aaf8:ef12 with SMTP id 5614622812f47-53ccfbb22ecmr2554952b6e.34.1792266383632;
        Sat, 17 Oct 2026 12:46:23 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388dd8b5a2sm4025321b6e.12.2026.10.17.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:46:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 17 Oct 2026 13:46:02 -0600
Subject: [PATCH v9 07/18] mtd: rawnand: sunxi: select the pattern ID for
 the current ECC step
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-7-b624c09e3ee5@gmail.com>
References: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
In-Reply-To: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
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
index 1db6ee18594a..22cc8998d49c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1120,7 +1120,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	if (pattern_found & BIT(step)) {
 		u8 pattern;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1))) {
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
 			pattern = 0x0;
 		} else {
 			pattern = 0xff;

-- 
2.53.0

