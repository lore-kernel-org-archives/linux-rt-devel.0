Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787334;
	b=hltyr0/y2RMApYtjGecY1zZ3zAA9ATZH5gycFUEOizlRU8igaqUkSDpj6krYIjyjTAxN
	 ZrZJgbBAj5JczDqk4MndxNw2V7jBSc+w/dzG8qMRT3uAwtGVzmF7iILdME+vKndgwOCwf
	 wbm4ZYkWBDBz6qsW3SEc6BsjzT+5P8loMwaTd9kAF2AYDu2/LrhbjiSfxs+Jcdm0pMDdd
	 RV5Wvw4BAYtygzwADJWi5F8imUlbTw/pqEWElL+IGhMthx4ncno8YV/nSL1UNMbBDysU9
	 c9lh9evJ821uoHJh5ougdpunVcbNrb0l6MxWG42h9n6NNu8V3rMdLrR+LqxvCnn98yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qzIOS4pabhM2WpxHXsERXfIb8DwXiiYzW+Mp1StwL9I=;
	b=qT93TDihs7p5YoYOppkWTlQR3QTq+bUuTMZyOi3OTrQBnGec6BZQcDU2DrykUubeeOSz
	 wcpQhpfNUC5pEPrQ9UN9x1SguATpHqPODX5Fmf27xeo/MZFYfUqc0EY/s2jCIcrwcG2v8
	 5oiPIyCxEwsw0HbjLlDSfQfq1wdAV7OdDc3YHiT0+b2gqhlgaJUpmjtAgS6qRLMPTPyl0
	 d9oNQ06XrbxFzVDoV8Vk46UCPnzLGAdrUx7vJODLoglj/lYD4yNtMoBZfvKcpA0BNcbfm
	 XsfVK+v2Wrzfg8abSRj0XoAOpUDvhs7MwC8/3ZMORB5gbi+ibJVSzSUen8Fc923xW2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=YxpMIhgf;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3B606A697;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76C3B606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=YxpMIhgf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=qzIOS4pabhM2WpxHXsERXfIb8DwXiiYzW+Mp1StwL9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxpMIhgf66tUp7B/033wbHsUdWWe1ixTwqe1NvAhwM32m9+EmXSFwV3SwmBZL+unI
	 ZgcjRVoq37p3hP1mP4xWCINB+sbWGOANv0wvecBp20JlV19oieYIS0SSJJcsDFBu9p
	 o7AxXEzezv9HWszB4fldfYN6Spfai8lUcBPYH9uv/rbsTSM2xZdEPEwNk0bnHpyDGg
	 Mlnd0u7UGvR3wwgZtTn38jSVjCf8hxDQ8ueDDrKqtWiKZk/lsRRzknODWhsU5PSQB8
	 UknkOpBvJp7BO5KhrprwysH8iKp6fYblPQjJgGyNzg182nbxfsn9hE/eYtBUcptOs9
	 OAaoBIQoEjsJw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWg2MxWzXSC;
	Fri, 27 Nov 2026 08:48:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 32/43] sched/deadline: Start a period for a task requeued onto an rt_mutex
Date: Fri, 27 Nov 2026 08:48:38 -0500
Message-ID: <20261127134846.114774-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234598@kernel.org>
References: <ea269b2ab986ea98f5df5ace2a80c4b4d9d7e55f.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234598@kernel.org>
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

> Can releasing task->pi_lock here before task->pi_blocked_on is set race
> with sched_setattr() or PI boosting on another CPU?

Yes. v12 will also call dl_proxy_block() in task_blocks_on_rt_mutex(),
under the pi_lock of the task, for a task that is not current.

> Does the uncontended FUTEX_CMP_REQUEUE_PI fast path in
> futex_proxy_trylock_atomic() also need to call dl_proxy_block() on the
> new owner?

No. From patch 38 on, dl_waiter_boosts() decides the boost. Until the
new owner wakes up, it compares the waiter with now + dl_deadline if
the owner's deadline is 0 or has passed. That is the deadline the
owner's wakeup gives it. What remains is an owner whose deadline is
ahead, but whose runtime would overflow it at the wakeup. It can miss
a boost, as on v7.4-rc2.

> When a boosted sleeping task has dl_se->deadline == 0 and
> dl_se->dl_runtime > 0, does replenish_dl_new_period() here record
> own_deadline = 0 via dl_note_donor_refill()?

Yes, as on patch 28. dl_end_held_boost() puts that deadline of 0 back
only in the first dl_period after boot. Later, it starts a period of
the task's own instead. In v12, dl_note_donor_refill() will hold no
boost for a deadline of 0: see my reply on patch 28.

> Should the boosted branch in dl_proxy_block() also check
> dl_entity_overflow(dl_se, rq_clock(rq)) as update_dl_entity() does?

Yes. v12 will add the overflow check to the boosted branch.

Thanks,

Mathieu
