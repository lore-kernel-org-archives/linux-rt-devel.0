Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005248F77;
	Fri,  9 May 2025 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746756401; cv=none; b=A1Eau9LfohF97T3CVirpPd094TUjkeyrg/TLV7uEjDzAPMwbiTDuJiT1/967YPZxS9unRUgNw4idj92RtoL2o9TQLAROEeh1ScOB6+8tMpx2bTqbd/bSREL0zJHPR9yQ+BQXWTN88SRBw5tSK8OAaj+ibkORm2sCLi6FIVF6/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746756401; c=relaxed/simple;
	bh=eOG+6uPAgB6kk87jbQU1jozNIa3ia4nGj0etd0Lgu8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MXlbMwWWFRLscwOx5pifiPEgfgeyy73GC+jc12C59aaF4qTWogZToXs+mxz8JXHNN2YbrwGrPcO9XHHZfkFFSiAAv3ViBSehxsVd+HuhgqU/PpTvND9masZhDe9DwhzZBxoDVp2lBtdxqPtpmKj9DULZO9Y/+nD3Nti6mF8+lhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8CxeXElYx1okdPaAA--.30539S3;
	Fri, 09 May 2025 10:06:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMBxLscjYx1owBG_AA--.32426S2;
	Fri, 09 May 2025 10:06:27 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Prevent cond_resched() occurring within kernel-fpu
Date: Fri,  9 May 2025 10:06:26 +0800
Message-Id: <20250509020626.23414-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxLscjYx1owBG_AA--.32426S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryUKFyDXFyxuryDtr15WrX_yoW5Jr4Upr
	yfur95tr4UJa4ava9rJw18Cry5Awn7G34xWa9xG34rA34Yqr18Xwn29r12qF12vFyIyFyS
	vFnYqrWI93W5A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU

When CONFIG_PREEMPT_COUNT is not configured (i.e. CONFIG_PREEMPT_NONE/
CONFIG_PREEMPT_VOLUNTARY), preempt_disable() / preempt_enable() merely
acts as a barrier(). However, in these cases cond_resched() can still
trigger a context switch and modify the CSR.EUEN, resulting in do_fpu()
exception being activated within the kernel-fpu critical sections, as
demonstrated in the following path:

dcn32_calculate_wm_and_dlg()
    DC_FP_START()
	dcn32_calculate_wm_and_dlg_fpu()
	    dcn32_find_dummy_latency_index_for_fw_based_mclk_switch()
		dcn32_internal_validate_bw()
		    dcn32_enable_phantom_stream()
			dc_create_stream_for_sink()
			   kzalloc(GFP_KERNEL)
				__kmem_cache_alloc_node()
				    __cond_resched()
    DC_FP_END()

This patch is similar to commit d021985 (x86/fpu: Improve crypto
performance by making kernel-mode FPU reliably usable in softirqs).  It
uses local_bh_disable() instead of preempt_disable() for non-RT kernels
so it can avoid the cond_resched() issue, and also extend the kernel-fpu
application scenarios to the softirq context.

Cc: stable@vger.kernel.org
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/kfpu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
index ec5b28e570c9..4e469b021cf4 100644
--- a/arch/loongarch/kernel/kfpu.c
+++ b/arch/loongarch/kernel/kfpu.c
@@ -18,11 +18,28 @@ static unsigned int euen_mask = CSR_EUEN_FPEN;
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
 static DEFINE_PER_CPU(unsigned int, euen_current);
 
+static inline void fpregs_lock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+}
+
+static inline void fpregs_unlock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
+}
+
 void kernel_fpu_begin(void)
 {
 	unsigned int *euen_curr;
 
-	preempt_disable();
+	if (!irqs_disabled())
+		fpregs_lock();
 
 	WARN_ON(this_cpu_read(in_kernel_fpu));
 
@@ -73,7 +90,8 @@ void kernel_fpu_end(void)
 
 	this_cpu_write(in_kernel_fpu, false);
 
-	preempt_enable();
+	if (!irqs_disabled())
+		fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
-- 
2.20.1

