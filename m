Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519F332621;
	Tue,  6 Oct 2026 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280855; cv=none; b=IAaYs55dJ44/BUWdGlOJDWzxX/Laih3+5CbEjS7m8ImpCvJ6hWJipmDOEFXB2y/MV2/rfS09QDtY3Igi9pB0KGo8HKQeR6t0OXGk7dHjPX07RR3DjaoZftAJk0JKaaEIRTfuDdyXDkcSU9wYXS7pN9h6pQmq/k0b2v64kKM3P10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280855; c=relaxed/simple;
	bh=YS72mDVgBqOiM3y5oj5JRFVXXwdS4wkbbbpnfg4GBM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2Kc2g++EQnv3XpM+YHeyQLf9kT1KbW6MXc+L23crFbYIQ6Du/vLaWIlw2hgiecqLVYpRr4qAbombWEtZI4OAyIrKwMENFmA29FO86BjX/k+MSOvhA3j/t3tc1XPVGvG/scalqiI7wT1m7eg2A8YwMpXV3BDwiVIjvMK/srY+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq30gTS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq30gTS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBC41F000FF;
	Tue,  6 Oct 2026 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791280854;
	bh=+KlVwSyHDnavG7QvskgSBE2rSteLEpC0WhyEJlJpUUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rq30gTS6aNcLeVZcb5Vx5oD/xEzadhC9LpNv9ju6She6gBvkHsGvUCK2gBArTavj4
	 ab5wSO82DFMdfrUBGaX7pupt0YoONt7RL+KizriKsuKR3huhEqvEPUAhoRn/DOhUMa
	 IsxRcweEQnMjaWcmMBQOpWexTRT0LdJk07lKExAhbwmuys/yfAxTYW/RXzfwyr2NBQ
	 LfPMPLACfwfIzcP1xRblhqtokjbdmo2uJa6tgs1MgzBmqT2HXyKeevC4hW/TtXEn6j
	 MghCfcG54dVqG43Aew5YOlRFyb59EWluN4/qbr2KL2h/oU1mrc1yToL5urT1RXj1fc
	 uPZ0qz7TqOb9w==
Date: Tue, 6 Oct 2026 12:00:51 +0200
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
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5] softirq: Preserve interrupt context during IRQ exit
Message-ID: <asTG09Me93-zP3aG@localhost.localdomain>
References: <20260930191432.62760-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930191432.62760-1-kmehltretter@gmail.com>

Hi Karl,

Le Wed, Sep 30, 2026 at 09:14:32PM +0200, Karl Mehltretter a écrit :
> +static inline bool softirq_handle_begin(void)
>  {
> -	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +	bool from_irq_exit = in_hardirq();
> +
> +	if (!from_irq_exit) {

Is this variable necessary?

> +		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +		return false;
> +	}
> +
> +	/*
> +	 * Only reached from irq_exit(), with HARDIRQ_OFFSET still set.
> +	 * Replace it with SOFTIRQ_OFFSET before handle_softirqs() enables
> +	 * interrupts. Use the raw operation to preserve the preemption
> +	 * disable location recorded by irq_enter_rcu(), and update lockdep
> +	 * directly.
> +	 */
> +	__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
> +	lockdep_softirqs_off(_RET_IP_);
> +	WARN_ON_ONCE(irq_count() != SOFTIRQ_OFFSET);
> +
> +	return true;
>  }
>  
> -static inline void softirq_handle_end(void)
> +static inline void softirq_handle_end(bool from_irq_exit)
>  {
> -	__local_bh_enable(SOFTIRQ_OFFSET);
> -	WARN_ON_ONCE(in_interrupt());
> +	if (!from_irq_exit) {
> +		__local_bh_enable(SOFTIRQ_OFFSET);
> +		WARN_ON_ONCE(in_interrupt());
> +		return;
> +	}
> +
> +	lockdep_softirqs_on(_RET_IP_);
> +	__preempt_count_add(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
> +	WARN_ON_ONCE(irq_count() != HARDIRQ_OFFSET);
>  }
>  
>  static inline void ksoftirqd_run_begin(void)
> @@ -758,10 +788,21 @@ static inline void __irq_exit_rcu(void)
>  		invoke_softirq();
>  	}
>  
> +	/*
> +	 * Wake the timer thread even if the interrupt hit a softirq or a
> +	 * section with BHs disabled. Only nested interrupts and NMIs are
> +	 * excluded.
> +	 */
>  	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
> -	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
> +	    local_timers_pending_force_th() &&
> +	    (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET)

NMIs shouldn't ever take this path, right?

>  		wake_timersd();
>  
> +	/*
> +	 * tick_irq_exit() relies on in_hardirq() being false for the
> +	 * outermost interrupt.
> +	 */
> +	preempt_count_sub(HARDIRQ_OFFSET);
>  	tick_irq_exit();

Can we also extend the HARDIRQ_OFFSET context coverage to tick_irq_exit() ?
From a quick look I haven't found anything that would prevent from that. You just need
to turn the "if (!in_hardirq())" test to "if hardirq_count()) == HARDIRQ_OFFSET"

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
