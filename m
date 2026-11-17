Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924676;
	b=Yq8Ls4JRr9ljMmT803cDGe4wFcIFK2B5+t0MTIzVJAl43Sy0TXF+0kl4HotvRg+hwwLe
	 NkpVNONhylCe5HzFimH5R/PkyCiZplvcguQqTbz5g9PoX0CU4huBSeBT+aTptYAw4S6hc
	 lPfGeO1gEQIgsLzcmKIR8YFY2fD5E+XHU6ukR33Jz23cHx0GGCjNvz6CUOditfUFwlkex
	 PBvNfeWcgjW38mTcuGLqB0oELdTTCXsA23M3J6lS+kSW2tXUgpWOhVvKbHLfESZJu/w/H
	 7tVXlQSRwyAqQiwHMtNIXA56uFuNUzhantZ7jZ4p7b7EDpDBSH/lC0lb2t01pMz/OjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924676;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TSuJZoTV5VOgBFs6hbu8BYXig+5tiAMG0Y+z9ib/dWs=;
	b=IQcrq7cOGujcXOsPn6bJnwJWfExhp5ReQuEuxIJ0D7GaxNZZBGFXQ2hxPvH2t/VgFPcz
	 rL3VpOZrLYox/pG92PMhhGICSaAtUe0pPqlmt0llbtVmgrw9WhmfRUGftmfTWoopRS8Gs
	 COCoHRMKEFryodc8vbcPfidTF3co1HTIQjFCXM7vzC71R2KXdol9GgqoyD5BWsDCzbUU7
	 mwbjCf/zk/G4L/97LdYWEN/EqmwkXBAYaBulujSypA92IP+AVb3VD7eLSo57UXEOTG5xQ
	 opuCjXeZlQv+F6lLbLxsS5UuFxSa2daZbU6ZFguFUb6ek9HwfozWiiiCFPeASkY+WZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=qSqrswsr;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121760A5BDE
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2121760A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=qSqrswsr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924666;
	bh=TSuJZoTV5VOgBFs6hbu8BYXig+5tiAMG0Y+z9ib/dWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSqrswsrCCu69Fuhen539ZEdOndgN0PUol5rXo8HwoJcRhSl8fzDe1y1bl98BNmUY
	 8UyAcmA+jLqezEPFMCvOPlk1LkusnLKe6ft5xKUj2Ds2O2YnJmB2Nqn4hJGwhIQsz8
	 GdKoQ5/0scJ/n/At7Gd4NutsaYpX3n6NURsxOcF5kr5I/IkKC89/1hsHbW0KNAmZyp
	 mmNz7klzsyPpf+CnID+MKUb4fZYvd3RkRJ8kjmvR0v4OtrTjmMRMARuQ1+B/x54tmz
	 Q8LVvQdmczjqJZShXbCXMsBuWbG8Ld0ATxXX9DEwDE+HU4bhfH3kz8E7reURBrMrNL
	 56DGEOJPntmlw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV20PtjzRmZ;
	Tue, 17 Nov 2026 09:11:06 -0500 (EST)
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
Subject: [PATCH v7 10/40] sched/deadline: Reset the deadline and the runtime with the parameters
Date: Tue, 17 Nov 2026 09:10:31 -0500
Message-Id: <2931e871568442196444a57d784b64c04f57f968.1794922146.git.mathieu.desnoyers@efficios.com>
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

A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
("sched/deadline: Improve the tracking of active utilization") moved
their reset to that time. Before it, the replenishment timer did the
reset at the deadline. So a task back after the reset found its
deadline passed, and started a new period. But __dl_clear_params()
resets neither the deadline nor the runtime.

Now a task back after its 0-lag time can be enqueued on its old
deadline and runtime. With runtime left, its 0-lag time comes before
its deadline. Back before that deadline, it would first spend the runtime
of the reservation it gave back. Back after it, a constrained task
would be throttled until its old period ends. "sched/deadline: Do not
lose a throttled task switched out and back" moves the deadline of a
throttled task on. This widens the window before the deadline to about
a period.

A task with no parameters of its own, boosted by a deadline waiter,
keeps the donor's deadline and runtime after its deboost. If it then
enters SCHED_DEADLINE before that deadline, it runs on the donor's
runtime. On v7.4-rc2, a task of 10ms per 100ms ran 40ms of its first
period.

Fix this by resetting the deadline and the runtime in
__dl_clear_params(), and in switched_from_dl() at the deboost of a task
with no parameters. The next enqueue then starts a new period.

The Sashiko AI review found the first case in the second posting of
this series, and the deboost in the third. The deboost_resets_period
case of deadline_bw_test, added later in this series, tests the
deboost.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b1c155c242..d6d2657dcddd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3569,6 +3569,16 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(&p->dl, false);
 
+	/*
+	 * A task with no parameters of its own was boosted into the class.
+	 * Its deadline and runtime are the donor's. Reset them, so that its
+	 * next entry into the class starts a new period.
+	 */
+	if (!p->dl.dl_runtime) {
+		p->dl.deadline = 0;
+		p->dl.runtime = 0;
+	}
+
 	/*
 	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
 	 * keep track of that on its cpuset (for correct bandwidth tracking).
@@ -3984,7 +3994,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
 }
 
 /*
- * This function clears the sched_dl_entity static params.
+ * Clear the static parameters of @dl_se. Also reset its deadline and its
+ * runtime, so that its next enqueue starts a new period.
  */
 static void __dl_clear_params(struct sched_dl_entity *dl_se)
 {
@@ -3995,6 +4006,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_bw			= 0;
 	dl_se->dl_density		= 0;
 
+	dl_se->deadline			= 0;
+	dl_se->runtime			= 0;
+
 	dl_se->dl_throttled		= 0;
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
-- 
2.47.3

