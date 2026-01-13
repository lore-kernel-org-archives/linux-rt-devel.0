Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC73803E1
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301957; cv=none; b=aITBvcXuE4/Df6LQS4l1bIq7y2JjSwcZUQ14E5bc9mmc8OjcqB9kT0hIYvGBSo/xxpvZegCwSHLh5QpTgzeJpX31pPfhKNKtLDv4Oi8XrSjJ9xxndSuo2c16sA7iQlPx0hYtNS8Rzc92tmdxnUj4S7QAyBWucVkhYkWBc4y8Qi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301957; c=relaxed/simple;
	bh=uI48RSG+a+nSuEyywiQ6swM+axk120OhOUA8CnTh+yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8ik/Pu0TYnK5dIJ8s1IsP5i4IHe+zAIDj3GN7D+bE9wPULgYD7x3RrXS2XIuPm/aigoyKp/prg2B41qMisOsANMHiY8A5EjYnP++bnB39M4lg2t465ABsKQZceWA4vMqqY9abM0zReUYHGUfSU0T6V3AZmVm/ezMBqAXHMIyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc78-0008DF-Al; Tue, 13 Jan 2026 11:59:06 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc74-000PMC-2b;
	Tue, 13 Jan 2026 11:59:02 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc73-00000004mJf-3p0Q;
	Tue, 13 Jan 2026 11:59:01 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 13 Jan 2026 11:58:44 +0100
Subject: [PATCH v4 01/10] ASoC: tlv320adcx140: invert DRE_ENABLE
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-sound-soc-codecs-tvl320adcx140-v4-1-8f7ecec525c8@pengutronix.de>
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
 Emil Svendsen <emas@bang-olufsen.dk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768301941; l=1278;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=WfOW2anrTgz/4XEyF51/kruoQkV8SVMulwmjlAzpc1c=;
 b=n9FTliga4EaJE1x7pWFw0Upb2MjvXIEiJw5Rf7Mx4Zjb3UN+jtqCTUADByhNGV4RZORIBDIrU
 xDcyIuVNUjKCBlAsIfiy9IUv8D0/DJHb8MLl7S8QyFFadNusYWYRs0c
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil Svendsen <emas@bang-olufsen.dk>

Looking at section 8.6.1.1.69 in datasheets for both 5140 and 6140 (3140
doesn't support DRE). REG ADCX140_DSP_CFG1 BIT 3 field "DRE_AGC_SEL" it
select either DRE or AGC.
It states:
 * 0 = DRE
 * 1 = AGC

The control is called "DRE_ENABLE" and for it to be true it has to be
active low.

This commit will invert the control so "DRE_ENABLE" is active low.

Signed-off-by: Emil Svendsen <emas@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 443cf59cb71ab3e70f47c4395159752a0331b1ef..75e1007012a48a569586bc2896400e79ddce1c71 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -338,7 +338,7 @@ static const struct snd_kcontrol_new adcx140_dapm_ch4_dre_en_switch =
 	SOC_DAPM_SINGLE("Switch", ADCX140_CH4_CFG0, 0, 1, 0);
 
 static const struct snd_kcontrol_new adcx140_dapm_dre_en_switch =
-	SOC_DAPM_SINGLE("Switch", ADCX140_DSP_CFG1, 3, 1, 0);
+	SOC_DAPM_SINGLE("Switch", ADCX140_DSP_CFG1, 3, 1, 1);
 
 /* Output Mixer */
 static const struct snd_kcontrol_new adcx140_output_mixer_controls[] = {

-- 
2.47.3

