Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBE2DC32E
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938502; cv=none; b=UOaS1NuoazJXPeDMJP9CGi+9s0yICaxWq++fRzovGyfC7DeCFfbLGzY36It++EmJ1fX+lUbZ2WWILCEPUg0ZEqrXLWQ0KdQcGoFM5wPJXWFV2XobTgfldtw1HmRseNUaFTmKAAaeCYz9I9ByUSoxMBvPWLKdpMrIRmNbxXR5QjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938502; c=relaxed/simple;
	bh=ipMGWggi8OUYlmOkvwY3b4SlKRBNV6CG2lfM7WKefdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=phhOlFnBkfQECCAgsMUuopDaRrG66qh/AykRQyYLjrbVAHSZ6dQKulOCxNPhEdoFPaNY5NaUTIP45rFM6GnF5jwxaOPfHOhOWJfaUmCVVd2p8vRk5IqyeJJ2HGDEJFwSKMXVTAtCfMVFSEdwXV3322+db4vyu98Su4JDqoKBjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFWGc8+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFWGc8+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5A61F000FF;
	Wed, 14 Oct 2026 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791938501;
	bh=CP50Ao9jHmFpunsbQCg07q5xpEmW/gDeTV4LJvk19uI=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=BFWGc8+Oy/7tmJ2nGntGjrDznvJnAgTB6CI3bNjNn0a2V+g3knp/UdET/AF12menC
	 onb9ohbuM9QHl7i+HZglERev40u8vrFe4NaMCUb9LLOga2O2FNUi7Zz/aB2KPoUUxH
	 t6cYD7ri6fqZmi3ie9hFeH6Ji0g0dxRvNcIspUN/msOGLjJk7SSTbW1kS64DT0JW/r
	 KORvUDkDtwVlqCZl3EZUF9oC/cjg+sLDKJZayNGwwwR1Rv57+wUvB9+W9DmHFy+V4i
	 9CtF7sVgfOImF+dAgM4aVCXG94A5gNVNfCPxYu+XU33nRMOHdLjDvEirxrYOO40B4G
	 7UX4rkNWEs4/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2A96CCE0459; Tue, 13 Oct 2026 17:41:41 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:41:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: Possible enhancement to RCU CPU stall warning messages
Message-ID: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

While chasing an "interesting" bug [1], I modified the RCU CPU
stall-warning code so that when a task (as opposed to a CPU) is
blocking the grace period due to being preempted, the stall-warning
message includes the task that is currently running on the CPU that the
preempted task wants to run on.  (In the case of the "interesting" bug,
I kid you not, that CPU was idle.)

Would this stall-warning addition be useful for PREEMPT_RT users?

If it is not useful, I am going to keep it out of tree.  Something about
it needing a way to dig into scheduler internals.  ;-)

But if you want it, please let me know.

							Thanx, Paul

[1] https://lore.kernel.org/all/8fa7f795-518c-4507-b684-60b0c1cac2c5@paulmck-laptop/

------------------------------------------------------------------------

commit 24853cb1cfb363ce608e2098ef22c272d475b84c
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Sep 28 13:35:01 2026 -0700

    EXP rcu: Print CPU that preempted stalled reader wants to run on
    
    This commit uses the dirty trick of defining an rcu_cpu_curr() within
    kernel/sched/core.c in order to allow the RCU CPU stall warning call out
    the CPU that a task preempted within an RCU reader would like to run on.
    In addition, print out the task (if any) currently running on that CPU,
    and add an exclamation mark ("!") after the CPU number if that CPU is
    currently offline.
    
    This is a potential step towards allowing people (or LLMs, for that
    matter) to locate any tasks that might be preventing the preempted RCU
    reader task from running.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cca..a8b3434edb2b4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2532,3 +2532,5 @@ extern void migrate_enable(void);
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
 #endif
+
+struct task_struct *rcu_cpu_curr(int cpu);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 803a56af3259f..7826c4d905248 100644
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
@@ -327,6 +332,9 @@ static int check_slow_task(struct task_struct *t, void *arg)
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
 	rscrp->rcu_rdr_running = task_curr(t);
 	rscrp->rcu_rdr_boosted = 0;
+	rscrp->rcu_rdr_cpu = cpu = task_cpu(t);
+	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
+	rscrp->rcu_rdr_cpu_task = th = rcu_cpu_curr(cpu);
 	if (rscrp->on_blkd_list) {
 		rnp = READ_ONCE(t->rcu_blocked_node);
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -352,6 +360,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	int ndetected = 0;
 	struct rcu_stall_chk_rdr rscr;
 	struct task_struct *t;
+	struct task_struct *tc;
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
@@ -372,17 +381,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
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
index b77152edafd92..e137cba24fc92 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11321,3 +11321,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+// Not for mainline, but hopefully someone has a trick that gets this
+// job done.
+struct task_struct *rcu_cpu_curr(int cpu)
+{
+	return cpu_curr(cpu);
+}
