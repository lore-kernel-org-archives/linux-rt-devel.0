Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D36218AC1
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Apr 2025 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561097; cv=none; b=C2c4OvmteCS/W8xQ9UUmes/ZNAVU9z1qDmLBJH5FFYoFkjh6LvnLLIqVw714xOzDD93VmjphS6l1/5y5GFURAUUvD+uHlepXS7qB/WbkZa6LgRqIxyuxMj3MHcIb0I0hiMJ87gzE7b3++AOm8yObNv8dgF+l31hAw9RPaDoQipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561097; c=relaxed/simple;
	bh=3t+D9Lfr67XaN/OQI2Y5+/XH4J/b8IDwoIxmQNpmNHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXxunY1xUG9k0weELB5hAhRxthMw+/hKjy2EASTTYti8TRVfq/3CIXxKqGsGHZ67X9Ij/TyeL/Fe8WYShq75oP36XRoEiJPgvEvPPVFkCdAYTOUGvc7UaPTpImQ12MVDc/tis/JbNiBtrLNBd4xDPdTE1EOj+3y7Dd2BTbCPcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+dDc3Ts; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+dDc3Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745561095; x=1777097095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3t+D9Lfr67XaN/OQI2Y5+/XH4J/b8IDwoIxmQNpmNHk=;
  b=e+dDc3Tsr77J22NcSt69IM+nFwHyR/jjYsy7dHoooF1f0FSrhdgtb5LS
   MTk4lG2QuEqLnmAGbYq65eDRa6oMe4uvtJ5KrK+DsythCAUTdlfPQa6mS
   3CJ/+vTs32X0lgLPR21ynjSoOhY0eknn+a+P47Avk0eucSunwA3XkEyO3
   ULV+xsFNMGFQiqj/RmRpExwpMXNRA8M4HrHn370UML4mqZVe+Xv3GE8Mn
   4j4Vop2rM2j99AxRE9Nu1TSihOZH/qH6gWL9w3IkU1ZVMSJqNVbx2ft7X
   8GULg7irBbyE5NZqzfhXxAkVesWLZVcbHe1FHAbRbtYOQpY+mVq8+t4fC
   A==;
X-CSE-ConnectionGUID: +VU1XILbRyaeWL6fKQIylA==
X-CSE-MsgGUID: DznN+7pHSKO6BL+POh/OYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="51021645"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="51021645"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 23:04:54 -0700
X-CSE-ConnectionGUID: kxh1GToFSUq1UwgD/emrLw==
X-CSE-MsgGUID: bMWV5gwtTsmWaKtljNz7Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133350476"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 23:04:50 -0700
From: Junxiao Chang <junxiao.chang@intel.com>
To: tomas.winkler@intel.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: junxiao.chang@intel.com,
	furong.zhou@intel.com
Subject: [PATCH] drm/i915/gsc: mei interrupt top half should be in irq disabled context
Date: Fri, 25 Apr 2025 14:04:54 +0800
Message-Id: <20250425060455.641008-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424065609.624457-1-junxiao.chang@intel.com>
References: <20250424065609.624457-1-junxiao.chang@intel.com>
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
top half might be in threaded IRQ context. generic_handle_irq_safe API
could be called from either IRQ or process context, it disables local
IRQ then calls MEI GSC interrupt top half.

This change fixes A380/A770 GPU boot hang issue with RT kernel.

Fixes: 1e3dc1d8622b ("drm/i915/gsc: add gsc as a mei auxiliary device")
Tested-by: Furong Zhou <furong.zhou@intel.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 1e925c75fb080..a099d885508ac 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -284,7 +284,9 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
 	if (gt->gsc.intf[intf_id].irq < 0)
 		return;
 
-	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
+	/* It can be called in both irq context and in thread context */
+	ret = generic_handle_irq_safe(gt->gsc.intf[intf_id].irq);
+
 	if (ret)
 		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
 }
-- 
2.34.1

