Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1D35CB77
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301956; cv=none; b=UzptqLshOgwXRnzys8SmEG+AxYgCQ0JIGqRN7OvyHshRN7N/AlBZwyn9NlTFgS3nfEW6EyZSWBLQTgrnJBC/h481FxFKlC5BxSeUFGgowBG1HfshqyCktYQlbiLQSyizSsKVFfhNXaUkIfL2m0CTbh2pkbIW+2/ZVsnd3iLStA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301956; c=relaxed/simple;
	bh=GMmXlHBjFf0Xdy6Kc2aDI2qKFJNMDm44ufSzcK3vwmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkKAULRpiSbLzrzym+vkjfIAQa3OpU5Tj7YMf9di8JTz4djtub4yPj4PwaIjvczEwbhbMysVlR/wz8ZlJh3FVX/PevHSCPWtjdnbAve5NIg5Q36RZGOdvkvxr6Sk0ji+Vk/obGnTcsvc8cJkdKy2UgaKgs00l+i7YY66+MC54lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc78-0008DH-Al; Tue, 13 Jan 2026 11:59:06 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc74-000PMJ-2e;
	Tue, 13 Jan 2026 11:59:02 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc73-00000004mJf-46Bf;
	Tue, 13 Jan 2026 11:59:01 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 13 Jan 2026 11:58:52 +0100
Subject: [PATCH v4 09/10] ASoC: tlv320adcx140: add kcontrol for num biquads
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-sound-soc-codecs-tvl320adcx140-v4-9-8f7ecec525c8@pengutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768301941; l=1192;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=B80SPpYYrd928XmCKz0MrXxcbEz/wYnv66aoOR2XOes=;
 b=P9LavGAcfo+Ds9DjMu9rqkoXRC9UkqsKaS1ircmFCnmVNj2oY2foZKwT52w/7VfaOg/2oy8Pp
 wPVjZw+3+SUDJZpJNcNM45jRQb0xkjYyAGsULA07BLtQqkyC5GHB2Y1
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil-Juhl <juhl.emildahl@gmail.com>

The tlv320adcx140 chips have a configurable amount of biquad filters
enabled per input channel. Currently this number is always left at the
default value of 2 biquads per channel.
This commit adds a kcontrol to allow runtime configuration of the amount
of biquads per channel.

The configuration is controlled by bits [5-6] in the DSP_CFG1 register.

Signed-off-by: Emil-Juhl <juhl.emildahl@gmail.com>
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

