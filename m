Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676859;
	b=Vwb+4sCmD1ku02POhjQbwUVitt3FnEJcAEd3QQWpO5em3wRldmeXU6+8LH07YSTvECbu
	 LPSvrGIl2PWf8raDU8Wbnm/DVYRYTKAdP7OefT/HZngcT1nld6Nzld0jPmSOj8prnTw38
	 DcX9lxkNB0qRYn+FEbFU+TWdLKLZMLcAyfjXTZCwBaeqHDgcLfdx7zQ1WtTmUi9sPTMwm
	 E73r8UyL9IP2OjN8hqmoyGUuScoPbmsjIafKdHMvNCaJndvZjIlewxNZ5RPHbarSbJWNy
	 gFp3abVESnGIC+Jyye2GprU/NSwBdAdb+ejYXqJ9/D/IuKwbzTQRfPQnf3JfgwoppQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676859;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+KFQfvqCaAVoWksFQF0LdVmJUFSaH6S/BvTxXHwburA=;
	b=q2G0F9jtXI4xlCJ3l5fFW4AmQJliGkv3/kheP4oSyNcli1XzdLMs/4vshdgj6Ze2yYUC
	 ErBg8YjtxJanQKWsetiGaizE058KfSKoOF7S9frSJCRcVbXQK2hWOck2DWiI4NDy622kC
	 KX36oEl5tNU0Kt4/kkBeoejP6lZqeVWGCnFcSD7yIFma2Qt3h91cX4S421uSS8nD1ntAs
	 2O/2po4CvB30A74rTJ7grxZjplSSZnOL/WEPtHwlyAyrjzKt9Qi/swxZsUiTNxhzLkW1Z
	 ilYyVu7ymmwKPE4Q9Qxcf+gLcXiHwMGGsFPtTnr4PqENJTYKOoexhB/qaIgT0OmHXFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CDlIj5cn;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF160606A326
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 03:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF160606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CDlIj5cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793676856; x=1825212856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=542XoxkYrTGwr4XYb6PejvvnkDtwoRYMhJuHoaiJH28=;
  b=CDlIj5cnBNOdn3IBy3VW6VZd0liJWjANhfLK3XNgjaNEcFl9qjUNQtiW
   MrzqzVJ9SE7c7ezc6FHyKcUswecYCEvoaofilBsdtiSYXzOfb6mcQtDh0
   boY9F7zUkGVtIJ3FYd2CNpK9LEROuDpi/ioKEv2GC9KZYFenFpZB/nfRU
   VhukHebGhcGJAEC7sTL5qb1bdsXrG73jk1ogB3ANKhEblHhC8yvlgtvqb
   6awMGvAjF8QRylisADEM1ukjRDmBQfUCnDxDKxuVmfcG9bC0OmrKqBvcW
   X1cRZWl7/QuOt/olwSXgrYG7WTJO7zr+abQuW6x64owRTyGco6Mv9A0p6
   A==;
X-CSE-ConnectionGUID: 3VJ8HwAET8ig/eNLkZ/IJw==
X-CSE-MsgGUID: Re1q3E5PSjitqcukjeRgaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2380779"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2380779"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 19:34:16 -0800
X-CSE-ConnectionGUID: NMDZ4cjjS1a3bf0mLYUIkA==
X-CSE-MsgGUID: 5vNC+z7FT4KaU15RpzoLOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6159817"
Received: from junxiao.bj.intel.com ([10.238.152.95])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 19:34:12 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: dev@lankhorst.se,
	junxiao.chang@intel.com
Subject: [PATCH 0/2] drm/xe: drm/xe: Improve real-time performance by limiting stolen memory usage
Date: Wed,  4 Nov 2026 11:27:30 +0800
Message-ID: <20261104032732.30681-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stolen memory access and allocation overhead can introduce latency spikes
and jitter, which negatively impacts real-time performance on PREEMPT_RT
kernels.

To improve real-time determinism, this series minimizes stolen memory usage
when running on an RT-enabled kernel:
1. It bypasses initial plane allocation from stolen memory to avoid hardware
   access latency, falling back to standard allocations.
2. It warns the user if the GSC microcontroller is active (which relies on
   stolen memory) and provides instructions on how to disable it.

Junxiao Chang (2):
  drm/xe/display: Skip initial plane allocation from stolen memory on RT
  drm/xe/gsc: warn about GSC stolen memory usage on RT kernels

 drivers/gpu/drm/xe/display/xe_initial_plane.c | 6 ++++++
 drivers/gpu/drm/xe/xe_gsc.c                   | 5 +++++
 2 files changed, 11 insertions(+)

-- 
2.43.0

