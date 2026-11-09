Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232250;
	b=xT2OLXSiKXW2XrhD6fRRRQMNVTAFtBjiA99emXf4jL3VWeM/TJy4LhF92kzj3fD4py/E
	 M3aIADEzqd8BGE4bJtmnSoficVVqtbM6VxGgNkHVqM1V+Vz7mKO57E7gA6KR6PQJ83gvg
	 ho9T2MMtvKzWIr5x/gHedGmi0xSFoL8WKEqOV8TTt6lPLciHZ1xY0QtFkjujaz08cQWGd
	 mUXpnhcHMLJh9KyI8QRcX6yCgVQscP5yEzKESFzmJ3jyLNHVyMhMc8ud9WQy7nVxrKGOA
	 AocBbNhyO9OY17O6LvmQ092t61Gamx5zQkz6a3GA7SZcUkqY0FSSgBVq7m/+Y1HfDpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=Bl68v6AQmdy9LATqa8bH4NaYM8uVN43V3tqfcoPsZk8=;
	b=otaLM+2bgIVURdaXoVO+TSn1mZLoU1nANkxYufHqf/6t3Nh1oEuSpu8mS5eDr2Biq2hm
	 rhwgb0Fi3KxpzqNyeg7+68J6DV7cSbbHTiUZKy0hDlagEDIUDiIdEJLvfkQfCVXLaD32l
	 Yqx0Pplrg1VhSKOSegYH1GhgHymejWnLBrWarUZqjB7uAAWpzZfW2oP5SIn6m43n9IS4m
	 QJLT2JYOZwipfHZUbwF4gyNJP6i9xcRXhNySRhtgV2GgAAZACGySQlCBNT6ELyU0LuEAN
	 74PzXnjoePZbua/jlwvzfgF0Z+2DWCm9TUkXjPrgus9nubwhSt4ocgcKJhukeNRNw/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=By1cDuka;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAB606A31C
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 13:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BFAB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=By1cDuka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794232251; x=1825768251;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nrAlFCLW07+2sEmBtO62a1rx9erwWQ2Zh2QS6iwHBK8=;
  b=By1cDuka2UvAuxQ/Jv4LosYeUUDU15PMg5jMFv9Z1rPiSBXcAnKbWx0D
   auufsKK2FLdQp6o3I+d4C034cBn+frn75IJIDrHJGwduC5+SWojGHDWUt
   2dUaN31qySV/BUuUxi480jXp9jrNZvYmPr0GrGg8bI56whIOAqpn9n/69
   Tc8VzwnPTqXw3KKtE7arm53NGot4pWpTvOUkn5ZCucJfIM7wiFxGRzEpu
   7OAQV73iyuHZEpAsdr9Qkall0zGAttepA1dl3Ic5+wYex/4U6MNxlMkQ7
   /XQpEk8FZjFA5ObWqsSsc/D7FW32rxT/6Jx5lrtrqbmXM3R9A3gzjyB16
   A==;
X-CSE-ConnectionGUID: Q4CC4mckTnmsemi2mUAnJQ==
X-CSE-MsgGUID: bwGoyQICSricOX3tZXXf/w==
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="66234039"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:50:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 9 Nov 2026 06:50:48 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Mon, 9 Nov 2026 06:50:46 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 9 Nov 2026 14:50:41 +0100
Subject: [PATCH 1/2] pinctrl: ocelot: use a raw spinlock for the GPIO
 regmap
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
Message-ID: <20261109-ocelot-pinctrl-irqchip-fixes-v1-1-9d2d8fcd58f5@microchip.com>
References: <20261109-ocelot-pinctrl-irqchip-fixes-v1-0-9d2d8fcd58f5@microchip.com>
In-Reply-To: <20261109-ocelot-pinctrl-irqchip-fixes-v1-0-9d2d8fcd58f5@microchip.com>
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

The irq_chip callbacks .irq_mask, .irq_unmask and .irq_ack access the
GPIO regmap. genirq calls them with the raw spinlock irq_desc::lock
held, for example from irq_startup() in __setup_irq(). The regmap is
created with devm_regmap_init_mmio() and guarded by a spinlock_t, which
is a sleeping lock on PREEMPT_RT and must not be taken under a raw
spinlock.

Make the GPIO regmap use a raw spinlock. Its accesses are short MMIO
reads and writes. The other regmaps of the driver are not used from the
irq_chip callbacks and are left unchanged.

The issue was found with CONFIG_PROVE_RAW_LOCK_NESTING on a lan9668
board (pcb8385), when a level low interrupt on one of its GPIOs is
requested, and was seen on lan969x when a PHY interrupt on a GPIO is
requested:

  =============================
  [ BUG: Invalid wait context ]
  -----------------------------
  swapper/0/1 is trying to lock:
  c3046c10 (pinctrl_ocelot:34:(config)->lock){....}-{3:3}, at: regmap_lock_spinlock+0xc/0x40
  other info that might help us debug this:
  context-{5:5}
  locks held by swapper/0/1: 6, last CPU#0:
   ...
   #4: c3200b5c (request_class){+.+.}-{4:4}, at: __setup_irq+0x140/0x840
   #5: c3200a7c (lock_class){....}-{2:2}, at: __setup_irq+0x168/0x840
  stack backtrace:
  ...
   _raw_spin_lock_irqsave from regmap_lock_spinlock+0xc/0x40
   regmap_lock_spinlock from regmap_read+0x2c/0x80
   regmap_read from ocelot_irq_unmask_level+0x6c/0x240
   ocelot_irq_unmask_level from irq_enable+0x38/0xc0
   irq_enable from __irq_startup+0x70/0xc0
   __irq_startup from irq_startup+0xb8/0x180
   irq_startup from __setup_irq+0x4d0/0x840
   __setup_irq from request_threaded_irq+0xbc/0x180
   request_threaded_irq from devm_request_threaded_irq+0x70/0x140

With the fix the report is gone on the lan9668 board.

Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 58d3cde9f964..06dd49782d74 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -2440,6 +2440,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 		.reg_bits = 32,
 		.val_bits = 32,
 		.reg_stride = 4,
+		.use_raw_spinlock = true,
 	};
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);

-- 
2.52.0

