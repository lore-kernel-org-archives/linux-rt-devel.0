Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904937;
	b=1bYyZTyMHQgWvilyHFxuq6Iu3XCwdz4FXrgtSpAk0qiczxZEJVV150D6RuhpHrXCG1n6
	 jqhmTCssd2R61YgDqeG5QR3G6Owud3P8FUfQ/COtR9ib/HKFdtcYGZrJbEEl/+g/OcjxV
	 AbcVwycnuYBAXTefXNsuVL13dLpW5F5a42zlsvDUQ1ybwFGYwaR2/mc3bW+824YDvqhef
	 E0t8GMWU1QrSDYOY5Y1kIBcT56Hbq158+NdMp9NVfglj3qs+EM3cJiGF0t+MiY756rN7M
	 CO+09zQPwBR70On7Um6ceHW/uERx4v/zYSqnxMLgPhqRpniTXG/0KVZM3KNBVacBaEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3diKjpt3Hplj9bun3k4VWxlSuPRXvr0bzFEfcX1wVKA=;
	b=faBLEV2uZlybLokABQIZ919mKHIiDOVMa8NQ9IGMYmRA44ihbAHmZgIMSStG8sUJ+Oev
	 0mDR9FxBbEnXaHN+9slNkD32KbnACoFRJB6XRRLSQkVZaoK2CMzdW3caJh7nVHk6CKbHG
	 VVZBnMqudF7XVdhxoQQwahG0/CPiu68gp4jyjtSCvibDvJXmnJTkxr0p2EYqKv6fi2nzY
	 e+EHo6zeFedSs2Td40tePJhwxTjdREa4clTt+Dq+yyC3B6dEwZMltPQJTK+SpVK831tdb
	 CYRhiOLAhA7Y1ed617/KGxbNEumYw7W2ziO/V7o/AF8RN1xltMtHLnwIj+2Y9uyVSkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCrfKKod;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048E606A31B
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C048E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCrfKKod
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-703be215729so1031786eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904936; x=1794509736; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3diKjpt3Hplj9bun3k4VWxlSuPRXvr0bzFEfcX1wVKA=;
        b=tCrfKKod4VfzUiFz3JbY2ZmVXQJcOHZYSDyOh+Ud7QHp5CteWXLGuOi1o171eqDFM1
         8dP6NXqOh+v9OrWjM9vaUr5bdBwTt4/3j0b2dAqfNYocE0bZ0bzZ9+L4GToMt+ntF2rC
         tdRc+Z5pmMwHcqD1as1jtQ1wIIg1vnagmVPQ3lQJYgcHWvNpl8aDTbcDTLiW4oq0JGY8
         Z+czamxHriSexWJqV5zXzkuFRPM449C6CohBPa/XpUDvhG+cKecHjq3FV5SJ9FFSaokA
         u6uFj9CwUDLe2Wd1vZ3+nZYc4Rv4avcizf/lD6Y2NHkuZPmMkEmrBbwP9MzRljnEmVMe
         oJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904936; x=1794509736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3diKjpt3Hplj9bun3k4VWxlSuPRXvr0bzFEfcX1wVKA=;
        b=eF3IIHk8Y+NfJfLlAlVL1zlsUphlIJ+iKq5i03huRbWUb0/4cpA6Eh7FYfT5MCwxxZ
         LjMYG3gtgJMJzmJXhfNjDsbQZNBtVT0/M3RZCMRZ3P6ey3kpDNmSr63O8L0OE1oIroZl
         DXWGvqpI65nFSHlZrpzWBBarraYCWj4nRGpx3fLhQ/Q1bvLVk7eq945fNwzsE/d26o4M
         SMo4V3ciDNMF8Cw8DOefj8xEvrMIfoYeOtNmy7mL5MmHnuTQPO7oFHCdkRnss6Tnn5vx
         4Cgnn+62iXgYu8bJRrrVCBOYVuOV0t49daHdKE8OFk/w1Nn2Y4JfR5+8BPgZorG9F0JT
         MYKg==
X-Forwarded-Encrypted: i=1; AKwUvBzTyT6YEcYNZUCByJAaLhT3jpXUxyox0Ogij4SbWyXNClWWKMogQU0e9okvscRuwzboXf2M/ymQ2rHIdO2lNQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/roZCcS+nV/HZSGAKGr0p07ld5C9qnBHzEIKG2/oPyJfN1qnmf
	e8IkX6x7XK+rLLDYZSqYLJjulmWBseWXktmGNmeY1b5gGJAGmfj5rwPi
X-Gm-Gg: AYBFou02kLMQDSs7sT5ngZnM8BHCaJmhuJ3qXfwkbK7FjNgFwKJT1YXv+Gigv2ou703
	UZbwdMEmSqpHIbOC/rdc2Rk5/56VLSedNx2NgK7+kZufhKbM3TTRu/YS+TPUkZlQovVFCsxLAW5
	2UZxWIt+DUVMAZPSFzRkMBLZc4DoQwHd+V4MJiW/9rpZZc5EuMcyhG8nJ+ph5DW1UzYtelf4z1u
	Uk1GdmYsoQ0lJ2gGKpKxDr7/lmqBwu6pw5EWkWuXehWvPpSgtGsi1sIa2fnfJEiO/TFX/d93GOt
	quDLa0zVNUKR3z9GPEEIGSBwgHwQ1DIQAQnwbmXnYZS/rrmMC2fgqFQA/HJp2mhG+4Qav6jcVwn
	Kte33Lf35YNbKLosiU/5Tw7xMZMaQQ/AKJw8n60yF+2D5AhtyDm3UgDNDfx9d1JdZV62WEs4pYc
	4Ktoy70Q5az/dJi19+SPEWs0KPDTg7jcF+kRhao+jEpR6TsCqN5Pexn7jW3hQ1S90kg/VTBC0Mq
	dfFQZWlX5JCeav9FvmzSbhQ5f0P7DeMIuRt9sVKFpge+30v2vi8TZpugcpSPHqxS5mXP6LL+Z24
	jCH1lAZhxfsEqGmH73D8UEJhP8SivY7GYEQhUcTHoEYBEGcVtfW0UafDnHASLSiH96fokk8xBbg
	PfWC+HfbSzXFwrHLyHInww5rZ3d/Rsmj1X02ZExGN91b0t25JLJ0RYAwHurrD2z3cBctiCinQBS
	90cR/TBdp4SUeIyigNVcsY7/0mIlMBS4iqtHjsuOOTF7eRW88YdpqH
X-Received: by 2002:a05:6820:7408:b0:6d9:8a4a:7114 with SMTP id 006d021491bc7-716e790c5fdmr232093eaf.48.1793904935633;
        Thu, 05 Nov 2026 10:55:35 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:34 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:20 -0700
Subject: [PATCH v10 04/26] mtd: rawnand: sunxi: reject pages exceeding the
 ECC step limit
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-4-dca1f6ed29a8@gmail.com>
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

The controller has 16 ECC status slots on A10/A23 and 32 on H6/H616.
Hardware-ECC setup checks the strength and available OOB space, but does
not check that the page fits those slots. NAND identification can supply
a larger page size, and the NAND core does not enforce this
controller-specific limit.

If enough OOB space is available, an unsupported geometry can pass attach
and reach DMA code that indexes status and user-data registers by ECC
step. H6/H616 also represent enabled data blocks with a 32-bit mask. The
number of steps must fit the controller even when their user data fits
the register bank.

Reject excessive step counts before allocating user-data lengths or
installing the hardware-ECC callbacks. Check the final step size, after
strength maximization and the conversion from 512-byte to 1-KiB steps,
so valid geometries retain their existing layout. This also keeps PIO
fallback from accepting a page that the controller cannot handle.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-173724@kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 662d96fc2535..1a61f608ad91 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2223,6 +2223,11 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	ecc->bytes = ALIGN(ecc->bytes, 2);
 
 	nsectors = mtd->writesize / ecc->size;
+	if (nsectors > nfc->caps->max_ecc_steps) {
+		dev_err(nfc->dev, "unsupported number of ECC steps: %d (max %u)\n",
+			nsectors, nfc->caps->max_ecc_steps);
+		return -EINVAL;
+	}
 
 	ret = sunxi_nand->oob_ops->init_user_data(nand, nsectors);
 	if (ret)

-- 
2.53.0

