Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223496;
	b=d9zPwtwEYxvwQEy3L+04u8etkx0gWThUzK1UXHSM9fygSWuXvymNFHKhhtgdQlBwR/9B
	 lRjLtXsckreU8lcKBo2rflJG9tblF6H/8v3RI+n5RQSnCSILPFf8dl8FxwChS+BJ21S7j
	 Bws03KQkdmaP9jZ7fAKtmv+kbn+j2nugRTLZQwFOngXLhhYyBlbK1Wkx1fmEZRssIHDbk
	 ntMkGhT5V8eeUMPniwP+PqIfGtWpHxa15dty1rhJlpmPbUtHqocLRbzYLRiiIIM7Ne/Jy
	 R1pTn8NZDGRD19KBSmHFnDE8QGCVFlMSMg6es/9q2znXP18i+NRO3K5wtxYupJL1sqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1uJoG142fYCuU8vw67QDp3rEWq4mupCEBikzvmy4Exg=;
	b=B6h/LTH+UicyfGwkL69hUIGyI88SAafgfum+KCQaw7P04Jwp5Sj/XVgqAi6oRqv4QS2m
	 893vF1rLNXLy59/t5oXfAk1+94cz0zWS1x4hfaI/q6BGr27mj90AWFSOtqnPUDHXax47Y
	 XwOK20hzr/fwe+24dd1Zsq9EhvWRr6sdQRnHYl0Wo89wcKrRxZI5oA9CLxOukkzXhW7Jo
	 V/jG6eCkYxE5Ych49x7COE7C77PV7ac3ze4BH6wQwvNcN6X+es2CXujz8sdv3QBTd7OGJ
	 D/v3j9UQYirgx8DRbc66fHB605aLEoJq1xujKzfjDqtLveZq52J9GTG28P+FZhO9qeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFleb2QW;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CF606ACF1
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 106CF606ACF1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFleb2QW
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-57728d87699so651367b6e.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223485; x=1795828285; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1uJoG142fYCuU8vw67QDp3rEWq4mupCEBikzvmy4Exg=;
        b=cFleb2QWZnIY6JP1tnav001EFHGR3tEZslNIKBYF078lRfmiRWVEfcceTUw09ocQlt
         aVxJ8n/QiBuQd8mach1eJmU+jhT9nPwkEAAqcGPPtdcIeNyMRmAvlhFSsczsUFj03m6I
         f5uq7sdfAuyrBSa/FniEeaxPMqkKen0X6XUO2WxoZ+6J83sHJL7X7CzSyKeAW9LpV6ZR
         jicbVonCIKt/LoUvXObjDiwXpbnLF8LO7/90+7MPTQ084tysRylfbrEXP2htG/v5Dino
         xTF98bQcOZl5+LlMT8Tzgjp5lCqvzD840Ii+UKnpNS7Akc+EJyPHG0Wr3t6+LIQf4pdk
         MxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223485; x=1795828285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uJoG142fYCuU8vw67QDp3rEWq4mupCEBikzvmy4Exg=;
        b=JeLjyrX2ybgwoTbCkiDj3YIoVVgkSUXgDsASnpsyjQDaWaj2bhHtB78pGmK/gLgxvD
         sK7xjW8fq+XI4N6Y1mdqrPIBndNPHN65RdwjwFGFDFx/MDQ05r1qfd2O13+4ychs8I6f
         6bvIyAikad9A8ntPR/6MmNt4u9fRQfoHkeTXBnSSar9xxJ/ohOiH6MKiFnf1oGzDL+2y
         htHxkknvKk3SooM+aU4JJ1gShj0DfBjkN7qHxoUHy9A1Z5rVPBRgXNjGfqK4uYwF9Tik
         kR37hsOembd8JogE1+AFDmJ2QM/tP+idad9sGTtHnTI6ISnkO4qEYkMa7lCrGfqZy66E
         g6hA==
X-Forwarded-Encrypted: i=1; AL+hErHSOe3vAkRXmV/hARgb6sWkNnY9BTUdMv9nQE/uTuc4G8I7C5hLSQk405G0RHDGaLqAOpyd5D6CTuSVgXJtbg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9r9F/EAYyWEKMpAX7NgqTg1arT0bgaVxJJ/LkSA/ptCOu+xRi5
	H7L3NzVfUkgPrfuKahOXPSE0BbQWE3PVQpc2q5xPDtNNDvVQkncSHiaq
X-Gm-Gg: AYBFou2nyJhk6ltptuFkl5eMQamyOoE/0cfbLdAYChLoW5/7taok5Fl9KMFlae/Iknw
	1aHfnd6zWzzXPA5N7XHfMrl4jrqnzFoBuklqHiiCCqD/JBxz38D6rdPloJH/I6adov5EaAbs2ZF
	6Mwml73EuerZY1/6R+PtGFR+XIzxFPEqmzgfPg1sfqOCVqgTsPz6I5866tqERWpQdab1q5+moXX
	eRC5L/zSJOJqIcbNEDvv/wSNMDHzP1+fHtl36QIINrNYEa1LDQl4ELS0rGlW3f/1aSoiEzUGtj5
	L/eA9bG6Dzlw3ejFf6/21M6pajDT0ZfNUyAmxqUgXCVxi1u+8/jTOd7shbEpxw0s8Aa16igfH0X
	Qot8EThPPGXPUYLpN9rj61DGiqZ/KDV5j++MOrDt03oe1FApGnpdB7PELEv6Qy4BvM7shYlLFxM
	EFboCyHHbNKZG/jqAb6Yag5hX+qlKb2ZQwgFtGCyRArhyo3LRCyY+8XFggtfsXMaIwgzv4XNkuJ
	YKoMLhS0/VfNBOolnaGm1go0vgpVuf54TMK5dBXDBIf2OkRJVWVTZeS/W3cnny7Atv0nzhhRB0M
	AFWU83SIxzkNICfPiIN1T3aOhDDXBLZEGzcfY/TQ81xeXGhtBeOHzacPkyEQPE7YAieabG3aHk+
	YvCvShKIhVpagxc/bAGNxS7SWnLozqx/Mn0Y1/zGlS0Yxjph2A13i0sRWGrWyynGgM04HlAvvT+
	c34O4ksmqBj/RGL9liynbZGkDVlTdcOwEWj+QAGLG+ecSOkXiTHirD
X-Received: by 2002:a05:6808:1915:b0:4f7:867a:1136 with SMTP id 5614622812f47-57a0c7bef2emr6229820b6e.64.1795223484984;
        Fri, 20 Nov 2026 17:11:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:44 -0700
Subject: [PATCH v11 21/26] mtd: rawnand: sunxi: skip unavailable NAND child
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-21-9721b1905ef4@gmail.com>
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

A disabled NAND child can prevent usable chips on the same controller
from appearing if there is no chip at its address. The driver scans
every child, even those marked disabled or reserved, and aborts probe
on a scan failure. If the chip does respond, it is registered despite
being marked unavailable.

Iterate over available children so unavailable nodes are skipped before
claiming their chip selects or issuing NAND commands. Keep the scoped
iterator so node references are released on both normal and error exits.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 4478189bf920..73d6cd89ca19 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2661,7 +2661,7 @@ static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 	struct device_node *np = dev->of_node;
 	int ret;
 
-	for_each_child_of_node_scoped(np, nand_np) {
+	for_each_available_child_of_node_scoped(np, nand_np) {
 		ret = sunxi_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
 			sunxi_nand_chips_cleanup(nfc);

-- 
2.53.0

