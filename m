Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100281;
	b=QjoVpwEvXjNy/90GeZHcfxSlAINhRMRUK1NuTnJOKU28JYKRpHHTBGO56S7RL2ZXVLiW
	 eh3/u/nTox1fguJUtLPG4dGmMdNBEJ6ghHKnyc3tEc5bNe/Stpe7yySGTURsCQR1renwz
	 LCOwt/8BNIKexubHBCUr+a2VY/aqV0rgw8iXbV80eqeqX0N/cYkxTG1s5M2SOF0PfYkY1
	 3N+tkAbeYqOaqprcsSM6jGEwkD7OaSUKvbF7gc3CCVNxnnNq42C+FfWQ1QYbiZYfOP7x3
	 iWCanlLgU52qsSy74DQ6GpI3Sp5X0KCCEC0THH/10pqXFGNZddtt+x21McY4+bkD4OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100281;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=1i9hP6J5LKM8a8cZzhOSGZzBGh1WAxZue5Ur85XvP1Y=;
	b=eKH4M0si6aiUlSzyYzlmRMOZHuV96Sho5BeQFZgaM/LVHEiQJA3P/iE94z/AmJKsHkhk
	 a1hhXaPN0FSWYYywfNappIgrrwe7G4w3v/SrxAHGzkOXSG9PBQacbQ9oysRO+yRJhwVah
	 +CS2mYVNFqOiPVy3m4+6U1ZDkg6D+ojsruw1bDhVc1IQh6B2AFjV6YTo6j5lw/ct6zqtr
	 xb5UnZKaUP9T8a471BkkLOgCp01KuiV45U0afzXc69rjZPFJtqqQrsfxDiqmORyd5s91s
	 RYhCUwHTh4xjsCw3ODSti7dBT7PDjtu6gIRxNQ/bhQV8VVBRfcykaoHKpTXTwtj+nyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YUObQlHy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Y65vrD6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YUObQlHy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Y65vrD6;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0E606A31D
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 11:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C0E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YUObQlHy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Y65vrD6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YUObQlHy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Y65vrD6
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B17F1F7D3;
	Tue, 27 Oct 2026 11:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793100278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1i9hP6J5LKM8a8cZzhOSGZzBGh1WAxZue5Ur85XvP1Y=;
	b=YUObQlHyVGGm9jIM3EI2vZ5eHmF1ymCpRuw7FnI3M3L4emb+FhuqkhXyb7pSvT6/cp+v9A
	EUMa/AXdlqZXdtsrfaL1w59mCZjWJ2M3Vng5YINFwVPaYR4oqZ09AdqFqakHWUN/6xM7cS
	bM42ezw4sF/X01s2cMNzstoWP+UdNjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793100278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1i9hP6J5LKM8a8cZzhOSGZzBGh1WAxZue5Ur85XvP1Y=;
	b=4Y65vrD6+E9FriitCJAU81+uMqwuWiN/Ex+kCPZn07UGV5JJzneO9n2i3UTzlPzEkakOnL
	+OefCZaIOrdMiKAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YUObQlHy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4Y65vrD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793100278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1i9hP6J5LKM8a8cZzhOSGZzBGh1WAxZue5Ur85XvP1Y=;
	b=YUObQlHyVGGm9jIM3EI2vZ5eHmF1ymCpRuw7FnI3M3L4emb+FhuqkhXyb7pSvT6/cp+v9A
	EUMa/AXdlqZXdtsrfaL1w59mCZjWJ2M3Vng5YINFwVPaYR4oqZ09AdqFqakHWUN/6xM7cS
	bM42ezw4sF/X01s2cMNzstoWP+UdNjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793100278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1i9hP6J5LKM8a8cZzhOSGZzBGh1WAxZue5Ur85XvP1Y=;
	b=4Y65vrD6+E9FriitCJAU81+uMqwuWiN/Ex+kCPZn07UGV5JJzneO9n2i3UTzlPzEkakOnL
	+OefCZaIOrdMiKAA==
Date: Tue, 27 Oct 2026 12:24:37 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	bwiedemann@suse.de, ryan.roberts@arm.com, mchauras@linux.ibm.com,
	agordeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH V2] powerpc: Support for generic TIF bits
Message-ID: <auCJ9ZDlTpHlnyTi@kunlun.suse.cz>
References: <20261027074710.129819-1-mkchauras@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027074710.129819-1-mkchauras@gmail.com>
X-Spamd-Result: default: False [-6.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linutronix.de,goodmis.org,suse.de,arm.com,lists.ozlabs.org,vger.kernel.org,lists.linux.dev];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -6.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 1B17F1F7D3

Hello,

what is the interaction with
https://lore.kernel.org/linuxppc-dev/f6c831c95f1171e0b82353e611485231482f3deb.1791975972.git.msuchanek@suse.de/

Does it supersede this patch or should it be added on top of it?

Also does this one need the first patch of that series?

Thanks

Michal

On Tue, Oct 27, 2026 at 01:17:10PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> powerpc already uses GENERIC_ENTRY for the irq entry/exit path.  That
> means the generic entry code handles all the arch-independent
> thread_info flags (TIF_SIGPENDING, TIF_NOTIFY_RESUME, TIF_NOTIFY_SIGNAL,
> TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY, TIF_UPROBE, TIF_PATCH_PENDING,
> TIF_MEMDIE, TIF_RSEQ, TIF_HRTIMER_REARM, TIF_USER_RETURN_NOTIFY) on
> behalf of the arch.  The only remaining blocker was that powerpc defined
> its own bit numbers for those flags, which conflicted with the layout
> required by the common header include/asm-generic/thread_info_tif.h.
> 
> This patch selects HAVE_GENERIC_TIF_BITS and switches powerpc's
> thread_info.h over to include <asm-generic/thread_info_tif.h> for the
> arch-independent bits, using HAVE_TIF_NEED_RESCHED_LAZY to opt in to
> the lazy-preemption flag.  The powerpc-private bits (TIF_RESTORE_TM,
> TIF_SINGLESTEP, TIF_RESTOREALL, TIF_NOERROR, TIF_EMULATE_STACK_STORE,
> TIF_ELF2ABI, TIF_POLLING_NRFLAG, TIF_32BIT, TIF_SYSCALL_RET) are
> renumbered to start at bit 16, which is the reserved range for arch use.
> 
> Enabling HAVE_GENERIC_TIF_BITS unlocks the following features that were
> previously unavailable on powerpc because their Kconfig dependencies
> could not be satisfied:
> 
>   1. RSEQ_SLICE_EXTENSION (CONFIG_RSEQ_SLICE_EXTENSION)
>      Allows userspace to register an RSEQ critical section and request
>      a limited time-slice extension when the task is about to be
>      preempted.  The kernel grants the extension (via the RSEQ shared
>      data ABI) so the critical section can complete, avoiding the
>      thundering-herd problem where many threads spin on the same
>      lock/resource after a preemption.  This feature requires a
>      dedicated TIF_RSEQ bit, which only exists when HAVE_GENERIC_TIF_BITS
>      is set.  Depends on: RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY &&
>      HAVE_GENERIC_TIF_BITS.
> 
>   2. HRTIMER_REARM_DEFERRED (CONFIG_HRTIMER_REARM_DEFERRED)
>      Defers re-arming of the hrtimer interrupt to the return-to-user
>      path, using the dedicated TIF_HRTIMER_REARM bit.  This avoids
>      redundant hrtimer_interrupt() invocations within the same tick
>      period and reduces latency jitter for high-resolution timer users
>      (e.g., PREEMPT_RT workloads, audio, real-time tasks).  Depends on:
>      GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS && HIGH_RES_TIMERS &&
>      SCHED_HRTICK.
> 
>   3. Dedicated TIF_RSEQ flag (fast-path RSEQ handling)
>      Without HAVE_GENERIC_TIF_BITS, TIF_RSEQ falls back to aliasing
>      TIF_NOTIFY_RESUME, forcing the generic entry slow-path to run on
>      every return-to-user for all RSEQ-registered threads.  With the
>      dedicated bit, the fast path can skip RSEQ work unless the flag
>      is actually set, reducing overhead in the common case.
> 
>   4. TIF_USER_RETURN_NOTIFY
>      The generic bit for the user-return-notifier subsystem
>      (kernel/user-return-notifier.c).  Used by KVM on x86 to lazily
>      restore guest MSRs; having the generic bit available means future
>      powerpc KVM work can use the same infrastructure.
> 
> The arch-specific bits that do not exist in the generic header retain
> their private numbering in the powerpc-reserved range (bits 16+), so
> no existing powerpc functionality is affected.
> 
> Tested on powerpc (POWER11 pSeries CONFIG_RSEQ=y +
> CONFIG_RSEQ_SLICE_EXTENSION=y + CONFIG_HRTIMER_REARM_DEFERRED=y):
> 
>   * tools/testing/selftests/rseq/ -- all tests pass (basic_test,
>     param_test, basic_percpu_ops_test, syscall_errors_test,
>     slice_test via run_timeslice_test.sh)
>   * tools/testing/selftests/timers/hrtimer-rearm.sh -- deferred=1
>     events observed; no new dmesg warnings
>   * Boot and basic workload testing shows no regression
> 
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> This patch is applicabe over
> https://lore.kernel.org/all/961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de/
> 
> Changelog:
> 
> V1 -> V2:
>  - Commit message updated
> V1: https://lore.kernel.org/all/20261021144453.232372-2-mkchauras@gmail.com/
> 
>  arch/powerpc/Kconfig                   |  1 +
>  arch/powerpc/include/asm/thread_info.h | 36 +++++++++-----------------
>  2 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 7f7910f38a67..e5527b56159a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -255,6 +255,7 @@ config PPC
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
>  	select HAVE_GCC_PLUGINS
> +	select HAVE_GENERIC_TIF_BITS
>  	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
>  	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>  	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 4b7ec1db3034..4df3f4b5bd56 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -93,44 +93,32 @@ void arch_setup_new_exec(void);
>  
>  #endif /* __ASSEMBLER__ */
>  
> +#define HAVE_TIF_NEED_RESCHED_LAZY
> +
> +#include <asm-generic/thread_info_tif.h>
>  /*
>   * thread information flag bit numbers
>   */
> -#define TIF_SIGPENDING		1	/* signal pending */
> -#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
> -#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
> -#define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
> -#define TIF_PATCH_PENDING	6	/* pending live patching update */
> -#define TIF_SINGLESTEP		8	/* singlestepping active */
> -#define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
> -#define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
> -#define TIF_NOERROR		12	/* Force successful syscall return */
> -#define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
> -#define TIF_UPROBE		14	/* breakpointed or single-stepping */
> -#define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
> +#define TIF_RESTORE_TM		16	/* need to restore TM FP/VEC/VSX */
> +#define TIF_SINGLESTEP		17	/* singlestepping active */
> +#define TIF_RESTOREALL		18	/* Restore all regs (implies NOERROR) */
> +#define TIF_NOERROR		19	/* Force successful syscall return */
> +#define TIF_EMULATE_STACK_STORE	20	/* Is an instruction emulation
>  						for stack store? */
> -#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
>  #if defined(CONFIG_PPC64)
> -#define TIF_ELF2ABI		18	/* function descriptors must die! */
> +#define TIF_ELF2ABI		21	/* function descriptors must die! */
>  #endif
> -#define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
> -#define TIF_32BIT		20	/* 32 bit binary */
> -#define TIF_SYSCALL_RET		21	/* syscall error value set */
> +#define TIF_POLLING_NRFLAG	22	/* true if poll_idle() is polling TIF_NEED_RESCHED */
> +#define TIF_32BIT		23	/* 32 bit binary */
> +#define TIF_SYSCALL_RET		24	/* syscall error value set */
>  
>  /* as above, but as bit values */
> -#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
> -#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
> -#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
> -#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
>  #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
>  #define _TIF_32BIT		(1<<TIF_32BIT)
>  #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
> -#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
>  #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
>  #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
>  #define _TIF_NOERROR		(1<<TIF_NOERROR)
> -#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
> -#define _TIF_UPROBE		(1<<TIF_UPROBE)
>  #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
>  
>  #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
> -- 
> 2.56.0
> 
> 
