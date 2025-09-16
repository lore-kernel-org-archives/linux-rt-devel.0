Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B8238140;
	Tue, 16 Sep 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017403; cv=none; b=kZGOoIxrblSsAwhPvmJ1TUhjSt+Km4BvwisiDEqv8KhZTi3VEYudf3rWao1ueUKzDLoGtwKkRPOV8K4HEtAJlkl2HaRkgZ6/9q8TUjTw5nG78uz1sYDDvH9iRIEjxNrJMBYzMal1u3Hg/zJlDMp1GeMtO7BVnw5HGJnSCzAAXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017403; c=relaxed/simple;
	bh=ze46u8/R33JuBIif2nf6P/mJdb3pka6dAVtmbEae0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avB47O93lJfV1V9vVxJ0oZfYceuBJj6jy3S0NvIBumBEiEeN2zA/JMAyTfdYCteO117bnqSdwWtq0VnV1hnE19c3nfovYKOG4n/DDcOunT9/QZQwOZrasuzUmjdoha+ddC+62LENSL0N610Fpq/l2d+TqCUgCYoxe0SV0SxCmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BuVTb01p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BuVTb01p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y1CVWQIsQOn7a8cjw6w6cUrilp9Uvw74NeFbCqBdqDs=; b=BuVTb01pgyX6v4DCA1GND44UBs
	BrmW6Al/55YurZUTsN2/S7msHxxn3Zeu1PPzrEbwyoXYa/GG7RyDq1+/tmNFS3Nm0CPjy80//xsED
	c3ff+pf7gBbiqhAfeorMG1TAB+qaqVlKeOXOLopb92ElFOf/jEaijNQ9ibBCrRn/bDT2f+GrNuO+J
	D2giIwJm90QkP+AOfIWpECszmQGWz8oDq7ndirb0s5cCbLLxs+GJbC9Bvc6zsC6G7m1K63RrXdvgL
	mpVoQBvGyMqsHs8oahbai6yRh2vsInl7jx20EMpXLs9/d+AliGEqUIoJ8OxiBQrhwiK7Vl8O+RpJ6
	oqHvLnig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uySdG-00000001xgi-1sVN;
	Tue, 16 Sep 2025 10:09:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 363A8303004; Tue, 16 Sep 2025 12:09:53 +0200 (CEST)
Date: Tue, 16 Sep 2025 12:09:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <20250916100953.GG3245006@noisy.programming.kicks-ass.net>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
 <20250915123539.GC23082@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915123539.GC23082@redhat.com>

On Mon, Sep 15, 2025 at 02:35:40PM +0200, Oleg Nesterov wrote:
> On 09/15, Peter Zijlstra wrote:
> >
> > On Mon, Sep 15, 2025 at 08:15:19AM -0300, Luis Claudio R. Goncalves wrote:
> > > Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
> > > if pi_blocked_on is set") changed the behavior of put_task_struct()
> > > unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
> > > with the commit description.
> > >
> > > Restore the previous behavior of put_task_struct() for the PREEMPT_RT
> > > disabled case.
> > >
> > > Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > > ---
> > >
> > >   Note: This patch is a fix motivated by Oleg Nesterov's question at
> > >   https://lore.kernel.org/linux-rt-devel/20250728201441.GA4690@redhat.com/
> >
> > Right, but I thought we did want to make this behaviour consistent.
> >
> > Why have !RT behave differently? That is, why isn't this simply a
> > 'buggy' comment/changelog issue?
> 
> Well, this was discussed several times, in particular see
> https://lore.kernel.org/all/CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com/
> 
> And task_struct->rcu_users was introduced to avoid RCU call in put_task_struct() ...

Ah, I forgot about that thing.. Although I had vague memories of that
argument on rcu_assign_pointer() vs RCU_INIT_POINTER().

> But I won't really argue if you decide to remove this !RT optimization, although
> I think it would be better to do this in a separate patch.

Right. So when they wanted to remove that preemptible() clause, I was
like why again do we have this !RT exception at all, and can't we get
rid of that.

If git isn't confusing me again, this got merged in this cycle. But so
far no benchmark came and told us this was a bad idea.

So what do we do now... do we restore the !RT exception (so far there
aren't any numbers to suggest this mattered) or do we let it be for a
bit and then go and clean things up?

---
 include/linux/sched.h      |  1 -
 include/linux/sched/task.h | 37 +++----------------------------------
 kernel/bpf/helpers.c       |  6 +++---
 kernel/exit.c              | 21 ++-------------------
 kernel/fork.c              | 14 +++++++++-----
 kernel/sched/core.c        |  3 +--
 6 files changed, 18 insertions(+), 64 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 644a01bdae70..fd6586c04ed3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1576,7 +1576,6 @@ struct task_struct {
 # endif
 #endif
 	struct rcu_head			rcu;
-	refcount_t			rcu_users;
 	int				pagefault_disabled;
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ea41795a352b..1125c44b205a 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -122,41 +122,12 @@ static inline struct task_struct *tryget_task_struct(struct task_struct *t)
 	return refcount_inc_not_zero(&t->usage) ? t : NULL;
 }
 
-extern void __put_task_struct(struct task_struct *t);
 extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
 
 static inline void put_task_struct(struct task_struct *t)
 {
-	if (!refcount_dec_and_test(&t->usage))
-		return;
-
-	/*
-	 * Under PREEMPT_RT, we can't call __put_task_struct
-	 * in atomic context because it will indirectly
-	 * acquire sleeping locks. The same is true if the
-	 * current process has a mutex enqueued (blocked on
-	 * a PI chain).
-	 *
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Though, in order to simplify the code, resort to the
-	 * deferred call too.
-	 *
-	 * call_rcu() will schedule __put_task_struct_rcu_cb()
-	 * to be called in process context.
-	 *
-	 * __put_task_struct() is called when
-	 * refcount_dec_and_test(&t->usage) succeeds.
-	 *
-	 * This means that it can't "conflict" with
-	 * put_task_struct_rcu_user() which abuses ->rcu the same
-	 * way; rcu_users has a reference so task->usage can't be
-	 * zero after rcu_users 1 -> 0 transition.
-	 *
-	 * delayed_free_task() also uses ->rcu, but it is only called
-	 * when it fails to fork a process. Therefore, there is no
-	 * way it can conflict with __put_task_struct().
-	 */
-	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
+	if (refcount_dec_and_test(&t->usage))
+		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
 DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
@@ -164,11 +135,9 @@ DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
 	if (refcount_sub_and_test(nr, &t->usage))
-		__put_task_struct(t);
+		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
-void put_task_struct_rcu_user(struct task_struct *task);
-
 /* Free all architecture-specific resources held by a thread. */
 void release_thread(struct task_struct *dead_task);
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8af62cb243d9..bdc4e65bca5c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2459,7 +2459,7 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root, struc
  */
 __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
 {
-	if (refcount_inc_not_zero(&p->rcu_users))
+	if (refcount_inc_not_zero(&p->usage))
 		return p;
 	return NULL;
 }
@@ -2470,12 +2470,12 @@ __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
  */
 __bpf_kfunc void bpf_task_release(struct task_struct *p)
 {
-	put_task_struct_rcu_user(p);
+	put_task_struct(p);
 }
 
 __bpf_kfunc void bpf_task_release_dtor(void *p)
 {
-	put_task_struct_rcu_user(p);
+	put_task_struct(p);
 }
 CFI_NOSEAL(bpf_task_release_dtor);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 343eb97543d5..240a6faa0e26 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -220,23 +220,6 @@ static void __exit_signal(struct release_task_post *post, struct task_struct *ts
 		tty_kref_put(tty);
 }
 
-static void delayed_put_task_struct(struct rcu_head *rhp)
-{
-	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
-
-	kprobe_flush_task(tsk);
-	rethook_flush_task(tsk);
-	perf_event_delayed_put(tsk);
-	trace_sched_process_free(tsk);
-	put_task_struct(tsk);
-}
-
-void put_task_struct_rcu_user(struct task_struct *task)
-{
-	if (refcount_dec_and_test(&task->rcu_users))
-		call_rcu(&task->rcu, delayed_put_task_struct);
-}
-
 void __weak release_thread(struct task_struct *dead_task)
 {
 }
@@ -305,7 +288,7 @@ void release_task(struct task_struct *p)
 	if (thread_group_leader(p))
 		flush_sigqueue(&p->signal->shared_pending);
 
-	put_task_struct_rcu_user(p);
+	put_task_struct(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
@@ -1057,7 +1040,7 @@ void __noreturn make_task_dead(int signr)
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
 		futex_exit_recursive(tsk);
 		tsk->exit_state = EXIT_DEAD;
-		refcount_inc(&tsk->rcu_users);
+		get_task_struct(tsk);
 		do_task_dead();
 	}
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 33dfb82af25b..383c811626a3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -106,6 +106,7 @@
 #include <linux/pidfs.h>
 #include <linux/tick.h>
 #include <linux/unwind_deferred.h>
+#include <linux/kprobes.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -729,12 +730,17 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
-void __put_task_struct(struct task_struct *tsk)
+static void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	kprobe_flush_task(tsk);
+	rethook_flush_task(tsk);
+	perf_event_delayed_put(tsk);
+	trace_sched_process_free(tsk);
+
 	unwind_task_free(tsk);
 	sched_ext_free(tsk);
 	io_uring_free(tsk);
@@ -915,12 +921,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	dup_user_cpus_ptr(tsk, orig, node);
 
 	/*
-	 * One for the user space visible state that goes away when reaped.
+	 * One for user space visible state that goes away when reaped.
 	 * One for the scheduler.
 	 */
-	refcount_set(&tsk->rcu_users, 2);
-	/* One for the rcu users */
-	refcount_set(&tsk->usage, 1);
+	refcount_set(&tsk->usage, 2);
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da2062de97a2..ad3c0e9f3eb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5259,8 +5259,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 
 		/* Task is done with its stack. */
 		put_task_stack(prev);
-
-		put_task_struct_rcu_user(prev);
+		put_task_struct(prev);
 	}
 
 	return rq;
