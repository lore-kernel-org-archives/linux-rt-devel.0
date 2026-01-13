Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9843557E0
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301957; cv=none; b=Z6Lz8WRDKmt7R6AFhcEtBnSqnmIXqxUO8k78LrKsWl9onk250TuzI7GWzdbrmyxMuFDdgtNwnt7y09S1f7vACajbiRJTXlmkfOIkmsw7tW8giXpIBx4qqBZLGLXYOJkwGLMDkMTYS0K+QppK02+GECXzpZ81GhJJFZccv5Ry5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301957; c=relaxed/simple;
	bh=vblqQcQCmptj0E/naq0Xulsg8sqiLk4QFOOLVzvMTM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBPRiiLkUTo3Da1HVmR0/I/Jz8P1jJzr8QZ+I2lriJYK44NxdPnrXRN+nPVq6+CGi3gXOMebOetgcn7cHVbs2RIGTI9DnAT6Z8u03uVPSgraOfrfJ8J3rGfiJBnIz3JF4If3tiqcetdl3YQyJawT1MlwC+8nI8WdxaIXuGTw388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc78-0008DI-Ak; Tue, 13 Jan 2026 11:59:06 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc74-000PMD-2c;
	Tue, 13 Jan 2026 11:59:02 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vfc73-00000004mJf-3mfZ;
	Tue, 13 Jan 2026 11:59:01 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 00/10] sound: codecs: tlv320adcx140: assorted patches
Date: Tue, 13 Jan 2026 11:58:43 +0100
Message-Id: <20260113-sound-soc-codecs-tvl320adcx140-v4-0-8f7ecec525c8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMlZmkC/5XNwQoCIRDG8VcJzxk62rrbqfeIDq6OJYSGbrKx7
 LvndgoKqsvAfw6/byIZk8dMdquJJCw++xhqyPWKmLMOJ6Te1ibAYMuBK5rjLdh6DTXRosl0KBc
 BTFszcsmobi1gI7veqZZU5JrQ+fE5cDjWPvs8xHR/7hW+fH+mC6eMQicsai47q/r9FcPpNqQY/
 LixSBa/wKvZfjWhmsIAKGaE7LX5aIr/TFFNxZxrGtz2nXBv5jzPD5DFVjF5AQAA
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
 Emil-Juhl <juhl.emildahl@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768301941; l=2242;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=vblqQcQCmptj0E/naq0Xulsg8sqiLk4QFOOLVzvMTM8=;
 b=McoY+CtUMhK3LUBObK9Qo94P3R2PQ6nz+JiB26oKTl3CosWMudNPMa+SGHKkh7XBOH/KbexIU
 nTx/Fm+DXTCB0mlrrgJXiq95bexCJpWC01WAKjcDz+lajgzb0pedxI8
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
Changes in v4:
- add Acked-by Krzysztof Kozlowski to 08/10
- consistently use Emil-Juhls new mail address
- Link to v3: https://lore.kernel.org/r/20251218-sound-soc-codecs-tvl320adcx140-v3-0-70ff66e5b93f@pengutronix.de

Changes in v3:
- Add missing "true" for regulator
- Link to v2: https://lore.kernel.org/r/20251218-sound-soc-codecs-tvl320adcx140-v2-0-3c2270c34bac@pengutronix.de

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
base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
change-id: 20251217-sound-soc-codecs-tvl320adcx140-a8d2e649bf78

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

