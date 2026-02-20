Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAE318EC6
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576987; cv=none; b=WCm78NbuZk/s66VjMo3It45wwXI6mssNRzd6V7yfq9Wp+FyH44pXPYzNsdjl8N+C+91E2WmUkBueco12/2JTZkPXNwQB9WDgNsJHv8GfhrZFNf0pONNxOLarbXeJYEerwpjYGGoGLQtrnbFMKXtO+a2RRkAg1b2wM8k+KfJKCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576987; c=relaxed/simple;
	bh=+0TTsFCqXwNcD9FpX0y560T4S4yey1kF0/TOh8QGn6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4XaB91dZFTnDeF2aZ9jhk9q4rHutOR4w7lklA5/MkSyfQJNYRDl0VE5VW8Txr5HFIYB9MKIKlKgDaXIo5mQn/mzv+wEbnU+6ggY4sDZy6dGPsEpldUhPK/cbKETKMdoBUoGpkoXue/r9EY57TLvB9xKA58oMlRjpJUkM8ITg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=i7cHkKna; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="i7cHkKna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576628;
	bh=+0TTsFCqXwNcD9FpX0y560T4S4yey1kF0/TOh8QGn6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7cHkKnaDgAxlyJ+xAAZT5mlUBi3d8a800+0USMeZYSzFTh6BHJYYQQlLz+zoixWl
	 ulywtapOzBCfEqp4Mtj/hon9Yudpwjfx9pzaBbNXSJkuYVhseKTh4YHpfS+IzmKEUP
	 7wx/0UqR/y3ZyS849zGcM1J2SOj5b7bWcx8BmLhEF+jBduMd3fSn6LHFo2gJ+wXrVn
	 HRdcjglZpnnqBLPuW6ZgRLHQIH+ejz/pcmUwwpwF0j2HpHUxrZeMCFFv5KN1DjjY2E
	 nbP0IX2e84LRZgQfvgd+i/2gLF4MiKxtl5z+dGxQFxxMw2cR7yAysbnGsWzXUvO2Yt
	 e+ph8NCSkrsjg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 01/24] drm/vblank_work: Add methods to schedule vblank_work in 2 stages
Date: Fri, 20 Feb 2026 09:36:59 +0100
Message-ID: <20260220083657.28815-27-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220083657.28815-26-dev@lankhorst.se>
References: <20260220083657.28815-26-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of vblank evasion in intel/display, it's necessary to
perform some work in advance, so the critical section will always run in
constant time on PREEMPT_RT.

By preparing all the work in advance, the part that needs to finish in
constant time only has to write a single variable instead. This allows
PREEMPT_RT to keep the interrupts disabled at the most critical part,
without completely reworking all locks to be raw spinlocks.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/drm_vblank_work.c | 106 ++++++++++++++++++++++--------
 include/drm/drm_vblank_work.h     |  12 ++++
 2 files changed, 92 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank_work.c b/drivers/gpu/drm/drm_vblank_work.c
index 70f0199251ea0..308093a0bbbf0 100644
--- a/drivers/gpu/drm/drm_vblank_work.c
+++ b/drivers/gpu/drm/drm_vblank_work.c
@@ -54,7 +54,8 @@ void drm_handle_vblank_works(struct drm_vblank_crtc *vblank)
 	assert_spin_locked(&vblank->dev->event_lock);
 
 	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
-		if (!drm_vblank_passed(count, work->count))
+		/* READ_ONCE pairs with WRITE_ONCE in drm_vblank_work_enable() */
+		if (!READ_ONCE(work->armed) || !drm_vblank_passed(count, work->count))
 			continue;
 
 		list_del_init(&work->node);
@@ -86,30 +87,8 @@ void drm_vblank_cancel_pending_works(struct drm_vblank_crtc *vblank)
 	wake_up_all(&vblank->work_wait_queue);
 }
 
-/**
- * drm_vblank_work_schedule - schedule a vblank work
- * @work: vblank work to schedule
- * @count: target vblank count
- * @nextonmiss: defer until the next vblank if target vblank was missed
- *
- * Schedule @work for execution once the crtc vblank count reaches @count.
- *
- * If the crtc vblank count has already reached @count and @nextonmiss is
- * %false the work starts to execute immediately.
- *
- * If the crtc vblank count has already reached @count and @nextonmiss is
- * %true the work is deferred until the next vblank (as if @count has been
- * specified as crtc vblank count + 1).
- *
- * If @work is already scheduled, this function will reschedule said work
- * using the new @count. This can be used for self-rearming work items.
- *
- * Returns:
- * %1 if @work was successfully (re)scheduled, %0 if it was either already
- * scheduled or cancelled, or a negative error code on failure.
- */
-int drm_vblank_work_schedule(struct drm_vblank_work *work,
-			     u64 count, bool nextonmiss)
+static int __drm_vblank_work_schedule(struct drm_vblank_work *work,
+				      u64 count, bool nextonmiss, bool armed)
 {
 	struct drm_vblank_crtc *vblank = work->vblank;
 	struct drm_device *dev = vblank->dev;
@@ -139,6 +118,7 @@ int drm_vblank_work_schedule(struct drm_vblank_work *work,
 		rescheduling = true;
 	}
 
+	work->armed = armed;
 	work->count = count;
 	cur_vbl = drm_vblank_count(dev, vblank->pipe);
 	passed = drm_vblank_passed(cur_vbl, count);
@@ -147,7 +127,7 @@ int drm_vblank_work_schedule(struct drm_vblank_work *work,
 			     "crtc %d vblank %llu already passed (current %llu)\n",
 			     vblank->pipe, count, cur_vbl);
 
-	if (!nextonmiss && passed) {
+	if (!nextonmiss && passed && armed) {
 		drm_vblank_put(dev, vblank->pipe);
 		ret = kthread_queue_work(vblank->worker, &work->base);
 
@@ -167,8 +147,82 @@ int drm_vblank_work_schedule(struct drm_vblank_work *work,
 		wake_up_all(&vblank->work_wait_queue);
 	return ret;
 }
+
+/**
+ * drm_vblank_work_schedule - schedule a vblank work
+ * @work: vblank work to schedule
+ * @count: target vblank count
+ * @nextonmiss: defer until the next vblank if target vblank was missed
+ *
+ * Schedule @work for execution once the crtc vblank count reaches @count.
+ *
+ * If the crtc vblank count has already reached @count and @nextonmiss is
+ * %false the work starts to execute immediately.
+ *
+ * If the crtc vblank count has already reached @count and @nextonmiss is
+ * %true the work is deferred until the next vblank (as if @count has been
+ * specified as crtc vblank count + 1).
+ *
+ * If @work is already scheduled, this function will reschedule said work
+ * using the new @count. This can be used for self-rearming work items.
+ *
+ * Returns:
+ * %1 if @work was successfully (re)scheduled, %0 if it was either already
+ * scheduled or cancelled, or a negative error code on failure.
+ */
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss)
+{
+	return __drm_vblank_work_schedule(work, count, nextonmiss, true);
+}
 EXPORT_SYMBOL(drm_vblank_work_schedule);
 
+
+/**
+ * drm_vblank_work_schedule_disabled - schedule a vblank work, withoug enabling
+ * @work: vblank work to schedule
+ * @count: target vblank count
+ *
+ * Schedule @work for execution once the crtc vblank count reaches @count.
+ *
+ * The vblank work will not be scheduled until drm_vblank_work_enable() is called.
+ * If the crtc vblank count has already reached @count, the work will still
+ * not be scheduled until the first following vblank.
+ *
+ * If @work is already scheduled, this function will reschedule said work
+ * using the new @count. This can be used for self-rearming work items.
+ *
+ * Returns:
+ * %1 if @work was successfully (re)scheduled, %0 if it was either already
+ * scheduled or cancelled, or a negative error code on failure.
+ */
+int drm_vblank_work_schedule_disabled(struct drm_vblank_work *work, u64 count)
+{
+	return __drm_vblank_work_schedule(work, count, true, true);
+}
+EXPORT_SYMBOL(drm_vblank_work_schedule_disabled);
+
+/**
+ * drm_vblank_work_enable - enable vblank work
+ * @work: vblank work to enable
+ *
+ * This function is specifically only for when drm_vblank_work_schedule_disabled() is
+ * called. It allows for the work to be armed in any context, without any locks.
+ *
+ * The work will be signalled earliest at the @count argument, if it has been passed,
+ * it will signalled at the next vblank.
+ *
+ * This is particularly useful for PREEMPT_RT, where the spin_lock is converted
+ * into a sleeping rtmutex, and vblank evasion requires some work to be
+ * scheduled on completion with interrupts disabled.
+ */
+void drm_vblank_work_enable(struct drm_vblank_work *work)
+{
+	WARN_ON(work->armed);
+	WRITE_ONCE(work->armed, true);
+}
+EXPORT_SYMBOL(drm_vblank_work_enable);
+
 /**
  * drm_vblank_work_cancel_sync - cancel a vblank work and wait for it to
  * finish executing
diff --git a/include/drm/drm_vblank_work.h b/include/drm/drm_vblank_work.h
index e04d436b72973..e19351200da24 100644
--- a/include/drm/drm_vblank_work.h
+++ b/include/drm/drm_vblank_work.h
@@ -47,6 +47,14 @@ struct drm_vblank_work {
 	 */
 	int cancelling;
 
+	/**
+	 * @armed: If false, the work item has been added to the
+	 * drm_vblank_crtc.pending_work list, but will not yet be signalled.
+	 *
+	 * Call drm_vblank_work_enable() to fire on next vblank.
+	 */
+	bool armed;
+
 	/**
 	 * @node: The position of this work item in
 	 * &drm_vblank_crtc.pending_work.
@@ -64,6 +72,10 @@ struct drm_vblank_work {
 
 int drm_vblank_work_schedule(struct drm_vblank_work *work,
 			     u64 count, bool nextonmiss);
+
+int drm_vblank_work_schedule_disabled(struct drm_vblank_work *work, u64 count);
+void drm_vblank_work_enable(struct drm_vblank_work *work);
+
 void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc *crtc,
 			  void (*func)(struct kthread_work *work));
 bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
-- 
2.51.0

