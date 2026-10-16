Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98131317166;
	Fri, 16 Oct 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135520; cv=none; b=NJ80JFdjsGvfkiBjvMTGxG6VLVA4d9PWw1AW9GGI75lDoaVCwEIqggoOZx9UDAscjXCA8oea5YrnPgAQt61/CQqjEVwO+MC1eJoSt0MuAR4dq/mN9XNDKmJKxE6q19RVBsKccTbue9y7/DobPzS+JtGyRuCPLjDf9PiycG7HCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135520; c=relaxed/simple;
	bh=WQ7A6YV1X5rtoOgXLneHcDdEPkWAi8eOIa8D6Hucz+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozuh7tUZB9FP/Ut5ZGITIkmj3plxkjQ0HXsHs+LVD950/+8e0hcHGQjlHqtDZ8qllrV2lEjewfYDfF0eudI4lsrpA8h5bo/pTYui2zzn3Uv4AUTD1+3Xz5FLyxHtswzUCovLNTOgFAcbb7SBzCqEvJfJ1gm4eUWbquMebXfbnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FGf5Ae24; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGf5Ae24"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MV+/6u1JVk3GRqSO5E1FrxLlCsGxVSGy9Af+ZhLfD9U=; b=FGf5Ae24hhb9zfjAZw1KNjdgUa
	xmUh4Q8Ua3vygWewRMjrXKyL99ZyDy5RZF/+kTIqmRD+F9OeN4jc8q0z0NTfWJD/+AK6n0iv+gaoy
	MtIuadwhNGfQBSBGLQtDl1nSz9ipxJX+Csh6UXgVDJEL/j92BhzqzJxhfojvnZl/EUfj15ipUi27a
	0mXEtDegxnkKCjmmK7SZ2SzQsSPM5s7pHxEIm4Jxn+Kkxlc5SHdBRv5F5tJ6BFMsB4+KLzQQSW2A0
	6DSa3twsVQzj/Lf7hHpQriivxPv5d/LxCypIspxLqGjLIg8NUKUtSF2maWTX/oZfmm2jDtJ1HivaH
	vL921QJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHcJJ-00000001CxA-3bdx;
	Fri, 16 Oct 2026 07:25:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5AD68300178; Fri, 16 Oct 2026 09:25:00 +0200 (CEST)
Date: Fri, 16 Oct 2026 09:25:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: paulmck@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: Mapping from preempted task to running task on same CPU
Message-ID: <20261016072500.GX4120091@noisy.programming.kicks-ass.net>
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
 <a92f4a71-614f-44e4-b4f1-38e92deffae2@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92f4a71-614f-44e4-b4f1-38e92deffae2@amd.com>

On Fri, Oct 16, 2026 at 10:14:27AM +0530, K Prateek Nayak wrote:

> > @@ -372,17 +381,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  	while (i) {
> >  		t = ts[--i];
> > -		if (task_call_func(t, check_slow_task, &rscr))
> > +		if (task_call_func(t, check_slow_task, &rscr)) {
> >  			pr_cont(" P%d", t->pid);
> > -		else
> > -			pr_cont(" P%d/%d:%c%c%c%c%c%c",
> > +		} else {
> > +			tc = rscr.rcu_rdr_cpu_task;
> > +			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
> >  				t->pid, rscr.nesting,
> >  				".b"[rscr.rs.b.blocked],
> >  				".q"[rscr.rs.b.need_qs],
> >  				".e"[rscr.rs.b.exp_hint],
> >  				".l"[rscr.on_blkd_list],
> >  				".R"[rscr.rcu_rdr_running],
> > -				".B?"[rscr.rcu_rdr_boosted]);
> > +				".B?"[rscr.rcu_rdr_boosted],
> > +				rscr.rcu_rdr_cpu,
> > +				rscr.rcu_rdr_cpu_offline ? "!" : "",
> > +				tc ? tc->comm : "???",
> > +				tc ? tc->pid : -1,
> > +				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
> > +		}
> >  		lockdep_assert_irqs_disabled();
> 
> ... since you are IRQs disabled, it should be fine to use it here.
> 
> If you don't want to take the overhead of rq_lock() + barrier,
> you can perhaps define a cpu_curr_snapshot_rcu() like:
> 
>     struct task_struct *cpu_curr_snapshot_rcu(int cpu)
>     {
>         return rcu_dereference_all(cpu_curr(cpu));
>     }
> 
> in kernel/sched/core.c and expose it similar to
> cpu_curr_snapshot().
> 
> I'll let Peter comment if he hates it or not ;-)

I would much rather do this than expose rq_lock().

