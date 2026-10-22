Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646270;
	b=Q5lLqDaUftuSHzieGOihHltF6cRWTWuwiNtxyemMnONo7WsWFTUBN1YygGQqRIsP9OAn
	 mfDkkFoptW6Twp0PGa2GLGEhHzkIDbkzWtE+j9fPyC+j4Oje8x6hEh0XB0B1iNu61mdEe
	 CCH5k60ch+w/J4auv7ruStCE/XpKbKEBSG0XcOA483/zyjz0BjW7cFzZYME8Y6NkuMSnh
	 vFGoBa5ToJFki3NIwGkSy8KcuYPFy+Yw2a7FJsYu9XvKBNYMfiaOTaeAJGikTnVnzuVR9
	 gyG0f/UwR/SgMA3Y+p/t9DSO7DfisBA7PEuxhP9BqjIgFZbkpfrx+Q+PqCTxJ3TtiRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B5VpfkiruZaKFMNAXJdCzQrQfGZBIQ5E4hTuwKkgO4o=;
	b=3kwW1HC+fm2yUnbzNUyW0FZwcUpooJpj+Ml1eqKgRXH9gfr84uplS6AF6G7fRNTS4WVX
	 PHJrxiF7SJYsiD5+5WlHeeraVvd8KsUSq94xyD0hak6iRt5B//DFKo/97apeM7oaY+scf
	 VYEyF8v2hlF1J6P05fGiY/PS80l2i0MUJ1TgED2faOnpLAQIJTuhlUA8BY2M5hEGn4xC7
	 5gPdBTCyt3KXxFS9Z1ie7MZj20ci73wfrkefn/dTFQi6JcYmvc0XmzBiW7O1nIveVEKc9
	 ex0FOEYEGiytpLOQA/FmA0cl6adWGX6YeI60NBHIaHM5TMYm71U4PxV4vsaSWceSmmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CHGVUuUh;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B4606A31E
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD5B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CHGVUuUh
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso15956995e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646268; x=1793251068; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5VpfkiruZaKFMNAXJdCzQrQfGZBIQ5E4hTuwKkgO4o=;
        b=CHGVUuUh+6BQBiSkNntXh1S7ABBsDA/V7I/tIVryrfMhBm1e+i51BA4Gc/CtHE4+QG
         IjlY64bAAYm8f0dY7Gp0MzF5ZRjNzHK1nw57Eq7IZMtF0kdhto4YedY8p0mQS1aSNT1J
         5HnDe/gdpQUQNPKs6+k766M5A5NUruhj5cz5Kuf79x6uP0lsDOcyb805v9EAzPug0Knv
         Bs7IUvthGN2sfnnInytMrapj2NzhH6/43PFb+b4W8Mhc51+JMtdG6xB9K3nbEBiQV8ft
         UWnW/adGGH9gC6LXt3hclw7A9BuM0muwhcVGETHuyx2t089s6iS/P4CyAYHtMje3mo6V
         F2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646268; x=1793251068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5VpfkiruZaKFMNAXJdCzQrQfGZBIQ5E4hTuwKkgO4o=;
        b=EkNeEpyXxoch/L0xrI7FYOCTdVFvzH/KaTbZLH7G8brDJK2/Oq9tVhobzcxLc8YVDu
         qefT8e5wZAh04kt/J+MCvDO3gZZZSeRP5scdv7TQsoxqQZjBwTeSD1nQkyGlwbSVQ0rF
         qnciChrYWmqSt+hhl2Jw72FKBiQ3yNtZdl1c+a3VGsRuKF1v+Bh3UmJEwePMXAw7ivRw
         ixMd1FabYvUiV5Bl7xjWwoYHP1Rb6J9GwAoWxO5NyOmCyVrLWMDZuc624GRA/bCnZptQ
         ec2djvUlLW8HVqvhaFL6kZ38o75dmDHSNPjZhqnTST0mYedguU+iY/GGgQKDLUuRkm9H
         azGQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5z3z07fR8r7rIoGwBMkLw3koULSwUab1rvaR+TTtLW+oqUQXlWOMcxvud5HWvSXywC3LVHrLWwbml0i+B6w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKn0JkO6bTNsFak57IzesUuhJMRkniuOSC99jXz7o5Be+ZsifRy
	e+kACHuLMq4BxIJFDjjuSMeL5hzq3TZhck3bJwKg8BuhJ21bj+YAeUcp
X-Gm-Gg: AYBFou0vB2nToQC5H6MMGLSvSW+/7HTpaunqbO/aItggSwxxsAoESukp/aswXQMcpIc
	crUO1TeEWoWRNE+OkYL/bCBDrXKFMawQ3cL4zqJjY+G9c0AfzCeW8/8otGVrevGZkEJsfo+fxmM
	jlGJtsgt313KVHYquK4QH2DkHzLwM/Z3Z0Vj7h20b7sFp5Rs+ewsPCKU/JBShbd7HkFArj4Hg9Q
	lnQ2vPizMP3tMF6k1EjZjMawK2JdPw+kzx45u6wqt6JHfeWso70PTLMSIdEn2nS33ZomMjJx8ju
	33KVJInfNZYT677jNjNSTVSEPticO7dOhuAw3+bEM9yAyryL7PFXjn5C5lJzHH2LVZp2EmuohwL
	326G7MsKGEOMuX8hmal8HrvbwZHiFotPCTnstMLMs9a7DbtGMBmi/YH7GvR0Kp4XRSBuhgcnSNY
	mIAg45CtP9z5lTIxpwfgTS5Y5nyz5pD4rY8uq6RKRX0x4XblF4OSzcGd5WU4dedA5InQ4qbomYO
	p85HKY2X9SoYD95N7PcJbhzoQ1eSYIPxFGsnwz18pFNxa8glWv8SElSXFSIw12J3VFCdmkwIAyR
	fpZnRS5hl9PMNKcWmWceNJwJN8/zYzjCMRJC/g/Dd9BIGfErrwVeKludHBesN09BgXe9XrXTK0K
	6eYCNEmVrcDMuoqusAKT52jxCewMZ+CKsMrjWrFttrKLB1aTT34tCG3CFm+s=
X-Received: by 2002:a05:600c:34c9:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4a1fdd09bebmr74736715e9.26.1792646268101;
        Wed, 21 Oct 2026 22:17:48 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Subject: [RFC PATCH 10/12] docs: entry: Describe the pre-counted hardirq lifecycle
Date: Thu, 22 Oct 2026 07:16:52 +0200
Message-Id: <20261022051654.79224-11-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022051654.79224-1-kmehltretter@gmail.com>
References: <20261022051654.79224-1-kmehltretter@gmail.com>
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

Document the raw count and lockdep entry, delayed traceable bookkeeping,
hardirq accounting, hardirq-to-softirq count swap, retained real IRQ exit,
possible preemption and migration, and the classification-only return tail.
Also cover late worker closure, raw teardown and context-tracking order.

Record that arm64 excludes pseudo-NMIs from this lifecycle and identify its
external noinstr inlining prerequisites.

Assisted-by: LLM
---
 Documentation/core-api/entry.rst | 75 +++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index 09942135aad18..e02c463dcb08f 100644
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
@@ -216,6 +209,68 @@ is still attributed to the interrupt. HARDIRQ_OFFSET is removed before
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
+  * irqentry_hardirq_enter() adds HARDIRQ_OFFSET with a raw update and
+    establishes IRQ-disabled and lockdep hardirq state before instrumentable
+    entry work. It then runs the generic entry and context-tracking path,
+    including any required transition out of an RCU extended quiescent state.
+
+  * irq_enter_rcu_preempt_counted() later performs the traceable debug and
+    latency bookkeeping for that raw update. It also performs the deferred
+    timer repair, NOHZ tick handling and interrupt accounting from
+    irq_enter_rcu().
+
+  * irq_exit_rcu_preempt_counted_prepare() performs interrupt accounting,
+    softirq handling and NOHZ tick handling while retaining the hardirq count
+    and lockdep nesting through every traceable exit callback. Softirq
+    handling uses the same temporary HARDIRQ_OFFSET to SOFTIRQ_OFFSET and back
+    transition described above. The architecture immediately follows the
+    preparation with irqentry_hardirq_exit_finish(), which applies the raw
+    count and lockdep teardown.
+
+The real interrupt is complete after that teardown. Return-to-kernel
+preemption can schedule and migrate the task before the architecture-specific
+tail runs, so the current preemption count cannot identify the original entry
+class. irqentry_state_t retains that provenance instead.
+
+For an ordinary hardirq returning to kernel mode,
+irqentry_hardirq_tail_enter() restores only HARDIRQ_OFFSET and lockdep hardirq
+nesting after the preemption decision. This synthetic classification covers
+traceable architecture tail work, deferred timer rearming, IRQ-on preparation
+and context-tracking preparation. It does not repeat interrupt accounting,
+RCU or tick entry. IRQ-on preparation accepts exactly this one synthetic
+lockdep nesting level.
+
+irqentry_hardirq_tail_exit() performs the final traceable teardown preparation
+and then removes the raw synthetic state. Both retained exit points recheck
+regular softirq work and forced-thread timer work raised by late callbacks and
+wake the corresponding workers before dropping hardirq state. If the
+interrupted context was in an RCU extended quiescent state,
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

