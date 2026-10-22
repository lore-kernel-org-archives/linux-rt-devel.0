Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646253;
	b=MVnpOffFaeQZOq7U2KKlm3NtRqPUHYkQDC8gcb41pWghkXeKfj5w0cmQnVdqQaTYkovg
	 gdkaqfA9q1+LjerNKDykv/RJQ8tAiXlbiF2HuwAe8n1HpeTdEpnl45drOfYhXvNSs9PuV
	 68pF9B3abAVNjgr8D6GgcUhU1y9Eu7iFb8Zt7VMpkFBKseKFbbZ+SmHjXfVncnH+vJeMQ
	 5+BVFbyIfr7/RFlKpkyrfjE6Q9oyMuNM2FKMz4RgVvNh7YTZnZAPtrrFUrh7ZW+g5LWDT
	 Vey6uGCbL1b8OFWPe5w4y7F1Akk3jXkaa9lFAdjB6slkXbLYIrUPQtF7WSu7X6OsKdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SgSVPju/oDwYCUMu1qXQuK1g6vGXDkUziO98RSaFsPc=;
	b=g/sFRNABdC9eL++xd2vEHm/6m85JerQNE8bmZuWrwYkEV/H3AhAA2peSmeNFkw2vjPdI
	 dQDLLcWQAg9xgKBVxoiy6Dr5edY3aNil/yZkfdjUkABRN6n8vUmn/BlqpERZUANmwkjch
	 U+bTEKjfQsWBjpEbiQlc3sQztQLszJ+bJffOVjOKfdELbV7/bHXai5/ng9lyOV6fYsg19
	 rtpc3648GDCJtR6HLSHJMyC/yHCMBDO78LtiT1WCUWvcQFTCAZfSWv7yo/CufJbHcOKIG
	 +aX8RMn5Njg1NuNHLSIap4T/NVFxCXJP8yJakm28Bpm+Kq54+jgdN1CivPLzv5Nx4Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYljh43v;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E3606A31A
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYljh43v
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso15954115e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646251; x=1793251051; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgSVPju/oDwYCUMu1qXQuK1g6vGXDkUziO98RSaFsPc=;
        b=KYljh43vcPj1aShabI9WT6rACHZqyNhY5Nyy8O7Pjy3c625vMyewpi5zLXum6iX0hc
         SV7Vt44zy5ZlsOj6Pq03Dp49Wf3uh4YIVWTeRJIdGzodkxgE06w6iRhst0E38rou4Czw
         +2Ktq2835BqqoOkPJLS1FCIL/3JjG5y67MgHHWP96oDrml+9kg/DFmQ+i8vyn7v3iSRw
         I3SK46W90tMAF3Igf3Laxvvij42WX/UaOoEhztfolMswdcUF0AqY3M0r6oo40/IjJGCJ
         I8USgpab6pnRbp+7pxeKlvlJgJI7FD0VzDDHKzyj9pZmxgqu8sDfN11CnPQipKJQaoev
         XtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646251; x=1793251051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgSVPju/oDwYCUMu1qXQuK1g6vGXDkUziO98RSaFsPc=;
        b=PPtb6/FjKLXjcW3TQDgUNCI1E1T0acdKH38xkLazTlmsyaRXo5YRsNty/fGS2ZMeNQ
         Yt3yKBP7fhSzDmfIisLLbvFAMeBAw2iu66wJNFUk6BXwLSy4W1TnDXDGzkh0QHua2JZZ
         B/mT+gqSqd31SZHq7LhHL4PbbOsiCrd/BZepdqMc1D9r9bo5SOThD4hRLZDW1Rx+DUjd
         Gn3r7lc8w3h5EJj50B+nvM5qXnksN9TOwhDNCdPxxBMrNh2jevl1TTYxm6M4WxYSDSsw
         yEf3+5Q6O3/dIbMnUGfbBGtYN2hF3oQDPKQZoV4xXVn/e/CxqRqC0cKReu8d+3pewMxd
         Hn1w==
X-Forwarded-Encrypted: i=1; AKwUvBwWZdTKMwznII53j2/qNfwKawF/rQhiuHHKeUtZRp7+siCq7hyHx+D4z0SggQqia2qttS9lCxKMGXicqZVZtQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLlE0az9av4H0qAD9pjnph57X+OPkBW+ZZjjU3hMty+NvtWTMTC
	coMP2KWsYFs5xvlT6Dg7FVXZVEbVWXSE72P6TGtyExXYmy2urIAgE8qq
X-Gm-Gg: AYBFou3D7iXAD/rbYuHN9tjwnhGSQ1p/bRl4JObIjyL5++/fsY9KbxZE3F+mwZR6RxK
	TPtRJVlsktT5vKt2/2J/TEe62P66JlENJCNPa7gjNmYYyp0Pfl/0WPJapvpngUeI761N/n1jR9A
	arFGyBW7GYhE+/VT6ek36ch3GoVs3LTqrD8WGhn/n8Z3+WEXT+JzWMb/gcboUH9BME+4dx2OnLl
	Amv8H9KRn+ZqIMA8bWxZ+ybv9M65vEQoEcURxTyKZp6SqcCvq1/My449uo67jPDQWlGVQnLRswF
	/IHsXW/T3QpiWMmi8EcSoiIM1qfH1sazbW/s9ahdBmEe1K5ObAD9LKfVz9bwt7jgrP7jK1ry72y
	KiWX7YADmtBpEeokones9mHVv8rlgTzqSSjlQmT61KFNxcrh6we5wFdxwNoB6nrTOfwCSlEThXS
	MJL2JfYiqw6+dXWgI2jxPU4gVKUdK7HcbCYZDjxvj31kTMJol1rWzQf9bSDbDgrRmTLvCwBmBSS
	P8igJeiV3XL+RkwsiS7J8z84/b+1i2kPueAYwYb2KsPfiTKnGAq4wDiQSfqIRyTzMJSe6QbUFtG
	a2ktbPKZCB+6iEHUkeGXJOZZ2dXfAhAW8+sTBwtQT6i1U+rsRWuaUQfcOl7wgLslO8uVQ6EILK2
	EO0SiW+I+Cd6nNbWrk+8/QbvHy0PizwWQwGI3mvAyqUB4NwyYYESyK4ewysY=
X-Received: by 2002:a05:600d:8653:20b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4a205ca7975mr15129905e9.4.1792646250340;
        Wed, 21 Oct 2026 22:17:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:29 -0700 (PDT)
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
Subject: [RFC PATCH 06/12] lockdep: Prepare IRQ-on state from a hardirq return tail
Date: Thu, 22 Oct 2026 07:16:48 +0200
Message-Id: <20261022051654.79224-7-kmehltretter@gmail.com>
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

lockdep_hardirqs_on_prepare() rejects any live hardirq context. An ordinary
hardirq return tail needs to retain one synthetic hardirq nesting level
through traceable IRQ-on preparation so callbacks remain classified as
hardirq work.

Factor the common preparation and add a return-tail variant which accepts
exactly one nesting level. Keep the ordinary helper restricted to zero.
Neither helper changes IRQ or hardirq state. The caller must remove the
tail context before lockdep_hardirqs_on().

Assisted-by: LLM
---
 include/linux/irqflags.h |  2 ++
 kernel/locking/lockdep.c | 42 ++++++++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 12 deletions(-)

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
index 01dba8fb32a90..457bef3ea1689 100644
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
+static void __lockdep_hardirqs_on_prepare(unsigned int expected_context)
 {
 	if (unlikely(!debug_locks))
 		return;
@@ -4442,10 +4434,11 @@ void lockdep_hardirqs_on_prepare(void)
 		return;
 
 	/*
-	 * Can't allow enabling interrupts while in an interrupt handler,
-	 * that's general bad form and such. Recursion, limited stack etc..
+	 * Ordinary IRQ enable requires no hardirq context. The interrupt return
+	 * tail variant permits exactly the synthetic context it is about to
+	 * remove.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context()))
+	if (DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context() != expected_context))
 		return;
 
 	current->hardirq_chain_key = current->curr_chain_key;
@@ -4454,8 +4447,33 @@ void lockdep_hardirqs_on_prepare(void)
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
+	__lockdep_hardirqs_on_prepare(0);
+}
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
 
+/**
+ * lockdep_hardirqs_on_prepare_irqtail - Prepare an interrupt return tail
+ *
+ * Like lockdep_hardirqs_on_prepare(), but invoked while the single synthetic
+ * lockdep hardirq context covering an interrupt return tail is still active.
+ * The caller must remove that context before lockdep_hardirqs_on().
+ */
+void lockdep_hardirqs_on_prepare_irqtail(void)
+{
+	__lockdep_hardirqs_on_prepare(1);
+}
+
 void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
-- 
2.39.5 (Apple Git-154)

