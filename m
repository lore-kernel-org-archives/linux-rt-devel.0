Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79CB1BCA1C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576665; cv=none; b=YOCE8DEOFHJq5NgpLRQ3JI/ftE/qpch9jynmEVbiAWx22ELucbmCQzWN4pOpnatfrKAlWsqx13/gTu9Cfb7UGzdWL4JKx7mWqT86o5aVvjmEm9+qFFCM6YuIG8Y5qlIqfn/GVWwnyNMObbIkSM4T6HLc2XWB9SUMqmAHrwAu4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576665; c=relaxed/simple;
	bh=Sgs+xvbaZIKHW7VoGQkz1t86r8O9YlWDGxUt8MB3jqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+JJiaCmHaSgrBIFRWS4mCRuhsPmBPODzJ/vQfL4ZKQ6CUsimGpXx3xYi6DCO9g/r5FA/TTh90DHKv5YrPUHb9mxbwHwINq1KdDRguIdb5KTzxcTEV0nVl8DSnonYs8XGyOf30GjKWYcSjOlLCLYMzbY1QcAMmiDuq3C5nAlRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=BL/MRKHH; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="BL/MRKHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576663;
	bh=Sgs+xvbaZIKHW7VoGQkz1t86r8O9YlWDGxUt8MB3jqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BL/MRKHHfUURN7dYKbohwDbT12i/t+pGXmO6pmKojePQFeHbGo6BMGLL9IyQWpoC7
	 7r98cuFWngyzvVTm6eSP5hTmsB0A/bWvDWQitmwQHHfpwAZ+KFNuZhbosFmUSq/XRm
	 QwNrjRL20P3rL01nllrt1o7r1JkWsLd3M5RURVh13LhPoFa1rFHOiMdsVxflZGmyMH
	 Rqe9qE1RPYlfIselzCLJ93S29ZZVbssBlmVaPb7KplMSKkCvie9zapKPpBVR98dWwk
	 UGa9IVOBf5BAfAkO4DCzu6HAWRyF3FHn15U83UeUJr4IbH//vzzdQDqokUkW5QxDFY
	 cq7LJFcrAkHdA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 21/24] drm/i915/display: Remove uncore lock from vlv_atomic_update_fifo
Date: Fri, 20 Feb 2026 09:37:19 +0100
Message-ID: <20260220083657.28815-47-dev@lankhorst.se>
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

TODO: Grab uncore lock during entire vblank evasion before disabling
interrupts, and check what breaks?

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/i9xx_wm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/i9xx_wm.c b/drivers/gpu/drm/i915/display/i9xx_wm.c
index 24f898efa9dd7..abf9f023bdd58 100644
--- a/drivers/gpu/drm/i915/display/i9xx_wm.c
+++ b/drivers/gpu/drm/i915/display/i9xx_wm.c
@@ -1863,7 +1863,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
 				   struct intel_crtc *crtc)
 {
 	struct intel_display *display = to_intel_display(crtc);
-	struct intel_uncore *uncore = to_intel_uncore(display->drm);
 	const struct intel_crtc_state *crtc_state =
 		intel_atomic_get_new_crtc_state(state, crtc);
 	const struct vlv_fifo_state *fifo_state =
@@ -1892,7 +1891,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
 	 * intel_pipe_update_start() has already disabled interrupts
 	 * for us, so a plain spin_lock() is sufficient here.
 	 */
-	spin_lock(&uncore->lock);
 
 	switch (crtc->pipe) {
 	case PIPE_A:
@@ -1951,8 +1949,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
 	}
 
 	intel_de_read_fw(display, DSPARB(display));
-
-	spin_unlock(&uncore->lock);
 }
 
 #undef VLV_FIFO
-- 
2.51.0

