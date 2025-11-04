Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9C28C00C
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Nov 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245918; cv=none; b=Zp2H314b5S2y5PGkgBKzlaXsMl1sitFNCET0Bo2WNC/bo5pc4NNU8KIzRKVCz/0OncZaf8gZGUBMxNO/GDAhcKCn5NiDeUswSnj9wjxqYi0CtClHSycCOdVnVpWuOippphZ463eaTGfrO4AT2kQSWmbjAuGLX+GcvYk00PYdj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245918; c=relaxed/simple;
	bh=5EyVl++02A6gXmAu1FIdHW+rmMCx4mTCiwsTCNDLiTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWtAT3GdzUyzI3O9D3JKGAoB7cB+AljieIanlGEnx9K6idypS5dGKmECe9HwrYBLViaAfkv/P6WMY428ck+BWtW9eBBkMFMqy0us+xXUUS+stvVe6aX6kHAWLhqvUM90ch3ZIJAjn0StuwS2lSvIo1s8vhFnzOsrGL3/CRiiAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=fv3MPoO4; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="fv3MPoO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1762245407;
	bh=5EyVl++02A6gXmAu1FIdHW+rmMCx4mTCiwsTCNDLiTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fv3MPoO4Dk7QvcADP9IWAkOO2NvEzAymD1cS6A2eFHwKy3LoPg3nWMMWJuwClqs3r
	 35qmKvICZSjQ2owdbhW9wrwbnKYhQxozAfKBO89mjHQXWGSHE7nIRQEoCIEPrh8obf
	 +4m5FoSPebVKPAoT0vAyfyjt7n3REr1fq+IKK/JxCRIRwo7tvaUkI+uoKI1jlLPmeD
	 l+H90hzm13AJSxsB89wW8vqUxY+qL8U4dYx959KowFMpMm1sOXOT8OkBJko//frjz1
	 y0l485RMadKcH+akRaA+br3jEQCiqgKcB6kZykR9/QnTGtzRVUcG1hXSyUGOYZihfW
	 /gRlZfh1VUtfQ==
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
Subject: [PATCH v2 4/7] drm/i915/display: Remove locking from intel_vblank_evade critical section
Date: Tue,  4 Nov 2025 09:36:28 +0100
Message-ID: <20251104083634.670753-5-dev@lankhorst.se>
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

finish_wait() may take a lock, which means that it can take any amount
of time. On PREEMPT-RT we should not be taking any lock after disabling
preemption, so ensure that the completion is done before disabling
interrupts.

This also has the benefit of making vblank evasion more deterministic,
by performing the final vblank check after all locking is done.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 35 ++++++++++-----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index 2b106ffa3f5f5..3628d2a1b8f38 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -708,6 +708,13 @@ void intel_vblank_evade_init(const struct intel_crtc_state *old_crtc_state,
 		evade->min -= vblank_delay;
 }
 
+static inline int vblank_evadable(struct intel_vblank_evade_ctx *evade, int *scanline)
+{
+	*scanline = intel_get_crtc_scanline(evade->crtc);
+
+	return *scanline < evade->min || *scanline > evade->max;
+}
+
 /* must be called with vblank interrupt already enabled! */
 int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
 {
@@ -715,23 +722,22 @@ int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
 	struct intel_display *display = to_intel_display(crtc);
 	long timeout = msecs_to_jiffies_timeout(1);
 	wait_queue_head_t *wq = drm_crtc_vblank_waitqueue(&crtc->base);
-	DEFINE_WAIT(wait);
 	int scanline;
 
 	if (evade->min <= 0 || evade->max <= 0)
 		return 0;
 
-	for (;;) {
-		/*
-		 * prepare_to_wait() has a memory barrier, which guarantees
-		 * other CPUs can see the task state update by the time we
-		 * read the scanline.
-		 */
-		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
+	while (!vblank_evadable(evade, &scanline)) {
+		local_irq_enable();
 
-		scanline = intel_get_crtc_scanline(crtc);
-		if (scanline < evade->min || scanline > evade->max)
-			break;
+		DEFINE_WAIT(wait);
+		while (!vblank_evadable(evade, &scanline) && timeout > 0) {
+			prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
+			timeout = schedule_timeout(timeout);
+		}
+		finish_wait(wq, &wait);
+
+		local_irq_disable();
 
 		if (!timeout) {
 			drm_dbg_kms(display->drm,
@@ -740,15 +746,8 @@ int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
 			break;
 		}
 
-		local_irq_enable();
-
-		timeout = schedule_timeout(timeout);
-
-		local_irq_disable();
 	}
 
-	finish_wait(wq, &wait);
-
 	/*
 	 * On VLV/CHV DSI the scanline counter would appear to
 	 * increment approx. 1/3 of a scanline before start of vblank.
-- 
2.51.0

