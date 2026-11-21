Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223489;
	b=mMmw1IvlCzqxk3sxAJg3ti0CL57ufMqamA76ahY7x0l2oI2gO9rZR44Rqs/xQDEsG3LL
	 pgtwj3+PSlXMUcVCi2RXHShrD4PB8KeQaNGHSJgDbbpy51GA9zqfswR2mvyjUl8DZgl9M
	 6WvJLOS8eLRheJ5lVxa9Epzq/FOR/R2gQz9Xl8I/gbT5j3KfmCdvh9eSUgGp3OT6ojRZ1
	 Q5/CvC1R+dv7K10EAoYBDchNKxBhIEc3pA1VksQIM+XOqbAeDTVCdBVus0O671wBL/RZi
	 2/QcZZNbNAZyGrA24rcCSul/fMT7e/TwiihWEC1/eL8l/fT58Of3y8nTHJwfPaEHH5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jCsma9jNkefw5HpS61LewWc4mQKxmVwW9euoTiUjDLY=;
	b=F1W35Z1XnA1U2U4Sn1DOZ+E7v9r7C8wCSb3OpwwZH0Rh2kkFnvacmBe+diiTgjnUVbqz
	 MVR6AaPwxnKHxJqXt0AzigZ/XPOpm+tuJcat/gjhNlFWGTehWwXH3+QQFzhqYG6zHtM7v
	 84BRrGe5YXoXHNaqORy9xQmU41KuSSgoXyMdtTVVcJBTw0r0Rsu6+VOmW6wtYH2pIm3tY
	 KcaN+qEGQp9iVz950cCLQUyDJVJ1tp3OvPjnNUSjtOTSq2yMSEr3fE+AYvV9AGplxJZ9y
	 mJM4drVr9FkxnBu0ekmuTcxWDIeNWCACZdQjy/UVodbiUB1MH56VN7nVKlnBhGIDwCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XfzFZQbZ;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685CC60A3815
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685CC60A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XfzFZQbZ
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-56431524c22so678561b6e.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223486; x=1795828286; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCsma9jNkefw5HpS61LewWc4mQKxmVwW9euoTiUjDLY=;
        b=XfzFZQbZQZrlLOfTcbJE0Hw2F5L7PqJsihgSYiU24rGgjKovNe/5LaOFb4l1wmvh4c
         KiF5PnjavU6PQHhES3uXJsQszfAmOcCfBUUEAUjx9gPU5N4hB71yxH8pIsrbhsNZ1t6o
         raXhTZkPchKVxOXy9Qa9FK/TBeQYSYxlH49PGnQEqNwnQTK4C/F5QMc8Wu0AjBmk/S+8
         qY5dXqbihY5sPGX+4Kq0w0yNli96vsj5e0d3SVcp0YdwoXehNG/eHUa4t846z5wwr3UB
         3WCBMzgnft7yHqJ+4iJnu7fHXt3/ks10womgTP0qvXvIb/snQziEVCSEMJWu6laqXf27
         vOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223486; x=1795828286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCsma9jNkefw5HpS61LewWc4mQKxmVwW9euoTiUjDLY=;
        b=yjSZ9KOTgd0aDLathKVT4Z4X4AXdCwdbe1IDJmWXPve2BmanTxlI6413aebG8C/lHg
         TdBq0f7Gjl8hrd7kjHEBI7y2f+zFNHXtRLPp8Jw+MuEtGeAZsDC82r3NpgQIG0/RoW6C
         Ku//TUIGkrJ+tuzLDGBfI9W1PMoCcoLhkAVsA0xnh4iVgcRpSrf9xOC1Rg71nlJ6SMxo
         XvUC29xqysq8BHqkeOCnvKFQfChhDii+peZRr9EszqPl4e5H485ZrNkxolQvX/VGHXPC
         xm0niMDyZYQhitW+VJXz5dm3sCiV18M15IlSPi/1aV9LGow7y4RQx5vAJF50/4UI9k0N
         C8Pw==
X-Forwarded-Encrypted: i=1; AL+hErEX9N9LI/tuiLwqNJFB/1R63t0LVcoS1aqMKvUqPzVtpnPqY7jwdfI50srdts3BGMXsmw6icvUwk2FgLmQ6sQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9WELW5NQF17dpwHJFND/bcWqgvlIzMvUSzzeSpcJ6EiNTs0bI2
	b9r5ni2RYjBpqx4bh51+x2L9rKcNqzFjYyzpQp2xrtCHrwU0hFLHggQj
X-Gm-Gg: AYBFou0AIl4XZtKztGi2Hu7NkhPtWm/6J9vem1AUz2Ewzzd0TtKCdvGWzjy8hxf/9fA
	EtI1iSrsZn3qyspxufZtX5Ar6mTi6WsKittqIUCTM7w0RcY9ZhmgLqC8lGehrv6tRxz4OtBS/z0
	a4q+bvGs2JhE2cYssHamGRjZBW6nE3sxvapyrVnoUWmQC8l2tF3W/fhuPfJ6tqM/gdfcu2vpPru
	l2+gbKETZ7KNVWB11TASvd8iFILXVli6fOFgw1S3lkRpysZM2/HQ8sqitgXjfRxgi+0IwX8KiJn
	06Ppdb9kB3IeipwLRNI3ZQvG7vvpy2ZvZTdCOBJOU+uvsJFB7acASyeE9VbH7q5qprpPe86Z5Tv
	jPPtEBbqwZKSURfNC2iC6ICTUH0+0tPFz+hbzGznR9hWu3xjSDbiosObI87t10OHoqhTc8K5J6t
	AkeuFcg1CLNWdXcW8+m2nnWm4Cyaas493RyuRGFscWRfo8aVYMGwu9MtbDSlG5Q4p3EzkYmH+ga
	5XoSLxUhIN0ZlHhSNnQe9zG1fKntNokwO9YdhM5uii+kU8wIQzc9b3tLni73Oq+d56JAvdSQt1j
	hWolra4Q/1uo7QlOvsDb4zNxi6XxTKun47rTWVwN7fi1kNE9lTK+DwqIE/V6rtXe7KDKFIsUqCJ
	JSF8Nv/RekFRDYmKWaVqUkfjWPH9PEICwW6Mu/5sMdmkCgg8FiZ71u22rYlJ/FadrOw6uPxS/SZ
	Hy92yf9uoF2uUz6ReeDOIlOMCaizrLVgNMr4c9VHnhU7iSj8Tq+HDV
X-Received: by 2002:a05:6808:6410:b0:574:16ef:89c6 with SMTP id 5614622812f47-57a0ab2e12amr5993188b6e.35.1795223486363;
        Fri, 20 Nov 2026 17:11:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:26 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:45 -0700
Subject: [PATCH v11 22/26] mtd: rawnand: sunxi: scan all chips before
 registering MTD devices
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
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-22-9721b1905ef4@gmail.com>
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

On a controller with several NAND chips, I/O to the first chip can
overlap identification of the next one. The driver registers each MTD
device as soon as it has scanned that chip. Normal I/O holds the
controller mutex, but nand_scan_ident() does not: its RESET and READ ID
operations can change the chip select and timings under the active
transfer. The transfer can also interfere with identification.

Scan all chips before registering the first MTD device. Track which
scanned chips have been registered so that a failure in either phase
cleans up every scanned chip and unregisters only published devices.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 73d6cd89ca19..abea2ab0cc42 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -274,6 +274,7 @@ struct sunxi_nfc_timings {
  * @sels: array of CS lines descriptions
  * @user_data_total: protected user bytes in a programmable layout
  * @user_data_step: maximum bytes assigned to each step, zero for a fixed layout
+ * @registered: whether the MTD device has been registered
  */
 struct sunxi_nand_chip {
 	struct list_head node;
@@ -284,6 +285,7 @@ struct sunxi_nand_chip {
 	u32 timing_ctl;
 	u16 user_data_total;
 	u8 user_data_step;
+	bool registered;
 	int nsels;
 	struct sunxi_nand_chip_sel sels[] __counted_by(nsels);
 };
@@ -2563,8 +2565,10 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 					      struct sunxi_nand_chip,
 					      node);
 		chip = &sunxi_nand->nand;
-		ret = mtd_device_unregister(nand_to_mtd(chip));
-		WARN_ON(ret);
+		if (sunxi_nand->registered) {
+			ret = mtd_device_unregister(nand_to_mtd(chip));
+			WARN_ON(ret);
+		}
 		nand_cleanup(chip);
 		list_del(&sunxi_nand->node);
 	}
@@ -2644,13 +2648,6 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	if (ret)
 		return ret;
 
-	ret = mtd_device_register(mtd, NULL, 0);
-	if (ret) {
-		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		nand_cleanup(nand);
-		return ret;
-	}
-
 	list_add_tail(&sunxi_nand->node, &nfc->chips);
 
 	return 0;
@@ -2658,6 +2655,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 
 static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 {
+	struct sunxi_nand_chip *sunxi_nand;
 	struct device_node *np = dev->of_node;
 	int ret;
 
@@ -2669,6 +2667,18 @@ static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 		}
 	}
 
+	/* NAND identification must finish before MTD users can access the NFC. */
+	list_for_each_entry(sunxi_nand, &nfc->chips, node) {
+		ret = mtd_device_register(nand_to_mtd(&sunxi_nand->nand), NULL, 0);
+		if (ret) {
+			dev_err(dev, "failed to register mtd device: %d\n", ret);
+			sunxi_nand_chips_cleanup(nfc);
+			return ret;
+		}
+
+		sunxi_nand->registered = true;
+	}
+
 	return 0;
 }
 

-- 
2.53.0

