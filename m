Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DB2F7F19
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 May 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983482; cv=none; b=Tqo2/OsoHa2PVuh6qdidpt3WRVVINyY/M75ZSFpUpf1EU+MIHM9G9BmwqjzIN9WSv8IBmbBAuIGCnF8s14iEerZ/YqdVRmL0WdEWMRluoRlMJ+wr+gRefgHPEAR3rOMzF09J1PJRSKhzdNjbAc1ztEYTb86QI8sc8otvT4TQ1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983482; c=relaxed/simple;
	bh=C9nbPprPSzvyG1eI6izTWL/Iwk1S4ELptvpZgAnKHhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nfRXDNA6bKZaZktxg2FKv8jipIR5vKXJUy+YdJafaxWsbsVNi7QmLYEb76/T35aPkHrXcjscS0C52BX7dD5MCsw/qNm9Mihcnho8fqSSCCkLxKRf8I0kc1qOHUtenHLhbD71YBaznFVJifAtOr0wM9eduI6woUNnu79N/5GUCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=i+oYMtE2; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="i+oYMtE2"
Received: from PC-202605011814.localdomain (unknown [IPV6:2409:8924:2013:1a6b:50af:214a:ea2b:7da2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 403418ca8;
	Thu, 28 May 2026 23:45:58 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	bigeasy@linutronix.de,
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
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE audio irq
Date: Thu, 28 May 2026 23:45:51 +0800
Message-Id: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6f438ac703a1kunmeb945bb5695a4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSExCVh0YSUkfQhkeSUwaHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSU9BSUtKSEFKGk0ZQU5LGh1BSUpPGkEeGkkZQU
	wfGklZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=i+oYMtE2Uw987NRwaIDLItV2PiXrfbsCTGptQqXsNBgKX6eSnYckWaW0ilkf7Z7q+7yAlojA/BSfPcWvvYgWDMC+MwDVjA1CKybUCLSlyt7b5omxUKGD8J1isNfRVgCxMr1Zzr4PoQ2O/iAqTsdK0sc00d6YEq5mSmAC+XtT38o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=loucx8xe4IYiCrHUEihfpijKrZOkZGAVA8/7vYAgfsM=;
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

Fixes: eef57324d926 ("drm/i915: setup bridge for HDMI LPE audio driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
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
