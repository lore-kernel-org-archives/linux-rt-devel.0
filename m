Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158326;
	b=cWKbBd6bYW/EqfXQzjWUoorf65Ld/nMenMWM18+qTMUrgSvPgTmvwH/PR1Ma8mRo7S+g
	 nKnqXbkjlAklcqCxAlAh4un6OPMC8djGyzXFOkb1YUTviUvUS8SKn5FSmmbyMr0UT8giI
	 THdusirDLc77eEIwQEMuTJpdDIRH33AU5gH2kn7vQXrPanVE+jUriHIZ6BfH066zK46Vk
	 M28lYFfot/DRb6+x3VK0ENGY9MfJ4gn/elZNylQq68pWtZiVTcT7Akq3PeUvFGqOKnzbW
	 jrI+rLM7fd4uoVwHgzfQqMr6ePD1W6ICxu5xhOLdubyHs+hEnPRdyb2Na3AzvKnaQLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A8EkBHzSkpvWMyA+KA0OYUqo4zY3bIhhFtk/YpfILDM=;
	b=xiGT37xXy4Ew496YssdtPce99VGymSEOd/tJ7FGyFQqNtyCchhaHglFydvFPNMYTyxWO
	 9ImDZIDF4Zw5POkRJtJlNAOe8tc6MCwSEKYeLKudEUA2nORs+9oCobfjRisVv9z2m3lh+
	 Gu+aoEeawfWeDz60zJULQYkINihrx/OjN6N6NFDKamObvtnggCdS6d3yv0iWk6OgZ4Tps
	 fo7wO2s6cbs8IPNqyxJP9GMDCTjy4ojkr9yWsIT3z46j0iUCQ5bAIMlE3m6UJCFShWzes
	 zAfh+jnVXtr4kJ27acozZbBSyazDpljYNMkCQb63JnAtGxWZTBKdxwWns2kef55P4oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BuH5zdiy;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BDF606A327
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BDF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BuH5zdiy
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso298438f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158324; x=1793763124; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A8EkBHzSkpvWMyA+KA0OYUqo4zY3bIhhFtk/YpfILDM=;
        b=BuH5zdiyb49gZAfIBJQoFonucYo9zkYx4yUeBXZYRwTfdMOmBUy0bDUydb4cjfkMou
         YGgUX9djDQ1tOAEUcKph5fvH6UZD58n6DYvGMXrul5kIVGwvc1wi7ykM6s7jdL4I6Nj3
         cPxarY9/PjJFPFeaBpuZl6nT3duTiobu9dTuLaxAiKUr8E/8Y2RsLb2q1vgRuImklfdw
         35S8ZGcZwKG3jNsfQzDnktW/kYDcYDoqSQJwgMmpPYBQfgQUienyxNrFw1gRjkRIqJVJ
         0iHm6vI4P34cbx6QnDKbMicxH2+ZM+1la8tN/mD8noF/oUvQtP0LqKzAssDB0+mD8H1G
         ErNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158324; x=1793763124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A8EkBHzSkpvWMyA+KA0OYUqo4zY3bIhhFtk/YpfILDM=;
        b=aIXg3jFjiKwBNKJAAkjaAlFuQTNOUmMeXtS/VtALw498F/benbawoNjc/5jkYq5gs6
         QpSydvuhSnZvy95CVZ1YwSRSZ8E0JlCZfswuQtFKwxvR6C6/GS4bzGIM0ws0hhW+m2no
         Hh6Z6CdRvLrTHgSBwgBTXQEZ6y3Rg0e3yiwyLg5LHpw+aFNudgWNZEJrtjn6do4iou5w
         ufXL0RBHeEt5MnblpgVDHkDPvcaLb5DfgZzQZXNSaOjUwkxCxAZQMTyvwMqtmLzkNgX8
         CsfTeXRXW2/dsoqqB+jfHqh3wTmz26JvtAneRFfyphdAtYfV/pZvmd09xABd5hJfAYWt
         vh8A==
X-Forwarded-Encrypted: i=1; AKwUvBwfrGKMu62HXu9g7k20yqRzdnjLnsjP8JFPxn8ViUOwCoSRmFEF+RAB3C7OCd8+9D2YWqMglK5zA5JyWz+VCw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLyf6yvM2UVJnq8BU81hWnnsefcmlWY+NholMx1TMangZ5P9qD0
	6h85CNh8dYN+hDG4/FGrfCiX3CsxFtKT825NDzmIvE+as99lS6FalFfg
X-Gm-Gg: AYBFou2U/7+NE+nRHvjK5EvHV+snUj/ClXXbqcjpseRQmXBOw2w/Ij0Zta4usfr1FLm
	mDx+yeZCi/npuXAtabFdLZye71wrbtjb4lHE/SuUVcdD86L3yBoN056Sn+qhLf6OFgkVcC/fWdP
	K+XlOJdGiG+UXwgNUEuFW6l0K/ANBY0SyZfulfSRSCAKTSboT+4UQk95UTlXUuR3oXGa9LUbuG9
	LHCi7WBJf/KE+BPDuuGWRm0+r7ePAUJeSz/5iJFZxypUgEp46mXm4KPFSb+S4jizNDDGmyz+zpO
	WV8kgOuTwGD6EVv14BOVIzI8LpvoF44G4kITTI4H1msjrnk3d09BChhbmRQKtVTawCcfjAT1oax
	J1LMMOvnjYe4eQZf5QyOSMRW21OH17ai1zhJnULixhOY54SXhavHcRmGsE2k5SjRFf0Ituv+wXs
	CfCkI77gjUHs59EK6T7dsaLxDfU6SBvDoW7t6eMzjO5V61oa7K7cIKsSYi3HLFr21tuWLIh6yNQ
	/3c4wjqWQ4tJCU3MLYDa/xHJF534HKrft9Wuwt/eypgAjQLnZJqy1Mqr/xAaz7qHb45lMGj8IT/
	RVtmdGKNM+r465C1iYXrz1UH9A3JGZfdktjRg8THWaEX7vruOcKfYPBXjJBMRMFclTyT/IHmyFy
	we61lt7r/MI+qPQ/Nkmj7mCyEk1xLFBLS1xK39sqWx9BPP7BvnG+WVIIcdMAjhuUN68OYrVXiFf
	kfRDWMhZW1QNl3dnbeF7TiYe5eZPNNZuXF
X-Received: by 2002:a05:6000:46d9:b0:48d:fa9c:7838 with SMTP id ffacd0b85a97d-48e5d567dd3mr1945784f8f.2.1793158324146;
        Tue, 27 Oct 2026 20:32:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 08/13] lockdep: Prepare IRQ-on state from a hardirq return tail
Date: Wed, 28 Oct 2026 04:31:22 +0100
Message-Id: <20261028033127.82193-9-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028033127.82193-1-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lockdep_hardirqs_on_prepare() rejects any live hardirq context. An ordinary
hardirq return tail needs to retain synthetic hardirq nesting through
traceable IRQ-on preparation. This keeps callbacks classified as hardirq
work.

Factor the common preparation and add a return-tail variant which requires
the synthetic hardirq context to be present. An interrupted outer hardirq
can contribute additional nesting. Keep the ordinary helper restricted to
zero. Neither helper changes IRQ or hardirq state. The caller must remove
the tail context before lockdep_hardirqs_on().

Assisted-by: LLM
---
 include/linux/irqflags.h |  2 ++
 kernel/locking/lockdep.c | 43 +++++++++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index e98313a8ad307..c7601a173e55b 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -25,6 +25,7 @@ struct task_struct;
   extern void lockdep_softirqs_on(unsigned long ip);
   extern void lockdep_softirqs_off(unsigned long ip);
   extern void lockdep_hardirqs_on_prepare(void);
+void lockdep_hardirqs_on_prepare_irqtail(void);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
   extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
@@ -33,6 +34,7 @@ struct task_struct;
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on_prepare(void) { }
+static inline void lockdep_hardirqs_on_prepare_irqtail(void) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
   static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 01dba8fb32a90..2ecd506715fa7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4395,15 +4395,7 @@ static void __trace_hardirqs_on_caller(void)
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 }
 
-/**
- * lockdep_hardirqs_on_prepare - Prepare for enabling interrupts
- *
- * Invoked before a possible transition to RCU idle from exit to user or
- * guest mode. This ensures that all RCU operations are done before RCU
- * stops watching. After the RCU transition lockdep_hardirqs_on() has to be
- * invoked to set the final state.
- */
-void lockdep_hardirqs_on_prepare(void)
+static void __lockdep_hardirqs_on_prepare(bool expect_hardirq)
 {
 	if (unlikely(!debug_locks))
 		return;
@@ -4442,10 +4434,11 @@ void lockdep_hardirqs_on_prepare(void)
 		return;
 
 	/*
-	 * Can't allow enabling interrupts while in an interrupt handler,
-	 * that's general bad form and such. Recursion, limited stack etc..
+	 * Ordinary IRQ enable requires no hardirq context. The interrupt return
+	 * tail variant requires its synthetic context, possibly nested inside
+	 * an interrupted outer hardirq.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context()))
+	if (DEBUG_LOCKS_WARN_ON(!!lockdep_hardirq_context() != expect_hardirq))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -4454,8 +4447,34 @@ void lockdep_hardirqs_on_prepare(void)
 	__trace_hardirqs_on_caller();
 	lockdep_recursion_finish();
 }
+
+/**
+ * lockdep_hardirqs_on_prepare - Prepare for enabling interrupts
+ *
+ * Invoked before a possible transition to RCU idle from exit to user or
+ * guest mode. This ensures that all RCU operations are done before RCU
+ * stops watching. After the RCU transition lockdep_hardirqs_on() has to be
+ * invoked to set the final state.
+ */
+void lockdep_hardirqs_on_prepare(void)
+{
+	__lockdep_hardirqs_on_prepare(false);
+}
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
 
+/**
+ * lockdep_hardirqs_on_prepare_irqtail - Prepare an interrupt return tail
+ *
+ * Like lockdep_hardirqs_on_prepare(), but invoked while the synthetic lockdep
+ * hardirq context covering an interrupt return tail is still active. An
+ * interrupted outer hardirq can contribute additional nesting. The caller
+ * must remove the tail context before lockdep_hardirqs_on().
+ */
+void lockdep_hardirqs_on_prepare_irqtail(void)
+{
+	__lockdep_hardirqs_on_prepare(true);
+}
+
 void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
-- 
2.39.5 (Apple Git-154)

