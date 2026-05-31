Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C43446CB
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241312; cv=none; b=rWE8P57ei0Tw+7IuT0i3tf2cyKnNJnfhCOFi9+e+/cvlKrd0cOvWLi5t8+gOrXDKXVmMNuO0IClFvXl2+vjrCpA0JOOFmKGGCF5vVKojs2sBXd2lA8LijqhKUtrzsEpZHO0DZ1QWNzgvDS8F2F0swUoF+Vys6Omg8Pj0gnarlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241312; c=relaxed/simple;
	bh=MfgaZITVjf+xSp/VVqdccCnPFjcq7/aWQ93a8bo464M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwCpBkRUadxC+Difmf0K7TWj2F3waj2R/4Psv8oSglTcCq497RREfUFLw3SzixtZX05aWkNGEnT1wGplmzMlm8upLY3TvD0+mvumyRmna/sKEdDEyfdBfTgpSnuQg/OfNcCgw+zwz5EAWZP9tA93A5qnDEXiumBsW7/jUYe4kSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=nw5t7x6/; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nw5t7x6/"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4079b061e;
	Sun, 31 May 2026 23:23:16 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Maarten Lankhorst <dev@lankhorst.se>,
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
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE audio irq
Date: Sun, 31 May 2026 23:23:07 +0800
Message-Id: <20260531152307.1283430-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <89e4e6258c62e0e2829038dd4f5a29cc530b4344@intel.com>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn> <20260529074816.k1K16jyy@linutronix.de> <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se> <20260529122137.VZtFvQvw@linutronix.de> <20260529142556.3833775-1-runyu.xiao@seu.edu.cn> <89e4e6258c62e0e2829038dd4f5a29cc530b4344@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7ea1d80c03a1kunmeba3563a10bb70
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx0ZVhkZQkwdTEkYGhkZGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=nw5t7x6/l8f6HAlZDcLLGMPbptweip4K4qDJP30Pu+gaL/IYyMv7uZnRnT8dWa3y/eTVDhBc5tCzQaK9o5Ktw+68G+u8WFurCa27xJjheQnYNetk/kZUXjJ5dw1i6vcdfTkRSoS/Py5/41rpG/sVcrcNkTDe2VLpLyq2oAUqE0c=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=MfgaZITVjf+xSp/VVqdccCnPFjcq7/aWQ93a8bo464M=;
	h=date:mime-version:subject:message-id:from;

Thanks, Jani.

That makes sense. I'll keep this as a standalone patch and respin it
without the stable tag.

Maarten, I understand the same fix is also present in your PREEMPT_RT
series. If you think it would be helpful, I can add a Link: tag to that
series in the next revision to make the overlap explicit.

Best regards,
Runyu
