Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904961;
	b=EF/BY9HLXzVlREg/WNSWZvliWd64ihYL0je90/XCVDI9g9dOpNtA/X0AUlSthHP7T3xN
	 9+WPKvBzNSGjbfU+rSS/SdB90/QcXMEklvlEjDvsnQpdQlKZNPhwZO0ZjcZgWPoeEoezz
	 IrKBGQk6Gp2+hfHTIitsSJFBh2TKIJa+nvRgYbroYKyguKPPW1qG5hmGUQSKysxJgBcIJ
	 jZmxviFJRAgREoQWQ/ysqNDab2AyAiG/v8tapLZAyuVIwbxkBV/mKV1NMWk64iyzmXpQx
	 K0BoyTCKV+63v1Y17nJnnEEJzrWYAMJjtb2PUmsO5wPSXaHnF/N4Vs9gZlZoGpKy//w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RwjIT0DqDPAYZ6NuHVGHzHM6/S203rMIqUTfEYiNenQ=;
	b=Pq+R8kaKLMLSFczyj6JpNeqBU+ULY9N6KsE9z8KYZPsRxbS5ZuqloryCtFz8yGt1jjUH
	 EXiq4lcVUGOx82TqXTcjHh4mQFsFTHixbbZQp9GEzo1gna2neFPUhZhJ0Wy7uqyhIOC+O
	 dLBKTsfzZmjVtXjUgm4mY+s4tYCEjXU26Kg+e607ldP7o/NBzytoj3BFlqRfXlFYryKiW
	 0Pn7NMXzBVu97ddG61gAS4T3PC0+/DInoe03VJ8/VYNlX1Vea3J/jqgNw75TlDmtE9FZI
	 33uPD6whk0g7y9mBApPaCG66qoth1S1oh/IP82/5T6Q/dTpxQG3v/Ifx5SpL3+GU4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zIRj/E08";
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F446083611
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13F446083611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zIRj/E08
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b1afdf5196so932883eaf.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904960; x=1794509760; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RwjIT0DqDPAYZ6NuHVGHzHM6/S203rMIqUTfEYiNenQ=;
        b=zIRj/E08pjKn64f3WiWZk5F/KdV1uO7o4wzwaUcaOY9f8oPJRAqrQ+EAusfnTwqcDc
         wD1xljIdCJc7YnwKD2ATfC0IP7VfHAPM0ybK1QmUad1Bpo1w0TIPe70eMJo2bQeztHIU
         1Ox+vh6jvjOcDqJAhqcvDaVYLLZK2bXjTJ4VmSm3lpm08OFfpuDHuYtwzqVChVvP9Sgj
         NgS5kz881bo1wWHx6/+1OGy2OX43KkwwjZOaqn362Pf0SwJSBRjR5yLBIMjtHPkSRShj
         a3lepH3v+oP395J02uJikvs44Wggp6W/2guYHgN9gJ2DyFnvY5qJYcGDdcrUBqPAVtLX
         cUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904960; x=1794509760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwjIT0DqDPAYZ6NuHVGHzHM6/S203rMIqUTfEYiNenQ=;
        b=kyjAy8TRTrQ7ii1U22yODZY20XA1Ok+E407lcisKwOOyFeVMtBlDy0sOy6buvlWp/C
         KCxtzWo0M2znwx/QzJmXprWeiuJCTV3RfbdKbHD989NUv4iPmVFiVJt2tVo5/pReJ1H2
         E52802zmLqMsmvSXqF1+UNUVjzq9f5o1dIXyfSVVNUPUylEYixwFRiSk3n4dz2AFG4DY
         VKMjUjts6VrJAc8GOFekXwHqKNoErccBMZzfamcNaaaSFm6bKxvGMvKmX/zjXN+s59X7
         GEyHyAfQ9mOWRAAVIuco2MAO4chSpM8poUdOmH1e7h4RrtXGgOYGivkXE91mp/+5vG/f
         8DJQ==
X-Forwarded-Encrypted: i=1; AKwUvByesMY1yJ84MriTkVX8FCOrgN0dcVuq4ay9imauW7+tHrwvbAhf+wRgU+n8zpPOu1g9NkBMWnjRH1gb9BJSrA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+xlttBgYS6yF4AEASsk0fUMiW8hKw30/TC7V6xwFzrcD80n2TD
	pPWas0ZJ0DnQVu6EMFH9iKOG2jRF5gQoESWeqr63alO4SBYdOXfFe7eX
X-Gm-Gg: AYBFou2pemFn5uyzuHMYQ/ikMQ7bcM1+QS9dgw9h+RfIlapBAsFMW4XxWgINjI8iXCX
	tdRx5HOWahHJWGVnDNKZwqwMt5yvEGhSuUCPI/ZpFkadqlcIs6olH48oleB2NMe8autKAQlXY0W
	youKhUEaFuhTZ4zCXkbzmLWp8K1j2mXRhBVF5DwQp4T44Uu0txDCPsq749vtYh6cPC9fP8tKFey
	XNeVKPxLiU6JXmiJi2f42nbeZiFYwZlIxIE1s+WfyGCbHxsdNQNI1gwDCd6a8R4dMev9fg4Jt0r
	vIhIkboO8QxkmvEs5HLiGCA+q7+UrNIud788zDIXqe+ud3nJZdait3p8q0GtALf9HQKOx4i0dpJ
	gKj0exM1obfBnr21qoH4lQ7Bweso3sU1Y0dZfu0sJHMtQ4ZwzuCf3QxGaBQ5NlIB+h5R1bGuv7W
	sMjI2BNdEU5Q1AnPQD8x+TkBpZnhFoq6WHPC3Pd4bRYnvnUjr+o0MClTfnJLFSDiMowh/45TY5l
	e8Sr/wNw6y4zoOpSv0fVg+/0tlvLNLINFhMyFg9Zn/f04WlPnYovFgVoHA0SXr5OYjt1GndUK9n
	4fUvkFh9f0gj2ugTMdDeEEdGNwbyB4OiXsYdUn5LZpoqeu4cdBFGmrxXfTfNDAbK4zt2Beri335
	kIO2X9mo5m4g5psW0V/zrLgiUKW77bPe64i6tP2Ji0Yx62Y7ZfxY2jjz4Bwsoz1hJrxKpj21Jy4
	dSBL3J+75M0sJ0kwJOT4PGd86O8J+yoECJtoIZChgoiN2ByHHDlO9P
X-Received: by 2002:a05:6820:160f:b0:70b:9b1f:e8a2 with SMTP id 006d021491bc7-716e73de95bmr322359eaf.3.1793904960035;
        Thu, 05 Nov 2026 10:56:00 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:59 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:34 -0700
Subject: [PATCH v10 18/26] mtd: rawnand: sunxi: skip unavailable NAND child
 nodes
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-18-dca1f6ed29a8@gmail.com>
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

sunxi_nand_chips_init() scans every child of the controller node,
including those marked disabled or reserved. Neither the chip setup nor
the NAND scan path checks availability, so these children are still
probed and registered. If an unavailable child describes an absent chip,
its scan failure can also prevent the other chips from being used.

Iterate over available children so unavailable nodes are skipped before
claiming their chip selects or issuing NAND commands. Keep the scoped
iterator so node references are released on both normal and error exits.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 636a04f49418..3de9ed6795fe 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2771,7 +2771,7 @@ static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 	struct device_node *np = dev->of_node;
 	int ret;
 
-	for_each_child_of_node_scoped(np, nand_np) {
+	for_each_available_child_of_node_scoped(np, nand_np) {
 		ret = sunxi_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
 			sunxi_nand_chips_cleanup(nfc);

-- 
2.53.0

