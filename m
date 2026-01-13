Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE3363C73
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301958; cv=none; b=R5tglTAzCNqwMHFGeILKHejdYs9QEyM4A0+pnrC5AbgVXeX5ihVlQWeC3MIW4Etmgjq8CM4oV6d3XsRsGTLdXPTG/i64i1nBgRjSEOLOgYnLxQDXQ5LOp2VG5P3o1tjhd1T5nNyWDVfYrDxBlp41Mw4BOkgbuaes1i1GYFAx7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301958; c=relaxed/simple;
	bh=uiStrhAEZdmOxCwCYfF8DOPBHOR/dQ2/Q2UFYc8U8tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sl5Pzqt1kcEQMnRo+9CdzSgPRB/wzAeAaGuld92qwUDS4/3+of71hYm8IDrn9t7VCy9cKVZGW5P6VkMTmLpSDAA6kAjms49V5HFUfAYLhUFR8394L5HmXQsedq0fZNgc0CxgGetPshk2K53NvcGCX2I03JwpDukh/cwqexgIvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc78-0008DN-Al; Tue, 13 Jan 2026 11:59:06 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc74-000PMG-2m;
	Tue, 13 Jan 2026 11:59:02 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc73-00000004mJf-40rQ;
	Tue, 13 Jan 2026 11:59:01 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 13 Jan 2026 11:58:49 +0100
Subject: [PATCH v4 06/10] ASoC: tlv320adcx140: add avdd and iovdd supply
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-sound-soc-codecs-tvl320adcx140-v4-6-8f7ecec525c8@pengutronix.de>
References: <20260113-sound-soc-codecs-tvl320adcx140-v4-0-8f7ecec525c8@pengutronix.de>
In-Reply-To: <20260113-sound-soc-codecs-tvl320adcx140-v4-0-8f7ecec525c8@pengutronix.de>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Dan Murphy <dmurphy@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kevin Lu <luminlong@139.com>, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Emil-Juhl <juhl.emildahl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768301941; l=3062;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=O/aJfQS58lHdzjkzWpckHiUhyDbcXaaLEfqrqhEcuH4=;
 b=oszZrkFa0AJJT8Ur2BwoDJZnhmm/gu348P2mzWMUUh0n1ikk8PdcEpEqVtskHUeWrDjRThWak
 /l9LQn3MRHqDu8oS3c+RJPPTlboqwrDEQu++9vE7gQhefZKmDKNZHJs
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil-Juhl <juhl.emildahl@gmail.com>

The datasheet, under "10 Power Supply Recommendations" section,
specifies that both the AVDD and IOVDD supplies must be up and stable
for at least 100us before the SHDNZ can be released. After that, the
chip is ready to receive commands after another 2ms.
Currently the driver doesn't contain any options to bind AVDD and IOVDD
supplies to the tlv320adcx140.

This commit adds bindings for AVDD and IOVDD supplies which the driver
will enable when used.

Signed-off-by: Emil-Juhl <juhl.emildahl@gmail.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 444c0e80f0907de201ed1818b5612164a48b0fca..a7200e149e5f40ddd61e3c0455b796c81f55e2e8 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -22,8 +22,16 @@
 
 #include "tlv320adcx140.h"
 
+static const char *const adcx140_supply_names[] = {
+	"avdd",
+	"iovdd",
+};
+
+#define ADCX140_NUM_SUPPLIES ARRAY_SIZE(adcx140_supply_names)
+
 struct adcx140_priv {
 	struct regulator *supply_areg;
+	struct regulator_bulk_data supplies[ADCX140_NUM_SUPPLIES];
 	struct gpio_desc *gpio_reset;
 	struct regmap *regmap;
 	struct device *dev;
@@ -1104,6 +1112,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 static int adcx140_pwr_off(struct adcx140_priv *adcx140)
 {
+	int ret;
+
 	regcache_cache_only(adcx140->regmap, true);
 	regcache_mark_dirty(adcx140->regmap);
 
@@ -1117,6 +1127,14 @@ static int adcx140_pwr_off(struct adcx140_priv *adcx140)
 	 */
 	usleep_range(30000, 100000);
 
+	/* Power off the regulators, `avdd` and `iovdd` */
+	ret = regulator_bulk_disable(ARRAY_SIZE(adcx140->supplies),
+				     adcx140->supplies);
+	if (ret) {
+		dev_err(adcx140->dev, "Failed to disable supplies: %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1124,6 +1142,14 @@ static int adcx140_pwr_on(struct adcx140_priv *adcx140)
 {
 	int ret;
 
+	/* Power on the regulators, `avdd` and `iovdd` */
+	ret = regulator_bulk_enable(ARRAY_SIZE(adcx140->supplies),
+					adcx140->supplies);
+	if (ret) {
+		dev_err(adcx140->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	/* De-assert the reset GPIO */
 	gpiod_set_value_cansleep(adcx140->gpio_reset, 1);
 
@@ -1234,6 +1260,16 @@ static int adcx140_i2c_probe(struct i2c_client *i2c)
 	adcx140->phase_calib_on = false;
 	adcx140->dev = &i2c->dev;
 
+	for (int i = 0; i < ADCX140_NUM_SUPPLIES; i++)
+		adcx140->supplies[i].supply = adcx140_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ADCX140_NUM_SUPPLIES,
+				 adcx140->supplies);
+	if (ret) {
+		dev_err_probe(&i2c->dev, ret, "Failed to request supplies\n");
+		return ret;
+	}
+
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
 						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(adcx140->gpio_reset))

-- 
2.47.3

