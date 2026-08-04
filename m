Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506A2EEE79;
	Tue,  4 Aug 2026 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814204; cv=none; b=NiH1c9pG2dmPc1NpbxZGhtwvtkbzSApeclY//hp75qPNXBRw7c1MUhz+1KWbFchvdPdxtZeD2ZxYmMthDiUMb0vUtRyqLoSJ31+IXneHCIAW5YmNBXRedseuOx2KVcT7L47zZhdLAdEFjVDX7I7uLxOnXwEA4QKepcSENgl7NI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814204; c=relaxed/simple;
	bh=MbRZ7gHoqkc1aC2eqcqaDM/+equNfQQACXqQMM9UMD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXLpI435QXXEJQmF0mT1Qd3O4MejV4cybT03UJjWhChsQFjIzdLWgvwGkn7CuKUxYnwm2mJLxE/ZyLZdohXLX+U58Z2m3bPDRyiyHx/mJOQgFG08L2rFv0nn4tDsYhtiM1vDhRrBF934LWzWntK1KZyJ0LN1LuIiEDaF/DwzPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ofk50Uej; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ofk50Uej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=d0O87m9puWjhQznpTeDLaAQB5PhBI6es8rrE1KbXKFo=;
	b=ofk50UejRgIiUIdSNJbtsKMSqbIj2Q3vfbZ1T4/xgkk3UnUCvygpLlMmeRNMT3
	5Vidd2HVeXibEEAuX7nIYPvocYjIWNLH2kz7ceaAzfVKeK7Lo++FO7wbj4G25NzS
	ccihQnoPU5wekRTDlMduFC074qyyG1GseXinNXQLU6aDo=
Received: from fedora (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnBqZvXHFq+3LgNg--.26552S2;
	Tue, 04 Aug 2026 11:28:48 +0800 (CST)
From: Ju Nan <junan76@163.com>
To: junan76@163.com
Cc: alexandre.torgue@foss.st.com,
	antonio.borneo@foss.st.com,
	arnd@arndb.de,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	lee@kernel.org,
	linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	mfd@lists.linux.dev,
	rostedt@goodmis.org,
	u.kleine-koenig@pengutronix.de
Subject: [PATCH v2] pinctrl: stm32: program the EXTI mux from .alloc instead of .activate
Date: Tue,  4 Aug 2026 11:22:29 +0800
Message-ID: <20260804032227.35017-3-junan76@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803061718.43210-1-junan76@163.com>
References: <20260803061718.43210-1-junan76@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnBqZvXHFq+3LgNg--.26552S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4rJw4fKryrZry8Zry8uFg_yoW7XF1kpF
	W3Xr4avrsrXFyxZw4UGw4jvF9xKa92yanrKwsrKayxZr1Yv34kK3WfKFy8uF4qyF97X3WD
	AF43tryUu3Z8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWrW3UUUUU=
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC9RIq22pxXHKrlgAA3e

stm32_gpio_domain_activate() writes the EXTI interrupt multiplexer
through a regmap obtained from the generic syscon driver. The irq core
calls .activate from __setup_irq() with the raw desc->lock held, so this
happens in a raw atomic section. regmap-mmio sets fast_io, and syscon
does not ask for a raw spinlock, so the regmap is protected by a
spinlock_t. On PREEMPT_RT that is a sleeping lock, which must not be
taken there. lockdep reports it as soon as a GPIO interrupt is
requested:

  BUG: Invalid wait context
  6.17.0 #4 Not tainted
  -----------------------------
  kworker/u8:0/12 is trying to lock:
  (&syscon_config)->lock){....}-{3:3}, at: regmap_lock_spinlock
  other info that might help us debug this:
  6 locks held by kworker/u8:0/12:
   #5: (&irq_desc_lock_class){-...}-{2:2}, at: __setup_irq
  stack backtrace:
   regmap_lock_spinlock
   regmap_field_update_bits_base
   stm32_gpio_domain_activate
   irq_domain_activate_irq
   __setup_irq
   request_threaded_irq

The driver was already aware of running in atomic context there: it uses
the _in_atomic() hwspinlock primitives around the very same access. The
syscon lock is the one lock in that section it does not control.

Program the mux from .alloc instead, which runs in a sleepable context.
That callback already owns this resource: it reserves the mux line in
pctl->irqmux_map under irqmux_lock, so writing the value it just claimed
is a natural fit, and the value only depends on the bank.

Nothing requires the mux to be reprogrammed at interrupt startup time:
the domain has no .deactivate, .free() only releases the irqmux_map bit
without touching the registers, and the resume path reprograms the mux
itself in stm32_pinctrl_restore_gpio_regs().

While moving the code, release the mux reservation when the hwspinlock
cannot be taken, which the .activate callback had no way of doing.

Reported-by: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/all/20220202174430.pf37tt6lua2op3gc@pengutronix.de/
Signed-off-by: Ju Nan <junan76@163.com>
---
Changes in v2:

- remove stm32_gpio_domain_activate callback
- program mux register in stm32_gpio_domain_alloc instead

v1: https://lore.kernel.org/all/20260803061718.43210-1-junan76@163.com/
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 53 ++++++++++++++-------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 6a99708a5a23..4332ac93a6ff 100644
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
-						    HWSPNLCK_TIMEOUT);
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
@@ -653,6 +629,27 @@ static int stm32_gpio_domain_alloc(struct irq_domain *d,
 	if (ret)
 		return ret;
 
+	/*
+	 * Now that the line is reserved, point its mux at this bank. Doing it
+	 * here rather than from .activate() keeps the access out of the raw
+	 * atomic section the irq core runs .activate() in; nothing needs it to
+	 * be reprogrammed at startup time, and the resume path rewrites it on
+	 * its own.
+	 */
+	if (pctl->hwlock) {
+		ret = hwspin_lock_timeout_in_atomic(pctl->hwlock,
+						    HWSPNLCK_TIMEOUT);
+		if (ret) {
+			dev_err(pctl->dev, "Can't get hwspinlock\n");
+			goto err_free_mux;
+		}
+	}
+
+	regmap_field_write(pctl->irqmux[hwirq], bank->bank_ioport_nr);
+
+	if (pctl->hwlock)
+		hwspin_unlock_in_atomic(pctl->hwlock);
+
 	parent_fwspec.fwnode = d->parent->fwnode;
 	parent_fwspec.param_count = 2;
 	parent_fwspec.param[0] = fwspec->param[0];
@@ -662,6 +659,13 @@ static int stm32_gpio_domain_alloc(struct irq_domain *d,
 				      bank);
 
 	return irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
+
+err_free_mux:
+	spin_lock_irqsave(&pctl->irqmux_lock, flags);
+	pctl->irqmux_map &= ~BIT(hwirq);
+	spin_unlock_irqrestore(&pctl->irqmux_lock, flags);
+
+	return ret;
 }
 
 static void stm32_gpio_domain_free(struct irq_domain *d, unsigned int virq,
@@ -683,7 +687,6 @@ static const struct irq_domain_ops stm32_gpio_domain_ops = {
 	.translate	= stm32_gpio_domain_translate,
 	.alloc		= stm32_gpio_domain_alloc,
 	.free		= stm32_gpio_domain_free,
-	.activate	= stm32_gpio_domain_activate,
 };
 
 /* Pinctrl functions */
-- 
2.55.0

