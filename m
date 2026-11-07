Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071604;
	b=cOy5rI8iwaotTtc6Qg+IdPwLt0AewEarTwdn0vYcKZZcoj0KtIBQiUfzLBuqYZVCdvpZ
	 o4aXjLTCWDYDIL6wPouqeRGjN77FBFLNnEMbQvE/vCbLI/keoQojgn/BkMywnzVW/jkb0
	 Sxh9qFY/1sASz+CTkn3Zhaxsrg9n4ajF/o04HN6sx9Jpe7DmEDfiYiDbKm4/muPEozlHT
	 iiKs7anygKVlTiTlsspLUB7lZ/Ef/qGnIaMR6xNhDGH1YPSd6QdYDGuj9vtcNYQc9FQYN
	 FUrK6jN5/5ko/xKuDJfGW//lNl/7oy/XDVwOmwD5gje+tEkdf4ENgbmA9zmtZuK9WCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HNh+mOggAomARf0sIyQqvL0qASzow+2PaiRF3uG93gg=;
	b=PxfQYfxzxVtsP5hP/D5RB95mIJCS/5fSO0GlkI2SXJjNhYSkA78rvk6RcpqargmvoKYU
	 5ywPF7RgHtV8WXG0WpPXx5bSomJgp05OEUFylg82Aj8fpxRazxKRBq8PSO1TVayf9Fpy0
	 BK7Oei6cnJT8O/cA6dEERLLvF0S4wPrvgOWoozsqjowkif+g3VqACCKj559OEdCFZflKn
	 UBlZ2UI9UqNHtAvMIMt5LOXIgdqCkI/Q+feDT4iatUq75TKX2ztgmoDtr7DrJzaQJumbM
	 9NYwa8R6Vkc2J6jTm0PQsmO9i+wz53hzODQwTE4ukVMAQ3owxs6KSmhSn1zHK/pPFpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bA0/Fv66";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19E6082BEA
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 17:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C19E6082BEA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bA0/Fv66
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so11235595e9.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071602; x=1794676402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNh+mOggAomARf0sIyQqvL0qASzow+2PaiRF3uG93gg=;
        b=bA0/Fv66frmq1IiF8dZEnBlIfVmqk83LlZvaPWE3cs1DWtBLMX1JpQyKGHutghmPMv
         LOHUkovl2OQVfT5TOFpk0UWDzmzmEMoc6ih8vrAnqtvnvlPedcnKDHNwY7ILPfBo3LlB
         KtfRl+iE7oO0dSc9kiT3skk4IXYjXDFwWWM1JwQmbwRK/MkuYmdyUcw0M8YdHOJv0o8b
         mIdhRR7jVgOdTFTw8eRRuHJReWKvLQmztKl3LuIMo4hH1XsKOL7eMspKKmqJ207VRo3a
         GTxr3UJn0Uu3R1Tbw4pbhRmH7WDblZa9uo3L3e2e7q3iuDvkiWnPBCJ9Yi0TgdG4kx3D
         6srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071602; x=1794676402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNh+mOggAomARf0sIyQqvL0qASzow+2PaiRF3uG93gg=;
        b=fX+2+IjwGbgfFav5mAlr+xP15LH133oAQ/jGMN8wOR6LEbzzChevOaHb8WcMdyLR7Q
         zCC9auCHfM13N8y9jKuP0fbIabMPz6XrVog6IRpLOoOf5BnpmfgGt2pNCzOa3ob/oIKE
         Exyg26garhN/iworl77X1BzY3GvlvW1euFYUQj3g0MP/YKrQ4qaHVys8AhvXFv8CDvRj
         AZ46K/eJsaE3szhzOa2HS9hUTSDY6Uhe7JXSdGV6PyJkVJqRhD3bpfxIsaIW5kHUf+Q7
         wAqnv6Q4MRLhUHb7M0R4zhuzI9Oau/6H7LeUFWiqUAej/HaN6mih9LXslBKUcJBgqLFS
         UbUA==
X-Forwarded-Encrypted: i=1; AKwUvBxHRS6hImhQOufrcY8DfAO2nlt5mqrtvSNjGoeWlGLxWlqIqPL2o+hGi5Myr4zpx3bluC6Yqq0MierBVaV59w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/z6G7aukhyYczrokqS6LXIqGlEL+uRTGlZc2dUdQkjggXioMVz
	cZVvqgamhBUBYbOzhOs0PT51TVp1Iu1n5rZrfqqaxwxpWPick4KBQBh5
X-Gm-Gg: AYBFou34dqJh/gB5rC5UC8tYVyGNKpZL0jnTe0FbuaGq8suwINnmajbck6sVRF2prEV
	x6SahuSGUxcGZYqxv+iREbmqEvsd2A2PySTTq8gtgDU7aGCIvt/Bwqlv+eVtj1xQL/jhpp9cx9/
	wUC+K4a+0PmgCBxLp6gqd3cXUlYfIpflSeSjoRc4/o+T+Rnlop6VXwkBhCduPaYn2d+Px0cEE9Z
	LxDxB0cpVWDOMK3bktlw3sS2TRFAiZ3WMIU0kADrNwd0VVtjBAj8Ek7MTHkaYxjvXLbaoNaAVpC
	ttNY2jQ9gM5VRFVu1kKJBxa0mgixCTHjb8Uulc5syPVPUo4IkdF9ftlzOKVGGdTNeimEjkSwDs1
	urOl28JqE9b2Re0fiwy1Eo7tzVXCj9WnsIxpSfH4uArHrGrnfORS/ucg8zysiK/wc1D6T2vF0Qa
	pDNVkjlkMlAYQFxPLnruqta7mQsDOzK0UnCcfiEGiYqFGLA2sT5L4iZBeP88h2+hcZx6VMGaqF6
	wwLSc3dNTSJz2cyD+KP4O+3BTq0ZWIxWMbJo/31sVCLSMPDMzbIRGe9O5Q4ZQGfH3uVDo9pfvoe
	2bS9Fbq8r8d/Sl5PWXjtamUbquvYj4f4+htJN/724rDtVvJF/dEDBNm1+50ZAyi7yVV3hTlJE33
	R52qpR+shtYSyjWBAviEykwFxZSgeT4+KjqwT7iWxvk8uQ5HV5Hgp+L/9SK5sOBLTpMCPRruHsp
	sweHg97arCXQ0PtdX0+5ZcBectD64pnTY=
X-Received: by 2002:a05:600c:4e8e:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4b6db4a5dc5mr105404535e9.1.1794071601430;
        Sat, 07 Nov 2026 09:13:21 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:20 -0800 (PST)
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
Subject: [RFC PATCH v2 7/9] rv: Add KUnit coverage for IRQ-exit scheduling
Date: Sat,  7 Nov 2026 18:12:50 +0100
Message-Id: <20261107171252.25090-8-kmehltretter@gmail.com>
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

Add KUnit coverage for the irqexit generated state table, invalid
transitions, and enable-time synchronization. Test live
preempt_schedule_irq() invocations without a switch, across a task switch,
and across CPU migration when another CPU is available. The live cases
require the built-in suite because they invoke a non-exported helper.

KUnit failure reporting may allocate with GFP_KERNEL. Snapshot reaction
counts inside synthetic IRQ-disabled and hardirq intervals, then evaluate
expectations after normal task context is restored. This avoids secondary
atomic-sleep or lockdep diagnostics when a monitor check fails.

The live tests invoke the generic helper directly. They do not exercise
an architecture-specific physical interrupt-return path.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/trace/rv/monitors/irqexit/irqexit.c    |  13 +
 .../trace/rv/monitors/irqexit/irqexit_kunit.c | 540 ++++++++++++++++++
 .../trace/rv/monitors/irqexit/irqexit_kunit.h |  21 +
 kernel/trace/rv/rv_monitors_test.c            |  13 +
 4 files changed, 587 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h

diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.c b/kernel/trace/rv/monitors/irqexit/irqexit.c
index f09a6ce5c463a..ff85504e9cead 100644
--- a/kernel/trace/rv/monitors/irqexit/irqexit.c
+++ b/kernel/trace/rv/monitors/irqexit/irqexit.c
@@ -157,3 +157,16 @@ module_exit(unregister_irqexit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
 MODULE_DESCRIPTION("irqexit: verify IRQ-exit scheduling ownership");
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+#include <kunit/visibility.h>
+#include "irqexit_kunit.h"
+
+const struct rv_irqexit_ops rv_irqexit_ops = {
+	.mon = RV_MON_OPS_INIT(),
+	.handle_resched_entry = handle_resched_entry,
+	.handle_resched_exit = handle_resched_exit,
+	.handle_sched_switch = handle_sched_switch,
+};
+EXPORT_SYMBOL_IF_KUNIT(rv_irqexit_ops);
+#endif
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
new file mode 100644
index 0000000000000..d5d6b8eefbbf6
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/completion.h>
+#include <linux/cpu.h>
+#include <linux/hardirq.h>
+#include <linux/irqflags.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/rv.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <rv/kunit.h>
+#include <rv_trace.h>
+#include <trace/events/sched.h>
+
+#include "irqexit_kunit.h"
+
+#if IS_REACHABLE(CONFIG_RV_MON_IRQEXIT)
+
+static void irqexit_test_switch(struct task_struct *prev, struct task_struct *next)
+{
+	rv_mock_current(prev);
+	rv_irqexit_ops.handle_sched_switch(NULL, true, prev, next, TASK_RUNNING);
+	rv_mock_current(next);
+}
+
+static void rv_test_irqexit(struct kunit *test)
+{
+	struct task_struct *owner = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long flags;
+	int observed;
+
+	owner->pid = 101;
+	other->pid = 102;
+	prepare_test(test, &rv_irqexit_ops.mon);
+	rv_mock_current(owner);
+
+	local_irq_save(flags);
+	/* The scheduling loop may return without an actual task switch. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+
+	/* A different task's IRQ-exit loop cannot complete owner's loop. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_entry(NULL, other);
+	__irq_enter_raw();
+	__irq_exit_raw();
+	rv_irqexit_ops.handle_resched_exit(NULL, other);
+	irqexit_test_switch(other, owner);
+
+	/* Both tasks can have suspended invocations at the same time. */
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_entry(NULL, other);
+	irqexit_test_switch(other, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_exit(NULL, other);
+	observed = READ_ONCE(ctx->reactions);
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed, 0);
+}
+
+static void rv_test_irqexit_invalid(struct kunit *test)
+{
+	struct task_struct *owner = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long flags;
+	int observed[14];
+	unsigned int i = 0;
+
+	owner->pid = 101;
+	other->pid = 102;
+	prepare_test(test, &rv_irqexit_ops.mon);
+	rv_mock_current(owner);
+
+	KUNIT_ASSERT_FALSE(test, irqs_disabled());
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqexit_ops.handle_resched_entry(NULL, owner);
+
+	local_irq_save(flags);
+	/* Scheduling must not start before the hardirq count is removed. */
+	__irq_enter_raw();
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+
+	/* A return with hardirq state still active is invalid as well. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	__irq_enter_raw();
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	__irq_exit_raw();
+
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	/* The first exit synchronizes; the second unmatched exit must fail. */
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	/* The state permits exit, but its task identity must still agree. */
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	rv_mock_current(other);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	/* Matching current is insufficient if the invocation is suspended. */
+	rv_mock_current(owner);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	irqexit_test_switch(owner, other);
+	rv_mock_current(owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed[i++] = READ_ONCE(ctx->reactions);
+
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	local_irq_restore(flags);
+	for (i = 0; i < ARRAY_SIZE(observed); i += 2) {
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed[i], 0);
+		RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed[i + 1], 1);
+	}
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqexit_ops.handle_resched_exit(NULL, owner);
+
+	/* Even an unsynchronized bad return must not be silently skipped. */
+	rv_mock_current(other);
+	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
+		rv_irqexit_ops.handle_resched_exit(NULL, owner);
+}
+
+static void rv_test_irqexit_sync(struct kunit *test)
+{
+	struct task_struct *owner = rv_kunit_alloc_mock_task(test);
+	struct task_struct *other = rv_kunit_alloc_mock_task(test);
+	struct rv_kunit_ctx *ctx = test->priv;
+	unsigned long flags;
+	int observed;
+
+	owner->pid = 101;
+	other->pid = 102;
+	prepare_test(test, &rv_irqexit_ops.mon);
+	rv_mock_current(owner);
+
+	local_irq_save(flags);
+	/* Switch events alone do not synchronize an already active loop. */
+	irqexit_test_switch(owner, other);
+	irqexit_test_switch(other, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+
+	/* Model disable/reset/re-enable while that invocation is suspended. */
+	rv_irqexit_ops.mon.rv_this->enabled = 0;
+	irqexit_test_switch(owner, other);
+	rv_irqexit_ops.handle_resched_entry(NULL, other);
+	rv_irqexit_ops.handle_resched_exit(NULL, other);
+	rv_irqexit_ops.mon.task_reset(owner);
+	rv_irqexit_ops.mon.task_reset(other);
+	rv_irqexit_ops.mon.rv_this->enabled = 1;
+	irqexit_test_switch(other, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	rv_irqexit_ops.handle_resched_entry(NULL, owner);
+	rv_irqexit_ops.handle_resched_exit(NULL, owner);
+	observed = READ_ONCE(ctx->reactions);
+	local_irq_restore(flags);
+	RV_KUNIT_EXPECT_OBSERVED(test, ctx, observed, 0);
+}
+
+#ifndef MODULE
+struct irqexit_live_ctx {
+	struct task_struct *owner;
+	struct task_struct *worker;
+	const char *skip_reason;
+	struct completion worker_done;
+	unsigned int entries;
+	unsigned int exits;
+	unsigned int switches_out;
+	unsigned int switches_in;
+	unsigned int entry_cpu;
+	unsigned int exit_cpu;
+	unsigned int switch_out_cpu;
+	unsigned int switch_in_cpu;
+	unsigned int target_cpu;
+	unsigned int raw_entries;
+	unsigned int raw_exits;
+	unsigned int bad_raw_context;
+	int affinity_result;
+	cpumask_t saved_mask;
+	cpumask_t test_mask;
+	bool migrate;
+	bool affinity_changed;
+	bool observer_attached;
+	bool raw_entry_attached;
+	bool raw_exit_attached;
+	bool hotplug_disabled;
+};
+
+/* Parent fixtures run in the suite runner, which owns rv_interface_lock. */
+static int irqexit_live_fixture_init(struct kunit *test)
+{
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+	struct irqexit_live_ctx *live;
+	int ret;
+
+	if (mon->enabled)
+		return -EBUSY;
+	live = kunit_kzalloc(test, sizeof(*live), GFP_KERNEL);
+	if (!live)
+		return -ENOMEM;
+
+	/* Keep the online mask stable without nesting tracepoint registration. */
+	cpu_hotplug_disable();
+	live->hotplug_disabled = true;
+	ret = mon->enable();
+	if (ret) {
+		cpu_hotplug_enable();
+		live->hotplug_disabled = false;
+		kunit_kfree(test, live);
+		return ret;
+	}
+	kunit_register_params_array(test, live, 1, NULL);
+	return 0;
+}
+
+static void irqexit_live_fixture_exit(struct kunit *test)
+{
+	struct irqexit_live_ctx *live = (void *)test->params_array.params;
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+
+	mon->enabled = 0;
+	mon->disable();
+	if (live->hotplug_disabled) {
+		cpu_hotplug_enable();
+		live->hotplug_disabled = false;
+	}
+	/* Retain the child's explicit skip reason on the parent case. */
+	if (live->skip_reason)
+		kunit_mark_skipped(test, "%s", live->skip_reason);
+}
+
+static int irqexit_live_worker(void *data)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (live->migrate)
+		live->affinity_result =
+			set_cpus_allowed_ptr(live->owner, cpumask_of(live->target_cpu));
+	complete(&live->worker_done);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!kthread_should_stop())
+			schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static void irqexit_observe_event(void *data, int id, char *state,
+				  char *event, char *next_state, bool final_state)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (id != live->owner->pid)
+		return;
+	if (!strcmp(event, "resched_entry")) {
+		live->entry_cpu = raw_smp_processor_id();
+		live->entries++;
+	} else if (!strcmp(event, "resched_exit")) {
+		live->exit_cpu = raw_smp_processor_id();
+		live->exits++;
+	} else if (!strcmp(event, "switch_out") && !strcmp(state, "rescheduling")) {
+		if (!live->switches_out)
+			live->switch_out_cpu = raw_smp_processor_id();
+		live->switches_out++;
+	} else if (!strcmp(event, "switch_in") && !strcmp(state, "suspended")) {
+		if (!live->switches_in)
+			live->switch_in_cpu = raw_smp_processor_id();
+		live->switches_in++;
+	}
+}
+
+static void irqexit_observe_entry(void *data, struct task_struct *owner,
+				  unsigned long pc, bool irq_off)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (owner != live->owner)
+		return;
+	live->raw_entries++;
+	if (pc || !irq_off)
+		live->bad_raw_context++;
+}
+
+static void irqexit_observe_exit(void *data, struct task_struct *owner,
+				 unsigned long pc, bool irq_off)
+{
+	struct irqexit_live_ctx *live = data;
+
+	if (owner != live->owner)
+		return;
+	live->raw_exits++;
+	if (pc || !irq_off)
+		live->bad_raw_context++;
+}
+
+static int irqexit_observe_boundaries(struct irqexit_live_ctx *live)
+{
+	int ret;
+
+	ret = register_trace_sched_irq_preempt_entry_tp(irqexit_observe_entry, live);
+	if (ret)
+		return ret;
+	live->raw_entry_attached = true;
+	ret = register_trace_sched_irq_preempt_exit_tp(irqexit_observe_exit, live);
+	if (!ret)
+		live->raw_exit_attached = true;
+	return ret;
+}
+
+static void irqexit_live_cleanup(void *data)
+{
+	struct irqexit_live_ctx *live = data;
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+
+	mon->enabled = 0;
+	if (live->observer_attached)
+		unregister_trace_event_irqexit(irqexit_observe_event, live);
+	if (live->raw_entry_attached)
+		unregister_trace_sched_irq_preempt_entry_tp(irqexit_observe_entry, live);
+	if (live->raw_exit_attached)
+		unregister_trace_sched_irq_preempt_exit_tp(irqexit_observe_exit, live);
+	tracepoint_synchronize_unregister();
+	if (live->worker)
+		kthread_stop(live->worker);
+	if (live->affinity_changed && !(READ_ONCE(live->owner->flags) & PF_EXITING))
+		KUNIT_EXPECT_EQ(kunit_get_current_test(),
+				set_cpus_allowed_ptr(live->owner, &live->saved_mask), 0);
+	put_task_struct(live->owner);
+	live->owner = NULL;
+
+	RV_KUNIT_EXPECT_NO_REACTION(kunit_get_current_test(), active_ctx);
+	mon->react = mon->reactor ? mon->reactor->react : NULL;
+	active_ctx = NULL;
+	rv_mock_current(NULL);
+}
+
+static void rv_test_irqexit_live(struct kunit *test)
+{
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct irqexit_live_ctx *live = (void *)test->param_value;
+	struct task_struct *worker;
+	unsigned int entries, exits, switches_out, switches_in;
+	unsigned int first_entries, first_switches;
+	unsigned long flags;
+	bool worker_done;
+	int ret;
+
+	KUNIT_ASSERT_FALSE(test, mon->enabled);
+	live->owner = current;
+	get_task_struct(live->owner);
+	init_completion(&live->worker_done);
+
+	active_ctx = ctx;
+	mon->react = rv_kunit_mock_react;
+	rv_mock_current(NULL);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqexit_live_cleanup, live));
+	worker = kthread_create(irqexit_live_worker, live, "rv-irqexit-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
+	live->worker = worker;
+	ret = register_trace_event_irqexit(irqexit_observe_event, live);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	live->observer_attached = true;
+	ret = irqexit_observe_boundaries(live);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	mon->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, preempt_count(), 0);
+	/* The worker must run on this CPU inside the explicit scheduling loop. */
+	scoped_guard(migrate) {
+		kthread_bind(worker, smp_processor_id());
+		sched_set_fifo(worker);
+		local_irq_save(flags);
+		preempt_schedule_irq();
+		first_entries = live->entries;
+		first_switches = live->switches_out;
+		wake_up_process(worker);
+		preempt_schedule_irq();
+		entries = live->entries;
+		exits = live->exits;
+		switches_out = live->switches_out;
+		switches_in = live->switches_in;
+		worker_done = completion_done(&live->worker_done);
+		local_irq_restore(flags);
+	}
+
+	/* Accepted model events prove that the real boundary probes ran. */
+	KUNIT_EXPECT_GT(test, entries, 0);
+	KUNIT_EXPECT_GT(test, first_entries, 0);
+	KUNIT_EXPECT_GT(test, entries, first_entries);
+	KUNIT_EXPECT_EQ(test, entries, exits);
+	KUNIT_EXPECT_EQ(test, switches_out, switches_in);
+	KUNIT_EXPECT_GT(test, switches_out, first_switches);
+	KUNIT_EXPECT_TRUE(test, worker_done);
+	KUNIT_EXPECT_GE(test, live->raw_entries, 2U);
+	KUNIT_EXPECT_GE(test, live->raw_exits, 2U);
+	KUNIT_EXPECT_EQ(test, live->bad_raw_context, 0U);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test, "live IRQ-exit entries=%u exits=%u switches=%u\n",
+		   entries, exits, switches_out);
+	mon->enabled = 0;
+}
+
+static void rv_test_irqexit_migrate(struct kunit *test)
+{
+	struct rv_monitor *mon = rv_irqexit_ops.mon.rv_this;
+	struct rv_kunit_ctx *ctx = test->priv;
+	struct irqexit_live_ctx *live = (void *)test->param_value;
+	struct task_struct *worker;
+	unsigned int source_cpu, resumed_cpu;
+	unsigned long flags;
+	bool affinity_restored;
+	int restore_result;
+
+	KUNIT_ASSERT_FALSE(test, mon->enabled);
+	live->owner = current;
+	get_task_struct(live->owner);
+	init_completion(&live->worker_done);
+	active_ctx = ctx;
+	mon->react = rv_kunit_mock_react;
+	rv_mock_current(NULL);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, irqexit_live_cleanup, live));
+	if (num_online_cpus() < 2) {
+		live->skip_reason = "Requires two online CPUs";
+		kunit_skip(test, "%s", live->skip_reason);
+		return;
+	}
+	cpumask_copy(&live->saved_mask, current->cpus_ptr);
+	cpumask_and(&live->test_mask, &live->saved_mask, cpu_online_mask);
+	if (cpumask_weight(&live->test_mask) < 2) {
+		live->skip_reason = "Requires two allowed online CPUs";
+		kunit_skip(test, "%s", live->skip_reason);
+		return;
+	}
+	source_cpu = cpumask_first(&live->test_mask);
+	live->target_cpu = cpumask_any_but(&live->test_mask, source_cpu);
+	KUNIT_ASSERT_EQ(test, set_cpus_allowed_ptr(current, cpumask_of(source_cpu)), 0);
+	live->affinity_changed = true;
+	live->migrate = true;
+	worker = kthread_create(irqexit_live_worker, live, "rv-irqexit-mig");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, worker);
+	live->worker = worker;
+	kthread_bind(worker, source_cpu);
+	sched_set_fifo(worker);
+	KUNIT_ASSERT_EQ(test, 0,
+			register_trace_event_irqexit(irqexit_observe_event, live));
+	live->observer_attached = true;
+	KUNIT_ASSERT_EQ(test, irqexit_observe_boundaries(live), 0);
+	mon->enabled = 1;
+
+	KUNIT_ASSERT_EQ(test, preempt_count(), 0);
+	local_irq_save(flags);
+	live->entries = 0;
+	live->exits = 0;
+	live->switches_out = 0;
+	live->switches_in = 0;
+	/*
+	 * The FIFO worker runs only after this task switches out inside the
+	 * real helper. It moves the queued, non-running owner to another CPU.
+	 * Do not migration-disable the owner: migration is the property tested.
+	 */
+	wake_up_process(worker);
+	preempt_schedule_irq();
+	resumed_cpu = raw_smp_processor_id();
+	mon->enabled = 0;
+	local_irq_restore(flags);
+	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&live->worker_done, 5 * HZ), 0UL);
+	KUNIT_EXPECT_EQ(test, live->affinity_result, 0);
+	KUNIT_EXPECT_EQ(test, live->entries, 1U);
+	KUNIT_EXPECT_EQ(test, live->exits, 1U);
+	KUNIT_EXPECT_GT(test, live->switches_out, 0U);
+	KUNIT_EXPECT_EQ(test, live->switches_out, live->switches_in);
+	KUNIT_EXPECT_EQ(test, live->entry_cpu, source_cpu);
+	KUNIT_EXPECT_EQ(test, live->switch_out_cpu, source_cpu);
+	KUNIT_EXPECT_EQ(test, live->switch_in_cpu, live->target_cpu);
+	KUNIT_EXPECT_EQ(test, live->exit_cpu, live->target_cpu);
+	/* Check actual resumed execution independently of the RV observer. */
+	KUNIT_EXPECT_EQ(test, resumed_cpu, live->target_cpu);
+	KUNIT_EXPECT_GT(test, live->raw_entries, 0U);
+	KUNIT_EXPECT_GT(test, live->raw_exits, 0U);
+	KUNIT_EXPECT_EQ(test, live->bad_raw_context, 0U);
+	restore_result = set_cpus_allowed_ptr(current, &live->saved_mask);
+	KUNIT_EXPECT_EQ(test, restore_result, 0);
+	affinity_restored = !restore_result &&
+		cpumask_equal(current->cpus_ptr, &live->saved_mask);
+	KUNIT_EXPECT_TRUE(test, affinity_restored);
+	if (affinity_restored)
+		live->affinity_changed = false;
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+	kunit_info(test, "live IRQ-exit migration cpu=%u->%u actual=%u entries=%u exits=%u switches=%u\n",
+		   live->entry_cpu, live->exit_cpu, resumed_cpu, live->entries, live->exits,
+		   live->switches_out);
+	kunit_info(test, "live IRQ-exit affinity restored=%u\n", affinity_restored);
+}
+#else
+static void rv_test_irqexit_live(struct kunit *test)
+{
+	/* preempt_schedule_irq() is deliberately not exported to modules. */
+	kunit_skip(test, "Requires built-in RV tests");
+}
+
+static void rv_test_irqexit_migrate(struct kunit *test)
+{
+	kunit_skip(test, "Requires built-in RV tests");
+}
+#endif
+
+#else
+#define rv_test_irqexit rv_test_stub
+#define rv_test_irqexit_invalid rv_test_stub
+#define rv_test_irqexit_sync rv_test_stub
+#define rv_test_irqexit_live rv_test_stub
+#define rv_test_irqexit_migrate rv_test_stub
+#endif
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit_kunit.h b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
new file mode 100644
index 0000000000000..b475388455c2a
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __IRQEXIT_KUNIT_H
+#define __IRQEXIT_KUNIT_H
+
+#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
+
+#include <linux/rv.h>
+#include <rv/kunit.h>
+
+extern const struct rv_irqexit_ops {
+	struct rv_kunit_mon mon;
+	void (*handle_resched_entry)(void *data, struct task_struct *owner);
+	void (*handle_resched_exit)(void *data, struct task_struct *owner);
+	void (*handle_sched_switch)(void *data, bool preempt,
+				    struct task_struct *prev,
+				    struct task_struct *next,
+				    unsigned int prev_state);
+} rv_irqexit_ops;
+#endif
+
+#endif /* __IRQEXIT_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 4fb611a9f8b85..9eb37cbd2de22 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -150,6 +150,7 @@ static void rv_test_dummy(struct kunit *test)
 #include "monitors/sssw/sssw_kunit.c"
 #include "monitors/sts/sts_kunit.c"
 #include "monitors/irqstate/irqstate_kunit.c"
+#include "monitors/irqexit/irqexit_kunit.c"
 #include "monitors/opid/opid_kunit.c"
 #include "monitors/nomiss/nomiss_kunit.c"
 #include "monitors/pagefault/pagefault_kunit.c"
@@ -171,6 +172,18 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_irqstate_preempt),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_irq),
 	KUNIT_CASE(rv_test_irqstate_rt_prepare_switch),
+	KUNIT_CASE(rv_test_irqexit),
+	KUNIT_CASE(rv_test_irqexit_invalid),
+	KUNIT_CASE(rv_test_irqexit_sync),
+#if IS_REACHABLE(CONFIG_RV_MON_IRQEXIT) && !defined(MODULE)
+	KUNIT_CASE_PARAM_WITH_INIT(rv_test_irqexit_live, kunit_array_gen_params,
+				   irqexit_live_fixture_init, irqexit_live_fixture_exit),
+	KUNIT_CASE_PARAM_WITH_INIT(rv_test_irqexit_migrate, kunit_array_gen_params,
+				   irqexit_live_fixture_init, irqexit_live_fixture_exit),
+#else
+	KUNIT_CASE(rv_test_irqexit_live),
+	KUNIT_CASE(rv_test_irqexit_migrate),
+#endif
 	KUNIT_CASE(rv_test_opid),
 	KUNIT_CASE(rv_test_nomiss),
 	KUNIT_CASE(rv_test_pagefault),
-- 
2.39.5 (Apple Git-154)

