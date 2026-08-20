Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F83CB2D7
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214079; cv=none; b=XqDRKF8CdIu78pNMukZiV13BEL3pOTQ4+FM4dIbjzwrl5kz8P51wi7L1TL7eOYxCO8TX1cVve2he9Cp0w6/tcNubxz/idbxR17IU4rgAB2eXPeQOzEMZgWMIay27NpZFRRP378Y28McGmCa2jAveRTTo2/X/b0hgoGDIuWW9dE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214079; c=relaxed/simple;
	bh=mM0hv9kkVmRkNiZCvasVK7f7m3POUKFF4mh+D3FHvk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVDkNQRli6dwAxVXYZgtH2FcSY8/CMBDHPKn9T7Duq8GtfK3ylPtqq6e2IBiCwKPSvmOXwjnKfAH1EFtdxM3hC+jteGvJOJqz9DhySfWmXTaLABzgYk3/8DMMiAVnmAc48QnNOToEXWl+e52OFvmbSoMk54v6Hq/8NW9jMP8BUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYLCfQW6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrWxZhv9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYLCfQW6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrWxZhv9"
Date: Thu, 20 Aug 2026 10:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787214076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wrlbDLpM0/RMipA5hKlwMUnFEMvKmV/f/UESLPxAg0=;
	b=TYLCfQW6HHfsoBftFFU3nnFkhV5WJtkKvOqBdtSlQEZmh0QAoAhkkLAZ2mN+u1fIszyv6j
	DxnrdYpX1NNCFRmUGWzhgjRMarg0R8i820nABuQI30xvk2cqhMP46jz8qfFSUskVMm8hg6
	v+9IrEwxNJ7y6NFy30xP3rvlltTNOh5kDjso1DqsQrseB6bBL8/B5NDQhVkPBJHTVjybas
	Np/PcXjBS4r6KpvOEbHQ2zdPzLBIHLuV/hB8jrNCqtCejMaXquMWWafub0E9bl91bdfUVB
	tQ8j62uSjJx6RCaeR2WZRFPmPmw5yL2ltwNFQcLXW+zGqv1NF6CFtlIHVorNGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787214076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wrlbDLpM0/RMipA5hKlwMUnFEMvKmV/f/UESLPxAg0=;
	b=rrWxZhv9ixzJcx2altuUqTOex7Qn7XLDFy7ddp1laijFcJenGoVpaZZV9fcrG3433K77LS
	2UARS1aKVjSPYeBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Liang Hao <haohlliang@gmail.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] docs: real-time: mention the hrtimer sleeper HARD path
Message-ID: <20260820082114.QIiSu8n5@linutronix.de>
References: <20260814094910.akPMAqd4@linutronix.de>
 <20260814161240.33774-1-haohlliang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814161240.33774-1-haohlliang@gmail.com>

On 2026-08-15 00:12:40 [+0800], Liang Hao wrote:
> The Timers section of Documentation/core-api/real-time/differences.rst
> describes the PREEMPT_RT default (softirq / ktimers) and HRTIMER_MODE_HARD,
> but not the sleeper helper: hrtimer_setup_sleeper_on_stack() marks the
> timer HRTIMER_MODE_HARD when the current task is RT or DEADLINE and
> HRTIMER_MODE_SOFT was not requested, so the wakeup runs in hard interrupt
> context.
> 
> Document that behaviour. Also rename "ktimersd" to "ktimers/%u" to match
> the per-CPU thread name.
> 
> No code or behaviour change.
> 
> Signed-off-by: Liang Hao <haohlliang@gmail.com>
> ---
> v3 -> v4:
> - drop the Documentation/timers/hrtimers.rst section; extend differences.rst
>   instead, per review
> - add only the sleeper HARD wording and the ktimers/%u rename
> - do not restate lowest-priority / cancel-PI points already covered elsewhere
> - avoid vague "and similar" caller lists
> 
>  Documentation/core-api/real-time/differences.rst | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
> index a129570dab5a..c8acfba051eb 100644
> --- a/Documentation/core-api/real-time/differences.rst
> +++ b/Documentation/core-api/real-time/differences.rst
> @@ -119,12 +119,17 @@ timers initialized with the HRTIMER_MODE_SOFT flag, which are executed in
>  softirq context.
>  
>  On a PREEMPT_RT kernel, this behavior is reversed: hrtimers are executed in
> -softirq context by default, typically within the ktimersd thread. This thread
> -runs at the lowest real-time priority, ensuring it executes before any
> -SCHED_OTHER tasks but does not interfere with higher-priority real-time
> +softirq context by default, typically within the per-CPU ktimers/%u thread.

Please do ktimers instead ktimers/%u. I don't see any other reference to
a per-CPU thread like that. This would also be in sync with ksoftirqd.

> +This thread runs at the lowest real-time priority, ensuring it executes before
> +any SCHED_OTHER tasks but does not interfere with higher-priority real-time
>  threads. To explicitly request execution in hard interrupt context on
>  PREEMPT_RT, the timer must be marked with the HRTIMER_MODE_HARD flag.
>  
> +hrtimer_setup_sleeper_on_stack() marks the sleeper HRTIMER_MODE_HARD when the
> +current task is in a real-time or deadline scheduling class and
> +HRTIMER_MODE_SOFT was not requested, so the wakeup runs in hard interrupt
> +context rather than on ktimers/%u.
> +

What about

   Userland sleeper deploy usually a hrtimer to guarantee a precise wakeup
   time. The timer is initialized with hrtimer_setup_sleeper_on_stack()
   which distinguishes between real-time and regular tasks. The hrtimer of a
   task without a real-time priority is initialized with HRTIMER_MODE_SOFT
   but for real-time priorities HRTIMER_MODE_HARD is used. This ensures
   that real-time tasks are woken up as soon as possible while ordinary
   tasks can not block the CPU with a thundering herd of wake ups.

>  Memory allocation
>  -----------------
>  

Sebastian
