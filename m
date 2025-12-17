Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC01FBEA8
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979729; cv=none; b=gVHxGRXcmri9aGfvsUIhSgsqvNs2xBtM9APuFlzGhrBpPQ8gm9qDacREiRG4VYrVanAMd23oPIQuw6VhqBfsxlK/Q4dZusiWKkB0ba5nkyHDyculZ2M8jtLAWPBlN+6KOFVaRlB0AnYtdObkrGn8rs6UgfB9FSVVsRmNbEgy4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979729; c=relaxed/simple;
	bh=pZIFlRIVLpcCvJfJFXahTVH85kCg+833Wa7DyItgKlk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g75tLrYGgM0Vshc1rhAIXlRuDy3deMuFu9Ed9zr+HsURsskkbMIerVUZ4x9n+5RlbrOKUXGKWXs7dmA2buCDveNEnnEivSSp2p5OuQ344jm8SmzRc0OQQ+WRJ4h/xgq4VbKXRNbOf14XhAp+06047sj3R6V/up2fJZ9pyjwQdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzW-00019I-Aw; Wed, 17 Dec 2025 14:54:58 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzR-0067Yt-09;
	Wed, 17 Dec 2025 14:54:53 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vVrzQ-00000004tQv-3RD4;
	Wed, 17 Dec 2025 14:54:52 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 00/11] sound: codecs: tlv320adcx140: assorted patches
Date: Wed, 17 Dec 2025 14:54:50 +0100
Message-Id: <20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACq2QmkC/x2NQQrCQAwAv1JyNrAbq61+RTysSaoB2ZVNLYXSv
 7t4GZjLzAau1dTh2m1QdTG3kpvEQwf8SvmpaNIcKNApUhzQyzdLIyMXUXacl/eRQhJeYx8wjUJ
 67i+PaRihRT5VJ1v/g9t933/XKrmZcAAAAA==
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
 Emil-Juhl <emdj@bang-olufsen.dk>, Andreas Sloth <anps@bang-olufsen.dk>, 
 Andreas Pehn Sloth <anps@bang-olufsen.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765979692; l=1417;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=pZIFlRIVLpcCvJfJFXahTVH85kCg+833Wa7DyItgKlk=;
 b=qiwrU1S12h5L0krGzhFGQZgF3qeR6m5ZXlrNhHpUUBv7xDMBqsbCtXcwhISryj3AzmFAaFj1I
 hHkbJD4zDuFAXdgJzUI7y7KTCb9jLGUi3Ihoal3anJxwIM66XavaQmU
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
Andreas Sloth (1):
      ASoC: tlv320adcx140: Add kcontrols for TDM Slot assignment

Dimitrios Katsaros (1):
      ASoC: tlv320adcx140: Propagate error codes during probe

Emil Svendsen (4):
      ASoC: tlv320adcx140: invert DRE_ENABLE
      ASoC: tlv320adcx140: fix null pointer
      ASoC: tlv320adcx140: fix word length
      ASoC: tlv320adcx140: add channel sum control

Emil-Juhl (4):
      ASoC: tlv320adcx140: implement register caching
      ASoC: tlv320adcx140: add avdd and iovdd supply
      ASoC: dt-bindings: clarify areg-supply documentation
      ASoC: tlv320adcx140: add kcontrol for num biquads

Sascha Hauer (1):
      ASoC: dt-bindings: add avdd and iovdd supply

 .../bindings/sound/ti,tlv320adcx140.yaml           |  14 +-
 sound/soc/codecs/tlv320adcx140.c                   | 159 +++++++++++++++++++--
 2 files changed, 163 insertions(+), 10 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251217-sound-soc-codecs-tvl320adcx140-a8d2e649bf78

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

