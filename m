Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584990;
	b=FmAM37dkypfwgh45romgvruSKe7cmBrLraOaeIkhhltqDHisMJmJKvmyQd+iYqHN+T5x
	 AcCGiFISIcU0LKqpZs8qjIyW8TByN3tWObppdwhCD3VUIKT9Rz/eRdsCWPI2CA6RCvxpo
	 kl593BQ6a7zqu74yR5X28UJczkHXyxGCd9VDWkTQ/36NQ+6O/z3Nbv0qTJHL59dGa6tfl
	 jTYtnczcuQRzwITEtWPQ0PsKCDJK3d9mbddWpRB56PAkTUoo8POFDpYrvPSQRewIUFYy0
	 GNPk8csqZJEPKidtRj4Og2I3TuRJGMGAGHPTwAYrqzHW7vZ10bQBV7fcZ7fc+9/uqPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xFCVBlkrizuZWlE0hb6CXLduUGl+Zuu3dMj5O1kjYAw=;
	b=vJtUedXh98WrGODgD1xMBoKeT3Nj5qE/Fo1j1RIdJZ3PNjEaFRqowh0WJIymiglgrsmI
	 sYZv2sEsewazgsfr1PJ+UIysXIhkp1RO/Hqm6TlPEXTkA5HkXNglazCvUR0buGLwbGDER
	 NG9nguHfbbSHqZC4Yr5XHHZo0AkBqxrzk6lbWEIOY7QBjpUj2jYc4AiXLya2fVMYuXBLs
	 ZHzN5iiu8vUoJ0p58M63zvDIZwKwBLV9kZpecuG+othaK0gzj6mBuLIroULVkXcfRVHHy
	 4bKofP4Zo789n7BWYEY+4JN1Xhx1y+oeS3W7YuJxjioBO9b7bRsoZ967oR45sm8zKfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SGdc1Ye8;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CA606A327
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493CA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SGdc1Ye8
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49465892f7bso1163258f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584989; x=1795189789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFCVBlkrizuZWlE0hb6CXLduUGl+Zuu3dMj5O1kjYAw=;
        b=SGdc1Ye8Lzj4qiOnrP9Eofugty8rJxI3mhauv5M8vHnuTaVQqr8qS1nAepGL/m+bTJ
         ttHMWURrd6KKVBsaFIGACrcOBqL1kJdjMUl9r0H4H65zx76RTgFzmsRWyHk0eVMv12T2
         AE0P3T74xJPobKXZp/nx2xNfA8RjwxvEEbfaXe0jIDQiVlQ98XngVQ/LPu5EvK9X3Wlt
         F0PJ2+i4AFVNkSpbGTkNBYn0lp/Tu1UFW043QohTWOIhIS08IFol9plAYegfGV8KKicI
         bfa4XwnKdbU2HkdnYTU/b1qXuGd5Ni6bFlbKvr7VFeKmRpClyEKfzScogSKXWieY2ln/
         v5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584989; x=1795189789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFCVBlkrizuZWlE0hb6CXLduUGl+Zuu3dMj5O1kjYAw=;
        b=idl4fSs24WMX1vM6Svc/kihHuc+5ahfOMARRglUrfNpcJUGEsskDNEJA0CMm5yDQH4
         IM/vvdLWlGkC/YZpihXW9rJ7jOC70vcG8G9xlYDRNLBZErmW2KUxIMo1gdhEXU66FNDf
         SV2QBzJQrUgTHr3/vPHQNOFgFBVMU0PS31Ri9yeSsVF487yqqOKmTbva+fRsg8oz8MIW
         BlFw7u34HCGYUAasNUwJnVl06J8yLIUoi2HIl2LsyqvLw9mCvdIGvjuTWVswyT6VmS62
         z/DstvOHhiuPrc3tTip9CQ5ZCFc6QX0WPh1dqXk3PfcrSP5/b8ZqFx94DZDRbr8EQCue
         WXJA==
X-Forwarded-Encrypted: i=1; AL+hErFFDsOChB5b0BCFJiH0aUvo0RqtnouZSZ86YWX8NZnmfBmSrDx5LXQPYjbrO3RC7kxanE1MFauf0NEJ6kkeng==@lists.linux.dev
X-Gm-Message-State: APuU4Z+w1Rxj7O+ZcOKlZveGAaMF63JoJjw5qVcoOEho30fhfigm+i82
	qtGmENCs2stb0eHc/FLGLGJwALm0Zbvy/1+TtCcWvottYA7/gR+AG1xN
X-Gm-Gg: AYBFou1PEZgqtI+FqTeQU3kDi7hj9rAPiyd+P+L+bcYobS7gXsEqH3zSQj/NE5KhFu2
	EWJvAfJOAyW2yofPEdNj81QFSiboKX5MpOFn8MccHl3LuKThuT1ZwOWnLkRuLquA7YkQN1NzqBp
	PGoojexqKXzbEh2yBdcItRimprh+BnL3fMseP4YYQKNAErAzCW76EXSWLWy3RkZvbKXegWqb7oN
	f2So/7wHE+83oNoQvdSTc481VXBDB5xtB4gFMl41sAvDxJtXYj01Xi3VoInGNppeheWZVOjygyU
	OTeU0foqDxPs/OVHxUtI+whmerr9T0gaeNzPgLQEKTm9xOgMpldWgqa1hmpcu+X0k+Q4jfqAeUC
	g6xXl6mztoH6SfGlEAQCScxLSeTxyoAaVQ6fB0Ew3XujNG2gBbZ4UJ7bxjeGt06NsTUoxJWGzfe
	Y/GUvb9fQgHRI5POGjF+DNRGWxETg7Tm2j4El6ikpih3234zY7BbICoK2q5tEp+j9p+OV/ab26m
	bXgg1G4HUWUBMbelNC1jJqZU4c6zYGhbxBGLKKfdlYnXPBrVVV7hg4yiSGbpZY1EZQR/zlIhXSl
	vgheTNbbef69Ps41vrM2hpMhmA4s7JAmfI2L/OOuZLXOgG2XLM5gXsUek/XkGCq9KT69ia3Za+/
	IVA==
X-Received: by 2002:a05:6000:2084:b0:498:be72:6371 with SMTP id ffacd0b85a97d-49c713aa624mr6770868f8f.21.1794584988524;
        Fri, 13 Nov 2026 07:49:48 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.56.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm6797151f8f.1.2026.11.13.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:49:48 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	will@kernel.org,
	boqun@kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	m.szyprowski@samsung.com,
	kayracizmeci@gmail.com,
	weihengqiuu@gmail.com,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 18/29] sched/deadline: Move a task's bandwidth only where room was made
Date: Fri, 13 Nov 2026 16:49:43 +0100
Message-ID: <20261113154943.14429-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <818f0461-4635-464c-be20-461cd4cd8341@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com> <20261108185406.1549770-19-mathieu.desnoyers@efficios.com> <avVk0UU8IRGoo77v@jlelli-thinkpadt14gen4.remote.csb> <d58e067d-05ae-4e4d-9d34-b0ac2741b211@efficios.com> <20261113150438.9119-1-parri.andrea@gmail.com> <818f0461-4635-464c-be20-461cd4cd8341@efficios.com>
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

On Fri, Nov 13, 2026 at 10:20:16AM -0500, Mathieu Desnoyers wrote:

[...]

> Neither is needed. I propose to carry your patch in the next version,
> unchanged, right before this one. I already carry your cpuset_mutex
> fix that way. I rebase my patches on top of it. Then one series fixes
> the order of the two, and the selftests run on both.
>
> Tell me if you agree, or if you prefer to keep it separate. If your
> patch is picked up on its own first, I rebase on it instead.

Sounds good, thanks.  Please carry it unchanged, with Sebastian's
Reviewed-by [1].

[1] https://lore.kernel.org/20261113153549.Z8XPohWU@linutronix.de/

Thanks,
  Andrea
