Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCB2D6E63
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070279; cv=none; b=ujsfY5JBeDo5c1tdT+QWGLOioB+FvrhISPtuoawVul7nVOlqbTGeo+NBl07oWgzKW1y+L766umM40zqyIcBgDCrBZKgvzYRHn5AltoM/yxDSLh1wXgSWAN2ijhgwLqdXhudgAgk6iDTM0FWzDXjAoNRc9gbBcmhhS1PW9PaKbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070279; c=relaxed/simple;
	bh=1qaJy32Pd0EFYm8hp3as/rFU8J0Uc6xsfp3DVkt6ijo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=do+izWE64Gfs1HZwyWYa9WoZCPCxgbmSr98AyG/XSbm1e7gv4XaozhduMGcfw9s+6Q+IL60lNyLAbhbTZaPw52STVjKoAAY/aD7IWqutTnM1rZ7KXRb/8L8EiveVH7+lYNEYC19Tt4ls4KGNptnjMka4hRk206NxIojuD/X7wF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY4-0007j3-Og; Thu, 18 Dec 2025 16:04:12 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY1-006IfI-1t;
	Thu, 18 Dec 2025 16:04:09 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY1-00000002kPh-1lUT;
	Thu, 18 Dec 2025 16:04:09 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 00/10] sound: codecs: tlv320adcx140: assorted patches
Date: Thu, 18 Dec 2025 16:04:06 +0100
Message-Id: <20251218-sound-soc-codecs-tvl320adcx140-v2-0-3c2270c34bac@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOYXRGkC/42NQQ6CMBBFr0K6tqYdUMCV9zAsSmeASUxLWmgwh
 LtbOYGbn7y/eG8XkQJTFI9iF4ESR/YuA1wKYSfjRpKMmQUouGnQtYx+dZjXSuuRbJRLepegDNp
 NV0qaBoHuVdsPdSOyZA408HYGXl3miePiw+fsJf17/1YnLZWEtkQyumqx7p8zuXFdgne8XZFEd
 xzHF/re3MjRAAAA
X-Change-ID: 20251217-sound-soc-codecs-tvl320adcx140-a8d2e649bf78
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
 Emil Svendsen <emas@bang-olufsen.dk>, 
 Dimitrios Katsaros <patcherwork@gmail.com>, 
 Emil-Juhl <emdj@bang-olufsen.dk>, Emil-Juhl <juhl.emildahl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766070249; l=1849;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=1qaJy32Pd0EFYm8hp3as/rFU8J0Uc6xsfp3DVkt6ijo=;
 b=eiD0FH+PVCaelj59RjHbg+qIR6pyFJQ432Xo832x8p17CGYJo+jnz/Xna3UfX0qJbp5RfH6or
 E7p/BJ38cPbBlPhrwDZ11U4SV0+raV/2LO05gXp760m59SGYbsIcLJy
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

These are some patches for the tlv320adcx140 codec we are carrying
around for a while, time to upstream them.

First four patches are fixes. The following four add regulator support
for AVDD and IOVDD. The remaining three patches add more controls to the
driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v2:
- drop "Add kcontrols for TDM Slot assignment", wrong way to control TDM
  slot assignment
- drop overlong and unnecessary backtrace from commit message
- drop unnecessary descriptio for regulator in binding
- improve commit message for "ASoC: tlv320adcx140: implement register caching"
- change order in dt-binding patches to fixes first
- Add missing S-o-b Emil Juhl
- Link to v1: https://lore.kernel.org/r/20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de

---
Dimitrios Katsaros (1):
      ASoC: tlv320adcx140: Propagate error codes during probe

Emil Svendsen (4):
      ASoC: tlv320adcx140: invert DRE_ENABLE
      ASoC: tlv320adcx140: fix null pointer
      ASoC: tlv320adcx140: fix word length
      ASoC: tlv320adcx140: add channel sum control

Emil-Juhl (4):
      ASoC: tlv320adcx140: power on/off the device on demand
      ASoC: tlv320adcx140: add avdd and iovdd supply
      ASoC: dt-bindings: clarify areg-supply documentation
      ASoC: tlv320adcx140: add kcontrol for num biquads

Sascha Hauer (1):
      ASoC: dt-bindings: add avdd and iovdd supply

 .../bindings/sound/ti,tlv320adcx140.yaml           |   7 +-
 sound/soc/codecs/tlv320adcx140.c                   | 149 +++++++++++++++++++--
 2 files changed, 146 insertions(+), 10 deletions(-)
---
base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
change-id: 20251217-sound-soc-codecs-tvl320adcx140-a8d2e649bf78

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

