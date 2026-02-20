Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D326FA6F
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576641; cv=none; b=rI/krbXoTOpI+smATRYZNeiFk3j6TMavH102+kJLEOt5zV9MdD64uEWO9B53YpGr7XjzMlAe8arhTo1i4CIoDCiFmYF+mFO4iVMRaVkwfk5aTTQG8XMvLazr/6MfhiYGNHQWKmoMF66YmkwqS68Xwf2s5b2mLfMnl+J22iTyvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576641; c=relaxed/simple;
	bh=JjuQlSBJtcs1s4HB+nRnZWBHE+LnWcQ0BbXuil+tJMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq2iR1msNzxyQALkXX9r5mf2r0MZbDzokFCLO53HKXZpnm22OeJZ8s6IvVB/P1O83Ot/Ky2NzuMmuw2QqAtwyjuy7DA/t36LSajJPfYdNKva3g3+QwthrUhdHUr6+i6yVh2HcxSxB65juDmsTKI8iGQrozPMbg/F/+F3zp1y13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=nkJxtm2P; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="nkJxtm2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576638;
	bh=JjuQlSBJtcs1s4HB+nRnZWBHE+LnWcQ0BbXuil+tJMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkJxtm2P9CLaR7Ws9EykXY8dGhA3nyFim68FBmIPIsbaekCYx5oJh0KacEO9uDo4l
	 BStuge/LwX1+s91bLtCntE6YXQZ+lFja4suLRlNViZZlfWCjaDvfREhSH9vvskRLbV
	 1T1RMPikz7vH3hizyh1wAIqTSmP+fbgw85pK/mSE9j92C9hHs1T/OPQlrj94xpkwET
	 fWERS8AZwIBoyS+aaeTxFrGN+/PWrlHMr/VPuUmL8lbTdTH/BTeIlirT/IrQdrdlTk
	 G7DBNlevmMDZnjwVFialniu8LqndqQB5BWLRJuorJcza/LJMa3h/EclAs63sst+apA
	 +f48l5WaDm0vw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>,
	Uma Shankar <uma.shankar@intel.com>
Subject: [i915-rt v6 07/24] drm/i915/display: Handle vlv dsi workaround in scanline_in_safe_range too
Date: Fri, 20 Feb 2026 09:37:05 +0100
Message-ID: <20260220083657.28815-33-dev@lankhorst.se>
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

Now that we have a macro, might as well handle the VLV dsi workaround
too.

This makes the vblank evasion code slightly more deterministic, by not
looping with interrupts disabled.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 36 ++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index 73676d8ccec8b..3eb6418723a84 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -739,6 +739,24 @@ static bool scanline_in_safe_range(struct intel_vblank_evade_ctx *evade, int *sc
 	else
 		*scanline = __intel_get_crtc_scanline(evade->crtc);
 
+	/*
+	 * On VLV/CHV DSI the scanline counter would appear to
+	 * increment approx. 1/3 of a scanline before start of vblank.
+	 * The registers still get latched at start of vblank however.
+	 * This means we must not write any registers on the first
+	 * line of vblank (since not the whole line is actually in
+	 * vblank). And unfortunately we can't use the interrupt to
+	 * wait here since it will fire too soon. We could use the
+	 * frame start interrupt instead since it will fire after the
+	 * critical scanline, but that would require more changes
+	 * in the interrupt code. So for now we'll just do the nasty
+	 * thing and poll for the bad scanline to pass us by.
+	 *
+	 * FIXME figure out if BXT+ DSI suffers from this as well
+	 */
+	if (evade->need_vlv_dsi_wa && *scanline == evade->vblank_start)
+		return false;
+
 	return *scanline < evade->min || *scanline > evade->max;
 }
 
@@ -769,24 +787,6 @@ int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
 		local_irq_disable();
 	}
 
-	/*
-	 * On VLV/CHV DSI the scanline counter would appear to
-	 * increment approx. 1/3 of a scanline before start of vblank.
-	 * The registers still get latched at start of vblank however.
-	 * This means we must not write any registers on the first
-	 * line of vblank (since not the whole line is actually in
-	 * vblank). And unfortunately we can't use the interrupt to
-	 * wait here since it will fire too soon. We could use the
-	 * frame start interrupt instead since it will fire after the
-	 * critical scanline, but that would require more changes
-	 * in the interrupt code. So for now we'll just do the nasty
-	 * thing and poll for the bad scanline to pass us by.
-	 *
-	 * FIXME figure out if BXT+ DSI suffers from this as well
-	 */
-	while (evade->need_vlv_dsi_wa && scanline == evade->vblank_start)
-		scanline = intel_get_crtc_scanline(crtc);
-
 	return scanline;
 }
 
-- 
2.51.0

