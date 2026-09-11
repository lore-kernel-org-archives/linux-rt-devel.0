Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D42E6CB8
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137508; cv=none; b=aFdfgXMAXIL0pPbLhevC4SvCDwEfpwie15VyVDSdWOL0zz2dKhBj3ULJ49Xc7wx5LbsyW7jDf9lBdIJy2jvLwY8b94yk+CKHhE32sKvM1ieQz/uGrwHbwHaY2BqagsaWzXLvXdS/Hj5c0vuoj/i10qt1JSd7JVL+S/DZ1Jr6Zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137508; c=relaxed/simple;
	bh=R7R18QEPttI5tJ0Mnid1UU0N5zuu9+//SNy8MOd6bO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5+pOyPwxiKyI+WQMvN6USF6+9GQvmK/iNUkOe71CR5a7ENuQl3R4Erqk6cwRqPjJUuBK4jpIVX3kCY10zKPcPB+tOt9krjrpp1ZBqW6rMLaffi2hWCYHFdbvD0V9bAC8j/0UFKXGx+n+kNTEX4AjLkKpomFCTY044eiL+m8hRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qGPwVphw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=19WPZ2GN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qGPwVphw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19WPZ2GN"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789137501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9IFnuoISe8DVZ4o8aEwdjhC6POqjZl+keV1u44bYjE=;
	b=qGPwVphwNXxowtP7Vv3qfHiY2O1+kE0YLhyRRIe0Xv7c05S/z2aR2xIj6Pr6/vS25TI8rE
	/Cbus7YMLfxbPFyf5mLr2W3H/RQFk3U7bKjpxvvqmNlYQHFbNmFCeOLt6oRj6SQt/h4PLU
	7KT5LS28ykAtghs4B7r+c46cpF6dQ5hiuiHAytbxqP9OYPnkhn/jT3KqDXmRJH3piNsiVa
	94do4qidRHRnYb9KSZuNE459smv5oe2KgzraLQJdRbjzXETVuclXZkjxrIFpCrCHkdrfHR
	OjxzkxdUUuPx17i04LdBjGd1KA69/MDeN2yFSHDSjB9L2zSxp+aYyl3MOxZnXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789137501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9IFnuoISe8DVZ4o8aEwdjhC6POqjZl+keV1u44bYjE=;
	b=19WPZ2GN5M/wPzdSaCQB5gsPYjpVRUlsrF5K2uWPXcGcWR27MzW3i4PKedvrVoJ9kHEDk1
	ecyIx09iKYf8IfDA==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/3] irq_work: Flush lazy work CPU down on PREEMPT_RT
Date: Fri, 11 Sep 2026 16:38:13 +0200
Message-ID: <20260911143815.997254-3-bigeasy@linutronix.de>
In-Reply-To: <20260911143815.997254-1-bigeasy@linutronix.de>
References: <20260911143815.997254-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PREEMPT_RT invokes IRQ_WORK_LAZY callbacks and callbacks which are not
explicitly marked IRQ_WORK_HARD_IRQ from thread context.  If a CPU gets
shutdown, the irq_work is flushed during smpcfd_dying_cpu() which is
invoked on the target CPU with disabled interrupts.

The callbacks enqueued on lazy_list on PREEMPT_RT are not flushed because
they require thread context. The callbacks remain and get processed once
the CPU gets back online.

per-CPU irq_work items continue to work for enqueues on their local-CPU,
only the work on the "offline" CPU get stuck. "Single" irq_work are
worse because they remain "claimed" and can not be used again. One
"symptom" is the late printk() in CPU down path which enqueues the
irq_work for printing but it never gets scheduled. Further prints don't
print to the console because the irq_work is "pending" of the offline
CPU.
Another problem is the canceling/ flushing of the irq_work which is
stuck. Since the irq_work will not continue, the task waiting for its
completion will block waiting.

While looking through the users of irq_work, it does not matter if the
callback is enqueued on another CPU. This makes it possible to invoke
the callbacks from a remote CPU by smpcfd_dead_cpu(). This is invoked
from the control CPU with enabled interrupts shortly after the
hotplugged CPU is shutdown so the llist can be accessed safely.

Add irq_work_run_cpu() which invokes the irq_work callbacks of the
specified dead CPU. Invoke it from smpcfd_dead_cpu().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irq_work.h |  2 ++
 kernel/irq_work.c        | 11 +++++++++++
 kernel/smp.c             |  1 +
 3 files changed, 14 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index c5afd053ae32c..7184e12739653 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -59,6 +59,7 @@ void irq_work_sync(struct irq_work *work);
 #include <asm/irq_work.h>
=20
 void irq_work_run(void);
+void irq_work_run_cpu(unsigned int cpu);
 bool irq_work_needs_cpu(void);
 void irq_work_single(void *arg);
=20
@@ -67,6 +68,7 @@ void arch_irq_work_raise(void);
 #else
 static inline bool irq_work_needs_cpu(void) { return false; }
 static inline void irq_work_run(void) { }
+static inline void irq_work_run_cpu(unsigned int cpu) { }
 static inline void irq_work_single(void *arg) { }
 #endif
=20
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 9f19c05c9962c..73eabcbdcd50c 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -263,6 +263,17 @@ void irq_work_run(void)
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
=20
+void irq_work_run_cpu(unsigned int cpu)
+{
+	if (WARN_ON_ONCE(!cpumask_test_cpu(cpu, cpu_dying_mask)))
+		return;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return;
+
+	irq_work_run_list(per_cpu_ptr(&lazy_list, cpu));
+}
+
 void irq_work_tick(void)
 {
 	struct llist_head *raised =3D this_cpu_ptr(&raised_list);
diff --git a/kernel/smp.c b/kernel/smp.c
index b696bcc60c08f..8f530a094c304 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -87,6 +87,7 @@ int smpcfd_dead_cpu(unsigned int cpu)
=20
 	free_cpumask_var(cfd->cpumask);
 	free_cpumask_var(cfd->cpumask_ipi);
+	irq_work_run_cpu(cpu);
 	return 0;
 }
=20
--=20
2.55.0

