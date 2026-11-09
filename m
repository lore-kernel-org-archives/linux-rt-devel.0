Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232253;
	b=0h4+JO63WD1LRPDRS0QwxnJ/lDD+R+avEX/3OEatzGRdAXSf15igi87qEcB27yyB43bz
	 SbWsg1LQk/k6l6s2M7Mu4pTE3Ct5FRWlLkdJRc+h7ULN6d+sbypbUMRG31/WdKcLw8Zfl
	 kc7zUDDUNIf+knVjMi3ti4Dcg89K3MwTSC8+zdpyaa6QMMSexuQJy+LY7QYNE85BqTi3H
	 N9MIcOEODptqL1Ix/WBWbzEYG3YMKldRoMReEFp7X2il1XbLqV++BkI6GqmXI7A82aYet
	 nUogmeIeGGYkVEtmR8X8Ddi/F8IpSxJydwMm/XmRxNwWEAb9vBgbdBtJ/88l++FZMjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232253;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=cchdRIXdDH+ZuqONJcFyi585VFaLRrBDFUIV1dNlKj4=;
	b=LWGhML0u0rcXO+XrEaP9CoqhSQZPoyhhj/vftFYvHQbgqdbiCsAxx0+bCqoaiq9MWP5g
	 905bJ3WiEbAw7FhyyH9Uw3Q13sHIxb0eSUdQlDE3fudukACtmSD3+IIBNMblzsxSeTpEE
	 NRU8H/oAfLoOVkvF+SOF94wUOxs1rw+bRU/99pJZ9orUC1vv8HHnH/9u2Pw/hNPmr+6mP
	 Fs2r5/37dXu9Ky5yuxsTsQkUsQ4F+IUqOTJ5LIxQYnf7o5rb4BmUDu/MNG1t8r1TEj5cE
	 CBPM73YA0JOi0iuMwLT4UGPnTwN30wsLOWnG8IDpLb2ZITHxnN6OzyB1NHgju8BrwUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ZBGiZ0Gg;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13788606D804
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 13:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13788606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ZBGiZ0Gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794232252; x=1825768252;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KJ7nI+y2+3u6aGJ43OEkoFlybCeTRkkOnnAS1Nj96MM=;
  b=ZBGiZ0Gg7D9U30/UxPH1JMlYqDP5Z8uBRifltmS5VHciAjEhcpikOK1j
   zlE3p9poY1+OjqxpZpCg4KOUj6wCxhmWPI7dhqHUurj8Jrsjg3ZxY1v0z
   et6JU2WxI69bnXL8tD+mPtC0586P8Wxffg3e+4AWl7H6SNZxur74epQyR
   20NxCbGa/5YqgMnHXvhHs3zV51Z74JrZGSBDBTc1hQ1xwG4eWhHRZanUU
   zJ0NlQA2id6HyfODOc5XLJkA1kGWXb6qP7H7hC5lrwdqiFpuMg1lrSgHI
   MERJ01nkN5gwksN45vaaelK0b0chy8IHe8M9tLV+93EcS4D5DJmPlPMOs
   w==;
X-CSE-ConnectionGUID: Is88lAHeTUi8yYLOizdCUw==
X-CSE-MsgGUID: rwg5ooJCRwCiFFAVrzY3Ig==
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="233294142"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:50:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 9 Nov 2026 06:50:51 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Mon, 9 Nov 2026 06:50:49 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 9 Nov 2026 14:50:42 +0100
Subject: [PATCH 2/2] pinctrl: ocelot: do not use the chained irqchip behind
 a sleeping bus
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
Message-ID: <20261109-ocelot-pinctrl-irqchip-fixes-v1-2-9d2d8fcd58f5@microchip.com>
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

Since the driver can use a regmap on a bus that can sleep, as for
VSC7512 attached over SPI, it still registers the gpiochip as not
sleeping and adds the chained irqchip when the node has an interrupt.
The chained handler and the irq_chip callbacks run in atomic context and
access the registers through that regmap, and consumers may use the
lines of a gpiochip that is not marked as sleeping from atomic context.

Mark the gpiochip as sleeping when the regmap can sleep, and do not
register the chained irqchip in that case.

The issue was found by code inspection and reproduced on a lan9668
board (pcb8385) with a lan9645x attached over SPI, whose pinctrl node
has an interrupt, by requesting an edge interrupt on one of its GPIOs
through the GPIO character device:

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 420, name: gpiomon
  preempt_count: 1, expected: 0
  locks held by gpiomon/420: 3, last CPU#0:
   #0: 84463cd0 (&gdev->srcu){.+.+}-{0:0}, at: lineinfo_get+0x13f/0x140
   #1: 838bbd30 (request_class){+.+.}-{4:4}, at: __setup_irq+0xe8/0x5c0
   #2: 838bbc70 (lock_class){-...}-{2:2}, at: __setup_irq+0x104/0x5c0
  ...
  Call trace:
  ...
   mutex_lock_nested from regmap_update_bits_base+0x1c/0x80
   regmap_update_bits_base from ocelot_irq_unmask+0x42/0x80
   ocelot_irq_unmask from irq_enable+0x1e/0x80
   irq_enable from irq_startup+0x64/0xc0
   irq_startup from __setup_irq+0x38c/0x5c0
   __setup_irq from request_threaded_irq+0x86/0x140
   request_threaded_irq from edge_detector_setup+0x1d8/0x240
   edge_detector_setup from linereq_create+0x3e2/0x540
   linereq_create from gpio_ioctl+0xa4/0x240

With the fix the lan9645x gpiochip is registered as sleeping and
without the chained irqchip, the request fails with -ENXIO instead and
without lockdep reports.

Fixes: 181f604b33cd ("pinctrl: ocelot: add ability to be used in a non-mmio configuration")
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 06dd49782d74..90a1f859db67 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -2367,8 +2367,9 @@ static int ocelot_gpiochip_register(struct platform_device *pdev,
 	gc->parent = &pdev->dev;
 	gc->base = -1;
 	gc->label = "ocelot-gpio";
+	gc->can_sleep = regmap_might_sleep(info->map);
 
-	irq = platform_get_irq_optional(pdev, 0);
+	irq = gc->can_sleep ? 0 : platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
 		girq = &gc->irq;
 		gpio_irq_chip_set_chip(girq, &ocelot_irqchip);

-- 
2.52.0

