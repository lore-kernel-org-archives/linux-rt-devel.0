Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EB209F3C
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359309; cv=none; b=ad4fDf4MwvMQa5xpirngGrSS2FcoerC+KI2rCyUWlIJepISitvGS2town6aZkeRWkrD2/C+1NMQpLJOzzVK7QHORRSmP/JHcM4UH5ZCvSaGl0Anl2vXRVs9c90R8LTOGo2JXdi1sTpKAOqs6ycPye0bM2U8THuMHc2WriL3C1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359309; c=relaxed/simple;
	bh=FtRxwNwB1LGh/EUQt2O9V51fIz3IQ4+TChBDHh9Ey7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucRrSAo6ixZMFcUciLEQALN/x3qCUk8+wi+m+F6jQ0C2gvuvOUOx7SVQcp+jD6swKSoTfSj6/PjMNsSolqk5EEpWmQoeeRlHeMdPpeNPU7pE6qCIK0uC2yhKY+y3Xzh9icJK79BKgC7OOGzBONIkQPhlG1hL9lDzT7v3Jl/asyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceDbVx9a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+RSrdlo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceDbVx9a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+RSrdlo"
Date: Wed, 12 Feb 2025 12:21:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739359306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1K7nMbUzi/PBxssXxktE8rcuXI/mW+uKt+5ZI9cf20=;
	b=ceDbVx9a2RdBxVvts79Y9Gu/Vc6V5J0JakVP5pAar2t8o7SYF6ep8YmxQi972w4iw8ktZS
	vV2u71gzCU3z9HnHr6lwdwBL9EL5n09HtBSe+UvCh9RQ9xKzhEF4ThiP6UOCOmRmTQlmhw
	ypC9G/dB0Tt5OHvR65sKcOgGpVYb02pl0tMyQ2WJTAmp570Oj182j1pklg89PNkVh3fa7n
	uCoND4zNtV3ejqmK0hX+z0C4fjIWHVz7kGs2X9fTC7q/gJNRT3X4bVppjmHDj0ZUOAEUp9
	HrKsDwgBmAksl+EzatchVRqx6xBgN1C1Hxdgq5g4npJpa+Lqp8smPMVDMfjXmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739359306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1K7nMbUzi/PBxssXxktE8rcuXI/mW+uKt+5ZI9cf20=;
	b=0+RSrdlobtGST3Ru+CGHZnGHLgeRoFN6Vz2ndbWWeKkku0DmygER63VRVMNX1meUQCqR2z
	+1R4wD164XpXF3DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: debug_exception_enter() disables preemption and may call
 sleeping functions on aarch64 with RT
Message-ID: <20250212112145.BIE8_6T2@linutronix.de>
References: <Z6YW_Kx4S2tmj2BP@uudg.org>
 <Z6n16cK85JMyowDq@J2N7QTR9R3>
 <20250210140657.UAsRw4k8@linutronix.de>
 <Z6vvyKZ5eoAS435b@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6vvyKZ5eoAS435b@uudg.org>

On 2025-02-11 21:48:08 [-0300], Luis Claudio R. Goncalves wrote:
> > Couldn't you delay sending signals until after the preempt-disable
> > section? 
> 
> Looking at do_debug_exception,
> 
> void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
> 			struct pt_regs *regs)
> {
> 	const struct fault_info *inf = esr_to_debug_fault_info(esr);
> 	unsigned long pc = instruction_pointer(regs);
> 
> 	debug_exception_enter(regs);
> 
> 	if (user_mode(regs) && !is_ttbr0_addr(pc))
> 		arm64_apply_bp_hardening();
> 
> 	if (inf->fn(addr_if_watchpoint, esr, regs)) {
> 		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
> 	}
> 
> 	debug_exception_exit(regs);
> }
> NOKPROBE_SYMBOL(do_debug_exception);
> 
> 
> Do you mean executing the
> 
> 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
> 
> after re-enabling the preemption or do you mean something more
> sophisticated?

single_step_handler() and brk_handler() can both send signals. If
inf->fn returns != 0 (which seems to be only be possible for
brk_handler() out of the possible four callbacks) this this
arm64_notify_die() sends a signal.
So we have three potential signal delivers. It shouldn't matter if the
signal is sent within the preempt-disable section or outside because the
signal will be queued for current and delivered on the return to
userland. So would just need to save the details and do it outside. Now
that I actually looked at the code, this might lead to a bit of a mess
so splitting out the signal part and avoiding the preempt-off part might
better which would be the rework that Mark was talking about.

> Luis

Sebastian
