Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102FF3B38A2
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911470; cv=none; b=shUoi0GhV01B1LlvajU3QI+uoV9q12PbKZSzgLvwoZjPMgTWEcOliBvBqGoeBY8yXJHp2Plp3nI1PUKWbrNmogOxY000oqmEHvjdApxmWXCzS7kQXeVtrE92HSfw4RPeO5Xo7Zb4hoQEdI8teYHMSr8IyOCkcvINlM9mZXZd8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911470; c=relaxed/simple;
	bh=Q5pjoXPRXrR4YAOjANnD4MJe+Rq6borHbdwBTCRM/XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cj2Llt62MTKtGXVWokbvqB0qHG1iHSMEXD42N+PSyzGX65FCNQP2qlHPo1mXaHtpSHWrLU5wewOzZYmsyl24t4zrw17qbGGJD7NtcHT7EIEqOMBWWmbd0OXrj1cQBjl35/fnr1RwxN6lI1tbTvzqdQsavWcC9bwWlck81tr6XYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emk+XXVU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emk+XXVU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso33444865e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 08 Jun 2026 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780911466; x=1781516266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbY26Xurtu23jBtBt7MOtdovk/2bF+TdV8T/2baMK9w=;
        b=emk+XXVUH6JeGXyUJ+OprTYHpU4rts4X29l89V87erNa+RoKM6uP6lEZuFu5iDChAC
         OcEsWTPuoSZ464B2GN1gDADHpSngZN0sWwcwJUG02XLMbQD60UDHr6wSZji8nQxABMFd
         +ZOiSMf3XNP4s6b6TMqtjOrplrfB24kYidC9k2sFAtOiNmjCzQYlqu2KYHbDO8iKs7lH
         NzpaZpWR8a92FPisIz8KVvTwkPXAQr8gUeA9WgmXgZiGrXH+AIRTcFHewJAv7aZ9BPAp
         gk0jkiFSizEcMCusHN2te7TgX4sxPPg0POTigXIiCjGaYezSPBFN+e+UG/npHC+ZhXA7
         oYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911466; x=1781516266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbY26Xurtu23jBtBt7MOtdovk/2bF+TdV8T/2baMK9w=;
        b=BcwR9NIGFC/9x2+e47Vc9FtwjsaHve54FA9ksZA4qY84QrQhucJsaY1MZTDFwMkdIB
         qE1intm3lYN1Dy70vda4Wq/p0Ht1m1abvI+Ykr3eeadqaJuNMWSn15MfUI9jeY1BzeMH
         I5sJP/RN+OxK2m9b9K2bSt50Z8Y41b0wxp2sNC5WC2aP3YNqOfnQOqHwQZWICr4oC+4P
         0hBMp089BjoS5RyyNxGD/MowPsSbGw4mGZAtLvLP2Ejg5SNGdJNbncwHRaMAeA1fuStT
         yTWJziFiS2Pl7Rr4nHHEtnoJXBLXlxZ7t5RkhJ9Jbyh0RTLVFIKfonWaQ/3eUv+r1y/M
         8HKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hFKniJUEcCePF9WVh9TqkDTLHGwNEK32WXQGtBZ5GCwWI6Jk2T+E0kMdnvwsrLkxOBB/yeU2rog8Axwkj3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv5ZunrkUmNNq+kVzmSs2h+d5EowLowTOVWOwmxXG4yQEKdzTw
	yiGJRZiF2kewv7QtjwsiRFqCvxgQfEDY6WVNVry/Er7UKyRBUTc+AFmxosgxPQ==
X-Gm-Gg: Acq92OGs1QrqHpH882HRwcAYK7iWJrMMjWOOdBYmK8H0lBG35DR39su6MJrdbwIwz3U
	5Zn8Pe4FQf5pBkYyAwohpNHO0Tp+kClvzuyIqRbdll5kl+/8x2eHfEkkRUBOiz5TnO56D6TrVaG
	HoK403/bfEDiFV+AirQ+iHFTEKcpUDxhQUzI2Ik0H2qJj45ReU0Pa7hHziBMbynW8c27NZd7LcL
	96G51IQGtBT7zvtpfjF+FOTFw60idSLqlKlKOaW+Y7cpe0NXBRbc3sX5/NvL78RifAIonehIzL9
	qKJ/6rH/fC5lNAjS++/t69KXzSNAQqKM4nmDfNwLivALjkrUJeBgLFUJZ6GW76L52qExggzl1k8
	wYfz3/nMYX+DfvNravkiJcfBL8fORQc1IMaHeywwgJig5PSlbaSlWqEgzb1pq84H0ZUrscV5gMf
	Gxycj6cxAHmJh9CEmSnzZb7l132LrCWXgflVrs
X-Received: by 2002:a05:600c:3f1b:b0:490:c0d8:d517 with SMTP id 5b1f17b1804b1-490c2598543mr239183895e9.3.1780911466302;
        Mon, 08 Jun 2026 02:37:46 -0700 (PDT)
Received: from builder ([2001:9e8:f105:6a16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm55829791f8f.5.2026.06.08.02.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:37:45 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Mon,  8 Jun 2026 09:37:29 +0000
Message-ID: <20260608093729.12111-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
marks the CPU offline for the scheduler via set_cpu_online(false) but
never informs RCU, so RCU keeps expecting a quiescent state from CPUs
that are now spinning forever with interrupts disabled.

As long as nothing waits for an RCU grace period after smp_send_stop()
this is harmless, which is why it went unnoticed. Since commit
91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
however, irq_work_sync() calls synchronize_rcu() on architectures without
an irq_work self-IPI, i.e. where arch_irq_work_has_interrupt() returns
false. That is the asm-generic default used by MIPS. Any irq_work_sync()
issued in the reboot/shutdown path after smp_send_stop() then blocks on
a grace period that can never complete, hanging the reboot:

  WARNING: CPU: 0 PID: 15 at kernel/irq_work.c:144 irq_work_queue_on
  ...
  rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
  rcu: Offline CPU 1 blocking current GP.
  rcu: Offline CPU 2 blocking current GP.
  rcu: Offline CPU 3 blocking current GP.

This issue was noticed on several Realtek MIPS switch SoCs (MIPS
interAptiv) and came up during kernel bump downstream in OpenWrt from
6.18.33 to 6.18.34, after the backport of the patch to the 6.18 stable
branch. The patch also has been backported all the way back to 6.1.

Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
generic CPU-hotplug offline path, so RCU stops waiting on the parked CPUs
and grace periods can still complete. MIPS shuts down all CPUs here
without going through the CPU-hotplug mechanism, so this report is not
otherwise issued. Reporting a dying CPU to RCU outside the regular hotplug
offline path is not unprecedented: arm64 does the same in cpu_die_early().
There it is an exception for a CPU that was coming online and is aborting
bringup, rather than the default shutdown action as on MIPS.

Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
CC: stable@vger.kernel.org
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 4868e79f3b30..0f28b4a62e72 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/sched/mm.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
+#include <linux/rcupdate.h>
 #include <linux/err.h>
 #include <linux/ftrace.h>
 #include <linux/irqdomain.h>
@@ -422,6 +423,7 @@ static void stop_this_cpu(void *dummy)
 	set_cpu_online(smp_processor_id(), false);
 	calculate_cpu_foreign_map();
 	local_irq_disable();
+	rcutree_report_cpu_dead();
 	while (1);
 }
 
-- 
2.51.0

