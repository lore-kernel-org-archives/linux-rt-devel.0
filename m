Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931035C69E
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704679; cv=none; b=MvQSatSn6VbjqmIqZTJ3bDwctkooTUl296z15uwRrj/b6m4eDZSqkN9IuHbQIO7qmJJKE2kbCqEmikWNgBMRRMwqpMeqaJl7/WpcccbtCtT7XycON+U4tQ1RQ38kxjQ4VT7zn2BAkYbHQoP/hyl6fGDAE40RrC5fNyaGoGIi+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704679; c=relaxed/simple;
	bh=AhPKeNImrvlq1anzVY2fNb8qUrxOu5aYYSTJF3bI2YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iSLg/maOp41xzp2tMdNM+MrFKIp4cBPZ/tum4a6sbfeAiodx1mtWxbLdNB59QvxlZRk3XwnuLEEizSrBJQTzuIudPayYxI9f6uims+ytWHwxU900kePDdQCUncjYSabMQxUkM9gUT/7eGP5BHw3Gjg/MnV/m0bG7Ptf2gWO0PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSYwoSk2; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSYwoSk2"
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-81d53a6ca68so1544502a34.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790704676; x=1791309476; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Q5DALqLK2poFGKjmNG6XI2SLB5UCPlonreW219u7mo=;
        b=YSYwoSk23ZtBbJKsDN+Go8JgJ/aerWmxT79wNXSayNh3SEniUSoknY0XHzOOxzXYLG
         RwSl3xozJUzxNiFpRvR8INQyXYrYer/YGD1npORtUUONI4fv3PctVCZzBvZjKX7gJF8+
         7fkr2D82OmwGnoWcgbm2Wr8SvOxWasSBI9aUmCyKtENbJUPGOEySMyWDxxbLck1Zqvs/
         wZcqgkljgczbAyA0lqxaps/AqL+f7m6aXIZMGRupt7QbkcKjElbQR3cN/01KJ0SBVLMf
         gTxRJuBxcRJu6QPpIMr3R+BTtuSvFLpo79c1k2SQcDMV1pzsDwnem2x39wy5Qw4y0ib6
         aOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790704676; x=1791309476;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3Q5DALqLK2poFGKjmNG6XI2SLB5UCPlonreW219u7mo=;
        b=ulxnWKBVm50Yv3lfrhC8OvNL7/yqOjrCrQkjrfkggKizyi/tqsNSGa9l7VjyKYYEIo
         CAwrTPQFGMBEojVHwAwa9ylejl4fpq7IlIgZks0O9xn5C73L94jpN8rqv9Mtfcs5ZyD2
         kdcusalJE/VGq3L+ffcKWKh2EXw+mC97t8Wgzic795gGAk9oTLcwAoibJupUHyohe7St
         8F67MPy4tn/DAPhjY8eFP9FXj5QEilQiyH6B+J5GWPSZBj0lH/EtyvJXlnYrpRhflgSv
         YDGfl9p1Oeo2Oyo1ZW5FOFjV2w3wnrdBa+AFxy/TOX+Pag1jGhY6MZU1tb4I46jDPWAr
         L95w==
X-Forwarded-Encrypted: i=1; AKwUvBwFDx0279k0qZpYWU+h24R12oVO2+omLPXrvlYRb+8MT+radyXXtTjOt1oSxanLPALNw/n/b2t/mLgi0Pm2Wg==@lists.linux.dev
X-Gm-Message-State: AFuF++k1mVWKYGVpyTtZHbTM6DC+cKkFs/s1ZN3V85eSkLlySIMKM7gD
	NkhZM8PaiafnHJQ+D831sxyvO++CefghLj2LVxwpFxGbs7+3+ft3xJoV
X-Gm-Gg: AYBFou0hCgT9jfK68qUlg/b/7OI4ZhfmMyUElKjHoawtP9xt4cDGq705TGjJbLjyn32
	kmKOTH+TW+Sp16GyK1nrQFf2qGcM8FFXMnQaV3p4DLc3VYCh8+ZzSYXox0kqk192DM6Sl7yT6q7
	C+cg213rSjsd6fgAy7/yfnC4l/RYEjK/kcjstqlXayS4DH0qh1nPK5lpyPsP127qBj00qujbeRl
	MAxn+8rXNfLcrADQCb8ljujEppBtZIBWrrqPe91DJgRk+C8MYzgAaHwel0Jjq826c1WWt0IUlGQ
	XfqwFXhLfI1kvI9rf5ddaAJnUS1uHSYgF8BwYO5zfgIEvul9Q0Cz1qefYWUq0Vy0M1AwLUwOq5B
	OpTm+CfebBvjO+3x6BPsrdUVNHB9ziNBQfsSyZGQQk2CCh8GjhC/0UmvCcDMtZcwdsySpoJ5O7V
	GXhthuH3yg9VVTIulLujN4q2exL7Tj0X6eaqchpJbRVmCZXEW/KHDeHI5m36bDrg8i1g==
X-Received: by 2002:a05:6830:6f8b:b0:81c:ad41:f9a8 with SMTP id 46e09a7af769-81fd8d7e013mr96882a34.25.1790704675863;
        Tue, 29 Sep 2026 10:57:55 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81faf7eedd6sm691407a34.17.2026.09.29.10.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:57:55 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 29 Sep 2026 12:57:51 -0500
Subject: [PATCH] pinctrl: mediatek: common-v1: Use a raw spinlock for the
 pinctrl regmap
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-v1-1-db92943f42cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQ6CMBBA0auQWTsJNBaCVzEuCgx1oq3NTKtGw
 t1tWL7N/xsoCZPCpdlA6M3Kr1jRnRqY7y56Ql6qwbSmb0djUSYphFrohyVpFnKBo8eQH5g4zlm
 eKO6DQj64hJ09L70xdhqHAWozCa38PX7X277/AZvetit/AAAA
X-Change-ID: 20260925-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-154d6225b977
To: Sean Wang <sean.wang@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Yingjoe Chen <yingjoe.chen@mediatek.com>, 
 Chaotian Jing <chaotian.jing@mediatek.com>, 
 Hongzhou Yang <hongzhou.yang@mediatek.com>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790704674; l=5335;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=AhPKeNImrvlq1anzVY2fNb8qUrxOu5aYYSTJF3bI2YQ=;
 b=yQ5tCTTuq8nTIonA2166WPdB0ch3FpnbY3HeqZaxd1jIKsCOG9Ko0jSYkM8b1C/Fa3Ehnt1cj
 hLTiIbbRx6fCXdVy1YJTPmVo+15nwP4U/aNM9eWC7H3yhRtWEe8kDnL
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The EINT irq_chip emulates both-edge interrupts by reading the pin's
level through mtk_gpio_get() and the pinctrl regmap. It does so from its
unmask and set_type callbacks, under the raw irq_desc lock, and from the
chained handler, in hard interrupt context. The regmap comes from syscon
and locks with a spinlock_t, which may sleep on PREEMPT_RT. With
CONFIG_PROVE_LOCKING, the first request of a both-edge EINT prints
"[ BUG: Invalid wait context ]" and turns lockdep off for the rest of
the boot.

Create the regmap for the "mediatek,pctl-regmap" nodes here instead,
with use_raw_spinlock set, and register it with syscon so that other
users of a node, such as the ethernet on MT2701 and MT7623, share its
lock. If the node already has a syscon regmap, keep using it. Select
REGMAP_MMIO, which the driver now uses directly.

Fixes: 3221f40b7631 ("pinctrl: mediatek: emulate GPIO interrupt on both-edges")
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Found on the Amazon Fire HD 10 (2017), an MT8173 tablet that is not
upstream yet, where usb_extcon_probe() requests the USB ID pin's
both-edge EINT. With this patch lockdep stays on through boot, CPU
hotplug, suspend to RAM, and lid open/close edges on the hall sensor's
both-edge EINT. Only MT8173 was tested. Nothing else uses the node
there, so the -EEXIST fallback was not exercised.

checkpatch warns that the regmap_config should be const. It is copied
per node to set name and max_register, as syscon does.
---
 drivers/pinctrl/mediatek/Kconfig              |  1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 59 ++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 30ef3dc5dfb1..764256901d6a 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -17,6 +17,7 @@ config PINCTRL_MTK
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select EINT_MTK
+	select REGMAP_MMIO
 
 config PINCTRL_MTK_V2
 	tristate
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 1a977acd6883..65b1e3096183 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/machine.h>
@@ -1057,6 +1058,60 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 	return mtk_eint_do_init(pctl->eint, NULL);
 }
 
+static const struct regmap_config mtk_pctrl_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.use_raw_spinlock = true,
+};
+
+/*
+ * The EINT irq_chip reads a pin's level through this regmap from callbacks
+ * that run under the raw irq_desc lock, so the regmap has to use a raw
+ * spinlock too, which syscon's own does not. Register one with syscon for the
+ * node instead, so that any other user of the node shares its lock.
+ */
+static struct regmap *mtk_pctrl_syscon_regmap(struct device_node *np)
+{
+	struct regmap_config config = mtk_pctrl_regmap_config;
+	struct regmap *regmap;
+	struct resource res;
+	void __iomem *base;
+	int ret;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ERR_PTR(ret);
+
+	base = ioremap(res.start, resource_size(&res));
+	if (!base)
+		return ERR_PTR(-ENOMEM);
+
+	config.name = kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
+	if (!config.name) {
+		iounmap(base);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	config.max_register = resource_size(&res) - config.reg_stride;
+	regmap = regmap_init_mmio(NULL, base, &config);
+	kfree(config.name);
+	if (IS_ERR(regmap)) {
+		iounmap(base);
+		return regmap;
+	}
+
+	ret = of_syscon_register_regmap(np, regmap);
+	if (ret) {
+		regmap_exit(regmap);
+		iounmap(base);
+		/* An earlier probe, or another user of the node, got there first. */
+		return ret == -EEXIST ? syscon_node_to_regmap(np) : ERR_PTR(ret);
+	}
+
+	return regmap;
+}
+
 /* This is used as a common probe function */
 int mtk_pctrl_init(struct platform_device *pdev,
 		const struct mtk_pinctrl_devdata *data,
@@ -1076,7 +1131,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 
 	node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
 	if (node) {
-		pctl->regmap1 = syscon_node_to_regmap(node);
+		pctl->regmap1 = mtk_pctrl_syscon_regmap(node);
 		of_node_put(node);
 		if (IS_ERR(pctl->regmap1))
 			return PTR_ERR(pctl->regmap1);
@@ -1089,7 +1144,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	/* Only 8135 has two base addr, other SoCs have only one. */
 	node = of_parse_phandle(np, "mediatek,pctl-regmap", 1);
 	if (node) {
-		pctl->regmap2 = syscon_node_to_regmap(node);
+		pctl->regmap2 = mtk_pctrl_syscon_regmap(node);
 		of_node_put(node);
 		if (IS_ERR(pctl->regmap2))
 			return PTR_ERR(pctl->regmap2);

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260925-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-154d6225b977

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

