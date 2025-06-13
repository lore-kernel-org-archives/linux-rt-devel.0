Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E71E32D7
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Jun 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827128; cv=none; b=H2g0EoX+0juFiY1SUhMMYZqcW5xVGo7o3TwlsnadWrw5P0aAjt2uOe4XVSGNUndYH+/kIj3+xQBZaxWfqDuixbQtLlkIpkZgzZbft6UBrTuw408xw77BnnKNjlaa0ESH/VcCbe9xUw0TXEf3IuQVBnmjMq0LCjSE+HJLqJ+Unrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827128; c=relaxed/simple;
	bh=5htOi7Xq7BJFop/zGyQ8bAo3uW48aC6mu64egcsnLl8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X3phEzbO11fIl+LtQ7vqRWXZOz4+UURgq5BBRCs0WWljBJ5lH8hrfHPPS9jvOIlDS5OqSV+0NVzDX1a13RM5o0QVoxD9B9HezfPu3KbK9sfkCBCkj1otSyPJFuBd3sv0UoVPzCGjqXMb9xSa19DZOsYJ6N+UYPGeH7rADMx3JM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiKUzjJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiKUzjJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749827125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=eydungCzbjJFbEm6WAZhTNuaULfp1EVCeqjKqKlnSWY=;
	b=XiKUzjJdhJyRiHsaISh/latfGA2pfZzbjFleM9sld5tFFF0qw7y77I/kCWHVdblvUBTueB
	Hp/pdBWGd4xrYagreXV6GRZLe/HUdtEc9h6cvXWTzxWndBKwR32UoqyBl3MDaAqZU++Uyx
	xYHT8WwdLkp3R/LIO9nCggT7FwhQuW8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-weIA_g6MMquHGSonfW0XDg-1; Fri,
 13 Jun 2025 11:05:22 -0400
X-MC-Unique: weIA_g6MMquHGSonfW0XDg-1
X-Mimecast-MFC-AGG-ID: weIA_g6MMquHGSonfW0XDg_1749827119
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A73AD1800295;
	Fri, 13 Jun 2025 15:05:18 +0000 (UTC)
Received: from localhost (unknown [10.22.65.24])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 918ED195E340;
	Fri, 13 Jun 2025 15:05:16 +0000 (UTC)
Date: Fri, 13 Jun 2025 12:05:14 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	DietmarEggemann@uudg.org, dietmar.eggemann@arm.com,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [RESEND PATCH v4] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <aEw-KjUjjP2gYH6z@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
from rt_mutex_adjust_prio_chain() could happen in preemptible context and
with a mutex enqueued. That could lead to this sequence:

        rt_mutex_adjust_prio_chain()
          put_task_struct()
            __put_task_struct()
              sched_ext_free()
                spin_lock_irqsave()
                  rtlock_lock() --->  TRIGGERS
                                      lockdep_assert(!current->pi_blocked_on);

Fix that by unconditionally resorting to the deferred call to
__put_task_struct() if PREEMPT_RT is enabled.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---

Resent as a gentle reminder, because this issue results in scary backtraces,
not obvious to debug and pinpoint root cause.

v2: (Rostedt) remove the #ifdef from put_task_struct() and create
    tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
v4: Fix the implementation of what was requested on v3.

 include/linux/sched/task.h |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb04..51678a541477a 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -134,11 +134,8 @@ static inline void put_task_struct(struct task_struct *t)
 	if (!refcount_dec_and_test(&t->usage))
 		return;
 
-	/*
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Under RT, we can only call it in preemptible context.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	/* In !RT, it is always safe to call __put_task_struct(). */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
 
 		lock_map_acquire_try(&put_task_map);
@@ -148,11 +145,13 @@ static inline void put_task_struct(struct task_struct *t)
 	}
 
 	/*
-	 * under PREEMPT_RT, we can't call put_task_struct
+	 * Under PREEMPT_RT, we can't call __put_task_struct
 	 * in atomic context because it will indirectly
-	 * acquire sleeping locks.
+	 * acquire sleeping locks. The same is true if the
+	 * current process has a mutex enqueued (blocked on
+	 * a PI chain).
 	 *
-	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * call_rcu() will schedule __put_task_struct_rcu_cb()
 	 * to be called in process context.
 	 *
 	 * __put_task_struct() is called when
@@ -165,7 +164,7 @@ static inline void put_task_struct(struct task_struct *t)
 	 *
 	 * delayed_free_task() also uses ->rcu, but it is only called
 	 * when it fails to fork a process. Therefore, there is no
-	 * way it can conflict with put_task_struct().
+	 * way it can conflict with __put_task_struct().
 	 */
 	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }

----- End forwarded message -----

