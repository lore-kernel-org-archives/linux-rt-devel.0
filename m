Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B303308F30
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082142; cv=none; b=OJve2vMXVBU0R8c/x9zZtAmoAoAI8LMV3xg8yJNQb4Q6D7NW6qJvv36o1TaPPeuxGv2O5ByyB8B1FhwiVThXgKP7aqfpnuYoYtPGwHgkCO8z1NENkBKrrXRtUorUwSlT+MhCHKoLDY1TlmLk+3cDmH7FpCIpfIVmhcpjBjN+l3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082142; c=relaxed/simple;
	bh=BftEMXNe9b9u5qp4tnrpwQrsP8OnPjgSNlWWBG1pYyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHKbNKkJRd78G0p4Rp3yT6YduxH3hfl+kUbCMnq8cOVabGxmUdslrLStmVYjX+81CH5CXZIUDOciJ0dU6+YVo16Ej8pR1F4ze/yBH4fZecYGZDzbc0o0hIrAeVAOiLFIdw0KpXbLRowpoVG+gG/G6OKgSTMpPCQKxjvS6888Xxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWIdV-0003AF-2G; Thu, 18 Dec 2025 19:22:01 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWIdP-006KXX-2c;
	Thu, 18 Dec 2025 19:21:55 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWIdP-00000002wYr-2VDZ;
	Thu, 18 Dec 2025 19:21:55 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 18 Dec 2025 19:22:03 +0100
Subject: [PATCH v3 09/10] ASoC: tlv320adcx140: add kcontrol for num biquads
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-sound-soc-codecs-tvl320adcx140-v3-9-70ff66e5b93f@pengutronix.de>
References: <20251218-sound-soc-codecs-tvl320adcx140-v3-0-70ff66e5b93f@pengutronix.de>
In-Reply-To: <20251218-sound-soc-codecs-tvl320adcx140-v3-0-70ff66e5b93f@pengutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766082115; l=1189;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=qc2dQpr272s/at2Ej519T5bc2Pd27yFq5qfLTQIbZ5w=;
 b=WlSZaGBOafxq3tHe0aRZ+fNbSm54GYgnCmv423Hd3A5eOMWpp2BkIF1k6NyFENccnquN148ei
 RpUlUHDFXd2DqJnqqIunQhIgAQdz9eHgtpvP7D1aOgsZFriQeRvcSv7
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
index a7200e149e5f40ddd61e3c0455b796c81f55e2e8..e7c607af642f43b2b783597f3cba3a8cbb31de4a 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -709,6 +709,8 @@ static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 	SOC_SINGLE_TLV("Digital CH8 Out Volume", ADCX140_CH8_CFG2,
 			0, 0xff, 0, dig_vol_tlv),
 	ADCX140_PHASE_CALIB_SWITCH("Phase Calibration Switch"),
+
+	SOC_SINGLE("Biquads Per Channel", ADCX140_DSP_CFG1, 5, 3, 0),
 };
 
 static int adcx140_reset(struct adcx140_priv *adcx140)

-- 
2.47.3

