Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BB748F;
	Wed,  2 Oct 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882310; cv=none; b=uDXjTgHSQgEWzUo1PCjSntVU8yV9GlKxHLIlF3Vi3QRCI39TsgXoX3PzHjkg9DLOEUuTk8rsR+k9rHTgS1LIytQ+OzDr/w+Dqy3VobiEucewRdH/YNdH1Ui0T1Skbuer8suei3bpnYbGde/BR1GiyyrXyDLOKOZr1W7BTUZbPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882310; c=relaxed/simple;
	bh=bIW3n6eCI6NBaqDEZCXu3bVmiRgME8xNjq6mKY6aF6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c81Oe5LMWYTit6zh0IbwRCoMKA3CE071+VWdDdhuWTJzFD9RIV0y+rCRVveCLyKtPX4482e3Xtw/6dyMEZoACzZxVHkZqdC89oKll8uzK7dLEgQFN5V5wDzMvnO+h57FRnHIWkZ8+rnM/4FpHB0+/OUbKP1blrBbBUTDpI6SuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC7BC4CEC2;
	Wed,  2 Oct 2024 15:18:29 +0000 (UTC)
Date: Wed, 2 Oct 2024 11:19:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Ben Segall
 <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman
 <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, Valentin
 Schneider <vschneid@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Repeated rto_push_irq_work_func() invocation.
Message-ID: <20241002111920.12cdc78e@gandalf.local.home>
In-Reply-To: <20241002150543.IhYy2Q9k@linutronix.de>
References: <20241002112105.LCvHpHN1@linutronix.de>
	<20241002103749.14d713c1@gandalf.local.home>
	<20241002150543.IhYy2Q9k@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 17:05:43 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2024-10-02 10:37:49 [-0400], Steven Rostedt wrote:
> > On Wed, 2 Oct 2024 13:21:05 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > Would it make sense to avoid scheduling rto_push_work if rq->curr has
> > > NEED_RESCHED set and make the scheduler do push_rt_task()?  
> > 
> > Can we safely check rq->curr without taking any locks on that CPU?
> > 
> > I guess tasks do not get freed while a CPU has preemption disabled, so it
> > may be safe to do:
> > 
> > 	task = READ_ONCE(rq->curr);
> > 	if (test_task_need_resched(task))
> > 		/* skip */
> > 
> > ??  
> 
> +rcu_read_lock() but yes. This would be one part. You need to check if

Yeah, preempt_disable() is pretty much equivalent today to rcu_read_lock(),
as synchronize_rcu() and synchronize_sched() have been merged into one.

> the task on pull-list has lower priority than the current task on rq.
> This would be need to be moved to somewhere in schedule() probably after
> pick_next_task().

Does it matter? The target CPU has NEED_RESCHED set, which should handle
the pushing logic anyway, right?

Hmm, I probably should look deeper to make sure that anytime a schedule
happens where there's overloaded RT tasks, it tries to push.

-- Steve
