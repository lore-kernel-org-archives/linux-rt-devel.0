Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787334;
	b=HR67/D0cSvYdO/A/IymFDHF963F3JQdsiX4J11PZ6tlmbi50SE0/HTfp8iAuEFPrK1Ln
	 q8byv2xYeNetASkgxWT0krlYoSnYVmvNBl9KsdV9imnzcweLe2og7YwLwy2XD1pcV9zfz
	 1f2KI3Il9LQzm2mQIThGtfT8HhEN1VRdTV0erPxLXJfELvrXH0GKrXn+/0tk0s1r1tO/9
	 h2Ko1GjDHZ5fepOXtM2n+qcNFbGYqBNS2qXiWRQvmzN1pI8nYp+YMl10664zfaDNhjnzq
	 4CD65/mDwXS2savwTtlAU7KuLvsNx99Qxkj/If2Wv3lrW0Dgq4IU8NKtTFJxJH6wOHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TA9o1HaPGYQ9hk9TwiWiYgRLrZATc1mGRJzf2NZUV5o=;
	b=JD+Tx+Y93yw5/cwr6ot471lew8MDX4Pz+5ORBHX61iy5zbkPVMl+5KFa9Icfq3W9EGHA
	 tr+sN2QSMXa5RNjxJ3CvfnKV5KlWe0FdcWVc6tjrc/qJu8k7msXL6favhACybcAUjV82G
	 1Rj2qsFzdjpBwQGUlTvAbiaGq3NVD/1HBSMykf9YlA3y0JS0Jho/sA8PrYjWu2yJ3h2bl
	 6+9zkUkJsawU/A0zafmXSFiE7zB0gP02hOjo+RWtVsaj3aRJl2NrmzFj8ohxvT5P6dyN7
	 Wz6zWf4GlQpv7hdMOqIUFHetGlpkAQFqB+Cn9Cb2ou1NW14HHIzQE/rAn6zMo9Vzu1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=CJ+hBH+m;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40279606A687;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40279606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=CJ+hBH+m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=TA9o1HaPGYQ9hk9TwiWiYgRLrZATc1mGRJzf2NZUV5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJ+hBH+mdPVov1otsLnvz2ufqSYxcYharsrZccdh7+Zr0fxf26/de/6Qwvi8BzD2m
	 XlgRy6cdmIgJrdZU2U8cDfmfheinKnY891SLHaXfW+VNoaQgMXZeM/yPp5TMq/13Mu
	 nXdJMrRr9JpMuEm6/6tCPDR300gjT6qsHJBvMeVyfsBzkHq7FLLeLWUpOHrZy1TUVx
	 GSmVD1zDv2RJIuVk9uAetxi6AWl6POqcrlXz/DshwBirG6q5gna9tQmczHTrav86VC
	 E1QF3hnB73R8u+mmCHNxh1Lbcac6U9/q1Xo4opwPpB/zft+LlHac3VXwLfEIcw7b50
	 nJWpAaIQu/VZQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWg3DsBzXSD;
	Fri, 27 Nov 2026 08:48:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 34/43] sched/deadline: Cancel the replenishment timer with the parameters
Date: Fri, 27 Nov 2026 08:48:39 -0500
Message-ID: <20261127134846.114774-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234583@kernel.org>
References: <85ae6bb1ce221469c21c31a352a703aceed394ed.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234583@kernel.org>
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

> Can dl_task_timer() fire before inactive_task_timer() at
> dl_next_period(dl_se) for a departed constrained-deadline task, pushing
> its bandwidth release and parameter reset out by an extra period?

Yes. This is the same as on patch 26, and it errs on the safe side:
see my reply there.

Thanks,

Mathieu
