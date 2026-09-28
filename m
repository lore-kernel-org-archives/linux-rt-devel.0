Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8D3A3E9A
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617324; cv=none; b=ELBiWRsQwfAr7I8MhmxCAoPR5xNqoamzUOwOyU/S982ZSwgdVvyYP5lS5Vq4nn9mYBhCzmLQCChq33nJbJgnS3c7BraLz/YRRi1pK0HrpzMZOBCcQnG2yA0haGzfVFgI4kFHht67bKD3BW7mi+sr3YSAtzSFcG91bHsVyTepb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617324; c=relaxed/simple;
	bh=6mIvWhe/r7QU8+ZBormU4CZE5CRYcvmpUPaCx/ZKS+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NB/bTT7exfN1uF7JB+u7sAbi9/AH4kShjDTGErCcEVavnrHIdafD2WKPGUKwfUZXVM1WPx4twUhp6SjTSsEqJI2Rnc39o3MBsRULnm0GEGdOPDfMKAvK0KWbY661gtcCqKV3CX9vkAuC62fdVPZBwpkokx9jx4Llu8f6rn+5OOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwHE71o1; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwHE71o1"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4843227cfcfso45485f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617318; x=1791222118; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbjBREz9vOqId6KGSe2hfelOhYq7OUN6jgn8hmrgsOA=;
        b=gwHE71o12rqe7beHC2fm4taistekEQars7y/B+cuZn6D4gasP+qHDZdtqrUBuFU0vJ
         2BabtbidKkXyECyYGthZBqa8xvG2eEa0VSEH0vfJDMbL2sF1XCkHUy/m6Uo1hx6Cm/Dn
         crDoTS+yB7UW+fDElPSgCU2eAFl5cjvRDfaKH8DUdmtEAikG12MEj9DJQ4ZTGXvivklY
         b4vHkPKnHlzDvpqjT8mY3ioVJcZ+UrhG6nxdtagmrhCs+II0/zN3Dut4N3/DFWRDYD+X
         WX84DCYVjQwy69Hp1Ru4Mx+sElU8O0VfrKl3VX+PzE/lhOp+DJUiHMRUQfDUzMGDombx
         AwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617318; x=1791222118;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbjBREz9vOqId6KGSe2hfelOhYq7OUN6jgn8hmrgsOA=;
        b=hh38EvCPLBxmHEFr5OPf2E1jDLNFZ7TF/U5KF9oe6+1Oj3NMs2il3/WRJnjc+5GbBj
         iMQTnRCIUfYeLSpYSXbK/HokRmcbQKqJjlshYjb+QlFhXkx7EdWoj1JgDEHre71LCMrp
         CeMewCZGvGx3sVC8iObDKgN4gb/kPFV2S6R/XQFuQVjPy6FWsGbMNiutNAX9rLV+xJp7
         Ik3Z5eKXgyuAZ8y9r0ILtltG+u7ucZnbLkOFiliecJK97bQW+gJxA5NckgLZubfjayEQ
         FLKWuaWsIQrpx3MdRHlRNRFpfYrL0HEyXK9h2tn7lsKE2mBOOragQEf7cfRH6dfji82g
         jjeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7ygV5Zlzg6eGYp39FSgfvqZMhmMEWgsgbVYiie6qsG/vQcxMwPAiCYnL6yFx1S51uE/Ae9kCJEMb/Nu+4Jg==@lists.linux.dev
X-Gm-Message-State: AFuF++mJV/SwZ2dR8L26YzgFn32FbYt3Fea2gDGg+XJasfbJvS9/VEcW
	aa49zTLpPtSH405IYYfmLx9ylfFmjeJKLewApgg6wIuex+j7Gq6av2Ba3mBDekC9HNgEE3hXUoH
	mywExjSfbRfPaNw==
X-Received: from wmdv11.prod.google.com ([2002:a05:600c:12cb:b0:4a0:8ba:ba83])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a00d778efemr1664475e9.14.1790617317905;
 Mon, 28 Sep 2026 10:41:57 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:16 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-10-smostafa@google.com>
Subject: [RFC PATCH 09/15] arm64: Don't assume the kernel stack size
From: Mostafa Saleh <smostafa@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	akpm@linux-foundation.org, urezki@gmail.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

stacktrace and panic functions assume that the kernel stack size is
THREAD_SIZE.

The allocated kernel stack size may not be THREAD_SIZE anymore, rely
on the newly introduced helpers task_stack_{low, high}()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/stacktrace.h | 4 ++--
 arch/arm64/kernel/traps.c           | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index eb18d7cee62f..cbc93cf213a7 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -41,8 +41,8 @@ static inline bool on_irq_stack(unsigned long sp, unsigned long size)
 
 static inline struct stack_info stackinfo_get_task(const struct task_struct *tsk)
 {
-	unsigned long low = (unsigned long)task_stack_page(tsk);
-	unsigned long high = low + THREAD_SIZE;
+	unsigned long low = (unsigned long)task_stack_low(tsk);
+	unsigned long high = (unsigned long)task_stack_high(tsk);
 
 	return (struct stack_info) {
 		.low = low,
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ce0e213d772d..b91b154843ef 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -902,7 +902,8 @@ DEFINE_PER_CPU(unsigned long [KERNEL_EXC_STACK_SIZE/sizeof(long)],
 
 void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
 {
-	unsigned long tsk_stk = (unsigned long)current->stack;
+	unsigned long tsk_stk = (unsigned long)task_stack_low(current);
+	unsigned long tsk_stk_end = (unsigned long)task_stack_high(current);
 	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
 	unsigned long exc_stk = (unsigned long)this_cpu_ptr(kernel_exception_stack);
 
@@ -913,7 +914,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
 	pr_emerg("FAR: 0x%016lx\n", far);
 
 	pr_emerg("Task stack:      [0x%016lx..0x%016lx]\n",
-		 tsk_stk, tsk_stk + THREAD_SIZE);
+		 tsk_stk, tsk_stk_end);
 	pr_emerg("IRQ stack:       [0x%016lx..0x%016lx]\n",
 		 irq_stk, irq_stk + IRQ_STACK_SIZE);
 	pr_emerg("Exception stack: [0x%016lx..0x%016lx]\n",
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

