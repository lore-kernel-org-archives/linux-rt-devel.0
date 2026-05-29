Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64733E008F
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065104; cv=none; b=IbAaZUXG4NNMZyGmuuSvw+uMu1Ayw6+N3w5i/ELNsduuAZ+GfoAdff5IXTAWoEHhhHmITMADKuOvq75kKykouMw7opu7tX1nT6eqQTXmHJxqy8xeL6DCNkDOrsOafcrPRnvMVqZvzKruJWKjzJ12svjtt3O4UWQxfj+MxrBdgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065104; c=relaxed/simple;
	bh=XIcFOKByaKlp7A36dRzcZgy0gMLVUvtFvUu9QwhQsDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyEzNf3zTn7YPHgAmQD1u7ykG9QWOuEXPlBOEMJtE92IIPM/heNnvgID/+7hiZkECyQnOXh7aqXBl5RjfcGyqOfHbj6kHKABEah0Q2FUajxD5ZGBTTrMhX8YkrfNU8HfJLn/IIJn07OeW4QTIDLMd0mXwijF97D6gLMfhaugyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mm9lGvge; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mm9lGvge"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40596a441;
	Fri, 29 May 2026 22:26:19 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Maarten Lankhorst <dev@lankhorst.se>,
	jani.nikula@linux.intel.com,
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
Date: Fri, 29 May 2026 22:25:56 +0800
Message-Id: <20260529142556.3833775-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529122137.VZtFvQvw@linutronix.de>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn> <20260529074816.k1K16jyy@linutronix.de> <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se> <20260529122137.VZtFvQvw@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7420fd2803a1kunme34de274a313e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR4eVhkeTBhNS0MaSklKSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=mm9lGvgeNttz3NAtznE5f1qkRm9D0UUEThEA9OVg2hrp1oTSq8zU2XQMC/qAy3pnUl10kBsAucyUf0RzDc3zG6ZLOP1VTKvCTbAv1P5dNgFrHveQdhIAatf47XRnXJK9B7/KjQrvRHsAGjBsd+weBz5FOoOyJPFURqGcniXCPSA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=XIcFOKByaKlp7A36dRzcZgy0gMLVUvtFvUu9QwhQsDM=;
	h=date:mime-version:subject:message-id:from;

Thanks Sebastian and Maarten.

I understand this fix is already covered by Maarten's i915 PREEMPT_RT
series and that the series is still pending review.

I'll drop this standalone patch and won't pursue a stable-targeted
version.

This issue was independently found by our static analysis and validated
with a no-device QEMU harness. If the extra analysis or validation
details are useful for the ongoing series, I can share them separately.

Best regards,
Runyu
