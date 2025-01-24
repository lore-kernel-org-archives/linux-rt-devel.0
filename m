Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD67080A;
	Fri, 24 Jan 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751053; cv=none; b=uaP0MCS7YM9vixEScC3mkOO6ddbaPrNxEzc9IsrKtGar4AzOv8VyYUDee0dCDh5EL+Ef+M2/2LP80rd0V1wddhEOt33gL5wIrR7cIb/DaJUTqX39zF7S9VVgb8RawFvbbj8TuVKhTAXqKmZ24LhWfQjz6ilEWeCa1vKIHErwGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751053; c=relaxed/simple;
	bh=pYZDGlEHyjK9+dKZagnVn9bjgnLwApsf9eqXgkdMv+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szVQ3uI2W6OGUpJIHhI5uvgroQyOnHyZKuQJo5eNVRvxOwGLYTCcqbZi//3laklMV+Opd9QfpFcglcn6kG871AmXGjCeWIiDqHsJ9DHg78aIHg8Msp8psJ1ZJ+Mq+YPcwKJZM893nyULDH7iFwNrHjlsIn43u1hRI7RDH5tw2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3rMH0ia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3rMH0ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A94C4CED2;
	Fri, 24 Jan 2025 20:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737751053;
	bh=pYZDGlEHyjK9+dKZagnVn9bjgnLwApsf9eqXgkdMv+8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T3rMH0ia2sUCkl7nTvz6qcHymz96trhQI7EKC3yLH8Xn3gokWMt7w7KRBdqPW0mkH
	 QfaMgY+UUkkkytsC5vHePWKwxJrKBkANmRAYGjDV+Q2my3gJLrVYB4Z/Po2Z43kcYN
	 IybH0GcKSM13guDdDdqsXtwsggpdpIscxUDUC52AYkIoAL5MiebncpDg3UGmqc+Ao+
	 d3IitzGN1LLAwxWMrxHq4bIy8HwRnpSfJmTbTOPQkCUe5Mavb1uDLTQFteLjp0r/zB
	 R+IoXORyCb0v4K8ePyuABqOrlEunNh2/DmObqL+qFGSBUUCJClFGTW3NeEx2Nsh+SQ
	 hTuQdLfa4iRdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9CE92CE1D2B; Fri, 24 Jan 2025 12:37:32 -0800 (PST)
Date: Fri, 24 Jan 2025 12:37:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] clocksource: Defer preempt_disable() after
 clocksource_verify_choose_cpus()
Message-ID: <ba435a6c-ace6-4e14-bda1-5289cde23176@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250124185923.3610964-1-longman@redhat.com>
 <20250124185923.3610964-2-longman@redhat.com>
 <a6818bae-1993-47ad-ac39-75fcfca38fc6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6818bae-1993-47ad-ac39-75fcfca38fc6@paulmck-laptop>

On Fri, Jan 24, 2025 at 12:25:19PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 24, 2025 at 01:59:23PM -0500, Waiman Long wrote:
> > The following bug report happened in a PREEMPT_RT kernel.
> > 
> > [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
> > [   30.962673] preempt_count: 1, expected: 0
> > [   30.962676] RCU nest depth: 0, expected: 0
> > [   30.962680] 3 locks held by kwatchdog/2012:
> > [   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
> > [   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
> > [   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
> > [   30.977827] Preemption disabled at:
> > [   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
> > [   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
> > [   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
> > [   30.982846] Call Trace:
> > [   30.982850]  <TASK>
> > [   30.983821]  dump_stack_lvl+0x57/0x81
> > [   30.983821]  __might_resched.cold+0xf4/0x12f
> > [   30.983824]  rt_spin_lock+0x4c/0x100
> > [   30.988833]  get_random_u32+0x4f/0x110
> > [   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
> > [   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
> > [   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
> > [   30.993898]  clocksource_watchdog_kthread+0x18/0x50
> > [   30.993898]  kthread+0x114/0x140
> > [   30.993898]  ret_from_fork+0x2c/0x50
> > [   31.002864]  </TASK>
> > 
> > It is due to the fact that get_random_u32() is called in
> > clocksource_verify_choose_cpus() with preemption disabled.
> > If crng_ready() is true by the time get_random_u32() is called, The
> > batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
> > it is a rtmutex and we can't acquire it with preemption disabled.
> > 
> > To avoid this problem, we can't call get_random_u32() with preemption
> > disabled. However, smp_processor_id() has to be called with preemption
> > disabled though and we have to exclude the current CPU from the
> > cpus_chosen list to be tested.
> > 
> > Extract current CPU removal code out from
> > clocksource_verify_choose_cpus() and defer the preempt_disable()
> > call to after clocksource_verify_choose_cpus() and before
> > current CPU removal. Also use raw_smp_processor_id() in
> > clocksource_verify_choose_cpus().
> > 
> > Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
> > Signed-off-by: Waiman Long <longman@redhat.com>
> 
> Good catch!
> 
> But we don't need cryptographically secure random numbers (or blistering
> speed) here.  Substituting something like torture_random()%nr_cpu_ids
> for get_random_u32_below() work?

I suppose I should add my concern...  If we don't have preemption disabled
across this code, we cannot reliably avoid attempting to IPI ourselves.

							Thanx, Paul

> > ---
> >  kernel/time/clocksource.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 77d9566d3aa6..8ffec49971ac 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -313,7 +313,6 @@ static void clocksource_verify_choose_cpus(void)
> >  	if (n < 0) {
> >  		/* Check all of the CPUs. */
> >  		cpumask_copy(&cpus_chosen, cpu_online_mask);
> > -		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
> >  		return;
> >  	}
> >  
> > @@ -322,9 +321,13 @@ static void clocksource_verify_choose_cpus(void)
> >  	if (n == 0 || num_online_cpus() <= 1)
> >  		return;
> >  
> > -	/* Make sure to select at least one CPU other than the current CPU. */
> > +	/*
> > +	 * Make sure to select at least one CPU other than the current CPU.
> > +	 * raw_smp_processor_id() is used opportunistically here as
> > +	 * preemption isn't disabled.
> > +	 */
> >  	cpu = cpumask_first(cpu_online_mask);
> > -	if (cpu == smp_processor_id())
> > +	if (cpu == raw_smp_processor_id())
> >  		cpu = cpumask_next(cpu, cpu_online_mask);
> >  	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> >  		return;
> > @@ -349,9 +352,6 @@ static void clocksource_verify_choose_cpus(void)
> >  		if (!WARN_ON_ONCE(cpu >= nr_cpu_ids))
> >  			cpumask_set_cpu(cpu, &cpus_chosen);
> >  	}
> > -
> > -	/* Don't verify ourselves. */
> > -	cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
> >  }
> >  
> >  static void clocksource_verify_one_cpu(void *csin)
> > @@ -373,15 +373,18 @@ void clocksource_verify_percpu(struct clocksource *cs)
> >  	cpumask_clear(&cpus_ahead);
> >  	cpumask_clear(&cpus_behind);
> >  	cpus_read_lock();
> > -	preempt_disable();
> >  	clocksource_verify_choose_cpus();
> > +	preempt_disable();
> > +
> > +	/* Don't verify ourselves. */
> > +	testcpu = smp_processor_id();
> > +	cpumask_clear_cpu(testcpu, &cpus_chosen);
> >  	if (cpumask_empty(&cpus_chosen)) {
> >  		preempt_enable();
> >  		cpus_read_unlock();
> >  		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
> >  		return;
> >  	}
> > -	testcpu = smp_processor_id();
> >  	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
> >  		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
> >  	for_each_cpu(cpu, &cpus_chosen) {
> > -- 
> > 2.47.1
> > 
