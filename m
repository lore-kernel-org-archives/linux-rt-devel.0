Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587237EFE2
	for <linux-rt-devel@lists.linux.dev>; Thu,  4 Jun 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597470; cv=none; b=nAp6qTi9TXgzBkxiPwZ+G3QQALHaqBH0SuNgn6G8iLLSlEIku5HFByNbFg4paoj6si1XYKu+EdW2pKPFy0CzMmi92dxAe8XJ9JDn2kkYnDDnaBPaszZKfqRHK5L35ZcI6Zbczd2DFmhbsU+ZfAmpwhPITqkuYHgpqOQ3dXJ2MEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597470; c=relaxed/simple;
	bh=90O4xwaiOrLK9AQmOIsYex+cu6SToyEyb6ORubBfVgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cowy8+47PgzMOGm5cVjZ7E3CT0a/S3c+GLeVGooQQiFWEXnJ0vTaCXZx0PiRslmbpNhlQKP1+n6Oa0SOgMg/Ok6veewn+QIGi7gypC4Hc/SC7vZIgEmbzNMElMe105Vj/h60Jvu+2rajF2+c6NVspVTuNey1cmedtF1h+Is/KMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOaJYOk+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOaJYOk+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so9127715e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 04 Jun 2026 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780597468; x=1781202268; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KY7xVSejKqSeN27Js6FROD/NEXBGbGSvmQ/6Y7FcvD0=;
        b=KOaJYOk+e8MPdIABmH+Lck2W3ufUhi8qkuBLEOVQvq6ZbptK3tMttlFedqR18e9Ie6
         WkNywpphukoIsANLFbYaXwY11+E3g+jgV2WqiHV5Naem7QJ71P/4QFa9aR1eGLsihBhe
         aVTEjBJrokS7+2anWlUGCKJloatt/5/elIWJtVVavpUhTN91pPJ3Ev9FjfgtTfHmhGdA
         v7mFwVBGrf1O7W6R6cGnHz8hvQoQpY1yyZgytLdVv8F6/Q56j2xMNfsNmWrvt/BxpbRk
         2Ex9G199hoGB2HXlG8SfQ48xYDJaap/EDLCGV7mP104cqJy1klB5kHsjZtRs4AVssfsX
         +zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597468; x=1781202268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY7xVSejKqSeN27Js6FROD/NEXBGbGSvmQ/6Y7FcvD0=;
        b=piXyqzblHsgQO1BOienZmXbIsKn9LxeM7oHW1POTwLPgETyKwhcR2DeDcMvQwEiG/x
         Nyqxlk/hVnt7zHpImz/K7k2cRt43/kujVx0+bKEkP21EODC7iaJ/apGkfrZ8zEo0fe18
         Lqoiqczw4INCfGm7fhoAoyMU4CmamD+o0lxkt6HAZwsSQVl/Vy6F07eJd5K/LKxrttD/
         CJmwr1Z4M+r4xyuJFvvGyRq+JtS2tz8ZMynTHfFs5s/3XTIFtTiBwpxyyAWthLfLzv0C
         T55YTgvZzwLk2aiKmWNLj636r5MmXc1wPS3+2ANW6I1OFBvQnOIqkffALgDDFMsEaBAx
         0F/g==
X-Forwarded-Encrypted: i=1; AFNElJ8LR8zx6vdNiI5JycGFKDndWd6+/FGNS8RLqXrnjDdwxBzqV4YHt/rAtzD+GBvhSWwHafAVULrJS+IJsKhHxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwXRp3VQJ9sRUVL+ekHHAEhlyZojw4Fm4d83yXBqBfITnI6ZTI
	K7lbLb03UlEFpOME++dMo3hofkQojyrCJ0BeA0+2yhJEUcuzQCypG01H
X-Gm-Gg: Acq92OGoxW8XDHoW9CRbOUTS4Z1C1vrZI9f6nsKyptcLPcun7kI7+3ynmyn6FQUhdb5
	xSM9wqHfHevcRiuZzml1lDBfbuPGKxXq8AXG/FndOv+f9q5/u0eb8O5o/tNo9Qi4u0tucl9ws7h
	c+GjWMaIpesCwoAXcruMw1RFLg+jgKNDUqGulmJ0zATKd2eZuPdPiWx8VVVfql8wc/FdqavsaNY
	VscjyPOp9IWUQ9y887E+wDLSKCLO/yAfStrjLWRadnLTcDsHs4kvyzQxpDukfT3n4lvlUTu1J/h
	K9uQBr92rFX+aIk3uMKM32sgbtlAWUB1YHlkdi7weZcgn9kZoaW1JqRQFneewOSilwqzAj6CoAd
	xkKDDScTOEeK/DjyJKxyQ6i/u6On2njzuoocivgiFvsIvfd66ZwZNYE3cWm6wpjk6THQL7NsNzr
	+7Abh5z40Hx+k9/NKo/46I/Ia7ViPNJJiQC72//Ek0q3oxrG8=
X-Received: by 2002:a05:600c:1f96:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-490b5e7962dmr143876325e9.3.1780597467554;
        Thu, 04 Jun 2026 11:24:27 -0700 (PDT)
Received: from builder ([2001:9e8:f12d:8916:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm100702395e9.10.2026.06.04.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:24:27 -0700 (PDT)
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
Subject: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Thu,  4 Jun 2026 18:24:07 +0000
Message-ID: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
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

This issue popped up during kernel bump downstream in OpenWrt from
6.18.33 to 6.18.34, since the suspected change has been backported to
6.18 stable branch [1].

Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
generic CPU-hotplug offline path (and arm64's stop handling), so RCU stops
waiting on the parked CPUs and grace periods can still complete.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=18c0456ea2615b1a743a6db739c74411c3b42bc6

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

