Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207371;
	b=w1q7Z18MFn97w21rihvk6JphwF6jykSYw6TA0ZEnwnXVr2RzBcVkoWz7DrxYCinBHghb
	 lK8F3q1toT9E1LlKFKBUrqtHyoIZHDJU7dicI479EzkYrJdn7+Y3cECQ4MJXCPzLSusMw
	 awXhpPbsXHQrXLAxMKtgANdfMbVeiVVySmXp8RNpqciR9cgE9IQj9Q02DysiKjbWQlWO9
	 QWREfu68WB9NsnMdGH4wsUYoykbtuhawgSQ8crY3Sk1BwOdmJFMT+7tY9wtF5XiTG0j9n
	 ImxHwsD8SEFca86AOF2YsLG3Jpqi4wW0/LEWDdEHCjpcALl3XoA3m1pW3KO3QcxWKpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207371;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CNvfx3FsmRuSU4jKrv6OcILPWoIpbOIycZRWputDuP0=;
	b=xHemXqbENW6mZ5FCrrYQTmVeNXpI8mSgEyOkM1TDSkgEGFiaSeR7o75dxl6ZaV9FO5Ws
	 1/5w+7Z1eOPamz0lrwbUBtWDmFeGFmIKtWBWrQ5FmY+Wq+LUvqc66LgbG5ipoNab1Qghx
	 tI0ym1xQj228J6AMTFTBqRYk5ErsWwVIICBehSZa77hmzBaDeoALpZd7al7jNOt4eqcb3
	 FX9ELBp5TgmTpNmwwz+R/UNobHWfakYwFtqdPMfn9pTlELm9EMY5R2WE8k/cxDvXK8Vtl
	 Swy8eZY8oRIKeuKvBcEDQ2jxc7PLdkGpbz9wT54jpq92pUnwNRdY2ExDFayD8XDvaSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=jE0wqTxw;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0A60A2637
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 20:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A0A60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=jE0wqTxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795207356;
	bh=CNvfx3FsmRuSU4jKrv6OcILPWoIpbOIycZRWputDuP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jE0wqTxwsKbM581p5MEU7tPoJ8lJ6oGMwbLT20bwXEZn3d6N3udfKffr5sJK2CQFv
	 8NZt3EFGWyweZNJxlJ8BRKIQwJLcEHgtZcbD4VN3PjaNsRM6kL2zgz1h24sYh7qHcv
	 FIUlMMoj3XQgXxe8+nQTv93OPxjE9UigyhiGN3HSiTSAYYw8tpDqIJ6gxwn7x/gH3x
	 AemICfFoFq1Jg4fTM/te/khRaTNztlO3/rokP7/axhZV+fTSr2TuuGBDARnwxXuc3B
	 x9gogqFig2+QBT5KOy2wndoQLcqPN3jWGjBM9sAeQRNk+ko3/XwwcvulL05QfGEzyl
	 xS4wldhlK5/0Q==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jWS2N4tmHzTqc;
	Fri, 20 Nov 2026 15:42:36 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v10 26/40] sched/deadline: Replenish a throttled task boosted while asleep
Date: Fri, 20 Nov 2026 15:42:03 -0500
Message-Id: <9c0cc7d7c43e0562a9fc9f363898178b36c6e9c2.1795207232.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
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

A deadline task can be throttled as it blocks, with an rt_mutex held.
Its replenishment timer is then armed. A deadline waiter can boost the
task while it sleeps.

Commit feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads
while enqueuing") lets a boost override the throttle. enqueue_task_dl()
lifts the throttle of a boosted task, and dl_task_timer() ignores a
boosted task. This covers a task that is enqueued while boosted. But a
boost of a sleeping task does not enqueue it.

T is a SCHED_DEADLINE task that holds the rt_mutex L. W is a
SCHED_DEADLINE task with an earlier deadline:

  T                                  W                              T's timer

  uses up its runtime, sleeps
    dl_throttled = 1
    start_dl_timer()
                                     pthread_mutex_timedlock(L)
                                       rt_mutex_setprio(T, W)
                                       T sleeps: no enqueue
                                                                    dl_task_timer()
                                                                      T is boosted: returns
                                     times out
                                       rt_mutex_setprio(T, NULL)
  wakes up
    enqueue_dl_entity()
      dl_throttled: waits for the timer

The timer has already fired. T would never run again, not even to die
of SIGKILL. Every later waiter on L would hang too. This was found by
reading.

Fix this by returning early in dl_task_timer() only for a boosted task
that is queued. A boosted task that sleeps then takes the existing path
for a throttled task that is not queued: it is replenished.

The refill reads the parameters of the donor, from the timer. So this
relies on two earlier patches. "sched/deadline: Do not replenish a boost
from cleared parameters" keeps the refill from looping on cleared
parameters. "rtmutex: Continue the chain walk when a waiter's deadline
donor changes" keeps the donor pointer from going stale. After a deboost in
the class, "sched/deadline: Reset the donor's runtime at a deboost in
the class" starts a period of the task's own reservation.

The Sashiko AI review of this series found this.

Fixes: feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads while enqueuing")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2912d13b60d6..9a4639ae676a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1705,10 +1705,13 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	}
 
 	/*
-	 * The task might have been boosted by someone else and might be in the
-	 * boosting/deboosting path, its not throttled.
+	 * A boost overrides the throttle. enqueue_task_dl() lifts it when the
+	 * boost enqueues the task, or when the task wakes up boosted. So a
+	 * queued task needs nothing here. A boost of a sleeping task does not
+	 * enqueue it, and it can end before the wakeup. Nothing would lift the
+	 * throttle then. So let a sleeping task reach the !queued case below.
 	 */
-	if (is_dl_boosted(dl_se))
+	if (is_dl_boosted(dl_se) && task_on_rq_queued(p))
 		goto unlock;
 
 	/*
-- 
2.47.3

