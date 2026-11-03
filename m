Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693094;
	b=PeZdW6AnXRHIovB/olRAqvYLad2zNpEjX3SJrpgTrZVn2PLY6fbUJ2DONKx2MokTlykT
	 5l6Qp8+xD5Ug+38rrLsgE2i9tsuAm+KoXaBaLqeLessleCZYXTB9idQeMj3stElq0GTXj
	 I2r1msSgJ/bqqsxZo2MIbPA/CcgeOfTtnZg9NwGwg/dfL9D8ODWxjAEW9DJlKQ+3Cg45u
	 gGTneH0FxkRGph/4yrGW7/pyZZwIOSV0sH7wcUI8N60zHPDTUIR42LxWWdm4JwcIPgHcL
	 +Q5qMjTfyP48akWemn6dcLwmZsFrCrRLOruN7lrjxst/a8fCPlaj30PQX6BZip4kQlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693094;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lBZxiQ5cmXwoaVDZ7ajT7A8R3NOnKXHegqMIHSlVWYg=;
	b=HtYRpS1i0tGVwa36Iknig3QLXhquR96MVUnlGQ5J8gCmJsLMgojj3kgHWogdBM3hEbmA
	 ODl1fFubPb00nXmjd4Tw7NPCaWoQBkalCzySL5tna3Itkzyd2BhtPXFAAjm96IeQ1Ezjf
	 S6q6j0M1ie7FG4AtAlP/fkVOse1/tC2RwNxqBxFhFgQo4C1Vmshnii+YIQ5t4gtoZtuQX
	 tT8MbPZ7rv6fqTZVpEvmOJf2/le/sYNWBKhJaMnb212bqR4teiYxe/5hKTdTnlbG8Xoi3
	 UNXQ2rZib1H6ITqZ98bLmUji1jcaCdnLq7q3kGYwUfaB7DN77sZdc/aV7ha9Mov2JPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="WPkOyO7/";
	arc=none smtp.remote-ip=91.218.175.164
Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE4606A329
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 08:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BAE4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WPkOyO7/
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=RWmMBXkZ+vwtLY3BE8puJytWEPMWyGOh1ixW8aK6vWM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793693091; v=1; x=1794297891;
 b=WPkOyO7/jXnLDvvc58HZsAFsfZhlf1yGovKl4MbrDD3v7pUevz+ROx/uSPrQ1a7NHZFsII+0
 gP0Gw5D1MyVzs8i7M66XV5NhZ+lxO8D2+BMYmIXo1Vr48JqGui41RiSMEIjRZEUmPTeEOwyDoa7
 Qhw6IteAtpqUdxhI+EMQw8M4=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id d76ee08530dc8e23;
	Tue, 03 Nov 2026 08:04:51 +0000
X-Mizu-Trace-ID: d76ee08530dc8e23
X-Migadu-Flow: FLOW_OUT
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Tue, 03 Nov 2026 08:04:33 +0000
Subject: [PATCH] irqchip/riscv-imsic: Synchronize remote state with IRQ
 work
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
Message-Id: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxG4auQrm0yg4ZEr2JcaPnRapjRFgVDu
 LujLr/FezM5TOG0q2YyvNQ1p4K4qkgux3QGa1tMdaibGMOatXcVNvR5APs7Cas9xmw33koHaWQ
 TQwsq/d3Q6fR77w9/+/N0hQzfIS3LB/3jP2V9AAAA
X-Change-ID: 20261103-imsic-remote-sync-irqwork-9cfec6c410de
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5097;
 i=troy.mitchell@linux.dev; h=from:subject:message-id;
 bh=RWmMBXkZ+vwtLY3BE8puJytWEPMWyGOh1ixW8aK6vWM=;
 b=owGbwMvMwCU2g/N9w09jE33G02pJDFkvpy6okFmZcNa7vdtgpfeWyO8zZ3w4vqH13Lv8ghreL
 RzfZCIvd5SyMIhxMciKKbJ0P+DZVuATZVsgUOgLM4eVCWQIAxenAEzkcArDXzHZrdmfAnZsvee9
 cz77heo9BSmFKsUCMwt3hgdd3e+5yYjhv2fKPcUE/RVvL/40XrcnKqleN61dWtFz3YWO7d4rJvb
 mMgAA
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
This was found while bringing up the SoC timer on SpacemiT K3 as a tick
broadcast device.

Without a real broadcast device, the tick code falls back to the hrtimer
based broadcast, which keeps one CPU's local timer running. Once the SoC
timer is registered it replaces the hrtimer broadcast, and every CPU may
stop its local timer in idle.

On K3 the SoC timer interrupt goes through APLIC in MSI mode to IMSIC.
When the CPU owning it goes offline, the interrupt is moved to a CPU
that may already be idle with its local timer stopped. IMSIC leaves the
enable on the new target to a timer on that CPU, and that timer can only
fire through the broadcast interrupt, which is not enabled yet. The
system stalls.

Tested on a K3 COM260 board by offlining the CPU owning the broadcast
interrupt, and then each CPU in turn, under a timerfd load:
- v7.4-rc1 with the SpacemiT SoC timer series and local timers forced
  to stop in idle
- a vendor 6.18 kernel with SBI cpuidle states that stop the local timer

Both stall without this patch and pass with it.
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

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-imsic-remote-sync-irqwork-9cfec6c410de

Best regards,
--  
Troy Mitchell <troy.mitchell@linux.dev>

