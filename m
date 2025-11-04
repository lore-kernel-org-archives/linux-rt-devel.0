Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAB1E572F
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Nov 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245918; cv=none; b=C32XYKLlZkDqcnu4SH1hgkcmLfwMnjQmf/ZhnEUFRcpr/ekTR9a3luTQ7oPFkJty5eJXzwR9kaA+jm/enCLmVntcufgas0ubLkX0Zu00iF6FnCYt/FQKYOD4f/+dc5cuNjcJEzmS+VfNKMUqz8HOPt1zQQ79lu99hPEq7qE4JpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245918; c=relaxed/simple;
	bh=ayTfIiXKSdAI7v9LVwmS0rL6yyY/P57eSpD8YoJWyyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHBs5b0OWRTNb9uEIYZO5ZMich/I3Vp66PQsibjq8DUhePDbJLMSRiPfDFZzJ9VLQw3tenER/E8ekIz4PPIINPHH146FE+9FuDE1EafRDO6R4TNiGxtlCuFrjxaa9cxJ5b0wUbBDtATkqDEhPR/PWV3IgINgLaf0TBWGWpPH0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=iWHQmrYd; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="iWHQmrYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1762245406;
	bh=ayTfIiXKSdAI7v9LVwmS0rL6yyY/P57eSpD8YoJWyyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWHQmrYd5b4fxa8XPV73ZI7zoLZtgNYKAX5YmHMdWvXqEi5ViWMs3PHZt72a0xDJe
	 le5B1hkiL8fsZebyJusmOkd7cIYNBFkcsLOnoE5NLylv2o65EdobMBAR1sucvAy+rA
	 T6HItkxA0qhHwIiI1d4VLocFj/Vaq4r6PktFE27Y4Ryq4rRkQnTk7x86RlgPBGgYQf
	 rEwAOlfHCwdOdZrNBXrD4Sxic5HWX2rjIbdLx/uXz+3JoBKSxV8bMA+C4K2iB37B0Z
	 iTl5384Zn4cvCASJgc8WbLp5Xbx5z3X8w50fgtV9wQxq+xXBsO5J8o6e2W2ezMOL5C
	 RlLNi50vpP9dg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	Maarten Lankhorst <dev@lankhorst.se>,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 3/7] drm/i915/display: Move vblank put until after critical section
Date: Tue,  4 Nov 2025 09:36:27 +0100
Message-ID: <20251104083634.670753-4-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104083634.670753-1-dev@lankhorst.se>
References: <20251104083634.670753-1-dev@lankhorst.se>
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
---
 drivers/gpu/drm/i915/display/intel_cursor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 7aa14348aa6d4..6b3bc8d94e51a 100644
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

