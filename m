Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8C23F40F
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Apr 2025 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582683; cv=none; b=O2I/5L2Sw/GnYnubawBB1faYi1vyPL1a0pvbY3dpV+zg0rInGI95Kz6SQ5eghzqKTPb2bLvDHyQ0YBTL4ZgvQxLzzctKOszZADiq9z+nhYOilO4AuVUDbyNqlDsUlkK9hd8rXiDEHfPHrlF4ZJAsEhvbc+LEyp+E9KjENdXBi3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582683; c=relaxed/simple;
	bh=UVDT8sTACh0OtzzEJGKuXfqyXHJuOvlPqxKEnjZxwXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQ7wAXaOvnyd68MlKK+Y7nKJuH0p4psSBM0Y361JuVcFkJu0RmgxxoPpO/Fz9h0tMjq6xLMM2KuFLgur4vYlnGdGZkYXInPYoToBwjU+8lqoMAmkwTrz+rS+gXd+UkHJPPrWq3ag0QOEIi+3PKkZrKkFfkcNC9ZL9uju+fyOIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMkfM/Xe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMkfM/Xe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745582681; x=1777118681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UVDT8sTACh0OtzzEJGKuXfqyXHJuOvlPqxKEnjZxwXw=;
  b=jMkfM/XenfcMklBJoLRJiAf3ds3ldm9lwGPRvYAjeP1JqSPdi51GY3EO
   jVk8gno4sBq5mepyUBxlr75R1aEojGK8ilOFbf564RPFbDK/ZU6GGO+LS
   4vvLED/aim40DNrDSzKz2E1BxM8dL2qEU3U3jCveBREf3kvd2CgLBNpZ0
   7A21C5SB3w1w/qpgT12i3205Pgkn/CixHK/0wI3qGU9hByhpSf+3mIrlt
   IrrxF9zGcAr4Kkg6zZ2MJpIOlboHds8oqgXF8IAGKWSkpiO1oZMR1X/Ry
   KG3jlZzRZO4N7vvqsy0dk7sovhepeSHn/KEbQyJbXsRzLzP8UpnZm9O+V
   g==;
X-CSE-ConnectionGUID: Vd7vrvgdQOClKFIbuh2Itg==
X-CSE-MsgGUID: wxdaMmE4SgiFJ+EqIY6UeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="51051722"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="51051722"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 05:04:40 -0700
X-CSE-ConnectionGUID: stuH08muRKSHgJLgQGelKQ==
X-CSE-MsgGUID: yTprr9KVQlGZXD/9ef1LmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132763679"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 05:04:34 -0700
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
Date: Fri, 25 Apr 2025 20:04:43 +0800
Message-Id: <20250425120444.642779-1-junxiao.chang@intel.com>
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
 drivers/gpu/drm/i915/gt/intel_gsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 1e925c75fb080..ad63abf1236a8 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -284,7 +284,8 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
 	if (gt->gsc.intf[intf_id].irq < 0)
 		return;
 
-	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
+	ret = generic_handle_irq_safe(gt->gsc.intf[intf_id].irq);
+
 	if (ret)
 		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
 }
-- 
2.34.1

