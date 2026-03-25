Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94127A907
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407936; cv=none; b=CpFiIyFaNeq7Nb/VCN0TjNKqRH9DQqMi4SM9dMt3pQdF/+uUsbwwBZx/GazJ+g6kprR2O4OncjuZtxlLvFyf+kecV0sLDLFMBGQ3e+B8lKlm/QlA87s/V7ZT1QQcSG64Glyxv9cbWqWbOGANsPUk76bOR2ZOt3031KtzCrJsmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407936; c=relaxed/simple;
	bh=JXHqg5hWd8bPxBjBym+A4W/OFM5UnnMAfI0nq4CgEfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jor+BMEjnOr8nH6v/+I6ntXdUWLo+M8zbuqtsbDZ8VYOaOvO3ZYqJBUmNcWe0pmrl2N6W15PKF27s5lWQG4Ch9HbK04vHR9VWVv5ZTSimD9Zu0AK8q7jt2GLlx9HGXrDDF2aemL+m/95IJAu90Cx0v6Lg4FMB3t8KYtnvOnDntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMf/E2VI; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMf/E2VI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774407932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KJ5Osz+94CcgUJbNmrLhEgNmoTHmbTb5mo8a4nYQ2+A=;
	b=KMf/E2VISyfo2STbJxUuhTRqXpWN+hKStIxX7hxoA+vvZDjJin4JnX6YwROwIXx9RbWQZg
	Etw8YpA/3xWo8dytdw0GcHyjTQlcS94RpC3gYoYCxkUzk36dfgcYO/zBNp/OTFQot0v3Zm
	tH7YuxZEdCNK3q+j/lY1gFDikKpuNBo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-rt-devel@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on PREEMPT_RT
Date: Wed, 25 Mar 2026 11:05:04 +0800
Message-ID: <20260325030508.321405-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On PREEMPT_RT, non-HARD irq_work runs in a per-CPU kthread, so
irq_work_sync() uses rcuwait (sleeping) to wait for BUSY==0.

After irq_work_single() clears BUSY via atomic_cmpxchg(), an
irq_work_sync() caller on another CPU that enters *after* BUSY is
cleared can observe BUSY==0 immediately (without sleeping), return,
and free the work. Meanwhile irq_work_single() still dereferences
@work for irq_work_is_hard() and rcuwait_wake_up(), causing a
use-after-free.

Note: if a sync waiter is actually sleeping, @work is still alive
(it can't be freed until the waiter returns), so there is no UAF in
that case. The UAF only occurs when sync checks BUSY==0 without
going through schedule().

Fix this by extracting and pinning the irq_work_sync waiter's
task_struct (if any) while BUSY is still set and @work is guaranteed
alive. After clearing BUSY, wake the pinned task directly without
touching @work.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/irq_work.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 73f7e1fd4ab4..b10b75d1cc09 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -200,6 +200,7 @@ bool irq_work_needs_cpu(void)
 
 void irq_work_single(void *arg)
 {
+	struct task_struct *waiter = NULL;
 	struct irq_work *work = arg;
 	int flags;
 
@@ -221,15 +222,37 @@ void irq_work_single(void *arg)
 	work->func(work);
 	lockdep_irq_work_exit(flags);
 
+	/*
+	 * Extract and pin the irq_work_sync() waiter before clearing
+	 * BUSY. Once BUSY is cleared, @work may be freed immediately
+	 * by a sync caller that observes BUSY==0 without sleeping, so
+	 * @work must not be dereferenced after the cmpxchg below.
+	 */
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
+		rcu_read_lock();
+		waiter = rcu_dereference(work->irqwait.task);
+		if (waiter)
+			get_task_struct(waiter);
+		rcu_read_unlock();
+	}
+
 	/*
 	 * Clear the BUSY bit, if set, and return to the free state if no-one
 	 * else claimed it meanwhile.
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 
-	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
-	    !arch_irq_work_has_interrupt())
-		rcuwait_wake_up(&work->irqwait);
+	/*
+	 * @work must not be dereferenced past this point. Wake the
+	 * pinned waiter if one was sleeping; if none was sleeping,
+	 * either irq_work_sync() has not been called or it will
+	 * observe BUSY==0 on its own.
+	 */
+	if (waiter) {
+		wake_up_process(waiter);
+		put_task_struct(waiter);
+	}
 }
 
 static void irq_work_run_list(struct llist_head *list)
-- 
2.43.0

