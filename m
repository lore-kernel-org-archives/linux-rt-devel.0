Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36026D4FC
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Apr 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593867; cv=none; b=PkDt5oDvXmcagQawas/B6V6UGs6F+eNxqb5dgwARxKq/RtUqyYI4bxXGFEj8GOhb48UuruJyRv08q/SXHnCtLmCFCnpOzZ4fkzSXMrHKMHWYktrZfyrQXWkO1PQjsP/AXgzhvKKYThkVjn2JGaFCkEuX4Yqe8rSyEKCX9Vvbwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593867; c=relaxed/simple;
	bh=5aYTKnW1uf91zxpbLRkRmehpF7E6EkPj5cYjxOKlKlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khx3AL3A8BPLJKDGkXDn1rGv3yj/1IdRrQAnYqrvHywvhnmIJfscXqKHBTJJgbDuJWL5Tyl9MvXJdNnugFCgUXIBzxUQjg7i/BK+FulUz4zh0WXTdCMByWyJrQeeWLR25Trsz5CuH3JbJOmbrAZ+gGcICgeDDH67sVqV++PHmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3wQZAFA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3wQZAFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745593865; x=1777129865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5aYTKnW1uf91zxpbLRkRmehpF7E6EkPj5cYjxOKlKlk=;
  b=B3wQZAFAWjQe1TgLaGpitSdsRHNNDB67wS1VuwErgvC74bfhhobBxD8u
   PcQMm/k65P2E90BJDfn+d3PVlOaTc3GvaAuWOWShMBxefQkU+6ZAjxJVr
   EENVtkl2HbWwjTmkTy9MlXzRiFCjX97quCXzejtG1B7VcZ1ewCWOvLZzv
   OEF+Qkpnl+PB7gWXxlZLnlCmfo+L24nTdhG85jNQ6SX5IcR45OF1cSPGh
   hXFOKSJJeOaAdqSksVXQh/uC+owMpfLe/88WUxTWQoDh6xUErbHnLLmjB
   +OcQBbVRX+TEbaxRYRw3ZpvptTp69Kn8/oC3GW4AYsS7EyeTNhsajMvUU
   g==;
X-CSE-ConnectionGUID: hlao1uzXT5KIqoJLEOlKrQ==
X-CSE-MsgGUID: oi33PQt/TWG7IuIwdJTqYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47133758"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47133758"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 08:11:04 -0700
X-CSE-ConnectionGUID: XWU8z64fTNawiwnxY2teIg==
X-CSE-MsgGUID: /VdhN3htTS6WdDeoB86ywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137916047"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 08:10:59 -0700
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
Date: Fri, 25 Apr 2025 23:11:07 +0800
Message-Id: <20250425151108.643649-1-junxiao.chang@intel.com>
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
 drivers/gpu/drm/i915/gt/intel_gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 1e925c75fb080..c43febc862dc3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -284,7 +284,7 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
 	if (gt->gsc.intf[intf_id].irq < 0)
 		return;
 
-	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
+	ret = generic_handle_irq_safe(gt->gsc.intf[intf_id].irq);
 	if (ret)
 		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
 }
-- 
2.34.1

