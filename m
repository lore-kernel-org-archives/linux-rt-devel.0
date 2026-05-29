Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219B344DAB
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068075; cv=none; b=R/ZfhJ0oB5vj8CNlN+yxG7OaJq74YNauzDyLs/FCF5d17pbXtO5dgJ9NQLUNlZDXbkr6H39RXqeaAgc3bDhaxLIGWN7Nj72BtRv0cd1JFdWa5vRTFqeqg0q839ZHtvY1mSS16iw4gEbSqAax5bojm5Ukz1lvlEYUqLW1cgOWic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068075; c=relaxed/simple;
	bh=TsGLVLs0UqIEpbs9UbAyHSjsjYjTd/56i80LcKQ+jVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EemXuNZ9HbBENK/pRFHHSLuVK3lW3lOY7cOaEjEWPMGTUD3mtHeUMC/5RHrP0pSZ8c+UMN3kNJh5rmxOG7JO6Z45givZFti+mehS2F6IyBiA8PfM16l7113ASL0n0BlgQBdiA16+ptwyoza1X9lv8OKnJsfIzlZPoefQcAy+kxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbuwFi0B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbuwFi0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780068073; x=1811604073;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=TsGLVLs0UqIEpbs9UbAyHSjsjYjTd/56i80LcKQ+jVQ=;
  b=VbuwFi0BQyiDmfuNBuD0oadDbEuWs5y0yJiojnEW/5J3okzqcqkdlukn
   wpTBgrTYMK3qGVL4vTIG0eDqRRKu1aJMVmh52HA+QEO4jc4kt4By20vRe
   5XuhhhixaAwodDEWgnk5vP6zfd0m3OlZu4ovKJ/mKQOAfXYKyZhkPRohc
   iPQlIfQXYC966eobXM/+ao5SnFsvZ7o4RvGFB5dDxewO/FHrL+L/bei7/
   s+TFROm84G4BkDSBhmDKqt0lSjH6fbt9sv1mDZo9NIQjv+9RMIEslHGD2
   3cBMBP36FORFgCBa4UKY8jmN7/cW39kQR8SyOPhipL5MAwQNwoH/qSSoR
   w==;
X-CSE-ConnectionGUID: tt3k3CiwTIukCPx62Od6+A==
X-CSE-MsgGUID: FgeVpBy9TOmQTbJuQ5Qk7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="81035963"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81035963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:21:12 -0700
X-CSE-ConnectionGUID: yjLCndB0TiOPSLVQhPEd8w==
X-CSE-MsgGUID: BWtIDHJxRiuXjGi7XkpREQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="273188008"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:21:06 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, Maarten Lankhorst
 <dev@lankhorst.se>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, clrkwllms@kernel.org, rostedt@goodmis.org,
 jerome.anand@intel.com, pierre-louis.bossart@linux.dev, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
In-Reply-To: <20260529142556.3833775-1-runyu.xiao@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
 <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
 <20260529122137.VZtFvQvw@linutronix.de>
 <20260529142556.3833775-1-runyu.xiao@seu.edu.cn>
Date: Fri, 29 May 2026 18:21:03 +0300
Message-ID: <89e4e6258c62e0e2829038dd4f5a29cc530b4344@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 29 May 2026, Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> Thanks Sebastian and Maarten.
>
> I understand this fix is already covered by Maarten's i915 PREEMPT_RT
> series and that the series is still pending review.
>
> I'll drop this standalone patch and won't pursue a stable-targeted
> version.

IMO merging easy to review standalone patches helps make progress while
the more contentious changes are in, well, sort of review limbo.

BR,
Jani.

>
> This issue was independently found by our static analysis and validated
> with a no-device QEMU harness. If the extra analysis or validation
> details are useful for the ongoing series, I can share them separately.
>
> Best regards,
> Runyu

-- 
Jani Nikula, Intel
