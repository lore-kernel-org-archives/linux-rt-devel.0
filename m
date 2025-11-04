Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD7314B68
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Nov 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245414; cv=none; b=CTaFIvKRv80uqOsNRuA2uefxfghiR3T/4GFQd3nJXwJQ0DBdD3D2Xoz51v+oeoCpKYGRAnBjGS2Pzbu658xQlEU3r4d0QdIbALjbkSWdXp6o2rG2dam87glbR3ydnct0uR8QlE7431i2LCyR4vK4OrPLGau9PtTuZF4GMXmFTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245414; c=relaxed/simple;
	bh=0eIelrLCgvItLKJTaYXGJPRomkuTZ6Fb/nXo41fHTdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqGihXsRgIAnTTGAgJKCS6ZEj/Z7ALPVZbMBL5w9E+BiJNNR6I+7/n4Z/v2ircK1V+Snix4BL2/CvKY/ACG9PIPb9/oY+UzN5pYEhjvCrZNDvtyADMts9QjeQ9i1FzZK+sd1NcaC2ShKeDYm2icbY6w5Qeo0Q2kGhZwVsz/BLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=TYlCxKSI; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="TYlCxKSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1762245408;
	bh=0eIelrLCgvItLKJTaYXGJPRomkuTZ6Fb/nXo41fHTdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYlCxKSIo1/9MnI5a5BFRn39DloMwDXoV4DzFj23CzAcrziMCxguajzFVFWl2Xkpy
	 LSXKG0K8xwRtYJRK9R0IVK+R/PoeZnm4x7zQ0qOIVaCpQsjQgmYfwr/9WpsO9U1KtV
	 kt0uGo7naJBT/+ljWMU+wvM/rTfBX881X3W4EZMbMIKftYDSQRa0CoV9XoTXNdgyT9
	 6PDscq/sWO4/k8bDF+HVOgUV6GlY9g+t7TURBWDmUH9Rd4Okqx2HYmhrJIvw/m2Tg9
	 q7zEPtXcKc4PIFB2A5gZDfmffzEHPyn4b8Ntxc82rXw6c9Qv1Wc2/7jsjU6IMDrHW1
	 uBsiUqbeFa2tw==
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
Subject: [PATCH v2 5/7] drm/i915/display: Make icl_dsi_frame_update use _fw too
Date: Tue,  4 Nov 2025 09:36:29 +0100
Message-ID: <20251104083634.670753-6-dev@lankhorst.se>
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

Don't use the dmc lock inside the vblank critical section,
not even as last call.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/icl_dsi.c                | 4 ++--
 drivers/gpu/drm/i915/display/intel_de.h               | 6 ++++++
 drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 70d4c1bc70fc3..e52b434ac8f11 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -243,8 +243,8 @@ void icl_dsi_frame_update(struct intel_crtc_state *crtc_state)
 	else
 		return;
 
-	intel_de_rmw(display, DSI_CMD_FRMCTL(port), 0,
-		     DSI_FRAME_UPDATE_REQUEST);
+	intel_de_rmw_fw(display, DSI_CMD_FRMCTL(port), 0,
+			DSI_FRAME_UPDATE_REQUEST);
 }
 
 static void dsi_program_swing_and_deemphasis(struct intel_encoder *encoder)
diff --git a/drivers/gpu/drm/i915/display/intel_de.h b/drivers/gpu/drm/i915/display/intel_de.h
index 9ecdcf6b73e4d..15f606a4a2e9d 100644
--- a/drivers/gpu/drm/i915/display/intel_de.h
+++ b/drivers/gpu/drm/i915/display/intel_de.h
@@ -214,6 +214,12 @@ intel_de_write_fw(struct intel_display *display, i915_reg_t reg, u32 val)
 	intel_uncore_write_fw(__to_uncore(display), reg, val);
 }
 
+static inline void
+intel_de_rmw_fw(struct intel_display *display, i915_reg_t reg, u32 clear, u32 set)
+{
+	intel_uncore_rmw_fw(__to_uncore(display), reg, clear, set);
+}
+
 static inline u32
 intel_de_read_notrace(struct intel_display *display, i915_reg_t reg)
 {
diff --git a/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h b/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h
index d012f02bc84f7..57d5ffabf2d52 100644
--- a/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/intel_uncore.h
@@ -91,6 +91,8 @@ static inline u32 intel_uncore_rmw(struct intel_uncore *uncore,
 	return xe_mmio_rmw32(__compat_uncore_to_mmio(uncore), reg, clear, set);
 }
 
+#define intel_uncore_rmw_fw intel_uncore_rmw
+
 static inline int intel_wait_for_register(struct intel_uncore *uncore,
 					  i915_reg_t i915_reg, u32 mask,
 					  u32 value, unsigned int timeout)
-- 
2.51.0

