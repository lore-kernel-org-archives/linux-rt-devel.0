Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA223EA9B
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979729; cv=none; b=TDPU7YFmc5wk7/xy5ImUXy0CobTkB76XtpXjTRTG9NnhGJ6ThfrdIy0cLpCEOgd8NBBsEmaDGXspbN502jcweXLiVAXavh3d6otkfcgZEDDz5Z7625CRv9OExxtd4wYM7ucu7LKBbmqp4TIiLSvp8sSXYj6HMLqcbeGmckcATyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979729; c=relaxed/simple;
	bh=zPpdXJh32fTl/pow4D5Akokivv3EhcAmHbMnAg6Y7mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mr0nS4HU33vZFjnrRwicMpFeQ6AdRVnTgJuya3Y7CjICBMBeVDDQ08KCZksuqHmhTY2weK4sqNdEzS2/eC3+Yb9qQwYpUOsnzL2UiYINgL6Y56ePleZeZEMWyt4a7s+/wftcsporNV8kTjF8SA/jSYl0pLm/CXS4gtuHHr2oGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzW-00019A-Ag; Wed, 17 Dec 2025 14:54:58 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-0067Yr-3B;
	Wed, 17 Dec 2025 14:54:52 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-00000004tQv-3TDr;
	Wed, 17 Dec 2025 14:54:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Dec 2025 14:54:52 +0100
Subject: [PATCH 02/11] ASoC: tlv320adcx140: fix null pointer
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-sound-soc-codecs-tvl320adcx140-v1-2-293dea149d7b@pengutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765979692; l=4599;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=kXe/dgFdcFD3wr8yI0ZYTPwUBzycKle01oM0utMLno0=;
 b=mASLkyf2r4+++Rji8xl9SELvcrjt8wYwKM5P3eBVoJKP573Oi2rfJ7L93sx8WOKy4GJPQ/XI3
 H0MAG8C6UDjCtJjRyKSXxVo11cLg2HXr/Oarmzs0GT9VLuVv7ejdyD3
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

From: Emil Svendsen <emas@bang-olufsen.dk>

The "snd_soc_component" in "adcx140_priv" was only used once but never
set. It was only used for reaching "dev" which is already present in
"adcx140_priv".

Kernel OOPS:
[  438.223704] Unable to handle kernel read from unreadable memory at virtual address 0000000000000018
[  438.232776] Mem abort info:
[  438.235569]   ESR = 0x0000000096000004
[  438.239326]   EC = 0x25: DABT (current EL), IL = 32 bits
[  438.244646]   SET = 0, FnV = 0
[  438.247764]   EA = 0, S1PTW = 0
[  438.250906]   FSC = 0x04: level 0 translation fault
[  438.255788] Data abort info:
[  438.258669]   ISV = 0, ISS = 0x00000004
[  438.262509]   CM = 0, WnR = 0
[  438.265482] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046d3d000
[  438.271929] [0000000000000018] pgd=0000000000000000, p4d=0000000000000000
[  438.278731] Internal error: Oops: 0000000096000004 [#1] PREEMPT_RT SMP
[  438.278739] Modules linked in: veth md4 btnxpuart crc8 moal mlan iio_rescale fsl_imx8_ddr_perf snd_soc_wisa_rx cfg80211 imx8m_ddrc ads7828 snd_soc_tlv320adcx140 sr1xxDriver tsf ts5usba224 snd_soc_audio_graphs
[  438.278798] CPU: 1 PID: 64 Comm: kworker/u8:3 Not tainted 6.1.7-20231014-1-rt5 #1
[  438.278804] Hardware name: B&O mozart2 Seoul Rev c (UNKNOWN) (DT)
[  438.278809] Workqueue: events_unbound async_run_entry_fn
[  438.278823] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  438.278829] pc : adcx140_pwr_ctrl+0x90/0xb0 [snd_soc_tlv320adcx140]
[  438.278845] lr : adcx140_pwr_ctrl+0x58/0xb0 [snd_soc_tlv320adcx140]
[  438.278861] sp : ffff800009b7bcd0
[  438.278863] x29: ffff800009b7bcd0 x28: 0000000000000000 x27: ffff800009731c58
[  438.278870] x26: ffff000002365b74 x25: ffff000000102205 x24: ffff00000995dba8
[  438.278879] x23: 0000000000000000 x22: ffff000006d52080 x21: 0000000000000000
[  438.278890] x20: 0000000000000060 x19: ffff000006c97480 x18: 0000000000000000
[  438.278899] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000034
[  438.278906] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
[  438.278914] x11: 0000000000000000 x10: 0000000000000a50 x9 : ffff800008655f04
[  438.278925] x8 : 0000c63716b3149c x7 : 0000000000001980 x6 : 0000000000000000
[  438.278934] x5 : ffff800009014c60 x4 : 0000000000000000 x3 : 00000000ffffff92
[  438.278940] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000ffffff92
[  438.278952] Call trace:
[  438.278954]  adcx140_pwr_ctrl+0x90/0xb0 [snd_soc_tlv320adcx140]
[  438.278969]  adcx140_set_bias_level+0x30/0x50 [snd_soc_tlv320adcx140]
[  438.278985]  snd_soc_component_set_bias_level+0x2c/0x80
[  438.278995]  snd_soc_dapm_set_bias_level+0x60/0x1b0
[  438.279000]  dapm_pre_sequence_async+0x84/0xc0
[  438.279005]  async_run_entry_fn+0x38/0x150
[  438.279010]  process_one_work+0x1e4/0x490
[  438.279016]  worker_thread+0x64/0x410
[  438.279021]  kthread+0x128/0x130
[  438.279032]  ret_from_fork+0x10/0x20
[  438.279041] Code: 95e38c64 a94153f3 a8c37bfd d65f03c0 (f9400ea0)
[  438.327685] read channel() error: -110
[  438.327694] thermal thermal_zone4: failed to read out thermal zone (-110)
[  438.497842] ---[ end trace 0000000000000000 ]---

Fixes: 4e82971f7b55 ("ASoC: tlv320adcx140: Add a new kcontrol")
Signed-off-by: Emil Svendsen <emas@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/tlv320adcx140.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 75e1007012a48a569586bc2896400e79ddce1c71..3fb1b6251e6f8b361e8f82ce6381a7e8cfcd1935 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -23,7 +23,6 @@
 #include "tlv320adcx140.h"
 
 struct adcx140_priv {
-	struct snd_soc_component *component;
 	struct regulator *supply_areg;
 	struct gpio_desc *gpio_reset;
 	struct regmap *regmap;
@@ -699,7 +698,6 @@ static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
 {
 	int pwr_ctrl = 0;
 	int ret = 0;
-	struct snd_soc_component *component = adcx140->component;
 
 	if (power_state)
 		pwr_ctrl = ADCX140_PWR_CFG_ADC_PDZ | ADCX140_PWR_CFG_PLL_PDZ;
@@ -711,7 +709,7 @@ static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
 		ret = regmap_write(adcx140->regmap, ADCX140_PHASE_CALIB,
 			adcx140->phase_calib_on ? 0x00 : 0x40);
 		if (ret)
-			dev_err(component->dev, "%s: register write error %d\n",
+			dev_err(adcx140->dev, "%s: register write error %d\n",
 				__func__, ret);
 	}
 

-- 
2.47.3

