Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D92857CD
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576640; cv=none; b=Re0jnbrZUJ5/SOBF1MaWyCC2X/5fhYpgjQcXoU/7cpz45X7WkL9LvMOdP+llMCegVOhXsIXGGOufe5heuQwZS2GI5PATj6yuBiNJ5YDKzdwFuSsX+Xk57hk+mIdcZt7tUKxXfnibaFtvY1sfFd26vSNqZrSeqwV7oQOj+QmPfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576640; c=relaxed/simple;
	bh=Mi72tZLkVY+OWZNlHhJHSloPqeEUuXErW5xRvyEChLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpBEYkZw2qw39hDE8O0VvSV91kyG4aLUf0qf9v3dC1hfO4f546uzPbU4ieOGN6TbN3jrClcdkdjBbOJBlI208Qbp/MDez6Eba/u0zq8a0Q3sVSQvS1jRnoHPC1amYHgbJ5UUsxtlhkPXd4IKlpUe7T/ZNcp93IZeVtdziWprcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=MCq40GcH; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="MCq40GcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576634;
	bh=Mi72tZLkVY+OWZNlHhJHSloPqeEUuXErW5xRvyEChLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCq40GcHb1nco+UWv9SA7ZJLRETUFt0frwlbrC6++7meCdcOmxkj40GP+j7SKZUGZ
	 mNhFhAzXEL5DLfF17aWgSWvLG7Y6zrtOJVRVMInYyCw6zN0Eq9uHbJV+IofL5RlwDC
	 sbpNxxc46DPgtj+IfmEcfUP1OcLQrWatFJBzBgyR4GSB9OsYHoQlP8uUDUQL/9LaP8
	 f9eXsLC0JT19mxqgtuo9UiK2tDTxoy01FEiwVO4BZKZ6yTYRsS/49pmH8JexnhEy/C
	 jNChQKVJb+O163HFeQjZbZiB7j1ulXOc56XkgSr/hfxkeCAKuBAPc0TSPnTNUilWbq
	 +UFajkdAKqYDA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>,
	Uma Shankar <uma.shankar@intel.com>
Subject: [i915-rt v6 05/24] drm/i915/display: Move vblank put until after critical section
Date: Fri, 20 Feb 2026 09:37:03 +0100
Message-ID: <20260220083657.28815-31-dev@lankhorst.se>
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

drm_crtc_vblank_put may take some locks, this should probably
not be the first thing we do after entering the time sensitive
part.

A better place is after programming is completed. Add a flag
to put the vblank after completion.

In the case of drm_vblank_work_schedule, we may not even need
to disable the vblank interrupt any more if it takes its own
reference.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cursor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 2c5d917fbd7e9..3e84a2078a0a7 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -816,6 +816,7 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 		to_intel_crtc_state(crtc->base.state);
 	struct intel_crtc_state *new_crtc_state;
 	struct intel_vblank_evade_ctx evade;
+	bool has_vblank = false;
 	int ret;
 
 	/*
@@ -913,6 +914,8 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 	intel_psr_lock(crtc_state);
 
 	if (!drm_WARN_ON(display->drm, drm_crtc_vblank_get(&crtc->base))) {
+		has_vblank = true;
+
 		/*
 		 * TODO: maybe check if we're still in PSR
 		 * and skip the vblank evasion entirely?
@@ -922,8 +925,6 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 		local_irq_disable();
 
 		intel_vblank_evade(&evade);
-
-		drm_crtc_vblank_put(&crtc->base);
 	} else {
 		local_irq_disable();
 	}
@@ -939,6 +940,9 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 
 	intel_psr_unlock(crtc_state);
 
+	if (has_vblank)
+		drm_crtc_vblank_put(&crtc->base);
+
 	if (old_plane_state->ggtt_vma != new_plane_state->ggtt_vma) {
 		drm_vblank_work_init(&old_plane_state->unpin_work, &crtc->base,
 				     intel_cursor_unpin_work);
-- 
2.51.0

