Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158315;
	b=FOzqv4ba8VMySzS7i/LxauOCjTKJ2UkKvtlsXougg1+SbU5tCz/uCjQrgPLqaiii7GMQ
	 L4NEH6KQGqV1qul3Pf2VNFnclYWZodeGUNAFUdxHpr4HRkve1SBQOYPEntkkkdNbk2lXw
	 ev/IeXGXgiyEVfzCC9C2JhmFifCqvmcd3FfxyQOLtRJpBO9HWyyPe6AkNdLr/71W08Ult
	 JRmkLSX0r4mLxxSctuBQrs8angAO0EGbSyKkZ3EZKOd0AEfTaSqXqqeIU/4EF/CQcZlEg
	 84Fk3ZkqgMRnCOcz28vqR6wxyzKR7Jqc5/reSrdRkafPhtgdU3SE6lguinE+VAF0PIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4bZvL/9Bc8+ZGmd5br85IbVSWoa0e2ud1GyeOTF2PTQ=;
	b=tMb0D7136KWrT07dsv3dqdyDcMPSXHAiqczyyqL1lnMtZsndP37xxpZ9yoli7DeQgTSU
	 /fZUA+2gpu70gDhvElftORx8gVOpTpLEmCFxq7nQ3OliFUKJKEx85Z5B+shHR0hHgWsBu
	 lUhyySMtLtB/J5WNfDlfDxuGapitvVp7myShc5wQYNZN3D+neToDkQrxqbE3ms/SknxSD
	 DK0/SRmsqn4syJkRUW+jz6uWi0ll0bbO0V2U0yktwNwPIQSeB5DgGEBE4HCCzcyDS3gmT
	 FGwiZ+vRrhUCFBnF3Cwd3KaexlQMro6AFhKcBEvAUD1E+RVjwZb9G/J4sqCemtyyT0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNqhJnVB;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B8606A326
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB0B8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNqhJnVB
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df4f540ebso224098f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158313; x=1793763113; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bZvL/9Bc8+ZGmd5br85IbVSWoa0e2ud1GyeOTF2PTQ=;
        b=YNqhJnVBWiDO6zCopdQCVsf1BicPKtHktguLxAOodaOAEsCGOM/5S6SNsEW4bH3IzM
         p0yqpOI3noKNFiReF+Wtej4xMIAqI0QT2g9WUhjZiwCQfYZN4fTIjtnlcdTmlGKHDHGY
         e7llKi4t2nP23tbG4CAtcQob+IEMVY0UeqauEL+tTBEgpKvPqZfhGdwSq/nPVs6Ozh+9
         8WkpU1cuyKrGcH33vS15oDFzGCWFC+2J7lzmILCNtKcEGxvexhVbvgCt/u5gVky4diA0
         YIbASWpmXW0Rjo00TIVnrohqK7KkYhFi2BPlS0ua3vNQqCYYw6o7oynVkKSRLMUKOJV8
         trDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158313; x=1793763113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bZvL/9Bc8+ZGmd5br85IbVSWoa0e2ud1GyeOTF2PTQ=;
        b=RJR4ahiUVrXdzf1gOIlC/FZetRksQCGmRsFpLbbdAda6eCoVDeoCCHbHwKlx2OGn7v
         W3orVTFTJ3/oEv6SZGgXHcp7dPHXie0MXJeDMBnB/+C7UYAHGCAYyLmse6ogrmj1Hsfa
         4V8qJy2x5OEnsO1kHvwsdAFRHSveLGZAapy7IEVqFhGtHeBFcwtD25XseONCE+SGPu9A
         wd96pKOrVnrkeUNJUWBrvdx7Wsew/S4NOAOlbTlt2WG4J9+cdp/+1CMsiTB4treNvXCH
         0AbxnhwF9NYNMaUIOu8JcM62G88FG6d6hHfEr48iX28MkZ0kAu3hvmGoF2E+qNcSVoXJ
         8sFg==
X-Forwarded-Encrypted: i=1; AKwUvBxDC05NAaQpPRVMawlDfRAlqsuyHjBAerUbOVP0c0JbIdGHE8eISpvgNw+bqXzt5py708W1Rx3XXiyF5hvv4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJl/2mLf1vtMWfFz9olJx3lvUFDazjTTpZLiVRlr/y2ofhAD4jr
	Iu9ugoBlPj6VK053JADQi4b+adns5j+tm4ofy6dIWCtV2qNa5Fa+ZtsF
X-Gm-Gg: AYBFou1wG9tf8Vfj9drFBx/k/Yoc9Zb7NPYsYzxsijF9EwxLCsrbOVrt0pVJGBKcWb6
	HX0DN6uWEyi0LbatbyPl+vQIPchDGE69Abkhfb9S6BQsEj9niYLdvRBUrSY6KfDTl3MvnEH8NuD
	0PMSFyR8rzrl/ivy55wsmK2gCnr7XQ1gEE+YS471Wx2SLRaf96QD5PZte+COhBr/MyvSrVY9mYM
	REBAnXTx7qwCgB2YncgzFwQVBXJZ1A1tTKVub8WSsrfoZTR4iKZbKDH4smUoF7lDmChGQCdGALd
	POFRG6A3ehK0m0YUwpAnXX3sr/qkB5a84U2ql0JapJK9JpFXBv6z9a3aB2WZLbCc6o47jTE1cJf
	tUxsteybxGP93fhhKBJBPhsSJpq/P18NubCf9Byt4h0T4qEzKsLr6sgMUnstghjdf0TTWiEfRux
	ZM7CbTXyjYkzPoEtAns4jy+asT+WzgDfqETmeFSwfaV1KOnG8QmDncvVifNNfHz7DpQTHCdxTut
	WOKHc3I3js/am8ax1or22zE5HOxjFLvJ/MbJq3xpADiPtuKLUkRw4NiFJSSKGvpoFQ2Ew4I8SuJ
	Enj8jJ4OjAtTKCCpiG0+LL147M6XKBupe3QbNf59UTrFLvVKG1z5wh4RcXo0FvEKslGozZtgJzz
	DUenCqZxdYyygcIoq+/SWhea2IVGEYDngciSnh1mwiin/7aBPdtTlik2V9tUSohHHYLYgvt1+d8
	b22Hh2X3Irhy5JXb3ExtGOi9uW09juxn+i
X-Received: by 2002:a05:6000:1862:b0:48b:d9:cb52 with SMTP id ffacd0b85a97d-48e5d2f0870mr3087140f8f.27.1793158313112;
        Tue, 27 Oct 2026 20:31:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:51 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/13] lockdep: Use raw access for pinned hardirq state
Date: Wed, 28 Oct 2026 04:31:18 +0100
Message-Id: <20261028033127.82193-5-kmehltretter@gmail.com>
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

irqentry_nmi_enter() reads lockdep's hardirq state before __nmi_enter()
establishes NMI context. Arm64 does the same for its NMI-like EL1 debug
entry. Both paths run with interrupts disabled and cannot migrate.

lockdep_hardirqs_enabled() uses this_cpu_read(), whose preemption checks
are unnecessary for these callers. Add a raw accessor and use it in the
two entry paths and in lockdep_hardirqs_off(). Keep the existing accessor
for callers which are not already pinned.

Check the interrupt state before accessing per-CPU state in
lockdep_hardirqs_off(), independently of warning suppression.

On arm64, this change relies on __kern_my_cpu_offset() being forced inline
by the earlier prerequisite patch so the call chain remains noinstr-safe.

Assisted-by: LLM
---
 arch/arm64/kernel/entry-common.c | 6 +++---
 include/linux/irqflags.h         | 3 +++
 kernel/entry/common.c            | 2 +-
 kernel/locking/lockdep.c         | 6 ++++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 11d3f888fcd87..003f84109a913 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -177,9 +177,9 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
  */
 static noinstr irqentry_state_t arm64_enter_el1_dbg(struct pt_regs *regs)
 {
-	irqentry_state_t state;
-
-	state.lockdep = lockdep_hardirqs_enabled();
+	irqentry_state_t state = {
+		.lockdep = lockdep_hardirqs_enabled_raw(),
+	};
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	ct_nmi_enter();
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbbb..5bc179a88e513 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -52,6 +52,8 @@ extern void trace_hardirqs_off(void);
 # define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
+/* The caller must already be pinned to the current CPU. */
+# define lockdep_hardirqs_enabled_raw()	(raw_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
@@ -113,6 +115,7 @@ do {						\
 # define lockdep_hardirq_context()		0
 # define lockdep_softirq_context(p)		0
 # define lockdep_hardirqs_enabled()		0
+# define lockdep_hardirqs_enabled_raw()		0
 # define lockdep_softirqs_enabled(p)		0
 # define lockdep_hardirq_enter()		do { } while (0)
 # define lockdep_hardirq_threaded()		do { } while (0)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e234b04373fea..2f5229132466c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -158,7 +158,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
 
-	irq_state.lockdep = lockdep_hardirqs_enabled();
+	irq_state.lockdep = lockdep_hardirqs_enabled_raw();
 
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c3dc84a7cef26..01dba8fb32a90 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4543,10 +4543,12 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	 * So we're supposed to get called after you mask local IRQs, but for
 	 * some reason the hardware doesn't quite think you did a proper job.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+	if (unlikely(!irqs_disabled())) {
+		DEBUG_LOCKS_WARN_ON(1);
 		return;
+	}
 
-	if (lockdep_hardirqs_enabled()) {
+	if (lockdep_hardirqs_enabled_raw()) {
 		struct irqtrace_events *trace = &current->irqtrace;
 
 		/*
-- 
2.39.5 (Apple Git-154)

