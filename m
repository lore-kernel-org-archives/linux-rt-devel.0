Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44E2857CD
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576654; cv=none; b=sWGg0sQPgL2vyVnK/ZdSvLTCDV7GckQArwYNkTF3Jz2pYBitLYCvxgbCx6v2CHNdjCpF51VcjxcUOgEP6DAJ/LGs9rfkekb4nHvo4GaEGE84hCNuQ7eZSCL1UkdRIubhiufUfWv/nTMJgW7logKho0bQotzyd94JBo8rBR39KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576654; c=relaxed/simple;
	bh=53C66RzHtX9qL76yXPs+mBF863nfy4n79sLU5LTiPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYvtk88fSBJqg3nmEsa4AgMYsZSLaX7x8wl3GjuZS3Pic3zORgfLXEej0JSKjCs0g8i2ir5GQSdHBln2pDmd0IaLETx2WdBXWzA4Qtgdm5hPp98KW5yRyI8jSkZ7zTQyccADX51mrZWhnpw6pGVR/+aLI/u6OxnnwHe+I0Wue+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=LUr1af6x; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="LUr1af6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576651;
	bh=53C66RzHtX9qL76yXPs+mBF863nfy4n79sLU5LTiPXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUr1af6x/aAxfUO55uHqBLQmHbj9Dz8lMAE+ewHimwjy/I+YxaXDI/W3yaoWYzF91
	 HijazkaVcMspeWP+IvUvwk8odC05s2TVuqOQYj6MgDikzKTRtAn5l2EPwI0Aqk9Uvc
	 Wh5/EnUH3wvstZN5DWh3deJ5wkIc2BaHdyrUZ2v0S2kdoP6fGAJwaztnjHmzSoxzRk
	 hHBRwBNgbZPpCD8qB6sfNxVCdj7H96m3ZkB2M703np6RFSG0ye2tzW9J2HHleeDpwQ
	 yKz9ZhQOvcNntAvIL5zbg7uHK+rvi87LE+eke1znB0/jl5PoTd/m8D3JSzvtjkrjXw
	 alTUxokgtD3pQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>,
	Matthew Brost <matthew.brost@intel.com>,
	Uma Shankar <uma.shankar@intel.com>
Subject: [i915-rt v6 15/24] drm/i915/display: Fix intel_lpe_audio_irq_handler for PREEMPT-RT
Date: Fri, 20 Feb 2026 09:37:13 +0100
Message-ID: <20260220083657.28815-41-dev@lankhorst.se>
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

The LPE audio interrupt comes from the i915 interrupt handler. It
should be in irq disabled context.

With PREEMPT_RT enabled, the IRQ handler is threaded.
Because intel_lpe_audio_irq_handler() may be called in threaded IRQ context,
generic_handle_irq_safe API disables the interrupts before calling LPE's
interrupt top half handler.

This fixes braswell audio issues with RT enabled.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lpe_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
index 5b41abe1c64d5..172c0062237eb 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -262,7 +262,7 @@ void intel_lpe_audio_irq_handler(struct intel_display *display)
 	if (!HAS_LPE_AUDIO(display))
 		return;
 
-	ret = generic_handle_irq(display->audio.lpe.irq);
+	ret = generic_handle_irq_safe(display->audio.lpe.irq);
 	if (ret)
 		drm_err_ratelimited(display->drm,
 				    "error handling LPE audio irq: %d\n", ret);
-- 
2.51.0

