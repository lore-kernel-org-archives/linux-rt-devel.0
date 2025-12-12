Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FEE3002A0
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765566225; cv=none; b=XKZidz6sasyGZa6QK/dmNueYUp8ulAEQpjzI1pOlftbVTAUQQpxZugFl7oW2K4d1R8cB1r2+4kzImU+a+tlbOvZFQ4u0uTJwRwXjg/FZ779IWgFSGSqeU7DuxQNO4FmZJMjNnMvp4AQl4pdtseKA3xFB7oTGFtvdw29t9cfiI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765566225; c=relaxed/simple;
	bh=lVKS6Y7TeGlvB2l0JwHXx0Wv058Rb5Lk7W9y/3Z96Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9MjEyLajEioIohQjtpqFnatexKlxRrymCPWUJlZz5KrnZLz995841b6Ji+f3FaNgT/4eH6z8GRorneGT84zIvbxIbY/RmXW1R1iaiNJW8ElJLGKqGvxG7quNAO6NNZY7k+UB+YlYuMgwv8W8L9Sk42MXsfoG4eGzugqTNCUVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3835B165C;
	Fri, 12 Dec 2025 11:03:35 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 472E13F762;
	Fri, 12 Dec 2025 11:03:40 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: nico@fluxnic.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	dongdong.deng@windriver.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2] smc91x: fix broken irq-context in PREEMPT_RT
Date: Fri, 12 Dec 2025 19:03:38 +0000
Message-Id: <20251212190338.2318843-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When smc91x.c is built with PREEMPT_RT, the following splat occurs
in FVP_RevC:

[   13.055000] smc91x LNRO0003:00 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   13.062137] BUG: workqueue leaked atomic, lock or RCU: kworker/2:1[106]
[   13.062137]      preempt=0x00000000 lock=0->0 RCU=0->1 workfn=mld_ifc_work
[   13.062266] C
** replaying previous printk message **
[   13.062266] CPU: 2 UID: 0 PID: 106 Comm: kworker/2:1 Not tainted 6.18.0-dirty #179 PREEMPT_{RT,(full)}
[   13.062353] Hardware name:  , BIOS
[   13.062382] Workqueue: mld mld_ifc_work
[   13.062469] Call trace:
[   13.062494]  show_stack+0x24/0x40 (C)
[   13.062602]  __dump_stack+0x28/0x48
[   13.062710]  dump_stack_lvl+0x7c/0xb0
[   13.062818]  dump_stack+0x18/0x34
[   13.062926]  process_scheduled_works+0x294/0x450
[   13.063043]  worker_thread+0x260/0x3d8
[   13.063124]  kthread+0x1c4/0x228
[   13.063235]  ret_from_fork+0x10/0x20

This happens because smc_special_trylock() disables IRQs even on PREEMPT_RT,
but smc_special_unlock() does not restore IRQs on PREEMPT_RT.
The reason is that smc_special_unlock() calls spin_unlock_irqrestore(),
and rcu_read_unlock_bh() in __dev_queue_xmit() cannot invoke
rcu_read_unlock() through __local_bh_enable_ip() when current->softirq_disable_cnt becomes zero.

To address this issue, replace smc_special_trylock() with spin_trylock_irqsave().

Fixes: 8ff499e43c53 ("smc91x: let smc91x work well under netpoll")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
This patch based on v6.18.

History
========

From v1 to v2:
  - remove debug log.
  - https://lore.kernel.org/all/20251212185818.2209573-1-yeoreum.yun@arm.com/

---
 drivers/net/ethernet/smsc/smc91x.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 9d1a83a5fa7e..d16c178d1034 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -516,15 +516,7 @@ static inline void  smc_rcv(struct net_device *dev)
  * any other concurrent access and C would always interrupt B. But life
  * isn't that easy in a SMP world...
  */
-#define smc_special_trylock(lock, flags)				\
-({									\
-	int __ret;							\
-	local_irq_save(flags);						\
-	__ret = spin_trylock(lock);					\
-	if (!__ret)							\
-		local_irq_restore(flags);				\
-	__ret;								\
-})
+#define smc_special_trylock(lock, flags)	spin_trylock_irqsave(lock, flags)
 #define smc_special_lock(lock, flags)		spin_lock_irqsave(lock, flags)
 #define smc_special_unlock(lock, flags) 	spin_unlock_irqrestore(lock, flags)
 #else
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

