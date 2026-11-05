Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904967;
	b=bYYp9lVMZ3VazGIrQ/EAuN7z17WGgZ0a9/TsTNFaUOYxydRod9iHLw26BljVE3OE1lua
	 NQYaeJGuKR6WsfnhilzQafrvy4qAkFWOz38UzAFHaH2d/kmgsGb4427+dQGf/5b+Uj6Vd
	 AbbWn7L8zDEnfywZlDf+hYXo1U8kiPGiGlF86wuubonFppK3JtfPpOyg/Lr6wJ+9hvuu9
	 jkGqteHe85yBGD54d7zqVEUlnf9MkgovgdRusurM8Lz0efNSN3SSZPhOfa5IYe+2lXmPg
	 Rk0WByonh5670lrop0u7U/k75N6b6rSnpF4+aPnj36jVi0pMCDnQM2fvBg2sFQD+5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=F8PJ7Wj/MurY/COKSMskXdHgUwbyiv0TEDO/uX+R0bU=;
	b=k0ACNN45GAWqWbrh99hztg/dC/ajVFhC7Ak/ejW18+LIxBhlowpc6xUsJfQzETu9oX3Q
	 0ntMhsKTAUsv02yu+ekX8Fd4ZDT3ZwdnTzvhsVWJ4dIWc+QXOCrX9PaZzQo9BjxVpwtOl
	 sROLtAxIMJ7VUjpwplgEg50hHk9Ph6GbOGdgmEUpw8te6CUWRDIBnunSe7qdwgtfTYq9D
	 Jtf8xAE11tREunz8iT24b2P3y5VaBNOBL/PeFq/Y3xtkI5tUtgn3Htkvde9OS7WwnfzeU
	 F7OHlierefvpXVza7U9ll6xXgDxs5umytGipy45ML8Nv9p3ZMA1AlUuu1yazmEVoGaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ePbfsBne;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739F606D822
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1739F606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ePbfsBne
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6f8a519e215so1084576eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904966; x=1794509766; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8PJ7Wj/MurY/COKSMskXdHgUwbyiv0TEDO/uX+R0bU=;
        b=ePbfsBneSS7MF2ambGNIoEm+8UHP+fFAHXDCZzy43alE3/ICmiCHflZQ1EinMrYiXN
         2xo8XkFVpXBkpJD2bcUJ72i+w0Hjz2do/ueu0rhrLr5F6yPUAezcva3XfzWCt8BV+j8D
         ah/qojfXyAsVLAAZqZsSeEci7XCOjjt9pPdD3Gn+pqwwfbWQPpcs/mHRpXZQZGGT+yvF
         6xtdcyAjY1WEaBVTYpXdh2T2zMdrEo2VgUi8tBpaqshzRiC+n/YPTPuQCwiVZ/GVJ4WO
         Tflu74lTY1ydGkONd2KRzU2627k2Wjfs0r9DE2XTQAb2RUtid7rSvygAS1YOVPDm/fP6
         sPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904966; x=1794509766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8PJ7Wj/MurY/COKSMskXdHgUwbyiv0TEDO/uX+R0bU=;
        b=wnBNoyAXPdvPAgLGn4Ey9WU6/jC8v8Wc4zCZKjDxvjCC4AYzt2hftRtaeHJdxsVPZH
         DdgmjjQj4w1rjfrkh3owAEf+NdTvZFsAcgxBfd0SdWjehI5qtqt+CSbl9F7u0eML1iy+
         rhreDUwaWAXYVwVkWyB2RvYCO2R//Ds/obydWWCd4jf5pql4zwiBqHQQ38Ho1R3ru9hE
         vmiAIoxoiYSD062ppiZi9EM8VhAvVeJrODjEf6G6pPj8kCRPmRgmHId20BuAw6VGud9Q
         DT389pYPTWWA+j86PZSJp2vm/R75H5EAm31H5ba++BuM6FfuQz7Yk6sRUkeRllTZnbGQ
         wOnQ==
X-Forwarded-Encrypted: i=1; AKwUvByYl8sK3ym6ZwWEPx8PmJpS03NxH9WFuW88D/NtFIQ3qA4NCBEQKks3q9w0FSFf2LffTqqhh432Nl42lw33GA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8tOH9vG6uwvAzMfR/MrpdND4pjCeQ5ViLhFvoeCwk3ChvlLSUN
	hYG2kYePIxGWSA38pK9LdRfJFaeeh08uPPu0FTCMi4japqfYxh7yTec/
X-Gm-Gg: AYBFou0Vld3hh1mZRa8Q4hL42hDUPGFVW6VCUr5Od55UoRm+8SLuRlUbmF9qDAMQd6k
	ykQxA3VHXYwzHZTfrOq0l0gm7KCIty9sYdDLe7q3QRZ2nMA/TJ7ewekUj/dPwiy3CWwed75/u7r
	Xp2pb1SgReQpPM0iAx1yUM5mrRwObMfpmopslAOzjVECJHjwhrExk1TUzDLbkk7yv5z6pKJ6WxY
	VaXHqxzlct9yUMmoc7sTwx/olyPfBxHGrNPXvVZB6y6LfQN3SSdhKWmPI6FyMA2AjMN8ookPo9D
	bCeEpcvu3n0yZBXwqCTUTlN/Bmten6HL6uIs4hjFF69xulNn+AUQl/+RzMjcKbQXri66euQKl2t
	Bv9mT4QgrxH5ecPy8ffp2gbE85LL7zaJZphEdis7jvoGF+Q/uxLc4oiDuZ40kMP3rcRHuyDddLb
	vHLEEUxP10Mnal8aUJQ+zZbowLZKRNMSHJ5HjT84rJAcrUJu9wJ4Vqcm/yKFwKrJEfJHC71see+
	HHefRUAPyA55OOR8Z+AWyVoTZJskBb/BJACyKXktUUFDor2CMZQ/Xru913++AtFa33hM89+FuQi
	usGxJXnUbbmL+QkAnS3eNAnNkyU9zuRD3STpchGDyR5Ze4y48ikXedrolXE8V+fUE0ub2i7UMAh
	U0n2l9xBdeTRGELDqrMNFE4ZqPBEI079uSlc+keySo7vCzWz9Ejf7DP1RIUHeVFZpZQCP6JN1xP
	FUuKHpCDmcVIFr1HeOyH12by0GaixSLKF9Fj2kYRTmIDKktfNSPH7vClFFOpSIOdG2Te8bPv+xR
	g==
X-Received: by 2002:a05:6820:151b:b0:716:e9e0:543f with SMTP id 006d021491bc7-716e9e05899mr67251eaf.11.1793904965992;
        Thu, 05 Nov 2026 10:56:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:56:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:39 -0700
Subject: [PATCH v10 23/26] mtd: rawnand: sunxi: avoid redundant column
 changes for extra OOB
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-23-dca1f6ed29a8@gmail.com>
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

Extra OOB is the spare-area tail after the last ECC step's protected
user data and parity. The PIO write loop tracks cur_off as an absolute
NAND column, starting at zero in the main-data area. The extra-OOB
helper instead compares it with an offset relative to the OOB start. It
therefore requests a column change even when the last step has already
reached the tail.

Add mtd->writesize to the comparison, as the read helper already does.
The comparison and the column-change command then refer to the same
byte. Keep the command when the cursor differs or is unknown, including
the DMA path, which passes no cursor. No transferred data or OOB layout
changes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 11fdc10c7f14..c9135c8abf54 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1718,7 +1718,7 @@ static int sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
 	if (len <= 0)
 		return 0;
 
-	if (!cur_off || *cur_off != offset) {
+	if (!cur_off || *cur_off != (offset + mtd->writesize)) {
 		ret = nand_change_write_column_op(nand, offset + mtd->writesize,
 						  NULL, 0, false);
 		if (ret)

-- 
2.53.0

