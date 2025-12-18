Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8C28689A
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070279; cv=none; b=fPIPaLzI348qJ6KNmxsN4fzIXwHhqrDbc7ZHTxIFuwwref7qaW8sa6gs9rSiuwSPw6CEtGYn+8Lv1QrjFZ94JqWcinxZzf2oRfR/B3vZRcT8LlGrufropxn6AI1lL7jnmfw3UQ4b833ZcTN5KG4eLywq28WIO6qEiJ8d90dr4Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070279; c=relaxed/simple;
	bh=qcmcfZEIlFcWuH8O6//zI+Eh0dn5AfQ8w4FItXEukno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojfacE1+HxjHaSDlM3cMXFlsdjG9YIp8h+a+zabE5JdmkPTNsg9D/IjEKhDrtgGLQUWgqPtAFYTsow2XqP6CVnuwHf+Hnp2F7QCkt1zRBOb5AvbjPR/QG+kWWZAsjjdrSCOXIZ9bBr2LxB4vVYTOAaTBizTRIoa1DpL4hHttzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY4-0007j4-Oa; Thu, 18 Dec 2025 16:04:12 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY1-006IfP-24;
	Thu, 18 Dec 2025 16:04:09 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1vWFY1-00000002kPh-1yly;
	Thu, 18 Dec 2025 16:04:09 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 18 Dec 2025 16:04:14 +0100
Subject: [PATCH v2 08/10] ASoC: dt-bindings: add avdd and iovdd supply
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-sound-soc-codecs-tvl320adcx140-v2-8-3c2270c34bac@pengutronix.de>
References: <20251218-sound-soc-codecs-tvl320adcx140-v2-0-3c2270c34bac@pengutronix.de>
In-Reply-To: <20251218-sound-soc-codecs-tvl320adcx140-v2-0-3c2270c34bac@pengutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766070249; l=948;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=qcmcfZEIlFcWuH8O6//zI+Eh0dn5AfQ8w4FItXEukno=;
 b=lgIUxAGJvhP5uCXlbIoIqRA1zCQqoh6Mq6Yp4QRmPukihQFsZ1mB76e2jj94y1TgQUCzvUboo
 i1Vw4st+aJnDtSDryvtMPNA25t4ia+vlfX/npoZuRfzKYdMt05UCdxf
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
index b34ea7824360310434d8b826392864dbfa5fc369..2931d536d7129e6a88eafbb6c45d00f50bbc7d5b 100644
--- a/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
@@ -44,6 +44,9 @@ properties:
       External supply of 1.8V. If not defined then the internal regulator is
       enabled instead.
 
+  avdd-supply:
+  iovdd-supply:
+
   ti,mic-bias-source:
     description: |
       Indicates the source for MIC Bias.

-- 
2.47.3

