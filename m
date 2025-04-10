Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DB1DFE0A
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Apr 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287024; cv=none; b=CjckDTMyuhR5zAHp/3jbJA0KrfhDGFj2Wpx0TGRPIkvLoVFsw4lPHy+yirmAokIjExKoo9yGzG/z2PWlzo9U6t9BU49z/uAHVvPkKrMYxMbYvgtuPg+mQ/UvXX5wqeHuJ4wg5cZZRGE/i+X2mz8ZOAYwPfzrVzeYzorRvir9Qfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287024; c=relaxed/simple;
	bh=fEIIJmuvKZ1FbFgiAVM+GhhSXj66E4+4E1CoqfCCUuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ozQ6HqsSkpmUF8H2ZVP21QzfAp3XJ6/7jfgyp55M9hHrqTSmNZ+wlwMXMGT/DUFTC7CZyeOFxK0imDI9DUEpc4tt8JTVHt6yyFYS7IhNL9Y72Nw3m5aCtuYwaXKNJMMoT7tmAFnMhV7JJXprIR45rWBBV/jtd2ghm34z1BBdWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCUXQKn6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCUXQKn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744287021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=jfr0CKO41OvdQbzGujfxRHdpipw9MCfRZIBLhG07wC0=;
	b=YCUXQKn6c5f3hKQupO5IjKXS7HBh+QHV2pjcLDCxUGaV2GaD78kOIBXMUwX4xmsLew5/mH
	NZDWpA13NhqMHQL48I/nLKe/oTiUJt+oMBOElLvt4Ni8gdYZ4Q2m+KYn0L4HE0zEEYi354
	dcUTDEP+5ZuvqYZeWDpqC/oM/9D//3E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-TDS-UST-N3m_GoJC_mff0Q-1; Thu,
 10 Apr 2025 08:10:18 -0400
X-MC-Unique: TDS-UST-N3m_GoJC_mff0Q-1
X-Mimecast-MFC-AGG-ID: TDS-UST-N3m_GoJC_mff0Q_1744287015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40F0C1954B36;
	Thu, 10 Apr 2025 12:10:15 +0000 (UTC)
Received: from localhost (unknown [10.22.88.250])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D25FD18009BC;
	Thu, 10 Apr 2025 12:10:13 +0000 (UTC)
Date: Thu, 10 Apr 2025 09:10:12 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: lclaudio00@gmail.com
Subject: [PATCH v3] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_e0uh36Ezz6isYo@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
__put_task_struct().

v2: (Rostedt) remove the #ifdef from put_task_struct() and create
    tsk_is_pi_blocked_on() in sched.h to make the change cleaner.

v3: (Sebastian and PeterZ) always call the RCU deferred __put_task_struct().

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 include/linux/sched/task.h |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb04..49847efe5559e 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -134,22 +134,12 @@ static inline void put_task_struct(struct task_struct *t)
 		return;
 
 	/*
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Under RT, we can only call it in preemptible context.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
-		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
-
-		lock_map_acquire_try(&put_task_map);
-		__put_task_struct(t);
-		lock_map_release(&put_task_map);
-		return;
-	}
-
-	/*
-	 * under PREEMPT_RT, we can't call put_task_struct
+	 * In !RT, it is always safe to call __put_task_struct(),
+	 * but under PREEMPT_RT, we can't call put_task_struct
 	 * in atomic context because it will indirectly
-	 * acquire sleeping locks.
+	 * acquire sleeping locks. The same is true if the
+	 * current process has a mutex enqueued (blocked on
+	 * a PI chain).
 	 *
 	 * call_rcu() will schedule delayed_put_task_struct_rcu()
 	 * to be called in process context.
-- 
2.49.0

