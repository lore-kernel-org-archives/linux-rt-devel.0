Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430028689A
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070283; cv=none; b=s5Ex41shUeIs70pytEurxprEkwoN+K0KBOtx1/U2jN5iKpzNrTdtwsz7+g4vahutaF3+2C9eljOmfL2aZa+M8N5FjK/O3ZBfXiA4YieWv05q+krPf6Dm1ed45iKCDdilfF5VC4DbPkjYFqSCijAQGEA/Bb50J51ao7GoBxLrICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070283; c=relaxed/simple;
	bh=YmYfAiYtDMLwEYQHfzbK96EA7eR/wsi3lxl4N1XTMhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2P1K0HLJgw7YPzLGR2nNsPuC8wviqD92MqvuG1A3DAp5nA1QgC7Lp+GpZPsRdf30REraDoUvhKrJonGYSjaykKFe10wHziUUPji+Pq01uEjxzy8LqOyUUlq8hNRTm0l8zJq5YbaBVjxU4SeW1dKu51Mmrb8cqvPY7qBFoVfeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY4-0007j7-Oe; Thu, 18 Dec 2025 16:04:12 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY1-006IfM-2M;
	Thu, 18 Dec 2025 16:04:09 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY1-00000002kPh-1uel;
	Thu, 18 Dec 2025 16:04:09 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 18 Dec 2025 16:04:11 +0100
Subject: [PATCH v2 05/10] ASoC: tlv320adcx140: power on/off the device on
 demand
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-sound-soc-codecs-tvl320adcx140-v2-5-3c2270c34bac@pengutronix.de>
References: <20251218-sound-soc-codecs-tvl320adcx140-v2-0-3c2270c34bac@pengutronix.de>
In-Reply-To: <20251218-sound-soc-codecs-tvl320adcx140-v2-0-3c2270c34bac@pengutronix.de>
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
 Emil-Juhl <emdj@bang-olufsen.dk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766070249; l=4929;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=ZnNeTOgXVvM9bTi+Jtpw4nD9MeKZ7YeJc6ZpZ/WVJxM=;
 b=hpoBvkey/bc3LThjtJLc7xSRm2Z/yp+0liV4kb9BY2rY15QW9X94fVLiwpPtk2DUO4qe5xYsQ
 ADiGEBT/znVAT7mHmpjViWoJTr8FV8HRtjIms8ow9LEn+eXMOY/J+cD
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil-Juhl <emdj@bang-olufsen.dk>

The tlv320adcx140 can be connected to controllable AVDD/IOVDD regulators
which when disabled will reset the registers to their default.  In
preparation for that switch to register writes to cache only when
powered off and sync the cached values to the registers when powered
back on.

Signed-off-by: Emil-Juhl <emdj@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 89 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index fdf4a9add852deb5e879dba5c8a09458fc6e709d..444c0e80f0907de201ed1818b5612164a48b0fca 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -121,6 +121,34 @@ static const struct reg_default adcx140_reg_defaults[] = {
 	{ ADCX140_DEV_STS1, 0x80 },
 };
 
+static const struct regmap_range adcx140_wr_ranges[] = {
+	regmap_reg_range(ADCX140_PAGE_SELECT, ADCX140_SLEEP_CFG),
+	regmap_reg_range(ADCX140_SHDN_CFG, ADCX140_SHDN_CFG),
+	regmap_reg_range(ADCX140_ASI_CFG0, ADCX140_ASI_CFG2),
+	regmap_reg_range(ADCX140_ASI_CH1, ADCX140_MST_CFG1),
+	regmap_reg_range(ADCX140_CLK_SRC, ADCX140_CLK_SRC),
+	regmap_reg_range(ADCX140_PDMCLK_CFG, ADCX140_GPO_CFG3),
+	regmap_reg_range(ADCX140_GPO_VAL, ADCX140_GPO_VAL),
+	regmap_reg_range(ADCX140_GPI_CFG0, ADCX140_GPI_CFG1),
+	regmap_reg_range(ADCX140_GPI_MON, ADCX140_GPI_MON),
+	regmap_reg_range(ADCX140_INT_CFG, ADCX140_INT_MASK0),
+	regmap_reg_range(ADCX140_BIAS_CFG, ADCX140_CH4_CFG4),
+	regmap_reg_range(ADCX140_CH5_CFG2, ADCX140_CH5_CFG4),
+	regmap_reg_range(ADCX140_CH6_CFG2, ADCX140_CH6_CFG4),
+	regmap_reg_range(ADCX140_CH7_CFG2, ADCX140_CH7_CFG4),
+	regmap_reg_range(ADCX140_CH8_CFG2, ADCX140_CH8_CFG4),
+	regmap_reg_range(ADCX140_DSP_CFG0, ADCX140_DRE_CFG0),
+	regmap_reg_range(ADCX140_AGC_CFG0, ADCX140_AGC_CFG0),
+	regmap_reg_range(ADCX140_IN_CH_EN, ADCX140_PWR_CFG),
+	regmap_reg_range(ADCX140_PHASE_CALIB, ADCX140_PHASE_CALIB),
+	regmap_reg_range(0x7e, 0x7e),
+};
+
+static const struct regmap_access_table adcx140_wr_table = {
+	.yes_ranges = adcx140_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(adcx140_wr_ranges),
+};
+
 static const struct regmap_range_cfg adcx140_ranges[] = {
 	{
 		.range_min = 0,
@@ -156,6 +184,7 @@ static const struct regmap_config adcx140_i2c_regmap = {
 	.num_ranges = ARRAY_SIZE(adcx140_ranges),
 	.max_register = 12 * 128,
 	.volatile_reg = adcx140_volatile,
+	.wr_table = &adcx140_wr_table,
 };
 
 /* Digital Volume control. From -100 to 27 dB in 0.5 dB steps */
@@ -1073,19 +1102,73 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	return ret;
 }
 
+static int adcx140_pwr_off(struct adcx140_priv *adcx140)
+{
+	regcache_cache_only(adcx140->regmap, true);
+	regcache_mark_dirty(adcx140->regmap);
+
+	/* Assert the reset GPIO */
+	gpiod_set_value_cansleep(adcx140->gpio_reset, 0);
+
+	/*
+	 * Datasheet - TLV320ADC3140 Rev. B, TLV320ADC5140 Rev. A,
+	 * TLV320ADC6140 Rev. A 8.4.1:
+	 * wait for hw shutdown (25ms) + >= 1ms
+	 */
+	usleep_range(30000, 100000);
+
+	return 0;
+}
+
+static int adcx140_pwr_on(struct adcx140_priv *adcx140)
+{
+	int ret;
+
+	/* De-assert the reset GPIO */
+	gpiod_set_value_cansleep(adcx140->gpio_reset, 1);
+
+	/*
+	 * Datasheet - TLV320ADC3140 Rev. B, TLV320ADC5140 Rev. A,
+	 * TLV320ADC6140 Rev. A 8.4.2:
+	 * wait >= 10 ms after entering sleep mode.
+	 */
+	usleep_range(10000, 100000);
+
+	regcache_cache_only(adcx140->regmap, false);
+
+	/* Flush the regcache */
+	ret = regcache_sync(adcx140->regmap);
+	if (ret) {
+		dev_err(adcx140->dev, "Failed to restore register map: %d\n",
+			ret);
+		return  ret;
+	}
+
+	return 0;
+}
+
 static int adcx140_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
+	enum snd_soc_bias_level prev_level
+		= snd_soc_component_get_bias_level(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
+		if (prev_level == SND_SOC_BIAS_STANDBY)
+			adcx140_pwr_ctrl(adcx140, true);
+		break;
 	case SND_SOC_BIAS_STANDBY:
-		adcx140_pwr_ctrl(adcx140, true);
+		if (prev_level == SND_SOC_BIAS_PREPARE)
+			adcx140_pwr_ctrl(adcx140, false);
+		if (prev_level == SND_SOC_BIAS_OFF)
+			return adcx140_pwr_on(adcx140);
 		break;
 	case SND_SOC_BIAS_OFF:
-		adcx140_pwr_ctrl(adcx140, false);
+		if (prev_level == SND_SOC_BIAS_STANDBY)
+			return adcx140_pwr_off(adcx140);
 		break;
 	}
 
@@ -1186,6 +1269,8 @@ static int adcx140_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	regcache_cache_only(adcx140->regmap, true);
+
 	i2c_set_clientdata(i2c, adcx140);
 
 	return devm_snd_soc_register_component(&i2c->dev,

-- 
2.47.3

