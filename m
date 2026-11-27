Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787333;
	b=o3PnD74KD8iQw9N/CWKtx2I0PFVVAkqWWxF/pvlA2U8InnONhX3v0rtYCPtwJlxT+HGJ
	 1bDotYNa9aGRKNZwRlufb/rPdtij+zcLppNxRAJ8Ph7wdNsiRA9+EP+jibPeSqQTxCloL
	 5FCnTtYHiccY+bBGZCoqGNlTJdqhaqCFfJB2owpSI7MsiE57R5bu5LZc0eoyyMZQDxqSw
	 RoUxLfxSua76plkWxjgi8qusnbqmPk9GrHWClk6ArsqG5VFwBtEN+mNjF0haOb65Us3SM
	 LiD9du829N12pCtWNHKB0L8v3Kl+iAaptaTOw1HZDxJYsJd4kfKMNNvMF94T3NuNa8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787333;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V/uEc4jL47bkiTzd7MGgfkd9ue145VA2nGSH2bL9Yog=;
	b=HSUt6T7w0WD7wrvUPo/9DQKBopv36vU67qA3DmzfKSKwzTCHPx+XUxRQ0g1lrXH42et3
	 fEwJo17D7XuMjoYOTChzllH/SRnjBGUzjkkc6nQLtcS0x+/rqhFgXxlghRkUEdA50GHXY
	 vtQH4ucI1xc0kNINOxUo5g7jJlPmQ8N5WcozikUSOAYnD7juNxNudE8KpeC7eYz46upkt
	 F1lYmlKIVCWBuzPSvP7UGnFARF8+c4aty3XvXRyDVVDGEEvAMZbtTlDsh+oWAwMQdxz56
	 5KQCPeO3CTDPxoi5ZZ0/FIn1hbT2j4CO62PPvTCN0E8L0yccIv5zQDF7VFwAwMwXMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ROFeXxvy;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1171606A326;
	Fri, 27 Nov 2026 13:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1171606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ROFeXxvy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787326;
	bh=V/uEc4jL47bkiTzd7MGgfkd9ue145VA2nGSH2bL9Yog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROFeXxvybAe3jEWLV6FqMC2LdifLlt5ZFXcKujaiDyN6feejz/R8+UlHm+butuhJ7
	 LvIilcf7mofGy4v+LCjN7l1W2F+1DAnp64nfeDrF2vUxi2AWIrh5Feb3H010/yqkjO
	 Sle8oYgQYVNSc7hZ7wIcofC0ASpzIbVtDkRMgU7uoUXXMUMVZkGbLAllO6Gs9nPsV3
	 bfcfgLWNHTh9PDJ/zhmdj5UW5WN4Hd9a7cJ4ijwCWh/bDWmTEwAY5PyqieScHB+ByQ
	 /HtQDHqCb4Je4g51RXzBvoClVM1v31en85ckWgCzxo9gRhkpU37xUxLVzwJ/i7fu2A
	 PBFwfBYvMwxWw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWf3p0wzXFQ;
	Fri, 27 Nov 2026 08:48:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 17/43] cgroup/cpuset: Refuse to take a deadline task out of its root domain
Date: Fri, 27 Nov 2026 08:48:31 -0500
Message-ID: <20261127134846.114774-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234578@kernel.org>
References: <2a3cf1f221564450a14f75f0f4eeebc3379a992e.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234578@kernel.org>
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

> Should pending also be populated when root->partition_root_state is
> PRS_ISOLATED (or via is_partition_valid(root))?

Yes. v12 will count the CPUs of an isolated partition root as pending
too. This alone would not cover your example, though. The second loop
checks the cpusets of @part, the child that the write makes a
partition root, and v11 passes NULL there. In v12, that loop will pass
the same pending CPUs when the root is isolated. The valid children of
an isolated root are isolated too, so the rebuild also gives their
CPUs to the default root domain. The v11 cover listed this as a known
limit. The v12 cover will drop it.

> Does dl_tasks_keep_without() (and dl_tasks_keep_root_domain() below) walk
> the cpuset hierarchy and iterate every task in affected cpusets even when
> no deadline tasks hold bandwidth or admission control is disabled?

It does walk them. In v12, dl_tasks_keep_cpus() will skip the walk of
the tasks when no task holds a deadline bandwidth, or without admission
control. dl_task_keeps_root_domain() accepts any mask then. The walk of the
cpusets stays. Each cpuset costs a mask computation.

Thanks,

Mathieu
