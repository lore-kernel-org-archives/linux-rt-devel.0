Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D7421F1F
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Mar 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543588; cv=none; b=sKVK3kJkC+3lYaetdCW/eL+b/MSzPcp2TEKBiyAWZvAHj1G2c0Xp++vQvPhaLkFZBUGDeBRILxTeFd4OXBoSdCPxR2oFAS4OoMsmIkYvRL0EWfUFCxX/bOfu1RYwGmFaUD4GEGQv2642laqA53iCG1V9cFg/mz6cNUFDW1Hw27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543588; c=relaxed/simple;
	bh=N59rhKekYSzO90t0Z7GXfxgOY++spj7v6aQcINF0/l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cItwQ8xaBFgp1o0TsCD30IcZxCzre88YxtTlubiZX3soX2YMIlWpb0oWREXMqx8pUldpfDg4DchhJwpDq+zclf16yOCdneNMKFosRqtH3HCe+t7YvJMsMMTSMTGoujUIkD1IZylZn1iunssSflv0r6UDmhDEAMfBYw7NJRiv7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIb1i6qL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o29c4EBL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIb1i6qL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o29c4EBL"
Date: Tue, 3 Mar 2026 14:13:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772543583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAffNeouQczhPYqzPOrjv2nqytQtFK/BWssDR6V5N1s=;
	b=lIb1i6qL8h9MiRz42pmMwbLciNyDm5IQ6eABURTTARl7DsaIUiasoYaVSxaVP4jwRtIRia
	GjRl31HlqzJ37onhVJie3y5ct3884XS6frlcXGpgCn7OtufgB/qTwVM5+Cj+vVhWHUrgYT
	wr7GiMRUQfSOtVYWyhvsjOkwNLKH+KKJtEQNx8ASUw+QcC/XtYNEOXFlZb8JZ5/BnqDH1G
	PLM77SIOfFOlpBUIe/rDdfWXZk8O5Jq0hdClHf4oAGOhxkr5WF120bXylGhSTvzH9amx3/
	yCTJn9S+A7FX+7kntjyLkSr72YnKW76EaQMshLAekWjx0gxCA0HXlgY4a7YN7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772543583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAffNeouQczhPYqzPOrjv2nqytQtFK/BWssDR6V5N1s=;
	b=o29c4EBLvJKzIMvSBUfZqFdIYT6eJwH/q6/QO6+gsueadrZwXrIjWoptJSI87JG/zCTr1K
	onyzCHoNtItEeqAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH] cgroup: Don't expose dead tasks in cgroup
Message-ID: <20260303131301.ieSSCM4n@linutronix.de>
References: <20260302120738.6KkDipsR@linutronix.de>
 <aaYHmCV2CW-tOT-Z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaYHmCV2CW-tOT-Z@slm.duckdns.org>

On 2026-03-02 11:56:40 [-1000], Tejun Heo wrote:
> Hello, Seb.
Hi Tejun,

> On Mon, Mar 02, 2026 at 01:07:38PM +0100, Sebastian Andrzej Siewior wrote:
> > Tejun, with this change, would it be okay to
> > - replace the irq-work with kworker? With this change it should address
> >   your concern regarding "run in definite time" as mentioned in [0]. So
> >   it might be significantly delayed but it shouldn't be visible.
> >   This would lift the restriction that a irq-work needs to run on this
> >   CPU and the kworker could run on any CPU. 
> 
> Yeah, that's fine.

Okay.

> > - would it be okay to treat RT and !RT equally here (and do this delayed
> >   cgroup_task_dead() in both cases)
> 
> I don't see why we'd bounce on !RT. Are there any benefits?

You would have the same bugs if any and not two separate types if at
all. It would get rid of the ifdef. No other benefit.

> > @@ -5283,6 +5283,11 @@ static void *cgroup_procs_start(struct seq_file *s, loff_t *pos)
> >  
> >  static int cgroup_procs_show(struct seq_file *s, void *v)
> >  {
> > +	struct task_struct *tsk = v;
> > +
> > +	if (READ_ONCE(tsk->__state) & TASK_DEAD)
> > +		return 0;
> 
> Does this actually close the window for systemd through operation ordering
> or does it just reduce the race window?

I see the task in questing exiting via sched_process_exit() and after
its schedule() it is removed from the cgroup list as per current logic.

The parent systemd task doing all its cleanup gets probably active
because its child died/ SIGCHLD. So we have sched_process_exit(), wake
parent, final schedule() leaving as zombie removing itself from the
cgroup list.
Judging from do_exit(), a preemption after exit_notify() before
do_task_dead() should lead to the same problem. By adding a delay

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -893,6 +893,7 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 		coredump_task_exit(tsk, core_state);
 }
 
+#include <linux/delay.h>
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -1004,6 +1005,7 @@ void __noreturn do_exit(long code)
 	exit_task_stack_account(tsk);
 
 	check_stack_usage();
+	ssleep(1);
 	preempt_disable();
 	if (tsk->nr_dirtied)
 		__this_cpu_add(dirty_throttle_leaks, tsk->nr_dirtied);

I get the same timeout behaviour on !PREEMPT_RT. So it seems like I did
reduce the race window.

So what about doing the removal before sending the signal about the
upcoming death? Something like:

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6975,6 +6975,7 @@ void cgroup_post_fork(struct task_struct *child,
  * Description: Detach cgroup from @tsk.
  *
  */
+static void do_cgroup_task_dead(struct task_struct *tsk);
 void cgroup_task_exit(struct task_struct *tsk)
 {
 	struct cgroup_subsys *ss;
@@ -6984,6 +6985,7 @@ void cgroup_task_exit(struct task_struct *tsk)
 	do_each_subsys_mask(ss, i, have_exit_callback) {
 		ss->exit(tsk);
 	} while_each_subsys_mask();
+	do_cgroup_task_dead(tsk);
 }
 
 static void do_cgroup_task_dead(struct task_struct *tsk)
@@ -7050,16 +7052,12 @@ static void __init cgroup_rt_init(void)
 
 void cgroup_task_dead(struct task_struct *task)
 {
-	get_task_struct(task);
-	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
-	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
 }
 #else	/* CONFIG_PREEMPT_RT */
 static void __init cgroup_rt_init(void) {}
 
 void cgroup_task_dead(struct task_struct *task)
 {
-	do_cgroup_task_dead(task);
 }
 #endif	/* CONFIG_PREEMPT_RT */
 

cgroup_task_exit() is invoked a few functions before exit_notify(). Not
sure what else I might have broken but the race window should be closed.

> Thanks.

Sebastian
