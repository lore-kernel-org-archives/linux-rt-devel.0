Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CF284B4B;
	Thu, 10 Apr 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288869; cv=none; b=eHoJCLW5GPAFjzNrxQa/4v/lSlgLc1qJ9+F0n3uFIIFV2Z6vDGbsdNFtlVkuzcXshmWHDVwOXNeD3/xOiHSoDoV4dhsV55TJDe7siMUm5Ds0ddPdB65ubl/gbvJaNDZAjWHBywYoUYipDc0WJv4c4dJYiHdZHi4r/9IPv0bxLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288869; c=relaxed/simple;
	bh=6kR3UnoHJX32Feeb+IIZW6yY378hwVxWM9UoyJsdsQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVsKkPWWmh523hbZ3Zfoh0oss69o5Z/sHoXSPZUmLfr36KmzJ17Li1bccEWfJPgST1dFyumEPWh2hqDNSOEnBZOYN7foSG//7PydtcLkSwdJhN2GzhQXpkRWh/uSzbcbfsT4640lWFI0EyShNv7XssL8hI2pCcJQLN+/Ia4oB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yh+DoUCY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yh+DoUCY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MAhRo0vfZyG5mWuwbaXdNpC34PBmmVSfGE392I46BCA=; b=Yh+DoUCYzJ4igA6Kycnyvv2+g7
	ZoMLHe176T5PjJLBpaB7trpJ/cTj3Pa9l4aNpRfU85hHCX/+vCE7ouQ3n5aqvJAbyL+r8LGoJCQV+
	h5pvSi48sAIvv7VQbX9dyMndf1AynYVuvWl9NJOk7j/TsvKZnG4NmqPUfFO1Dxf65NGpVjaR5NN4h
	IosG+pHrvxxXYzGSBur6aAFVxxxLho0tKNUCfph4vcO3T2jB33K/EEpMkNAFPrYh+C74GdeF8eZtN
	uBnaZniX0KR64b4kIfiX/20DHfKTkOo6d6IkWakuUFivDPvcFPhiNEO3eOLa/wMfGAFM1HK2j6lHU
	eqGGfr2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2rDH-00000002tCY-33G5;
	Thu, 10 Apr 2025 12:41:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6E963003FA; Thu, 10 Apr 2025 14:40:59 +0200 (CEST)
Date: Thu, 10 Apr 2025 14:40:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, lclaudio00@gmail.com
Subject: Re: [PATCH v3] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250410124059.GA9833@noisy.programming.kicks-ass.net>
References: <Z_e0uh36Ezz6isYo@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_e0uh36Ezz6isYo@uudg.org>

On Thu, Apr 10, 2025 at 09:10:12AM -0300, Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
> 
> 	rt_mutex_adjust_prio_chain()
> 	  put_task_struct()
> 	    __put_task_struct()
> 	      sched_ext_free()
> 	        spin_lock_irqsave()
> 	          rtlock_lock() --->  TRIGGERS
> 	                              lockdep_assert(!current->pi_blocked_on);
> 
> Fix that by unconditionally resorting to the deferred call to
> __put_task_struct().
> 
> v2: (Rostedt) remove the #ifdef from put_task_struct() and create
>     tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
> 
> v3: (Sebastian and PeterZ) always call the RCU deferred __put_task_struct().

Changelog goes below the --- line.

> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  include/linux/sched/task.h |   20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 0f2aeb37bbb04..49847efe5559e 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -134,22 +134,12 @@ static inline void put_task_struct(struct task_struct *t)
>  		return;
>  
>  	/*
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> -		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> -
> -		lock_map_acquire_try(&put_task_map);
> -		__put_task_struct(t);
> -		lock_map_release(&put_task_map);
> -		return;
> -	}

I don't think you've substantiated why the !PREEMPT_RT case needs to go.

> -
> -	/*
> -	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * In !RT, it is always safe to call __put_task_struct(),
> +	 * but under PREEMPT_RT, we can't call put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
>  	 *
>  	 * call_rcu() will schedule delayed_put_task_struct_rcu()
>  	 * to be called in process context.
> -- 
> 2.49.0
> 
