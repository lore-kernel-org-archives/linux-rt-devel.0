Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8353163D;
	Thu, 15 Oct 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086077; cv=none; b=tuQtid0j/xuRZLCKfIpL5KDj/OY70STO+6Ck06Obf3Ht2cRBdajYhPeQWunTNVTL6VTw1VkAV3qb1WdxHTO1KhpM5liWDNvYft8b6E0c6N/ywMFx+5qW9b8UMoesjThXWkrXB6FffqmgO9llDfhY739NPEkZzJosPRWC4FjhCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086077; c=relaxed/simple;
	bh=JFw0bpbSMHAqeGYxKKAYz5op/Z+aunIdwy0CuRP0No4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=InZOeMFshC9qB/Wk7imympdQm2fkK0UC+xebyjUxB/TC/GMnkRIcJSQ++1PhWQzgcaPQHwePWiVAXYoqTlFFGcIBIz0an0xxfdXOIulpX0VbG0gp2UsN5dAiwJwv2Gz0Fm0pMRDV8o2E3txd/3DnDIM/cTEATUoF7UYKX5Y+pYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH7UkG6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH7UkG6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C21F000C4;
	Thu, 15 Oct 2026 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792086067;
	bh=fCB/nAeUeRxuZBJvipKyv3oCBpQ2JvV0i093QZCY2NU=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=YH7UkG6nM0TvI4585CupVvBI+oDhyY1hhV2GS15il0tWR94kjkLCfE3cH8PVVZVeI
	 627sg2AW9d6G0W2P1JZmZwBrPBv38p7shY/NjFFE6reAdaYLkf03jtpeoVpqeyBMd4
	 fRbMXW2wPUehdju2E0oBmtCyauRRnAwM+YTSlSmrgKviio+7XlbJOIdb8OBQLbrJce
	 tFZpieT3dQzM/kLYCXadlMMJo0qeCRKtPuJ3V0rmxnamUQfX+/7vhVAG6kjRhNTbZF
	 hU+ljHMWnIqBj1EbkgwEqLmmN4sWfza+LnOiyAoA1HYh6b9GPy9tBS9LcdVSOPVFIt
	 h+ydJQolZ3FiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8BB3CCE23FD; Thu, 15 Oct 2026 10:41:07 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:41:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: Mapping from preempted task to running task on same CPU
Message-ID: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
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

One of the commits [1] that I used to chase down a recent bug [2] (and
thank you again for the fix!) uses the scheduler-internal cpu_curr()
macro to map from a given CPU to the task currently running on that CPU.
In the commit, the actual operation is mapping from a stalled (AKA
preempted but runnable) task to the task running on the corresponding CPU.
This tasks's ->comm and ->pid are then printed in the RCU CPU stall
warning console output.

One of the real-time folks voted in favor being able to use this (the
group is CCed here), which suggests that I push this commit to mainline.
Which means that I need to do something other than my crude hack of
creating a rcu_cpu_curr() function in kernel/sched/core.c to get access
to the scheduler-private cpu_curr() macro.

Please tell me what I should instead be doing (in the check_slow_task()
function shown below) to get at this information.

							Thanx, Paul

[1] 68a2e5363f8f ("EXP rcu: Print CPU that preempted stalled reader wants to run on")
    This is in -rcu, and is also shown at the end of this email.
[2] https://lore.kernel.org/all/8fa7f795-518c-4507-b684-60b0c1cac2c5@paulmck-laptop/

------------------------------------------------------------------------
68a2e5363f8f ("EXP rcu: Print CPU that preempted stalled reader wants to run on")
------------------------------------------------------------------------

commit 68a2e5363f8f30f17038b3daee5dbbd661a7207e
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
