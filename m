Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438F244691
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Jul 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753474550; cv=none; b=AQua2IaTnu5/BoQkqploTPvwixGMvowKS4EGUD7NUhPIGdEFCSQEW7YMr9HInwG56+kkNQg9CneMad00VMbrMesQJ7o5K1fvRQPLzluloBBU0sDiuErdAaHtNL02nUdMWo3svT8qBoMESKLVFcVd+kcP3r08OujCU3Q9tcmNN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753474550; c=relaxed/simple;
	bh=/F/JVr3SNg41VeueRzHG4AAT+V7CIIpptHyNH6dHFVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bl0YyE4W0Ippz2QKXqBGW3BM4IDV1XUmrFmPn1ua591Jeyh3wiROYAl6tPuCzBZGG+0odfQeweZWpVxoV8iM+PS4vHuRdzNDlNtIj7fl62eVIsqsRupbaG2YaizqME86j6zVOhuQSGFMrsrPdNSrJ6U7ix0TDYKx3OaKjdZVrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312f53d0609so234969a91.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 25 Jul 2025 13:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753474548; x=1754079348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDxcanwU1JbetZe9oiUEN/n+YFfsJR7sLnCsAScdPD4=;
        b=tdKmpF7sfixjBxryKnrYoNKIsva4mWc+QyyJVtAR2zhSz/piU7Qzba/a4z697atKWp
         GiQFoMUxYGAjJwLvGRo4eMr+GnBQ0CNjV+uXtlQzXWpSFe6nCdZyfL39ZVBDGy5fKAc0
         VyE8SrvGd+8AO6KJsTsZehpQPfc+4X5Kytiv/DT6eblaO/X9Gq9YRh9RGc4YQK0xaW3F
         Xzfulhd84Yx/9Bd/UH0KWKRC5gfI5Z+xKpshCUlaw1wGKFM1SRrM7Y/x9FHxtyTjrU65
         t3xiG42V5na3X55tW8mJu5gpzpsW8EB6KSpfOa5YaIg1PBnxV7vfmqb9KdmsnnQ8yrfc
         2Iig==
X-Forwarded-Encrypted: i=1; AJvYcCWoRjYMduCCjF1bQMIle9BUJfUotJ2qC5Kvw+larKM+E0eG6dJkSx0DiLCIChSq96GOFh2+eIc0iEWU4GPfuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygtbd4WRU9S//7IHBGVdv6n3Cyl51DKSQM5VwsrXb7gMlR280r
	N4h18cVTmbdaxuIKGi5lZZUJXgfcZyehYA3m2T5e2KTgiE7hiD4G81hg
X-Gm-Gg: ASbGncunqLeBRxzzex4RlRcDSk/1zHc+/ikJzC1fopcW0sHyxK/30NVk2nefVb2BsIS
	zxZ7YEVBz+Z8SDJ2gCzwZaw3pFlSbQe+jglFpgt+Lno/cPXJxtbOPL8d7uJkfsQNfvjVRwyz39n
	XtqYOInT3IGsarVn7uJG8T9OafpIr2/MapWArU7r9la/47KMkv96WIG/nC6kkJ+PKo3NpT14qje
	tGiTfSt0qd/SgIC/KEC/XfUn2CS+/71pWm+OGdf2Cs8eJjmlThZYM+6DmjFCnXHvv+bkoSHpw7V
	4wtbJwqV9qhcuouU4c0OIF8Wbdxb1wG3LhksRDipuUcYeyAZTwMH3fwPAdak8IHKsY1Wu1W5hrN
	ulPI8IxDSomv6
X-Google-Smtp-Source: AGHT+IFWfq/YuZlLKXEbKR6CH+4VjCjJlJjC/Hbgbn/0EjkusqP9d4OK3YW1DW7j/4gOzB0opFCTOA==
X-Received: by 2002:a17:90b:4ad2:b0:313:f9fc:7214 with SMTP id 98e67ed59e1d1-31e77873f60mr1854586a91.1.1753474548387;
        Fri, 25 Jul 2025 13:15:48 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fb798sm346993a91.8.2025.07.25.13.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:15:47 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org,
	kasan-dev@googlegroups.com,
	syzkaller@googlegroups.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
Date: Fri, 25 Jul 2025 20:14:01 +0000
Message-ID: <20250725201400.1078395-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fuzzing USB with syzkaller on a PREEMPT_RT enabled kernel, following
bug is triggered in the ksoftirqd context.

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 30, name: ksoftirqd/1
| preempt_count: 0, expected: 0
| RCU nest depth: 2, expected: 2
| CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Tainted: G        W           6.16.0-rc1-rt1 #11 PREEMPT_RT
| Tainted: [W]=WARN
| Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
| Call trace:
|  show_stack+0x2c/0x3c (C)
|  __dump_stack+0x30/0x40
|  dump_stack_lvl+0x148/0x1d8
|  dump_stack+0x1c/0x3c
|  __might_resched+0x2e4/0x52c
|  rt_spin_lock+0xa8/0x1bc
|  kcov_remote_start+0xb0/0x490
|  __usb_hcd_giveback_urb+0x2d0/0x5e8
|  usb_giveback_urb_bh+0x234/0x3c4
|  process_scheduled_works+0x678/0xd18
|  bh_worker+0x2f0/0x59c
|  workqueue_softirq_action+0x104/0x14c
|  tasklet_action+0x18/0x8c
|  handle_softirqs+0x208/0x63c
|  run_ksoftirqd+0x64/0x264
|  smpboot_thread_fn+0x4ac/0x908
|  kthread+0x5e8/0x734
|  ret_from_fork+0x10/0x20

To reproduce on PREEMPT_RT kernel:

 $ git remote add rt-devel git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
 $ git fetch rt-devel
 $ git checkout -b v6.16-rc1-rt1 v6.16-rc1-rt1

I have attached the syzlang and the C source code converted by syz-prog2c:

Link: https://gist.github.com/kzall0c/9455aaa246f4aa1135353a51753adbbe

Then, run with a PREEMPT_RT config.

This issue was introduced by commit
f85d39dd7ed8 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq").

However, this creates a conflict on PREEMPT_RT kernels. The local_irq_save()
call establishes an atomic context where sleeping is forbidden. Inside this
context, kcov_remote_start() is called, which on PREEMPT_RT uses sleeping
locks (spinlock_t and local_lock_t are mapped to rt_mutex). This results in
a sleeping function called from invalid context.

On PREEMPT_RT, interrupt handlers are threaded, so the re-entrancy scenario
is already safely handled by the existing local_lock_t and the global
kcov_remote_lock within kcov_remote_start(). Therefore, the outer
local_irq_save() is not necessary.

This preserves the intended re-entrancy protection for non-RT kernels while
resolving the locking violation on PREEMPT_RT kernels.

After making this modification and testing it, syzkaller fuzzing the
PREEMPT_RT kernel is now running without stopping on latest announced
Real-time Linux.

Link: https://lore.kernel.org/linux-rt-devel/20250610080307.LMm1hleC@linutronix.de/
Fixes: f85d39dd7ed8 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq")
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Byungchul Park <byungchul@sk.com>
Cc: stable@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Cc: syzkaller@googlegroups.com
Cc: linux-usb@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 include/linux/kcov.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 75a2fb8b16c3..c5e1b2dd0bb7 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -85,7 +85,9 @@ static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
 	unsigned long flags = 0;
 
 	if (in_serving_softirq()) {
+#ifndef CONFIG_PREEMPT_RT
 		local_irq_save(flags);
+#endif
 		kcov_remote_start_usb(id);
 	}
 
@@ -96,7 +98,9 @@ static inline void kcov_remote_stop_softirq(unsigned long flags)
 {
 	if (in_serving_softirq()) {
 		kcov_remote_stop();
+#ifndef CONFIG_PREEMPT_RT
 		local_irq_restore(flags);
+#endif
 	}
 }
 
-- 
2.50.0

