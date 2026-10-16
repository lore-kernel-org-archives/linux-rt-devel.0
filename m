Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC62D42E8F8
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166432; cv=none; b=k2SN5W/kqlPOO18gTlJuhth3aglaPr3fnSJpUYeK1RpMOo23LydDLvZGYAtTLmxIogiGKmsyb1YkVPbR7bwCPyYZgAvSfJl1BWX4rXA5XkGQ5G/x6MMSe0kBuSXgvnyHLYiZxmtky/BeL7/0awVoO841rNVNSgQ9MToD3UgvbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166432; c=relaxed/simple;
	bh=uJPink3fGZGXeOfJ7YdCIcHCnFmK5JvCLcoU8KptqGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehyT8/+eEG0YyWAcCF7A7Xx/YK3G1K0MwXcV9OrGBwuXlQWCaIfOufnn4DExV0zq549Ly0RUg/koVxN1p1mAryuI+pH2Hfz17L6HQer/arWRn5S5zHkvLGqN/k9/m4As/RJpnqhEpfVqKbb7dgjSP0s/8MfJWLct610NpTnRTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECQnNlyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECQnNlyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7B51F000C4;
	Fri, 16 Oct 2026 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166431;
	bh=oLBVgjffSBn5s23DHDCqs3c1WFbCK/7WrEpaIk3H7cI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ECQnNlylHWId3AnzqGCY1uliFTAGi9XN1JqGQPWYJVybjnlvJrl8t9EqAEMdHaJSc
	 A1JsQlzIAwgqEKfqZbCIDhaqpQfWHQVLXmgumFIPjWa+uacwz5rqK46FqoKXL8IO8h
	 1nFW/I1kTpa2hSdfPQWmJ7N6GFCvp5Kd7So8ZoJ31ftEJLKx5j00oglB/TefmPsWC3
	 O/gAEadDc4eG7qSC07I+0CKtFe2KQSXkM4fp22t/tGkp7LdDVXvI7YE04DUnt/TYQm
	 tZUrnkqru/kbTqCCb/QIiG2L0b0qIr8/JtvjxACEtMswm2/U4b4yZFlzS5MX6TUcVY
	 eFpJfk7ijxHew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3749ACE0854; Fri, 16 Oct 2026 09:00:31 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:00:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
 <20261016112339.6d6ac80a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016112339.6d6ac80a@gandalf.local.home>

On Fri, Oct 16, 2026 at 11:23:39AM -0400, Steven Rostedt wrote:
> On Tue, 13 Oct 2026 17:41:41 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8b3d47a325cca..a8b3434edb2b4 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2532,3 +2532,5 @@ extern void migrate_enable(void);
> >  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> >  
> >  #endif
> > +
> > +struct task_struct *rcu_cpu_curr(int cpu);
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 803a56af3259f..7826c4d905248 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -309,6 +309,9 @@ struct rcu_stall_chk_rdr {
> >  	bool on_blkd_list;
> >  	bool rcu_rdr_running;
> >  	int rcu_rdr_boosted;
> > +	int rcu_rdr_cpu;
> > +	int rcu_rdr_cpu_offline;
> > +	struct task_struct *rcu_rdr_cpu_task;
> >  };
> >  
> >  /*
> > @@ -317,8 +320,10 @@ struct rcu_stall_chk_rdr {
> >   */
> >  static int check_slow_task(struct task_struct *t, void *arg)
> >  {
> > +	int cpu;
> >  	struct rcu_node *rnp;
> >  	struct rcu_stall_chk_rdr *rscrp = arg;
> > +	struct task_struct *th;
> >  
> >  	if (task_curr(t))
> >  		return -EBUSY; // It is running, so decline to inspect it.
> > @@ -327,6 +332,9 @@ static int check_slow_task(struct task_struct *t, void *arg)
> >  	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
> >  	rscrp->rcu_rdr_running = task_curr(t);
> >  	rscrp->rcu_rdr_boosted = 0;
> > +	rscrp->rcu_rdr_cpu = cpu = task_cpu(t);
> > +	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
> > +	rscrp->rcu_rdr_cpu_task = th = rcu_cpu_curr(cpu);
> >  	if (rscrp->on_blkd_list) {
> >  		rnp = READ_ONCE(t->rcu_blocked_node);
> >  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
> > @@ -352,6 +360,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> >  	int ndetected = 0;
> >  	struct rcu_stall_chk_rdr rscr;
> >  	struct task_struct *t;
> > +	struct task_struct *tc;
> >  	struct task_struct *ts[8];
> >  
> >  	lockdep_assert_irqs_disabled();
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
> 
> Is there a possible race between the call to rcu_cpu_curr() and here, where
> that task could have exited and is freed?
> 
> There's no get_task_struct() on that task.

The get_task_struct() happens in the list_for_each_entry_continue()
loop that it right before the raw_spin_unlock_irqrestore_rcu_node().

Or do I have an off-by-one bug here?

							Thanx, Paul

> -- Steve
> 
> 
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
> >  		put_task_struct(t);
> >  		ndetected++;
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index b77152edafd92..e137cba24fc92 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -11321,3 +11321,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
> >  		p->sched_class->prio_changed(rq, p, ctx->prio);
> >  	}
> >  }
> > +
> > +// Not for mainline, but hopefully someone has a trick that gets this
> > +// job done.
> > +struct task_struct *rcu_cpu_curr(int cpu)
> > +{
> > +	return cpu_curr(cpu);
> > +}
> 
