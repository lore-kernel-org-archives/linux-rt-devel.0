Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC424F5E04
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617332; cv=none; b=BOfKaQimf6OgSXwOw7PTAe6SV2Pf/+GU4zfJsgxlyHNYcG8hgEIk8KmmB60rNDLvI0XKZaqOV4c6dnS0kVFNdawA8NWdWuJ8jgqr3lpSrT/++3nUXAx0lLK9a3Ddl4WAqE0iJfU5K+k5rz4bLzUABc9fW86+vuUWwpHzN1kljvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617332; c=relaxed/simple;
	bh=LLJifOi3vvg2Oi1hnLaR9/CWjBWQAFtnWhBPvFWhHP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPMiIUtoyEPfcAkGceJk4io0e+kwb2zcOChHvelW75stgndQPUtNZ+V9ZEGcfTLrizUUrZwrVaaNszOl4TpQy9FfcG1tuzBfO2cQfoE4i/zslDdemDgW9rQEVAb2le7ym7TMzdxJCtZOvBejnzOCcGunS9EcwS+9FkK4CLwxfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvRJH2ut; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvRJH2ut"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48aec0407daso571875f8f.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617326; x=1791222126; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nxfrq1oErs1k/vPJqSmHMRIqd6UamZQptG6IeTh3sVg=;
        b=uvRJH2utiFAeUibQmXPndVbqYdBXKjcwu9cFfMC0D2e8pmCyjhdUnKXm4IjZ8j2eWj
         A9AQ0I+SVSbwm6SLUXcdLohLoSeY8ZQY1wVCfLEEH6HZ5663QfZyOJmaGYlNSI759Eym
         1VSOitrZ59p66x1ME5TGV2to5+AKHRObU1fEeYi82TklCq+zumy8tSV/VtemdMt2tLY1
         F4JY3+izETz0dKJMsXF8NO2q+ofq/2ZqzR4OnQVQIftfkh9k3F250Ec8OFoYHlOOY91p
         tZO0gZe8dM9lVKY9cTmdrMV8BGr3Xw1sof6NUhbPbdJqz4CC3tPyauwIi8fXRUNiWYRB
         MZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617326; x=1791222126;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nxfrq1oErs1k/vPJqSmHMRIqd6UamZQptG6IeTh3sVg=;
        b=vofc5lfmNsqbGKIzAchzP6zTe15vWvgsADpJRWZRk/4ir1hIlO/Hv9JZStsJDfEL01
         saCpoVsX1SzdWvALY33NtMoW4liifbyQUjUhnnpzZV9q/gCzzr1CbaXsZeV7i5ezNdE+
         Xdxzf3koA62cxBdnCm+mbDuCFOmGnSJ67uGAy25gLSuUrKXfnzm8O1or+L9EyJ/62IET
         HXTUlkVZMVAoOoQhZqm/w6/RSY1jaGN6ZRLcYVRFh20+VDCwqxqcT+j0ESOu3LbC44X8
         boB5qFYfTkw1TzBdiOgsABP4obzuXt3aCx1RI5KDIZ/kha4cMcaTCx9tyRXCATdjjPIF
         ShvA==
X-Forwarded-Encrypted: i=1; AKwUvBxCy2sXlsNN8BPzDyP08ou0H514YPDXvmxuzESn/Ge1zW2gSYlja/oWhRDvraF+5KwxSAK2TrypHA6tC3dzig==@lists.linux.dev
X-Gm-Message-State: AFuF++luHHS8BzrnwQS23gKtPkVsfvq7Pn/GQb7pyClQlT/3udgStQrT
	MUbQgcDJetKX3T97wRTWVMP2PF2mHKiKCHx4QuCI5duBBmI7etJ3SGZB8H0e9fT5Ff5Du6cjiPo
	w75vr9r/KFtIeCw==
X-Received: from wmpg37.prod.google.com ([2002:a05:600c:4ca5:b0:4a0:6b:ade5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f12:b0:49f:ce78:356b with SMTP id 5b1f17b1804b1-49fe6700d0cmr271026815e9.28.1790617325440;
 Mon, 28 Sep 2026 10:42:05 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:21 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-15-smostafa@google.com>
Subject: [RFC PATCH 14/15] arm64: mm: Relax kernel stack alignment
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

On the kernel entry it was not possible to use the stack until it
was checked for overflow which was done by a clever trick relying
on aligning the kernel stack to double it's size, so if the
bit at THREAD_SHIFT was set it means that the stack pointer has
overflowed.

Now, we can easily switch the sp to sp_el1 which is the overflow
stack, push some registers and execute more complex flow.

Rework the kernel entry code to eliminate the tbnz check and the
alignment requirement.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/memory.h |  7 +--
 arch/arm64/kernel/entry.S       | 87 ++++++++++++++++++++++++++++-----
 2 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 93ce6ef65573..4545d9b39bd5 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -130,12 +130,7 @@
 
 #define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
 
-/*
- * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
- * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
- * assembly.
- */
-#define THREAD_ALIGN		(2 * THREAD_SIZE)
+#define THREAD_ALIGN		THREAD_SIZE
 
 #define IRQ_STACK_SIZE		THREAD_SIZE
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a31ef890a2ee..ea733b673970 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -62,15 +62,33 @@
 	sub	sp, sp, #PT_REGS_SIZE
 
 	/*
-	 * Test whether the SP has overflowed, without corrupting a GPR.
-	 * Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
-	 * should always be zero.
+	 * Test whether the SP has overflowed, using the overflow stack.
+	 * As we do not know if the CPU was in process or irq context, first
+	 * check against the task stack if that failed it means it might have
+	 * been an interrupt, so check against an interrupt stack, if both
+	 * failed it means that at least one of the stacks overflowed.
 	 */
-	add	sp, sp, x0			// sp' = sp + x0
-	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
-	tbnz	x0, #THREAD_SHIFT, __bad_stack
-	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
-	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
+	msr	spsel, #1
+	stp	x0, x1, [sp, #-16]!
+
+	mrs	x0, tpidrro_el0
+	ldr	x0, [x0, #TSK_STACK]
+	msr	spsel, #0
+	mov	x1, sp
+	msr	spsel, #1
+	sub	x1, x1, x0
+	cmp	x1, #THREAD_SIZE
+	b.lo	.Lstack_ok\@
+
+	/* Check whether we are on the IRQ, SDEI or EFI stacks. */
+	stp	x2, x30, [sp, #-16]!
+	bl	__check_ext_stacks
+	ldp	x2, x30, [sp], #16
+
+.Lstack_ok\@:
+	ldp	x0, x1, [sp], #16
+	msr	spsel, #0
+
 	b	el1t_\regsize\()_\label
 	.endm
 
@@ -528,13 +546,60 @@ SYM_CODE_START(vectors)
 	kernel_ventry	0, t, 32, error		// Error 32-bit EL0
 SYM_CODE_END(vectors)
 
+
+	.macro check_stack_overflow type, ptr, size
+	.ifc \type, percpu
+	ldr_this_cpu x1, \ptr, x0
+	.else
+	adr_l	x1, \ptr
+	ldr	x1, [x1]
+	.endif
+	cbz	x1, 1f
+	.ifc \type, top
+	sub	x1, x1, #\size
+	.endif
+	msr	spsel, #0
+	mov	x0, sp
+	msr	spsel, #1
+	sub	x0, x0, x1
+	cmp	x0, #\size
+	b.lo	2f
+1:
+	.endm
+
+SYM_CODE_START_LOCAL(__check_ext_stacks)
+	/* IRQ stack check */
+	check_stack_overflow percpu, irq_stack_ptr, IRQ_STACK_SIZE
+#ifdef CONFIG_ARM_SDE_INTERFACE
+	/* SDEI normal stack check */
+	check_stack_overflow percpu, sdei_stack_normal_ptr, IRQ_STACK_SIZE
+	/* SDEI critical stack check */
+	check_stack_overflow percpu, sdei_stack_critical_ptr, IRQ_STACK_SIZE
+#endif
+
+#ifdef CONFIG_EFI
+	/* EFI runtime stack check */
+	check_stack_overflow top, efi_rt_stack_top, THREAD_SIZE
+#endif
+
+	/* All checks failed => it's a real overflow */
+	ldp	x2, x30, [sp], #16
+	b	__bad_stack
+
+2:
+	/* A check succeeded => return to kernel_ventry */
+	ret
+SYM_CODE_END(__check_ext_stacks)
+
 SYM_CODE_START_LOCAL(__bad_stack)
 	/*
 	 * We detected an overflow in kernel_ventry.
-	 * Restore SP and X0.
+	 * Restore X0 and X1, and pop the overflow stack.
 	 */
-	sub	x0, sp, x0
-	sub	sp, sp, x0
+	ldp	x0, x1, [sp], #16
+
+	/* Restore SP_EL0 */
+	msr	spsel, #0
 	add	sp, sp, #PT_REGS_SIZE
 
 	/* Switch to the overflow stack */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

