Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D237F72D
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372945; cv=none; b=eMF/92nFDBOM035XRwFa4UhB1ZOKYefK4qLwEIw/fWlJ5fM069t0gxUjzGnzYM1A7X6J6hSTcZTcbIZiS6gCHw12eIbAAJMbkI3itf7IOTp0st8fwX8XdPWr8TuxTjxF7WnOEPrLUbxYVkCcJOYcB2wb9/BBg+FamL8nmN0pp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372945; c=relaxed/simple;
	bh=UzD+wLf+xG4YpVbP7ZGzeZuekJ96UK/PmMCCZKxbzAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f6aDaNKyYHNEpVeurkKmNnFQE9YnM64k+19oE6En0r6jPt2qg1PueXqKVZP4bJcxbeLDoyqTh3Suu/jWxevvjYHS76bZ1Le64HOlXN3kGfA+9YGcoX+C8TGW+3+QizXNIiCmGw2K5YKlKkNx07f8E70EuVFClCoiz6wbyVlw4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LTqNkGrx; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LTqNkGrx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=optLbU79fsFYP8qRGm+YcbhR39r3nfkhczlKBdhAWSE=;
	b=LTqNkGrxOZqExbQfTmhbs7niHOm9yGbQNIcwLsXnrRracOZfteo2HbiNJZYjbzCGE8DiBnqL0
	eurfwO6Q0knDiasek63sL9uRsrccTplZHjpdTMM61VHYsoZF8oMVFs2JFGbxH5ZvO712Ybz1b/M
	bRaOxQmc0ry+asRSHps+R98=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gm9N25gLSzmV6t;
	Thu, 25 Jun 2026 15:26:26 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id DCE7F4056E;
	Thu, 25 Jun 2026 15:35:32 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 25 Jun 2026 15:35:32 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
	<rostedt@goodmis.org>, <rmk+kernel@armlinux.org.uk>, <linusw@kernel.org>,
	<arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: [PATCH] ARM: enable interrupts when arm_notify_die() is handling user mode errors
Date: Thu, 25 Jun 2026 15:35:22 +0800
Message-ID: <20260625073522.182503-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

For lastest linux-next kernel, with default multi_v7_defconfig, and
setting CONFIG_PREEMPT_RT=y, CONFIG_DEBUG_ATOMIC_SLEEP=y, and
CONFIG_PERF_EVENTS=n. When the user program executes bkpt
instruction, the following WARN will be triggered:
```log
[    3.677825] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[    3.678002] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 84, name: test
[    3.678036] preempt_count: 0, expected: 0
[    3.678078] RCU nest depth: 0, expected: 0
[    3.678864] CPU: 0 UID: 0 PID: 84 Comm: test Tainted: G        W           7.1.0-next-20260623 #45 PREEMPT_RT
[    3.679067] Tainted: [W]=WARN
[    3.679088] Hardware name: Generic DT based system
[    3.679198] Call trace:
[    3.679695]  unwind_backtrace from show_stack+0x10/0x14
[    3.680363]  show_stack from dump_stack_lvl+0x50/0x5c
[    3.680377]  dump_stack_lvl from __might_resched+0x160/0x174
[    3.680393]  __might_resched from rt_spin_lock+0x38/0x138
[    3.680425]  rt_spin_lock from force_sig_info_to_task+0x1c/0x11c
[    3.680438]  force_sig_info_to_task from force_sig_fault+0x44/0x64
[    3.680450]  force_sig_fault from do_PrefetchAbort+0x94/0x9c
[    3.680461]  do_PrefetchAbort from ret_from_exception+0x0/0x20
[    3.680513] Exception stack(0xf0ab5fb0 to 0xf0ab5ff8)
[    3.680653] 5fa0:                                     00000000 bed32e94 bed32e9c 00037954
[    3.680672] 5fc0: 00000002 00000001 bed32e94 0009d590 00000000 bed32e9c 00000002 00000000
[    3.680682] 5fe0: bed32d48 bed32d38 00037a00 00037958 60000010 ffffffff
```

When PREEMPT_RT is enabled, force_sig_info() requires interrupts to be
enabled. Enable interrupts when arm_notify_die() is handling user mode
errors to fix the issue.

Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 arch/arm/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index afbd2ebe5c39..6aa205a92920 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -375,6 +375,7 @@ void arm_notify_die(const char *str, struct pt_regs *regs,
 		unsigned long err, unsigned long trap)
 {
 	if (user_mode(regs)) {
+		local_irq_enable();
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
-- 
2.53.0

