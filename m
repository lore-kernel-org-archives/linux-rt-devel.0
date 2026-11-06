Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009595;
	b=a5N+LsYlqBo2WFm5lQW5WOE7iw2IFy20XnVKucjBr55qgBoekp9WN6v7y1W8E6e3GEdA
	 fBP8ZJ86SmeRzn4Yfkp0OmGNCC8ufpc5An1nTl6+MNNNFajV2mQh5XundVYjZZ51ZFuSP
	 g+k6nf/nqnJiENVugvDyHxcRmvcbH16eGcOhtb3ST187BcdY2FIfY4rBWZTydkrl+9SDd
	 LumKBdYLkVm7LtcrmjaDaDkBuBlCWzIleZ6PnhyIm88rNpXDcwrOBbMj/7J7B+VFs74zI
	 DJ4sGznfegACL3kGpe3T5saNc0e69PIaPHDLRwwBdm6cjgoNbeENrV3jysSfLm9Q1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009595;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K5qgzjvth7HyNn4wHDgsHLoQmJi9QSsbYOjhd+zHt2E=;
	b=5dsPhTpLdXlmD1cFxux5KyzfAnETqOECi1Er/9fnmYnmGR+0pUtjh5YzqHwJ1fMNuOeW
	 vXsMAiKHxe7ak6N5BVGbMmCtUdA7FnPUbIf9/1WfZUFEachglm2tkEtQNURaigFsX4U7X
	 cBPRPTQ39X4BNgikZ/XZaYPJtgrB53SqfbmoTTmDtOTv+hbPPWjqLP8qP5cZq+Tv9jSx3
	 LDFIcFHo85FsFY6t6qUXC87okdB2sfb/WUDkZUz9JQq1o0nB5WQHWMSgnIw3h0W6nhDPL
	 w4h2LnRI35EYGY8/8/jftY2CkAj0U/WeGa2Lo/URa40M2LoG3G2OxAJg2nQNJt1zrOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=EsZxrBjK;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F14606A33C
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 23:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25F14606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=EsZxrBjK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794009587;
	bh=K5qgzjvth7HyNn4wHDgsHLoQmJi9QSsbYOjhd+zHt2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsZxrBjKHzxEjIJVaFYGPfUzdni4t0xErxhmsgo+Tzzrv2uSJObHZg4YCOQIk2lqW
	 tsm6A23V3U2K6h4j7r7q/zcIhHYMMbTayFrVIsyT6XNWhL5kSIrJhod1GqtYS6EYm4
	 kR/WqTq3xrmXnazoqjvYHTeW/0VAWS1puZa0f5uaiLe2O91JIUQnrDvQNH52U8hIUU
	 5KqhWACkGuF5ykOQjH/PM+JGGXTqS61aVg1PJQxpDXkNkl0a5VezF832GAMObuEvan
	 sv5f33FOYpy0eO0YlUhPUA0i2TDVSMGHtCAfTQplDdlmfIr4PkPhyHhtXdkc2WKNNP
	 rwy0K7+lIV9PQ==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLx4M1H9qzLly;
	Fri, 06 Nov 2026 18:59:47 -0500 (EST)
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
Subject: [PATCH 3/5] locking/rtmutex: Clone a waiter's sort keys as it enters pi_waiters
Date: Fri,  6 Nov 2026 18:59:29 -0500
Message-Id: <20261106235931.1478800-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
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

An rt_mutex owner can inherit the priority of the wrong waiter. A waiter
has two copies of its sort keys: the lock tree's, updated when its
priority changes, and the pi_tree's, which orders its owner's
pi_waiters, cloned from the first when the waiter blocks and by the
chain walk while it is the top waiter of its lock. A waiter whose
priority changes while another is ahead of it, and that becomes the top
waiter later, as the one ahead times out (remove_waiter()) or the lock
changes hands (try_to_take_rt_mutex()), enters pi_waiters with keys it
no longer has. On v7.4-rc1, an owner with a SCHED_FIFO 50 waiter on one
mutex, and on another a SCHED_FIFO 70 waiter set to SCHED_FIFO 10 behind
one of 80 that times out, runs at SCHED_FIFO 10 while the SCHED_FIFO 50
task waits on it, in 3 runs of 3.

Clone the keys in rt_mutex_enqueue_pi(), under the wait_lock that the
lock tree copy is updated under and the owner's pi_lock that the
pi_tree copy is read under, and drop the clones its callers did. The
owner then runs at SCHED_FIFO 50, in 3 runs of 3. The
futex_lock_pi_inherit selftest added later in this series has the case,
promoted_waiter.

Found reviewing "sched/deadline: Take a deadline boost from the
waiter's rt_mutex node", posted in a series on top of this one, which
takes a deadline boost from these keys.

Fixes: f7853c342418 ("locking/rtmutex: Fix task->pi_waiters integrity")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/locking/rtmutex.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 323973be2074..e89f0f0e604b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -512,11 +512,19 @@ static __always_inline bool __pi_waiter_less(struct rb_node *a, const struct rb_
 	return rt_waiter_node_less(__node_2_rt_node(a), __node_2_rt_node(b));
 }
 
+/*
+ * Enqueue @waiter in the pi_waiters of @task, its lock's owner, with the
+ * sort keys of its lock tree copy, current under the wait_lock held here:
+ * the chain walk updates the tree copy of a waiter that is not the top
+ * waiter of its lock, and does not clone it, so a copy cloned before would
+ * enter @task's pi_waiters with the keys of a priority it no longer has.
+ */
 static __always_inline void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
 	lockdep_assert_held(&task->pi_lock);
 
+	waiter_clone_prio(waiter, task);
 	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
 }
 
@@ -1005,7 +1013,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
-		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
 		rt_mutex_adjust_prio(lock, task);
 
@@ -1022,7 +1029,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
-		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
 		rt_mutex_adjust_prio(lock, task);
 	} else {
@@ -1243,7 +1249,6 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
-	waiter_clone_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
-- 
2.47.3

