Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EE311946;
	Thu, 18 Jun 2026 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781750383; cv=none; b=AiRvBxbTtKIJKTkILcBEyFl6CG6Mx/j3bdiRgEiB57gelRsGoglfTqTOrsFRd2rdWAHPUzUyl6TXosujPVWrSufdAhDIcNOb4Sd9RpaiIbOVZxm0iLUo19aCmbVaiH+DySu3dohlgda4iSZdlfIo5Y1G3jVU49V49Lh+c3sLRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781750383; c=relaxed/simple;
	bh=K1qxLlQIDW5M9k9aBhkRPrbww38jnM/psYR0W1LZOjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YgHvC9tKYphBhsPaKtMOwvqAe0y+/MJz9fTAxFdURt7cWsAQ9VWYWMGxucQm7/A2zB+mJZfNZpjsADKu61OKvBYQagynMqmJvOnzf2oyP9qlOVz/Dg8Y3h3pKOZpo7VyzIlrpR4qoYRdir34cITCK9YX8ySIfYNLOnqJwLqckyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Piz9kGoz; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Piz9kGoz"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42d5d546d;
	Thu, 18 Jun 2026 10:34:25 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: Question: SPEAr PLGPIO irq_enable on PREEMPT_RT and regmap updates
Date: Thu, 18 Jun 2026 10:34:18 +0800
Message-Id: <20260618023418.213453-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed8946a3503a1kunmf2d2cccc885db
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGU0fVkpIHx0fHRgaQkoeQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Piz9kGozhLGhAp7BcS2rw2ba7CmgSgklDxmtNboRQ5YYYBESGwjFqpSrhHhUawXgG3QuTvrbrxl2tcZ1o6y7Sy3nXbq/3g87F7FnXGJlmxnoME6Y3vHQ6PMwMDKL9EcBJFj4BiX33skF+NHZtMrHIGRP//YsSSwKouDO3avIQvk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=vMH1HYNQKQ/qahkG7RCFCu22hgnkU7ddsQQrw8qsHa0=;
	h=date:mime-version:subject:message-id:from;

Hi,

While auditing GPIO/pinctrl irqchip callbacks, our static analysis tool
flagged the SPEAr PLGPIO irq_enable path, and we manually reviewed it
against the current tree.

The path is:

  irq_startup()
    -> plgpio_irq_enable()
       -> gpiochip_enable_irq()
       -> spin_lock_irqsave(&plgpio->lock)
       -> plgpio_reg_reset()
       -> regmap_update_bits()

On PREEMPT_RT, plgpio->lock is a regular spinlock_t and can become a
sleeping lock.  Since irq_enable/irq_disable can be called from IRQ
management paths while the IRQ descriptor raw lock is held, taking that
regular spinlock there looks unsafe.

A minimal Lockdep reproducer preserving this irq_chip::irq_enable carrier
reports:

  BUG: sleeping function called from invalid context
  irqs_disabled(): 1
  plgpio_rt_spin_lock_irqsave
  plgpio_irq_enable
  request_threaded_irq_probe_path

My first thought was to convert the PLGPIO register lock to
raw_spinlock_t.  However, that does not seem sufficient because the IE/EIT
updates go through regmap_update_bits()/regmap_read()/regmap_write().  For
the syscon/MMIO regmap used here, regmap may still take its own regular
fast-IO lock unless the regmap was created with use_raw_spinlock.  So a
raw_spinlock_t conversion in the PLGPIO driver alone may just move the
PREEMPT_RT problem one level down into regmap.

The repair I am considering is to keep the gpiolib resource updates in
the fast irq_enable/irq_disable callbacks, but defer the actual PLGPIO
IE/EIT register writes to irq_bus_sync_unlock(), after the IRQ core has
dropped desc->lock.  The driver would keep per-line shadow state for:

  - IRQ disabled/enabled state
  - pending IE update
  - edge direction state
  - pending EIT update

and then synchronize those shadow updates from irq_bus_sync_unlock()
under a mutex.

In other words, the fast callbacks would only update local shadow state
and call gpiochip_enable_irq()/gpiochip_disable_irq(), while the sleepable
regmap writes would be batched into the irq bus sync phase.

Does that sound like an acceptable direction for SPEAr PLGPIO, or would
you prefer a different fix, such as changing the underlying syscon regmap
locking model or handling only the IE register path?

The draft patch I have locally is roughly:

  pinctrl: spear: defer PLGPIO IRQ updates to bus sync

and it changes only drivers/pinctrl/spear/pinctrl-plgpio.c.

Thanks,
Runyu
