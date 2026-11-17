Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924675;
	b=beycLP8EY8Ohu+xA1y8rpbVzQZh6zLHcuR3kBBPDfCHr0+Gy9+fYKwmJna5JrKsDkivg
	 QqTkJpeMiZokzBv5j2mUomp420acmWJV66gA9XnkQEl73Qx9r6fwKcBb4e0ByDQLvEpLT
	 w3XoJukbPUa49S5lt+5W8ODO4IcmKA9/F3xaDewGoN73TWPb2YWpA9fqCdIu84CLoeC8m
	 1ZnvJWo36BbPAHS6/cNTnz6PlKHZYl7om8IN1R1AEektE6Wc03BASCuT/kz77O1+ZgMI2
	 Fa5ohcteVzJICrJvN9kpfES1GQMNcmqbNGK7JGnrveHcXEs8Ga8MH2oTvGizS0CHuQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m+HE3BkDFQ4IV4fsS1sl09qCu7vuyN4FY+nitCf4dGE=;
	b=gBI8i0PfdeaBaYvzW8Ox+fnzMY4lFeT2zjGwqJJbFtYr09pLPYXQ3npvc/O0GOEsdPHD
	 WJQmN5OziV8++hulnQ44YlJReEaiqHtU/+dS+gRyocpqp7ira+fj32r51W1VU5IjGvP2T
	 cm32mGJUyRMCk/Yz4X6CkETthLajdow0jCDHqCZjXJWrW/T2RumFIDslgyYvZbFqNv2u4
	 42CmOuoFeEKBMIgVVkAVveuvj1559z4sOS4vbLQ5s6TKti1TgqbtxFeY7QV+4Q6sSkjHI
	 H+gB4JjK2WsIkF06gv5usNyDu0kR3CnVC+0FH+qvtNzIyYZul4plnyOhrC4CFRgQ1SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=APwtBQL3;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50660A3832
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE50660A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=APwtBQL3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924669;
	bh=m+HE3BkDFQ4IV4fsS1sl09qCu7vuyN4FY+nitCf4dGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APwtBQL3cn6pHrJQSZ4jodB1d5QhDpOqSSQRg8ghSAhJMHv2AaP+BwIUKpPn9JJWR
	 qxo1anfEj38X3PDZmJx7dMQ2a/+XE4VPfQXPrF2C34sbo2NCdVEFwkOGX5qIbOwTNZ
	 16HsFv5PnmeKwOQ8pU18Ub/Zcv2CC5BSsimSDdO8mtAhcSj8HydIDP8VTq7djkxTCc
	 Y7nXkCQZ+XMJgCQEk8lmkhR/7FSBTUQXx4fkhr/pFfBzHYi8U8MTyd5mU1QKAnQgFO
	 tFw4B9zS41Xnzo4GIPkPnwOljZlrO+0aK55cTb9xYgMB20gvcXg8VE311mjQEF7nDd
	 MMaKVIdFV7kdw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV50NqBzRHP;
	Tue, 17 Nov 2026 09:11:09 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	tglx@kernel.org,
	will@kernel.org,
	boqun@kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	parri.andrea@gmail.com,
	m.szyprowski@samsung.com,
	kayracizmeci@gmail.com,
	weihengqiuu@gmail.com,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v7 26/40] sched/deadline: Make a rebuild count a task in the root domain it runs in
Date: Tue, 17 Nov 2026 09:10:47 -0500
Message-Id: <d956394fd7c5d85d9cd92489b0abf5c709c4545d.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A rebuild of the accounting counts each deadline task on the first
active CPU of its cpuset. Commit 318e18ed22e8 ("sched/deadline: Walk up
cpuset hierarchy to decide root domain when hot-unplug") made this
choice. It relies on the bandwidth check to keep such a CPU active.
This guess would go wrong in three ways:

 - A cpuset, like the root one, can hold CPUs isolated by
   isolcpus="domain" beside housekeeping CPUs. If an isolated CPU comes
   first, the task would be counted in the default root domain. Its own
   root domain would then be short of that bandwidth.
 - A task confined to isolated CPUs can see them all go offline. The
   rebuild would then find no active CPU, and hit its BUG_ON().
 - dl_task_offline_migration() moves a throttled task, with its
   bandwidth, off CPUs that went offline. The rebuild would count it in
   its cpuset, not where it moved.

In the first and third cases, a root domain would admit deadline tasks
beyond its capacity.

Fix this by choosing the CPU in this order:

 1. The CPU the task is on, if it is active and in the task's mask. A
    mask can hold CPUs of two root domains, for instance after
    select_fallback_rq() widened it. Also the CPU the task is queued on
    out of its mask, if it is active and recorded with the bandwidth.
    Without admission control, dl_task_offline_migration() can put a
    throttled task there. It runs there until it blocks.
 2. dl_bw_cpu, the CPU recorded with the bandwidth, if it is active and
    in the mask. A task moved asleep is not on its new CPUs yet.
 3. The first active CPU of the mask, a housekeeping one if any.
 4. With no active CPU in the mask: dl_bw_cpu if it is active, else an
    active CPU of the cpuset.

The mask of the task comes before its cpuset. A partition change sets
the task masks before its rebuild, and the housekeeping mask after.

Leave out a task with no active CPU, instead of the BUG_ON(). dl_bw_gen
then keeps its release from removing anything.
dl_task_offline_migration() counts it again when it moves it.

A task that select_fallback_rq() moves to another root domain still runs
where its bandwidth is not counted. The next patch moves the bandwidth
with it.

The Sashiko AI reviews of v1 to v4 found these cases.

Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
Fixes: 318e18ed22e8 ("sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 88 +++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a9b8bd019d4b..9ff79141c630 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -927,14 +927,20 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 			__dl_sub(dl_b, p->dl.dl_bw,
 				 cpumask_weight(src_rq->rd->span));
 			raw_spin_unlock(&dl_b->lock);
-
-			dl_b = &later_rq->rd->dl_bw;
-			raw_spin_lock(&dl_b->lock);
-			__dl_add(dl_b, p->dl.dl_bw,
-				 cpumask_weight(later_rq->rd->span));
-			raw_spin_unlock(&dl_b->lock);
 		}
+		/*
+		 * Count the bandwidth in the root domain the task moves to.
+		 * Do it also when a rebuild left the task out, for want of an
+		 * active CPU. A rebuild that reaches the task after this finds
+		 * its dl_bw_gen current, and leaves it alone.
+		 */
+		dl_b = &later_rq->rd->dl_bw;
+		raw_spin_lock(&dl_b->lock);
+		__dl_add(dl_b, p->dl.dl_bw,
+			 cpumask_weight(later_rq->rd->span));
+		raw_spin_unlock(&dl_b->lock);
 		p->dl.dl_bw_cpu = later_rq->cpu;
+		p->dl.dl_bw_gen = dl_bw_gen;
 	}
 
 	set_task_cpu(p, later_rq->cpu);
@@ -3820,6 +3826,60 @@ static void dl_get_task_effective_cpus(struct task_struct *p, struct cpumask *cp
 	cpuset_cpus_allowed_locked(p, cpus);
 }
 
+/*
+ * Return a CPU of the root domain where a rebuild of the accounting should
+ * count the bandwidth of @p, or nr_cpu_ids if there is none.
+ *
+ * Prefer the CPU @p is on, if it is active and in the mask of @p. The
+ * task runs, or wakes up, in the root domain of that CPU. A mask can hold
+ * CPUs of two root domains: housekeeping CPUs and CPUs isolated by
+ * isolcpus="domain". When every CPU of a mask goes offline,
+ * select_fallback_rq() can widen it to both. It moves no bandwidth.
+ * Prefer that CPU also if @p is queued there, out of its mask, and the
+ * CPU is the one recorded. Without admission control,
+ * dl_task_offline_migration() can put a throttled task and its bandwidth
+ * on any active CPU. The task runs there until it blocks.
+ *
+ * Else prefer the CPU recorded with the bandwidth, if it is active and in
+ * the mask. It is in the root domain that admitted the bandwidth, or that
+ * its last move put it in. A task moved asleep is still on a CPU of the
+ * root domain it left, out of its mask. Else take the first active CPU of
+ * the mask, a housekeeping one if there is one. A task on isolated CPUs
+ * that all went offline can have no active CPU at all.
+ */
+static unsigned int dl_task_rebuild_cpu(struct task_struct *p)
+{
+	struct cpumask *msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
+	int recorded = p->dl.dl_bw_cpu;
+	unsigned int cpu;
+
+	/*
+	 * Look at the mask of the task first. A change of the cpusets sets
+	 * the mask of each task before its rebuild. The housekeeping mask
+	 * that dl_get_task_effective_cpus() reads is updated after it. If no
+	 * CPU of the mask is active, take the CPU recorded if it is active.
+	 * dl_task_offline_migration() moved the task there, or an earlier
+	 * rebuild counted it there. Else ask the cpuset.
+	 */
+	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
+	cpu = task_cpu(p);
+	if (cpumask_test_cpu(cpu, msk) ||
+	    (cpu == recorded && cpu_active(cpu) && task_on_rq_queued(p)))
+		return cpu;
+	if (cpumask_empty(msk)) {
+		if (recorded >= 0 && cpu_active(recorded))
+			return recorded;
+		dl_get_task_effective_cpus(p, msk);
+		cpumask_and(msk, msk, cpu_active_mask);
+	} else if (recorded >= 0 && cpumask_test_cpu(recorded, msk)) {
+		return recorded;
+	}
+	cpu = cpumask_first_and(msk, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
+	if (cpu < nr_cpu_ids)
+		return cpu;
+	return cpumask_first(msk);
+}
+
 /* From dl_rebuild_rd_accounting(), under the locks it asserts. */
 void dl_add_task_root_domain(struct task_struct *p)
 {
@@ -3827,7 +3887,6 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq *rq;
 	struct dl_bw *dl_b;
 	unsigned int cpu;
-	struct cpumask *msk;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	/*
@@ -3842,10 +3901,17 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
-	msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
-	dl_get_task_effective_cpus(p, msk);
-	cpu = cpumask_first_and(cpu_active_mask, msk);
-	BUG_ON(cpu >= nr_cpu_ids);
+	cpu = dl_task_rebuild_cpu(p);
+	if (cpu >= nr_cpu_ids) {
+		/*
+		 * No active CPU can count the bandwidth of this task. Leave it
+		 * out of this rebuild. dl_bw_gen then keeps its release from
+		 * removing anything. A later rebuild, or
+		 * dl_task_offline_migration(), counts it again.
+		 */
+		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
+		return;
+	}
 
 	raw_spin_lock(&dl_departed_lock);
 	/*
-- 
2.47.3

