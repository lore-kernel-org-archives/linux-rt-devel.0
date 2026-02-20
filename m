Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C2238C29
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576988; cv=none; b=RmXMH0/IwLDQUkVLHjmjm0dWNVQKRYbKZ36BwWIqxlPJUO3Ult9m9Rn+28Y1XEJvEHykT8TEXJCrUy9F88N4+aQwB5NoBt9ZBgxKXkb4sOSy1N62kHmpVeZUl7WG+QCyZ7rqDXeymnrh6mdaIGGTKTwxClsBL0k4MxhuT8DulQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576988; c=relaxed/simple;
	bh=Pr02vlxwRsiizKg8kzf2j4MUH4jROzjEfn4Qba2lZTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ru3CIy/8kcMwzcVVkq/ITLDze0YBmZLhM1KN4bCjeE/LJWqI5z7XV6iF7g1j0Og3SmF62eBPB/coCdt6TyMnYhq+ZzRiMQvpo5elAKJRy/fO/xYeboQai9lmqIvdj3kNGxJ6m5O/Tnv3dT1mp/c0nCOTjBuoqaaIyykXFXaWAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=lC8IysW3; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="lC8IysW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576632;
	bh=Pr02vlxwRsiizKg8kzf2j4MUH4jROzjEfn4Qba2lZTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lC8IysW3ql49x62SjytARusiUasK9Uy52FxhHNSfnNjOl/Enn7DkfpKkjjsISTlYA
	 eDGrElIZMtmzHZAvPpCR/5BkbEqKvlDSN5GuzlnxYKSKhZQ5AgnutMfeugIUPxE9rS
	 8CjP5DNkfkdwlZJQHy6x4T3QVNoCeNJgkZqOxbIVjD21BecY5IkKdF1uPCQDKvMA64
	 xj6OVk250nCn/HPg2MSZIgYqNbDSJh4erYUAbFg31h9oncOxDz5Y40UsGTBBSXGsyn
	 5e0GfUnZtJ+WqTpt0jdalnJEMr282/JoSqKlZtTU0X6+XUTdqtPmbqrMGJ53YlJP7M
	 kv3/VwKc87ogw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 04/24] drm/intel/display: Convert vblank event handling to 2-stage arming
Date: Fri, 20 Feb 2026 09:37:02 +0100
Message-ID: <20260220083657.28815-30-dev@lankhorst.se>
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

This is converts the vblank functions to be called with interrupts
disabled, even on PREEMPT_RT kernels.

Because the PREEMPT_RT kernel converts all spinlocks to rt-mutexes,
the normal vblank functions cannot be used inside the critical section.

Instead, prepare the vblank at the start, and then enable the vblank
work after the hardware programming is completed.

This allows us to keep programming the hardware with interrupts
disabled, and still schedule completion on PREEMPT_RT on next vblank.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_crtc.c | 84 ++++++++++++-----------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 663011af37e95..36a9685958bad 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -480,6 +480,10 @@ static void intel_crtc_vblank_work_init(struct intel_crtc_state *crtc_state)
 
 	drm_vblank_work_init(&crtc_state->vblank_work, &crtc->base,
 			     intel_crtc_vblank_work);
+
+	drm_vblank_work_schedule_disabled(&crtc_state->vblank_work,
+					  drm_crtc_accurate_vblank_count(&crtc->base) + 1);
+
 	/*
 	 * Interrupt latency is critical for getting the vblank
 	 * work executed as early as possible during the vblank.
@@ -525,6 +529,21 @@ int intel_scanlines_to_usecs(const struct drm_display_mode *adjusted_mode,
 				adjusted_mode->crtc_clock);
 }
 
+static void intel_crtc_arm_vblank_event(struct intel_crtc_state *crtc_state)
+{
+	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
+	unsigned long irqflags;
+
+	if (!crtc_state->uapi.event)
+		return;
+
+	drm_WARN_ON(crtc->base.dev, drm_crtc_vblank_get(&crtc->base) != 0);
+
+	spin_lock_irqsave(&crtc->base.dev->event_lock, irqflags);
+	drm_crtc_prepare_arm_vblank_event(&crtc->base, crtc_state->uapi.event);
+	spin_unlock_irqrestore(&crtc->base.dev->event_lock, irqflags);
+}
+
 /**
  * intel_pipe_update_start() - start update of a set of display registers
  * @state: the atomic state
@@ -561,6 +580,8 @@ void intel_pipe_update_start(struct intel_atomic_state *state,
 
 	if (intel_crtc_needs_vblank_work(new_crtc_state))
 		intel_crtc_vblank_work_init(new_crtc_state);
+	else
+		intel_crtc_arm_vblank_event(new_crtc_state);
 
 	if (state->base.legacy_cursor_update) {
 		struct intel_plane *plane;
@@ -638,23 +659,6 @@ static void dbg_vblank_evade(struct intel_crtc *crtc, ktime_t end)
 static void dbg_vblank_evade(struct intel_crtc *crtc, ktime_t end) {}
 #endif
 
-static void intel_crtc_arm_vblank_event(struct intel_crtc_state *crtc_state)
-{
-	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
-	unsigned long irqflags;
-
-	if (!crtc_state->uapi.event)
-		return;
-
-	drm_WARN_ON(crtc->base.dev, drm_crtc_vblank_get(&crtc->base) != 0);
-
-	spin_lock_irqsave(&crtc->base.dev->event_lock, irqflags);
-	drm_crtc_arm_vblank_event(&crtc->base, crtc_state->uapi.event);
-	spin_unlock_irqrestore(&crtc->base.dev->event_lock, irqflags);
-
-	crtc_state->uapi.event = NULL;
-}
-
 void intel_crtc_prepare_vblank_event(struct intel_crtc_state *crtc_state,
 				     struct drm_pending_vblank_event **event)
 {
@@ -708,29 +712,10 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
 	 * event outside of the critical section - the spinlock might spin for a
 	 * while ... */
 	if (intel_crtc_needs_vblank_work(new_crtc_state)) {
-		drm_vblank_work_schedule(&new_crtc_state->vblank_work,
-					 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
-					 false);
-	} else {
-		intel_crtc_arm_vblank_event(new_crtc_state);
-	}
-
-	if (state->base.legacy_cursor_update) {
-		struct intel_plane *plane;
-		struct intel_plane_state *old_plane_state;
-		int i;
-
-		for_each_old_intel_plane_in_state(state, plane, old_plane_state, i) {
-			if (old_plane_state->hw.crtc == &crtc->base &&
-			    old_plane_state->unpin_work.vblank) {
-				drm_vblank_work_schedule(&old_plane_state->unpin_work,
-							 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
-							 false);
-
-				/* Remove plane from atomic state, cleanup/free is done from vblank worker. */
-				memset(&state->base.planes[i], 0, sizeof(state->base.planes[i]));
-			}
-		}
+		drm_vblank_work_enable(&new_crtc_state->vblank_work);
+	} else if (new_crtc_state->uapi.event) {
+		drm_crtc_arm_prepared_vblank_event(new_crtc_state->uapi.event);
+		new_crtc_state->uapi.event = NULL;
 	}
 
 	/*
@@ -754,6 +739,25 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
 
 	local_irq_enable();
 
+	/* Run after local_irq_enable(), not timing sensitive */
+	if (state->base.legacy_cursor_update) {
+		struct intel_plane *plane;
+		struct intel_plane_state *old_plane_state;
+		int i;
+
+		for_each_old_intel_plane_in_state(state, plane, old_plane_state, i) {
+			if (old_plane_state->hw.crtc == &crtc->base &&
+			    old_plane_state->unpin_work.vblank) {
+				drm_vblank_work_schedule(&old_plane_state->unpin_work,
+							 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
+							 false);
+
+				/* Remove plane from atomic state, cleanup/free is done from vblank worker. */
+				memset(&state->base.planes[i], 0, sizeof(state->base.planes[i]));
+			}
+		}
+	}
+
 	if (intel_parent_vgpu_active(display))
 		goto out;
 
-- 
2.51.0

