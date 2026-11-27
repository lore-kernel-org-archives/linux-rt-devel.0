Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787334;
	b=1u0uZzdAQWkripAAd7aapfSikPjipa/p9LXAqRdNVJ3HFrX/2NXcA/jgIciMvHZyKS3L
	 WQmnp7We1ag8i2PBxm8OnATn6a8cC0WXEYwADlGLZ+84DNlAAsAThsA+CKheAu0AWkENm
	 yVu6hkNhk10I88mbcTO6PyWRhEzglTPr8bO79CyNEjd/uzLFQihORtPQdQl9fIJd1N6hr
	 qHAnup4UvCF1pUulZS3aqZ8Hd/wZ7C1UaGHXYRS3TpH81ZPan9o05agVRQB/d7XSbLEJe
	 eiHI3uqzS8/ZgXS2LXfTAkky5UmX+WEAanQ1vb72aR33pMxYEZrm1BUHWSjxH0i8Wow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cbLZTPIacK3smXFxZhajgu1f3k6mRrMLoG/5fwHTDvg=;
	b=D5GvB1EL00AWzaojh+/ckc0yYkHaNlWwlXaXkmj0rNus5kk3Ky9tsu4FBIwjfo4LVCwY
	 Tt/senmu6BbXFrnD20Y17678wGNEIcUOkt7tmbwF/lI6Co2DvZIb+8W6AkNnPnUAoWwf8
	 QoBRJZkCcxPvCdL9+1KNq6zIOoCNs5wctbhN6uONcYL67RK0vwHfEoaC7ilpNhkplllUh
	 asp+IehzTanWqCMCA/ugEMePKrG6xISJpHTuGruJhDtaTmwTRdeEaaWz/33o+dlJl5pzh
	 eZXnKnrVhWNiCwgiDYSXdfqUmVMQ/dFyi7HKtga3CAjCfyGDDUTXkzuQaDDig2QC6sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Kihlko2H;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC4606A68F;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75DC4606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Kihlko2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=cbLZTPIacK3smXFxZhajgu1f3k6mRrMLoG/5fwHTDvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kihlko2HHsvjmX9ONlEa7gLoKIAy5HjzI9Laea3xZHkY5MF7WxR1cqCqpowsOmPyR
	 2hxuS41sQ6lDo6MkcBcWq5ifCX1cwNCw0pw7RZdFvA61D0AgV4eQzsf4HGy7n0s1Vb
	 nxQQPnZE9IQ0+BkP/Mtjo8kg24fiMqsV5jMDLNj+5nSZCqsGmT7EaWKTMBomS6QObU
	 FFQhoAAjUYHoWj968sjpeXfLrxHWWmSv7Oc7fZj6XxmRj0W2iOGj3AH4IJeI11yPas
	 0Iqztj7Gq1/xt94PEZclFDT4Ap7+EhhiIbXKJwczdZGzcIdpBSXVFq4cBORa0Ng27Q
	 6Ui7SOFMkgaMw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWg0nB2zXP9;
	Fri, 27 Nov 2026 08:48:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 30/43] sched/deadline: Start a period for a task that enters the class blocked
Date: Fri, 27 Nov 2026 08:48:36 -0500
Message-ID: <20261127134846.114774-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234590@kernel.org>
References: <f878da91a2dcaec14aaf959a83659c166a98ad05.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234590@kernel.org>
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

> Can dl_boost_blocked() leave an expired p->dl.deadline in place when a
> blocked task still has a non-zero dl_se->dl_deadline?

Yes, as on v7.4-rc2. This patch starts a period only for a blocked
task with no parameters of its own. A task that left the class keeps
its parameters. So its passed deadline stays in its waiter node, which
then sorts first. The cover lists this case with the known limits: "a
task that comes back to the class while it waits".

> Does switched_to_dl() skip replenish_dl_new_period() when a task with
> p->dl.deadline == 0 enters SCHED_DEADLINE with a constrained reservation
> while blocked on an rt_mutex?

Yes for the deadline of 0, in the first dl_period after boot. Patch 37
replaces this test with dl_in_constrained_gap(), and v12 will test for
a deadline of 0 there. Patch 37 also fits the period to the new
parameters at the change. So from patch 37 on, the test no longer mixes
old and new parameters.

> Does the !p->dl.dl_throttled check in switched_to_dl() also prevent a
> throttled departed task from receiving a donor period when it is boosted
> back into SCHED_DEADLINE?

This is the limit of your first point: the waiter sorts with its passed
deadline. The task does not run early. Its wakeup lifts the throttle,
and starts a period of the donor, as on v7.4-rc2.

Thanks,

Mathieu
