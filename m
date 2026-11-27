Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790180;
	b=emHcWRASyA5+h9MBM3MpcOZvpvawrK1A1Rn1JSynsHs4Wse90rCnesfW3qJlZp395Cvh
	 korqWjUO7+/ivHgdPkd3BcZcB74OZZ1mBwCbEGAc4qapU+HOnYyaTMqnDNAfKsnGEpVbq
	 6mMUMyijY80mv1nMBUpw9e7lqV3iUP+V6PSz9gRChETXdPQVWflPeNZt+UleB9v/bCMqC
	 3SgCdg7crbsYun+ptm/Zqw/3KK6bExu7qpBwqz8s/FdYaNQ0fF1s9Cz7n/eyiv075cuDP
	 q0/3b7ZXFxRxWXdAcwaZliXXxcChTE5iA3IQnBIn9jMQB8KoNfhGxCnJMIzDSkW3P9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790180;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UNfXRsGfHoyy/U6tpwZgKkZ2HKP6ILdRnxLWKmbUmYg=;
	b=FQhDqDhGhdXtb3Ehr7AEAuLM6ON/v/DQSifYcS7yAxH2uXcmSqdwnmZNbN3IYJntX/T0
	 r+FFu0yYj2vkBJZQPhuiwHviwBB7YXdI8TF0J5DqhfGdUNXkTC5f2bNuvEqVXU+nQFNWq
	 nZ9YE/UBAZUbnWbUpeC+M0R+tDgzs27Rz17k1edH58U5hmUPvmOQlp+M4zw/8yAGnL5Ru
	 K6kIpLxkOYjqDaTMeVp+Xarpo4qMGt1fvZoSJT7wddEY4OGhLdgk5XBurEU5iQ8xpNewk
	 Y0kxnnwXMSZk/42Qn0EocCXv88R4TS9MBHgaQTk9R98TbCgMKPOOL/NKuBcmNm2S4hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=lHWaFOoY;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DCC60A5BFC
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 14:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DCC60A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=lHWaFOoY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795790177;
	bh=UNfXRsGfHoyy/U6tpwZgKkZ2HKP6ILdRnxLWKmbUmYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHWaFOoYC+DReIiXlTpmpDYUpSbjxGcLPaJk2Gw3pUUropScigFSeR69B4+X4h49Y
	 wckhiLWkDJH2faQS3y1FzCeLqEsdwcZVpWxQmAdihksFjL4IurEDJlt8maagRx18og
	 MnCXVwNYkb9uarH6gCyRxoF9ua2GAU9kNExCArHqxdAH/UsHoO3fB241ESU0cpWJKz
	 L1h5IBWpxedgqDTNqgH/NXpILJVM4WDh8VxcgBpsyytrr2D1Rei8kCofSlA2sqbLPQ
	 D+2JXelk8b3nh6n+/MRgDlL7ryTtAX/kpa/yJF5KPDlwAvulx5AMIR9iMX8yJGIxJS
	 0BlzwRSWp+T0Q==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbbZT2drnzXZM;
	Fri, 27 Nov 2026 09:36:17 -0500 (EST)
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
	tommaso.cucinotta@gmail.com,
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
Subject: [PATCH v12 22/43] rtmutex: Do not stop the chain walk at an owner whose top waiter changed
Date: Fri, 27 Nov 2026 09:35:49 -0500
Message-ID: <482c6c8e24d0aec9e9e875b14087fb465034fd6b.1795771148.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
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

rt_mutex_adjust_prio_chain() stops the walk early at an owner in two
cases. Each case misses a change of the owner's priority:
- The owner's top pi waiter is not the top waiter of the lock just
  walked. That lock then does not set the owner's priority, so there is
  nothing to pass on. But the step before can requeue a waiter whose
  priority dropped. The top pi waiter of the owner can then be a waiter
  on another lock. The owner's priority, or its deadline donor, changed.
  With deadlock detection on, the walk went on, but without requeueing.
  It now requeues there too.
- The owner has no pi waiters left. A waiter that left caused this, and
  remove_waiter() walks on from the owner itself. But that walk can be
  preempted and come late.

The walk then stops at the owner, and the next owner keeps the old
priority or the old donor. With deadline tasks, the old donor can exit.
The refill of the next owner would then read its freed task_struct.
When the waiters are SCHED_FIFO tasks, the first case leaves the next
owner boosted to the old priority until it releases its lock.

Fix this by removing both checks. The next check already stops the walk
when the owner's waiter is up to date. An out of date waiter is now
requeued, and the walk goes on to the next owner. A late walk can still
leave an owner on an exited donor for a while. The next patch keeps the
donor's task_struct alive as long as a boost points at it.

The first case, with deadline tasks. O and M are SCHED_OTHER tasks. W
and Z are SCHED_DEADLINE tasks. W has the earlier deadline. X is a
SCHED_FIFO task. It takes the top of L1' from W:

   O         M                 W                                  Z             X

   locks L2  locks L1 and L1'
                               blocks on L1'
                                 M->dl.pi_se = &W->dl
             blocks on L2
               O->dl.pi_se = &W->dl
                                                                  blocks on L1
                               sched_setscheduler(SCHED_OTHER)
                                 rt_mutex_adjust_pi(W)
                                   M->dl.pi_se = &Z->dl
                                   walk at M: L1' is not M's top
                                     stops
                                                                                blocks on L1'
                                                                                  walk stops at M
                               times out on L1'
                                 not the top waiter: no walk
                               exits
   runs out of runtime
     refill reads O->dl.pi_se:
       W's freed task_struct

The second case. O, M and X are SCHED_OTHER tasks. W is a
SCHED_DEADLINE task. Another task, S, changes the policy of W:

  O         M            S                          W                          X

  locks L2  locks L1
            blocks on L2
                                                    blocks on L1
                                                      M, O get W's parameters
                                                                               blocks on L1
                         sched_setscheduler(W)
                           walk at L1: W behind X,
                             M deboosted
                                                    times out on L1
                                                      not top waiter: no walk
                                                                               times out on L1
                                                                                 M: no pi waiters
                                                                                 walk from M:
                                                                                   preempted
                           walk at M:
                             no pi waiters, stops
                                                    exits
  runs out of runtime
    refill reads O->dl.pi_se:
      W's freed task_struct

The cases pi_chain_top_moves and pi_chain_top_moves_rt, added to
deadline_bw_test later in this series, test the first case.
pi_chain_top_moves_rt fails without this patch and passes with it.
pi_chain_top_moves also needs the previous patch. No case tests the
second one: it needs a walk preempted at the right step.

The Sashiko AI review of this series found both cases.

Fixes: 23f78d4a03c5 ("[PATCH] pi-futex: rt mutex core")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/locking/rtmutex.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c78dfe9c93fc..b09816977d4e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -818,27 +818,14 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		detect_deadlock = false;
 
 	/*
-	 * Drop out, when the task has no waiters. Note,
-	 * top_waiter can be NULL, when we are in the deboosting
-	 * mode!
+	 * Do not stop at a task that has no pi waiters, or whose top pi
+	 * waiter is not top_waiter. The previous step can have made a
+	 * waiter on another lock the top pi waiter of the task. A waiter
+	 * can also have left meanwhile, and its own walk can be late. The
+	 * priority of the task changed then, and the next owner must
+	 * follow. The test below tells whether there is something to pass
+	 * on.
 	 */
-	if (top_waiter) {
-		if (!task_has_pi_waiters(task))
-			goto out_unlock_pi;
-		/*
-		 * If deadlock detection is off, we stop here if we
-		 * are not the top pi waiter of the task. If deadlock
-		 * detection is enabled we continue, but stop the
-		 * requeueing in the chain walk.
-		 */
-		if (top_waiter != task_top_pi_waiter(task)) {
-			if (!detect_deadlock)
-				goto out_unlock_pi;
-			else
-				requeue = false;
-		}
-	}
-
 	/*
 	 * If the waiter priority is the same as the task priority
 	 * then there is no further priority adjustment necessary. The
-- 
2.47.3

