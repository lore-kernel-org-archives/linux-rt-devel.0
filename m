Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582301;
	b=zxf2x9H+9eh9/4KPv67gt+jySw0+fj2Gl9I0kpFdjjDIyFUkULNiMucLpyYkU9Makmtx
	 +aPXEdi3scuHdn0JAw/xQgBRSYVm3PyOq03sKSjOClxtSDYVjNX1/izGhTcfWAd3XB9pJ
	 pLhiZSNymgQ25pJOsRSgsfKnJlfUVR4jMyzWWZU8ZLVOgZFfzDYrc5XDFDKoDqwe7MRZ0
	 Y8A4ojgWSIMtpEcsaREPi9I85I3fMULVKL9hj7CMYoWcsTjHpbKoQWVn7YxEdkxvXlCuS
	 uFhJz/jBrEtspYZuDw5BVUphAjYqr9zllYry5BjU7bjtdm0Av/7BU4VlUXZtiVvMarw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KemPF4UyXFCnRn0FFZM6lfFKM0OQmZfUuPBKXbcJpj4=;
	b=3PB9zX0GwP4RCbKow6fzNSeNf3lECmtHFqPIcKLmg7nSk24m5zwICt+pwKCuuMTaaoBx
	 tb9W5fEIOcDe8CvEnDXS8sVKb8kmO9NC3Ks+8vIiO4yRs8gqnbuwbDxfoAHOx3SM3pYmH
	 tP7maqB33SKbx7dku1RvqLlcnsboqHwtSh8HJEZV9CUccc5tOv9JRsDgD0+epH/A30EG6
	 NFigjjYs0JVBGoO5GAzKPXBchu1VrH4ypUcwlR9mrsDURA7Z5X/twKRKCoMf+q08uXj6y
	 c97VbynTKxJzHlfuNNw65GMMwmNBavFV60MNQTmu9j+yvu8MAKPDVfc+fU4U+OhiQIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yXvbpsmY;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CC606A88B
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690CC606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yXvbpsmY
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490a0e72588so460155f8f.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582300; x=1795187100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KemPF4UyXFCnRn0FFZM6lfFKM0OQmZfUuPBKXbcJpj4=;
        b=yXvbpsmY2M9Qiz67KU7x4Gemm9BspdDnwGIHyB1PHwSCn9D6TCjYwaFg2qlt0K08GW
         iA1tfEozTNqATXO+um5yGUnQmb9av1qRwAvoVI7nGUvx1bC93jv9GbOOynuinmyfkKpF
         jIMyYMmqVjb2bx7FhJnCWzfm95r4OaT2NnFYF+67No0ba25pjBtMmHno8n0UlE/BpDgT
         eAMYlRuy1VC6kb+MWm1SoLSQujrUaIlGjso8MhpNVlAljOQPm7Gi7x3xqrdxMqEEPQym
         NjAqzRkYGFBM6+qjQ5VAj58IaSe1vzJj+XKae7Bz0h2n8h2YMleOS8vt73OIFwhKWiQ7
         P+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582300; x=1795187100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KemPF4UyXFCnRn0FFZM6lfFKM0OQmZfUuPBKXbcJpj4=;
        b=g+Je9oeFnQ8fdllyOh5nUXKkU+iNyWas7/V7qXXwrOkm3CB4592CrsSKMJdIhRaeFy
         lu9pD0p6keg1G6DBZMPejRR7DXAKI+HczDeQyVVCWA5l3nQeuuubmCuZR7pBHIfKGdTq
         t5iiTvkjDCgsA8GQnrbDK3kTUC+MVDDW1Y20+qtWfOWeoGDiyC5xHatTrucKC9VnixEP
         KVWmAtEh0rw9lB9/j/0CmMGz9ARx26e8YncKJBzePVbNTM9T5eHpocX5SmjKcEq52bjQ
         plxtJuwoiniyBji1b7K5F/Vz+vAjGhU21wzttW54ye9K1VYiTTKpCqetbsWueMYlMmyO
         bKRA==
X-Forwarded-Encrypted: i=1; AL+hErHD0suJgP8AGzqkp5sVUI2yuWEc5ED2Wo/bWAA9fzopp7woK/++80E1/Upo1iVtIuNofxKcuZ9FWDvrfgO8LA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/oUowKPFSwzBsfB8BBwZ6HK4RcU491kUymUdqxplan4a5lyvd1
	PQIxHofHrLpk1YXcXc3xmRPYY9fRvUJ2RyTc21BVBPSSQG5BJfZoQqaI
X-Gm-Gg: AYBFou2B2ZunHpNiPy9yi5Sl3CtaevuVH9IeKDlgh9qRMti3pD/J9WsoroEkUfFQ15V
	hrZ7K36yoqGfieb6q7KmJLP+TgH9G2LAdWULniNB1aAVPn9zGFPURv67a+g6E6ZgreQvuA08mmw
	X3YshRBgbqEpTkJFmIiqB/tRej48Iypb+xl8O/t63vIi5M3jCOcg357QPL8VaErBBU1E/fc+dlJ
	FpR/JLU22Icw9/1mWoyhyG492jeVj0i8tD5CbZLHMHglSd/Y0f5sI7281+ec+tMUUZaMWYl49u6
	hBCD8hMYKGn6s9xRbMoIsCU1xgOM6sWBxBjJLNwdnX+35w7UyylQ+ci9XDRQsMDHioH6cDpjDSs
	NXxhNK1IQuFuA2t6uGPixa/+VH/1fXVNur/ldyRqdx7KtpPkgGop5CNOqP6hUf6g02Y5BX1dk4D
	CBd7zx1/8Xl4XCRb2p/FF53YFll39vduA/I7c7cpkaCZBsnr69Bm7AA0yaxTLliLdgHvpHqVOFu
	yqnsYjhAFwB2prwvPeBgsqJl08v6JHBvGXRbPsicGnUaRY4g94OkangmOW7pCKw53o/RQc2CiWH
	7eKa6bgwA8rDZvK6bs5FO9ZvxfMXpgf31UAoTf8Ae/ntFkJPPx/xjtXJtAOrjkFsLi6DbN9bY1p
	9OQ==
X-Received: by 2002:a05:6000:2486:b0:493:5d67:499 with SMTP id ffacd0b85a97d-49c712ac9edmr5552285f8f.14.1794582299355;
        Fri, 13 Nov 2026 07:04:59 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.56.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm6390874f8f.11.2026.11.13.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:04:58 -0800 (PST)
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
Date: Fri, 13 Nov 2026 16:04:36 +0100
Message-ID: <20261113150438.9119-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d58e067d-05ae-4e4d-9d34-b0ac2741b211@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com> <20261108185406.1549770-19-mathieu.desnoyers@efficios.com> <avVk0UU8IRGoo77v@jlelli-thinkpadt14gen4.remote.csb> <d58e067d-05ae-4e4d-9d34-b0ac2741b211@efficios.com>
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

On Fri, Nov 13, 2026 at 08:35:03AM -0500, Mathieu Desnoyers wrote:
> Hi Juri,
>
> > > +/* The caller made room for the deadline bandwidth in the new root domain. */
> > > +#define SCA_DL_BW_RESERVED 0x20
> >
> > Why not 0x10?
>
> No reason. 0x10 is free. The planned next version uses it.

Hi Mathieu,

A heads-up, since both are under review: [1] adds SCA_DL_CHECK as
0x10, so if your next version also takes 0x10 and both get merged,
the result would build with the two flags silently sharing a bit.

Your plan in [2] to change the affinity check and the early exit also
overlaps [1], which moves dl_task_check_affinity() into
__set_cpus_allowed_ptr_locked(), right above that early exit.

I'm happy to rebase [1] on your series, or the other way around,
whichever is easier.

[1] https://lore.kernel.org/20261105164856.29698-1-parri.andrea@gmail.com/
[2] https://lore.kernel.org/94d8d7af-b04f-4c59-ae3b-e693d4457a65@efficios.com/

Thanks,
  Andrea
