Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1D53E2E1
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170305; cv=none; b=ApTFNgHZknUYUFyuLfcCElZvE4f7OOMlSxTHXsal3TvDI1JlnK6p0wlMMV/ob0KSqWK5eYARnvT8MlvLZ3l8MueqFZdlre9Iy5m9JIjQp17dZUgrEyZA4Q5+2YtNIoqPJuFOWrNSub6Z6h8YcCxpEVYIr1lpoVshuwkbaVXSmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170305; c=relaxed/simple;
	bh=jIK62wK0WEbPOxqEiJ1hoViwhHtloqawE0ZL/7BUI24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2VX1rgSN4aRsX98Io4Z5AOP0ncNr+tHRzBx2XsKKm+li7W1dT5INX+hVbXmGxomeKZzdbD90LypppkRUpsW66VeZcH5ELbZiTsCrq008lNBzoc6oS3WqD5xKsZyRGPggg6sfHCgOlwbep/aTUxLA3CZsaoEg2fKGxYXITHdx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW9Va7s1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW9Va7s1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A5E1F000C7;
	Fri, 16 Oct 2026 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170303;
	bh=UDuQiVUpmVYHHgXnCWJGz0kZgdWnWToigJwEXE9utiQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=MW9Va7s1OojLORAe0CfTaQQqrW2j9gw88k9t4SkzMyNvD8y6xGjpVpyGhwwppITnV
	 4MMmXwpSx+0F8WUMbzokZUNFtPO/6CydRbrdI/FHyloxeZwru1l1TF0nGFRoZB+975
	 zD46uy7HzBw5XrRUt0qknYCpZB9nQg71us3U7zpIQ5ptiXfMm9osvwmt2SnTFbqA6j
	 WuMThQ8kMfyuELx3dQqNrjyaxKFtiBXF4Im3QOtlqMXOaGi4xP+UX2kOUAFgpH+whg
	 +JxGIy1OcU9dwnLBzfqhnJNnYMcuKYxOSE0jW1ryWhwdj47vAEnh13A1fpke3THea9
	 M3A2bd23lebBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DB450CE08CF; Fri, 16 Oct 2026 10:05:02 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:05:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
 <20261016112339.6d6ac80a@gandalf.local.home>
 <7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
 <20261016121753.0da4e4e1@gandalf.local.home>
 <d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
 <20261016125453.36ae8efe@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016125453.36ae8efe@gandalf.local.home>

On Fri, Oct 16, 2026 at 12:54:53PM -0400, Steven Rostedt wrote:
> On Fri, 16 Oct 2026 09:48:12 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > ------------------------------------------------------------------------
> > 
> > static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> > 	__releases(rnp->lock)
> > {
> > 	int i = 0;
> > 	int ndetected = 0;
> > 	struct rcu_stall_chk_rdr rscr;
> > 	struct task_struct *t;
> > 	struct task_struct *tc;
> > 	struct task_struct *ts[8];
> > 
> > 	lockdep_assert_irqs_disabled();
> > 	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
> > 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > 		return 0;
> > 	}
> > 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
> > 	       rnp->level, rnp->grplo, rnp->grphi);
> > 	t = list_entry(rnp->gp_tasks->prev,
> > 		       struct task_struct, rcu_node_entry);
> > 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
> > 		get_task_struct(t);
> 
> This gets the ts[i]
> 
> > 		ts[i++] = t;
> > 		if (i >= ARRAY_SIZE(ts))
> > 			break;
> > 	}
> > 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > 	while (i) {
> > 		t = ts[--i];
> > 		if (task_call_func(t, check_slow_task, &rscr)) {
> > 			pr_cont(" P%d", t->pid);
> > 		} else {
> > 			tc = rscr.rcu_rdr_cpu_task;
> 
> But what gets the tc?
> 
> > 			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
> > 				t->pid, rscr.nesting,
> > 				".b"[rscr.rs.b.blocked],
> > 				".q"[rscr.rs.b.need_qs],
> > 				".e"[rscr.rs.b.exp_hint],
> > 				".l"[rscr.on_blkd_list],
> > 				".R"[rscr.rcu_rdr_running],
> > 				".B?"[rscr.rcu_rdr_boosted],
> > 				rscr.rcu_rdr_cpu,
> > 				rscr.rcu_rdr_cpu_offline ? "!" : "",
> > 				tc ? tc->comm : "???",
> > 				tc ? tc->pid : -1,
> > 				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
> 
> Here tc is dereferenced.
> 
> > 		}
> > 		lockdep_assert_irqs_disabled();
> > 		put_task_struct(t);
> 
> There's a put_task_struct(t), but I don't see a put_task_struct(tc) :-/

You are absolutely right, and thank you!  I need that get_task_struct()
in check_slow_task(), then an additional put_task_struct() here.

Which might mean holding the rq lock in check_slow_task().  Except that
task_call_func() already does that for me, right?

Like this, to be folded into the existing patch?  Or am I still missing
something?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 33e953bb40b33..b314d79c07840 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -336,6 +336,8 @@ static int check_slow_task(struct task_struct *t, void *arg)
 	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
 	// Interrupt are disabled for RCU read-side critical section. 
 	rscrp->rcu_rdr_cpu_task = th = cpu_curr_snapshot_rcu(cpu);
+	if (th)
+		get_task_struct(th);
 	if (rscrp->on_blkd_list) {
 		rnp = READ_ONCE(t->rcu_blocked_node);
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -402,6 +404,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 		}
 		lockdep_assert_irqs_disabled();
 		put_task_struct(t);
+		if (tc)
+			put_task_struct(tc);
 		ndetected++;
 	}
 	pr_cont("\n");
