Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3219CD07;
	Wed,  7 May 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612394; cv=none; b=Ori0a1M9SH5+R8JvAn41Vf1GSZrgJ+K/7bGZzo8b4wLnCBwny3roF6YO/RDEG5kTEWSFFrn3KOPStSTpfMrKFIUkNHSHFCXQqRjBDM4glxihpDn0figYrTkCzfRjraNdBENnnZtmN2cs9BASvtxMIQ3gT83NzKETofzP+wCjKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612394; c=relaxed/simple;
	bh=TkYjw2gY1eODfPiUtFnFZw5vNxrfJTGcP3anVqaHl7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crH7uC8CiDq++CBfgurUtkQgB++gVohnp0VCDAoTgZEA/V8EnoFQ/AbOrNKUTQwrFwPXTwOHwnBPK0A0R2qb5iIHopvfEh3uJfLoOzXGtGKJlMMWm4FPkqrLoPxku+uNcOfeFu7Py+jY1DB6CyXzCI2DZNCo4pPrmAJc17v7F0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8DxvnOjMBtoHgvYAA--.59778S3;
	Wed, 07 May 2025 18:06:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMBxXsWiMBtoQcS5AA--.13196S2;
	Wed, 07 May 2025 18:06:26 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH] Loongarch:Prevent cond_resched occurring within kernel-fpu
Date: Wed,  7 May 2025 18:06:24 +0800
Message-Id: <20250507100624.8925-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxXsWiMBtoQcS5AA--.13196S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryrJrW3Cw4rJr1fCF1fKrX_yoW8uF1rpr
	yS9r95tr4UJ3ZIvay3Jr18Gry5J3ykGw1xWFZxGa4rA3y5Xry8Xwn2gr12qFy29FWIvFWf
	ZFn5XrWIg3WUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

When CONFIG_PREEMPT_COUNT is not configured, preempt_disable/preempt_enable
merely acts as a barrier. However, cond_resched can still trigger a
context switch and modify the EUEN, resulting in do_fpu being activated
within kernel-fpu critical section, as demonstrated in the following path:

dcn32_calculate_wm_and_dlg
    DC_FP_START
	dcn32_calculate_wm_and_dlg_fpu
	    dcn32_find_dummy_latency_index_for_fw_based_mclk_switch
		dcn32_internal_validate_bw
		    dcn32_enable_phantom_stream
			dc_create_stream_for_sink
			   kzalloc(GFP_KERNEL)
				__kmem_cache_alloc_node
				    __cond_resched
    DC_FP_END

This patch is similar to d02198550423a0b695e7a24ec77153209ad45b09
(x86/fpu: Improve crypto performance by making kernel-mode FPU reliably
usablein softirqs),to avoids the issue, and extends kernel-fpu application
scenarios to softirq.

Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/kernel/kfpu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
index ec5b28e570c9..e60bbaca357a 100644
--- a/arch/loongarch/kernel/kfpu.c
+++ b/arch/loongarch/kernel/kfpu.c
@@ -18,11 +18,28 @@ static unsigned int euen_mask = CSR_EUEN_FPEN;
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
 static DEFINE_PER_CPU(unsigned int, euen_current);
 
+static inline void fpu_lock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+}
+
+static inline void fpu_unlock(void)
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
+		fpu_lock();
 
 	WARN_ON(this_cpu_read(in_kernel_fpu));
 
@@ -73,7 +90,8 @@ void kernel_fpu_end(void)
 
 	this_cpu_write(in_kernel_fpu, false);
 
-	preempt_enable();
+	if (!irqs_disabled())
+		fpu_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
-- 
2.20.1

