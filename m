Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071607;
	b=PY24z1eGQHBT7ClktoknMfD6SKiz7b7eTRFm8GOyOREvXvehP+UPn7oVK10nlX0fauee
	 zNVNZqkGHseTAuzKyQz755zJDmeXJ+JSO6Q/cVTKmFFhtK8SjtxcUAzWQ8V9NQ6NYGWSc
	 G1GWfm+XjaFTb+Nx9iapFdVZdukzgYAHT65Qk1o2awA9T4MxPkEJy5KfoYk3chIYW01+4
	 u5h/0HZmYeK6ZTtcCBt3wRMKLzS8nhEBd40yd3cnJmruPTFz91H4Swcb9dO79QxMyaobt
	 8N6FXUvrXFE1r9kMQHZZYxLUDRUCq1/Lr6BFp0wiiQHUChIwuWA7cjBudTm0VapPAGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cY4Zdp30rnyBf+8O7w9bEit8iyPlxVfUdM89VX78//0=;
	b=ZqubF3Imz+oePGRSD6AjDMMBni0IVEJtgrsydAaM1oDq+PhF2tJz/z0wwBLhTHZoSfRE
	 ctjb8z079zbzSAXTE2ChWBSkJSSARItR61e+MZaFbl2qnhzHysAe0U4/NDjq1U4tQ0xP/
	 ecntOgX5t+rtnEddEgOTYd3lho822MYBtJ9TeZHefOzFtfcl0/rLQP3XuhaS9hs0Hr8Fo
	 mIwb4IdxjvfOlBDFWiosTchHUTQdGcByHjEHAiv9NtDotX+wp3BvIkgrOEWI+4tJD5yPx
	 6JqkmUCqLpbTz0DJfjA+B1FHyVOimuXNPfgMDFGlV5D6kSRCuLCeYgRgevEK05Ebt/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0WTOc4h;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC79606EEB7
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 17:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC79606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0WTOc4h
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so856000f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 09:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071604; x=1794676404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cY4Zdp30rnyBf+8O7w9bEit8iyPlxVfUdM89VX78//0=;
        b=A0WTOc4hxF78UjqBMX0jKJ9SoJnIaCf8tYUCxzd0gb7/KecvFcpvuKip46xQJ4t29Z
         aP9Er05dxqVdW+LOx7zSYq5BGaWx7EPLFXEzGRz0SGTcuLbJN/OQEc6nlkHk7sSLJDke
         RbBdgFbfSIvZ5oWMZkf8sFMkCP5qr9l0khnPMMvsNCpqg0hzoI+JDnCrfE0aGFoPMDPA
         jTa+ycqNfLxSblc/XHbbNjjb4kW1VMNsVFVNoAxrFe3r9cCnnkL4m3Hj/S/4Q4p1aQTw
         7jVoejg8TgC5EvFj9Num51bR7eovlUycjd6lCAOFG1FEPQls1yBYRB4y/ywjKL4XEYwl
         4+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071604; x=1794676404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cY4Zdp30rnyBf+8O7w9bEit8iyPlxVfUdM89VX78//0=;
        b=cZeErrlSzmtAiLbciU45KtSbapDj41arINFh4+HDa1+4cfE0esUt27Pk/uAA0LKzUI
         YA1tLgmLvctqdPQoW275U1wqJzJjycn8w8NT2C0mKugVdXxYlaVFBXqPMW8whmSnLKAX
         N85lnxd50OOoKXgwTvYLnlF/0OnUnPT7dyxnYiq+S5rt//osw9ridPQ8lku7nD6kAgI9
         bT/AIUttcobi/4BdTYdDS9LmcXPGfg1etu3n/KfKz0Kr+GLCNon4JGsij1+qPjLfbAhh
         h4js7Kv+hk6W/6+Je+e/ghyXflTkN7+T/i+Hfaue8abKOJ9RtAMfvPoefrIbltEc1+xj
         h16A==
X-Forwarded-Encrypted: i=1; AL+hErE01eYbfCm0rNJwqa5USKRXFu+vDZ578l7Ah85nWHwKE5aLTakLO0ADmr9jo1g6f6V1b4uZZzYHbXKL4XqoNA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ZCo1RyhPl61oyfJepxnTyoshzCKArcP0Gclw+BJYF4Paaepf5
	jqZWObY/dMd4JYbMDqrWPw65NSeu6YuT+DvcU2tmRpK3MhtzGbJP0H8l
X-Gm-Gg: AYBFou0PInSX2VYA3+mkPFAKf0BhE/sB5F2WZcnOmfoVwN7OHAQhXEMPf2k64kP4VHG
	LJbrMWNH4Ek9ZxqJnxR8QGXamPA3eEYLGOCJuVO7TyW4/NW++NGvZ0mmyoWjMGioUhIIpsFjdnS
	ichSUG8vYxply2r8N6bEpd043amgQ2BdJDgnSok+ksOYeIg6DVe2jT5VuBK6juEGBzT1RaHLIHf
	5VOn/1tPmWNDowDl4gQLzAoxHefMcvafJQMwmOHSaPujOtT8TghGIyyJHCcbXl8sA44IR/lxavs
	KB0BP42v78lufYNJdy+l561lt2P6O1ROcnRWSYZXH7pCp177ohBII3lPx/REVvBkxRGxT7pu+gI
	aEDLNo44BXmzM474Z7PnudzVzBrxNfhtv1oEjP4F0qs2HB3kQ0Q9YIhA+kS+F1Jd9ugBRfBn4ts
	OuTqsTYzPFFx6s+Cqo0zNMFNZpwOEOS9OHQ7vp1YQt6WjuQ1Evx8RR4cDILt8GRnnYuPdFQGXfZ
	QPyyrEeV9WMp5DpmcWKxzZYHJX10kPguQUv1Kvj1zoaVtx9zuG8wXS4YBLve5ymFeenFbVzPU3T
	8jwGJWBKNgYHyJXcwawUX7ESYLKzYv5lKASmUENEuiyMRWGn083Xg785mJhkV2bx+OzW+a6enkA
	6JrkwJY3oaUd0TDiln3yfY3CuPRpKteyp7IYZcbTYEzHu/RwblI7J3wXtWEF7V0mquDhu4pDBEk
	yvz4HxaOeMeNyw5jHfmr9LXv78V/YTJak=
X-Received: by 2002:a05:6000:288c:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-49277218ba7mr12062781f8f.22.1794071604037;
        Sat, 07 Nov 2026 09:13:24 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:23 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 8/9] rv: Test empty PREEMPT_RT softirq worker intervals
Date: Sat,  7 Nov 2026 18:12:51 +0100
Message-Id: <20261107171252.25090-9-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
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

On PREEMPT_RT, a worker enters serving-softirq state before it checks for
pending work and leaves that state afterward. A worker with no pending
action therefore creates a valid interval that action-based tests miss.

Add KUnit-only helpers that exercise the worker boundaries directly and
force the real per-CPU ksoftirqd task through one invocation with no
pending softirqs. Preserve pending work that races with the test seam.
Verify that each path emits one context pair without an intervening softirq
action.

Keep the seam inactive outside KUnit tests. Gate its predicate and worker
branches with the existing kunit_running static key, and isolate the test
bookkeeping in a helper. Outside a KUnit run, both added worker checks take
only the disabled static-key path.

When another KUnit suite enables the global static key, check the per-CPU
phase before trying the atomic compare-exchange. Keep the compare-exchange
as the arbiter between the worker claim and timeout disarm.

Both tests attach to non-exported IRQ boundary tracepoints. Run them only
when the RV KUnit suite is built in and report them as skipped when it is a
module.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/interrupt.h                     |   7 +
 kernel/softirq.c                              | 228 ++++++++++++++++-
 kernel/trace/rv/Kconfig                       |   6 +-
 .../rv/monitors/irqstate/irqstate_kunit.c     | 239 ++++++++++++++++++
 kernel/trace/rv/rv_monitors_test.c            |   2 +
 5 files changed, 479 insertions(+), 3 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee2dd5349697d..e1a4090596609 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -599,6 +599,13 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+void softirq_kunit_run_empty_worker(void);
+bool softirq_kunit_empty_worker_active(void);
+int softirq_kunit_run_empty_ksoftirqd(struct task_struct **owner,
+				      int *owner_cpu, bool *armed);
+#endif
+
 #ifdef CONFIG_PREEMPT_RT
 extern void do_softirq_post_smp_call_flush(unsigned int was_pending);
 #else
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0d5fe265e354b..f6ed814f1f94a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -10,6 +10,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #define INSTANTIATE_EXPORTED_INTERRUPT_DISABLE
+#include <kunit/test-bug.h>
+#include <kunit/visibility.h>
+#include <linux/completion.h>
 #include <linux/export.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
@@ -609,6 +612,190 @@ asmlinkage __visible void do_softirq(void)
 
 #endif /* !CONFIG_PREEMPT_RT */
 
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+enum softirq_kunit_empty_worker_phase {
+	SOFTIRQ_KUNIT_EMPTY_IDLE,
+	SOFTIRQ_KUNIT_EMPTY_PREPARING,
+	SOFTIRQ_KUNIT_EMPTY_ARMED,
+	SOFTIRQ_KUNIT_EMPTY_RUNNING,
+	SOFTIRQ_KUNIT_EMPTY_DONE,
+};
+
+struct softirq_kunit_empty_worker {
+	atomic_t phase;
+	struct completion done;
+	u32 held_pending;
+};
+
+static DEFINE_PER_CPU(struct softirq_kunit_empty_worker,
+			      softirq_kunit_empty_workers);
+
+/*
+ * Exercise the worker boundaries without entering handle_softirqs().
+ *
+ * The caller must be in preemptible task context with interrupts enabled and
+ * no active softirq context. Like run_ksoftirqd(), this returns with local
+ * interrupts enabled.
+ */
+void softirq_kunit_run_empty_worker(void)
+{
+	ksoftirqd_run_begin();
+	/* Preserve any pending work which raced with the test seam. */
+	wakeup_softirqd();
+	ksoftirqd_run_end();
+}
+EXPORT_SYMBOL_IF_KUNIT(softirq_kunit_run_empty_worker);
+
+bool softirq_kunit_empty_worker_active(void)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	worker = raw_cpu_ptr(&softirq_kunit_empty_workers);
+	return atomic_read(&worker->phase) == SOFTIRQ_KUNIT_EMPTY_RUNNING &&
+	       current == raw_cpu_read(ksoftirqd);
+}
+EXPORT_SYMBOL_IF_KUNIT(softirq_kunit_empty_worker_active);
+
+/*
+ * Force one real ksoftirqd invocation after its smpboot predicate observes
+ * no pending work. The run itself still uses run_ksoftirqd(). The caller must
+ * hold the CPU hotplug read lock across this call so the selected CPU and its
+ * ksoftirqd remain online. The returned task pointer carries no reference.
+ */
+int softirq_kunit_run_empty_ksoftirqd(struct task_struct **owner,
+				      int *owner_cpu, bool *armed)
+{
+	struct softirq_kunit_empty_worker *worker;
+	struct task_struct *tsk;
+	unsigned long completed;
+	int this_cpu, phase, ret;
+
+	if (!owner || !owner_cpu || !armed)
+		return -EINVAL;
+	WRITE_ONCE(*owner, NULL);
+	WRITE_ONCE(*owner_cpu, -1);
+	WRITE_ONCE(*armed, false);
+
+	lockdep_assert_cpus_held();
+	this_cpu = get_cpu();
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	if (atomic_cmpxchg(&worker->phase, SOFTIRQ_KUNIT_EMPTY_IDLE,
+			   SOFTIRQ_KUNIT_EMPTY_PREPARING) !=
+	    SOFTIRQ_KUNIT_EMPTY_IDLE) {
+		put_cpu();
+		return -EBUSY;
+	}
+
+	tsk = __this_cpu_read(ksoftirqd);
+	if (!tsk) {
+		atomic_set(&worker->phase, SOFTIRQ_KUNIT_EMPTY_IDLE);
+		put_cpu();
+		return -ENODEV;
+	}
+
+	init_completion(&worker->done);
+	worker->held_pending = 0;
+	WRITE_ONCE(*owner_cpu, this_cpu);
+	WRITE_ONCE(*owner, tsk);
+	/* Publish the owner before globally registered callbacks can match it. */
+	smp_store_release(armed, true);
+	atomic_set(&worker->phase, SOFTIRQ_KUNIT_EMPTY_ARMED);
+	wake_up_process(tsk);
+	put_cpu();
+
+	completed = wait_for_completion_timeout(&worker->done, 5 * HZ);
+	if (!completed) {
+		phase = atomic_cmpxchg(&worker->phase,
+				       SOFTIRQ_KUNIT_EMPTY_ARMED,
+				       SOFTIRQ_KUNIT_EMPTY_IDLE);
+		if (phase == SOFTIRQ_KUNIT_EMPTY_ARMED) {
+			ret = -ETIMEDOUT;
+			goto out_disarm;
+		}
+
+		/*
+		 * Once the predicate has claimed the request, synchronize with
+		 * complete() before making the completion reusable. CPU hotplug
+		 * remains excluded by the caller while this helper runs. RT lock
+		 * contention can delay the worker after it claims the request, so
+		 * wait for it to finish.
+		 */
+		if (phase != SOFTIRQ_KUNIT_EMPTY_RUNNING &&
+		    phase != SOFTIRQ_KUNIT_EMPTY_DONE) {
+			ret = -EIO;
+			goto out_disarm;
+		}
+		wait_for_completion(&worker->done);
+		phase = atomic_cmpxchg(&worker->phase,
+				       SOFTIRQ_KUNIT_EMPTY_DONE,
+				       SOFTIRQ_KUNIT_EMPTY_IDLE);
+		ret = phase == SOFTIRQ_KUNIT_EMPTY_DONE ? -ETIMEDOUT : -EIO;
+		goto out_disarm;
+	}
+
+	phase = atomic_cmpxchg(&worker->phase, SOFTIRQ_KUNIT_EMPTY_DONE,
+			       SOFTIRQ_KUNIT_EMPTY_IDLE);
+	ret = phase == SOFTIRQ_KUNIT_EMPTY_DONE ? 0 : -EIO;
+
+out_disarm:
+	WRITE_ONCE(*armed, false);
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(softirq_kunit_run_empty_ksoftirqd);
+
+static bool softirq_kunit_force_empty_ksoftirqd(void)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	if (atomic_read(&worker->phase) != SOFTIRQ_KUNIT_EMPTY_ARMED ||
+	    current != __this_cpu_read(ksoftirqd))
+		return false;
+
+	return atomic_cmpxchg(&worker->phase, SOFTIRQ_KUNIT_EMPTY_ARMED,
+			      SOFTIRQ_KUNIT_EMPTY_RUNNING) ==
+			      SOFTIRQ_KUNIT_EMPTY_ARMED;
+}
+
+static bool softirq_kunit_begin_empty_ksoftirqd(void)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	if (atomic_read(&worker->phase) != SOFTIRQ_KUNIT_EMPTY_RUNNING)
+		return false;
+
+	worker->held_pending = local_softirq_pending();
+	set_softirq_pending(0);
+	return true;
+}
+
+static void softirq_kunit_restore_empty_ksoftirqd(bool active)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	if (!active)
+		return;
+
+	lockdep_assert_irqs_disabled();
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	or_softirq_pending(worker->held_pending);
+	worker->held_pending = 0;
+}
+
+static void softirq_kunit_finish_empty_ksoftirqd(bool active)
+{
+	struct softirq_kunit_empty_worker *worker;
+
+	if (!active)
+		return;
+
+	worker = this_cpu_ptr(&softirq_kunit_empty_workers);
+	atomic_set(&worker->phase, SOFTIRQ_KUNIT_EMPTY_DONE);
+	complete(&worker->done);
+}
+#endif
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -1198,11 +1385,50 @@ void __init softirq_init(void)
 
 static int ksoftirqd_should_run(unsigned int cpu)
 {
-	return local_softirq_pending();
+	unsigned int pending = local_softirq_pending();
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+	if (!pending && static_branch_unlikely(&kunit_running) &&
+	    softirq_kunit_force_empty_ksoftirqd())
+		return 1;
+#endif
+	return pending;
+}
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+static void softirq_kunit_run_ksoftirqd(unsigned int cpu)
+{
+	bool kunit_empty;
+
+	ksoftirqd_run_begin();
+	kunit_empty = softirq_kunit_begin_empty_ksoftirqd();
+	if (local_softirq_pending()) {
+		/*
+		 * We can safely run softirq on inline stack, as we are not deep
+		 * in the task stack here.
+		 */
+		handle_softirqs(true);
+		softirq_kunit_restore_empty_ksoftirqd(kunit_empty);
+		ksoftirqd_run_end();
+		softirq_kunit_finish_empty_ksoftirqd(kunit_empty);
+		cond_resched();
+	} else {
+		softirq_kunit_restore_empty_ksoftirqd(kunit_empty);
+		ksoftirqd_run_end();
+		softirq_kunit_finish_empty_ksoftirqd(kunit_empty);
+	}
 }
+#endif
 
 static void run_ksoftirqd(unsigned int cpu)
 {
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+	if (static_branch_unlikely(&kunit_running)) {
+		softirq_kunit_run_ksoftirqd(cpu);
+		return;
+	}
+#endif
+
 	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 9cdc881b8da29..2dc97edc38b1e 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -139,7 +139,9 @@ config RV_MONITORS_KUNIT_TEST
 	  These tests verify that monitors correctly detect violations by
 	  triggering fake events and validating the expected reactions.
 
-	  Enabling this may slightly increase overhead of some monitors if any
-	  unrelated KUnit test is running.
+	  Building this option, including as a module, adds test-only hooks to
+	  some monitored paths. KUnit's static key keeps the hooks dormant while
+	  no test is running. Running this or another KUnit suite can temporarily
+	  add slight overhead to those paths.
 
 	  If unsure, say N.
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
index e61c500a954a9..40fe9fd4b1fb4 100644
--- a/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
@@ -885,6 +885,37 @@ struct irqstate_inline_bh_ctx {
 	bool exit_attached;
 };
 
+struct irqstate_empty_worker_ctx {
+	struct task_struct *owner;
+	int owner_cpu;
+	unsigned int entries;
+	unsigned int exits;
+	unsigned int action_entries;
+	unsigned int action_exits;
+	unsigned int event_index;
+	bool armed;
+	bool real_worker;
+	bool inside_pair;
+	bool bad_order;
+	bool bad_boundary_context;
+	bool bad_boundary_cpu;
+	bool actions_at_exit;
+	bool entry_attached;
+	bool exit_attached;
+	bool action_entry_attached;
+	bool action_exit_attached;
+};
+
+static bool irqstate_empty_worker_matches(struct irqstate_empty_worker_ctx *empty_ctx)
+{
+	/* Pairs with owner publication in both empty-worker test paths. */
+	if (!smp_load_acquire(&empty_ctx->armed) ||
+	    current != READ_ONCE(empty_ctx->owner))
+		return false;
+
+	return !empty_ctx->real_worker || softirq_kunit_empty_worker_active();
+}
+
 static void irqstate_inline_bh_entry(void *data, bool serving,
 				     bool from_hardirq)
 {
@@ -1154,6 +1185,202 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
 		   softirq_count() == saved_softirq);
 }
 
+static void irqstate_empty_worker_entry(void *data, bool serving,
+					bool from_hardirq)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx))
+		return;
+	empty_ctx->entries++;
+	if (empty_ctx->event_index != 0 || empty_ctx->inside_pair)
+		empty_ctx->bad_order = true;
+	empty_ctx->event_index++;
+	empty_ctx->inside_pair = true;
+	if (!serving || !in_serving_softirq() || !irqs_disabled())
+		empty_ctx->bad_boundary_context = true;
+	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
+		empty_ctx->bad_boundary_cpu = true;
+}
+
+static void irqstate_empty_worker_exit(void *data, bool serving,
+				       bool from_hardirq)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx))
+		return;
+	empty_ctx->exits++;
+	if (empty_ctx->event_index != 1 || !empty_ctx->inside_pair)
+		empty_ctx->bad_order = true;
+	empty_ctx->event_index++;
+	if (!serving || !in_serving_softirq() || !irqs_disabled())
+		empty_ctx->bad_boundary_context = true;
+	if (raw_smp_processor_id() != READ_ONCE(empty_ctx->owner_cpu))
+		empty_ctx->bad_boundary_cpu = true;
+	empty_ctx->actions_at_exit = empty_ctx->action_entries ||
+				     empty_ctx->action_exits;
+	empty_ctx->inside_pair = false;
+}
+
+static void irqstate_empty_worker_action_entry(void *data, unsigned int vec_nr)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx) ||
+	    !empty_ctx->inside_pair)
+		return;
+	(void)vec_nr;
+	empty_ctx->action_entries++;
+	if (raw_smp_processor_id() != empty_ctx->owner_cpu)
+		empty_ctx->bad_boundary_cpu = true;
+}
+
+static void irqstate_empty_worker_action_exit(void *data, unsigned int vec_nr)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	if (!irqstate_empty_worker_matches(empty_ctx) ||
+	    !empty_ctx->inside_pair)
+		return;
+	(void)vec_nr;
+	empty_ctx->action_exits++;
+	if (raw_smp_processor_id() != empty_ctx->owner_cpu)
+		empty_ctx->bad_boundary_cpu = true;
+}
+
+static void irqstate_empty_worker_detach(void *data)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx = data;
+
+	WRITE_ONCE(empty_ctx->armed, false);
+	if (empty_ctx->action_exit_attached)
+		unregister_trace_softirq_exit(irqstate_empty_worker_action_exit,
+					      empty_ctx);
+	if (empty_ctx->action_entry_attached)
+		unregister_trace_softirq_entry(irqstate_empty_worker_action_entry,
+					       empty_ctx);
+	if (empty_ctx->exit_attached)
+		unregister_trace_softirq_context_exit_tp(irqstate_empty_worker_exit,
+							 empty_ctx);
+	if (empty_ctx->entry_attached)
+		unregister_trace_softirq_context_entry_tp(
+			irqstate_empty_worker_entry, empty_ctx);
+	tracepoint_synchronize_unregister();
+}
+
+static void run_irqstate_rt_empty_worker(struct kunit *test, bool real_worker)
+{
+	struct irqstate_empty_worker_ctx *empty_ctx;
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned int saved_count, saved_softirq;
+	bool order_ok, restored;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		kunit_skip(test, "Requires RT worker serving boundaries");
+		return;
+	}
+
+	prepare_test(test, &rv_irqstate_ops.mon);
+	empty_ctx = kunit_kzalloc(test, sizeof(*empty_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, empty_ctx);
+	empty_ctx->real_worker = real_worker;
+
+	ret = register_trace_softirq_context_entry_tp(
+		irqstate_empty_worker_entry, empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->entry_attached = true;
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  irqstate_empty_worker_detach,
+						  empty_ctx));
+	ret = register_trace_softirq_context_exit_tp(irqstate_empty_worker_exit,
+						     empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->exit_attached = true;
+	ret = register_trace_softirq_entry(irqstate_empty_worker_action_entry,
+					   empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->action_entry_attached = true;
+	ret = register_trace_softirq_exit(irqstate_empty_worker_action_exit,
+					  empty_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	empty_ctx->action_exit_attached = true;
+	attach_irqstate_test_probes();
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, detach_irqstate_test_probes,
+						  NULL));
+
+	KUNIT_ASSERT_TRUE(test, preemptible());
+	KUNIT_ASSERT_FALSE(test, irqs_disabled());
+	KUNIT_ASSERT_EQ(test, softirq_count(), 0U);
+	saved_count = preempt_count();
+	saved_softirq = softirq_count();
+	if (real_worker) {
+		cpus_read_lock();
+		ret = softirq_kunit_run_empty_ksoftirqd(&empty_ctx->owner,
+							&empty_ctx->owner_cpu,
+							&empty_ctx->armed);
+		cpus_read_unlock();
+	} else {
+		migrate_disable();
+		WRITE_ONCE(empty_ctx->owner_cpu, smp_processor_id());
+		WRITE_ONCE(empty_ctx->owner, current);
+		/* Publish the owner before globally registered callbacks match it. */
+		smp_store_release(&empty_ctx->armed, true);
+		softirq_kunit_run_empty_worker();
+		WRITE_ONCE(empty_ctx->armed, false);
+		migrate_enable();
+		ret = 0;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, empty_ctx->owner);
+
+	order_ok = empty_ctx->event_index == 2 && !empty_ctx->inside_pair &&
+		   !empty_ctx->bad_order;
+	restored = preempt_count() == saved_count &&
+		   softirq_count() == saved_softirq && !irqs_disabled();
+	KUNIT_EXPECT_EQ(test, empty_ctx->entries, 1U);
+	KUNIT_EXPECT_EQ(test, empty_ctx->exits, 1U);
+	KUNIT_EXPECT_EQ(test, empty_ctx->action_entries, 0U);
+	KUNIT_EXPECT_EQ(test, empty_ctx->action_exits, 0U);
+	KUNIT_EXPECT_TRUE(test, order_ok);
+	KUNIT_EXPECT_FALSE(test, empty_ctx->bad_boundary_context);
+	KUNIT_EXPECT_FALSE(test, empty_ctx->bad_boundary_cpu);
+	KUNIT_EXPECT_FALSE(test, empty_ctx->actions_at_exit);
+	KUNIT_EXPECT_EQ(test, preempt_count(), saved_count);
+	KUNIT_EXPECT_EQ(test, softirq_count(), saved_softirq);
+	KUNIT_EXPECT_FALSE(test, irqs_disabled());
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	if (real_worker)
+		kunit_info(test,
+			   "RT smpboot empty worker events=%u/%u actions=%u/%u order=%u serving=%u same_cpu=%u restored=%u\n",
+			   empty_ctx->entries, empty_ctx->exits,
+			   empty_ctx->action_entries, empty_ctx->action_exits,
+			   order_ok, !empty_ctx->bad_boundary_context,
+			   !empty_ctx->bad_boundary_cpu, restored);
+	else
+		kunit_info(test,
+			   "RT empty worker events=%u/%u actions=%u/%u order=%u serving=%u same_cpu=%u restored=%u\n",
+			   empty_ctx->entries, empty_ctx->exits,
+			   empty_ctx->action_entries, empty_ctx->action_exits,
+			   order_ok, !empty_ctx->bad_boundary_context,
+			   !empty_ctx->bad_boundary_cpu, restored);
+}
+
+/* Exercise an RT worker interval which executes no softirq action. */
+static void rv_test_irqstate_rt_empty_worker(struct kunit *test)
+{
+	run_irqstate_rt_empty_worker(test, false);
+}
+
+/* Exercise the real ksoftirqd task and its smpboot predicate. */
+static void rv_test_irqstate_rt_smpboot_empty_worker(struct kunit *test)
+{
+	run_irqstate_rt_empty_worker(test, true);
+}
+
 static int irqstate_preempt_worker(void *arg)
 {
 	struct irqstate_preempt_ctx *preempt_ctx = arg;
@@ -1389,6 +1616,16 @@ static void rv_test_irqstate_rt_inline_bh(struct kunit *test)
 	kunit_skip(test, "Requires built-in RV tests");
 }
 
+static void rv_test_irqstate_rt_empty_worker(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqstate_rt_smpboot_empty_worker(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
 static void rv_test_irqstate_preempt(struct kunit *test)
 {
 	kunit_skip(test, "Requires built-in RV tests");
@@ -1414,6 +1651,8 @@ static void rv_test_irqstate_rt_prepare_switch(struct kunit *test)
 #define rv_test_irqstate_live_toggle rv_test_stub
 #define rv_test_irqstate_irq_exit_inline rv_test_stub
 #define rv_test_irqstate_rt_inline_bh rv_test_stub
+#define rv_test_irqstate_rt_empty_worker rv_test_stub
+#define rv_test_irqstate_rt_smpboot_empty_worker rv_test_stub
 #define rv_test_irqstate_preempt rv_test_stub
 #define rv_test_irqstate_rt_prepare_irq rv_test_stub
 #define rv_test_irqstate_rt_prepare_switch rv_test_stub
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 9eb37cbd2de22..be3aaae2613a8 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -169,6 +169,8 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_irqstate_live_toggle),
 	KUNIT_CASE(rv_test_irqstate_irq_exit_inline),
 	KUNIT_CASE(rv_test_irqstate_rt_inline_bh),
+	KUNIT_CASE(rv_test_irqstate_rt_empty_worker),
+	KUNIT_CASE(rv_test_irqstate_rt_smpboot_empty_worker),
 	KUNIT_CASE(rv_test_irqstate_preempt),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_irq),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_switch),
-- 
2.39.5 (Apple Git-154)

