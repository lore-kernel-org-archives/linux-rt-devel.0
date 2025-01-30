Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5E19E999
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jan 2025 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222628; cv=none; b=mX2MAf1QSCTaqUldqV/czN3FnJAj/FWGb3xthBnrWnBAmsbRJ5S65Tn4ZJYwJOPU1vE91Mb9oCzM8LKNk5DCsjroh4l7WxSFtCW7ywwSVpCVHJWi4kCwVh4oVIAoBFzFVfw8foFwaM+x/11LyTkXPuCAO0j7P06pGkp9RTKUrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222628; c=relaxed/simple;
	bh=lql/d444xg1Fy6Q9EA9tIL30jSjwOM1Ski88qz9kq60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+3St2KEqSzQjwzzTqgpvJ8ai+pUtIYPAeh+KIC+P0lMWNxzwk5v3/c6TP+ONJ++VdVaCGbPmcdPoQRihh7887Cp+Yw81pOVEEuLcQ/hSImubeIEUIspanTAIZdP3wPr4f281y5NsoHBDv2fePEZY6vjZzlsfmJ39lk1qAOLfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pgMyWN+x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cy/ruR5F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pgMyWN+x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cy/ruR5F"
Date: Thu, 30 Jan 2025 08:37:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738222625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3+e6z1uPc4ACSBSTVY4Z3GnLWwnctsh+5Nt4c8md5w=;
	b=pgMyWN+xSTjEAVhHsr1zj/K9Zj1nJT+YPw45BSO5dU5/NlpR1UpScO8gbw5UwRXuPfNlcD
	cloNz0YZ+8O8kWMvOGub9piNHhvrUbZ0+i4UW+E8FRQy3ySu82rDUCfHT4tJT3hU+zfKwb
	aE1y0hk+qiSMF+QHzo9QZr6vEcnUiR8NOxIBof/X4qMTXalt4ub2UAq1l2nzs2L8u3G4jO
	eCPayPibF+rhWuZ3s7Lv50shIuoCAWKrYsz6gso4YSBwbp9TQhXAQvFyF68MKmPCA/Y68F
	rBUvQjhoy0+E/yK3c7idGJmds1tcLvwE5Mh71pCxy+vsorh8n7OLR1j9cK6GDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738222625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3+e6z1uPc4ACSBSTVY4Z3GnLWwnctsh+5Nt4c8md5w=;
	b=Cy/ruR5FXkPtyk6JrqOm1GywTw0ryi6o3zC4SFpGuoZEiMfsKoStAlW0ivLRXOdrpga83X
	kOycsFdYOP1hzQAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
Message-ID: <20250130073704.2h2vRBTJ@linutronix.de>
References: <20250129224001.430506-1-longman@redhat.com>
 <20250129224001.430506-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129224001.430506-2-longman@redhat.com>

On 2025-01-29 17:40:01 [-0500], Waiman Long wrote:

Instead of the backtrace

> The following bug report happened in a PREEMPT_RT kernel.
> 
> [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
> [   30.962673] preempt_count: 1, expected: 0
> [   30.962676] RCU nest depth: 0, expected: 0
> [   30.962680] 3 locks held by kwatchdog/2012:
> [   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
> [   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
> [   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
> [   30.977827] Preemption disabled at:
> [   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
> [   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
> [   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
> [   30.982846] Call Trace:
> [   30.982850]  <TASK>
> [   30.983821]  dump_stack_lvl+0x57/0x81
> [   30.983821]  __might_resched.cold+0xf4/0x12f
> [   30.983824]  rt_spin_lock+0x4c/0x100
> [   30.988833]  get_random_u32+0x4f/0x110
> [   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
> [   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
> [   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
> [   30.993898]  clocksource_watchdog_kthread+0x18/0x50
> [   30.993898]  kthread+0x114/0x140
> [   30.993898]  ret_from_fork+0x2c/0x50
> [   31.002864]  </TASK>

which is huge and doesn't provide much unique information could please

> It is due to the fact that get_random_u32() is called in
> clocksource_verify_choose_cpus() with preemption disabled.  The
> batched_entropy_32 local lock and/or the base_crng.lock spinlock will
> be acquired. In PREEMPT_RT kernel, they are rtmutexes and the above
> warning will be printed if the fast path fails because of contention.

extend this? 
clocksource_verify_choose_cpus() is invoked with preemption disabled, it
invokes get_random_u32() to obtain random numbers. To do so it acquires
the lock batched_entropy_32 which is a local_lock_t. This lock becomes a
sleeping lock on PREEMPT_RT and must no be acquired in atomic context.

> Fix this problem by moving the clocksource_verify_choose_cpus() call
> before preempt_disable() while moving the part that needs preemption to
> be disabled out into a new clocksource_verify_fixup_cpus() helper that
> is called after preempt_disable(). In that way, the get_random_u32()
> function will now be called with preemption enabled.

Could you replace the patch below with
  https://lore.kernel.org/all/20250129202909.GQNNqNoH@linutronix.de/

Or is there anything that makes it not work? It looks way simpler. Just
to disable preemption during the measurement and keep the task on the
same CPU for the whole time.

> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
> Signed-off-by: Waiman Long <longman@redhat.com>

Sebastian
