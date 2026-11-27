Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787333;
	b=bux0TDaMhuLz6nI4WEAGNW7Uy4XST2vWYNN1Ca/UArG2896U4dhYHNOuDf4/8p0oXZqP
	 6jS3nLTrRy2vC2P7si/HCPBgnQRxT0t31YvCktnpeKbg4Sag2nyk9oDL6CoP0b50BBiCY
	 Jh1Eo1h4ppIG8RneAim6ShorT4rh/0MKQ9DMxS7kQxbJX6nLI4efLbclEiZ8+9WMfgGZM
	 mCWbDmPUJaOaPpNDA8N6ik365h6A9nWEOK26tGm6Bix15uCiF+GPGnVrNm68RVsbnyQ+Q
	 h/+O//KTihqrgWZnB+ftOkCpGCvkre7UEvojOewQ25CE+RH9sdKwZ6mYI1nMMzm52Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787333;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LWonx9SWofZH7HpXqR71LiMp0otZZf4iBhXMB4Hmx4Q=;
	b=jGML+P68ZOtqqQ4mG1qallkoYFYyR+fUxyvlRPzZfbtlhxtc5FCFrIpc0gb5rSL+7zIv
	 DOFCyCwL8rDbmh98jIgfZdcwR6v0nQrRZ4Y8WRGmmRPSzXFrZTxHIJFi2rQOxiWbN7ihs
	 OCjCpGkszSGtg0ToYU0qbLfnWsdapDrMQVE/Jan9setUOxYtbEsYFSWhkpku+jAzIoQR1
	 puVGO/JxRPht41yz0ybDdWhr3LZtRpV9wdEGJtHPWUHby4kZz1rPkzwB6aSleVEc1yGDn
	 MbEB6CMdnR070/WVOz9R8dXeBS+CH3tnPhG/QGkhklWe5gD7dfNVPbIiWv7/0eos+NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=oxcf85qL;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1149606A324;
	Fri, 27 Nov 2026 13:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1149606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=oxcf85qL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787326;
	bh=LWonx9SWofZH7HpXqR71LiMp0otZZf4iBhXMB4Hmx4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxcf85qLQuX821Vy5nJtWOtrlGxbEPpwNQeE7YjmuCRpI9pgTwdnf1NiN4u4kDCLx
	 SYV1sioc8CgyP9hxJBxB80QTf3ITWew5KI1WLXgwGoCDbJq5HbHKLyGder/fIwkMx6
	 0OV+iHm89aNzXOkHdGVCTSlqEcM/n9lfiDJAVnhrofPZq+YdS07/IfNQNa4RUhg+vq
	 +Onc3wp04t5CFw0fxX7aIIYkNB9ujmbB6leMEjs2z+Uh0GlFC1u7rLbaP2rvuVKBFx
	 J91I0ZQeWTjEwR/H4UgLRB+exAASdZgdo2gm8bObn99fAt/MnsRe+9JGMb5hrppygb
	 rD0fg1ELAe0aQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWf274dzXCN;
	Fri, 27 Nov 2026 08:48:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 15/43] sched/deadline: Keep a task in the root domain that counts its bandwidth
Date: Fri, 27 Nov 2026 08:48:29 -0500
Message-ID: <20261127134846.114774-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234570@kernel.org>
References: <1b7d48df779794ceece2155c0080722932f2c3cd.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234570@kernel.org>
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

> Does this overwrite p->wake_cpu for a sleeping deadline task even when
> its existing p->wake_cpu is still valid in ctx->new_mask and span?

Yes. v12 will keep p->wake_cpu when the new mask still allows it, and
when it is in the root domain that counts the task's bandwidth.

> Does this early return bypass the local NUMA node search in
> select_fallback_rq() for deadline tasks?

Yes. In v12, select_fallback_rq() will first try the CPUs of the root
domain on the node of @cpu, then the whole root domain.

Thanks,

Mathieu
