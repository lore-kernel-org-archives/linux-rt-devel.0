Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25467480350
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711168; cv=none; b=b230sGClzc4RdnOSjW8arh7E2JU7oI073PAQ9SmNusLszHdCrh56ADP+lGWL3Es/Dh9gpMrkcL7XFCWwh/CbWlPoDfu6Fz3vjbiln36yqexuW/S/atk/EmAnlB5MA4XImxpvn60AT+sidOldGE2iq1PsKmxxuI91zV/nrx5KO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711168; c=relaxed/simple;
	bh=/cUP8qiDwMFPXMJ07+t7pi0dWpyopD+eP2Yi5ET34pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f59nkrHIXsfeYuCPFIcngJauA+jdzw0QpIIqKTZ5HpiTeU4u/OxD02Oz2SL2z90GCJ/A0cfRNAkbz32Iwzz8NL/r3RqwEh+BhS1q0Yr7ipe8tgH2T94Rv84uNYpcYgR6rGCXE0ttbmUG3BMWsCEyH5Mr29SgXEzVOZDvrHkuSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Gb/FqZ+I; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Gb/FqZ+I"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42c786665;
	Wed, 17 Jun 2026 23:40:43 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	linux-gpio@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH 0/2] gpio: use raw spinlocks in irq startup paths
Date: Wed, 17 Jun 2026 23:40:33 +0800
Message-Id: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed63dec9403a1kunme39bd4ec7353b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEJPVhhPGhkeQ0oeGUMdHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Gb/FqZ+IjVPGhiGasMk5wIQKUqgwywBh4ygHk3qwhFjX1Zcuk8nYG+uCxDg3mGwGOxqnZv3gTfiDb0F6Zu2Ny63ZNjmxmlHhHId2IsZIBsmbvo9o76G+UcdLUEZcJx/h/7FlhgmQLPWUxuk7S1ScVnVHOFDo8NInP2XTZQmsD7I=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0UJyhmAnyClFs0OH2R0752mdmhXxf0o0IrDtwIqU2zU=;
	h=date:mime-version:subject:message-id:from;

This 2-patch series fixes two GPIO irqchip paths where IRQ startup or
unmask can update controller state under a regular spinlock.  On
PREEMPT_RT, that lock can sleep while irq_startup() is running in a
non-sleepable context.

Both issues were found by our static analysis tool and then manually
reviewed against the current tree.  The grounded PoCs kept the
request_threaded_irq() -> __setup_irq() -> irq_startup() carriers and
Lockdep reported "BUG: sleeping function called from invalid context" on
the corresponding driver update helpers.

Convert the affected register locks to raw_spinlock_t.  The locked
sections only serialize MMIO register access and irqchip state updates,
so they should remain non-sleeping.  The conversion does not move any
sleepable operation under a raw lock; it preserves the existing short
register-critical sections while making their non-sleeping requirement
explicit for PREEMPT_RT.

Runyu Xiao (2):
  gpio: sch: use raw_spinlock_t in the irq startup path
  gpio: eic-sprd: use raw_spinlock_t in the irq startup path

 drivers/gpio/gpio-eic-sprd.c |  8 ++++----
 drivers/gpio/gpio-sch.c      | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.34.1
