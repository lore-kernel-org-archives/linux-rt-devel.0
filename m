Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262124;
	b=aCz/oKWVTRH+ND+kmu8i0mIWgzgnQauGUu7u7fu/thKfTM5GYFgtNVfIJPfWthTEyg7i
	 fKWwryRbH5rHsLt79+PjLaqlZzTwVyv6rNRLmtzULo22WxELXLYQ8QP0L93l43W2ZZElg
	 VS3bBLxFdH/6SSaMcyme4qAvZgH8UHT/ucHXB94DO5/NvWpIDKRtQBPiCCh9M3x8z5V71
	 vi8Ma78hNRzwxWj44IUQfXH23Bh/yuE6LMuYx3S33l/RRQZJJcJqn8eArtIiEEDAMSXVM
	 Ri9hDlm55FagytnwoIXyzfWg3S1t6htkFFfYKpw32wncKtb1qmf1gqREnKhHyxpeULg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262124;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=VFjEU5TvIppJYRMn21oMvJWqxywZg/Hz1VFsvqQQ8Jk=;
	b=Yl/5fy4GZqi1kOc3XVAaax1Gptxg41NcnmrAUgz4CgieFDwVPrc6KPbuqFjp8Z4OmyT3
	 CN9drvOcNITJbJBeYbTPtCtuihZoSs7GvpmAiCS2ilSKA2HNzIOJ7hhD3y4MJHQkexjqW
	 vHvwxQMUJDlurv01EqqXurl6iNzoWtaaFTUGYFCre3kVDhdIhMiBA9oPTWaRUF9b+YOEr
	 dnVJFZ9DwqyzHmGSMIf99K5P6Zid6rN/La4GZorUQ2I4nBJm5pm0HK4fxIiQIRn/Qf0ka
	 P8NL/hxwwFTzYtHUIsBnU+sw7EnbE8T3uQC59yvS5xRlqgA5RN8LratsDkJv+5iYz2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irTnZUSL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E2606A321;
	Mon,  9 Nov 2026 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irTnZUSL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925FB1F0089F;
	Mon,  9 Nov 2026 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262123;
	bh=VFjEU5TvIppJYRMn21oMvJWqxywZg/Hz1VFsvqQQ8Jk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=irTnZUSLikyASNjkhxmd4umLxiyk+xcJjEBjLN8uhZsPqzDwRI/EuITBZBm7yM8Hs
	 hNdZPWDhHTxzWKKAKhogMMqEmM8ybJfxRd36faqWv74KDri/LLhzxn8rjR6EZqn3ER
	 chi7MPHyN9vz+fTrSUHkx8ZD3QNTQj+cmwWeg5dIcFu1dy0nLk8pIH9gfMB2BdjZEa
	 sKvVTCGupCrxeHI+0OPbgpjR2CjGze9enVI94S/a8hZrQDc1lRYwL+WB9YbJdrAyG8
	 o/FYzLXAS+/NFh8eHVvDVfdd/I2cy7evNwe0eabOaR5IsZkOfT2bk5YFNyZ43rRZqY
	 Ve2Q7dXfTaM/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 57824CE0CC1; Mon,  9 Nov 2026 14:08:43 -0800 (PST)
Date: Mon, 9 Nov 2026 14:08:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH] rcu: Print CPU that preempted stalled reader wants to
 run on
Message-ID: <ba4a68a7-3656-434c-a51d-5c312c0924c0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
 <7a827d0a-1a69-4be6-8b69-9a9769b182b7@paulmck-laptop>
 <0d0974b0-5235-4764-abad-0a665c27a1d0@amd.com>
 <22d0d56c-6cef-47d7-a923-1d888e224b58@paulmck-laptop>
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
In-Reply-To: <22d0d56c-6cef-47d7-a923-1d888e224b58@paulmck-laptop>

Hello!

Just double-checking the cpu_curr_snapshot() function in the patch below
before assuming that silence means assent.  ;-)

The prior discussion may be found in the Link: tags shown below.

							Thanx, Paul

------------------------------------------------------------------------

commit 334abba563703bcd11bf5de1358fa68abaae2d1e
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
    
    Link: https://lore.kernel.org/all/a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop/
    Link: https://lore.kernel.org/all/e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop/
    Link: https://lore.kernel.org/all/22d0d56c-6cef-47d7-a923-1d888e224b58@paulmck-laptop/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
    Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
    Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e3..ba7c7bb13b6e9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2527,3 +2527,5 @@ extern void migrate_enable(void);
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
index b5b205b1a6e22..98b45b2557e92 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4605,6 +4605,19 @@ struct task_struct *cpu_curr_snapshot(int cpu)
 	return t;
 }
 
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
+
 /**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
