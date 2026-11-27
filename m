Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787333;
	b=EKzHayM8M4ROFS/yOZ81r7SyzSWaXvJsUJVie4LmEczAuW5G0qXWzRInuugrnsBCTrMT
	 2EqCBokg6T6xUb0RJauJ/N/+t5z1iEzfUGkEoqzGaE9FHcfIqmV93raE67hASH1gc6mM0
	 Bg96JZocZY73z2aj1VKFw1ozQQjH1eOkenpC0Ik1OEglD47tq1NQP+fyJBiJ6Xi4In4Xi
	 1HWkj+i5XTI8t0RyJOIkERfCfmcdqTdVYTfF9mP/YI6rk9VfMlhyHfz961LUfrtSpttxE
	 YDVPEYbAr1FiI1xl6BDJp+HLmduF4+yqP25A4vO3U3p4iCpDYTGfLqjeFjw/dsyoy/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787333;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rz0MNQvL/1oEtaBSiY8Lv9+pQKETRhLj46NxxQM8tlM=;
	b=Uruqik8skbp7bfdRFlvAsWR4+rH71S6odPgRKxZLhhjcjZI3c0SJwQSWfbUuKYLj5MBs
	 /q6rnPuaYDWkrUAhx8PRfj7uAUgga78GDgVOswO+dQwND8DDmTqBb44SoTdiBUUTi+IGR
	 Rcnghw9Yt+VvSvrw1pI+OR9yJ0uQwPVVGoZC/YevqeFCFjQElADZotorMdiQRQNkr1QX2
	 l1GYgnsYGxRoIZiX7392FljNpM4sIHpG/Otb/smkIsJYSXpyyONpYhh+L7pCI50RSzbet
	 bNMqJiNSjW/NC/OckbHssgEG5wKty4/M3OZD+9DIE+Tc7sXOsu5NS7XNws2kxCRqctQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=xOGLaqsg;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123D606A327;
	Fri, 27 Nov 2026 13:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E123D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=xOGLaqsg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787326;
	bh=rz0MNQvL/1oEtaBSiY8Lv9+pQKETRhLj46NxxQM8tlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xOGLaqsgvggC92s77RB75m2eW/HBvK/oW3prjpoNFE0j+xn/rZ/hOUpS2wmlAOzSk
	 5ftdB/nzZZhih/OL1cMPs0hcSbytHL+EaeSZc8FHzNZcCNuHaDCBIvdMdhENXw41k3
	 tkruRP5UYGStbTrHK1dxU9loWjAEm7tACyVEVypGiWjnemkqqhwu9tNqQBUPZO/hU2
	 Qq04LMtpdHSZoHyimTfyFCHjqCpy11yFDkxsOJ8mppUrZHn/SXz4Udi+TYDT/ENEtO
	 jzsS3/tn7LsSXsDxsN1XGeGRvHZImbLAZ+c4brl4S5OySaAESj5O9ASXah95kLXW1G
	 BHxMl6XJoc0Uw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWf2z48zX26;
	Fri, 27 Nov 2026 08:48:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 16/43] sched/deadline: Keep the last CPU a task has in its root domain
Date: Fri, 27 Nov 2026 08:48:30 -0500
Message-ID: <20261127134846.114774-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234566@kernel.org>
References: <8760bd586c67945ac5129fd92e52bdfc2e840c67.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234566@kernel.org>
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

> Should the cgroup v1 loop break on !cpumask_empty(pmask) instead of
> cpumask_intersects(pmask, possible)?

Yes. This needs a task that cannot run on every CPU of its cpuset, as
on arm64 with mismatched 32-bit EL0. cpuset_cpus_allowed_without() then
gives the CPUs of an ancestor, but cgroup v1 leaves the task in its
cpuset. v12 will stop the walk at the nearest ancestor with CPUs left,
as cgroup v1 does in remove_tasks_in_empty_cpuset().

Thanks,

Mathieu
