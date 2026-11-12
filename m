Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470085;
	b=BhvXfc6lCna5W7KlH/KKn6fNA7QzQNLHPHUPYJXUc8bvB86X7rDxd4vyondfDy6RGfsw
	 1jS1fgoW/rEjA6ef8/pet7l8mKWFJT+LQCyrS/ZMLOfl9T+I5d+vmay6q9IQBmF7Q4B8D
	 Zl1RbmubnRF7g29EI8E9yJuQM4hjEF0fLyXystBiQiitxOlBHkKXNc2ZCimd11C3KMGUN
	 TCQ3ibeOvvwvxbygmXasjRM9SeQcJlq8WvNCcyEeZxIP5XTCYIp8s10mREIuLgLiEqmZR
	 eAUQLS346PDQumfiy0e6TdroEtlkIQ/GSmJ8VG1gPEjl8NF2wQGe3EOtvGaJ3qlNRJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470085;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=djctqSnhrcBejenkoaZxRRPbd4r/+GRrKcP4QIKjFSw=;
	b=Bf0ImYMAiOjmKuwVmkd9uFk9IAnIKuq3T/rn5CB9sthtNJrW/GnRcb8g454IRcxwgi5Q
	 ifKRZmbQjdBbuSMzfVYntm5LXE6nqebwsV9NxqsWtebkXgqKXuk+mwwDo3gPIs1QbRCAQ
	 grEpJ46gKKWpLRCKGor778+WK01I002AxFQdXLD5DSmFc6nxOqNyJUnx+wLoLgeFqqDiS
	 kq2B+9IauuqejpYI+QHtV8XfxaRxCip1HVZgIGQssD3yTPZYsKPhRsX5jSLV5PFG97N9o
	 uAD7qJfUOGy95zLXnpAft61HOdk+SE7hwtTV8Yxm5JoSFmlKz5zelnVBMv7ID//YuVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GLjLahCD;
	arc=none smtp.remote-ip=95.215.58.80
Received: from mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37234606A338
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 07:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37234606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GLjLahCD
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=jCIzZyd444ha6pslVm1boveaGld0krXHIpLGnhI5FvQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794470083; v=1; x=1795074883;
 b=GLjLahCDBTChpUkJhgsQMhRmqaPDKVCWTZTJjtj7UThn8K+2SHfiH7hUxFclnWUTzdN/1t3l
 FNTuYmXdTx1a4PR+7DKBSxNQwNVtRiCjHvbuywz8QSgN86Gs1O0h4/+wTvJkfnFt80aL9EOc+IA
 eFPEre/EiXDgbrhNsMj0odvA=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 6cba420a238a3506;
	Thu, 12 Nov 2026 07:54:43 +0000
X-Mizu-Trace-ID: 6cba420a238a3506
X-Migadu-Flow: FLOW_OUT
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Thu, 12 Nov 2026 07:54:32 +0000
Subject: [PATCH v2 1/2] irqchip/riscv-imsic: Synchronize remote state with
 IRQ work
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-imsic-remote-sync-irqwork-v2-1-680f65b24ff6@linux.dev>
References: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev>
In-Reply-To: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3849;
 i=troy.mitchell@linux.dev; h=from:subject:message-id;
 bh=jCIzZyd444ha6pslVm1boveaGld0krXHIpLGnhI5FvQ=;
 b=owGbwMvMwCU2g/N9w09jE33G02pJDFlfC3aKyj4/JyrC1W9WF3ju0dx9fxIV1vz4fjlbWrpl5
 ewppqsnd5SyMIhxMciKKbJ0P+DZVuATZVsgUOgLM4eVCWQIAxenAExE/BvDP9vq3w+NPpbsuCd0
 +UvGrFlqXNwHj08952U7v+u3lObSBglGhoON+ysDBdxfaX1yY2IqNljaJC3533vZnS81W25I7uC
 x5QAA
X-Developer-Key: i=troy.mitchell@linux.dev; a=openpgp;
 fpr=3FE5535CF1B0E658E57DB59BAE1C2FBEA7DB42E1

Remote IMSIC state updates are deferred to a timer on the target CPU.
If that CPU has stopped its local clockevent and is waiting for a
broadcast interrupt, enabling the broadcast IRQ can depend on delivery
of that same interrupt. This can stall timer delivery when the broadcast
IRQ is unmasked or moved to another CPU, including during CPU hotplug.

Queue hard IRQ work to synchronize remote state independently of timer
delivery. Keep synchronous updates on the local CPU and the timer retry
for an unfinished vector move. Hard IRQ work also avoids depending on a
schedulable worker when PREEMPT_RT is enabled.

Fixes: 21a8f8a0eb35 ("irqchip: Add RISC-V incoming MSI controller early driver")
Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
 drivers/irqchip/Kconfig                 |  1 +
 drivers/irqchip/irq-riscv-imsic-state.c | 19 +++++++++++++------
 drivers/irqchip/irq-riscv-imsic-state.h |  4 ++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 136bab41f801..5cdc3f52198c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -651,6 +651,7 @@ config RISCV_IMSIC
 	bool
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_WORK if SMP
 	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_MSI_IRQ
 	select IRQ_MSI_LIB
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 01620373b43a..f6373e4019a2 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -252,6 +252,11 @@ void imsic_local_delivery(bool enable)
 }
 
 #ifdef CONFIG_SMP
+static void imsic_local_sync_work(struct irq_work *work)
+{
+	imsic_local_sync_all(false);
+}
+
 static void imsic_local_timer_callback(struct timer_list *timer)
 {
 	imsic_local_sync_all(false);
@@ -268,18 +273,19 @@ static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu
 	 */
 
 	/*
-	 * We schedule a timer on the target CPU if the target CPU is not
-	 * same as the current CPU. An offline CPU will unconditionally
-	 * synchronize IDs through imsic_starting_cpu() when the
-	 * CPU is brought up.
+	 * A remote CPU may have stopped its local timer and be waiting for
+	 * the broadcast interrupt whose IMSIC state needs updating. Use an
+	 * IPI-backed work item so enabling that interrupt does not depend on
+	 * its delivery. An offline CPU synchronizes IDs in imsic_starting_cpu().
 	 */
 	if (cpu_online(cpu)) {
 		if (cpu == smp_processor_id()) {
 			if (__imsic_local_sync(lpriv))
 				return;
+			__imsic_local_timer_start(lpriv, cpu);
+		} else {
+			irq_work_queue_on(&lpriv->sync_work, cpu);
 		}
-
-		__imsic_local_timer_start(lpriv, cpu);
 	}
 }
 #else
@@ -510,6 +516,7 @@ static int __init imsic_local_init(void)
 #ifdef CONFIG_SMP
 		/* Setup lazy timer for synchronization */
 		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
+		lpriv->sync_work = IRQ_WORK_INIT_HARD(imsic_local_sync_work);
 #endif
 
 		/* Allocate vector array */
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 189829b8673a..a36b9f0ef840 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -9,6 +9,7 @@
 
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/irqdomain.h>
+#include <linux/irq_work.h>
 #include <linux/fwnode.h>
 #include <linux/timer.h>
 
@@ -34,6 +35,9 @@ struct imsic_local_priv {
 	unsigned long				*dirty_bitmap;
 
 #ifdef CONFIG_SMP
+	/* Remote synchronization must not depend on a timer interrupt. */
+	struct irq_work				sync_work;
+
 	/* Local timer for synchronization */
 	struct timer_list			timer;
 #endif

-- 
2.56.0

