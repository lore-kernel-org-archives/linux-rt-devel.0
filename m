Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223492;
	b=mHMjxaDifq2/QWNMnuxSOhOik5IfSzA4l5ck7DnxOSvWb+okh4JpGUi6ZKHC5Tt2w2ei
	 rCFelRKb4XT4yoQruvJCh5yQba5ZP3ezFapOL+HddJ8j3R/OrosBguH1hLjxp0sngGs9o
	 AfTkvPNPMVLGE84+KkGGuBXK4YfyTnWFCleBUSlcu3Dfc2rrsslylnV8WN2cx5ViaUmoP
	 KFnW9b93XIzwv0VXXmwC7DQ7MAjvhzfAExAaAx2xzyq1W4DmtozZ6yOh324h6SSJxbaZJ
	 wbN0vE3DdQwyzktX4fnJQ1YAB371cAhVEoWsajEmU+yVq8irgJ5Q4HjNc063UiFj5EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8wmwptSly1/jnXieQYc5MDUwaGqVqpFqBShPCzacVyA=;
	b=QRWfCc47aEk91RmE3eRcXy4O4zJUNHekyYTOW14pmMxLjjnIcH03zfdZKObq/g/xCBXI
	 w2mgNmlIs4iXaBNmQiZKJMqJzLv3ocj7W3Lb6MTN2R3EZXIwAWFYMaBwB54Wx96EdSXjs
	 +rDHzWdG6jgT/OdOP23h+mIgv6OSgNao09C2OWt/Au+nztobIYUQ8AQ8B/sdtMftGWcpn
	 bOFfVkbwWfYu3vgJODiKOeWTDHZdAyydXNbnMar5AQzetV/Aw10Z3Glcg4dMcEW9TASMf
	 sKkum6kmGOxFyYPh1A6tsoOpNP3xGwrINBj9PXTnANWPnEelrP4EZx+dj5eYfC2H+yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRFXLhvY;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB562606AA04
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB562606AA04
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRFXLhvY
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-862b090e3c3so855399a34.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223488; x=1795828288; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wmwptSly1/jnXieQYc5MDUwaGqVqpFqBShPCzacVyA=;
        b=oRFXLhvYkpJHHWopAfhW6I2PVzmZrjGr6MmnClk0OaD04hxy5uo5fyDN1dFHzbTtOs
         HY1f34bHm/7Eyq+SR2R9s5IR7eC53O9RCbPEuIzkKSQVOtgHd6frcY/1FIaMTVY+954v
         TLl5NM8+6MmlWEge+ifoauuw4LDFw4Doc/buWDxL7/ADUJ9qu8zLqJY/HSpdaMg+HLdv
         0gkdoKocANCwp3ELflQG+iuBlU7z6+Z9i5927yss+Y4bFngF2Ow9R5Z/rVPzqqKxC7wc
         4FaCJUVy41GjBI6scYpOAERSMhLyOKg5AH6SWQf/UJxu7IZeb3ncHrxKZQqV/poFOTZj
         9oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223488; x=1795828288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wmwptSly1/jnXieQYc5MDUwaGqVqpFqBShPCzacVyA=;
        b=2ArnFD/NIqjCa4Bne++fSaIKclAVhuvox8AJSU2bhdreJ//Eg90HN3NAm7Ujvbw90P
         hR/LZ8rI/yDogpDNBos3Yk91QjC1auysWLgZmb8YKWromXD/WcE0uFBvOwQ7eQ76BLz0
         J7QDI0tiYgQT5TBf4+laqy4f5QykJ5Wmpgwa/NDCv1bZzNGmNPiEjaoBgtBKuo3o/for
         yjaf41Y+HCCXEcvRNRi8z7bjHNr3s9rdEbkZV4/Au4hKC/E/w0lG7K50V+2PO6m+UkXI
         y7nKw3Yk5ZU4Z/zDEhokQHBSrr6Ei4Duki9ioe5RUzRujXiVBm4ijz/yRQm3Wmdl9ls7
         6NfA==
X-Forwarded-Encrypted: i=1; AL+hErEBrvhvYCZfqrnVvaBGBhoK7PBG8VDt67jAnoM+cUplpXjNkUTKTRbjxW0k0QQV7n8DufEeQXRQzVaHluVIzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z92w/pojMoqOf5CroKIrGwxa7U0JXyXhKBABpdc70HGq4b9aby4
	Hfg+LRQu6SiVJLteA+glKV4wUwVrCs9qBEUPqmlaPfSESXsPu28Ywns2
X-Gm-Gg: AYBFou1FxaZii0h6jt+XywLloN1GCUxcZiRSWuqjWY9kmQ26DeBS3YLbemSrZa/MNej
	syfBdimMKp9hGPaxU1YH6kNcjKkEbTbdt/+R6Z+C7NzQiLxmrtAAEL64aBSCSiqxTg+ndhYyuuU
	bERJIbWtD2SPW5hNkBq6rWwz9joL68CdMSgduOTQULRMsTQaQAyRqBdHWKFcJo+ICmgZ1BJDUEd
	y238iP8YZWsb9+oz6TNcFbaudm64K7d3CQsdV5fJa99vOn26jt/V2xIk78wycmt2N8yYnznh4cU
	gtLSzSl8MubeoRPTY+OpoKu2ufTTmFhjzXFApvU4d6IjJkW9apVcyzgeh7OILoNQ1sNF3AbFELb
	3H2dQRF5cxnaYxGWZdPSXuAimWjAvTVoCmbPFI1uaDzZwhO+KzMO+AkerlTw9F1jDhPnMXqTvDF
	pMhBySReswufqsS0Qz8V4Gn/xFdd0udhikjONNmkHIXUQAHoQ6kOwAnp0ZoU/B3G0Yev4+di9QG
	MzbSKgBTSanAKse/5IRQIkZzr5SjEQ4ht5Ep4DIDV1kT2Jd5CbGph0h3dYDVEWNT+LHzLU1g2bi
	JWKEKFd9Vu3sjWh/qDvNqfHFCPjQrb8+R2c5O2om5wKuBz1o6aiZWkMsCVXpAAn+66krgsErb8z
	ilWP+cNrXApq6y5oImIwfS7YbM7l2B1jD8BspwLBMNzp/nkKMPDOQd/StHs8+dnhrofr2RZ0CvQ
	4Eb58MpmnrwCneWmxCuXYaFE21He8vFuJXycsXb2V/1rW8KEL0RKA1
X-Received: by 2002:a05:6808:2220:b0:572:e8eb:36a6 with SMTP id 5614622812f47-57a0bc9d273mr5655190b6e.56.1795223487680;
        Fri, 20 Nov 2026 17:11:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:46 -0700
Subject: [PATCH v11 23/26] dt-bindings: mtd: sunxi: require the H616 AHB
 reset
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-23-9721b1905ef4@gmail.com>
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
 devicetree@vger.kernel.org
X-Mailer: b4 0.17-dev

Normal NAND reads and writes worked on H616. Fault injection exposed a
failure when recovering from an aborted internal DMA transfer: the
controller's soft reset could leave the first subsequent read displaced,
sometimes without an ECC error. This was not observed during ordinary
I/O.

The controller needs its AHB reset to stop internal DMA and restore data
ordering after an aborted transfer. Require resets and reset-names for
the H616 compatible so the binding describes the reset needed for
recovery. The in-tree H616 SoC description already supplies the named
reset. Older descriptions that omit it were valid under the previous
binding and do not describe the reset needed after a DMA abort.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index 9d061e2216cb..ccf616fabc91 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -119,6 +119,9 @@ allOf:
           minItems: 4
         clock-names:
           minItems: 4
+      required:
+        - resets
+        - reset-names
 
 examples:
   - |

-- 
2.53.0

