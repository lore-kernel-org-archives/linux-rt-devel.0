Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232248;
	b=LgK6m5B4t3TOIsJ76l4cVaxk2ITdaqJgtD6knp+5B6bZXEbwUcriiDuC4RCQzwuwYs0v
	 YVfDfBV/wghqEGC2wVc33Yb24i3MjJ2II7TC2MFmuhMk3sUdQgt3IMKJrgdKXHEeMfA/p
	 X17SLq/0ebZTqsECaCeeX/iD+QyI3aZfcUCNOXGbr0mwC3ixLQ1ApFcNH3Las2WvouX74
	 K1nKywvcvn9GMUixnss0gLzphIcTbaiwbtYqtCzJiuGDv4w8xC2zNh0/yRcaD70Zg0NNr
	 PgVFMCTiQvfIJwYHoTMigH2DhtiAaSskDdBlQmTe12a929Vo06DpP4pFehlJMnh2BjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232248;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:CC:X-Mailer;
	bh=TSgT6T7A4AJYeCodDAhTvoJ93exX30UmjslAxvNT8Gs=;
	b=dYx/hbZC+VqwB3TiJQ8ah7hU25GszE8SiTcmWI6386SxVTkcPreMlYbDNdLtD9hpatGE
	 iONfk/k97c7nr5crI+l/qnROVGMSI4psdkHzSJUwutzzF8NNWSZ9KZ/yO63BsA38K6Mu1
	 B3GRchwaLG0sLYLZzUKTox/yCyCD/wPnoMLtmoYaygcj0qiWFJII3eb8+UBYy42bUDjLf
	 BDtf5/XbDid9xo+F03/Sdl1GU1aQHxQiFe9Wqu5Sxg2g4Vlnp51yiA/RfAwJadlXo5St1
	 yUideAONfBTzWYROnVGA7gbLkhW6XF6ZHYfxVKUwB1hxmB3yqgpa0aCuXb/8euc5lIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=lZhFXo+y;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BA606A31C
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 13:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=lZhFXo+y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794232255; x=1825768255;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=dlQEmgJ8iyz+elWQzgRIaC0oM/qYC6YLbKkqyuV9Q28=;
  b=lZhFXo+ydgl69I7884D6XJBQAd6qbhkb48bfiDVO1CKi5Mex2EaOCUaJ
   iwt9C4cf205yvmZqZmPY0XCreQ4uhSNsxibIRMB77Xqd4qtylhaL/eqFD
   DG7u3n7DSIKUxiz/SAsioaxu/5eOCIoHHHE8XQlbS/JIegFh0/Q+sfotW
   a92pGI1od17RwZtevKB1bIUczLum4o+0d1mBctPgK5bjlLcLkJAfrbRPz
   dvQRG5tDHPn44uRY1wmB4IhfcMC1maJvIiZjpXUSNupJg6Pl9geZs/HDY
   ct7Fu9l4TSKeRspXdZhX76Al4YNZZ72MTNx0a2RLs19PHExJQenrPIr9A
   w==;
X-CSE-ConnectionGUID: eBwMAOiVQaqHo3RiXecYPA==
X-CSE-MsgGUID: leRv61FUTguDGOA4i/uiOg==
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="297652651"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2026 06:50:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 9 Nov 2026 06:50:46 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Mon, 9 Nov 2026 06:50:43 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH 0/2] pinctrl: ocelot: fix the GPIO irqchip context handling
Date: Mon, 9 Nov 2026 14:50:40 +0100
Message-ID: <20261109-ocelot-pinctrl-irqchip-fixes-v1-0-9d2d8fcd58f5@microchip.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALDP8WoC/x3MQQqDMBBG4avIrDtggsTaq5QuJP7RAUnSiYgQv
 HtDlx8PXqUCFRR6dZUUpxRJscE8OvLbHFewLM1ke+uM6SdOHns6OEv0h+4s+vWbZA5yofA4ILh
 lsnDhSW2RFf/QDu/Pff8ASPTrNm4AAAA=
To: Linus Walleij <linusw@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Colin Foster <colin.foster@in-advantage.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Lee Jones <lee@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Two fixes for the GPIO irqchip of pinctrl-ocelot, where the irq_chip
callbacks take locks that are not allowed in the calling context.

The first makes the GPIO regmap use a raw spinlock. The callbacks run
with the raw spinlock irq_desc::lock held, where the spinlock_t of the
MMIO regmap is not allowed on PREEMPT_RT and is reported by
CONFIG_PROVE_RAW_LOCK_NESTING.

The second covers the regmap on a bus that can sleep, as for VSC7512
and lan9645x attached over SPI: the gpiochip is marked as sleeping and
the chained irqchip, whose callbacks run in atomic context, is no longer
registered.

The two patches are independent of each other. Both issues were
reproduced and the fixes tested on a lan9668 board (pcb8385), the
second with a lan9645x attached over SPI.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Jens Emil Schulz Østergaard (2):
      pinctrl: ocelot: use a raw spinlock for the GPIO regmap
      pinctrl: ocelot: do not use the chained irqchip behind a sleeping bus

 drivers/pinctrl/pinctrl-ocelot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
base-commit: ff00e5c03e7efe88f7a50a8673b14e8f0d4b45bb
change-id: 20261109-ocelot-pinctrl-irqchip-fixes-74ef6d92e6f8

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

