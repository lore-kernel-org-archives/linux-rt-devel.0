Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17E1EC00D;
	Thu, 20 Feb 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048246; cv=none; b=PVglmt7TRr9Bktp+DBtq51GdewEtdvXjU5gxRqM3cc49ioBxl5Z5iVPV3mf5PcVcM4tEUdJDZZNiPK6IX8iCcrPsXtH+Y9OCIevN/vpDrryG/Fe1A6SsEbrPtmWnhb3cMaC8A1B7QjH5vtggLlndxzBDtq6RProRKNw8JtoK37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048246; c=relaxed/simple;
	bh=o7cC2pzvDGIsuGMkokdSibsF9dX73IidV1pc3KaCWCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7uNNrdbV45IJmftE/A0mJ3e1AxnUTBZgHry1Cfo2O7529CI/9bpvg6cc8brg7Fzo693oWfgy4VLIoXtXkS58fduxEXw3nNL/d+1VFQiRyZZNgMLubKVvk8RamhUTh0o9bjuDyq1IZmGIcXK96RMkJIDW2//pvgc17v+C1F/lwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gsGPHaVw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsGPHaVw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UCsau6Q1T8XzQ2ZBsnSplAduXGSIHhbZTYy26mO11B4=; b=gsGPHaVwli7MJfInoK/NyZWFMj
	KwwXNXOgi5RCveeIUA+WeGuij8EAe+TBahj03xVnCHRvw6NGYkg6xvRuVGBGjhgMHxr4jpRJ/izzW
	oPB4o0kT/Tpt21Gfoa+0U1+28b4HbYBTWyXJkBjl6I1bi03bvwOXMAfW25qTBgP4Px5Om2lb/SyCL
	KnQpKlX8rd2eMNK/o0VTuC0fGKQShv/AQXpbJNcLPVOWaht8ZXwKLY3Qi8dpwzeqypi1YcjwAwLg8
	AdI3u05Qo6TvuzKSxWU0BN/OQZHk4E7vhO3T4OwvP6pEl7xWEmm8DdxXbO0dqqVc44rBi/aIkg3p5
	xI+UK3vQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tl428-00000009IIL-3KZS;
	Thu, 20 Feb 2025 10:43:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C5C83300756; Thu, 20 Feb 2025 11:43:55 +0100 (CET)
Date: Thu, 20 Feb 2025 11:43:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Barret Rhoden <brho@google.com>, Petr Mladek <pmladek@suse.com>,
	Josh Don <joshdon@google.com>, Qais Yousef <qyousef@layalina.io>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Vernet <dvernet@meta.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 01/22] kernel/entry/common: Move
 syscall_enter_from_user_mode_work() out of header
Message-ID: <20250220104355.GI34567@noisy.programming.kicks-ass.net>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220093257.9380-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220093257.9380-2-kprateek.nayak@amd.com>

On Thu, Feb 20, 2025 at 09:32:36AM +0000, K Prateek Nayak wrote:
> Retain the prototype of syscall_enter_from_user_mode_work() in
> linux/entry-common.h and move the function definition to
> kernel/entry/common.c in preparation to notify the scheduler of task
> entering and exiting kernel mode for syscall. The two architectures that
> use it directly (x86, s390) and the four that call it via
> syscall_enter_from_user_mode() (x86, riscv, loongarch, s390) end up
> selecting GENERIC_ENTRY, hence, no functional changes are intended.
> 
> syscall_enter_from_user_mode_work() will end up calling function whose
> visibility needs to be limited for kernel/* use only for cfs throttling
> deferral.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  include/linux/entry-common.h | 10 +---------
>  kernel/entry/common.c        | 10 ++++++++++
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index fc61d0205c97..7569a49cf7a0 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -161,15 +161,7 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
>   *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
>   *  2) Invocation of audit_syscall_entry()
>   */
> -static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
> -{
> -	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
> -
> -	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, syscall, work);
> -
> -	return syscall;
> -}
> +long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
>  
>  /**
>   * syscall_enter_from_user_mode - Establish state and check and handle work
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index e33691d5adf7..cc93cdcc36d0 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -79,6 +79,16 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
>  	instrumentation_end();
>  }
>  
> +__always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
> +{
> +	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
> +
> +	if (work & SYSCALL_WORK_ENTER)
> +		syscall = syscall_trace_enter(regs, syscall, work);
> +
> +	return syscall;
> +}
> +
>  /* Workaround to allow gradual conversion of architecture code */
>  void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }

This breaks s390. While you retain an external linkage, the function
looses the noinstr tag that's needed for correctness.

Also, extern __always_inline is flaky as heck. Please don't do this.
