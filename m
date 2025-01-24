Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D41D89F1;
	Fri, 24 Jan 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754663; cv=none; b=UhcB6uqjsA40lfYooHBkiS+uxAGW6xG1/w2lbBnwwKeTO1EIn6sHJ5dAqA74yr4OBGH1Nyp2KCdvtPW7swmswZxH2Y6tnAMJzJt+ll1TxptxqdLFZHT1UBvIU5cdZ0iy+pAH9br/i+8BU52PdGK8dnbzm+z2nZjs1tcI790DghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754663; c=relaxed/simple;
	bh=rjPhSgkHfFwfPecrqg/9bviiHX/f6QrUdTtZnKBQLwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXBCQvl527EPmNntKA/sW9/rZM0H/c0EemmDOzf34mN/MMdki4UeIm1VFjjPSn/TnVw4ghfEU5vRYweDPrrrLusryEagefYf9ZmY+abG3X3e00vtg2BYnWKtN4WO+h+mrtv9X1UIpswwvMAuDzLoYS3ChMFIUixf9K7BqRzlYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPMuJyDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPMuJyDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF19C4CEDF;
	Fri, 24 Jan 2025 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737754663;
	bh=rjPhSgkHfFwfPecrqg/9bviiHX/f6QrUdTtZnKBQLwc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pPMuJyDXz1ml8vp/N7f3+ZA/MQ4BNVrAZqQiBtYA+PLR/PuGqd0433Jbo+eDJAS6S
	 QHOujHsL3xTwqcHswTxbVpHCowgA3vLGS8XByKq4WWnguGRfsN//vvERCOD6PE1iAK
	 Eb/lBe3NgGGQ8nfJILp52W8gHlGeTemmxjK7VS61zu9/tHgnYltku71kRUcwBVhFOz
	 6keHSh3kQptIpcqoY73+Ck5E+VLM9MbLYlB9mm1cJH3Z0QPHfDzpSYy1hBVIXihdv8
	 3Np71GsbKH733nI96dJ+49nhd4U6G9gzlc04cNTl24+P01BDwJPIxOab5DaotjETXT
	 hZQBG5JwdCQVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9D787CE0A44; Fri, 24 Jan 2025 13:37:42 -0800 (PST)
Date: Fri, 24 Jan 2025 13:37:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] clocksource: Defer preempt_disable() after
 clocksource_verify_choose_cpus()
Message-ID: <751e87e0-4113-4887-8436-c4a69c82abcb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250124185923.3610964-1-longman@redhat.com>
 <20250124185923.3610964-2-longman@redhat.com>
 <a6818bae-1993-47ad-ac39-75fcfca38fc6@paulmck-laptop>
 <ba435a6c-ace6-4e14-bda1-5289cde23176@paulmck-laptop>
 <33340159-3bee-48cc-85a0-830305e736aa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33340159-3bee-48cc-85a0-830305e736aa@redhat.com>

On Fri, Jan 24, 2025 at 03:41:45PM -0500, Waiman Long wrote:
> On 1/24/25 3:37 PM, Paul E. McKenney wrote:
> > On Fri, Jan 24, 2025 at 12:25:19PM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 24, 2025 at 01:59:23PM -0500, Waiman Long wrote:
> > > > The following bug report happened in a PREEMPT_RT kernel.
> > > > 
> > > > [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > > > [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
> > > > [   30.962673] preempt_count: 1, expected: 0
> > > > [   30.962676] RCU nest depth: 0, expected: 0
> > > > [   30.962680] 3 locks held by kwatchdog/2012:
> > > > [   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
> > > > [   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
> > > > [   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
> > > > [   30.977827] Preemption disabled at:
> > > > [   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
> > > > [   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
> > > > [   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
> > > > [   30.982846] Call Trace:
> > > > [   30.982850]  <TASK>
> > > > [   30.983821]  dump_stack_lvl+0x57/0x81
> > > > [   30.983821]  __might_resched.cold+0xf4/0x12f
> > > > [   30.983824]  rt_spin_lock+0x4c/0x100
> > > > [   30.988833]  get_random_u32+0x4f/0x110
> > > > [   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
> > > > [   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
> > > > [   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
> > > > [   30.993898]  clocksource_watchdog_kthread+0x18/0x50
> > > > [   30.993898]  kthread+0x114/0x140
> > > > [   30.993898]  ret_from_fork+0x2c/0x50
> > > > [   31.002864]  </TASK>
> > > > 
> > > > It is due to the fact that get_random_u32() is called in
> > > > clocksource_verify_choose_cpus() with preemption disabled.
> > > > If crng_ready() is true by the time get_random_u32() is called, The
> > > > batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
> > > > it is a rtmutex and we can't acquire it with preemption disabled.
> > > > 
> > > > To avoid this problem, we can't call get_random_u32() with preemption
> > > > disabled. However, smp_processor_id() has to be called with preemption
> > > > disabled though and we have to exclude the current CPU from the
> > > > cpus_chosen list to be tested.
> > > > 
> > > > Extract current CPU removal code out from
> > > > clocksource_verify_choose_cpus() and defer the preempt_disable()
> > > > call to after clocksource_verify_choose_cpus() and before
> > > > current CPU removal. Also use raw_smp_processor_id() in
> > > > clocksource_verify_choose_cpus().
> > > > 
> > > > Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
> > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > Good catch!
> > > 
> > > But we don't need cryptographically secure random numbers (or blistering
> > > speed) here.  Substituting something like torture_random()%nr_cpu_ids
> > > for get_random_u32_below() work?
> > I suppose I should add my concern...  If we don't have preemption disabled
> > across this code, we cannot reliably avoid attempting to IPI ourselves.
> 
> Does the CPU choosing process itsself needs to have preemption disabled? I
> thought it was because of need to use smp_processor_id() and have the
> current CPU excluded. Preemption is still disabled after that.

If the function is migrated from one CPU to another, the check against
raw_smp_processor_id() doesn't mean much.  At that point, you might
as well just rely in the calling function clearing it.

And the extra preemption happens only in an error condition were extra
debugging is enabled.  Plus clocksource_verify_choose_cpus() should be
pretty quick.  So do we really care about the additional disabling of
preemption?

							Thanx, Paul
