Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8F14F9F3;
	Sat, 25 Jan 2025 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737780389; cv=none; b=JQ3D6H3XkCRuhAhfCyQSF0UKJ4PCEzYWGiXKkjmLrbJ7MHXq9WJBLdYn1m07m32BkFVNF6tum3eL9v+67AMejrisWcFNCFRzM5mhefqNO+0v5sQOuVlbcHby9B7ZJO9ZAryoHzaOLLxpV6a6Z/5ey9e2Ul/b8oLdC5HcLyFTJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737780389; c=relaxed/simple;
	bh=+Wm5mNFWxRQFyCX6hnulFZ3ZUMg++cTNYaxnftRaogo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q67GCGQ1lKwcIDYz5bPp19AObknfNmBrHn7+YDHc4fcurz8AO0zegVC8hReEW4E77idgLr8721ne/LTh10ufKrXGGEaUZv/e4HbiHR6w2+Jx774DXRBqkxJJ52JmcvGG6VKiqiybD9NgghDcqyAKWb8EYKDj/sMwGXvVacPYESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXhWeeA0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXhWeeA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE9C4CED6;
	Sat, 25 Jan 2025 04:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737780388;
	bh=+Wm5mNFWxRQFyCX6hnulFZ3ZUMg++cTNYaxnftRaogo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cXhWeeA0IMGLiml9Z1aGWnngb+ik06LgzUa7uTnP9On9BnLyu5dN254wCar+erIJ1
	 46jev7Bo+aEJp57OjGaPcdAZwWOsg3AtTx+wMTKv4nJ7I9Dw8/xnoxRIXuHoalyP4z
	 +O0R8bIWEStyJw8jPLAhb09ZF5wrEd4ifZTSeYMNZm96x7g9X/OCnhqf3SVzce89t2
	 wjSPDoegwc5OSYrYAL5xPpo/h8IxWAVD396Rkmphz0UwhILZqadWDITwpu5ft3OhCC
	 wdOJAq9Qufh6Rq5quPph0Ov9gtUYzc6H6dlyPGm43DEItMgfa+gjSgnDdOZibf3GbY
	 oSHiYw9J+7BlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 20538CE1C63; Fri, 24 Jan 2025 20:46:28 -0800 (PST)
Date: Fri, 24 Jan 2025 20:46:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
Message-ID: <57e9af03-e00d-4cc4-a881-33f36f1530ce@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250125015442.3740588-1-longman@redhat.com>
 <20250125015442.3740588-2-longman@redhat.com>
 <7532b16e-2a1d-42ee-af1c-dfb91a55d741@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7532b16e-2a1d-42ee-af1c-dfb91a55d741@redhat.com>

On Fri, Jan 24, 2025 at 09:11:27PM -0500, Waiman Long wrote:
> 
> On 1/24/25 8:54 PM, Waiman Long wrote:
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
> > Fix this problem by using the less random get_random_bytes() function
> > which will not take any lock. In fact, it has the same random-ness as
> > get_random_u32_below() when crng_ready() is false.
> > 
> > Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
> 
> Oh, I should have added
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> > Signed-off-by: Waiman Long <longman@redhat.com>

Works for me!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> > ---
> >   kernel/time/clocksource.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index 77d9566d3aa6..659c4b79119c 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -340,9 +340,13 @@ static void clocksource_verify_choose_cpus(void)
> >   	 * and no replacement CPU is selected.  This gracefully handles
> >   	 * situations where verify_n_cpus is greater than the number of
> >   	 * CPUs that are currently online.
> > +	 *
> > +	 * The get_random_bytes() is used here to avoid taking lock with
> > +	 * preemption disabled.
> >   	 */
> >   	for (i = 1; i < n; i++) {
> > -		cpu = get_random_u32_below(nr_cpu_ids);
> > +		get_random_bytes(&cpu, sizeof(cpu));
> > +		cpu %= nr_cpu_ids;
> >   		cpu = cpumask_next(cpu - 1, cpu_online_mask);
> >   		if (cpu >= nr_cpu_ids)
> >   			cpu = cpumask_first(cpu_online_mask);
> 
