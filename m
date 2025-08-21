Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986C261B91;
	Thu, 21 Aug 2025 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796245; cv=none; b=CreF5itK8Rstf6JYgFPTIumgsP4YQLE4hLoIWUd9Vres6+q9DNqT7azHp/Nh8V1e9M0NJmoBcVWd03GC+UVN1HVxNVU2+r2uawa16OB5yPILEJA7etDC3rdR3EiydxymaqhEZVBWT9A1ZgkDaou4MuQWQlXx4bSo8RVCI/0JODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796245; c=relaxed/simple;
	bh=kDOqvlOXuH69SSUuUs5DmxFUZ3wrC5hXiIXFH0hY3Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCPj2mvzslxPy8Qwhzh4g2Hdq49HPV58+MjhNg9VSqgnkUZjz0IulIT/lPhC+iNBxPa/Rw9VoC0/xSccrl3p72kakeJmbBT8/s+zeEjO4hqfjfy3mr/RT8JPhrNyTdEDyYMIl/JPR6rKdFaX8qvh5ztlOWXJJLhLbEej8JgQ2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbLh81sX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbLh81sX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BE3C4CEEB;
	Thu, 21 Aug 2025 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796244;
	bh=kDOqvlOXuH69SSUuUs5DmxFUZ3wrC5hXiIXFH0hY3Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbLh81sXm0DUflwgqtNhHdTWVp4IjzpjSqdYklFzdKdwPwEGrAa54aZ7sbtMunflO
	 zBrdhRC7JID+ve9FKkXW8vWzyoSTM2aZ/fWhuc0phuCt7pKt6qACwhbPp9FaQIJvtc
	 OuiBzBhw0cvy9djf6AcSCEMZy8wXmISy29ReKzT8LUxLjLId4l/+0CyVNN9UFwji9P
	 P/7Cm9Iis5hcRmlKlEoznjw3Ad58jtqMBKhBuTYPnDPnur//FyTNuNzgfZPns9gTcl
	 YGzQvzy8fKoi7Nteq58jVEG52gzsd5UR9LHDA7wlGTyGM/rGXl4Yi3dOcjdAH2tE4P
	 s3l/eLPZJFEMg==
Date: Thu, 21 Aug 2025 07:10:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <aKdTEkK5MBz_Fj47@slm.duckdns.org>
References: <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
 <20250821092827.zcFpdnNy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821092827.zcFpdnNy@linutronix.de>

Hello, Sebastian.

On Thu, Aug 21, 2025 at 11:28:27AM +0200, Sebastian Andrzej Siewior wrote:
...
> It is not wrong as in something will explode. The priority-inheritance
> boost is meant to give the lower priority task runtime in order to leave
> its critical section. So the task with the higher priority can continue
> to make progress instead of sitting around. Spinning while waiting for
> completion will not succeed.
> In this case "leaving the critical section" would mean complete the one
> work item. But instead we flush all of them. It is more of semantics in
> this case. That is why the looping-cancel in tasklet cancels just that
> one workitem.

Understood. However, given that these pools are per-cpu, BHs are usually not
heavily contended and canceling itself is a low frequency operation, the
practical difference likely won't be noticeable.

> > I think the main focus is keeping the
> > semantics matching on RT, right?
> 
> Yes, but having the semantics with busy waiting on a BH work is kind of
> the problem. And there is no need for it which makes it a bit difficult.
> The previous patch would match the !RT bits but we flush all work, have
> and the lock for no reason. That is why I don't like it. The majority of
> tasklet users don't need it. It is in my opinion bad semantics.
> 
> But if you insist on it, the previous patch will make it work and has
> been tested. There is not much I can do.

Oh, I'm not insisting, don't know enough to do so. Just trying to understand
the situation.

> > I'm most likely missing something about RT but wouldn't the above still lead
> > to deadlocks if the caller is non-hardirq but higher priority thread?
> 
> Not sure what you refer to. Right now there is this lock in
> local_bh_disable() which forces PI.
> Removing the whole section for RT as in this snippet gets us to the
> wait_for_completion() below. It lets the task with higher priority
> schedule out allowing task with lower priority to run. Eventually the
> barrier item completes and with the wakeup the high priority task will
> continue.
> So the high-priority task will lose runtime (allowing task with lower
> priority to run). I don't think it will be a problem because it is
> mostly used in "quit" scenarios (not during normal workload) and matches
> tasklet_disable().

Okay, so, on !RT, that busy loop section is there to allow
cancel_work_sync() to be called from BH-disabled contexts and the caller is
responsible for ensuring there's no recursion. It's not great but matches
the existing behavior. Obviously, in !RT, we can't go to
wait_for_completion() there because we can be in a non-sleepable context.

Are you saying that, in RT, it'd be fine to call wait_for_completion()
inside local_bh_disable() and won't trip any of the context warnings? If so,
yeah, we don't need any of the looping.

Thanks.

-- 
tejun
