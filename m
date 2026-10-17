Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8549219A
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266391; cv=none; b=QgcILUMe0V/ZudRG6QCEHUqQbxbVFdGfW3Vip0iLS0LfhYu+HD8S6cD/5hy6zqYzjsgpitecD975iPbLe1Ac8malAnpWmdWV16ZoTiuxvFOIlwXRhG3pbY1LskabgRN6dwmTkhYE/qIwuYTAmJU9LIikkrcpj7w+Yf+zPnAnp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266391; c=relaxed/simple;
	bh=Gr8R6NeJ/RQhMXjnXQ9SPScO5ueGFcDbXLJ+snnHayc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0LHUWuQiQ8vIqytv1UgRo9DPRO1aP1kxe2hUgO65w6sKnbXtNyWSrw+3pNd21WcLUqLn48QH699laiSIF1sRF3TaCCUfxhuZr8rABPibN5nlkDFYbSmyF7+GhRj3mrsuV2rYnxBw7+FKh0u1HUnAPsqYQIkx6xJobnESepwwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax9a1SSI; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax9a1SSI"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4a451915d8aso616834b6e.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266386; x=1792871186; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZdHG1tGz+KtQsx+1wa5xHbH5Q5lOoI44lGCgj2AqxM=;
        b=Ax9a1SSI6hiDh05j+wpYYSZbpKHwcKyDiGL4ttF9F3YkyQkUhBT6CZS1JCXCNSzovs
         GvEbJ/7lXp0AcZDmVQbV2MjrTyLWmUWU2W8opjzPUTS03U48AcNRfpBLfjjLvRFicixV
         uJFB+Eyg2a9CpzB2SfGJq+1NFWezXf1K/+iYV4IKPRyH0FuNqetDvDZv9srMLesv/2uI
         I1jqZ+gQcoawI4DO0thpWP+fznlh6KSaxlorgTabWfJkyvp3WMO0i4BYqA6CJqUQKOhm
         UIuBIMDLuSQuQ5VJYKG5fD5l2phVjFISOUkavS9jywve9vErXD27N/iTOdxwYiq93dOg
         eUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266386; x=1792871186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZdHG1tGz+KtQsx+1wa5xHbH5Q5lOoI44lGCgj2AqxM=;
        b=WmQOelmzUEDdJuF8qKglMKVftnG3mqTBkudQSqmZWPx9VfU9BT/mDEJ6Tu4IG2rJq/
         0oifc7eRAgyRD0TNe/7hMpGOJHZmzdJebLJI+T2ZcArb+N+HxEUu7ay49Tdiel9etHmJ
         vLNkAlTQi7KwCVFN5I0iS05q67kgbZ0Ze4p5jhcYYKh764IotGGK2dGLFilXeE4rU2wr
         yOJAEVOZoScc94QQarpxVG+LLnW1VE/0kDUW2yVIQauvQ0G1KHXywh4r9Vm69RmfJYZw
         jBFipQe/TWnpGh4ch7KBPDvG4WmJx2PmkfDnwoMe7kuiLhXn+99iRu7YEUl7+mRQmpFr
         CtxA==
X-Forwarded-Encrypted: i=1; AKwUvBxAWgJnV6lFyfZ7P2T67nEmUO+roXQfOpGjp4dvrIDbCuShj0wM8mztzC3NwK5iniy3G5/eLT6hAKTDy2lzEA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKvp7ARxEpC6QbXcJT5r8GCf8YRuOOF1sOuZz2rdYle97d9ZdqL
	MXdONVqHcz78ZEUkFMjErWdgN5fPSe/Q9xIj72JOMW0V2MJAeIpwLd9x
X-Gm-Gg: AYBFou0Zs4OK5ntQNviQhTBO1+VYaaESttYzOPsvCz/+mYem/MMbqnhz7/gBPhULqon
	+IWkMEJ0JwwclMyvdaNv0AEio7VM5V2QyhJgNtvxul/huU8/E9Jtts4dgGSHM9xZhxUzSbytKW1
	GSACV9JJ7hiXL2xeqTBi5GZELiFaBH3SM8ivPXNDdiwi7scbraqcKWwLuVmsfuAFy0hO03Sprh7
	R4tFWpXzOjIRQMBSqUJ3uyvMKDJp8jF/ZqwKhgQprpGxvdoHLxz9Ebc54Kp4tVdiyBOQtIMtezA
	r3/hIpXKRph8EQI0MlBKyzfLhGMeRb29A0RrE2/3dl/I5oTpbdRV+Vq0l95xNYs61R+4Ecq14x/
	V5SvJB/DsdGWfM+qBilaRE1OyDnsNDAWkl/huNF1mGfhpQe1PznE8RA/rooc8sv1ojIhtRnDB9W
	+z7ZW8dvCSW5ZjHMz47qR/RGDEHXZy4flD/7CGMRGmA4O7wOKtMMZPxLdKP468bQ5iQ1Z1blg7E
	5w6ZDi7Wp6jiLo354IJ6kbFev03yruxwWmDbG5/GIgDhhtRDUsojN7CqUOTapR2EP1rzp19QBn3
	klqAU4bqq76CU+t875rJU3+cd1NurT4C3OLjDfbg1Sw/F9E0n9GRV+3KBRKHy3jdU4VkcUkH7vK
	sD3grnSYLPWdro3/qtAMVN+C1kcqJft8Y
X-Received: by 2002:a05:6808:5392:b0:4c0:12f3:6007 with SMTP id 5614622812f47-53cc22e2b13mr2397740b6e.4.1792266385605;
        Sat, 17 Oct 2026 12:46:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388dd8b5a2sm4025321b6e.12.2026.10.17.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:46:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 17 Oct 2026 13:46:03 -0600
Subject: [PATCH v9 08/18] mtd: rawnand: sunxi: preserve synthesized
 zero-pattern data and OOB
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-8-b624c09e3ee5@gmail.com>
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
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>
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
index 22cc8998d49c..82af3ccad885 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1231,8 +1231,9 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
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

