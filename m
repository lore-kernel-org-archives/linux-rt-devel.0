Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3E1EBFE9
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Oct 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868070; cv=none; b=HxOtB2H2Wi6Y1xF0hcF981QQEyENKHlXqavry10eHxNAMlkGKJiMUS4ZCR7aJRcyo4k8K4fNG5sM4q31krMksAy8plbomSTSURTqL6Rd5cFeSAGjppd8BrLtbVqM26eL3G8qRWwq9nVjzl2fvi+JFJHOjLyE9WJfKBd/X+bUqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868070; c=relaxed/simple;
	bh=2Z9DwrHSv3h+ppj8MiimsOk3gWPLhum8Vq7Bd6PwFTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mo+VXx0p+qk0JadC2E4bBd6nbWHocHqL8MH6Igf3IG7XDRWsqNMyoNL2hbrbWo407HJttdF+PvQMaNgHFilu2ZQYZdbgIWA2pKcpcgWzmrAE+QGELVVsR8mYcO0uOq6ii5vgIds04LvBwuLnXZm1O+LE9iiv9kxalEnSedZMosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zr7UTdNx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2F+fBr9R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zr7UTdNx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2F+fBr9R"
Date: Wed, 2 Oct 2024 13:21:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727868066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BwB8xoWmLLMY6U28KYPe07KHWwt4btmlRwABZZ3vFfg=;
	b=zr7UTdNxgAmA5/7k+1NCmnUv4uAkIqxCmVbPhj184e14Qu4YmUt/ZT1a6fAbWjXeVxD6qu
	QFNafZodidZ+qHjpOOS/gMl33yUwPI5w5EV7yrlZ/95NOcNUN/+Tp9Dggcv0g5joMwNl+i
	9z4k4TWWFANPIa/E3QdMxIL0B+sXsAQiNpZFifKG9roae16KJXgt2Go5nCmBgJ9nin/rHo
	h3WX5UNk246eSetybgz220Y4oc9Q+adnFvc4qrsGI32XKb6kKXXrnZEc8dpV44yRb448gg
	SiDdG+dJcE1yRbGLn+OxlKNT1eN2SXwnYVTS75n1dZYIF+0/h8XL/IyAxumoPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727868066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BwB8xoWmLLMY6U28KYPe07KHWwt4btmlRwABZZ3vFfg=;
	b=2F+fBr9RHPV9kxYFxKafzK+o/5eRardof9eWe9pTml53Kbr19RCXfAmk39UDTOUk4fAqM7
	tuJfy0ZR2GOEKACQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] Repeated rto_push_irq_work_func() invocation.
Message-ID: <20241002112105.LCvHpHN1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I have this in my RT queue:

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2193,8 +2193,11 @@ static int rto_next_cpu(struct root_doma
 
 		rd->rto_cpu = cpu;
 
-		if (cpu < nr_cpu_ids)
+		if (cpu < nr_cpu_ids) {
+			if (!has_pushable_tasks(cpu_rq(cpu)))
+				continue;
 			return cpu;
+		}
 
 		rd->rto_cpu = -1;
 
This avoided a large number of IPIs to queue and invoke rto_push_work
while a RT task was scheduled. This improved with commit
   612f769edd06a ("sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask")

Now, looking at this again I still see invocations which are skipped due
this patch on an idle CPU more often than on a busy CPU. Given that the
task is removed from the list and the mask is cleaned almost immediately
this looks like a small window which is probably neglectable.

One thing I am not sure what to do about it (from a busy trace):
|      ksoftirqd/5-63      [005] dN.31  4446.750055: sched_waking: comm=rcu_preempt pid=17 prio=98 target_cpu=005
|      ksoftirqd/5-63      [005] dN.41  4446.750058: enqueue_pushable_task: Add rcu_preempt-17
|      ksoftirqd/5-63      [005] dN.41  4446.750059: enqueue_pushable_task: Set 5

Since the enqueued task is not yet on the CPU it gets added to the
pushable list (the task_current() check could be removed since an
enqueued task can never be on CPU, right?). Give the priorities, the new
task will preempt the current task.

|      ksoftirqd/5-63      [005] dN.41  4446.750060: sched_wakeup: comm=rcu_preempt pid=17 prio=98 target_cpu=005
|      ksoftirqd/5-63      [005] dN.31  4446.750062: sched_stat_runtime: comm=ksoftirqd/5 pid=63 runtime=14625 [ns]
|       cyclictest-5192    [003] d..2.  4446.750062: sched_stat_runtime: comm=cyclictest pid=5192 runtime=13066 [ns]
|       cyclictest-5192    [003] d..2.  4446.750064: dequeue_pushable_task: Del cyclictest-5192
|       cyclictest-5192    [003] d..3.  4446.750065: rto_next_cpu.constprop.0: Look count 1
|       cyclictest-5192    [003] d..3.  4446.750066: rto_next_cpu.constprop.0: Leave CPU 5

This is then observed by other CPUs in the system so rto_next_cpu()
returns CPU 5, resulting in a schedule of rto_push_work to CPU5.

|      ksoftirqd/5-63      [005] dNh1.  4446.750069: push_rt_task: Start
|      ksoftirqd/5-63      [005] dNh1.  4446.750070: push_rt_task: Push rcu_preempt-17 98
|      ksoftirqd/5-63      [005] dNh1.  4446.750071: push_rt_task: resched

push_rt_task() didn't do anything because Need-resched is already set.

|      ksoftirqd/5-63      [005] dNh1.  4446.750071: rto_next_cpu.constprop.0: Look count 1
|      ksoftirqd/5-63      [005] dNh1.  4446.750072: rto_next_cpu.constprop.0: Leave CPU 5

but scheduled rto_push_work again.

|      ksoftirqd/5-63      [005] dNh2.  4446.750074: push_rt_task: Start
|      ksoftirqd/5-63      [005] dNh2.  4446.750074: push_rt_task: Push rcu_preempt-17 98
|      ksoftirqd/5-63      [005] dNh2.  4446.750075: push_rt_task: resched

came to the same conclusion.

|      ksoftirqd/5-63      [005] dNh2.  4446.750075: rto_next_cpu.constprop.0: Look count 1
|      ksoftirqd/5-63      [005] dNh2.  4446.750076: rto_next_cpu.constprop.0: Leave no CPU count: 1

It left with no CPU because it wrapped around. Nothing scheduled.

|      ksoftirqd/5-63      [005] dNh3.  4446.750077: sched_waking: comm=irq_work/5 pid=60 prio=98 target_cpu=005
|       cyclictest-5216    [027] d..2.  4446.750077: dequeue_pushable_task: Del cyclictest-5216
|       cyclictest-5216    [027] d..3.  4446.750079: rto_next_cpu.constprop.0: Look count 1
|      ksoftirqd/5-63      [005] dNh4.  4446.750079: sched_wakeup: comm=irq_work/5 pid=60 prio=98 target_cpu=005
|       cyclictest-5216    [027] d..3.  4446.750080: rto_next_cpu.constprop.0: Leave CPU 5

CPU5 is making progress in terms of scheduling but then CPU27 noticed
the mask and scheduled another rto_push_work.

|      ksoftirqd/5-63      [005] dN.2.  4446.750084: dequeue_pushable_task: Del rcu_preempt-17
|      ksoftirqd/5-63      [005] dN.2.  4446.750085: dequeue_pushable_task: Clear 5
|      ksoftirqd/5-63      [005] d..2.  4446.750086: sched_switch: prev_comm=ksoftirqd/5 prev_pid=63 prev_prio=120 prev_state=R+ ==> next_comm=rcu_preempt next_pid=17 next_prio=98
|      rcu_preempt-17      [005] d.h21  4446.750089: rto_next_cpu.constprop.0: Look count 0
|      rcu_preempt-17      [005] d.h21  4446.750089: rto_next_cpu.constprop.0: Leave no CPU count: 0

This rto_next_cpu() was triggered earlier by CPU27.

At this point I'm not sure if there is something that could be done
about it or if it is a special case.

Would it make sense to avoid scheduling rto_push_work if rq->curr has
NEED_RESCHED set and make the scheduler do push_rt_task()?

Sebastian
