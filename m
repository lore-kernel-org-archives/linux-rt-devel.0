Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158335;
	b=vczM1QnvknX4gn80Q+ysvBnx8rNgts3ZhmmjAwvHCWZj3jtf+w9Pw36Iq6q1lwl4ptLp
	 yNXlMRnIF7z4kjckTgvXgF5PSK+tkxRqTetsJBW+MHsGiHgYxakvSQpTKv9gB+lO/FlhB
	 I6mpeX0tyNkImF1ROkqO6tnHfO6Dw+frTLXukQLd6aMXqUdo88/lfEjvXuND/CSBQpPu3
	 npwMybUwZH8AirR6TS1llOKcgSUn6d5V7MUK+z6wXnz/n7eMFURMrn4Gox4+N4eIt+cXU
	 6m5Ce5HUYIaH8uA2q18UgVsuJkW7BWmO79T9Q5MqFRAhKioqXcBYMnjLO4lICDaMlCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WCtCiCeMvqleVCPGIStS9YbFBYnceHXr+HhJDm7YwVI=;
	b=R2L/iRtPqdiZPU7tsKAHP2XCo+ZFYuMXnRBdm19gl4limmOldg4DcJOLPU+9cyE+ERnx
	 qvtnpWWnBEHlDWxpqQphPtRp2qRq1nix3wXwWT2jC37cnY2+Tl/GLnJg4TzzUcpsPeBDN
	 vzN3Ua3A/EcmxQiHc1j8b43+sWIj2QlsPnmKMndXqz9yXZAVdTV4RkrlQnzg24gzi3d6s
	 Zluwz2wG37/B8gQ3uYcNkdcO+TzjuQoPThLyib2rX0DL2JNupl3L4ujM3EvXHlhwjhumd
	 COJTJmf6V3wFVNzjZ6agHnZrGRXi4LYXkDX+MtFj2mqS1tHI1zWxySeWTzjuzZxyeWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="j+F/VqTB";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB94606A322
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB94606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j+F/VqTB
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e0d1da913so402079f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158333; x=1793763133; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCtCiCeMvqleVCPGIStS9YbFBYnceHXr+HhJDm7YwVI=;
        b=j+F/VqTBnigMrjpZd0u1tGt4rugwBppXWoorWU6fhtTFi7mrAlC8xZIiO3K59nZ6yT
         LeStE0OROd//H2Tj0DLEe+H8RNK7HidSXYqZRQRerutZ81W59svNz4jf0kKguc6vxX2w
         l82JRh3yEMmMwjD4ovubRmzD7Ye7ChOrrcS+9d3a7Fux3gBNlbeXJYe37IuV0Uk1L34P
         OWTlKNAVvkX+EcVjgNFqpH+3gHziuUqiKqPv6gMPv+CAZjl9J8UVykOV1XnSskoEoN0F
         FEc74L0nSewSgMDvjD0x/G6j7lAGlyzvERo0/axydICd/Jr1LXH+uTknLzV2/0lkc+xC
         pw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158333; x=1793763133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCtCiCeMvqleVCPGIStS9YbFBYnceHXr+HhJDm7YwVI=;
        b=umsei2yf1GYr280b9IHAq0TN2Qyd0vfn8jmiJ+c9HeNPbJxzgeNa+CraZYhm77Bdis
         5YwWwKDCbAmiCOYRSNeAvUgQQ1nCpv3uhp8BmaVtG1dt6L2QADT4dnJ4PcF3Bi9R3pZW
         QOKVdXp/s9wfZ8yfWaOos+7+xnUna/6MK77btNdGnP/yxqb1i+Vsf7uELcLaphT4c6aG
         pVuZ2x/jToad8gi5H5j7bKNaa0mg6vUzPhPmJJr7gnLXIG7HuaXoI0hLM40NC1yj4XLx
         dc0bJHdeF1ObqGTkHzBLckIVMSQ0VCObg8zhi0lypli0V6LtPatQW4K/tAmWD/U472Tl
         qDZw==
X-Forwarded-Encrypted: i=1; AKwUvBx9LDnxjKevaH9gRstMM7zv9vRXr5rcgVdqiiopx+xSQFLI8YjX9EqCbuEftwCxv2s+N4HGAYqWuyI/QfnBUQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLlV2+bXa+ftea++xBcTuIqhk7szOlh2qG8LCeLsKBhlv2njHdj
	mdlwFx2v5yqNSbtkS0EfBvQJoHGMmVm9p8l1zRrmVvaMXipUHa4T/AqJ
X-Gm-Gg: AYBFou1A5vlTSKy2o61wHXKLnDRzrGHUXUdYeH76cUlBPeNoGax07OapS3n3ZzRsPK7
	cNvOWEkXQKinyRNzMjhiOOnEhdQ0r4tZcCd9lZwT+K4uZeYdpEKXpEgHnqot0w5vcmZiHRBvIeh
	IAywBWQki6zfZGsSEtlBZrrCnxEYZf6Wz4ik4hBeu6x2WSfQFBXuKKXUXnRz4VN+d+AULAF/qlt
	VDyoLKrtKD2Xi7KTOdXCw/l3BSYej5OWal59rtqmVeBWyYcfvgmXUXQokj8UV7nrXEJqkAx+1Dw
	KoqDAVP4jF9f5D/foqE+sIwdld3UU5O7UQJ3/ho1nN2Yej6A1FydCBHLC5NG7QosJOUzshKZWrw
	+8OIaqOBPRDPkt4PiI/8noNHeIr3ary6LjTcxoGqPJ/fYp5f0DixzKJlh1w4R3t8piC9JdTZWWW
	rJ4gyA3THiRBYDbfe9vTUtWyBlAZsoRaHYOBccz9Omi3GDZHgPSpQ2hBXg/zauGzErxn0MisaYF
	ybXe7Fw2m9h3ysUQJ/pNK+Buu8Yv0cYHVi0bFo30JftTNJAgw338I5ftvQnMgiffFl37X9V7trj
	+0wTp0ScA6e3y4kL8axPRre+MJ523MwODlWTN4PJF/c7WBa+heS6qmRrJOWu9x4UWPCVxxhUAef
	m2lRT47jSodWOw1+PVs8WROifugtRyIQqTBPpId/Li01wwmZLyham/BhQjuh+9c8bFbXMI5rrYb
	neaZecJ0feTfW4BQEx0osG+YSTwMhQJR09
X-Received: by 2002:a5d:5d88:0:b0:48e:5c9b:f12c with SMTP id ffacd0b85a97d-48e60212fb8mr338598f8f.16.1793158333537;
        Tue, 27 Oct 2026 20:32:13 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/13] arm64: Use the pre-counted hardirq lifecycle
Date: Wed, 28 Oct 2026 04:31:25 +0100
Message-Id: <20261028033127.82193-12-kmehltretter@gmail.com>
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

Ordinary EL0 and EL1 interrupt paths establish generic entry state before
irq_enter_rcu() adds HARDIRQ_OFFSET and lockdep nesting. Callbacks in that
early window are therefore not classified as hardirq work. Their exit paths
also drop the classification before function-graph return callbacks and the
kernel return tail have completed.

After the EL1 pseudo-NMI decision, enter ordinary interrupts through
irqentry_hardirq_enter(). Finish the staged count update and delayed timer
and accounting work with irq_enter_rcu_preempt_counted(). Use the retained
exit preparation followed immediately by conditional raw count and lockdep
teardown.

For kernel returns, preserve the existing per-CPU register adjustment, then
stage hardirq return-tail classification before MTE exit tracing. Keep the
pseudo-NMI lifecycle unchanged.

The noinstr path also depends on the raw preempt-count and
__kern_my_cpu_offset() inlining prerequisites earlier in this series.

Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
Link: https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org
Assisted-by: LLM
---
 arch/arm64/kernel/entry-common.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 003f84109a913..d70cffffe71c6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -94,6 +94,8 @@ static void noinstr __arm64_exit_to_kernel_mode(struct pt_regs *regs,
 {
 	local_daif_mask();
 	irqentry_exit_pcpu_adjust(regs);
+	/* arm64 uses the split exit API, so enter the tail before MTE tracing. */
+	irqentry_hardirq_tail_enter(&state);
 	mte_check_tfsr_exit();
 	irqentry_exit_to_kernel_mode_after_preempt(regs, state);
 }
@@ -560,13 +562,19 @@ static __always_inline void __el1_pnmi(struct pt_regs *regs,
 static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
+	struct irqentry_hardirq_cookie cookie;
 	irqentry_state_t state;
+	bool do_sub;
 
-	state = arm64_enter_from_kernel_mode(regs);
+	state = irqentry_hardirq_enter(regs);
+	cookie = irqentry_hardirq_count_state(state);
+	mte_check_tfsr_entry();
+	mte_disable_tco_entry(current);
 
-	irq_enter_rcu();
+	irq_enter_rcu_preempt_counted(cookie);
 	do_interrupt_handler(regs, handler);
-	irq_exit_rcu();
+	do_sub = irq_exit_rcu_preempt_counted_prepare(cookie);
+	irqentry_hardirq_exit_finish(do_sub);
 
 	arm64_exit_to_kernel_mode_preempt(regs, state);
 }
@@ -877,16 +885,24 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 static void noinstr el0_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
 {
-	arm64_enter_from_user_mode(regs);
+	struct irqentry_hardirq_cookie cookie;
+	irqentry_state_t state;
+	bool do_sub;
+
+	state = irqentry_hardirq_enter(regs);
+	cookie = irqentry_hardirq_count_state(state);
+	mte_disable_tco_entry(current);
+	sme_enter_from_user_mode();
 
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
 
-	irq_enter_rcu();
+	irq_enter_rcu_preempt_counted(cookie);
 	do_interrupt_handler(regs, handler);
-	irq_exit_rcu();
+	do_sub = irq_exit_rcu_preempt_counted_prepare(cookie);
+	irqentry_hardirq_exit_finish(do_sub);
 
 	arm64_exit_to_user_mode(regs);
 }
-- 
2.39.5 (Apple Git-154)

