Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7F3F12E0;
	Wed, 14 Oct 2026 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994276; cv=none; b=FV/YpLemfu3Gmx+OK5jvL6bgScykTLuuYqDrdwQl60DIFJ2hG0jydrxV02kQwaYFsoqPZfpM1TJLAxy7EpGwgZKgqCbxKWat7SUbU0FVv2ipHglaSDG8hrC3j1hTbE+XjWyRwfEaKQOvIpUPVlmk1CfcjV6BxHYR5JlrZLxZdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994276; c=relaxed/simple;
	bh=klA4hH8Mv1mbt/DzIuieB2Q6V4hh+j4fK1qgn3pllcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8XP2nqRgdxABgycXLSmLcLT1Klj4jz/PF2cku2FMxZraMmbFqCmGTyRceDv1vU3xAYWR+rH8M1SQDrhRJik49i9faLX4TUnhI2cxLsNgU35eaT5ODffI3eWLESJQk0xkRK3xJMqRrLbdyZs/daSNU3dMHoK7wndS2hAmj6KiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WCgs8tda; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WCgs8tda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=vD0NYzUJsJFaZFVryPBxGWUgQmiZpnh4TV1Ps+d5RWQ=;
	b=WCgs8tda2Zv3PJklFz49gflNOSls4Nw3b2RM6byorIje9pe6uAET/yiQWqxWPp
	cohxrQuKqfE1YCTdmbT8r2CJ1jqUx8ivQERWioe1+Lgsz6g2c7LGUiV2CUpXnQ8t
	Rxp5OplJfLjsWG8nmfiK8M8PsVtKVena+1pNz5lE8eA9k=
Received: from fedora (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3v15Gqc9qxM0iAA--.40892S4;
	Thu, 15 Oct 2026 00:09:56 +0800 (CST)
From: Ju Nan <junan76@163.com>
To: junan76@163.com,
	antonio.borneo@foss.st.com,
	bigeasy@linutronix.de,
	linusw@kernel.org
Cc: alexandre.torgue@foss.st.com,
	arnd@arndb.de,
	clrkwllms@kernel.org,
	lee@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	mfd@lists.linux.dev,
	rostedt@goodmis.org,
	u.kleine-koenig@pengutronix.de
Subject: [PATCH v4 2/2] pinctrl: stm32: program the EXTI mux from .alloc instead of .activate
Date: Thu, 15 Oct 2026 00:09:18 +0800
Message-ID: <20261014160917.139241-4-junan76@163.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014160917.139241-2-junan76@163.com>
References: <20261014160917.139241-2-junan76@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v15Gqc9qxM0iAA--.40892S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4rJw4fKryrZry8ZF4fZrb_yoWxtr1rpF
	W3XrsIyrsxX3WrZa4DtF4jvF9Ika92y3ZrGw1DtayxZrn0vrn5t3WSqFyxuFWjkF97J3ZI
	vF45tryUua1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVyIbUUUUU=
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC0xQOv2rPqVQckwAA3h

stm32_gpio_domain_activate() writes the EXTI interrupt multiplexer
through a regmap obtained from the generic syscon driver. The irq core
calls .activate from __setup_irq() with the raw desc->lock held, so this
happens in a raw atomic section. regmap-mmio sets fast_io, and syscon
does not ask for a raw spinlock, so the regmap is protected by a
spinlock_t. On PREEMPT_RT that is a sleeping lock, which must not be
taken there. lockdep reports it as soon as a GPIO interrupt is
requested:

 [ BUG: Invalid wait context ]
 7.1.13 #7 Not tainted
 -----------------------------
 kworker/u8:1/29 is trying to lock:
 (syscon:117:(&syscon_config)->lock){....}-{3:3}, at: regmap_lock_spinlock
 other info that might help us debug this:
 context-{5:5}
 5 locks held by kworker/u8:1/29:
  #0: ((wq_completion)async){+.+.}-{0:0}, at: process_one_work
  #1: ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work
  #2: (&dev->mutex){....}-{4:4}, at: __device_attach_async_helper
  #3: (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq
  #4: (&irq_desc_lock_class){-...}-{2:2}, at: __setup_irq

The driver was already aware of running in atomic context there: it uses
the _in_atomic() hwspinlock primitives around the very same access. The
syscon lock is the one lock in that section it does not control.

Program the mux from .alloc instead, which runs in a sleepable context.
That callback already owns this resource: it reserves the mux line in
pctl->irqmux_map under irqmux_lock, so writing the value it just claimed
is a natural fit, and the value only depends on the bank.

Nothing requires the mux to be reprogrammed at interrupt startup time:
the domain has no .deactivate, .free() only releases the irqmux_map bit
without touching the registers.

Keep the access inside the existing irqmux_lock section rather than
after it. hwspin_lock_timeout_in_atomic() deliberately skips the local
lock that the other hwspinlock modes take, so its caller is responsible
for disabling preemption and for excluding other local contexts; every
other hwspinlock user in this driver relies on bank->lock for that.
irqmux_lock plays the same role here, and it also turns the mux
reservation and the mux write into a single critical section. Nesting
the regmap spinlock_t inside irqmux_lock, itself a spinlock_t, is what
the wait-context checker expects.

Note that this bounds the semaphore hold time on !PREEMPT_RT only. On
PREEMPT_RT spinlock_t disables neither interrupts nor preemption, so the
hardware semaphore can be held across a preemptible section and a
coprocessor contending for it may poll for an unbounded time. That is
not introduced here: bank->lock is a spinlock_t too, so every existing
hwspinlock user in this driver behaves the same way on PREEMPT_RT.
Removing that exposure requires the EXTI mux regmap to be raw-spinlock
based, which the syscon core does not currently offer, and is left for a
separate change.

While moving the code, release the mux reservation when the hwspinlock
cannot be taken, which the .activate callback had no way of doing.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/all/20220202174430.pf37tt6lua2op3gc@pengutronix.de/
Signed-off-by: Ju Nan <junan76@163.com>
---
The issue mentioned by Antonio in v3 cannot happen: irqmux_lock is held
while irqmux_map is checked, so PB5 cannot write the mux once PA5 has
claimed the line. I tested it on the same STM32 board:

1. add a fake device in dts:

&i2c5{

hdmi-transmitter@39 {
	compatible = "sil,sii9022";
...
	interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
	interrupt-parent = <&gpioa>;
...
};

fake-hdmi-transmitter@40 {
	compatible = "sil,sii9022";
...
	interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
	interrupt-parent = <&gpiob>;
...
};
};

2. hack the sii902x driver so that the second and later instances only
   call request_irq() and return 0 from .probe.

3. dmesg result:

# dmesg | grep -i error
[    2.107147] stm32_rtc 5c004000.rtc: probe with driver stm32_rtc failed with error -110
[    5.439201] GPT: Use GNU Parted to correct GPT errors.
[    9.333158] sii902x 0-0040: error -EINVAL: request_irq(0) 0x0 sii902x_interrupt [sii902x] 0-0040
# dmesg | grep -i "irq line"
[    9.324176] stm32mp157-pinctrl soc:pinctrl@50002000: irq line 14 already requested.
# uname -a
Linux fsmp1a 7.1.13 #7 SMP PREEMPT Wed Oct 14 19:26:21 CST 2026 armv7l GNU/Linux

The second instance (0-0040) fails to map its interrupt: .alloc refuses
the line with "irq line 14 already requested", so the mux is never
written for GPIOB. client->irq is then left at 0, and the hacked probe
fails with "-EINVAL: request_irq(0)".

---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 46 +++++++++++----------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index e71651d4fad4..b5f9091bd990 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -600,30 +600,6 @@ static int stm32_gpio_domain_translate(struct irq_domain *d,
 	return 0;
 }
 
-static int stm32_gpio_domain_activate(struct irq_domain *d,
-				      struct irq_data *irq_data, bool reserve)
-{
-	struct stm32_gpio_bank *bank = d->host_data;
-	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
-	int ret = 0;
-
-	if (pctl->hwlock) {
-		ret = hwspin_lock_timeout_in_atomic(pctl->hwlock,
-						    HWSPNLCK_TIMEOUT_MS);
-		if (ret) {
-			dev_err(pctl->dev, "Can't get hwspinlock\n");
-			return ret;
-		}
-	}
-
-	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->bank_ioport_nr);
-
-	if (pctl->hwlock)
-		hwspin_unlock_in_atomic(pctl->hwlock);
-
-	return ret;
-}
-
 static int stm32_gpio_domain_alloc(struct irq_domain *d,
 				   unsigned int virq,
 				   unsigned int nr_irqs, void *data)
@@ -645,10 +621,27 @@ static int stm32_gpio_domain_alloc(struct irq_domain *d,
 	if (pctl->irqmux_map & BIT(hwirq)) {
 		dev_err(pctl->dev, "irq line %ld already requested.\n", hwirq);
 		ret = -EBUSY;
-	} else {
-		pctl->irqmux_map |= BIT(hwirq);
+		goto unlock;
+	}
+
+	pctl->irqmux_map |= BIT(hwirq);
+
+	if (pctl->hwlock) {
+		ret = hwspin_lock_timeout_in_atomic(pctl->hwlock,
+						    HWSPNLCK_TIMEOUT_MS);
+		if (ret) {
+			dev_err(pctl->dev, "Can't get hwspinlock\n");
+			pctl->irqmux_map &= ~BIT(hwirq);
+			goto unlock;
+		}
 	}
 
+	regmap_field_write(pctl->irqmux[hwirq], bank->bank_ioport_nr);
+
+	if (pctl->hwlock)
+		hwspin_unlock_in_atomic(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&pctl->irqmux_lock, flags);
 	if (ret)
 		return ret;
@@ -683,7 +676,6 @@ static const struct irq_domain_ops stm32_gpio_domain_ops = {
 	.translate	= stm32_gpio_domain_translate,
 	.alloc		= stm32_gpio_domain_alloc,
 	.free		= stm32_gpio_domain_free,
-	.activate	= stm32_gpio_domain_activate,
 };
 
 /* Pinctrl functions */
-- 
2.56.0

