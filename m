Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CD396573
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980533; cv=none; b=ttx8v5Hvb0SvxfuEUldGVFDGdMHdZNu4zz9GU9hjhZnNp3AiuuTGexDFeabLCszMuXO6esg57RxYCIFHcZI6Um32c7Y0v+oQaxmfbVHkMnxheaLKBG0fw/uy/BkWAtU/1dSjPH+ePYpH/WiW27rPI7hCYu3qVbCTqSUt/xrw1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980533; c=relaxed/simple;
	bh=psw6OIrwkaBiE2O7lF2QKi4RGG61GxTElFyh95uR00M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5LEPRcGPF4AuRcrXlKWZ+ySfqSQ+gigUSGqghabt4TzPA4WbVV5KPWxBwi/77CcYTIqzDREk4y/QcdgK0/GZdXA+59dUQY6zKAaKDHdki9bPrQgym4el1M1qZNo2wbfzKiQzwp4b00ZKNl5tA//xaf3aLGgFvjg9Qe0i5qzA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVs9r-0002Xr-2f; Wed, 17 Dec 2025 15:05:39 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVs9p-0067qh-2h;
	Wed, 17 Dec 2025 15:05:37 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-00000004tQv-3cL9;
	Wed, 17 Dec 2025 14:54:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Dec 2025 14:55:00 +0100
Subject: [PATCH 10/11] ASoC: tlv320adcx140: add kcontrol for num biquads
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-sound-soc-codecs-tvl320adcx140-v1-10-293dea149d7b@pengutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765979692; l=1159;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=u6go7JAZwUS7BsR7tvarSkNkpQtFGjP95RxpYP1aFUI=;
 b=kbvT+CYRnbHOLiJmG6qDWdGTPNduDWmbb9MTYG5yPUYxnFb7M1xLxwEew6xfcBLKnSDihN2xw
 1FYb/mOHyn3DhahXB9Eq/AG7RPnk/Zuef+PSjjxfSd1CwHGZM6KE/B9
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil-Juhl <emdj@bang-olufsen.dk>

The tlv320adcx140 chips have a configurable amount of biquad filters
enabled per input channel. Currently this number is always left at the
default value of 2 biquads per channel.
This commit adds a kcontrol to allow runtime configuration of the amount
of biquads per channel.

The configuration is controlled by bits [5-6] in the DSP_CFG1 register.

Signed-off-by: Emil-Juhl <emdj@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index a835074d9a7898466c6854f0c0e8ab687a99c57a..d8b6e6fafb68bc48ce9be01e2435bfecdb5bafc8 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -719,6 +719,8 @@ static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 	SOC_SINGLE("CH8_ASI_Slot", ADCX140_ASI_CH8,	0, 0x3f, 0),
 
 	ADCX140_PHASE_CALIB_SWITCH("Phase Calibration Switch"),
+
+	SOC_SINGLE("Biquads Per Channel", ADCX140_DSP_CFG1, 5, 3, 0),
 };
 
 static int adcx140_reset(struct adcx140_priv *adcx140)

-- 
2.47.3

