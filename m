Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976D4FC8E9;
	Fri, 16 Oct 2026 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166932; cv=none; b=pC4Mo817thYUGIRYf07n8w3UvPQVm3hs5TLUdJ+MtKUSofOmshurB+HUWp4fmo+apmqfA3p6QZMfKe1W1A/p/11pfGIrKO8ga/UroMVS82/J6hEuS7bgfrmemXSJbbuecXYLz1FXIC0ZPMWpC3KpnfKZNbGW5C1MTeXEAHBYzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166932; c=relaxed/simple;
	bh=TFrbtsw4/NWtxnrV40DvdCowWXBoBbsoKgaf+ovSJ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBrpfxP6Pztqs9xb3eRHmUVOjUfY1D7jK5ntH00KacYpB1WClAfhKkwvZ0LjEBQ9Oad9d5cjnl5JQLDFBjkdm9/RBTLaTOuSrnKCL5OnoOog97PdmF1pDRk05hFU+a3w5W2Arg/8mrEC9CER8l08v1Durt3NqNZ1rmKi91KAwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaVgmzB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaVgmzB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1B91F000C4;
	Fri, 16 Oct 2026 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166931;
	bh=CvxbrF9+7kJSGUOwpuxXUeWuwLElfWufjL06nR8gAR4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LaVgmzB8RYqIljRwSEaqwHjFKIrreMWVzrkmgJ4yoRYwmbFa8bm0RruErKOO01CUx
	 53NZfv4dRYK5fzdJezSXAHPOssQxUfwVMmqPFsmD2dHOLj3svB6LPUw2kNuvl++wBk
	 FYwrn8vyAdJHzgrR0Sxkal8IeAxvcWb0grcmOXApFyFmdAjHwodGAXFfdkhrJ86We2
	 w5ubbABzVDjKB39yIcOeKeOTmboW2f2SAvLk1df+IYS1+yrpcNodGSykhvJdHNv387
	 R3hLaoEQZcWF+cGxvTN/2x3yG1MvZsPSLM+zqP6X5S23UiFtdbUskVsFg+bWmLUyM3
	 fo/TZLABCP/LA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8192CE0854; Fri, 16 Oct 2026 09:08:50 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:08:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <974da9b7-4168-4345-8f04-ec18b32ac7df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
 <a92f4a71-614f-44e4-b4f1-38e92deffae2@amd.com>
 <20261016072500.GX4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016072500.GX4120091@noisy.programming.kicks-ass.net>

On Fri, Oct 16, 2026 at 09:25:00AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 16, 2026 at 10:14:27AM +0530, K Prateek Nayak wrote:
> 
> > > @@ -372,17 +381,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  	while (i) {
> > >  		t = ts[--i];
> > > -		if (task_call_func(t, check_slow_task, &rscr))
> > > +		if (task_call_func(t, check_slow_task, &rscr)) {
> > >  			pr_cont(" P%d", t->pid);
> > > -		else
> > > -			pr_cont(" P%d/%d:%c%c%c%c%c%c",
> > > +		} else {
> > > +			tc = rscr.rcu_rdr_cpu_task;
> > > +			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
> > >  				t->pid, rscr.nesting,
> > >  				".b"[rscr.rs.b.blocked],
> > >  				".q"[rscr.rs.b.need_qs],
> > >  				".e"[rscr.rs.b.exp_hint],
> > >  				".l"[rscr.on_blkd_list],
> > >  				".R"[rscr.rcu_rdr_running],
> > > -				".B?"[rscr.rcu_rdr_boosted]);
> > > +				".B?"[rscr.rcu_rdr_boosted],
> > > +				rscr.rcu_rdr_cpu,
> > > +				rscr.rcu_rdr_cpu_offline ? "!" : "",
> > > +				tc ? tc->comm : "???",
> > > +				tc ? tc->pid : -1,
> > > +				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
> > > +		}
> > >  		lockdep_assert_irqs_disabled();
> > 
> > ... since you are IRQs disabled, it should be fine to use it here.
> > 
> > If you don't want to take the overhead of rq_lock() + barrier,
> > you can perhaps define a cpu_curr_snapshot_rcu() like:
> > 
> >     struct task_struct *cpu_curr_snapshot_rcu(int cpu)
> >     {
> >         return rcu_dereference_all(cpu_curr(cpu));
> >     }
> > 
> > in kernel/sched/core.c and expose it similar to
> > cpu_curr_snapshot().
> > 
> > I'll let Peter comment if he hates it or not ;-)
> 
> I would much rather do this than expose rq_lock().

Thank you both!  Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit 1468f6acb32add422b8f4dcebc0d75e7fd4b95aa
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Sep 28 13:35:01 2026 -0700

    rcu: Print CPU that preempted stalled reader wants to run on
    
    This commit uses the dirty trick of defining an rcu_cpu_curr() within
    kernel/sched/core.c in order to allow the RCU CPU stall warning call out
    the CPU that a task preempted within an RCU reader would like to run on.
    In addition, print out the task (if any) currently running on that CPU,
    and add an exclamation mark ("!") after the CPU number if that CPU is
    currently offline.
    
    This is a potential step towards allowing people (or LLMs, for that
    matter) to locate any tasks that might be preventing the preempted RCU
    reader task from running.
    
    [ paulmck: Apply feedback from K Prateek Nayak and Peter Zijlstra. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cca..3606e5a2cec32 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2532,3 +2532,5 @@ extern void migrate_enable(void);
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
 #endif
+
+struct task_struct *cpu_curr_snapshot_rcu(int cpu);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 803a56af3259f..33e953bb40b33 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -309,6 +309,9 @@ struct rcu_stall_chk_rdr {
 	bool on_blkd_list;
 	bool rcu_rdr_running;
 	int rcu_rdr_boosted;
+	int rcu_rdr_cpu;
+	int rcu_rdr_cpu_offline;
+	struct task_struct *rcu_rdr_cpu_task;
 };
 
 /*
@@ -317,8 +320,10 @@ struct rcu_stall_chk_rdr {
  */
 static int check_slow_task(struct task_struct *t, void *arg)
 {
+	int cpu;
 	struct rcu_node *rnp;
 	struct rcu_stall_chk_rdr *rscrp = arg;
+	struct task_struct *th;
 
 	if (task_curr(t))
 		return -EBUSY; // It is running, so decline to inspect it.
@@ -327,6 +332,10 @@ static int check_slow_task(struct task_struct *t, void *arg)
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
 	rscrp->rcu_rdr_running = task_curr(t);
 	rscrp->rcu_rdr_boosted = 0;
+	rscrp->rcu_rdr_cpu = cpu = task_cpu(t);
+	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
+	// Interrupt are disabled for RCU read-side critical section. 
+	rscrp->rcu_rdr_cpu_task = th = cpu_curr_snapshot_rcu(cpu);
 	if (rscrp->on_blkd_list) {
 		rnp = READ_ONCE(t->rcu_blocked_node);
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -352,6 +361,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	int ndetected = 0;
 	struct rcu_stall_chk_rdr rscr;
 	struct task_struct *t;
+	struct task_struct *tc;
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
@@ -372,17 +382,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	while (i) {
 		t = ts[--i];
-		if (task_call_func(t, check_slow_task, &rscr))
+		if (task_call_func(t, check_slow_task, &rscr)) {
 			pr_cont(" P%d", t->pid);
-		else
-			pr_cont(" P%d/%d:%c%c%c%c%c%c",
+		} else {
+			tc = rscr.rcu_rdr_cpu_task;
+			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
 				t->pid, rscr.nesting,
 				".b"[rscr.rs.b.blocked],
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list],
 				".R"[rscr.rcu_rdr_running],
-				".B?"[rscr.rcu_rdr_boosted]);
+				".B?"[rscr.rcu_rdr_boosted],
+				rscr.rcu_rdr_cpu,
+				rscr.rcu_rdr_cpu_offline ? "!" : "",
+				tc ? tc->comm : "???",
+				tc ? tc->pid : -1,
+				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
+		}
 		lockdep_assert_irqs_disabled();
 		put_task_struct(t);
 		ndetected++;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 559735f71b5dd..1fa63eee528c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11320,3 +11320,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+// Not for mainline, but hopefully someone has a trick that gets this
+// job done.
+struct task_struct *cpu_curr_snapshot_rcu(int cpu)
+{
+	return rcu_dereference_all(cpu_curr(cpu));
+}
