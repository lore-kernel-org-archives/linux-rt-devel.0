Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622E258CE5
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082126; cv=none; b=ctefsbtOR1lzu4LJtPjBoHQnQGA1CTDFVdai/zRFvumwGTS6oWmmRToSq7NTYvwI27uRWO0zQGZJDG2Lwr37JAj02kRJCqvQjUVkM0jZWHQI8bhtQr0HJYeezwSEAoFccchMkrNCKXLMz3v9Ud2fRAtmFpucaAz0bpgZRCGGVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082126; c=relaxed/simple;
	bh=sMAOvxmCw6OmDAyaMZWgESnKkBLUiDQChGiH/5dU728=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsw5JIwtlVQ2sODgeW7xOFygTOBSRk+II4e8UFbs+sHQ5HbBVA8oqZvi03lA/lmKcyvJhjbp/ctLcpJt9TlATjEQpHvjF5PB+VspFeSRUy5OOEEcjkss9vwqsMW8dGDQWvIg6p1RN4PYS3e1QrToYz4AkhDnuraax2cXKv5z/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWIdV-0003AG-2E; Thu, 18 Dec 2025 19:22:01 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWIdP-006KXW-2f;
	Thu, 18 Dec 2025 19:21:55 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWIdP-00000002wYr-2U0v;
	Thu, 18 Dec 2025 19:21:55 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 18 Dec 2025 19:22:02 +0100
Subject: [PATCH v3 08/10] ASoC: dt-bindings: add avdd and iovdd supply
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-sound-soc-codecs-tvl320adcx140-v3-8-70ff66e5b93f@pengutronix.de>
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
 devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766082115; l=958;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=sMAOvxmCw6OmDAyaMZWgESnKkBLUiDQChGiH/5dU728=;
 b=OK8kIkQA4Q0iYOYUSVPisfxG75rucqH6ENRAXGK5CqyulhFxXYy9qKID2+228+9fPU25qHNTH
 mRH52UcR+yxAlp43hQF19zWSqUlPiM27lsYySGcoOuVn9Y4vesoc586
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-devel@lists.linux.dev

Add bindings for the avdd-supply and iovdd-supply which are named after
the corresponding pins on the tlv320adcx140 chips.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
index b34ea7824360310434d8b826392864dbfa5fc369..a93de2debbb45a3daebb0e24397e4893262e3a11 100644
--- a/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
@@ -44,6 +44,9 @@ properties:
       External supply of 1.8V. If not defined then the internal regulator is
       enabled instead.
 
+  avdd-supply: true
+  iovdd-supply: true
+
   ti,mic-bias-source:
     description: |
       Indicates the source for MIC Bias.

-- 
2.47.3

