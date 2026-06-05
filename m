Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE637B02A
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680661; cv=none; b=Q5vzqXTHtItD7v0trDBaNi1s8Wcc3TXqebRn80tUcwOBZIUerbuKvCCXtpP2lBB82FI1HG2WVxyj9CWwL3L6AwHHMuL3HdxShoI5825NDXSJzptsdGNAN7Jt7RScpIpdPEnNszxwhPaESx8WS+7+w04rRpJuVTpkhx4OsECIn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680661; c=relaxed/simple;
	bh=0gNrJ3YIOU6NVAtWa683S47hAsOfCZvLyZLY69MbUtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=N3OW9GBnLYXaYCxYWGeHy/3iIIlnqFX+S0dqkDaLQgHFTNA/urZb4ZIJqO0yqXNv/xkqGqwUMLiOUBmGHy0a+TtSx3fifkoxCscLfbCSWYtOmbVNu7oD+unGedIkXCVgWJN+8hXJ+K4YKIdLRyIs/LKtYtsxhRebZKOsrMHvWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vtq3Rdx4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vtq3Rdx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780680656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7uLXM0OI1h+4SUJMpu2ba6P7n++mGzI5a6+vQaq2dDE=;
	b=Vtq3Rdx4EeG5LpAhQK2XkCwsAn2Yfa29+Inqf0LrxTn+JP5IC/CFAKbC9PzMEEfCNxRqDF
	CbsFyqeJEPwoCfRIMowV7eH8/36p9+2wlo6h30l8LIN51CduWgbP8KmWs1EYMAZKJ8xNoF
	sTd/2A5lWNPa+xjbpLggmw7kfThQW5k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-SauCPuLpN4ymXK7aYIV42w-1; Fri,
 05 Jun 2026 13:30:52 -0400
X-MC-Unique: SauCPuLpN4ymXK7aYIV42w-1
X-Mimecast-MFC-AGG-ID: SauCPuLpN4ymXK7aYIV42w_1780680651
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3720319560A1;
	Fri,  5 Jun 2026 17:30:51 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 649451800347;
	Fri,  5 Jun 2026 17:30:49 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5] debugobjects: Don't call fill_pool() in early boot hardirq context
Date: Fri,  5 Jun 2026 13:30:38 -0400
Message-ID: <20260605173038.495075-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: MrjBZQJDwOS80E6xueHRYnhHuEOVIDxQQ79654hEeAg_1780680651
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When booting a debug PREEMPT_RT kernel on an arm64 system with grace
processor, a "inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage"
lockdep warning message was reported to the console.

During early boot, interrupts are getting enabled before the scheduler
is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
can fire and attempt to fill the pool from within the hardirq. This can
lead to a deadlock the interrupt occurred while in the memory allocator.

Add a new can_fill_pool() helper and reorder the exception rule and
forbid this scenario by excluding allocations from hardirq.

Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
Co-developed-by: Waiman Long <longman@redhat.com>
Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b18a682fe3da..6fb00e08a4e2 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_blocked_on(void)
 #endif
 }
 
+static inline bool can_fill_pool(void)
+{
+	/*
+	 * On !RT enabled kernels there are no restrictions and spinlock_t and
+	 * raw_spinlock_t are the same types.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return true;
+
+	/*
+	 * On RT enabled kernels, the task must not be blocked on a lock as
+	 * that could corrupt the PI state when blocking on a lock in the
+	 * allocation path.
+	 */
+	if (debug_objects_is_pi_blocked_on())
+		return false;
+
+	/*
+	 * On RT enabled kernels the pool refill should happen in preemptible
+	 * context.
+	 */
+	if (preemptible())
+		return true;
+
+	/*
+	 * Though during system boot before scheduling is set up, preemption is
+	 * disabled and the pool can get exhausted. Before scheduling is active
+	 * a task cannot be blocked on a sleeping lock, but it might hold a lock
+	 * and if interrupted then hard interrupt context might run into a lock
+	 * inversion. So exclude hard interrupt context from allocations before
+	 * scheduling is active.
+	 */
+	return system_state < SYSTEM_SCHEDULING && !in_hardirq();
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -734,18 +769,11 @@ static void debug_objects_fill_pool(void)
 	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
-	 * on the fact that spinlock_t and raw_spinlock_t are basically the
-	 * same type and this lock-type inversion works just fine.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
-	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
+	if (can_fill_pool()) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-		 * the preemptible() condition above.
+		 * the preemptible() condition in can_fill_pool().
 		 */
 		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
-- 
2.54.0

