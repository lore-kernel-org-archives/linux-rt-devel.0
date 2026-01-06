Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C831AF3F;
	Tue,  6 Jan 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696086; cv=none; b=TzqZdEhL91V7jtvDs02/U+GBKtAQwTe76ZRL8UdBzQzuXbNR+IB1FV0lZ/yEAnWe6RuF+kp5gEstP09KiwIw7JF1C/fZghepwdqAqV5FPCCus1DVPkIG2qRUinQYm0V9r6OCBqsXLAmwWH4sMrgNGdpRtvHQCshQ6kyAawqs/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696086; c=relaxed/simple;
	bh=Wqf9b0nlr+qDFE2sB82BkI3ws7XxguF/SMTSDtfWTpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyB9I4NKUrAEUzelCRTXz4YobQtJFrqYZGD64XarZg7y0vt1oiOK1xwxO420AgjGtpSxn73v3hJ/sqYqYkjsfeixWzRY4haV1fp8GAHKC80/aONXwwChrInd5LmaTvbSJyXEYc3UROlWb+8fT91w1OKtKcMGkBqHyauuEATOfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gsg+6X1V; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gsg+6X1V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6LqZ86XMDHuJfK9Aq90epNc2agQkGzdh4IAJRspyP2o=; b=Gsg+6X1VlE77Uyy9BzcDwgcWyd
	sZUsK8DMJv91TT5irRvVouSmdB7IT+DEQi9h4djQwsyw3z8bIDEwUQdbOx28lpytuXshBclhn7L3y
	xhWpOMN001a4XkEpdX0bDL3EGrpvh/Bipbg0ZztMDFpLKhyC4X9Zjab3NXGBiKVXnOkkuvoX44MYP
	9im40J4z+gTsAd2kwyot1mS75ZDGuyXhK9crE4zUwcdBp/1b20P7XPZps3ACV6EadHMhALIbgWv82
	C/kGLBaPpSSYHsva24ARQK83Dgnt3/Q3ngIZfnYBEg/FMXO4bkCZTSdy3CX7oDVq9WqB5muizODQD
	dQDezB+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4V0-00000009Y2J-3ktk;
	Tue, 06 Jan 2026 10:41:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A753330056B; Tue, 06 Jan 2026 11:41:13 +0100 (CET)
Date: Tue, 6 Jan 2026 11:41:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [RFC PATCH] sched/core: Stash task priority after dequeue and
 put_prev_task() in sched_change_begin()
Message-ID: <20260106104113.GX3707891@noisy.programming.kicks-ass.net>
References: <20260106075239.279072-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106075239.279072-1-kprateek.nayak@amd.com>

On Tue, Jan 06, 2026 at 07:52:39AM +0000, K Prateek Nayak wrote:
> When running amd-pstate driver on a PREEMPT_RT kernel on a shared memory
> system (Zen3 and prior), the following splat was observed from
> triggering the WARN_ON_ONCE() in rq_pin_lock():
> 
>     ------------[ cut here ]------------
>     WARNING: kernel/sched/sched.h:1807 at __schedule+0x122/0x17c0, CPU#8: swapper/0/1

Can you enable CONFIG_DEBUG_BUGVERBOSE_DETAILED?

(not critical this time, since you already said rq_pin_lock() and that
only has the one WARN; it does help in general because 'obviously' 1807
isn't actually in rq_pin_lock() for me).

>     Call Trace:
>      <TASK>
>      preempt_schedule+0x41/0x60
>      preempt_schedule_thunk+0x16/0x30
>      try_to_wake_up+0x341/0x7c0
>      autoremove_wake_function+0x12/0x40
>      __wake_up_common+0x78/0xa0
>      __wake_up+0x31/0x50
>      send_pcc_cmd+0x133/0x310
>      cppc_set_reg_val+0x10e/0x220

> 
> Inspecting the set of events that led to the warning being triggered
> showed the following:
> 
>     systemd-1  [008] dN.31 ...: do_set_cpus_allowed: set_cpus_allowed begin!
> 
>     systemd-1  [008] dN.31 ...: sched_change_begin: Begin!
>     systemd-1  [008] dN.31 ...: sched_change_begin: Before dequeue_task()!
>     systemd-1  [008] dN.31 ...: update_curr_dl_se: update_curr_dl_se: ENQUEUE_REPLENISH
>     systemd-1  [008] dN.31 ...: enqueue_dl_entity: enqueue_dl_entity: ENQUEUE_REPLENISH
>     systemd-1  [008] dN.31 ...: replenish_dl_entity: Replenish before: 14815760217
>     systemd-1  [008] dN.31 ...: replenish_dl_entity: Replenish after: 14816960047
>     systemd-1  [008] dN.31 ...: sched_change_begin: Before put_prev_task()!
> 
>     systemd-1  [008] dN.31 ...: sched_change_end: Before enqueue_task()!
>     systemd-1  [008] dN.31 ...: sched_change_end: Before put_prev_task()!
>     systemd-1  [008] dN.31 ...: prio_changed_dl: Queuing pull task on prio change: 14815760217 -> 14816960047
>     systemd-1  [008] dN.31 ...: prio_changed_dl: Queuing balance callback!
>     systemd-1  [008] dN.31 ...: sched_change_end: End!
> 
>     systemd-1  [008] dN.31 ...: do_set_cpus_allowed: set_cpus_allowed end!
>     systemd-1  [008] dN.21 ...: __schedule: Woops! Balance callback found!
> 
> 1. sched_change_begin() from guard(sched_change) in
>    do_set_cpus_allowed() stashes the priority, which for the deadline
>    task, is "p->dl.deadline".
> 2. The dequeue of the deadline task replenishes the deadline.
> 3. The task is enqueued back after guard's scope ends and since there is
>    no *_CLASS flags set, sched_change_end() calls
>    dl_sched_class->prio_changed() which compares the deadline.
> 4. Since deadline was moved on dequeue, prio_changed_dl() sees the value
>    differ from the stashed value and queues a balance pull callback.
> 5. do_set_cpus_allowed() finishes and drops the rq_lock without doing a
>    do_balance_callbacks().
> 6. Grabbing the rq_lock() at subsequent __schedule() triggers the
>    warning since the balance pull callback was never executed before
>    dropping the lock.
> 
> Since the dequeue on a deadline task can push its deadline, stash the
> task prio towards the end of sched_change_begin().
> 
> The modification to priority within the sched_change guard's scope will
> still be considered as sched_change_end() will supply the priority
> stashed at the end of constructor's execution as the old priority to
> sched_class->prio_changed().
> 

Would not something like so make more sense?

---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 80c9559a3e30..60e0c25aae78 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3306,6 +3306,8 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 
 static u64 get_prio_dl(struct rq *rq, struct task_struct *p)
 {
+	if (task_current_donor(rq, p))
+		update_curr_dl(rq);
 	return p->dl.deadline;
 }
 
