Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158329;
	b=HXdVf6SNiRowzsqVrEcadnM7iaQ6KTi0II/3f4NiKuYvtdGpYQhZ5/PQiJe/eqWbIBqJ
	 aDSqVC5Rlqtn+UcEylNDezaZ4lOV2WS7SDSI5WiLTCaZN/Ub06ghqebZREdQpOIcm0c9f
	 0PJQA4yFrKDZ1xGOq7xYWxluPSwSKMp1ygz8oaBdEe1KD/sn7K9Dd9Yv4xvdeBfc4Q/On
	 58DQHDw5GMh+Gs2JoIEmZDGZe7IOgQZ+DMiecUOW7q75fXrl10scjaREkEpI4fCg5B1/N
	 wpAMOb7i5S1XwXIShAZ72jAJqXz2zNKg2wSvX9hyTsoI36b2CZzDdEeAPgj34JOF8GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gbskEFrs/q8sEy5EcDMb9bqLWWCDi117BEzygxdkUw4=;
	b=0Lb19ROGIh3oIgWFOJebuppmvWjqsBTbAy5JRlV8PdJK5Hv47MdJj+PxygX+Um7prxzI
	 uilogve5ayikdCXN6aGS70ZUojxQvd9jpj+r7QEglNAuVWRqztCT66G+CSJBsvYCBnRXF
	 MZrNZBImxZR7+r7BeGE2nZ5wAcR4QDSnICxyMi8oHB1l1NkJmt59xJKE3iJY1tHtFfrmt
	 XSwSZiz2sQpDNBI4ScMBW+DlMAxnM2K5Hra/UNdO/A+ZEt3fMTPrINpSg4G8xLDRMkXih
	 6qP+mIJPQ9gRwJOImBJg0tLm6d7dUe6KcNvR99ybNj7GGpUigcRSDsW6PFIweS0G6lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SLZbsxZr;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D764606A33B
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D764606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SLZbsxZr
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so403096f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158328; x=1793763128; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbskEFrs/q8sEy5EcDMb9bqLWWCDi117BEzygxdkUw4=;
        b=SLZbsxZr4b4U7s3N6fQVby1zhFEX+y1eYgIQnRU8V26pvvMSXi/ATOivRRDLFE8roA
         YLFVEhLHj2WMcVRQmgyuLnFGRqkSZ3ZRQbcbLVCvwbD+IOrIjyY50JIoWqE0gjwERyYt
         18UmcS6NtnDmpYIyCaHCn7UDsCx5lBCRY4muwVVuE3+mNNib8UrPEGFDqOF7seiP91a+
         JBw+MBQ1c24RqROYSgPNBjGNhermG+S3/yh7SNDF+VBtpHbJwSR/BnA2VBO8kzArdlur
         whUykdraRC7su+C4vjez3jskKDURYeKfzQhiS6lXGtCbCDqg2SyRxHdlCXsZxhf1IaQB
         AJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158328; x=1793763128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gbskEFrs/q8sEy5EcDMb9bqLWWCDi117BEzygxdkUw4=;
        b=WhlMVTZRylJDrEIhSF1g+5nqW/RjBnE4QAlG5ZkEqyRVehM60gLSrJ+nc6WW4CCsIP
         PZ0dpMLod+l89HOZNETBFbwgNQ4aCmQ/02V7lb60Bhr+X8h4Kih1fU48DuGut9qM3neL
         TP3yZ+7RGXu15eoRLnKJlchRFyHKdcsPR5zt91B7zcLbFuJzoAwCoKeJsiknierMscaj
         VuIRvfjsuOn20JBdq3ZCLwhxFIXYhfwGSLyQ2T53MAismdMJEEocclu6QvuXnK8CTvNB
         CMxzC65XlKJwBPti5u0Nei09PZ8gN3ZtGnZs3X25z4yStMKfv7smvjmTKyOfes8VHPn5
         sqzg==
X-Forwarded-Encrypted: i=1; AKwUvBw6T/qlzRd7tYfhppFVd6SVw5CIP73oPa5kDv6lL7cfjhtA3sVUmvuN/uO6z0VsXdb664R0/daO1BlyRn4C1A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJgGuEreSMKDnxpjJh0KJCrs9dHGfU9eicXx02nZF4qQZ5KBBFb
	N4bR+iozp4gLmCWxLNCLMlE1/cNwuY5hbwBMHGGKWsD5biJD4+++FnQV
X-Gm-Gg: AYBFou3Y6PJFnt93G+Vvl7Z+43ILyT4jhbMkHOO+9aqfMCxaWHoVxeshtamjL5yamMe
	GUFjx/JpCRoTOYhsfbRw8pHXhLOswm9HD6XR4acYKJ/r9PpgyTVEFaT9ilEdIc8vKPqMyyMGX2G
	nBfAI0CYFvzalKPKtewFBIuihqNbvy106HsdZ8wX3g/UKRBJBOuaJgz4Z9GAoS23bB6lWCNpVFK
	5A91o8xgfsBE2JwKAiqpmL6HB2vAZYnREckPUhHxpw1EnUn1R01CMiXH4SpmzDimzHTOoRMsjm1
	CQaNmYxbOCueQYwFVGFdNUSZ+CLFODKBDIgqG9Te0adMeNgoFAX2ym4u+FTO8H4+coHQBdi7DTo
	GzF1+gIU9yxico0WWHMbXXKX0NKEjrAqvysTHCK7CwJ46rbTG5wHKxYOd4UyEqvy/8FVBltGgP2
	2rTtARCllZi4fkK+Lz4eqvScufAzMiswS8pQAn2nU3I0MgL+83B8FR5Db51Cu1E7d449ync8Bk7
	Fez3Q3+vLS2R9w1W61n009NV4oLNS+OcrjWFYyrXHkr/+dYl0+rrRcYBxROMJ8OQHjVS8j8EFwk
	8bMSZO8ulNaaDy0QClm8hH1Qr9pvNMf4iU28U+qbDbJeYV9ANeRooRw80M1QJvtyF5CikZZP8ke
	bVS3Fp9cpcCSodT47jhxsj/ndJKvwyeat+YMjDbpWTxDl56+/NQOn7xjB6mlCnDvpMnBlrryjgq
	/M7wtPSAzy5uKz2N7WjLpUo7LGl+Kqv5MS
X-Received: by 2002:a5d:5e8d:0:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-48e5d45a4edmr2964330f8f.27.1793158327517;
        Tue, 27 Oct 2026 20:32:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:06 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/13] entry: Carry ordinary-hardirq provenance through kernel return
Date: Wed, 28 Oct 2026 04:31:23 +0100
Message-Id: <20261028033127.82193-10-kmehltretter@gmail.com>
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

The entry state can cross hardirq teardown and a possible reschedule before
the architecture completes its return tail. At that point preempt_count()
no longer identifies whether the original entry was an ordinary hardirq, a
synchronous exception, or an NMI-like event.

Initialize the hardirq state in every entry path so irqentry_state_t
distinguishes ordinary hardirqs from other entries across kernel return
while keeping the two-byte generic state layout. A later return tail can
restore hardirq classification only for entries which established the
pre-counted hardirq lifecycle.

Assisted-by: LLM
---
 include/linux/irq-entry-common.h | 6 ++++--
 kernel/entry/common.c            | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index e1fd9155410c1..6f649f6613312 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -341,8 +341,8 @@ enum irqentry_hardirq_state {
  *            exit path has to invoke ct_irq_exit().
  * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
  *           lockdep state is restored correctly on exit from nmi.
- * @hardirq: Encodes whether the current staged hardirq-count attempt was
- *           applied.
+ * @hardirq: Encodes ordinary-hardirq provenance and whether the current
+ *           staged hardirq-count attempt was applied.
  *
  * This opaque object is filled in by the irqentry_*_enter() functions and
  * must be passed back into the corresponding irqentry_*_exit() functions
@@ -412,6 +412,8 @@ __irqentry_enter_from_kernel_mode(struct pt_regs *regs, bool hardirq)
 {
 	irqentry_state_t ret = {
 		.exit_rcu = false,
+		.hardirq = hardirq ? IRQENTRY_HARDIRQ_APPLIED :
+				      IRQENTRY_HARDIRQ_NONE,
 	};
 
 	/*
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9d207c37c5707..c7814c51bb35d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -112,6 +112,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		irqentry_state_t ret = {
 			.exit_rcu = false,
+			.hardirq = IRQENTRY_HARDIRQ_NONE,
 		};
 
 		irqentry_enter_from_user_mode(regs);
@@ -144,6 +145,7 @@ noinstr irqentry_state_t irqentry_hardirq_enter(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		ret = (irqentry_state_t) {
 			.exit_rcu = false,
+			.hardirq = IRQENTRY_HARDIRQ_APPLIED,
 		};
 		irqentry_hardirq_count_state_set(&ret, cookie);
 
@@ -193,7 +195,9 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 
 irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 {
-	irqentry_state_t irq_state;
+	irqentry_state_t irq_state = {
+		.hardirq = IRQENTRY_HARDIRQ_NONE,
+	};
 
 	irq_state.lockdep = lockdep_hardirqs_enabled_raw();
 
-- 
2.39.5 (Apple Git-154)

