Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904969;
	b=NI/1+PhyP8ruP2mN3nH28iD4oxb8q2Tnp8js1y9vGlao3Hxf3pVcvJFs/MNyUeu2DL46
	 cqsd3PbgRZyhDw6g2okD3PeZJMgOi0/nt5xMEwd0SSib9yLMJxnvv7lfWR+nSIEvuRkbg
	 6PoMIvkk/h64Mo/8s8cddELFPfoFTePi4375e91bV5vpjHE6xsZndWqcDiWQxBF1PHJ5O
	 lEuG86+/KYhGbGmZJf+TC745hWfHQEqrS4c7tOjPQzsB2gUSn6POBJzBzCZXU2nKcIUu8
	 gFZHNmQTZwqlQvI+g2IGbTQpN6Z/1bAxCAko/I3tpWF6o+k0muFeaY90UnY8CnZocYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=KWxxvC68veJE9vLqTWwy/EexVQuI9OEnPBoyBsJoQls=;
	b=N31+Tl1jXGh0DzpfjBxdaJ+cLNne+UTEBt6RUFTaKrsomlSRIIOaoH7M1VAOEIm0p8BA
	 hOBSy6qAwRYVZth6M44YQMyUSF+bJ4TcMrefhzE8DKoUCRIc01rS5/OLggTcDuR3qROj+
	 mpGIUQBFZ7bXfxysiQpojIPwIdB4zz93wIYiNoO+04rFX9xMeFsd+7gm8xyHZXm21KKEk
	 meETE2xblZnRwszX6IsMlnyWWmyejqBdZxjLc+wiyThdDfFCRuvkOt3P7XwuIPBKR6Cav
	 NWNfvOs5ZuKJkzM/joNsjHwAzAtix1ft5fURlAK+Woz3ZllOWuur7YyLG7hbBMvfhCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrhoRe3x;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDF60A261F
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DDDF60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrhoRe3x
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-705cb6ceebaso1493790eaf.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904968; x=1794509768; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWxxvC68veJE9vLqTWwy/EexVQuI9OEnPBoyBsJoQls=;
        b=rrhoRe3xHyLEH79PBGX5xQiaaMGyNqL4RFnSvz/cVpflO1VAKVJXIgy1QJYyEKKvLr
         Ehu+teISzIeG1fe3nm1aCk+iRYtMXAZkUuYTujCjp1hVq2pXEf2aEDVIi953q352XioN
         7z3StCggsPamR6Npeiqj08eVt+J7iRsuQZ3Po34eg7/gEIyivO+HIQ8MWYPDD41ZHdVm
         cmzuYPk6WAjD/j+s0zd2nWZsKCsubKHfSh+KgOhldry0NJkaOi9DzcZngN6NM58afHG1
         Tvyna5EaIK9vttmTyWxOgkxti0bkz9T7nUNs8fDiu4VGKoKwna7Pam63D5qzH7lJ3dwg
         QQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904968; x=1794509768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KWxxvC68veJE9vLqTWwy/EexVQuI9OEnPBoyBsJoQls=;
        b=kZ6oBXXzBHVy3uK+fsOooECG+ypO9UU7FpRbJpLVWQvpFTkkZO/AHXVlAKU5s6sYJp
         +uYk3SDPmVlZG51ZEpoSzbufwmvklFvXhi1R3DCaBueF8SNc95f4QZ9q7BdExaBfo9qU
         phctca2FjMUtQoGoO2u4W/hsDYu72F8kmTKF5lcLwT8kjWA4BVY+BYEdBwl+VBerEatv
         g6C579pcTbKv2vIHhduopGEp5bhnxmS4XAQQeGRAjZdhogJsbV5vkFo7Zr7c+5PhRNaQ
         lRQdiE7x8sWENf++7gev87NSfEOtLQUR5+XTXAf1+HvBOuqinP6QPjfuFPeWmZ8toZvq
         0JeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/+Cuddu0aXjQK5ERHZvH5PjxTTNT3XMAHlLgQBDhrEh5v8wIJTefvHo3LPKNQfCaG4tljZlRLRv5SQUmnXQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8WVwUZEWA2eok+Q1VqdsbHMuVHtU+OrFnMfXZfkpek+cTyYnAA
	cfrrmzFbZznHTaM89jOMdv4Ypvt6XQH/ufEUyVEw69MXxfrwXes0HFJ7
X-Gm-Gg: AYBFou2T8r2HG3C2kzRu6Cd/ZTfgRpcp2cD8AZauEbcvFqhZEKPjF0br5p5sTsyBexh
	az3SwV2QY3CFtp+QV05xmRjPkLQHKOMQoH5YOKGgtfy8iODk/jUuI3oTD0kjZp1Alc+zNoTJSYb
	dxTgKE7sxnH9ZCGsQaz77kWzNsFguwJBFWzO6u2wPnPYiUoqGicfLFopn+eQ+WXJIPswtQf+LZz
	lTV0pv8sDMeI/n9w5cOZkBU9S88U7QBlmJBOo/GlcGXKSYKxax6GbcWtzjLliQW4f7gGFQfpgxv
	9dvgs7YHFoSDUyVKGki8Gytav5Wf9Sp/xdrgQ1pMKjVtNIrDpdgMasqxy3lYQn68lnj2GRl9Mj4
	qaIbgz4dQbvziE27HfVz9Jo0uJ+yFCXpDhiSNI5LUpNb3nIOwCNsXXqQrEYpBYizOUYMvVtqsBF
	QWRiYVqKYTi2KrQ9biq/T6PlLtOnJ3ZJtTAJV9cgsBCcPNkU2zNhrdsi36Ir/EDXHKbIFLMkd7k
	DYXBTSBRlrCAFNo7h/hGjJJk+ztPjzPoDBp8Zp9jyFn7T9jo29XcKn2sI7xljCMxK2sOP0o9Z+8
	AtLSlrAts2MAw+MhbKgCGDoTDeUtEVjAFR9E/cecR8TpzmZks6vof6SiRFSt3zfwt7mCBI4B9QK
	5BWmsOr/zvYqomLyvJ9XC49gQxH3TtPTURWhet+4GMU8WKnF4MJsZmwXCKkwdbWD59c5jBWopo0
	+3F8JdcUZJP2S4+za3/bNDl8On5lGY5sae2SAVhbgrloZoj2TkixLk
X-Received: by 2002:a05:6820:16a9:b0:6f6:3762:5f9c with SMTP id 006d021491bc7-716e73de6d9mr410801eaf.11.1793904968458;
        Thu, 05 Nov 2026 10:56:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:56:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:41 -0700
Subject: [PATCH v10 25/26] dt-bindings: mtd: sunxi: Add randomized OOB flag
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-25-dca1f6ed29a8@gmail.com>
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
 devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2

Allwinner NAND firmware writes the bad-block marker as part of the
controller's randomizer stream. The mainline driver compensates those
two bytes so that the physical marker instead remains plain, even when
the rest of the page is scrambled. On H6/H616, the firmware also places
a fixed amount of ECC-protected user data before the first parity
region, whereas mainline distributes available OOB space among the ECC
steps.

Add an opt-in property selecting that firmware page format for the
configured controller hardware-ECC geometry. It identifies how existing
flash contents must be interpreted, rather than changing the format of
all NAND attached to a controller compatible. Without it, retain the
mainline marker representation and protected-OOB placement.

The property applies to normal ECC transfers. Raw operations still
bypass ECC and randomization and expose physical main and OOB bytes,
including the physical randomized marker.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index ccf616fabc91..4ed99054a8ab 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -79,6 +79,16 @@ patternProperties:
           minimum: 0
           maximum: 1
 
+      allwinner,randomized-oob:
+        type: boolean
+        description:
+          Select the normal-page format used by Allwinner NAND firmware for
+          the configured controller hardware-ECC geometry. Normal page
+          transfers use the controller randomizer, the bad block marker remains
+          in its data stream instead of being compensated to stay plain on
+          flash, and protected user data uses the controller-specific placement
+          expected by the firmware.
+
     unevaluatedProperties: false
 
 required:

-- 
2.53.0

