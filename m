Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2693F8DEF
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Mar 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143816; cv=none; b=aGafhA4T1SoJowcRoQ3dVhDXi3PtTCSgM41jvj5VNgtivxfOptoFlw1HILaOeAwJ007J89jLGAAd8NcmB/NANYLCmFPeqPeCu6xtmhBj+uwto2Zp2gYKsJ0uurgB7aUm0BQaTwWlSoqn02TGTa/4XOCVIel7BOvjcsqP3w0dKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143816; c=relaxed/simple;
	bh=NHtI2Z11Xo8X3bSX8tXzymRuUlGqGqqx3SrsRTV/4W0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTQmp5Zs7DKDw5cgi+WCQCOzl15uXAjGDFacJO94RRF62h8URYDbYde6gl2Lu7sr9kVpWwB0YE8RDl4AbToiHfTft7ZmjdcsaEOayW8A+KD4o08Z+UwFNuOZALXEzjtnqcqWSKg9CikcJsL4fJPyhkB4+SWBYxNG+t+6yLOFvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K6nfN1fc; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K6nfN1fc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+0
	wgslnTkBc3j9ffV3JF6NCmpin0BzZgA1BKIZ+H9yQ=; b=K6nfN1fchX/zbGjmlR
	q5fYwXZE1MdyCBa7LJTn7XjqOWUPeiU0XCAz3gznAyse9E03YXJraDdD5OWWItyJ
	kRsLGHSPnQWG4fEVhil3lsjtnkf1s0CZlxQYN9NE0YbOWfQ9X9iVdpYlplC1T0dl
	afz65Iensap0KHbkXQy/gPRSg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBHYne5BrBp96icAA--.72S2;
	Tue, 10 Mar 2026 19:55:40 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in bh disable on RT
Date: Tue, 10 Mar 2026 19:55:34 +0800
Message-Id: <20260310115534.3477871-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHYne5BrBp96icAA--.72S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1UKr4xCFW3JrW7Zw1UWrg_yoW5Gw1Upr
	Z7ua48tw4UXFy0q3ZrA3WI9r10vw4rJa4xCFn2ka4xJrsxJr1kXrnagFn2qFyjqFWrZw4f
	ZFyvyry7u348ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEksgUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC6Bw3QWmwBry8jgAA3T

In RT-Linux, when enabling CONFIG_PREEMPT_RT_NEEDS_BH_LOCK, calling
__local_bh_disable_ip() when !preemptible() is illegal because it uses
local_lock, which might sleep. The only exception is during the
cgroup_init() logic in start_kernel() while preemption is disabled,
cgroup_init() calls cgroup_idr_alloc(), which calls spin_lock_bh().
It is sufficient to only exclude the system startup phase in macro
DEBUG_LOCKS_WARN_ON.

Although the original check of this_cpu_read(softirq_ctrl.cnt) can also
prevent the WARN_ON print during the boot process, it may hide some issues
that should be exposed immediately. Because softirq_ctrl.cnt maybe 0 when
__local_bh_disabled_ip() is called in !preemptible() context.

In RT-Linux, __local_bh_disable_ip() will be used by numerous _bh variants
locks and local_bh_disable(). Since locks call __might_resched() check, we
analyze the scenario of using local_bh_disable() in !preemptible() context.

If CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled, __local_bh_disable_ip()
does not enter the local_lock lock and thus using local_bh_disable() in
!preemptible() context does not lead to might sleep problem, but using
local_bh_disable() in !preemptible() state is not meaningful in RT-Linux.

In non RT-Linux, we use local_irq_save() followed by local_bh_disable() to
keep soft interrupts disabled after restoring interrupts. However, in
RT-Linux, when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled,
local_bh_disable() merely increments the softirq_ctrl.cnt counter without
actually disabling the soft interrupt behavior, because other tasks on the
CPU can preempt the task that wants to disable soft interrupts and execute
soft interrupt-related logic.
Consider the sequence diagram below:
Task A                        Task B
                              __local_bh_enable_ip()
                                __do_softirq()
                                  handle_softirqs()
                                    ...
                                    local_irq_enable();
                                    ...
local_irq_save()
local_bh_disable()
local_irq_restore()
                                    h->action(); -- it is serving softirq
local_bh_enable()

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 77198911b..320a52583 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -173,7 +173,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
-			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
+			DEBUG_LOCKS_WARN_ON(system_state != SYSTEM_BOOTING);
 		}
 	}
 
-- 
2.34.1

