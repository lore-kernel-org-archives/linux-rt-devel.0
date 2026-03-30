Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDD395D81
	for <linux-rt-devel@lists.linux.dev>; Mon, 30 Mar 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855973; cv=none; b=XV9f5H7GW7FQusLQYJLyOp4Yv/4aSnLfhBEpMzUxNPXYniodiEzmJMb7NxteS8ZsGsVxAonBt3vwteqgGqhQuCuUtpAwnSgTKrLSZNHTXlcR7/+SwM6jOzoFc5pJEldbPwZz2XeA3+2KDO53H0K5PZ5C4aMO9x9rZm32EKwxguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855973; c=relaxed/simple;
	bh=kMMKF+4b2ZsB5B0b7Rj/tCjkaXGnQ745SZFwRUOVu9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bb4bQeG1wVqAPHp6G8DIoPeJpH/wz5tjrcOeIDZjx6svFWoLPSlhQQEesZBwXFMJnTUVXQlKyE9wfWAG29egE7y4cmN8ZcqqYUiryHbxa48jOfoDO3s09wd5xFdhde7lpE+1IfoEJmcCygF8M3r5vTFusHQx8rjCShgsWT4kz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YUup4KGe; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YUup4KGe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774855969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q1dl26aM6gomYdZ7GI/XmWPR9T0Sw1op7U21QGHWm4A=;
	b=YUup4KGeQJzVuamXYItUPr+FmmqUCLJoTBCLK7oFywYWyKGzTVe0AURm/F2VKCf2yAZW9K
	dj4WyvjFJI5Sh3XLtfa3JXCpq3DSZVl28K5MbXfc5PvGVt8EEtHSKCz6wqemHWYDqoFNI5
	wIC1fCoIzcTaPp/+kARldSwJ6udT/Ao=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-rt-devel@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on PREEMPT_RT
Date: Mon, 30 Mar 2026 15:32:29 +0800
Message-ID: <20260330073234.303732-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On PREEMPT_RT, non-HARD irq_work runs in per-CPU kthreads via
run_irq_workd(), so irq_work_sync() uses rcuwait to wait for
BUSY==0.

After irq_work_single() clears BUSY via atomic_cmpxchg(), it still
dereferences @work for irq_work_is_hard() and rcuwait_wake_up().
An irq_work_sync() caller on another CPU that enters after BUSY is
cleared can observe BUSY==0 immediately, return, and free the work
before those accesses complete — causing a use-after-free.

Fix this by wrapping run_irq_workd() in guard(rcu)() so that the
entire irq_work_single() execution is within an RCU read-side
critical section. Then add synchronize_rcu() in irq_work_sync()
after rcuwait_wait_event() to ensure the caller waits for the RCU
grace period before returning, preventing premature frees.

Fixes: 810979682ccc ("irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/irq_work.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 73f7e1fd4ab4..bf411656c316 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -292,6 +292,12 @@ void irq_work_sync(struct irq_work *work)
 	    !arch_irq_work_has_interrupt()) {
 		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
 				   TASK_UNINTERRUPTIBLE);
+		/*
+		 * Ensure irq_work_single() does not access @work
+		 * after removing IRQ_WORK_BUSY. It is always
+		 * accessed within a RCU-read section.
+		 */
+		synchronize_rcu();
 		return;
 	}
 
@@ -302,6 +308,7 @@ EXPORT_SYMBOL_GPL(irq_work_sync);
 
 static void run_irq_workd(unsigned int cpu)
 {
+	guard(rcu)();
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 
-- 
2.43.0

