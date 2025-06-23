Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20859225A47
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Jun 2025 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717043; cv=none; b=sb4CaWhadpUCQS0YfH11i21W/H72Skj8WJFzSJOZsTrOPyU1j3FjO9YOa+KimHp1p629ucHv0o3BGhGqsbgChhTJ8oYVxhw8JT4aefl3CzrV1dMo8aZGEW0i1JeHGgpKWuGvJ0Lip6hYHPAHoykkknkY1VfX3reXljT/Gb2LpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717043; c=relaxed/simple;
	bh=MhgGBIYNOOygKR4AR/fb3TJ06syiq6M62XCFqXquIVM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ckn73lcQqwYZkmC5CYgNYnXWNguiB7rdoXuZ2BcWSopdC9jHliAbf3PeyG9aHQGWDvTpZavNRkpGU0cFksRYGLpXfJIqkG/Ynjj+GcICBUQE9t7x3pcJke8VCWtFyild389kfu2Es153emT0QPIHn4IJ+M4SwkR4lZXOrBrbieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Fg3ftNtD; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Fg3ftNtD"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so5555356a12.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 23 Jun 2025 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1750717040; x=1751321840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwALQ0/M99GpNXm649yfXIYpBjTO5FIrE5mdkDBYsC4=;
        b=Fg3ftNtDexur1YCmIn5ZqdcG8nS0VRCwvj5rUhXHN2bFG6WJyUbKNtMtvEJclaDMOT
         F7mgpgituV8MZW0woTFINS7TROGEo26Qz5AjgnC1t5TWFCL04Q5w16iUMGUf1Tb+rhHJ
         j9k1E65Roj95bWeKNLU18gY/Andfu3TMdg91JDtm9TX4WshJwTfkocSAQ10Z3r6s5Cnm
         dUOkplmx1yNTfqBU+LU4opREqkGfd27c+d4YzbfK0JJSKWPGz6do3uM9l+oKykq4ttdQ
         JHRwTLX2GK7e4C540sg5N7t/hKYDSaERjMvaV8/jKk2isNscCndPqORD6vKiA+gsf8J6
         yWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717040; x=1751321840;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwALQ0/M99GpNXm649yfXIYpBjTO5FIrE5mdkDBYsC4=;
        b=fePccUCFBxxoyJmTcwmlSWPNkOEsjAyhRqbvpF8OjwrvQ4LFYQjlfRPWgj3AKogr8U
         rnxwHhm+6hQWteIFJjXNUfB7Tv1pv+MwwOVur7I3sbydWCBWDIp7V5L9ZMXQ/nHCchwx
         B0kWIEVxWQdH7lICsS9V3fO6Fo6p9IqUoQsILWET2oI6eeImsZH8M+mgPBg2YKhZsYK7
         IM2LtvmH24GakE/Jlt9pIsiKNB5qNzTo9Knlkl7rlsG74Z8PBeS6tLrFHMSqpDbtk02O
         OPdtOinBzRizN8HIF7AsPKduxXXED5EYPx+aLwlc1ZQl6Z9keEQsmnU78GhTMAvCBHFy
         gubg==
X-Forwarded-Encrypted: i=1; AJvYcCU+UZZe88Q08CTkHISH9QN9QuZAgs/YTLUAen2C1F14KwzbMoc3Maiwo2BUXInz2Lr+ckFE+/GV5wfVMv0pCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs2tqrk3pSHhidkG4dKf95CgjJ2ZGRWGQQ9lx1mPEmASYh4xx6
	PiIsj/rgLfquPeu6Ktn4qsQhowSh3z/Wym5XyQ6UVFfQkEOgHDxfp6roi+5XLSgbzM4=
X-Gm-Gg: ASbGncvwjv32wgj6AGxCoAChX88rohPe+ue8JEgDftytIJGlqt17yqn0NFWh4mf3CQ2
	gWrvQ15y+JXUjVPBDiX1v3PuQnBa1QgXz0ocumrzTWwtqvOEDhlJ5CNHhWsZ1rm08ddzJ4nAfHs
	GaL9GESozoeBDjkL3B3b0gn3xVBrkKrTQMMxv8LvDu6bGlA6J/xwNcIkIoPqjZYbNgEIzOyJEaf
	b4JKBihe7zuSSuJ+nC0okyhvY9qBkSYvvlFoGPxAd8R5TekIlyHuv+lkvJ+UKCJmISGmlIqIpLy
	98JwdmO6O2gASlz5PMKkfiWG1ITtdIAx/sopY5XqaSX3Kx/Aab3FAsNbhfOf+DwSnjggkiw=
X-Google-Smtp-Source: AGHT+IElt6M7x8aXRpogAoTHdWeL/Uqxi5GNVPzJBQouv9xg34gl6XJEz0EoG9yvqb/nuTqJZTpptA==
X-Received: by 2002:a17:90b:4e83:b0:313:f9f6:309f with SMTP id 98e67ed59e1d1-3159d8f998cmr18402246a91.34.1750717040272;
        Mon, 23 Jun 2025 15:17:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:8d10])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d839332bsm92675595ad.40.2025.06.23.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:17:19 -0700 (PDT)
Date: Mon, 23 Jun 2025 15:17:19 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jun 2025 15:17:17 PDT (-0700)
Subject:     Re: [PATCH] riscv: Enable interrupt during exception handling
In-Reply-To: <20250620114346.1740512-1-namcao@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  Alexandre Ghiti <alex@ghiti.fr>, bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
  linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  namcao@linutronix.de
From: Palmer Dabbelt <palmer@dabbelt.com>
To: namcao@linutronix.de
Message-ID: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 04:43:46 PDT (-0700), namcao@linutronix.de wrote:
> force_sig_fault() takes a spinlock, which is a sleeping lock with
> CONFIG_PREEMPT_RT=y. However, exception handling calls force_sig_fault()
> with interrupt disabled, causing a sleeping in atomic context warning.
>
> This can be reproduced using userspace programs such as:
>     int main() { asm ("ebreak"); }
> or
>     int main() { asm ("unimp"); }
>
> There is no reason that interrupt must be disabled during exception
> handling.

Looks like they used to and we lost it as of f0bddf50586d ("riscv: 
entry: Convert to generic entry"), where we'd check the PIE bit and 
quickly re-enable interrupts if they were enabled before.

This way of doing it also seems fine, and it's kind of nice that we can 
just read the code to figure out how the interrupt contexts are managed.  
So I think it's fine to keep it this way, even though it's more code.

I'm kind of split on a Fixes tag here.  One could argue it's a 
regression, as having interrupts disabled during exceptions is going to 
cause all sorts of performance issues for users.  Seems a bit risk to 
just backport, though...

That said, if nobody noticed then it's probably a good sign nobody is 
really paying attention and we should just backport it before anyone 
notices...

> Considering the previous struggle with a similar bug [1][2], fix
> this problem once for all by enabling interrupt during exception handling
> whenever possible:
>   - If exception comes from user (interrupt handling was for sure enabled)
>   - If exception comes from kernel and interrupt handling was enabled
>
> This also has the added benefit of avoiding unnecessary delays in interrupt
> handling.
>
> This patch mimics x86's implementation.
>
> Link: https://lore.kernel.org/linux-riscv/20250411073850.3699180-3-nylon.chen@sifive.com [1]
> Link: https://lore.kernel.org/linux-riscv/20250422162324.956065-3-cleger@rivosinc.com [2]
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/riscv/kernel/traps.c | 36 ++++++++++++++++++++++++++++++------
>  arch/riscv/mm/fault.c     |  4 ----
>  2 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 9c83848797a78..f7d2372dc0eb6 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -6,6 +6,7 @@
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/irqflags.h>
>  #include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
> @@ -72,6 +73,18 @@ static void dump_instr(const char *loglvl, struct pt_regs *regs)
>  	printk("%sCode: %s\n", loglvl, str);
>  }
>  
> +static void cond_local_irq_enable(struct pt_regs *regs)
> +{
> +	if (!regs_irqs_disabled(regs))
> +		local_irq_enable();
> +}
> +
> +static void cond_local_irq_disable(struct pt_regs *regs)
> +{
> +	if (!regs_irqs_disabled(regs))
> +		local_irq_disable();
> +}
> +
>  void die(struct pt_regs *regs, const char *str)
>  {
>  	static int die_counter;
> @@ -151,11 +164,15 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
>  {										\
>  	if (user_mode(regs)) {							\
>  		irqentry_enter_from_user_mode(regs);				\
> +		local_irq_enable();						\
>  		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
> +		local_irq_disable();						\
>  		irqentry_exit_to_user_mode(regs);				\
>  	} else {								\
>  		irqentry_state_t state = irqentry_nmi_enter(regs);		\
> +		cond_local_irq_enable(regs);					\
>  		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
> +		cond_local_irq_disable(regs);					\
>  		irqentry_nmi_exit(regs, state);					\
>  	}									\
>  }
> @@ -173,24 +190,23 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>  
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> -
>  		local_irq_enable();
>  
>  		handled = riscv_v_first_use_handler(regs);
> -
> -		local_irq_disable();
> -
>  		if (!handled)
>  			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
>  				      "Oops - illegal instruction");
>  
> +		local_irq_disable();
>  		irqentry_exit_to_user_mode(regs);
>  	} else {
>  		irqentry_state_t state = irqentry_nmi_enter(regs);
> +		cond_local_irq_enable(regs);
>  
>  		do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
>  			      "Oops - illegal instruction");
>  
> +		cond_local_irq_disable(regs);
>  		irqentry_nmi_exit(regs, state);
>  	}
>  }
> @@ -225,6 +241,7 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
>  		local_irq_enable();
>  	} else {
>  		state = irqentry_nmi_enter(regs);
> +		cond_local_irq_enable(regs);
>  	}
>  
>  	if (misaligned_handler[type].handler(regs))
> @@ -235,6 +252,7 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
>  		local_irq_disable();
>  		irqentry_exit_to_user_mode(regs);
>  	} else {
> +		cond_local_irq_disable(regs);
>  		irqentry_nmi_exit(regs, state);
>  	}
>  }
> @@ -308,15 +326,19 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> +		local_irq_enable();
>  
>  		handle_break(regs);
>  
> +		local_irq_disable();
>  		irqentry_exit_to_user_mode(regs);
>  	} else {
>  		irqentry_state_t state = irqentry_nmi_enter(regs);
> +		cond_local_irq_enable(regs);
>  
>  		handle_break(regs);
>  
> +		cond_local_irq_disable(regs);
>  		irqentry_nmi_exit(regs, state);
>  	}
>  }
> @@ -355,10 +377,12 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  		syscall_exit_to_user_mode(regs);
>  	} else {
>  		irqentry_state_t state = irqentry_nmi_enter(regs);
> +		cond_local_irq_enable(regs);
>  
>  		do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->epc,
>  			"Oops - environment call from U-mode");
>  
> +		cond_local_irq_disable(regs);
>  		irqentry_nmi_exit(regs, state);
>  	}
>  
> @@ -368,11 +392,11 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
> +	cond_local_irq_enable(regs);
>  
>  	handle_page_fault(regs);
>  
> -	local_irq_disable();
> -
> +	cond_local_irq_disable(regs);
>  	irqentry_exit(regs, state);
>  }
>  #endif
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 0194324a0c506..6d23ed0ce8a28 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -306,10 +306,6 @@ void handle_page_fault(struct pt_regs *regs)
>  		return;
>  	}
>  
> -	/* Enable interrupts if they were enabled in the parent context. */
> -	if (!regs_irqs_disabled(regs))
> -		local_irq_enable();
> -
>  	/*
>  	 * If we're in an interrupt, have no user context, or are running
>  	 * in an atomic region, then we must not take the fault.
> -- 
> 2.39.5
