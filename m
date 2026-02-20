Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E343168E6
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576987; cv=none; b=e+ntJCHaYJL3KeQN5ajkq9R5D6SGtZN/7dbmXPgFH3zQRkHRAFdfzkRUNOD39phjs9hl83is3IQQsonUBk/XIhT+cz6/mMApo4WIhGBXvp4eNQnioYhjhPZwRXqvcrbFqmMmn6dHc1exTWmDk3u5fyfktNb7gchl9NXZfQl+l1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576987; c=relaxed/simple;
	bh=3DZgJsq9cXtJcxxoTli6qqSG9rAnN2F4n5NlIb7zR3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y56PU/OqEz5GL5KUwLh3Vuu3AwvXYE9m1sZ+yQgoMKqMJ6drtiHwuOwkTt60xje7nZtkOY0qgtY7MVSh39+xj25/jZd9czwaHCdy4wNs+vP9oCB88VAwDvGP1bZPU8mLv4A54hCtv/w6txyCSe4wKfHG5tNQhiANwR26jpThzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=Ev9nFH96; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="Ev9nFH96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576629;
	bh=3DZgJsq9cXtJcxxoTli6qqSG9rAnN2F4n5NlIb7zR3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ev9nFH96B0fcrZCQaMktJQZ93UahbVulRs+oZwk0wGheiSa40qhf9WA8eT6oLEa0A
	 T2oGwvKadV/9H8NjLGqpMf2nqGiIQXe94x/1/qK+nrsY1iCNkytRJ96knjIOy6uiMF
	 tS9j00EUx51o+ySYcLjgjAtHA2x3RZIplySH+XGq4zXYOtYGUNCokiIVG75cM/0PFf
	 fKhrTNTfcMMCNfRkVW6JdOkRQMXUZxhvfNmQFjwlnO3nljZt7wvMWbvXhpbcO6VeTO
	 bcW0/UwGCqcTUE9xha6yYjWCNIJuVM6/EIY9+j+cmBRFUKb4W0Pkrkt+Xq6Ovhc3vz
	 bYce+XaKjvGdg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 02/24] drm/vblank: Add a 2-stage version of drm_crtc_arm_vblank_event
Date: Fri, 20 Feb 2026 09:37:00 +0100
Message-ID: <20260220083657.28815-28-dev@lankhorst.se>
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

When trying to fix the hardware programming in intel/display, I had
to take all the vblank locks with local_irqs_disabled(). This
required converting the entire vblank code to raw spinlocks.

In the alternative approach, do all preparations in advance, and only
enable the vblank_event with interrupts disabled, this requires only
a simple write and prevents a complete re-architecture of the code.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/drm_vblank.c | 61 +++++++++++++++++++++++++++++++++++-
 include/drm/drm_vblank.h     | 14 ++++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 42fe11cc139b9..1a84a69e99810 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1118,12 +1118,68 @@ void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
 
 	assert_spin_locked(&dev->event_lock);
 
+	WARN_ON(e->postponed);
 	e->pipe = pipe;
 	e->sequence = drm_crtc_accurate_vblank_count(crtc) + 1;
 	list_add_tail(&e->base.link, &dev->vblank_event_list);
 }
 EXPORT_SYMBOL(drm_crtc_arm_vblank_event);
 
+/**
+ * drm_crtc_prepare_arm_vblank_event - arm vblank event *before* pageflip.
+ * @crtc: the source CRTC of the vblank event
+ * @e: the event to send
+ *
+ * See drm_crtc_arm_vblank_event(). This function is a 2-stage version of
+ * that call. This function is called *BEFORE* programming the hardware.
+ *
+ * After programming, call drm_crtc_arm_prepared_vblank_event() and the
+ * event will be scheduled on the next vblank.
+ *
+ * This is mainly useful for code that has to run on PREEMPT_RT kernels,
+ * with interrupts disabled, since all vblank spinlocks are converted to
+ * rtmutexes, and code running with irqs disabled cannot take any vblank lock.
+ *
+ * It also increases determinism for any hardware
+ * programming, since no vblank related locks are taking when arming.
+ */
+void drm_crtc_prepare_arm_vblank_event(struct drm_crtc *crtc,
+				       struct drm_pending_vblank_event *e)
+{
+	drm_crtc_arm_vblank_event(crtc, e);
+
+	/* Set the flag, so that the event is not fired yet */
+	e->postponed = true;
+}
+EXPORT_SYMBOL(drm_crtc_prepare_arm_vblank_event);
+
+/**
+ * drm_crtc_arm_prepared_vblank_event - arm prepared vblank event *after* pageflip.
+ * @crtc: the source CRTC of the vblank event
+ * @e: the event to send
+ *
+ * See drm_crtc_prepare_arm_vblank_event(). This function is a 2-stage version of
+ * that call. This function is called directly *AFTER* programming the hardware.
+ *
+ * Before this function is called, drm_crtc_prepare_arm_vblank_event() should be
+ * called instead.
+ *
+ * This is mainly useful for code that has to run on PREEMPT_RT kernels,
+ * with interrupts disabled, since all vblank spinlocks are converted to
+ * rtmutexes, and code running with irqs disabled cannot take any vblank lock.
+ *
+ * It also increases determinism for any hardware
+ * programming, since no vblank related locks are taking when arming.
+ */
+void drm_crtc_arm_prepared_vblank_event(struct drm_pending_vblank_event *e)
+{
+	WARN_ON(!e->postponed);
+
+	/* remove the flag to be processed as a normal event */
+	WRITE_ONCE(e->postponed, false);
+}
+EXPORT_SYMBOL(drm_crtc_arm_prepared_vblank_event);
+
 /**
  * drm_crtc_send_vblank_event - helper to send vblank event after pageflip
  * @crtc: the source CRTC of the vblank event
@@ -1381,6 +1437,8 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 	list_for_each_entry_safe(e, t, &dev->vblank_event_list, base.link) {
 		if (e->pipe != pipe)
 			continue;
+
+		WARN_ON(e->postponed);
 		drm_dbg_core(dev, "Sending premature vblank event on disable: "
 			     "wanted %llu, current %llu\n",
 			     e->sequence, seq);
@@ -1886,7 +1944,8 @@ static void drm_handle_vblank_events(struct drm_device *dev, unsigned int pipe)
 	seq = drm_vblank_count_and_time(dev, pipe, &now);
 
 	list_for_each_entry_safe(e, t, &dev->vblank_event_list, base.link) {
-		if (e->pipe != pipe)
+		/* Matches WRITE_ONCE in drm_crtc_arm_prepared_vblank_event() */
+		if (e->pipe != pipe || READ_ONCE(e->postponed))
 			continue;
 		if (!drm_vblank_passed(seq, e->sequence))
 			continue;
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f5b1b..956d5621eb7f9 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -53,6 +53,13 @@ struct drm_pending_vblank_event {
 	 * @sequence: frame event should be triggered at
 	 */
 	u64 sequence;
+
+	/**
+	 * @postponed: whether drm_crtc_prepare_arm_vblank_event() is called,
+	 * and drm_crtc_arm_prepared_vblank_event has yet to be called to arm.
+	 */
+	bool postponed;
+
 	/**
 	 * @event: Actual event which will be sent to userspace.
 	 */
@@ -294,7 +301,12 @@ int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime);
 void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 			       struct drm_pending_vblank_event *e);
 void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
-			      struct drm_pending_vblank_event *e);
+			       struct drm_pending_vblank_event *e);
+
+void drm_crtc_prepare_arm_vblank_event(struct drm_crtc *crtc,
+				       struct drm_pending_vblank_event *e);
+void drm_crtc_arm_prepared_vblank_event(struct drm_pending_vblank_event *e);
+
 void drm_vblank_set_event(struct drm_pending_vblank_event *e,
 			  u64 *seq,
 			  ktime_t *now);
-- 
2.51.0

