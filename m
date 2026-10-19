Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431041;
	b=F4lN5+p9dmi/71RECKektBblnfotm3oqTMeSWVEan63HQ/w7Wy1ijiZRt6jUNFmOGiPk
	 dcj+Xg2vYLPNt4Ku1kSxsNIgp3UITxF1NJmIuQI/SyLTAXUTlwSFPNsp7XFa++XaPY/SV
	 wYOVB1hT97hWqMcsQUSH1GLUQoYytd/WBLEXuRSKiDQFG0K6HmGzWRGnw41Txfu8eFKQw
	 iCausl6oyQRtTR1gtiB3a4RUwjd1JFA+ylB4/TvadeKIkuDp7bPgTv6zAlmSykxwMDOeG
	 CYc/3aORbnlya4ysTc7MJRLWOXO8D6eIfpRHQlrWMxC/XIinHMNVGKllypEO2tk2XDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431041;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=lXS3s/Em2HJXXRGGBF2jVlZ4nf9XOwRZqcFKv6Ie1/0=;
	b=35gOR5yxGxRQoJAZaWkkRksxOZK4QtgpLaeJYA22dMyX+sSbiwRKNMJd9adYINyZPzjr
	 hw7iBklEc8CVjkYOiYej/88daWO6nAKuPgsdqjpFjqTpjICU+r0drCpwg36T72q6AAi11
	 Hil0zifaeDSN2nguwC6eMCei086mHWniKxZfbsRw7x6d2VbVwuH3xQtcJYiLu40LTt9Jg
	 yUlHqSEf+M+tju3IMBTiI4QM8xZshbGk+Gag2PwBsL+qAaxW99vNWsg7pksFFTo8eju/7
	 nwtTYXKojYydVqX33EmCEImEnXCjkTdcW8KiF5ISIFg8Fr6fxJNFeuehyhLz3dWL8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9vl+JM2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C21606A31D
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9vl+JM2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A17E1F000C4;
	Mon, 19 Oct 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431040;
	bh=lXS3s/Em2HJXXRGGBF2jVlZ4nf9XOwRZqcFKv6Ie1/0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=g9vl+JM2NpJaIowIis0ZAHQDXx6IJSgyqUD74IlSegU+3nLG0G64ZZxV10Ib4Xefu
	 zFo/BPf5BVo8HIS2/dU7qg4c7oK0SoseHfqUXqywUo0L2Jn6lN1gHeYitONzd+/ooe
	 zqADxIFevZi9RBdsqQFWoLPGdy7Y5GM1gObea71J/L9oW83pRit8ruEBph+R5ypsry
	 +4ghMrtsHetOcXxQTCavjJt1ncnR/zzOgXDKjZV7BDorlvjclpTwMH1OBorYWYCj+F
	 GnfXp0lwJXs6C2n1cTxuQT8tJVp7zjxmidez6kJq/6ugXDR5aBH6nTbTpo6TjIn2rE
	 3f68fC44EWTBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 21455CE09FC; Mon, 19 Oct 2026 10:30:40 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:30:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <846ce517-b063-4dc9-867a-603ff49bfd79@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016112339.6d6ac80a@gandalf.local.home>
 <7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
 <20261016121753.0da4e4e1@gandalf.local.home>
 <d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
 <20261016125453.36ae8efe@gandalf.local.home>
 <112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
 <20261016134030.6791c1e4@gandalf.local.home>
 <4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
 <fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
 <20261018102107.210318fa@fedora>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018102107.210318fa@fedora>

On Sun, Oct 18, 2026 at 10:21:07AM -0400, Steven Rostedt wrote:
> On Sat, 17 Oct 2026 12:02:08 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > 
> > > Or we can rely on interrupts being disabled across the full call to
> > > rcu_print_task_stall().  This interrupts-disabled region acts as an RCU
> > > read-side critical section, so that the call_rcu() in put_task_struct()
> > > cannot invoke its callback (and thus cannot free the task_struct
> > > structure) until some time after rcu_print_task_stall().
> > > 
> > > Does that work, or am I still missing something?  
> > 
> > Except that if this is the case, then I don't need get_task_struct()
> > in the first place for any of them, do I?  I can instead just rely on
> > the call_rcu() in put_task_struct() that had to have happened sometime
> > after picking up the pointer to each task structure.
> 
> I was thinking that since this is called via a RCU stall, would RCU
> still make progress? This is for task RCU right? But as you said, if
> interrupts are disabled here, it becomes a RCU grace period itself. And
> yeah, I don't think we need to call any get_task_struct() at all.

This is for vanilla RCU, not tasks RCU.  There was a time when I agreed
that it was not necessary to worry about the RCU grace period making
progress while the stall-warning message was being printed, but objective
reality taught me otherwise.  ;-)

Very good, the new version shown below does no get_task_struct().

> > I clearly need to go through this one step by step and upgrade it as
> > needed from a debugging hack to a proper patch.
> > 
> > > (And yes, even if it doesn't work, comments might be nice.)  
> > 
> > But this point still holds.  ;-)
> 
> Exactly. A nice big comment saying "we are creating a RCU grace period
> here that would prevent put_task_struct() from freeing any tasks, so
> any tasks we reference now will still exist when printing (as long as
> we never re-enable interrupts)." Or something like that.

I put short comments where the get_task_struct() calls used to be,
and added a longer explanation in the commit log.  Does this work,
or would something else be better?

							Thanx, Paul

------------------------------------------------------------------------

commit a3f59574592f58d074f5f66c9e5385548164dc82
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Sep 28 13:35:01 2026 -0700

    rcu: Print CPU that preempted stalled reader wants to run on
    
    This commit defines a cpu_curr_snapshot_rcu() function that invokes
    rcu_dereference_all(cpu_curr()) to determine which task is currently
    running on the specified CPU.  The RCU CPU stall warning then uses this
    new function in order to print the task that has preempted the stalled
    task (the stalled task being the one that is in an RCU read-side critical
    section, thus preventing the current RCU grace period from completing).
    This modified stall-warning message also includes the CPU, along with
    an exclamation mark ("!") after the CPU number if that CPU is currently
    offline.
    
    This is a potential step towards allowing people (or LLMs, for that
    matter) locate any tasks that might be preventing the preempted RCU
    reader task from running.
    
    Adding a get_task_struct() for the currently running task would be a
    bug because we are not in a position to prevent that task from exiting.
    Yes, yes, because interrupts are disabled throughout, the corresponding
    task_struct structure cannot be freed, but following sequence of events
    is all too possible:
    
    o       The check_slow_task() function places a pointer to the task_struct
            structure in its local variable "th".
    
    o       The corresponding task exits, reducing its task_struct structure's
            ->usage to zero.  The task_struct structure is therefore passed
            to call_rcu().
    
    o       The check_slow_task() function invokes get_task_struct(th),
            setting th->usage to one.
    
    o       The rcu_print_task_stall() function invokes put_task_struct(),
            again reducing ->usage to zero, and again passing the task
            struct to call_rcu().  This results in either double-call_rcu()
            or use-after-free, depending on when the RCU grace period for
            the first call_rcu() completes.  Both outcomes are bad.
    
    This commit therefore relies solely on disabled interrupts acting as
    an implicit RCU read-side critical section that prevents all of the
    task_struct structures from being freed, thus avoiding the need for
    get_task_struct().
    
    The original get_task_struct() calls in rcu_print_task_stall() on the
    tasks on the ->blkd_tasks list are safe because those tasks cannot exit
    without first acquiring the rcu_node ->lock that this code already holds
    (because these tasks must remove themselves from the ->blkd_tasks list).
    But it is better to be consistent and rely on RCU in both cases.
    These pre-existing get_task_struct() and put_task_struct() calls are
    therefore removed.
    
    [ paulmck: Apply feedback from K Prateek Nayak and Peter Zijlstra. ]
    [ paulmck: Apply feedback from Steven Rostedt. ]
    
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
index 803a56af3259f..08699652f51c2 100644
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
@@ -327,6 +332,13 @@ static int check_slow_task(struct task_struct *t, void *arg)
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
 	rscrp->rcu_rdr_running = task_curr(t);
 	rscrp->rcu_rdr_boosted = 0;
+	rscrp->rcu_rdr_cpu = cpu = task_cpu(t);
+	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
+	lockdep_assert_irqs_disabled();
+	rscrp->rcu_rdr_cpu_task = th = cpu_curr_snapshot_rcu(cpu);
+	// There is no need for get_task_struct(t) because we are in
+	// an implicit RCU read-side critical section due to interrupts
+	// being disabled.
 	if (rscrp->on_blkd_list) {
 		rnp = READ_ONCE(t->rcu_blocked_node);
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -352,6 +364,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	int ndetected = 0;
 	struct rcu_stall_chk_rdr rscr;
 	struct task_struct *t;
+	struct task_struct *tc;
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
@@ -364,7 +377,9 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		get_task_struct(t);
+		// There is no need for get_task_struct(t) because we
+		// are in an implicit RCU read-side critical section due
+		// to interrupts being disabled.
 		ts[i++] = t;
 		if (i >= ARRAY_SIZE(ts))
 			break;
@@ -372,19 +387,25 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
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
-		put_task_struct(t);
 		ndetected++;
 	}
 	pr_cont("\n");
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
