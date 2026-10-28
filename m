Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158339;
	b=Gdo7PsUm1bokwGRDae92fifonTXE5rEs3+4Bjc0XcD60j5lgMuJB6vxC33a7VvA6/Xny
	 TRnZp6rdYcbiD2HtNPP3px/KPay7/XImRFyqG4E1ZuXlLBe5ybZ98RhXZjeHhe2drM4nJ
	 ux2UjEco76spX7rZvb7F2st1rFjbrtzrok5PXeysZiEj1Nm5T4lc3kNZBZz0SuDbUxdB3
	 TVCdKcvSH766XEHLCGHiz+kpduMluhy5fdoh349SJtj7nQs8Fc5HsAzLyHppSX0sFP4UP
	 cwqW/KcNCWbZS7D2DtbjCKJhbzzjY3KTfPZrfv0BBsgKfSLAD3rwHUI+HuCWS0czp6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/z19Dyd36Kry4my+DL1hRK2Ik7rhLnBj6p5QTA/aWQg=;
	b=XWeIdIHcd3513yMURG4VSMZRZeJCZOjvMDbJoJ1VYPu3etQfpJbNGkNz6eYpnuXWnZfe
	 9f2uqkWiBZYp5So0H+PcQh9AvK9qE2WvOlNucnrD1YBvJS4Sbo4CXerEX0NMlr5zJVx82
	 OCKptyOhKzOFLK1qVO+HFhGPIPHfLETEGxVdc9yS/rS7XcZD4COqb9Da7a+sexbVc2gWP
	 +HZKcSOnHBoVY+9vLb5yvrL7MkUag9T+EUDAHVf80HpTH4iPDse3YZ7Yz1s8O+h1+C2lA
	 WkIKdV5WYLkc9tyax99RxZIyxIL+/mZNmwuq7vt9721DumupeQxB4vNjESnNbl4KyFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgoVKXBr;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C160A2604
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82C160A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgoVKXBr
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so244379f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158337; x=1793763137; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/z19Dyd36Kry4my+DL1hRK2Ik7rhLnBj6p5QTA/aWQg=;
        b=hgoVKXBrFGlpKWAo8gO4xjROsRa7CBzy2qdyvIjlju/5VFURTZHOPQcOXh9hivH00f
         rGvtG2/eDJ9sMhCnlFXX7byR1dGKWVzhF8hKT6LqmaZDIeZAyp499qkCafheo7OVEPyo
         x5k9AV1KMebCNTofptVmoD4jxuM068pF774JS7mOs4fej9oHxK6AzfR6oVJPMa6LJa4j
         7DX+o7D0mnKPBO4yPlgrHtfRuT3beVFeLivCbOR2BnODcvT6OWfzVVCODAmU1eEXnbbB
         iVPtL+bZyvkcgsR7v2DjWr2aFNsdITkG8/h3doKI5IJ7tt00L6MyHICCz7Toi3+KMkhL
         8yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158337; x=1793763137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/z19Dyd36Kry4my+DL1hRK2Ik7rhLnBj6p5QTA/aWQg=;
        b=VuwRwIlO4FF5eS/1A8KAK/9GTc6/PWoGAEMuaP7GgHN0g+GdaFyuv7yVZ4obkn6V59
         VpsJBUzJZT+QyX6PN1fi9sVwopw2ky2LhlfUFofclokWZxyv7VPvzJOt+RVP5lSWgHXt
         chS6b24gkQIzaSRzsfvPGcFyoLYd2MdZOFXqR+ywvf55+yRVIl45Ngwd9wlR6dYUCX3Q
         LUF8Jk7t3SkrEW4mrL7CYnRs2ze6NikoosXgKTzQ4UQGOx4tRiSOpLohC9Gwenj3C/oK
         m0k5nX4LX26IIP3z8uANB3ShG9C52y4jkZhXY0GzQiZi4IpIlCSpS+9sgT08N7ebl9pe
         4djQ==
X-Forwarded-Encrypted: i=1; AKwUvByfOsLKahYkTTKtV1vupr3i3gM18kiVPX+BBOnqVvlZyN0EVSTY656tQjhwEd0L2NwcQSyoTlKDlfoiI0P+MQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJODpZF6gzaDB/syToeDsdG0ec0L8gOZuLtJcfl6eRF3FnpuWj2
	WAX3tEQ+m4u46camMJUMJEF5ICLueGIma13RLUbCEmmu69Xf5U0ZezAn
X-Gm-Gg: AYBFou1KlUbO+tnh/tMCanbOhHf8nNqYFM+fYsh/zR0kys8Cd4oxxyBSvCsOCiJiuMr
	7236zYF00bRdCfbAXYIkRys9kBGKS1NL+KEHIKQVJhAbZ9eh8B2kgDG+MsyHM5f5ycK6adowbdA
	KcP1crO6KjOohryi4xQic21msMD7NrRc79F/OGS63Q3A3fAcnzIc0xE+/8WlDpddbvIBkVmYtRj
	ZExCGpJtQ9tbm4PHauLw/HQh/Vw4agUuTZqUvdg2r/rtJ9XSFxfuI8CGCY/zU0QJzBHJFxMjCcg
	AOdBk9KhOGdV8dY4DF//rr56BsChFR8z2mA2CvzQWigcJN6bzvtxQQxjYyOXqeURUANH8byUP+Z
	WBXC1sxZnTlUJBbwK3wHBPJaDW+r0Kt6mYCBEweIyNgBRrKIi032UAmLxX4eGNMk5rLhxDxHy9S
	LYgmvvm7+tcpx8QjfyPg4esn7chD8LJ7t0Bh/K8gCEXifLcFFSmnW92MvYPEEjERsMpFdgpehrr
	pEUnSUJW3QOe0FhDkuCbmBRpMQnL3r90czn3CV8ejFUCzieJoKC3+18c/bFqfskJv0MLjfogxhH
	oLT69XJmPFmSqv0DQwfqRQ8mU1CH0XjQfGvETq4QcxQB7oqE3hSlfYVuU81Q2OrIb+6Ml12iV6I
	s0HFviOvYQEql7RMiO855RJdGDaNk5JVNjUSQvLwFqmGkRYdwizRI67HDV+SPVAQBkDecgz10K+
	Y/aylHhK/h6F6IftruV8Ts+R0UjDIxRcvH
X-Received: by 2002:adf:e011:0:10b0:48c:4d32:ccf8 with SMTP id ffacd0b85a97d-48e5d58f11dmr2007171f8f.16.1793158337059;
        Tue, 27 Oct 2026 20:32:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:15 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/13] Documentation: entry: Describe the pre-counted hardirq lifecycle
Date: Wed, 28 Oct 2026 04:31:26 +0100
Message-Id: <20261028033127.82193-13-kmehltretter@gmail.com>
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

The entry documentation covers only the traditional irq_enter_rcu()
path. It does not explain the early-counted entry contract or the retained
and synthetic hardirq exit phases.

Document the staged raw count and lockdep entry, delayed traceable
bookkeeping and rejected-add handling, hardirq accounting,
hardirq-to-softirq classification switch, retained real IRQ exit, possible
preemption and migration, and the classification-only return tail. Also
cover late worker closure, conditional raw teardown and context-tracking
order.

Record that arm64 excludes pseudo-NMIs from this lifecycle and identify its
external noinstr inlining prerequisites.

Assisted-by: LLM
---
 Documentation/core-api/entry.rst | 89 ++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index 09942135aad18..7153cc4120192 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -193,21 +193,14 @@ Note that the invocation of the actual interrupt handler is within a
 irq_enter_rcu() and irq_exit_rcu() pair.
 
 irq_enter_rcu() updates the preemption count which makes in_hardirq()
-return true, handles NOHZ tick state and interrupt time accounting. This
-means that up to the point where irq_enter_rcu() is invoked in_hardirq()
-returns false.
+return true, handles NOHZ tick state and interrupt time accounting. On this
+entry path, in_hardirq() therefore returns false until irq_enter_rcu() is
+invoked.
 
 irq_exit_rcu() handles interrupt time accounting, handles soft interrupts if
 possible, handles the NOHZ tick state and finally undoes the preemption count
 update.
 
-In theory, the preemption count could be updated in irqentry_enter(). In
-practice, deferring this update to irq_enter_rcu() allows the preemption-count
-code to be traced, while also maintaining symmetry with irq_exit_rcu() and
-irqentry_exit(), which are described in the next paragraph. The only downside
-is that the early entry code up to irq_enter_rcu() must be aware that the
-preemption count has not yet been updated with the HARDIRQ_OFFSET state.
-
 Note that soft interrupt handlers must run in BH context rather than in hard
 interrupt context. irq_exit_rcu() therefore replaces HARDIRQ_OFFSET with
 SOFTIRQ_OFFSET in the preemption count while it handles soft interrupts and
@@ -216,6 +209,82 @@ is still attributed to the interrupt. HARDIRQ_OFFSET is removed before
 irq_exit_rcu() returns because irqentry_exit() might schedule, which requires
 that HARDIRQ_OFFSET has been removed from the preemption count.
 
+Pre-counted hardirq lifecycle
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Architectures which need hardirq state before early context-tracking or
+tracing callbacks can use the pre-counted lifecycle. It applies only to an
+ordinary hard interrupt after the architecture has distinguished it from an
+NMI-like event:
+
+  * irqentry_hardirq_enter() attempts to add HARDIRQ_OFFSET with a raw update
+    and records whether the update was applied. It establishes IRQ-disabled
+    and lockdep hardirq state before instrumentable entry work. It then runs
+    the generic entry and context-tracking path, including any required
+    transition out of an RCU extended quiescent state.
+
+  * irq_enter_rcu_preempt_counted() later finishes the staged attempt. For an
+    applied update it performs traceable debug and latency bookkeeping. For a
+    rejected update it attempts deferred reporting and skips post-add
+    bookkeeping. It also performs the deferred timer repair, NOHZ tick
+    handling and interrupt accounting from irq_enter_rcu().
+
+  * irq_exit_rcu_preempt_counted_prepare() performs interrupt accounting,
+    softirq handling and NOHZ tick handling while carrying any applied
+    hardirq count across the traceable exit path. When an applied outer
+    hardirq invokes softirqs, both the preempt-count and lockdep
+    classifications temporarily switch from hardirq to softirq and back. The
+    architecture immediately follows the preparation with
+    irqentry_hardirq_exit_finish(), which performs the conditional raw-count
+    subtraction and lockdep teardown.
+
+The staged addition carries an opaque state into its instrumentable finish and
+matching teardown. With DEBUG_PREEMPT and no separate reschedule bits, an
+already-negative count follows the legacy DEBUG_LOCKS_WARN_ON() rule. During
+an oops the warning condition is bypassed and the addition is applied.
+Otherwise the attempt is rejected and leaves the count unchanged. Its finish
+attempts deferred reporting, which an intervening oops can suppress. A
+rejected token always skips post-add bookkeeping and the matching subtraction,
+independently of whether reporting produced a warning.
+
+The real interrupt is complete after that teardown. Return-to-kernel
+preemption can schedule and migrate the task before the architecture-specific
+tail runs, so the current preemption count cannot identify the original entry
+class. irqentry_state_t retains that provenance instead.
+
+For an ordinary hardirq returning to kernel mode,
+irqentry_hardirq_tail_enter() makes a fresh staged attempt to add
+HARDIRQ_OFFSET and establishes lockdep hardirq nesting after the preemption
+decision. This synthetic classification covers traceable architecture tail
+work, deferred timer rearming, IRQ-on preparation and context-tracking
+preparation. It does not repeat interrupt accounting, RCU or tick entry.
+IRQ-on preparation requires this synthetic lockdep nesting to remain present.
+An interrupted outer hardirq can contribute additional nesting.
+
+irqentry_hardirq_tail_exit() performs the final traceable teardown preparation
+and then conditionally removes any applied raw synthetic count. For an applied
+staged count at outermost hardirq depth, both retained exit points recheck
+regular softirq work and forced-thread timer work raised by late callbacks and
+wake the corresponding workers before ending hardirq state. If the interrupted
+context was in an RCU extended quiescent state,
+ct_irq_exit_prepare() runs before the raw tail teardown and
+ct_irq_exit_finish() completes the transition afterwards.
+
+On arm64 the ordinary lifecycle is selected only after the pseudo-NMI
+decision. Pseudo-NMIs continue to use irqentry_nmi_enter() and
+irqentry_nmi_exit(). All raw transitions are in noinstr paths, so
+preempt_count(), the raw preempt-count update helpers and
+__kern_my_cpu_offset() must remain inline. The arm64 conversion includes the
+first requirement and depends on the `arm64 raw preempt-count inlining
+prerequisite`_ and `arm64 per-CPU offset inlining prerequisite`_ for the
+others.
+
+.. _`arm64 raw preempt-count inlining prerequisite`:
+   https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
+
+.. _`arm64 per-CPU offset inlining prerequisite`:
+   https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org
+
 Even though interrupt handlers are expected to run with local interrupts
 disabled, interrupt nesting is common from an entry/exit perspective. For
 example, softirq handling happens within an irqentry_{enter,exit}() block with
-- 
2.39.5 (Apple Git-154)

