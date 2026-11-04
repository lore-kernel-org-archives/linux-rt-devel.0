Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826744;
	b=ds8ksi3IONnZd2MumpOMS3reY8SrCg5rRilHzFjvf98xIVuksm/DIGdjfjJz1MXGYv/K
	 rp4V0b+U7D9UvUPF4hUK0jHhrozrieEzmI0y9Bwfq0Tym75o4N+OuGXSpmbJ5FyP72MsH
	 4wmQZ9jURkHoLPI290/53NoDwzNa0C2shUtZo1enhAIo1BvkVXli1Av8tHTbW757Pya1/
	 BAJIpW67rAqorZTu5WhQ6cBPJ2fmzfFCoiOQmXYY5oeubEK63CXsBEDuaW+2TCQrJHI3f
	 4DbwJAAgVmDlf85t6c+OIKM49kIha6ko40eFWaT3LaLNZ5Vbmdh6ThnZ6xagA4BypZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826744;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6nW76LHW1M1CJQpMcvCs2TBoKFhchXf77EjxuZBJpEs=;
	b=5DTRv9l68sUGXUgr32JaeiYeEPvWrPP+6CjQLnhDxRcfwZUnQz3y85R0XqkPyU07NDVm
	 4wxQHjtCtMV/vE4xqQSc+3Zmiyz+xvtkl5O/yChTBIwG7H0ger/0EIRnjV42plusA+wmY
	 CcrVmKuSYqs56x7c8CBdE/ZcaLNK970XESapVmHK33ZYmSj61IheFz1yfmegdRH4VaAC+
	 0MZpPBMvJSoXPBM2OSNV32qj4bBtP28vGjlvU2c7BfPZQBzPBxpfOUCNDi5GWQhKZ0vVK
	 XMuwbN4+DMFrzpslyHO7ua74BAZy2R3e2byhYq3lrl8dRXwzqIeSiLDMung1FHsKNaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABA60807B7
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 21:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AABA60807B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793826732;
	bh=6nW76LHW1M1CJQpMcvCs2TBoKFhchXf77EjxuZBJpEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O65TuIV7cQu1Lb+W22GzWGB5ezlivqYmRIJ/HtcvD7tj1fdgaVzXVfjiWTVpm9P3G
	 HNxHryuVlZwC2Y/Bu0zFmTYSDjz0hWodXVHf6tDKA2NzpMpse8bacx880HkYF6Gq0P
	 b5Flqdg11DjhWWlM+cPLy62BDqxn4O9NNHK+nbL+Ox72a2ai8fslmmLYqqYM/Kblsu
	 gbm1Xjl1w6lDK4Xt7Y2N+gyMjA2SBq6Y+O1aWmyjLl9NxJlTpEAurCXP3gso+r/00R
	 f2g7C760JnuHax7S8vLgOivd9k1b8pRcmFuPneH0+jo6p/vrdNdnMydPOOpWL4jA31
	 Td8WSWOUeTFjA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKdRw5n5QzLT1;
	Wed, 04 Nov 2026 16:12:12 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v2 02/21] sched: Refuse SCHED_FLAG_KEEP_PARAMS that would change the policy
Date: Wed,  4 Nov 2026 16:11:48 -0500
Message-Id: <20261104211207.1392343-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
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

SCHED_FLAG_KEEP_PARAMS keeps the parameters of a task: it skips
__setscheduler_params(), which is what sets p->policy. A request that
asks for another policy is then carried out by half, and succeeds:
SCHED_OTHER to SCHED_BATCH with SCHED_FLAG_KEEP_PARAMS returns 0 and
leaves the task where it was.

For SCHED_DEADLINE it costs bandwidth. A task that priority inheritance
boosted into the deadline class is of that class already, so
prev_class == next_class and the class check of
commit 8a70415351ba ("sched: Reject SCHED_FLAG_KEEP_PARAMS when it would
change scheduling class") lets the request through: sched_dl_overflow()
admits it and adds
its bandwidth, which the skipped __setscheduler_params() never gives to
the task. It keeps SCHED_NORMAL and a dl_bw of 0, so nothing releases
that bandwidth, and total_bw of the root domain holds it for good.

Refuse a policy change as well, where the class change was refused
alone.

A SCHED_OTHER owner of a PTHREAD_PRIO_INHERIT mutex with a slice of
40ms, boosted by a deadline waiter blocked on it, leaves 0.4 of a CPU
behind at every such call: total_bw 419424 -> 838854 and there to stay,
in 8-CPU VMs of v7.4-rc1 with the four deadline fixes of sched/urgent,
and of this series up to here. With this change the call is refused and
total_bw is as it was. The selftest added later in this series has the
case, params_keep_boosted.

Found by the Sashiko AI review of the first posting of this series.

Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/syscalls.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index f0b7b2d52614..ab0a573e9b37 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -674,20 +674,25 @@ int __sched_setscheduler(struct task_struct *p,
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(policy, newprio);
 
-	if (prev_class != next_class) {
-		/*
-		 * SCHED_FLAG_KEEP_PARAMS prevents the class change from
-		 * actually happening (it skips __setscheduler_params and
-		 * the sched_class assignment). Reject contradictory
-		 * requests that ask for a class change with KEEP_PARAMS.
-		 */
-		if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) {
-			retval = -EINVAL;
-			goto unlock;
-		}
-		queue_flags |= DEQUEUE_CLASS;
+	/*
+	 * SCHED_FLAG_KEEP_PARAMS prevents the policy and the class change
+	 * from actually happening: it skips __setscheduler_params() and the
+	 * sched_class assignment. Reject the contradictory requests that
+	 * ask for either, rather than carry out half of what they ask.
+	 *
+	 * A class change with the policy kept is one of them: the class of a
+	 * policy depends on the priority that priority inheritance leaves,
+	 * and on whether a BPF scheduler is in charge.
+	 */
+	if ((attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
+	    (policy != p->policy || prev_class != next_class)) {
+		retval = -EINVAL;
+		goto unlock;
 	}
 
+	if (prev_class != next_class)
+		queue_flags |= DEQUEUE_CLASS;
+
 	/*
 	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
 	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
-- 
2.47.3

