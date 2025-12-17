Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2788396574
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980533; cv=none; b=ZTKMrlplDf1gZ6ubvdr+Xnd1GF0Dl9KtDqmx3wpym5r9FjsqcIBfmACjz/KnjOFi6B0UTsDQdjEF4Y2QYtEc3/RTPWBvnT0qT8F+iVafvgYHVCKkCskiHMd3x9SmXHtjlVaK7vEbCBeWcbLwq0QFoNrsFSbrIBmzg4bv6wOZ0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980533; c=relaxed/simple;
	bh=x4MhiHIBxXZT/JGnBW6uY17eLmz9TncIJc1+KlFk9mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gWg+XF8YPN8HsrhPRInZPTxP4btnE2YsoSPRfCOnqYwUyb15U9KAlFUIxaZszhdcVb7H0vwLm6eLuMSHu5e5j5tkXZ9tooydFf95Zp5ja8e4aUikSQCqDDevgbjzIB5LmIN9D10XVwSJRd0FhcqAjH128zEHeDV0CD90XsCsnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVs9r-0002Xq-2f; Wed, 17 Dec 2025 15:05:39 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVs9p-0067qe-2H;
	Wed, 17 Dec 2025 15:05:37 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-00000004tQv-3enP;
	Wed, 17 Dec 2025 14:54:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Dec 2025 14:55:01 +0100
Subject: [PATCH 11/11] ASoC: tlv320adcx140: add channel sum control
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-sound-soc-codecs-tvl320adcx140-v1-11-293dea149d7b@pengutronix.de>
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
 Emil Svendsen <emas@bang-olufsen.dk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765979692; l=1805;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=B4XLlj4yXAj1cRuxwpnqVGmABzsNU6rXcpOes817Bdk=;
 b=sWuf6hpTwFoOGIfSt9ZVGZCUgGhRW8zvVEmA1ODx2tyZ3UobRD+0KXCTA5KuoehvSD5nGGASF
 ZHfPacU4NnIDNq5oFKty+5CrxmzbX1+vq8fPGsP9ouPfD90Q6S4k+S5
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil Svendsen <emas@bang-olufsen.dk>

Add control for channel summation.

3 modes are supported:

1. "Disabled": Normal operation

2. "2 Channel": Every two channels are summed and divided by 2

  Out 1 <- (CH1 + CH2) / 2
  Out 2 <- (CH1 + CH2) / 2
  Out 3 <- (CH3 + CH4) / 2
  Out 4 <- (CH3 + CH4) / 2

3. "4 Channel": Every four channels are summed and divided by 4

  Out 1 <- (CH1 + CH2 + CH3 + CH4) / 4
  Out 2 <- (CH1 + CH2 + CH3 + CH4) / 4
  Out 3 <- (CH1 + CH2 + CH3 + CH4) / 4
  Out 4 <- (CH1 + CH2 + CH3 + CH4) / 4

Signed-off-by: Emil Svendsen <emas@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index d8b6e6fafb68bc48ce9be01e2435bfecdb5bafc8..4f7d2a771a272a23050616a3a6db473f69ee752e 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -222,6 +222,13 @@ static const struct snd_kcontrol_new decimation_filter_controls[] = {
 	SOC_DAPM_ENUM("Decimation Filter", decimation_filter_enum),
 };
 
+static const char * const channel_summation_text[] = {
+	"Disabled", "2 Channel", "4 Channel"
+};
+
+static SOC_ENUM_SINGLE_DECL(channel_summation_enum, ADCX140_DSP_CFG0, 2,
+			    channel_summation_text);
+
 static const char * const pdmclk_text[] = {
 	"2.8224 MHz", "1.4112 MHz", "705.6 kHz", "5.6448 MHz"
 };
@@ -721,6 +728,8 @@ static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 	ADCX140_PHASE_CALIB_SWITCH("Phase Calibration Switch"),
 
 	SOC_SINGLE("Biquads Per Channel", ADCX140_DSP_CFG1, 5, 3, 0),
+
+	SOC_ENUM("Channel Summation", channel_summation_enum),
 };
 
 static int adcx140_reset(struct adcx140_priv *adcx140)

-- 
2.47.3

