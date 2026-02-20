Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890026FA6F
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576643; cv=none; b=uGATJWcsg/tH++8Dj2eQmYtF+qzdU4lwOd9HyVUeMPo0LElxACqeUADrYTJXBIYiFJ3wCJiIdiYM5+hjEZXVJg6XhEqm9qTRCklQvbkfb+EMu/88rKBMHs7LIvlTG0egLjFCkLCHEXb2IjWViJK6PqOwUxN4QR3Lms/LBGL4uK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576643; c=relaxed/simple;
	bh=/T86rcA01cGgM35z2+asiVe5bkFH96NTyprH2lsWm8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGPziEakFMyIOaqEHIKeTN/ssgsrKGAlIaxJ+2K6alfr29XGeIcy4IoDpb+uJfhnwCH0L6W314OUC4oztbX0pNgPpiCEvSWsJqHxbRmG9LUAnDrDcItgHeC02d65P+MNdFQnn4dC4B1AywGXUQS717DTiMdHsqpaHpm4GH2UJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=g2A7FA26; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="g2A7FA26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576641;
	bh=/T86rcA01cGgM35z2+asiVe5bkFH96NTyprH2lsWm8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2A7FA26ZnykXFsTxCQcbYCPUReus9yzXK0Zsq9aHQMst1ihllQ3/OdfIgQAGq6+r
	 TSp4fET14KsM0yqLaIDUSbfki/PuhMCurFWpgVyb9yus8B8fcRhnQJywGbwh7m4keB
	 r6/b8SzGrg0a2LwA3As6GzbAinoT/ASwxK5S0R8NVZfIjBqhhqprvFF/gWZ8pBRjAD
	 7QmXK/Hj/7qc0/HoQbKvROYiC2kUzN3Kr7RFAKkqsztTtbg8KWha0HZDYzBUT5PW80
	 poPp38k3NGWMywOnGdM5xBDY0kU4Um4BDaAH/mzbBY01XwxwCFckKCm+mob4kLBlLa
	 YNu3TvZYxKB1w==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 09/24] drm/i915/display: Make get_vblank_counter use intel_de_read_fw()
Date: Fri, 20 Feb 2026 09:37:07 +0100
Message-ID: <20260220083657.28815-35-dev@lankhorst.se>
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

Fixes the following lockdep splat on PREEMPT_RT:
<3> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
<3> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1373, name: xe_module_load
<3> preempt_count: 1, expected: 0
<3> RCU nest depth: 0, expected: 0
<4> 11 locks held by xe_module_load/1373:
<4>  #0: ffff888107b691a0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x104/0x220
<4>  #1: ffff88813cd30280 (&dev->clientlist_mutex){+.+.}-{3:3}, at: drm_client_register+0x32/0xe0
<4>  #2: ffffffff837f88f8 (registration_lock){+.+.}-{3:3}, at: register_framebuffer+0x1b/0x50
<4>  #3: ffffffff835985e0 (console_lock){+.+.}-{0:0}, at: fbcon_fb_registered+0x6f/0x90
<4>  #4: ffff88812589e6a0 (&helper->lock){+.+.}-{3:3}, at: __drm_fb_helper_restore_fbdev_mode_unlocked+0x7b/0x110
<4>  #5: ffff88813cd30158 (&dev->master_mutex){+.+.}-{3:3}, at: drm_master_internal_acquire+0x20/0x50
<4>  #6: ffff88812589e488 (&client->modeset_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_locked+0x2a/0x1b0
<4>  #7: ffffc9000031eef0 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_client_modeset_commit_atomic+0x4c/0x2b0
<4>  #8: ffffc9000031ef18 (crtc_ww_class_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_atomic+0x4c/0x2b0
<4>  #9: ffff888114f7b8b8 (&intel_dp->psr.lock){+.+.}-{3:3}, at: intel_psr_lock+0xc5/0xf0 [xe]
<4>  #10: ffff88812a0cbbc0 (&wl->lock){+.+.}-{2:2}, at: intel_dmc_wl_get+0x3c/0x140 [xe]

This splat will happen otherwise on all tracepoints too, for similar reasons.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index 8263cefaa0fb6..e204c260b9aef 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -132,7 +132,7 @@ u32 g4x_get_vblank_counter(struct drm_crtc *crtc)
 	if (!vblank->max_vblank_count)
 		return 0;
 
-	return intel_de_read(display, PIPE_FRMCOUNT_G4X(display, pipe));
+	return intel_de_read_fw(display, PIPE_FRMCOUNT_G4X(display, pipe));
 }
 
 static u32 intel_crtc_scanlines_since_frame_timestamp(struct intel_crtc *crtc)
-- 
2.51.0

