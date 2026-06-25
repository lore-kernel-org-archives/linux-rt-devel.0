Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F9388E69
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379814; cv=none; b=Jb13upozsDegRkVlFOow04ACZXkNZVe8mx+Pnzg0lUESru+iI9oqT4TXJ9ElVwv7mMbLOGpqWeQGtoYM9569BrcKz1WQu2MAYo4GsZUopMWdGhC2HF1RSpvkMvQFNw4nbIxl9xSQgYwd7AS1JgEpyvK7aaP+Rc0X168YIzoENaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379814; c=relaxed/simple;
	bh=TwMs+oYNaRMRd7Pb/e+Z1vE1erd4NlISUb6M3vMIjow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgeaLqeuacSYB1XaUs/mylYYcnoM2aa2G6CynA4JhZ4p9cCTyrxK9PkNVjDGdASim/hCThFbU/NMiqUaCBdgGMw/iC8QKz6Xx+411UiTQG8b+7w8NL5duINMlOhKJzMZqcBHl+ols7E7lk4zJze4J6BWgEjP1xZFjzXp+ToFMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCnuEUZF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOi/VdsR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCnuEUZF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOi/VdsR"
Date: Thu, 25 Jun 2026 11:30:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782379809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q53xKpSeJmpDx2AZ7+6vHYsZS2WekXI5H2SqxBWvloE=;
	b=rCnuEUZF8UFoIohoD8fIAgrFXP2+jZXhLGcomVa8zlnEyxpXIi99giPPBs6w/eYsyF8MDs
	RspfZHVnH1QrEsLdD7mhQTMrq8y8iKAjQxGS3QFmi7dcI+nGiRnQl6d2baIrtQU+EH6Bhx
	DrfwwyScEYF/koYYrAPF9vvvMHYUPnqqm0IzxYX5LneYyL4NF36oTyAKiRoFvD2bNzrPfX
	U003hWovc4hGhKsn9P0bzB6wlBKGjCEY4S1RCzLyqP3Sj0iI4eRjtct1wG0urskJQJOlQP
	giosOdOMVSVLNIxwj24hnzhiByymGmKaGmIyajoAiq7PLdsCzpV6ytmGnLqu+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782379809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q53xKpSeJmpDx2AZ7+6vHYsZS2WekXI5H2SqxBWvloE=;
	b=gOi/VdsRNjFKskHjwR2aPN1e3v9sUIJdMRHJohk5anvzfSLntMokBkfPdrSWQLeLZjqjVl
	a3DLrWSNt4bqMgBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <20260625093008.e5I4bh-_@linutronix.de>
References: <20260625073522.182503-1-xieyuanbin1@huawei.com>
 <20260625085034.tvyGSmaP@linutronix.de>
 <ajzvcCve4LubjH9J@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajzvcCve4LubjH9J@shell.armlinux.org.uk>

On 2026-06-25 10:05:52 [+0100], Russell King wrote:
> > for this but actual breakpoint handling might be broken or is it just
> > me? But then your stack trace looks like mine so :/
> 
> ARM Linux doesn't use BKPT. BKPT was an instruction introduced by Arm
> Ltd in ARMv5TE. Prior to this, we use a UDF instruction instead (we
> had to pick something!) and gdb and other tools use that as a
> breapoint.
> 
> Moreover, BKPT isn't guaranteed to trap to the kernel, especially when
> there is a hardware debugger connected. In that case, DDI0100E states
> that use of BKPT must be according to the instructions provided with
> the hardware debugger. This makes BKPT unsuitable for use.

So you are saying this:

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e62cc4be5adf6..11ac69113eca2 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -595,6 +595,16 @@ do_bad(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 1;
 }
 
+static int do_debug_event(unsigned long addr, unsigned int fsr,
+			  struct pt_regs *regs)
+{
+	if (!user_mode(regs))
+		return 1;
+	local_irq_enable();
+	ptrace_break(regs);
+	return 0;
+}
+
 struct fsr_info {
 	int	(*fn)(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 	int	sig;
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index f2be95197265d..bfd718f64020c 100644
--- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -46,7 +46,7 @@ static struct fsr_info fsr_info[] = {
 static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 0"			   },
 	{ do_bad,		SIGBUS,  0,		"unknown 1"			   },
-	{ do_bad,		SIGBUS,  0,		"debug event"			   },
+	{ do_debug_event,	SIGBUS,  0,		"debug event"			   },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"section access flag fault"	   },
 	{ do_bad,		SIGBUS,  0,		"unknown 4"			   },
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"	   },
diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
index d0ae2963656a6..96c1d45d20d9e 100644
--- a/arch/arm/mm/fsr-3level.c
+++ b/arch/arm/mm/fsr-3level.c
@@ -34,7 +34,7 @@ static struct fsr_info fsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
 	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
 	{ do_bad,		SIGBUS,  BUS_ADRALN,	"alignment fault"		},
-	{ do_bad,		SIGBUS,  0,		"debug event"			},
+	{ do_debug_event,	SIGBUS,  0,		"debug event"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 35"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 36"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 37"			},

is not worth doing it? With this I can my little testcase working.

> Consequently, ARM Linux has not supported the use of BKPT - no code
> was added to support this instruction, hence why the kernel prints an
> Alert level message stating that the fault was unhandled.
> 
> In addition, when a hardware debugger is not being used, with the
> addition of hw_breakpoint.c, what userland sees in response depends on
> kernel configuration. If hw_breakpoint.c is not built (when PERF_EVENTS
> is disabled), then a SIGBUS signal will be raised. If it is built, and
> prior to a recent commit by LinusW, it will raise a SIGTRAP. After
> LinusW's commit, it won't raise a signal, but userspace will spin on
> the BKPT instruction.
> 
> The path we go through in the above case is very much an "oh damn,
> we aren't handling this exception, let's try to do something that
> might save the day".

Okay.

> Rather than throwing local_irq_enable() in random places, it would
> be better to do it earlier, but I would want to review what x86 does
> when it gets an exception that the kernel doesn't handle - not sure
> when I'll get around to doing that though.

That would be exc_int3() from arch/x86/kernel/traps.c.
Besides doing "notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);"

it does cond_local_irq_enable() which enables the interrupts if they
were enabled by the "caller", sends the signal (SIGTRAP).

Sebastian
