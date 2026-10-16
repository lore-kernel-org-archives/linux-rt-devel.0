Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D73B19A5
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122343; cv=none; b=DpLOXCKgX0doJaDaYNooIVeYdzG71CZ9yj372M8KbnQ8V/atCbbYUjxekR+bPMu+dMPJuSlv0Vx7XrhU8EKAMHvZ5P1QZrDnpkJAuoLvTEML5GTCjwA2Dzj5/zzurPshQFAtCNZbMM3sJgVRANdYnPKnC0tx65L8Uz8cqluZhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122343; c=relaxed/simple;
	bh=H5TfgRr2Bv5tbABipMunxtVTh9+p1lSGxQCm++Vk00I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXZTG8FvMbSdcOXFB4wPZbZ1PGaO313HgD67zaozUUVVWS0/BFGpEWI8K9D4ARY7bpHkCvzIyfLohKy6zs7X3/PyU5ZW8GxeXq05GqU/JyLCQoAXBnW5BrJKxmQq5x2ZeR/0ggsWvU2Ko2zg279TGWAc6AbQIdzLXcbNpikd1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeOsXU1e; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeOsXU1e"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-833e671ee9fso4328544a34.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122339; x=1792727139; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+uyWszwAFvFc8JbK1nSE8GaRzk3E1Kb/gXy0IKu03o=;
        b=qeOsXU1eJDEYBy5tDXm0y5PlG+CY3MG9GoXxylyVe74nEkml8ZQNPlT23n3iZSnCFj
         ND4cyxZkkY0SzPL8LVbSa6+2u5fFaDOfCj/ofNj5tXq6BrtRCdTJK9A+sAjOrJtAX7Bu
         XLJyRY7NhuemNhwqe0AJMwkaublHQznQk1sSM+6dn67esCyvxjOvMR64Exak/d4ly9q4
         Ca2eIpA/XuhcuiNrpJFe9bJVT9OXuoxpEwvfFTqGIwLGqpOkEIwAMUb43k+b1FkT58vO
         b+g63ZmrGxT+apTE8ytgaiqxweA8YVQBAzHxyPEIB+DlKNqQQevCJrnzXocjjTjEdAv2
         AA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122339; x=1792727139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+uyWszwAFvFc8JbK1nSE8GaRzk3E1Kb/gXy0IKu03o=;
        b=NujzmGq/4UnigNF7z4SUdCYRjxDaVvgzDyYPaPrBfz3MTLvPNgfHnmI64KemWOGx+w
         mPp5XXLa8caT/nQ9OhEgBL0QoRM6iIw7OoNS4gb3numt2fVOqxLuilXxh7TNo16wSJyG
         ALU2dfcsDzmcuQ//47NTzWmTnbb138S7wuf3AB37Rbk6p2MkbwsBEUUgxhENv0XrS6IW
         3gugmWLKJXu1eVSUn214R6F2jxdFRPurfKCAqgkqwuV1Z1bcfaQlYfzSs0SizG3diFl+
         RhJVw/Tdn0iNSh/CqL76JryvAeTFjzTmfSzSoeTQbAOyoswJbzLlLWbkTWdDFk7MAx+u
         u8Rw==
X-Forwarded-Encrypted: i=1; AKwUvBwoobPWbsQ7c5o5ykUDrhba+OlchANjvoqMlvZe6nXBdNdpHf8a51q/mvZATKfmVIou8m9OTFqE6Wpy5BwbtA==@lists.linux.dev
X-Gm-Message-State: AFq9FYITyd2/DVZwLrcj5JsaNlfPuDAy/jYm17mehFpgjj0Jqh3kwQJI
	jyv9uXysKpvBOrQoCFZK1qrFQ82Qkv1hV/vogkBLDQHOCf1KiBiSFlsM
X-Gm-Gg: AYBFou3OzSPSyYTz7boTztaEIdkEUFWWgXcyNrQYDLGBST+C9oYT6599jUCrSZtNSdU
	4ysXBh2Q7IjOe8j6XmkN/DlySZk+C31mlq2cIF9pQpgn9IBUtYErc2rTIre+M1s0TK24J9Be4/+
	E4SQlFtyyV0yNaOkQNKL9nhaC45kRpcrAMwnvLVnkEWeggYqCIRvf+hm4ilLp/21/I7ECRkj2c3
	5sUjnX/dCfXKxJYGQpvcqAJuiLmSx9RVNa8pg3HvmdgQsK8dr0upCfx6AeSERip2U88QctO4w70
	/m8IWXzsq5HE1Vm4kVkKP+nWD2N5akEmY764AZAXwAv/5Pn9WC8snfP3BsU4u9fdhkOYI/gC1xN
	xaNqxOIM+GqQM3vdo1ZlniIjOthnCV1oiIgtsATh46ZW5LHykuZC14ClFd0DnYtbFj4QAJTV8ii
	8lAe1VmVLYFCvnT9LSo6fnDSiCUEG6lh9GvWYHkYBKSneg7k7qE3ptxKn5U2NX0MRFQObOXx/Ev
	biAml9vtCsuw2enNsoU9hZZz39SPDMyR89eiby5W88eW6umB5A4tm7HIwRdf1ANNh6IZ/chT6M+
	ZIQtxgXL3lBkfs5suyxdb9yikCUlMWquLoxQIVesQyBXB6RUPm1cWpL6ueXi7OOm5qF8PddN+ao
	tGY8ZXqcY+yd0OgW9gwqY3KeViBuNi11Qzw==
X-Received: by 2002:a05:6830:82b9:b0:822:27d6:c281 with SMTP id 46e09a7af769-83094f728ebmr20703536a34.8.1792122338629;
        Thu, 15 Oct 2026 20:45:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm834402a34.0.2026.10.15.20.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 21:45:22 -0600
Subject: [PATCH v8 07/17] mtd: rawnand: sunxi: preserve synthesized
 zero-pattern data and OOB
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-7-8ba4881fbee8@gmail.com>
References: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com>
In-Reply-To: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com>
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
index 661ced4e07de..a244d2158d76 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1219,8 +1219,9 @@ static int sunxi_nfc_oob_read_batch(struct nand_chip *nand,
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

