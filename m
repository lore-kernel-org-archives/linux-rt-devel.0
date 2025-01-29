Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70917E0FF
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jan 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168487; cv=none; b=aG70079/2wvAJMCaSHM7cskLzHQba+GM/Q4f02wGALNpXGyFLvaZxLCXy7w+ElMAbgmEYl94kjmJx6SlSHoflYMWPnHxPBNfFYZdUDXpDlOxeFOi1YO0sJXIgXTX5ehJrobEpeqvG7iuJH+Pc9ukfdjRc6UmM07sqg/lJWaAaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168487; c=relaxed/simple;
	bh=yAmgQCeLCa+luDkPVunhX4KFdrz7gdPlzk6g6RsI1tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcSYcd/zHvwQV/hqqDqR3hUZE/YAwDdL17ckvOr9b3UE0mZpsgM8VkZ1kikRmK67hLvriGLIgciUMqGWLuFLYOt97Zh6P7pCU4N12uNfKovCgt0BCEBihA3ECeLiVKGMNsjl7zuNhdks2X+P8tFkEgXEabN/xsCe9V5dECBVkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kOxnXtfh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jFlFxfA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kOxnXtfh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jFlFxfA"
Date: Wed, 29 Jan 2025 17:34:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738168484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czTRkk4r1DUtL6lxIAkznyN2eGoBWS39qbA3TRqI4Dw=;
	b=kOxnXtfhPD1y4PBDZ/3pOGqCXuvEs0H6gkR6myQiXwqJJri92Ct5ZHxqlRLVevVhfdCyfm
	YNnmHxW6qoZUS5/tJljpSXYfamSIaHIL0nKMdQwuNExNPzZfnMtV80WL6cHNrnuK8ykytE
	xqjb7oUmgsAJMrGcF/6ndcDwzLL100/VRW8QQXvDmddv+vBiB1XaM2WDZpJLEJSmCvaJFc
	k4XKScQzWlaEBOhjqAOCZWqFKlQ/53LbGOh1qfqf2EpumfUYJ3ZVY6IFI8mYNZ7POMQ1K+
	BakrRgphGvc9V16HW7Ve7ysU9O5UzVHWCu06SKQ51kBB4ETMfOXiC7l/YcVEwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738168484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czTRkk4r1DUtL6lxIAkznyN2eGoBWS39qbA3TRqI4Dw=;
	b=3jFlFxfAWDEQfxsZVlX0Stu2tye425DB5Gv1NV/sAqExjlnm35Z0YSaj6A0OU5WOPEE5OH
	jAaoMBT7Yej6m0CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
Message-ID: <20250129163442.vczSGi63@linutronix.de>
References: <20250125015442.3740588-1-longman@redhat.com>
 <20250125015442.3740588-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250125015442.3740588-2-longman@redhat.com>

On 2025-01-24 20:54:42 [-0500], Waiman Long wrote:
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
> 
> It is due to the fact that get_random_u32() is called in
> clocksource_verify_choose_cpus() with preemption disabled.
> If crng_ready() is true by the time get_random_u32() is called, The
> batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
> it is a rtmutex and we can't acquire it with preemption disabled.
> 
> Fix this problem by using the less random get_random_bytes() function
> which will not take any lock. In fact, it has the same random-ness as
> get_random_u32_below() when crng_ready() is false.

So how does get_random_bytes() not take any locks? It takes locks in my
tree. You two have a lock less tree?

In case your tree is not lock less yet, couldn't we perform the loop
verify_n_cpus+1 times without disabled preemption? Then disable
preemption after return from clocksource_verify_choose_cpus() and then
either remove current CPU from the list if it is or remove a random one
so that we get back to verify_n_cpus CPUs set.

Alternatively, (and this might be easier) use migrate_disable() instead
of preempt_disable() and only use preempt_disable() within the
for_each_cpu() loop if delta is important (which I assume it is). 

But all this would avoid having to run with disabled preemption within
clocksource_verify_choose_cpus() while having the guarantees you need.

> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
> Signed-off-by: Waiman Long <longman@redhat.com>

Sebastian
