Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6920ADC4
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593211; cv=none; b=tddRneu9ip6hZnBvHZjXj9fn9ODeND9EFTfttWGrAG4T0KoJsw5Y00Ks7HZmLRx8ZMTRglNFzUeykI9VH0vWVShUKHj2OLHWKHuyYmgSyQfzjZMqwvnhTa7e4g3wxFpUiO7feBZ+Qb2dFN5QyoHX9kzMPVeYIXtGbIP55xpkr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593211; c=relaxed/simple;
	bh=WGIvt+eNWLR8EpH1wQ/sGPeZ8bTeKXak6jUnrdoCNg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTdmonWFQI2k3QWCyLqaqu4NCD8vnNTaAw2PHfQZz/MZlYTn4Vc0s22n0J+fWffccIFd9IIEorOde3ewf/7oIlTvgSS0MYjPTe4kZabNEAxqkXiU6+IX0y6+9AQ61DldR0HLeCUTk9OC9R68TSVKHJtl2c5eoBs3kYeQ/y4ytR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MswMRCVm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KHg15G7s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MswMRCVm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KHg15G7s"
Date: Mon, 3 Feb 2025 15:33:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738593208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9swSVj90gMmGN48m//mBvN8gG9L3wYEsY+irXAHWsYU=;
	b=MswMRCVmBRpFwBRCGbZbWQgNje+L1eyYQTgv6Co1S2KAptx2hcLdY/MFM7T5aXtJPWkfg+
	nTPC9MmBfXfm9HFV95X/W+HIgl525qXSoM7J8b3GzusuKtXSZcRlgHuyUOwZExMUNvyiPq
	9py/VpbU9vIPEBcxSqmdFj+BPiyynYPF9OMEASQXrHRTcvyCQlwQUBlpQk56lLbV2AeAli
	Rz5qGkvvG2xBU104qhkG/VlrD15znSoCFv1dzOfv1ijXlXJwOs8u44imxutq9IpOsfQbcB
	E7MuNBOFtKH5EU07cJo/BkIhSzWUYUh3Pp3c5x+SDjstFtEM0XVFCx2C9djRNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738593208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9swSVj90gMmGN48m//mBvN8gG9L3wYEsY+irXAHWsYU=;
	b=KHg15G7s9ahbSCkp0X2P3Nfer1A23ihSSr+7ydv11JJUBpx/wsb36foWctCbrTG3HycqZG
	xYKDRinp51XWcLCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 2/2] clocksource: Use migrate_disable() to avoid
 calling get_random_u32() in atomic context
Message-ID: <20250203143327.x_ZarOCC@linutronix.de>
References: <20250131173323.891943-1-longman@redhat.com>
 <20250131173323.891943-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131173323.891943-2-longman@redhat.com>

On 2025-01-31 12:33:23 [-0500], Waiman Long wrote:
> The following bug report happened with a PREEMPT_RT kernel.
> 
> [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
> [   30.962673] preempt_count: 1, expected: 0
> [   30.962676] RCU nest depth: 0, expected: 0
> 
> It is due to the fact that clocksource_verify_choose_cpus() is invoked
> with preemption disabled.  This function invokes get_random_u32()
> to obtain random numbers for choosing CPUs.  The batched_entropy_32
> local lock and/or the base_crng.lock spinlock in driver/char/random.c
> will be acquired during the call. In PREEMPT_RT kernel, they are both
> sleeping locks and so cannot be acquired in atomic context.
> 
> Fix this problem by using migrate_disable() to allow
> smp_processor_id() to be reliably used without introducing atomic
> context. The preempt_disable() function is then called after
> clocksource_verify_choose_cpus() but before the clocksource measurement
> is being run to avoid introducing unexpected latency.
> 
> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I would have moved the preempt-disable into the for_each_cpu() loop. But
given that the clocksource is only updated on boot and by the watchdog
this does not matter at runtime.

Sebastian
