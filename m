Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB434DB58
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979729; cv=none; b=TNdX7qvy9luWA+V7RWFi2n3z1OnHINDBHPXLZWXWETItQqNu25Hw/x5hcpXXqnuiy4SdBJpw/xycsHjMU8qGwWUdNYalS/Dv4moiiD+t3V488+G3+zXk+Oh5yKGuBw5VwEUUCO2iRmP0qR+uav3gqAjMU4EjB7gbvvU2a+VQVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979729; c=relaxed/simple;
	bh=mufaNSnxOyOJaXre14Y6jf5ZcVEkcfur+VRINOEz6V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjIDNcEGTFspx2E9eUli1lmvgS1l1hAulZ2J5wrZUDz8iBtqfaY7c0nih1rZeulaMDbeNGp60A59B4tfITjaqJ++O4S6dLbHLZH0bMkWffsL0t+pgDha0TnGqnJhjIjmMrYA53LDe3s5kK+3jpLFZYEuEoUa91UwA1XGyvmSAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzW-00019G-Af; Wed, 17 Dec 2025 14:54:58 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzR-0067Z0-09;
	Wed, 17 Dec 2025 14:54:53 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-00000004tQv-3bQK;
	Wed, 17 Dec 2025 14:54:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Dec 2025 14:54:59 +0100
Subject: [PATCH 09/11] ASoC: tlv320adcx140: Add kcontrols for TDM Slot
 assignment
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-sound-soc-codecs-tvl320adcx140-v1-9-293dea149d7b@pengutronix.de>
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
 Andreas Sloth <anps@bang-olufsen.dk>, 
 Andreas Pehn Sloth <anps@bang-olufsen.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765979692; l=1243;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=/CKeb3D1C2I/QEaSoCCDRI6gq3lhbGRa4YCn/nWD5Kg=;
 b=+zTgmoquauS/t8FniXCXoxFBGV0jP1HkA+mYqbRY7+xWQfr8qlFceMARyv44s6YNJGZ7N/2aI
 fPJ21HKzRjdAmJmrnFTrAqTHh9sb9K4LuSEMiYoofUtKKk+tKdA3Q64
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Andreas Sloth <anps@bang-olufsen.dk>

Signed-off-by: Andreas Pehn Sloth <anps@bang-olufsen.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index a7200e149e5f40ddd61e3c0455b796c81f55e2e8..a835074d9a7898466c6854f0c0e8ab687a99c57a 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -708,6 +708,16 @@ static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 			0, 0xff, 0, dig_vol_tlv),
 	SOC_SINGLE_TLV("Digital CH8 Out Volume", ADCX140_CH8_CFG2,
 			0, 0xff, 0, dig_vol_tlv),
+
+	SOC_SINGLE("CH1_ASI_Slot", ADCX140_ASI_CH1, 0, 0x3f, 0),
+	SOC_SINGLE("CH2_ASI_Slot", ADCX140_ASI_CH2,	0, 0x3f, 0),
+	SOC_SINGLE("CH3_ASI_Slot", ADCX140_ASI_CH3,	0, 0x3f, 0),
+	SOC_SINGLE("CH4_ASI_Slot", ADCX140_ASI_CH4,	0, 0x3f, 0),
+	SOC_SINGLE("CH5_ASI_Slot", ADCX140_ASI_CH5,	0, 0x3f, 0),
+	SOC_SINGLE("CH6_ASI_Slot", ADCX140_ASI_CH6,	0, 0x3f, 0),
+	SOC_SINGLE("CH7_ASI_Slot", ADCX140_ASI_CH7,	0, 0x3f, 0),
+	SOC_SINGLE("CH8_ASI_Slot", ADCX140_ASI_CH8,	0, 0x3f, 0),
+
 	ADCX140_PHASE_CALIB_SWITCH("Phase Calibration Switch"),
 };
 

-- 
2.47.3

