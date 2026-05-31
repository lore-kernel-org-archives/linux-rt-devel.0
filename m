Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617632D94BA
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241792; cv=none; b=IORGkra56kO/ZKmSPapkvYotLxtOd1HrwAk3TepC0HJH3JseOu1N3HNNyAgh74DcRH9Unwa97WThJIAOgnpMTe3Ck0QBguswJyE6FzYHEY1jUNpaDGnCtPruAZoBLs6ZQZfOeWBY6t+y1dun+AbtWMsulV/xPXPQHRHAXYREhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241792; c=relaxed/simple;
	bh=LouVJhSa7zh91F2Ohng9mFfJtdukqR9oAWmyjIgpb/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYSh67TJksMG2aZuPFQiSNmusxUdrn2JAr0iP/kIY88l5qDAodzHUSrBE1rsmpPiRjOs0jNYSOsZG1PgM8RJ56sEcaj47cf3moQ9TTALmij55xEe2cv522PaTqnOZpn/DZqtA8m6emCD7PWZYck9cVuy/RQ2lz5aarpI0IrPaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hZrnfinu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hZrnfinu"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4079b06e0;
	Sun, 31 May 2026 23:31:18 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	jerome.anand@intel.com,
	pierre-louis.bossart@linux.dev,
	tiwai@suse.de,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH v2] drm/i915/audio: use generic_handle_irq_safe() for LPE audio irq
Date: Sun, 31 May 2026 23:31:08 +0800
Message-Id: <20260531153108.1448185-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531152307.1283430-1-runyu.xiao@seu.edu.cn>
References: <20260531152307.1283430-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7ea9333803a1kunmf881f88610bfb5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE8ZVkIZTk9KGkkaQhhCSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=hZrnfinuQpp+r6EHpu+x9payITlyKfPOR79KX5meBd9GCPDgyk9e2jwsXx9RoMM4x+JSzruYEWlWoWM63xqwus+t6AZpD6WnsWbFMjTMlUmhuwYQw5MFqeweWLxIC0hZXpgpMPXZZh+Y0YTslx/xFfmbQwrU3haqaX9etiEWJ40=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=hDaIee1qAflFeBZV4uLANTtsezA1dAxOljNHIOSLk9U=;
	h=date:mime-version:subject:message-id:from;

intel_lpe_audio_irq_handler() forwards the LPE audio child IRQ from the
i915 parent IRQ path with generic_handle_irq(). The forwarded child top
half is not an independent hardirq entry point; it inherits the context
of the outer i915 interrupt dispatch path.

This becomes a problem when the parent IRQ runs in threaded context, for
example on PREEMPT_RT or other forced-threading configurations. i915
requests the parent IRQ with IRQF_SHARED and without IRQF_NO_THREAD, so
the forwarded child handler can run with local IRQs enabled. That
violates the expected top-half execution semantics and can trigger an
"enabled interrupts" WARN.

The issue was identified on Linux v6.18.21 by our static analysis tool
and then manually reviewed on the i915 child-IRQ forwarding sites after
commit 8cadce97bf26 ("drm/i915/gsc: mei interrupt top half should be in
irq disabled context") fixed the same helper contract for the GSC path.

It was then validated with a reproducible QEMU no-device parent/child
IRQ harness that registers a threaded parent IRQ and a child IRQ
handler, then exercises both generic_handle_irq() and
generic_handle_irq_safe() under the same threaded parent context. In the
plain-helper phase, the child handler ran with irqs_disabled=0 and
triggered an "enabled interrupts" WARN. In the safe-helper phase, the
same child handler ran with irqs_disabled=1. This is family-level
runtime evidence for the same IRQ forwarding misuse pattern. No
Baytrail/Cherrytrail hardware was available to run the real i915 LPE
path end-to-end.

Use generic_handle_irq_safe() here so the forwarded LPE audio child IRQ
runs with local IRQs disabled even when the outer i915 dispatch path is
threaded.

Link: https://lore.kernel.org/all/20260310115709.2276203-16-dev@lankhorst.se/
Fixes: eef57324d926 ("drm/i915: setup bridge for HDMI LPE audio driver")
Suggested-by: Maarten Lankhorst <dev@lankhorst.se>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Add Link: tag to Maarten's PREEMPT_RT series
- Add Suggested-by: Maarten Lankhorst
- Drop Cc: stable@vger.kernel.org per Sebastian's feedback
- Keep as a standalone patch per Jani's suggestion

 drivers/gpu/drm/i915/display/intel_lpe_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
index 42284e9928f2..ac1dfd592a9f 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -263,7 +263,7 @@ void intel_lpe_audio_irq_handler(struct intel_display *display)
 	if (!HAS_LPE_AUDIO(display))
 		return;
 
-	ret = generic_handle_irq(display->audio.lpe.irq);
+	ret = generic_handle_irq_safe(display->audio.lpe.irq);
 	if (ret)
 		drm_err_ratelimited(display->drm,
 				    "error handling LPE audio irq: %d\n", ret);
-- 
2.34.1
