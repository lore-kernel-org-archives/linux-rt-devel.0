Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0E9463;
	Mon,  3 Aug 2026 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737944; cv=none; b=gwltGsBxjh0y0azD6l09rrmyE9cPTMBff6b0FnNMfMnYDI9HhXgBCwOf13UuBxXMyc4M2ox8HJwlSBYmmdRovzZ1cNI5k9HoB41PbsmttU/xPAiC4D9z8xgGUCSO35eWVKY+zU9cd58vjNk4Esd/jWFAA8pwD1mU3ZgS6Jm4vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737944; c=relaxed/simple;
	bh=Ugm9wYbpELahg9Xe7+XpwxXZm4/hVdPVjwdIIMqoDPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MlpxDxl4+kXtzViuGWq7CaNCh+zob39Zrh31kB9OryKC5aHGt8MT96a9O/7GeKEij8IYIWp3jwJoDG8bY6Jwq3WnyrL0so5T7zvHjS1C/5h58hJy1hcAqObd4BkcHnYdNVDwRGQiz0nbvMPQHSTFuaWcudny79Jnh9viCA06lKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h7YI8M12; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h7YI8M12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=8z/Ja8msCQyhEkE0uXSWUZRUIHxD/U1gQXqjPG00wU0=;
	b=h7YI8M12Jzaz5cy9Cm5Pn22nsI6GiSamaOgo96RjU2yxsydKU2MISMaZyW1JBI
	ObiLtpXiM/nE95ktCgP1dHEU7nqD65ujWOMJnyq32AykuXkHx4WStV8le+9EjwYl
	ot790ANHolh1/E02xQlP6QmkhESoMy4K4kNHEqvnUHH7w=
Received: from fedora (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3T9pzMnBqkykzMg--.4961S2;
	Mon, 03 Aug 2026 14:17:25 +0800 (CST)
From: Ju Nan <junan76@163.com>
To: Antonio Borneo <antonio.borneo@foss.st.com>,
	Linus Walleij <linusw@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: stm32: use a raw spinlock regmap to program the EXTI mux
Date: Mon,  3 Aug 2026 14:17:14 +0800
Message-ID: <20260803061718.43210-1-junan76@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3T9pzMnBqkykzMg--.4961S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw4xJFyUCF1UXFW5Cry7trb_yoW7XFy8pF
	W3XFWYyrs7Jr4rZrW0y3y0vFW5Kan7t3y5CwnxK3y2vrn0va45K3W3KFyUAFsFkr4kXFZ0
	yr15AFy8uF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKzuZUUUUU=
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC1BZgEmpwMnZTtAAA3J

stm32_gpio_domain_activate() programs the EXTI interrupt multiplexer
with regmap_field_write(), on a regmap the driver obtains from the generic
syscon driver via syscon_regmap_lookup_by_phandle(np, "st,syscfg").

An irq_domain .activate callback is by contract called from raw atomic
context: __setup_irq() takes the raw desc->lock and calls
irq_activate() while holding it.

That regmap is created by syscon with regmap_init_mmio(). The regmap-mmio
bus sets .fast_io = true, and syscon does not set use_raw_spinlock, so
__regmap_init() protects the regmap with a spinlock_t.

On !RT a spinlock_t only ever spins and nothing bad happens at runtime,
which is why this has gone unnoticed. On PREEMPT_RT spinlock_t is a
sleeping lock, and taking it under the raw desc->lock is a sleep in atomic
context. lockdep's wait-context checker catches this ahead of time — with
CONFIG_PROVE_RAW_LOCK_NESTING=y the driver splats on boot as soon as
anything requests a GPIO interrupt (here: an sii902x HDMI bridge):

BUG: Invalid wait context
...
(&syscon_config)->lock){....}-{3:3}, at: regmap_lock_spinlock
other info that might help us debug this:
... 6 locks held by kworker/u8:0/12:
 #5: (&irq_desc_lock_class){-...}-{2:2}, at: __setup_irq

i.e. a wait type 3 (LD_WAIT_CONFIG, sleeping-on-RT) lock is acquired while
the raw desc->lock has already limited the context to wait type 2
(LD_WAIT_SPIN).

Note the driver is already aware that it runs in atomic context here: it uses
the _in_atomic() hwspinlock primitives around this very same register
access. The syscon lock is the one lock in that section it does not control.

The fix:

Register a regmap with use_raw_spinlock = true for the node through
of_syscon_register_regmap() before looking it up, so the syscon layer hands
out that one instead of instantiating its default. It has to go through the
syscon layer rather than staying private to the driver, because both pinctrl
instances of an STM32MP1 (pinctrl and pinctrl_z) reference the same node —
private regmaps would give them one lock each and no mutual exclusion on the
mux registers. Same pattern as drivers/soc/samsung/exynos-pmu.c.

Reported-by: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/all/20220202174430.pf37tt6lua2op3gc@pengutronix.de/
Signed-off-by: Ju Nan <junan76@163.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 64 +++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 6a99708a5a23..39df117489d1 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1757,6 +1757,68 @@ static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pde
 	return domain;
 }
 
+/*
+ * The interrupt mux registers are written from stm32_gpio_domain_activate(),
+ * which the irq core calls with the raw desc->lock held. The regmap the
+ * generic syscon driver hands out is protected by a spinlock_t, which may
+ * sleep on PREEMPT_RT and therefore must not be taken from there.
+ *
+ * Publish a raw spinlock regmap for the node before looking it up, so that
+ * all of its users keep sharing one regmap, and one lock.
+ */
+static const struct regmap_config stm32_pctrl_syscfg_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.use_raw_spinlock = true,
+};
+
+static void stm32_pctrl_publish_syscfg_regmap(struct device_node *np)
+{
+	struct regmap_config config = stm32_pctrl_syscfg_regmap_config;
+	struct device_node *syscfg_np;
+	struct regmap *regmap;
+	void __iomem *base;
+	struct resource res;
+
+	syscfg_np = of_parse_phandle(np, "st,syscfg", 0);
+	if (!syscfg_np)
+		return;
+
+	if (of_address_to_resource(syscfg_np, 0, &res) ||
+	    resource_size(&res) < config.reg_stride)
+		goto out_put;
+
+	config.max_register = resource_size(&res) - config.reg_stride;
+
+	base = of_iomap(syscfg_np, 0);
+	if (!base)
+		goto out_put;
+
+	/*
+	 * The regmap is handed over to the syscon layer, which never releases
+	 * it, so it must outlive this driver: no device managed allocation
+	 * here, and no device to attach it to either.
+	 */
+	regmap = regmap_init_mmio(NULL, base, &config);
+	if (IS_ERR(regmap)) {
+		iounmap(base);
+		goto out_put;
+	}
+
+	/*
+	 * A regmap is already registered for that node, most likely by the
+	 * other pinctrl instance sharing it. Drop ours and use that one.
+	 */
+	if (of_syscon_register_regmap(syscfg_np, regmap)) {
+		regmap_exit(regmap);
+		iounmap(base);
+	}
+
+out_put:
+	of_node_put(syscfg_np);
+}
+
 static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
 			   struct stm32_pinctrl *pctl)
 {
@@ -1766,6 +1828,8 @@ static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
 	int offset, ret, i;
 	int mask, mask_width;
 
+	stm32_pctrl_publish_syscfg_regmap(np);
+
 	pctl->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(pctl->regmap))
 		return PTR_ERR(pctl->regmap);
-- 
2.55.0

