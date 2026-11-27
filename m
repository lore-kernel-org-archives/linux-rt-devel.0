Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787335;
	b=L4kgn3yhpj0mQUpVM2GCx3aiHsznVLEfPYcq0r62XhTfIzpZJowWQHVtR8BYZ7MMKD3r
	 jKTnRlW9LvpPI5AG1piXxZm8GA7Mggw/yypZas5Nv06eLO8tKz98mFcvgAZXwIXZUHSPI
	 rgB5g/dh8+x1w/ZoxhJlVzLUsgbWF4OhvbJnkgUZekHJVmHN44XtUyljeP5EGppb+gZ9k
	 mGxV05nIvCZm5vpAjMtvkvzNdUjslRR2CWkEqlXZYfwAm+Fr9SL+U/TgpN7YaRT8SiA4Z
	 gJnW25UkUCPtT/KnJwOzQtb3v6AWqypdhHIIFre5XceXZ9bfsgZ9pi5Q6F608jBAjCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787335;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uMApDK+8TfYZIJAzU/8/HXKKeBoWrrjUmZ6z7WM2CTM=;
	b=FD/Kk2sU1+1RucAF+dbEynX7/z1Hp+f0IJXY/HsWHa68QyTTQVvaDmomyZjHpjJIeZba
	 I/L8grPMBzK7Hl4OiD3f5Nu6Io7h0XlQu+0OF80nvpbb9Sql6HNcxNPhpZ0G4b5QiU7FP
	 84fIY/YkS7Q3IhtIAQNDEUPCV0ZGz+2yXAv+F0d9AurCC0aLzPVyzd15iz6M8vJcrpDIV
	 sOk3wvGXoZAsIy9ovWtporMzMJMViCTRM3p4AyHtpVGimWPT1ro2UB3Za5EF22Ns0QmE/
	 qGnwzltSRXd1EJVDZtYHlbqtFAYxsUrAPdJ+54Dz1N+0A3AO1Z783wpbEEQkvw8n9Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=qfuog0VW;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2286606A687;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2286606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=qfuog0VW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=uMApDK+8TfYZIJAzU/8/HXKKeBoWrrjUmZ6z7WM2CTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfuog0VW26fc8rISOdpJoy5nxQwIiFTxbjZikj3hNrAkwbfZrVs2dxN0cJyY+uUGV
	 rxzTAxNASrwQAJJOfflxG47VoWUOfJRHTLnVxvxt6tO+0cVZHfdWny3kGZu0eZTs8W
	 aIOP/GsrvlgzX9c+rD6w0kihxGE4ALDvK5h58oCze5i2eDQKzmennIzYlo3QFH5cYF
	 tY/g1mYunv/wZ1iggMVhfV+LWSLgntA8FCr4YqcU9Deo2sjI3SubK4O01wzUdzLi7D
	 0zZrXSWFqHEr34rC2wGHW6Hc1/inktZYjNV/5S+8MUSzANYoYoPvLRrYsPitp2/pRT
	 uQX3dJZzGjJ8w==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWg6Pw2zXPG;
	Fri, 27 Nov 2026 08:48:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 42/43] selftests/sched: Test parameter changes in deadline_bw_test
Date: Fri, 27 Nov 2026 08:48:43 -0500
Message-ID: <20261127134846.114774-15-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234599@kernel.org>
References: <f4340ebcf4ff6e789ad8c5272eb798b3180265d4.1795646915.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234599@kernel.org>
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

> Can measured() probe cg_p before rr_t's 0-lag time at 500ms and report a
> false bandwidth leak?

It could. In v12, reenter_runnable_in_gap() will wait for the 0-lag
time of T before the probe. That is its next period, plus the time to
pay back its overrun.

> Can ob_waiter preempt ob_rival before ob_rival enters SCHED_DEADLINE?

Yes. In v12, the main thread will wait until the rival C (ob_rival) is
a deadline task before it lets W (ob_waiter) run.

Thanks,

Mathieu
