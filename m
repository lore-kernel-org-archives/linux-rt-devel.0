Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387162857CD
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576669; cv=none; b=CEA/wktDlYdxV1deriOBBA+dSKi6IS1pW/2XYLLhVuMzGocu1hLnqhWtQNNJT3Cwym8ASn+FxJBy2VcdUh0mB+wAfaFiig+fMvkgARZ5C5s5Sn+Vz+QQlKI8exqkvy7XFMfCPLnpZRwnQTkTyWlnNmPPMgLuATHYt8uwm3X+mCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576669; c=relaxed/simple;
	bh=VBco7zVB9VTaGgt3tIx7GWoTZdb6hMaqwzco395EbzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBB3Y8QzFmm7qEi5RWWJPzXRKROwzVcn6J6Vgd4J4n+6jx4epQ8f9iKnwGAfIx4AHDNDVkt+Tc+1ZZvbPp/LsPf6NF2uxIK/iv9Jg0irZcv54q/OmRhCfUE9x7Pc6PxtzY1DIbTKjhCK40Vcc+uoENomu+7mki+hgEfteyROQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=UowcRtqo; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="UowcRtqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576666;
	bh=VBco7zVB9VTaGgt3tIx7GWoTZdb6hMaqwzco395EbzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UowcRtqovuImaK2Jkc1EvmNPZ+17LmsPylMzA+5fL6T5z1sw38RYQ9fif8TF3b3h4
	 mIFP9/G+0Nlhw7m2Gbl1dRBcZHvWuD+lxYHsap3cNDE8vSZ8LtnQNDBiEt4pCXSeP0
	 O/hEbQlZq7kBrYJjRqNz/bhOO4pa2fDHCF90DdwV4cllOzcaEQL4ccnUyap563hoxw
	 KJMwqNG84d9+DH9zjD7xkvitx0G2NskG0IMJ776kwW3Wm+jq/wzPRD/Sb5yFeVNBli
	 2JtVH4Ch3JnNWTk8bRNaNaVJoCxnCrl7gW7G9SPvOEpLgofq+bZ/RB8XZXwgLF0ow/
	 wuEjRVLi1+S6g==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 23/24] PREEMPT_RT injection
Date: Fri, 20 Feb 2026 09:37:21 +0100
Message-ID: <20260220083657.28815-49-dev@lankhorst.se>
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

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/Kconfig.debug | 15 ---------------
 drivers/gpu/drm/xe/Kconfig.debug   |  5 +++++
 kernel/Kconfig.preempt             |  4 ++--
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 3562a02ef7adc..0ab10ff41e38d 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -233,21 +233,6 @@ config DRM_I915_LOW_LEVEL_TRACEPOINTS
 
 	  If in doubt, say "N".
 
-config DRM_I915_DEBUG_VBLANK_EVADE
-	bool "Enable extra debug warnings for vblank evasion"
-	depends on DRM_I915
-	default n
-	help
-	  Choose this option to turn on extra debug warnings for the
-	  vblank evade mechanism. This gives a warning every time the
-	  the deadline allotted for the vblank evade critical section
-	  is exceeded, even if there isn't an actual risk of missing
-	  the vblank.
-
-	  Recommended for driver developers only.
-
-	  If in doubt, say "N".
-
 config DRM_I915_DEBUG_RUNTIME_PM
 	bool "Enable extra state checking for runtime PM"
 	depends on DRM_I915
diff --git a/drivers/gpu/drm/xe/Kconfig.debug b/drivers/gpu/drm/xe/Kconfig.debug
index 01227c77f6d70..1d5f11c6e88f3 100644
--- a/drivers/gpu/drm/xe/Kconfig.debug
+++ b/drivers/gpu/drm/xe/Kconfig.debug
@@ -30,6 +30,11 @@ config DRM_XE_DEBUG
 
 	  If in doubt, say "N".
 
+config DRM_I915_DEBUG_VBLANK_EVADE
+        def_bool y
+        depends on DRM_XE
+
+
 config DRM_XE_DEBUG_VM
 	bool "Enable extra VM debugging info"
 	default n
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index da326800c1c9b..68a6d42c55abe 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -87,9 +87,9 @@ config PREEMPT_LAZY
 endchoice
 
 config PREEMPT_RT
-	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !COMPILE_TEST
+	def_bool y
 	select PREEMPTION
+	depends on ARCH_SUPPORTS_RT
 	help
 	  This option turns the kernel into a real-time kernel by replacing
 	  various locking primitives (spinlocks, rwlocks, etc.) with
-- 
2.51.0

