Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930F2C21FF
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Jun 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236257; cv=none; b=ug1YAJFGpj/2s/pDuWzWNWj5y5i4oQD//1mb3ywxUsssjnle+qga7TwLiE7qHwQCbmav8aJn8g3pGvddst29/mjjgqUum02LL6lNzti+MBlUi6s71SGcWpYdcrqNf0zKtyuUYHtRtjylNsk9xVBuc4MvO9Ye+SGGb8qs2IvcJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236257; c=relaxed/simple;
	bh=avjQiiv8cCcIYnt9E2ZpTwjXGjFlEqvPKicig6PEuzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VP28/7W/9C7tU2OQNpEzd/5vqtPLe3Pqd2+wGVNigP9w6/bAzB3BS2N2/kqxGgsMz0PtQ0sZOI07j6pS/+RM0Erx2+fWkGyD6w58dxE/ZVmVoSjLCuPn6duJxcsVzJjttYoeIIlZQQYO3Qv1ewbeJFOwucQEACWS0oNxX5uQKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=iATYjJfC; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="iATYjJfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1782235709;
	bh=XF6tbhKDYptAzOTwXbQhHT13O+eZL/ZgRHBgRBiDPAM=;
	h=From:To:Cc:Subject:Date:From;
	b=iATYjJfCOno1uN/xK3hjDEZymMvO2Hac3c769t1Jxfv05I00h/jqTJC+5vC6bIdhE
	 2p+eHPwvNofV0cV1ebLc7qIcyCltKM3qo/zLRqNZjMSbEI2sejrzO2eNM1REkoMOxy
	 EgHDD2nxDwBOvLNLskEXjTCRECV9c00R5eJSMYTA=
Received: from stargazer (unknown [IPv6:2408:824e:303:c231:c427:8c70:2426:a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9E38365982;
	Tue, 23 Jun 2026 13:28:22 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Henry Chen <chenx97@aosc.io>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Xi Ruoyao <xry111@xry111.site>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] MIPS: loongson64: add IRQ work based on self-IPI
Date: Wed, 24 Jun 2026 01:27:21 +0800
Message-ID: <20260623172728.191557-1-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit 91840be8f710 ("irq_work: Fix use-after-free in
irq_work_single() on PREEMPT_RT"), we observed the performance of
execve() is significantly impacted on MIPS.

While we are unsure how that commit caused the impact or how to improve
it (or even if it can be improved at all), implementing IRQ work with
self-IPI seems able to mitigate the impaction.

Perhaps this can/should be implemented for other MIPS architecture
processors as well, but we don't have the enough knowledge of them, nor
access to the hardware.  So only implement it for loongson64 here.

Link: https://lore.kernel.org/6be1cdd5f91dd7418a32ff372a6f3ae259b19195.camel@xry111.site/
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/mips/include/asm/irq_work.h |  9 +++++++++
 arch/mips/include/asm/smp.h      |  2 ++
 arch/mips/loongson64/smp.c       | 10 ++++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 arch/mips/include/asm/irq_work.h

diff --git a/arch/mips/include/asm/irq_work.h b/arch/mips/include/asm/irq_work.h
new file mode 100644
index 000000000000..d4fa2d80aabc
--- /dev/null
+++ b/arch/mips/include/asm/irq_work.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_MIPS_IRQ_WORK_H
+#define _ASM_MIPS_IRQ_WORK_H
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return IS_ENABLED(CONFIG_MACH_LOONGSON64) && IS_ENABLED(CONFIG_SMP);
+}
+#endif /* _ASM_MIPS_IRQ_WORK_H */
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 2427d76f953f..a545568f1cac 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -50,6 +50,8 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
 #define SMP_ICACHE_FLUSH	0x4
+/* Loongson64 - Self IPI for IRQ work */
+#define SMP_IRQ_WORK		0x8
 
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 147acd972a07..e584299d0fde 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -381,6 +381,13 @@ loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 		ipi_write_action(cpu_logical_map(i), (u32)action);
 }
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	loongson3_send_ipi_single(smp_processor_id(), SMP_IRQ_WORK);
+}
+#endif
+
 static irqreturn_t loongson3_ipi_interrupt(int irq, void *dev_id)
 {
 	int cpu = smp_processor_id();
@@ -397,6 +404,9 @@ static irqreturn_t loongson3_ipi_interrupt(int irq, void *dev_id)
 		irq_exit();
 	}
 
+	if (action & SMP_IRQ_WORK)
+		irq_work_run();
+
 	return IRQ_HANDLED;
 }
 
-- 
2.54.0

