Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAE1F0995
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Jun 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841841; cv=none; b=e0TSBv6ZoMyjUa7HSj67gKa8eMvDeuTWWhBF6A968/NH8DojbA2CoDp6+NVkom2tYIa2UvdWC5LXdlj227mRe1tUGhZY8X8RQ+vyQYdK+8uBQIwPjMU/Df0ewDLe2yKccg43b4FvoP6tIQugiXUJlZIm+tVGe7mGIY3uQ+QPAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841841; c=relaxed/simple;
	bh=QA9NqgcgUWHrqYUqBR7yhraSomobFIbUflse/YSJvq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rctsl8BrCISVJqKG83w5clEmVnSCkKck3CgZbbfu2qyHqAugyxVaeUtS52hS1n+U+IYmiIqcQhxjHMYZ+Eu5+shiO3rM2Kd3oYtuuQhTZUYFyB1KD4kMc0I/hV0fjsf6WHZuvfBsesRM6hQwtvbHPVsFIgoFvWG6KM6TeKj+vxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lFgpfZjx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oB49dWEh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lFgpfZjx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oB49dWEh"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750841837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dSz85eYJTtAi2agc17qHX/1+bUZe+MGxymAHtYLqr88=;
	b=lFgpfZjx6uGRBsvO6dZpYkaK/A1Hv0Lp9I4Gy2AZkQTGOTa3Xkj7rsKYGOYsFwfOIaYG5N
	OQflmYoNU4FsbqpmCLHi5QQ8+2j6tDjTcldiGCjpuI/4AUnBj/UqKIjzGlYacLOt1HBvT4
	n+4SZws3px68REiKi7p4bIuK8jA0kb/jf7rKqVHaD4N2MYWi7eBJGastjFjNDU2ioMcSXK
	DfSzFi8Sox6he9lwzpem7dlJ8aEc//nGHpGD04NWF8w5psSR+U9Y6fADi5Gbu1LKudCYRT
	Eglv1lVnyXXHQfai9C0f8oVZ1H82LMVIOuCGTQCuog+vxFEjWxH0w7wQEUK3jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750841837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dSz85eYJTtAi2agc17qHX/1+bUZe+MGxymAHtYLqr88=;
	b=oB49dWEhOw+nx9sg5XL7NPDHjTHRc9m7yCEd4CUCCHCIbhEt9u6hptaDyX1AHnG9X4HFbi
	2DFIVtQyBwQwKtBg==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2] riscv: Enable interrupt during exception handling
Date: Wed, 25 Jun 2025 10:56:30 +0200
Message-Id: <20250625085630.3649485-1-namcao@linutronix.de>
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

There is no reason that interrupt must be disabled while handling
exceptions from userspace.

Enable interrupt while handling user exceptions. This also has the added
benefit of avoiding unnecessary delays in interrupt handling.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: stop enabling interrupts for kernel exceptions. For exceptions treated
like NMI, it is wrong. For page faults, interrupts are already
(conditionally) enabled.
---
 arch/riscv/kernel/traps.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 9c83848797a78..80230de167def 100644
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
@@ -151,7 +152,9 @@ asmlinkage __visible __trap_section void name(struct pt=
_regs *regs)		\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
+		local_irq_enable();						\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		local_irq_disable();						\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
 		irqentry_state_t state =3D irqentry_nmi_enter(regs);		\
@@ -173,17 +176,14 @@ asmlinkage __visible __trap_section void do_trap_insn=
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
@@ -308,9 +308,11 @@ asmlinkage __visible __trap_section void do_trap_break=
(struct pt_regs *regs)
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
--=20
2.39.5

