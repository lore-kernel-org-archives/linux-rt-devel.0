Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087244;
	b=BnfO45KCgAJez3EoUeDnNRsx8m8Y5GNvKi2paXRIAM6KW1X6TiXAibwLWWd+n3eWClEs
	 Tg1Lmp3SKOuDu5CNicXpQ7FNvB3MGdOC6cFcaU0GX6p9fHi+P/Adk0UhwOs1+9Y+VHNBT
	 p6Mq0SjIh9ey9Nbcfmn4V/qJlchEdjJ0sDXL1NSnEzry37qgTm6rpFQfuQhArKxnuDyNp
	 /wPnx5Wtgjt2SFbr/QRGDNu7chcDsPvMwLVF8ZaqLF7kzU1n0wNgybQ6XUSvNIxTL14R6
	 PXQsqVojdMasXnU0vr6KOg0zBKddBvq49TqJg0bo0GoNahSEIE3GagBlVo9mBq0kqTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t18E7UE4PFJI3gidN0TaBJ4kzWBHAiAbXIwjPN/F3kE=;
	b=AV7aNiXsk+SDda80mV1R5wEOLVp24Jko7Wp4hw4ho8auJj2K8cPJIAvna+Xz+ek/cvjP
	 mdAXnDQZsgxYHQ4YQM3WMBQDo4NcJc46C5xRLdllq3qNG0F10O0qXiv9h7Deh5hSWOiFk
	 CDMThUFG22boGDJmN0ltkiF+AohHNAnPBnqnteD9mpVPspLTYRF0VCZafRphe7O7Pq0Fv
	 RtfvhmFU/NjRE2bfMwl+bc7XWdtQsTy5DV+LdtxIl2Du592HEqEdrixeASAfCiUGwFdaD
	 MnKiZr81wldgOPfFyZ9UvjTY87BzL0Xn/+3Ddcbw9wbe7bXI7EBcVyH6Pt6Sw+AuKhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ejeEoHnH;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F6606A31B
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 07:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 800F6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ejeEoHnH
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1757400c88.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793087242; x=1793692042; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t18E7UE4PFJI3gidN0TaBJ4kzWBHAiAbXIwjPN/F3kE=;
        b=ejeEoHnH6r1vfHNm5W5u/U31AQModKLIBioPbajyN/XG8CSMWYHfyFW/cOZKd0vQY1
         dEkNghhx/rvnusvyx8RBmwx1JRyelsASxJyPdog33fDOaa23BYF41JEv6SODJuMUPZIf
         W+uHMOW9liz+pXgOjuLhlnsppUv5FzLh2dSgiKPRodsWTgH0/HMUhcbWmIeIdgO99jJt
         j+7xGHFy/+jPx8+AVjbc3zFD8SgVEeUwMUakn9025gQijhQtMgkCRZ21j4HqwM0GDiy5
         SketQcbWLUhTKGUhRXJgmiAbdcawZVUp0z5SObx27H779PDKupuWDzoAqUNRAm+idlTc
         8bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087242; x=1793692042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t18E7UE4PFJI3gidN0TaBJ4kzWBHAiAbXIwjPN/F3kE=;
        b=0LWHACALpUS/bNxe+frpmqdffcLLA02jIjsQrJe9dP5UzlPrb1anmvIvOYzeNREZBW
         JxP16N6SRUo8gf4Gg64/C85vpsjmUiyF8A/j1m++mr3EozvXY1gsfkDW8jZ22Md8gvPP
         W/fk/P8xOKG9q5DZZxpBQMGCNYD/XbGEkotuV7ApUtwslPkg98hMU4128joGTr/niaaU
         q+Fwu+kkU212MBvdVJuUtuIoyNUvZp+hyVlBCNZpvnICxjKTUBZ8ht/8PP5Wy9nfOu8P
         9Xb+uc1M7ZaOMo4tqqFWH//69xJxEZQlWD5RoVL1DvngAASF15R0GSYWYcB/BHUNKQfX
         rVFA==
X-Forwarded-Encrypted: i=1; AKwUvBwxsHQOMmMmEWcJDKAyvMUG4fC5Yo0019qEMIG0bROkRm8g3RPpinuCPC13d+hiz//yOmDWeVeD17D+4De3Ng==@lists.linux.dev
X-Gm-Message-State: AFq9FYKMtnGtGuqjGnrwWcg3+4fLc0FoUf3fexWgi16+6UYjeLI+LLa7
	zIb7yj+cx0hgSyPFK5LrmYPsMgD8G0OVNo61MnLFhEH8pxmCuwntRtG8
X-Gm-Gg: AYBFou0pywC0zM8mBwb4CcBFNqsIE7PkaQZJyozgmEgXFVOm3gGKE/k8T/UKTFSxC1N
	tYgIrfYQeyt3TqKHZuyUlhI0wnk6pVbrECLNWjtqYC7Kx9dQW8KvtZ4w/J615u0ecA0ZFA08sjf
	+PmK61OcybMmzaDaZMHrebYPE1PBCJX/BaOBn7jvKifl8wozsqw+VLL2Nc57OwWETVsoezVx8bw
	QqFBvhbUtsx2jAaBsvtueE/UPABqXM9fXbdsZvoLnw9vW2V7JRexexTlFm7gSQaMU9DOmUlY9tX
	khNGFb3XZzNhaO7LbCpp3C+ws4AdeGXT+Aad5y6dVxXFzPHuz9xRjXEM9nQz3E2o/tq1xirLUVZ
	OO91+NvY6NW5RpKmKHOqbWobAPrpg2Fo/wLJenFfdN26v+KEOgiKDujK0pXkjCMjhtiUtmyo0G8
	Fvta6+eaQvl6VQEaexS7hqqJyM7WQ62HyP/GSH7vZ0PBk2qTFmDRx7sOzU6mENPRmYfc2E9PAKm
	71muVr2ZgEMlbWWyhJJA1JTv0n56MiNAUdxRQOwKK2pxmJ4e/MQiAGLjbKunoqNZYzW6lo3FxBq
	RrkR1GRHmsVkvD7zFQ4KEKvRuyuInes=
X-Received: by 2002:a05:7022:1508:b0:195:49ee:94c7 with SMTP id a92af1059eb24-19934a926ecmr14662254c88.8.1793087242216;
        Tue, 27 Oct 2026 00:47:22 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0e8d700sm36526698c88.10.2026.10.27.00.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:47:21 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	mkchauras@gmail.com,
	msuchanek@suse.de,
	bwiedemann@suse.de,
	ryan.roberts@arm.com,
	mchauras@linux.ibm.com,
	agordeev@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH V2] powerpc: Support for generic TIF bits
Date: Tue, 27 Oct 2026 13:17:10 +0530
Message-ID: <20261027074710.129819-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.56.0
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

powerpc already uses GENERIC_ENTRY for the irq entry/exit path.  That
means the generic entry code handles all the arch-independent
thread_info flags (TIF_SIGPENDING, TIF_NOTIFY_RESUME, TIF_NOTIFY_SIGNAL,
TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY, TIF_UPROBE, TIF_PATCH_PENDING,
TIF_MEMDIE, TIF_RSEQ, TIF_HRTIMER_REARM, TIF_USER_RETURN_NOTIFY) on
behalf of the arch.  The only remaining blocker was that powerpc defined
its own bit numbers for those flags, which conflicted with the layout
required by the common header include/asm-generic/thread_info_tif.h.

This patch selects HAVE_GENERIC_TIF_BITS and switches powerpc's
thread_info.h over to include <asm-generic/thread_info_tif.h> for the
arch-independent bits, using HAVE_TIF_NEED_RESCHED_LAZY to opt in to
the lazy-preemption flag.  The powerpc-private bits (TIF_RESTORE_TM,
TIF_SINGLESTEP, TIF_RESTOREALL, TIF_NOERROR, TIF_EMULATE_STACK_STORE,
TIF_ELF2ABI, TIF_POLLING_NRFLAG, TIF_32BIT, TIF_SYSCALL_RET) are
renumbered to start at bit 16, which is the reserved range for arch use.

Enabling HAVE_GENERIC_TIF_BITS unlocks the following features that were
previously unavailable on powerpc because their Kconfig dependencies
could not be satisfied:

  1. RSEQ_SLICE_EXTENSION (CONFIG_RSEQ_SLICE_EXTENSION)
     Allows userspace to register an RSEQ critical section and request
     a limited time-slice extension when the task is about to be
     preempted.  The kernel grants the extension (via the RSEQ shared
     data ABI) so the critical section can complete, avoiding the
     thundering-herd problem where many threads spin on the same
     lock/resource after a preemption.  This feature requires a
     dedicated TIF_RSEQ bit, which only exists when HAVE_GENERIC_TIF_BITS
     is set.  Depends on: RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY &&
     HAVE_GENERIC_TIF_BITS.

  2. HRTIMER_REARM_DEFERRED (CONFIG_HRTIMER_REARM_DEFERRED)
     Defers re-arming of the hrtimer interrupt to the return-to-user
     path, using the dedicated TIF_HRTIMER_REARM bit.  This avoids
     redundant hrtimer_interrupt() invocations within the same tick
     period and reduces latency jitter for high-resolution timer users
     (e.g., PREEMPT_RT workloads, audio, real-time tasks).  Depends on:
     GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS && HIGH_RES_TIMERS &&
     SCHED_HRTICK.

  3. Dedicated TIF_RSEQ flag (fast-path RSEQ handling)
     Without HAVE_GENERIC_TIF_BITS, TIF_RSEQ falls back to aliasing
     TIF_NOTIFY_RESUME, forcing the generic entry slow-path to run on
     every return-to-user for all RSEQ-registered threads.  With the
     dedicated bit, the fast path can skip RSEQ work unless the flag
     is actually set, reducing overhead in the common case.

  4. TIF_USER_RETURN_NOTIFY
     The generic bit for the user-return-notifier subsystem
     (kernel/user-return-notifier.c).  Used by KVM on x86 to lazily
     restore guest MSRs; having the generic bit available means future
     powerpc KVM work can use the same infrastructure.

The arch-specific bits that do not exist in the generic header retain
their private numbering in the powerpc-reserved range (bits 16+), so
no existing powerpc functionality is affected.

Tested on powerpc (POWER11 pSeries CONFIG_RSEQ=y +
CONFIG_RSEQ_SLICE_EXTENSION=y + CONFIG_HRTIMER_REARM_DEFERRED=y):

  * tools/testing/selftests/rseq/ -- all tests pass (basic_test,
    param_test, basic_percpu_ops_test, syscall_errors_test,
    slice_test via run_timeslice_test.sh)
  * tools/testing/selftests/timers/hrtimer-rearm.sh -- deferred=1
    events observed; no new dmesg warnings
  * Boot and basic workload testing shows no regression

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
This patch is applicabe over
https://lore.kernel.org/all/961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de/

Changelog:

V1 -> V2:
 - Commit message updated
V1: https://lore.kernel.org/all/20261021144453.232372-2-mkchauras@gmail.com/

 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/thread_info.h | 36 +++++++++-----------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7f7910f38a67..e5527b56159a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -255,6 +255,7 @@ config PPC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
 	select HAVE_GCC_PLUGINS
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 4b7ec1db3034..4df3f4b5bd56 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -93,44 +93,32 @@ void arch_setup_new_exec(void);
 
 #endif /* __ASSEMBLER__ */
 
+#define HAVE_TIF_NEED_RESCHED_LAZY
+
+#include <asm-generic/thread_info_tif.h>
 /*
  * thread information flag bit numbers
  */
-#define TIF_SIGPENDING		1	/* signal pending */
-#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
-#define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
-#define TIF_PATCH_PENDING	6	/* pending live patching update */
-#define TIF_SINGLESTEP		8	/* singlestepping active */
-#define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
-#define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
-#define TIF_NOERROR		12	/* Force successful syscall return */
-#define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
-#define TIF_UPROBE		14	/* breakpointed or single-stepping */
-#define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
+#define TIF_RESTORE_TM		16	/* need to restore TM FP/VEC/VSX */
+#define TIF_SINGLESTEP		17	/* singlestepping active */
+#define TIF_RESTOREALL		18	/* Restore all regs (implies NOERROR) */
+#define TIF_NOERROR		19	/* Force successful syscall return */
+#define TIF_EMULATE_STACK_STORE	20	/* Is an instruction emulation
 						for stack store? */
-#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
 #if defined(CONFIG_PPC64)
-#define TIF_ELF2ABI		18	/* function descriptors must die! */
+#define TIF_ELF2ABI		21	/* function descriptors must die! */
 #endif
-#define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
-#define TIF_32BIT		20	/* 32 bit binary */
-#define TIF_SYSCALL_RET		21	/* syscall error value set */
+#define TIF_POLLING_NRFLAG	22	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_32BIT		23	/* 32 bit binary */
+#define TIF_SYSCALL_RET		24	/* syscall error value set */
 
 /* as above, but as bit values */
-#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
-#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
-#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
-#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
-#define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-- 
2.56.0

