Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA91E1DEC
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Apr 2025 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477770; cv=none; b=LZsvUcOsRjWorDKJlLTQm4a9xUbJsg7pqJLVn7zbHhVdTQEwfIs0KyLIQxRyIlJpDl43WS2cwfg9+ia5PD1lWOYxIpDdovFSsGM5ae0515T1jJ+c1dqydnU/CWFMDODBECot0z94grAzLCf0EuOOMgLKXDPx97wGKsecdfSehFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477770; c=relaxed/simple;
	bh=Ir3SSYARcOB2QW3Bh2EUraLS/CBw+CKFmNvfHpUxzVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ij34gvxR0VTT8kHbcAbRZ3muUsDvPDaZdMLvvwSBUDR87tk0GfttrS9gpmFusT6mW+MsxhymUvxgaGjP/CMs4t8D6xvRHydNMJqZ0w7nHvCkK8O+m+Bw+hHvp+EOiJRkSjYvD9TXOgMl0gYeZBvXKq1MOyqOD/UmWa0ZpeC+dZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSd/EgbH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSd/EgbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745477767; x=1777013767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ir3SSYARcOB2QW3Bh2EUraLS/CBw+CKFmNvfHpUxzVg=;
  b=fSd/EgbHZXLRgUcyWNsXiB89VP2DTcpgOMc2LnpOwGwJrV49i8ku3TAX
   1hzu/dds7kNXSrcNh/+82Cgf9lN+xnArx+GYqyXWCTlWQFn6xckuuYK2X
   WvsObi7Gad+bEX55iZwQc10mitSaP4rbdCu/o1fTmt+LhE46kNXBmToSQ
   BeOQhkXKqb5C6i1DyUZAJauEXPD0+HUepBGMbKh9OU2R7e3E0xGu9J88r
   Tjp+tq4vgVxrCo+tFqdocF1DCvFJQE/3t9nJUhzP6fU0HHdPyOeXIWLZd
   JR2FRO76bRzR4xZY0jh4eAPzo/Eh26E3BRJoCKYV0Tyg1PskwUkJmOdUh
   A==;
X-CSE-ConnectionGUID: iSfCN+AISESw1W+DEI1zyw==
X-CSE-MsgGUID: eHTAD3OnS3i9CzquNH0bOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57292846"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="57292846"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 23:56:06 -0700
X-CSE-ConnectionGUID: Hv9IHME7RL60tTAWX4oaPA==
X-CSE-MsgGUID: cgZo7lo+ReG/4taaxT42OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="163505032"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 23:56:03 -0700
From: Junxiao Chang <junxiao.chang@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: junxiao.chang@intel.com
Subject: [PATCH] drm/i915/gsc: mei interrupt top half should be in irq disabled context
Date: Thu, 24 Apr 2025 14:56:08 +0800
Message-Id: <20250424065609.624457-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MEI GSC interrupt comes from i915. It has top half and bottom half.
Top half is called from i915 interrupt handler. It should be in
irq disabled context.

With RT kernel, by default i915 IRQ handler is in threaded IRQ. MEI GSC
top half might be in threaded IRQ context. In this case, local IRQ
should be disabled for MEI GSC interrupt top half.

This change fixes A380/A770 GPU boot hang issue with RT kernel.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 1e925c75fb080..9c72117263f78 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -270,6 +270,9 @@ static void gsc_init_one(struct drm_i915_private *i915, struct intel_gsc *gsc,
 static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
 {
 	int ret;
+#ifdef CONFIG_PREEMPT_RT
+	int irq_disabled_flag;
+#endif
 
 	if (intf_id >= INTEL_GSC_NUM_INTERFACES) {
 		gt_warn_once(gt, "GSC irq: intf_id %d is out of range", intf_id);
@@ -284,7 +287,18 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
 	if (gt->gsc.intf[intf_id].irq < 0)
 		return;
 
+#ifdef CONFIG_PREEMPT_RT
+	/* mei interrupt top half should run in irq disabled context */
+	irq_disabled_flag = irqs_disabled();
+	if (!irq_disabled_flag)
+		local_irq_disable();
+#endif
 	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
+#ifdef CONFIG_PREEMPT_RT
+	if (!irq_disabled_flag)
+		local_irq_enable();
+#endif
+
 	if (ret)
 		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
 }
-- 
2.34.1

