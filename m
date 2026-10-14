Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A813F2100;
	Wed, 14 Oct 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994273; cv=none; b=av9lYXXGflvAUJsacHRKt8lTAx7eeKmYv+PavolqrOQIEckvNgzBlWeD7nAGbU4Y7ZzuAh8AXk/6EaljRfFVq4pVweXSi0AXJtC+k9SwBuDfzE30haso6EEKDUSf5jTDPT/baYYF9dZj2Uo5zBZxZfM0//DZkRvRNWQXFLWoQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994273; c=relaxed/simple;
	bh=0KahYyyhQZw5mMkvhRhU4fmtAbsfrfjzFGUnDs0/jXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHa9G6FhjPC3Dim+yyuP0F3dj/maZX0bxEhRyplsOiaEG30Ev/+WPUd372unZ1LUpyhwGEZdc1arcumf8duuIhCscuP+XxN/xFyljhu8qW6VBEsFh9s4N/c/6AyhngbhTpnQcx4AS7PsTZMIBFLh/c9n7+8jVZiHPOvtE46FFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RMRQrryY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RMRQrryY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=cqkUVC2cMMYINzmwfqfIjQdgvD0S+4BFXmGBP6+vY6I=;
	b=RMRQrryYAd/kYHktK/2NU5R/KznupYU2QtG/KA9w8dVZgnTqAv1Wh+oX/9lZdA
	HVo9EBHjiSGajdOIfPHAjPpKG6fRoeyzLxXyn+U5McdU2A75GroLhcMSphOxJ06H
	49fz6cys5CaiM+zwjZe6GPDoPqgi8sHGFL79NgY7tqJj0=
Received: from fedora (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3v15Gqc9qxM0iAA--.40892S2;
	Thu, 15 Oct 2026 00:09:44 +0800 (CST)
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
Subject: [PATCH v4 0/2] pinctrl: stm32: fix hwspinlock timeout and EXTI mux locking
Date: Thu, 15 Oct 2026 00:09:16 +0800
Message-ID: <20261014160917.139241-2-junan76@163.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v15Gqc9qxM0iAA--.40892S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUZr4kWF48GFyxZF4fZrb_yoW8CFWDpF
	ZxKr4Ykrs5XryaywsFyr409Fy5uw48Jw15G34kKw18Ars8ur1kt3s3Kr4S9F1qkrZ3ZFZF
	vr4aqrn8C34DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziO6pDUUUUU=
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC9QkLvGrPqUnueQAA3Z

This series fixes two problems around the hwspinlock-protected EXTI mux
and pin configuration accesses in the STM32 pinctrl driver.

Patch 1 fixes the timeout passed to hwspin_lock_timeout_in_atomic().
The value was written as 1000 microseconds, but the argument is in
milliseconds, so the driver could busy-wait for up to one second with
interrupts disabled instead of the intended one millisecond. It is a
standalone fix and can be applied on its own.

Patch 2 moves the EXTI mux programming from the irq domain .activate
callback to .alloc. .activate runs under the raw desc->lock, while the
mux is written through a syscon regmap protected by a spinlock_t, which
lockdep reports as an invalid wait context and which is a real bug on
PREEMPT_RT. This was originally reported by Uwe Kleine-König in 2022.
.alloc runs in sleepable context and already reserves the mux line, so
the write now happens in the same irqmux_lock section as the
reservation. While at it, the reservation is released when the
hwspinlock cannot be taken.

---
Changes in v4:

- make the two patches a series to resolve the dependency issue
- reproduce the bug fixed by patch 2 on a modified version of
  STM32MP157-DK board with kernel version 7.1.13
- check the concurrent-requester case raised by Antonio in v3: the
  second bank is rejected in .alloc under irqmux_lock (details in
  patch 2)

v3: https://lore.kernel.org/all/20260804141402.86911-2-junan76@163.com/
v2: https://lore.kernel.org/all/20260804032227.35017-3-junan76@163.com/
v1: https://lore.kernel.org/all/20260803061718.43210-1-junan76@163.com/

Ju Nan (2):
  pinctrl: stm32: Fix the unit of the hwspinlock timeout
  pinctrl: stm32: program the EXTI mux from .alloc instead of .activate

 drivers/pinctrl/stm32/pinctrl-stm32.c | 60 ++++++++++++---------------
 1 file changed, 26 insertions(+), 34 deletions(-)

-- 
2.56.0

