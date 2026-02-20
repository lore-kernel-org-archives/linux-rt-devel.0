Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F92857CD
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576642; cv=none; b=mJuCtyr8Gt9mOhv4PGX6w3ODDTP1vPlsmNvhB5mcj2B0hFN3Xy0T9fEyTDV93d2aEVfmAYQQS/S0idhi8KhRu8ZxdwZLJeQIwoJMsgxgYBQhkyg3ZlD+MeW2XxBueUpmxIj//yaPPF8rRixpQu4HWBiZttT0qNwHo9zaOqDFkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576642; c=relaxed/simple;
	bh=42xBVBf7/zSvWegansEjJVb5Z73iPoTA1jQMjnntQyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzEmK8AV2DVMdE7NzD+c6DS0rNoTEpYGAjUsfdPwbs5acA/XgmidjuahnbFUX+hQ2rUJmQ6RwEMl4UzPOF0i2vzRHPClzdUGYyUnRFMmtbbnUBaO5jRDIKxme0BrI4C524dlNG0fXHgqhTOBkcKGWUzRD7GwZUVVF7t3D0nb1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=Ishf+Ozy; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="Ishf+Ozy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576639;
	bh=42xBVBf7/zSvWegansEjJVb5Z73iPoTA1jQMjnntQyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ishf+OzymbKsqH5w2UhvZKRq5KgnYsCVXGNsd9/M98lRxyqi5dDgIm2offnrlXThu
	 oYh1xGTR2T9IZlX++YVqYNi5HOgyHKZndjRNukcltpDVvwC7Yk/v9zUSPcCFPmZ2S5
	 /csfveeubgHIg6S8thS5Pa0OzOUBKrgc57UOiQRzFIYYeKEGkg/ilgguIkngafq+10
	 fMthZgSXNG2RZKmCOHO5rkuMtFy2ZJyFvLQoD7zqvL74Om0MVH1AjN/Sy8hAx8fGUA
	 86URLVFgmQhAL+k7FecFJllB5whIcJgsSo3Apd8PoCQ3ofP03ZNxVQj+nhKVuJALyQ
	 kSEOd6yddFNZw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Uma Shankar <uma.shankar@intel.com>
Subject: [i915-rt v6 08/24] drm/i915: Use preempt_disable/enable_rt() where recommended
Date: Fri, 20 Feb 2026 09:37:06 +0100
Message-ID: <20260220083657.28815-34-dev@lankhorst.se>
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

From: Mike Galbraith <umgwanakikbuti@gmail.com>

Mario Kleiner suggest in commit
  ad3543ede630f ("drm/intel: Push get_scanout_position() timestamping into kms driver.")

a spots where preemption should be disabled on PREEMPT_RT. The
difference is that on PREEMPT_RT the intel_uncore::lock disables neither
preemption nor interrupts and so region remains preemptible.

The area covers only register reads and writes. The part that worries me
is:
- __intel_get_crtc_scanline() the worst case is 100us if no match is
  found.

- intel_crtc_scanlines_since_frame_timestamp() not sure how long this
  may take in the worst case.

It was in the RT queue for a while and nobody complained.
Disable preemption on PREEPMPT_RT during timestamping.

[bigeasy: patch description.]

Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 43 ++++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index 3eb6418723a84..8263cefaa0fb6 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -316,6 +316,20 @@ static void intel_vblank_section_exit(struct intel_display *display)
 	struct intel_uncore *uncore = to_intel_uncore(display->drm);
 	spin_unlock(&uncore->lock);
 }
+
+static void intel_vblank_section_enter_irqf(struct intel_display *display, unsigned long *flags)
+	__acquires(i915->uncore.lock)
+{
+	struct intel_uncore *uncore = to_intel_uncore(display->drm);
+	spin_lock_irqsave(&uncore->lock, *flags);
+}
+
+static void intel_vblank_section_exit_irqf(struct intel_display *display, unsigned long flags)
+	__releases(i915->uncore.lock)
+{
+	struct intel_uncore *uncore = to_intel_uncore(display->drm);
+	spin_unlock_irqrestore(&uncore->lock, flags);
+}
 #else
 static void intel_vblank_section_enter(struct intel_display *display)
 {
@@ -324,6 +338,17 @@ static void intel_vblank_section_enter(struct intel_display *display)
 static void intel_vblank_section_exit(struct intel_display *display)
 {
 }
+
+static void intel_vblank_section_enter_irqf(struct intel_display *display, unsigned long *flags)
+{
+	*flags = 0;
+}
+
+static void intel_vblank_section_exit_irqf(struct intel_display *display, unsigned long flags)
+{
+	if (flags)
+		return;
+}
 #endif
 
 static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
@@ -360,10 +385,10 @@ static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
 	 * timing critical raw register reads, potentially with
 	 * preemption disabled, so the following code must not block.
 	 */
-	local_irq_save(irqflags);
-	intel_vblank_section_enter(display);
+	intel_vblank_section_enter_irqf(display, &irqflags);
 
-	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -427,10 +452,10 @@ static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
 	if (etime)
 		*etime = ktime_get();
 
-	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 
-	intel_vblank_section_exit(display);
-	local_irq_restore(irqflags);
+	intel_vblank_section_exit_irqf(display, irqflags);
 
 	/*
 	 * While in vblank, position will be negative
@@ -468,13 +493,11 @@ int intel_get_crtc_scanline(struct intel_crtc *crtc)
 	unsigned long irqflags;
 	int position;
 
-	local_irq_save(irqflags);
-	intel_vblank_section_enter(display);
+	intel_vblank_section_enter_irqf(display, &irqflags);
 
 	position = __intel_get_crtc_scanline(crtc);
 
-	intel_vblank_section_exit(display);
-	local_irq_restore(irqflags);
+	intel_vblank_section_exit_irqf(display, irqflags);
 
 	return position;
 }
-- 
2.51.0

