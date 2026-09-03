Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054ED4DF4BD;
	Thu,  3 Sep 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448947; cv=none; b=AV5Lhh4rk8hDuRX79WnPRRcT3DSYFFBPI/EV1opXlJwbd9R67RhUAyaEwnO7Z5Mmc1kt9LdbeRwxdRUcZGHONZgCytSDFMLHil+3YFMakhVee6y4/KhswKEJf/H6yjksv30TCa2ldhH4nrrAqKKcwQ02Uk4TuOy0dQnkP25OQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448947; c=relaxed/simple;
	bh=TMtYzgrpSdHvJiolBo1cD5SrbKicrTZIvKVO8zzOy+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al48FFQ+BbrsTtwjZWjtqfHal6l5Z5bfrlcczv+4JbSig0KZziCnO5Yd6pQCoPZ0YcRrPioioCZULNr1GhdGm5O/0LX/XYxklZK3FGEoaR+N0FiXEh9bwKala2XAyYDbm8v0Oo+YcskGRahN4Ln1+INYHpp0Rir0O334q5GIz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc9oqVsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc9oqVsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F751F00A3D;
	Thu,  3 Sep 2026 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448944;
	bh=ilm2t067fCG9Kf82aPXhlS3s3xhdYNrMre1PxcoIAto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vc9oqVsWekXn3cZudgd6cwl9RwQLq5SIyCrHSUFInoznjAB7fYe9pDULppKbRaBsC
	 xvQMcztkM2AyPhJ1jITBGe4K0Sv/D8LhjQbhjlJxMaxLH0vTpSmsTYert7Ol/rfnku
	 m5/8Wi0QWVg23uWpjmd5bBP0ZMnmg3unpFcIF7nT9ioPMJW9BwaMaND+OkHpEMMCdb
	 /0oes0LpaL4xHIsU8bE6t/BrBzMAR8ANzdogAEPt4okg9yjpzd1wijXXU75rnrnpLm
	 E4bA/2pxQI41fQtFzm13yEvGiPAn4ju+iP2q+izcVR1KPqiUmiA8zOdowhfnosEJlh
	 jiqYDNwj/63Pg==
Date: Thu, 3 Sep 2026 17:22:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] softirq: Preserve interrupt context during IRQ exit
Message-ID: <apmQrTzP0sTSReI1@localhost.localdomain>
References: <20260903112737.49551-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903112737.49551-1-kmehltretter@gmail.com>

Le Thu, Sep 03, 2026 at 01:27:37PM +0200, Karl Mehltretter a écrit :
> __irq_exit_rcu() drops HARDIRQ_OFFSET before deferred hrtimer rearm,
> softirq dispatch, and timersd wakeup. This work is still on the IRQ
> return path, but in_task() reports task context.
> 
> Context-sensitive code called from this window therefore sees task
> context. ftrace records normal-context flags and selects its normal
> recursion slot. KCSAN attributes IRQ-exit accesses to the interrupted
> task, while KMSAN can select and modify that task's metadata.
> 
> Keep HARDIRQ_OFFSET until the IRQ-exit work is done. For direct softirq
> handling, replace it with SOFTIRQ_OFFSET and restore it afterwards. Other
> __do_softirq() call paths keep their existing accounting.
> 
> With hardirq context retained, ftrace records hardirq context, KCSAN uses
> interrupt attribution, and KMSAN no longer uses the interrupted task's
> state.
> 
> Since softirq eligibility is now tested before HARDIRQ_OFFSET is removed,
> use irq_count() == HARDIRQ_OFFSET. This preserves the old !in_interrupt()
> semantics, including PREEMPT_RT's task-local softirq-disable state.
> 
> Drop HARDIRQ_OFFSET before tick_irq_exit(), as before.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> I reworked Peter's draft linked above into this version and tested it.
> 
> Changes:
> - Use in_hardirq() in softirq_handle_begin() instead of ksirqd, since
>   __do_softirq() also has task-context callers, including ktimerd.
> - Use irq_count() for the eligibility test so PREEMPT_RT's task-local
>   BH-disabled state remains part of the decision.
> 
> Tested with non-RT, threadirqs and PREEMPT_RT x86-64 QEMU boot/stress.
> The QEMU kernels had lockdep and IRQ tracing enabled and reported no new
> warnings.
> 
> A focused RT test rejected every BH-disabled IRQ-exit observation. The
> old-mask negative control admitted every one.
> 
> ftrace marked direct IRQ-exit work as hardirq rather than normal context.
> 
> A separate A/B changed printk caller attribution from task to CPU,
> in_task() from 1 to 0 and interrupt_context_level() from 0 to 2. Fault
> injection no longer consumed the interrupted task's fail_nth state.
> 
> KCSAN attributed all 16 target reports to interrupt context.
> 
> KMSAN did not select or change task state in 64K IRQ-exit windows. All
> 28 KMSAN KUnit tests passed.
> 
> The exact TIP source also passed A/B boot/stress on a Pi 400
> (Cortex-A72, arm64).
> 
> For additional coverage, the mainline adaptation passed A/B boot/stress
> on a Microchip SAM9X75 Curiosity (ARM926EJ-S/ARMv5TEJ).
> 
> vmlinux linked successfully for arm64, ARM, RISC-V and s390.
> 
>  kernel/softirq.c | 48 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 5d02c36c40e3..63aeaa5f62e9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -350,8 +350,8 @@ static inline void ksoftirqd_run_end(void)
>  	local_irq_enable();
>  }
>  
> -static inline void softirq_handle_begin(void) { }
> -static inline void softirq_handle_end(void) { }
> +static inline bool softirq_handle_begin(void) { return false; }
> +static inline void softirq_handle_end(bool from_hardirq) { }
>  
>  static inline bool should_wake_ksoftirqd(void)
>  {
> @@ -481,15 +481,35 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  }
>  EXPORT_SYMBOL(__local_bh_enable_ip);
>  
> -static inline void softirq_handle_begin(void)
> +static inline bool softirq_handle_begin(void)
>  {
> -	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +	bool from_hardirq = in_hardirq();
> +
> +	if (!from_hardirq) {
> +		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +		return false;
> +	}
> +
> +	/* Replace the retained hardirq context with normal softirq context. */
> +	__preempt_count_add((int)SOFTIRQ_OFFSET - (int)HARDIRQ_OFFSET);

So it skips the whole RT locking and processing because softirqs don't
happen anyway on hard IRQ tail there. Looks good.


> +	if (softirq_count() == SOFTIRQ_OFFSET)

Any other value should be forbidden here.
It should just warn.

> +		lockdep_softirqs_off(_RET_IP_);
> +	return true;
>  }
>  
> -static inline void softirq_handle_end(void)
> +static inline void softirq_handle_end(bool from_hardirq)
>  {
> -	__local_bh_enable(SOFTIRQ_OFFSET);
> -	WARN_ON_ONCE(in_interrupt());
> +	if (!from_hardirq) {
> +		__local_bh_enable(SOFTIRQ_OFFSET);
> +		WARN_ON_ONCE(in_interrupt());
> +		return;
> +	}
> +
> +	if (softirq_count() == SOFTIRQ_OFFSET)
> +		lockdep_softirqs_on(_RET_IP_);

Same here, you should warn if softirq_count() != SOFTIRQ_OFFSET

> +	__preempt_count_sub((int)SOFTIRQ_OFFSET - (int)HARDIRQ_OFFSET);
> +	WARN_ON_ONCE(!in_hardirq());
>  }

Thanks!

-- 
Frederic Weisbecker
SUSE Labs
