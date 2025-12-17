Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE4314A86
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979730; cv=none; b=HgQRLwcjBh2lUcfYlFiAbcu/DKT3gkSGRRgJnKun/LQpEuS790X65GzsN9CEbkYtVDs5+dhxdRHbixnyGHGGVqzF/Wrwc8gOX2FDEU1imeJVA9RjxxuQP1fdaxNz7cF0jNK0dTmpL74TG56f1vMzNhSitJcemoGOWymLoHlMyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979730; c=relaxed/simple;
	bh=GKEP9AMHKJ5a6QyDgU/OzjIEbqOGjcz+nleihAOIg1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXl6sHzx3LyjuZ1L7WevYN2wHfKTZAbwT6MX8DeB0oveBKtqzrfgiQb7MN5POxnWXo+lLk/5Xx2a2ItFgSkHWyI6uLiATRPuo7qg1tDvSGE6bHkTbBmcGMwNr0GBsyTB/DoRwvF0DuEWSSMp+qwhcY2Z//WByuTQAPAQQxAUI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzW-00019C-Ah; Wed, 17 Dec 2025 14:54:58 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzR-0067Yw-04;
	Wed, 17 Dec 2025 14:54:53 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-00000004tQv-3Wsb;
	Wed, 17 Dec 2025 14:54:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Dec 2025 14:54:55 +0100
Subject: [PATCH 05/11] ASoC: tlv320adcx140: implement register caching
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-sound-soc-codecs-tvl320adcx140-v1-5-293dea149d7b@pengutronix.de>
References: <20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de>
In-Reply-To: <20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765979692; l=4851;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=ea1XVBbDlDq+86UiTFrQSLPJP6o7hjwGJAsuTxqcX9E=;
 b=JFqG24vOUudcOM9puVhc5pwH/8zBjLeww2s0Fsk7nQ34R0/htBd4sZSo7WqurEu9+Jjd1n12Z
 bdKlnMCzfycAuKM7oOEP9D28V2uX3TzmVTxI9xBbtQytXcCtrcBFMPg
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil-Juhl <emdj@bang-olufsen.dk>

The tlv320adcx140 can be connected to controllable AVDD/IOVDD regulators
which when disabled will reset the registers to their default.  In
preparation for adding support for them implement register caching.

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

