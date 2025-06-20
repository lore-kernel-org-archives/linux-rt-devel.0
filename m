Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797B21C17D
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Jun 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419838; cv=none; b=nZltQ1UXLNHgLHFbNtgCoRcukCMjSp/Ph07dLAvfVFNtwADW/fi6z7wpzhIRjHjIUzKfUzyYQmZWYyjhDhLbTh2ok64eH4MkOZ5UdJo8Nn3SWTvrlkfXvtb6hpCMkG9yqLaUWsM4BPICVsldKbmKMq1Oq6rLCtR57VrprCxAhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419838; c=relaxed/simple;
	bh=m/mUXUZ6+NGykPq7xxAoqFXkmsGmjOVJWDwEZJ7iyX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VUpFpcylGv+TVCE5XkFnotKgSlLvzacY/YrwBjmenQGd7xvjINJyV33nf9eiYkcZUDmahkGt2wjQYj4qFMZREEm8ildPvkTTCPqeoQ8cr1/n/O0xdd/GEyOEsjioBrhyxs+DtXZC+fnrC9S/hlBwnG3iVO7wAOKNfEuG87okU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UgUIeio2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S2AkSu5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UgUIeio2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S2AkSu5x"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750419835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/m3+MZqHQPeqM4I6z9a/fRPvjt+/JpRRAWT413jndnE=;
	b=UgUIeio2TQ/ldfUgVRx45f7RhPur2s6/w/Zk+Q8N5LgKQ9Wn6LDYoHIjLVzIjxLZIFtlgR
	rmxJC2f+fkkG35+gSlPyxdoGmGayU35dOqp1XvVgcsZT56+1AVt8zTapYmR22q4i560Rk6
	PQzvSS3lTcePTtBC5FPp/5A9MhO90Va1/av3v9FkiOB5nrrY2ocyM30c3lw2NtdID2Cg/t
	bb3z5a7pmQUZoycK+BqEwfkZWUx7SSvFq+foML8aPYvywhuXUe60UPTNLPyow4+8OTbm9y
	+LN5sgKR+ahV7UnwU4F5Eh0nTC/1r23hNdx8RVkRqB8FaXkXczpdj4EPeZ4EXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750419835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/m3+MZqHQPeqM4I6z9a/fRPvjt+/JpRRAWT413jndnE=;
	b=S2AkSu5xJwmQmDYKmvGUyq5asUVpOA8dobkqtgXYu5t9/A0xyhwOEwoMBpX7tpAOzSPEOx
	y66RgqrhVfMUF8BA==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] riscv: Enable interrupt during exception handling
Date: Fri, 20 Jun 2025 13:43:46 +0200
Message-Id: <20250620114346.1740512-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

force_sig_fault() takes a spinlock, which is a sleeping lock with
CONFIG_PREEMPT_RT=3Dy. However, exception handling calls force_sig_fault()
with interrupt disabled, causing a sleeping in atomic context warning.

This can be reproduced using userspace programs such as:
    int main() { asm ("ebreak"); }
or
    int main() { asm ("unimp"); }

There is no reason that interrupt must be disabled during exception
handling. Considering the previous struggle with a similar bug [1][2], fix
this problem once for all by enabling interrupt during exception handling
whenever possible:
  - If exception comes from user (interrupt handling was for sure enabled)
  - If exception comes from kernel and interrupt handling was enabled

This also has the added benefit of avoiding unnecessary delays in interrupt
handling.

This patch mimics x86's implementation.

Link: https://lore.kernel.org/linux-riscv/20250411073850.3699180-3-nylon.ch=
en@sifive.com [1]
Link: https://lore.kernel.org/linux-riscv/20250422162324.956065-3-cleger@ri=
vosinc.com [2]
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/kernel/traps.c | 36 ++++++++++++++++++++++++++++++------
 arch/riscv/mm/fault.c     |  4 ----
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 9c83848797a78..f7d2372dc0eb6 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/randomize_kstack.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -72,6 +73,18 @@ static void dump_instr(const char *loglvl, struct pt_reg=
s *regs)
 	printk("%sCode: %s\n", loglvl, str);
 }
=20
+static void cond_local_irq_enable(struct pt_regs *regs)
+{
+	if (!regs_irqs_disabled(regs))
+		local_irq_enable();
+}
+
+static void cond_local_irq_disable(struct pt_regs *regs)
+{
+	if (!regs_irqs_disabled(regs))
+		local_irq_disable();
+}
+
 void die(struct pt_regs *regs, const char *str)
 {
 	static int die_counter;
@@ -151,11 +164,15 @@ asmlinkage __visible __trap_section void name(struct =
pt_regs *regs)		\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
+		local_irq_enable();						\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		local_irq_disable();						\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
 		irqentry_state_t state =3D irqentry_nmi_enter(regs);		\
+		cond_local_irq_enable(regs);					\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		cond_local_irq_disable(regs);					\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
 }
@@ -173,24 +190,23 @@ asmlinkage __visible __trap_section void do_trap_insn=
_illegal(struct pt_regs *re
=20
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-
 		local_irq_enable();
=20
 		handled =3D riscv_v_first_use_handler(regs);
-
-		local_irq_disable();
-
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 				      "Oops - illegal instruction");
=20
+		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state =3D irqentry_nmi_enter(regs);
+		cond_local_irq_enable(regs);
=20
 		do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 			      "Oops - illegal instruction");
=20
+		cond_local_irq_disable(regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
@@ -225,6 +241,7 @@ static void do_trap_misaligned(struct pt_regs *regs, en=
um misaligned_access_type
 		local_irq_enable();
 	} else {
 		state =3D irqentry_nmi_enter(regs);
+		cond_local_irq_enable(regs);
 	}
=20
 	if (misaligned_handler[type].handler(regs))
@@ -235,6 +252,7 @@ static void do_trap_misaligned(struct pt_regs *regs, en=
um misaligned_access_type
 		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
+		cond_local_irq_disable(regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
@@ -308,15 +326,19 @@ asmlinkage __visible __trap_section void do_trap_brea=
k(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
+		local_irq_enable();
=20
 		handle_break(regs);
=20
+		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state =3D irqentry_nmi_enter(regs);
+		cond_local_irq_enable(regs);
=20
 		handle_break(regs);
=20
+		cond_local_irq_disable(regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
@@ -355,10 +377,12 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state =3D irqentry_nmi_enter(regs);
+		cond_local_irq_enable(regs);
=20
 		do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->epc,
 			"Oops - environment call from U-mode");
=20
+		cond_local_irq_disable(regs);
 		irqentry_nmi_exit(regs, state);
 	}
=20
@@ -368,11 +392,11 @@ void do_trap_ecall_u(struct pt_regs *regs)
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state =3D irqentry_enter(regs);
+	cond_local_irq_enable(regs);
=20
 	handle_page_fault(regs);
=20
-	local_irq_disable();
-
+	cond_local_irq_disable(regs);
 	irqentry_exit(regs, state);
 }
 #endif
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0194324a0c506..6d23ed0ce8a28 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -306,10 +306,6 @@ void handle_page_fault(struct pt_regs *regs)
 		return;
 	}
=20
-	/* Enable interrupts if they were enabled in the parent context. */
-	if (!regs_irqs_disabled(regs))
-		local_irq_enable();
-
 	/*
 	 * If we're in an interrupt, have no user context, or are running
 	 * in an atomic region, then we must not take the fault.
--=20
2.39.5

