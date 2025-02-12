Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412620A5E3
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364042; cv=none; b=XbFWXLTDUn1YLRwcRXgS2jzRoTP0/+Nxcy6SgDkXxMx003oYKEDkxlW4Qx3VKO5HWJ1ONRjUC1RP9i5gFOGKJgIUHxwsuN2y6SxBBvpgb5ciDaQq/9kwxa3uUAcq3qUHcoYpfp9lR55LuGZfjb14wK/PvqUg0aJZTjMohGWOUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364042; c=relaxed/simple;
	bh=78lMWVU0GAo7qsBSJL48v+wFRMKDl7nuR/hlpATBW3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reXfjzQjgpHJBmEPce8gmSjoJ4O9Y4dhTGD8W47SY1M6riJ0UvA5fzAZ3IVjX8qUjoPDlyIG9orRdKEGIKYUEEgwtAG+iolIfpyAC6auKHh14vyKvDKzQ9M6OXOpSDso2Z2u4WRueQDQc+PICWiZYHvc1CHXVnfxD4EJ/DuCJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC907113E;
	Wed, 12 Feb 2025 04:40:59 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D74B3F58B;
	Wed, 12 Feb 2025 04:40:36 -0800 (PST)
Date: Wed, 12 Feb 2025 12:40:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: debug_exception_enter() disables preemption and may call
 sleeping functions on aarch64 with RT
Message-ID: <Z6yWwRcPvVGk2EyC@J2N7QTR9R3>
References: <Z6YW_Kx4S2tmj2BP@uudg.org>
 <Z6n16cK85JMyowDq@J2N7QTR9R3>
 <Z6tf8iDhNriSGjeC@uudg.org>
 <Z6vs3IWxUxhIDBBO@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6vs3IWxUxhIDBBO@uudg.org>

On Tue, Feb 11, 2025 at 09:35:40PM -0300, Luis Claudio R. Goncalves wrote:
> On Tue, Feb 11, 2025 at 11:34:26AM -0300, Luis Claudio R. Goncalves wrote:
> > On Mon, Feb 10, 2025 at 12:49:45PM +0000, Mark Rutland wrote:
> > > On Fri, Feb 07, 2025 at 11:22:57AM -0300, Luis Claudio R. Goncalves wrote:
> ...
> > > I don't have an immediate suggestion; I'll need to go think about this
> > > for a bit. Unfortunatealy, there are several nested cans of worms here.
> > > :/
> > > 
> > > In theory, we can go split out the EL0 "debug exceptions" into separate
> > > handlers, and wouldn't generally need to disable preemption for things
> > > like BRK or single-step.
> > 
> > If this is an acceptable workaround, until we have the real solution,
> > I can work on that :)
> > 
> > Luis
> 
> I tested the prototype below and it survived 6h of ssdd and the ptrace LTP
> tests running simultaneously, in a tight loop. Would something along these
> lines be an acceptable workaround?

Sorry, no. This makes the code even more convoluted and less
maintainable.

If you want to fix single step specifically without bothering with the
rest of the rework I mentioned, the right fix is to split that out from
the other "debug exceptions", and handle that with the usual structure
we have for other synchronous exceptions like FPAC/BTI/etc:

* In arch/arm64/kernel/debug-monitors.c, add new do_el{1,0}_step()
  functions which handle their corresponding stepping logic. These
  should have the same rough shape as do_el{1,0}_fpac(), and should
  handle all the default signalling logic that would otherwise be
  handled by do_debug_exception().

  The existing single_step_handler() should be removed, or at minimum
  refactored and only called by those new do_el{1,0}_step() functions.

  The existing hook_debug_fault_code() registration of
  single_step_handler() should be removed.

  I'm not sure whether do_el0_step() needs the
  arm64_apply_bp_hardening() logic, but do_el1_step() does not.

* In entry-common.c, add new el{1,0}_step() functions. Each of
  el1h_64_sync_handler(), el0t_64_sync_handler(), and
  el0t_32_sync_handler() should be updated to call those rather than
  el{1,0}_dbg() for the corresponding EC values.

  In el0_step() it shouldn't be necessary to disable preemption, and
  that should be able to be:

  | static void noinstr el0_step(struct pt_regs *regs, unsigned long esr)
  | {
  |         enter_from_user_mode(regs);
  |         local_daif_restore(DAIF_PROCCTX);
  |         do_el0_step(regs, esr);
  |         exit_to_user_mode(regs);
  | }

  In el1_step(), I'm not *immediately sure* whether it's necessary to
  disable preemption, nor whether we need to treat this and use
  arm64_enter_el1_dbg() and arm64_exit_el1_dbg() rather than
  entry_from_kenrel_mode() and exit_to_kernel_mode().

  So we either need:

  | static void noinstr el1_step(struct pt_regs *regs, unsigned long esr)
  | {
  |         arm64_enter_el1_dbg(regs);
  |         do_el1_step(regs, esr);
  |         arm64_exit_el1_dbg(regs);
  | }

  ... or:

  | static void noinstr el1_step(struct pt_regs *regs, unsigned long esr)
  | {
  |         enter_from_kernel_mode(regs);
  |         local_daif_inherit(regs);
  |         do_el1_step(regs, esr);
  |         local_daif_mask(regs);
  |         exit_to_kernel_mode(regs);
  | }

With that, we're a step forward in the right direction.

Mark.

> 
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 8b281cf308b30..eb3b54710024f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -933,18 +933,20 @@ void __init hook_debug_fault_code(int nr,
>   * accidentally schedule in exception context and it will force a warning
>   * if we somehow manage to schedule by accident.
>   */
> -static void debug_exception_enter(struct pt_regs *regs)
> +static void debug_exception_enter(struct pt_regs *regs, int touch_preemption)
>  {
> -	preempt_disable();
> +	if (touch_preemption)
> +		preempt_disable();
>  
>  	/* This code is a bit fragile.  Test it. */
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
>  }
>  NOKPROBE_SYMBOL(debug_exception_enter);
>  
> -static void debug_exception_exit(struct pt_regs *regs)
> +static void debug_exception_exit(struct pt_regs *regs, int touch_preemption)
>  {
> -	preempt_enable_no_resched();
> +	if (touch_preemption)
> +		preempt_enable_no_resched();
>  }
>  NOKPROBE_SYMBOL(debug_exception_exit);
>  
> @@ -953,8 +955,14 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
>  {
>  	const struct fault_info *inf = esr_to_debug_fault_info(esr);
>  	unsigned long pc = instruction_pointer(regs);
> +	unsigned long req = ESR_ELx_EC(esr);
> +	int touch_preemption;
>  
> -	debug_exception_enter(regs);
> +	touch_preemption = !(IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +		(req == ESR_ELx_EC_SOFTSTP_LOW || req == ESR_ELx_EC_BRK64
> +		 || req == ESR_ELx_EC_BKPT32 || req == ESR_ELx_EC_SOFTSTP_CUR));
> +
> +	debug_exception_enter(regs, touch_preemption);
>  
>  	if (user_mode(regs) && !is_ttbr0_addr(pc))
>  		arm64_apply_bp_hardening();
> @@ -963,7 +971,7 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
>  		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
>  	}
>  
> -	debug_exception_exit(regs);
> +	debug_exception_exit(regs, touch_preemption);
>  }
>  NOKPROBE_SYMBOL(do_debug_exception);
>  
> 
