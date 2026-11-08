Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147245;
	b=4+k86EIekwYXZgPQrOPwHJHIg6tboS9Gp/WNcaBSmSMVL8QrPuBfu7XG8OvMB4qSX6i6
	 KIAZcxFnGVBvu9lJRIOyDqzEfxqRlFJl49nl2fxIxjxfaSF5H+9AsR5+M7waNeMrdoog6
	 ANFwijHCj8t3wMK0wmfxhUWfx/P3mH2FBD9pWS4pyfsJMDI5uITJ24AT4k//cvMQj7tHP
	 aLVwaaD2XpbN7yKmZLrrU3BUUoiLWo0NRqdQbI4amIJ4jLA4e++ZFBA9IiXQ+DJyWDQk8
	 9yVTpEhMvQiLNlF7ZMjySSM9RJTy1kMGElMRx9tk6NjyTB0EQ9VkGppHqzPAJvcOBsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147245;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RD9wBI9Yu/LeRJ+j05l5UqSYv5kN0CfbFsjR9ogEBcE=;
	b=xVugYBaMMkmHly0KMjGiwg9HKLcAUtXHHhu+MQ/39BUHb30Y/tw/GSgetRB75s/cgTD+
	 7MVI5x3hGGWcHmELHh6RBagbqRv45npNj152pp2p/iB3lQJ3Uz1rx4N+lQRIDIKgl7AZJ
	 BgB7s6s0WVipaVnIu45DssCjgBV5JWRsCnJJlF3cDtYgewmM7uLfO8H2hBqFanRNfAi5B
	 9qTii7tcA53Mz1i2wDqEjiRaBzRPWz+PVVVXEXxa+RQJpjRhigNfh/0Od78xZlwN2EKTW
	 Wkv/uj106KLUoGPCv+/9gUdqYXz6b/vnS3oJQtGh1Bx3aUO3kA5DK1NFIgrLjqCodeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ntNNri5k;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8A606A322
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 14:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E8A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ntNNri5k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794147236;
	bh=RD9wBI9Yu/LeRJ+j05l5UqSYv5kN0CfbFsjR9ogEBcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntNNri5kq9o4YnCOvZXKsHhjnQYP70QeAOub505HN2eid21LQpgGauPPKmznLrAns
	 q1KbuT8U7Gc6Y3Ow0qwtORaGADHofqyPLk5Xjf/22cQKp+AHAwuoCOrk3n3q/NCz+O
	 YU7s9q3pw8H/QlsIQ6SSfLGps+O8dxPDXgYoC9EphPVnWiAxnU3Gm3bhxF+fl5zfr7
	 Wv3BvUhce6t/nldRuWg3URxJDC0JW2uJaFkwc+MXze/Ive8vS3NzPoMMy0kxXqtm+3
	 3XPoV/uTtB9WO9LGsp0fY/g8fJ8tqzH/HC4OOZjZg1OFJafjSkSZ4+On7zmjdH0p7L
	 ybUCJkXAWkPqg==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jMvzS4vTmzMgn;
	Sun, 08 Nov 2026 09:13:56 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	shuah@kernel.org,
	juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] locking/rtmutex: Clone the sort keys in rt_mutex_enqueue_pi()
Date: Sun,  8 Nov 2026 09:13:45 -0500
Message-Id: <20261108141347.1525532-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
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

An rt_mutex waiter has two copies of its sort keys. waiter->tree sorts
the waiters of its lock. waiter->pi_tree sorts the pi_waiters of the
lock owner. Only the top waiter of each lock is in pi_waiters.

When the priority of a waiter changes, the chain walk updates
waiter->tree. It copies waiter->tree to waiter->pi_tree for the top
waiter only. A waiter that is not the top waiter keeps its old pi_tree
keys.

Such a waiter can become the top waiter later. remove_waiter() does this
when the top waiter leaves. try_to_take_rt_mutex() does it when the lock
changes owner. Both put the new top waiter in pi_waiters without a new
copy. So pi_waiters sorts it by a priority it no longer has. The owner
then inherits from the wrong waiter, at that waiter's current priority.

In this example, O is the owner, a SCHED_OTHER task. L1 and L2 are two
rt_mutexes. W1, W2 and W3 are waiters. Their SCHED_FIFO priority is
under their name. T is any other task. It changes the priority of W2:

  T                         O                W1                            W2           W3
                                             FIFO 80                       FIFO 70      FIFO 50

                            locks L1, L2
                                                                                        blocks on L2
                                             blocks on L1 (timed)
                                                                           blocks on L1
  sched_setscheduler(W2)
    W2 now at FIFO 10
    rt_mutex_adjust_pi(W2)
      W2->tree: FIFO 10
      W2 not top: no copy
      W2->pi_tree: FIFO 70
                                             <timeout>
                                             remove_waiter()
                                               rt_mutex_enqueue_pi(O, W2)
                                                 W2 sorted as FIFO 70,
                                                 ahead of W3
                                               rt_mutex_adjust_prio(O)
                                                 O inherits W2's FIFO 10
                            runs at FIFO 10                                             still waits

The owner runs at SCHED_FIFO 10 while a SCHED_FIFO 50 task waits for
it. This needs no race. Each step can come long after the one before.

Fix this by copying the keys in rt_mutex_enqueue_pi(). All callers hold
the wait_lock and the owner's pi_lock, as waiter_clone_prio() requires.
Remove the three copies the callers made.

With this patch, the owner runs at SCHED_FIFO 50. The
futex_lock_pi_inherit selftest added later in this series tests this
case (promoted_waiter).

Fixes: f7853c342418 ("locking/rtmutex: Fix task->pi_waiters integrity")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/locking/rtmutex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 323973be2074..975efa1d864c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -517,6 +517,8 @@ rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
 	lockdep_assert_held(&task->pi_lock);
 
+	/* The tree keys can change while @waiter is not in pi_waiters. */
+	waiter_clone_prio(waiter, task);
 	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
 }
 
@@ -1005,7 +1007,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
-		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
 		rt_mutex_adjust_prio(lock, task);
 
@@ -1022,7 +1023,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
-		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
 		rt_mutex_adjust_prio(lock, task);
 	} else {
@@ -1243,7 +1243,6 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
-	waiter_clone_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
-- 
2.47.3

