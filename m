Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6334DCD7
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979739; cv=none; b=GnmPjXtbrKvhtFLOw/ZL59clZLiWNVt5NzIwIHSyj9qxMg9eE8kzC8/rQ6KemxMtHLflr9OHI1CzEpwdiuJ8Rmp9f+6VKwS3SQQ2U/KrBTcocao5rHrfD/XRQfzQpc8kV+iL6tvHtw+KoirhthdGJfQk6W2qWui7ruHcErse/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979739; c=relaxed/simple;
	bh=KIVZf9eQsEe24xzKqF2imdi5YUmFlNEbdV3+FMOkKwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlbXEPHPmuSf6Onu6tJ13Ov8SEpKEcxKZLGzR+NH/n15QkZScx0e/hVZL/jIPHNbeNKQhxYFdlts1o1nHEMm9tJiLKqv4kBb4ZFUTgWKbqQAGpC4GWOfzn/doEky4R9/jv3eQh9AIJVIWiUKu8Ax4uSMrKj2Y/5xV8Hqk4kC+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzW-00019E-Aw; Wed, 17 Dec 2025 14:54:58 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzR-0067Yu-08;
	Wed, 17 Dec 2025 14:54:53 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-00000004tQv-3U9J;
	Wed, 17 Dec 2025 14:54:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Dec 2025 14:54:53 +0100
Subject: [PATCH 03/11] ASoC: tlv320adcx140: Propagate error codes during
 probe
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-sound-soc-codecs-tvl320adcx140-v1-3-293dea149d7b@pengutronix.de>
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
 Dimitrios Katsaros <patcherwork@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765979692; l=1285;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=PpAmR8wKqRTX1YV1R8fVM7vj/FkNO/cKPTJr6ncyO00=;
 b=Lmsr373tVsUPXJXaGvQZv99Z8QpPFjlDFtShSLA+VZS/trGASkNcumkV6pvm6/9fBy0dl9vVK
 A17congPgMrCHuBPmCnQtJn/6bzNzaYFniJ425lxP10TgYuc1BgRMO8
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Dimitrios Katsaros <patcherwork@gmail.com>

When scanning for the reset pin, we could get an -EPROBE_DEFER.
The driver would assume that no reset pin had been defined,
which would mean that the chip would never be powered.

Now we both respect any error we get from devm_gpiod_get_optional.
We also now properly report the missing GPIO definition when
'gpio_reset' is NULL.

Signed-off-by: Dimitrios Katsaros <patcherwork@gmail.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 3fb1b6251e6f8b361e8f82ce6381a7e8cfcd1935..58a6dfa228cc326d18b3c3f126732033749c8e49 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -1154,6 +1154,9 @@ static int adcx140_i2c_probe(struct i2c_client *i2c)
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
 						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(adcx140->gpio_reset))
+		return dev_err_probe(&i2c->dev, PTR_ERR(adcx140->gpio_reset),
+				     "Failed to get Reset GPIO\n");
+	if (!adcx140->gpio_reset)
 		dev_info(&i2c->dev, "Reset GPIO not defined\n");
 
 	adcx140->supply_areg = devm_regulator_get_optional(adcx140->dev,

-- 
2.47.3

