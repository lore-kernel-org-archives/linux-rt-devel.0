Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442879;
	b=DefQz/kNjJsFgGS/ckwg/WnzMZeqNty6f75oaFBgfZ7qX3Pw7bcv6S/Qxp953aIfMCRO
	 N7swTrJhTHnQsqO5Hs6EE6t17m7moOK18vht+B0jcKt5qBvTkTLqnvmsXNsSwZeYo6cUb
	 nmYkP2vIWSZv60CybrFgu271yPrmsa5Xk37qPzAkKFUkNH8EMP3ZtknfMS/1r6IghP/M6
	 SqGQhVNk7//u9cwPQr0Cc4seaQjjds27JwpTkjNe2ownssckpx6RJSonn+W9tfxwlRVsM
	 cnDo+4tAMAr03Uku2USa5vYdsoScR1+EBlPzLjYydFsOL5aICK8S2hNIGpkktmOwbkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442879;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mxMUYzin+1iTcBhuRWJPjGD5mo13ZLuKNESWTPDIUTA=;
	b=QsdtxggyClOsh1ZQmW5hNK3aOgNSTHY8hYcoqh6k5u9WHLdtN0hcuvDzSFDePShvL531
	 SlQhqntUYut2HrjV5iHJNzJOx8uh5e97WNF6MFRBac2Vxsh9SlL1zU/sML8zS8STl29aF
	 3XYUVPJT8SkZ8he4rurfwFQsat2JoIIfFIPwK57hQNVLcFAxsoccovGQq1yVFThRfomMD
	 oSnUw+FjsDudaFHnP+mqcsei1CdmjJu1pYWLC+cEC6rXncYllFTFQvBA7bcQlqFNv4vmB
	 YZwluuTFyF5nXJRc0wEc1sPhdDyqxwZTtOaeASVPZLczCnkWLdzRkiB20OvP83k+9ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUTATZz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE0606A31F;
	Mon, 19 Oct 2026 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUTATZz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC51F000C4;
	Mon, 19 Oct 2026 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442878;
	bh=mxMUYzin+1iTcBhuRWJPjGD5mo13ZLuKNESWTPDIUTA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WUTATZz9ABjBYitGjDhoqbn/Ufegq/lOBOge+JT27WvVN3f6v5mx4NpEy2zlcMjdX
	 qLHsou5Bbh45trNM/oH+D6aSteY8gjVdX4YZ5mn5HUsiNh4mVfmVB8pbVtpLZR7dq0
	 ZIZHBlHzZaZXetLnFr+T9JHegmnweV00cvpe7CxR0ltI+7XbJf11k1xTV54iJAQF4E
	 n9QENJdR0+bOE23dk4iwrugbrsAP1QYE0QyLKp6vrOWbwSbkTy9MKt0ppOI72FANCo
	 bJOGkzbkC4hg1Afh8t2md7hz0e2Aj/t0vkrjjIrCEnwKSlHxhbMjstoUuGDtehBnmX
	 Kdw3PqiYzL+Cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92890CE09FC; Mon, 19 Oct 2026 13:47:58 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:47:58 -0700
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
Subject: [PATCH] rcu: Print CPU that preempted stalled reader wants to run on
Message-ID: <7a827d0a-1a69-4be6-8b69-9a9769b182b7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
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
In-Reply-To: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>

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

o	The check_slow_task() function places a pointer to the task_struct
	structure in its local variable "th".

o	The corresponding task exits, reducing its task_struct structure's
	->usage to zero.  The task_struct structure is therefore passed
	to call_rcu().

o	The check_slow_task() function invokes get_task_struct(th),
	setting th->usage to one.

o	The rcu_print_task_stall() function invokes put_task_struct(),
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

Link: https://lore.kernel.org/all/a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop/
Link: https://lore.kernel.org/all/e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

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
index 559735f71b5dd..3d88ad36ec9b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11320,3 +11320,16 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+/**
+ * cpu_curr_snapshot_rcu - Return the task currently running on CPU
+ * @cpu: CPU to query
+ *
+ * The caller must be within an RCU read-side critical section.
+ *
+ * Return: Pointer to task_struct of task running on @cpu.
+ */
+struct task_struct *cpu_curr_snapshot_rcu(int cpu)
+{
+	return rcu_dereference_all(cpu_curr(cpu));
+}
