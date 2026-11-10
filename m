Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316744;
	b=4oVgIhwGJCJzVjytBGeU/eER+sitBcNgn6t3/0A1ZglIKoBclpS/h6iyqd7bEyrD1ftX
	 ebyAsP5fwrrgawSmJUY0qDMCw6G4lF/bHjleYxmD8etZWYEmtAzkEMJ0usftQpDK0sgGJ
	 Lcv3d5IGpUnxlqgQwMZb4XiA62bffVfi8IMhB88OcUrNHWQU+D/Ws/QzXGAZi1d/EbdPs
	 DL+78uKV3ma0Riy+PMh0CwQGLryEB7fZb4MDKpXZggXT7pebCPFCq+Zp6L4BEJ+bkfQnV
	 j4vugsjN1lV5RKXrUJb2zJwFbwVAAmTHcVQQlCHDfqHNd2fBLPh5jvorwcGqdjCo3jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316744;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=uCK3DWsW5brHcg2UrNGkrWpwotXCDgVLqXuyjt+/CDE=;
	b=D0pLsEwDrQlX41X/nQR6aAnEZiF+5XJyVUddqxmTy1wRmHeBKxsPnCVXajIxbA2lHUXu
	 WqXFAHXDGas0Jh6SlFGPP/bLeakt/cIv88+AqH3N6nZkNzHP3FbiOZFzj6DVL7rjXm43c
	 zQ1z1Q3tWilE/Ia5Sxkj4+4j0iRaDUZKf6glIndcJM9+y96WdbX75NHGC4pgJaxo3lKnM
	 BHrhZiYsvGo/XD5DxI1ilyMuw3QPQJT84BFkHaKIpIn/FtLlX6ZhzbnYmWnMKyDHLb1Ox
	 ZJN5NEpta5LLITU1FVBxh5PWjys8C1T1vY8URtavJzORfOVqaH2cvx/xKMD2vqk+45g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PiiRYKmz;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D26073B2B
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80D26073B2B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PiiRYKmz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCK3DWsW5brHcg2UrNGkrWpwotXCDgVLqXuyjt+/CDE=;
	b=PiiRYKmz/2psCcUvt/SNJZLa3+r5nyRgEPYY2BFwZHkTmo1c/BWewSmaJNZYKwoBdTgjLN
	eboEomvS+iQaNJfox0X0qDkJEdN+TUJyXnxxq5aVYwmtBFYQ2uqU6SncMVywGZEUCMp1yy
	JvC8ud2HUXjZhHyUh700wxXisFcJA4o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-NJj78KMhPumcqtsRDY0MZA-1; Tue, 10 Nov 2026 08:18:59 -0500
X-MC-Unique: NJj78KMhPumcqtsRDY0MZA-1
X-Mimecast-MFC-AGG-ID: NJj78KMhPumcqtsRDY0MZA_1794316739
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1232242f8f.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 05:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316738; x=1794921538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCK3DWsW5brHcg2UrNGkrWpwotXCDgVLqXuyjt+/CDE=;
        b=NZbQFiDf+n2qOGHsWZydZeKUg+KzcjVLv93kyx5bPs4y681WThGoAYy1PvgfbRB0Cs
         h2sl+vjuUVi32i7BKu4RjGBM9g0xFt8B09eRCjlJbCJ0tliGq4vaiioEeH0735TAd/4r
         4qCPB/F6qZmiHyvpI10oVGeY7Z65wQdG6wce+srciPfdfpwDZQekTq+xcHzPTmK8ht3L
         bwjl1bOKV2TdI3NVKJsB4Gm6+3dE0bx4VUJFTjI3PyeUif/UTQby9DOJxMKgR7QRFDG9
         KQ152VyA/E8L0Ck1CjR33nkeKeiN6Kuq0zRWsFND4kvOmm0hA5nL3WonvqExn32HSW4i
         /nmw==
X-Forwarded-Encrypted: i=1; AL+hErGzh1XbCBp7ohFhXxuS96MCDLsfJVEoHaaDJ8f7iWlsQfZvldHuFG2ZlfFtZm2Mi3X7dfsvzAynnXP1ciXooQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+tz4zPGvSbOACHG3wmT0el/nAr1B+I1hu9kJMb2S1gybpn5mib
	HsDa9Fjyw1Al8IUzKp7w41YmvTDe9FN5vK8Z3qv8O6flNFdFF0p68FzQld8tGQLdb/8PnxZF7J0
	vDQlzlXeXH+QiNjc/DiQmIbEIMVtNkq/Nna4JiFT3V51FpN6ztQ7YjTGZSwsTTkgR3g7e
X-Gm-Gg: AYBFou35t+7+0xaHt+1bH99aVIbXfZiaujV3rCumnb9ML9cps4TtXOOnzeQ6PU/Nx7/
	VEnsYda4/FQSHr19cuJJLreMV2nMX2e8t21wNIzPnM6NJ6Nex4Hji/6n4FLvnxKTH2jhC5l1MvX
	WZAvGt0XSTpTvmvdI79J+W4O5IZK7WCrjtq+EVVQOeJZsZzDziV2p9+SjI5PuuvoyWFpHEOfYig
	RcvGtt287DrugW/jwFaDzZ0TuJigUNFyYVNcGdt9r6SETWph3Ri0+bB/SQnqxiDVyJLBU5GL9g9
	ShZXZ+XPemd/vFTk3me0gBaMXNM1IYURTv1LjhM6jqIfu8EYatCvMYEnE2TVfMqHVgYmJtg7GCD
	1fik4cf4Hj0SAnWWyedA4BMwhXKeE/KR0VVut/RLjWS19MfrTvRGK/hCIUvHKesCs2G8IioyrOK
	h/bwI=
X-Received: by 2002:a05:600c:870e:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4ba0234267amr43353245e9.8.1794316738343;
        Tue, 10 Nov 2026 05:18:58 -0800 (PST)
X-Received: by 2002:a05:600c:870e:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4ba0234267amr43352395e9.8.1794316737684;
        Tue, 10 Nov 2026 05:18:57 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0236f03esm49827465e9.3.2026.11.10.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:18:57 -0800 (PST)
Date: Tue, 10 Nov 2026 14:18:54 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 09/29] sched/deadline: Reset the deadline and the
 runtime with the parameters
Message-ID: <avMZvuEdV8ua36jy@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-10-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-10-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZayYSvkg9eXM9qkSTUw9qWO-RtehoXNBE1SD5Win7N4_1794316739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
> time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
> ("sched/deadline: Improve the tracking of active utilization") moved
> their reset to that time. Before it, the replenishment timer did the
> reset at the deadline. So a task back after the reset found its
> deadline passed, and started a new period. But __dl_clear_params()
> resets neither the deadline nor the runtime.
> 
> Now a task back after its 0-lag time can be enqueued on its old
> deadline and runtime. With runtime left, its 0-lag time comes before
> its deadline. Back before that deadline, it would first spend the runtime
> of the reservation it gave back. Back after it, a constrained task
> would be throttled until its old period ends. "sched/deadline: Do not
> lose a throttled task switched out and back" moves the deadline of a
> throttled task on. This widens the window before the deadline to about
> a period.
> 
> A task with no parameters of its own, boosted by a deadline waiter,
> keeps the donor's deadline and runtime after its deboost. If it then
> enters SCHED_DEADLINE before that deadline, it runs on the donor's
> runtime. On v7.4-rc1, a task of 10ms per 100ms ran 40ms of its first
> period.
> 
> Fix this by resetting the deadline and the runtime in
> __dl_clear_params(), and in switched_from_dl() at the deboost of a task
> with no parameters. The next enqueue then starts a new period.
> 
> The Sashiko AI review found the first case in the second posting of
> this series, and the deboost in the third. The deboost_resets_period
> case of deadline_bw_test, added later in this series, tests the
> deboost.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Nit below, other than that

Acked-by: Juri Lelli <juri.lelli@redhat.com>

>  kernel/sched/deadline.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index cf24d2df6bfc..cc43c5eeae51 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3573,6 +3573,16 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(&p->dl, false);
>  
> +	/*
> +	 * A task with no parameters of its own was boosted into the class.
> +	 * Its deadline and runtime are the donor's. Reset them, so that its
> +	 * next entry into the class starts a new period.
> +	 */
> +	if (!p->dl.dl_runtime) {
> +		p->dl.deadline = 0;
> +		p->dl.runtime = 0;
> +	}
> +
>  	/*
>  	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
>  	 * keep track of that on its cpuset (for correct bandwidth tracking).
> @@ -3999,6 +4009,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)

Think we want to update the comment that comes with this function (as it
now clears also dynamic parameters).

>  	dl_se->dl_bw			= 0;
>  	dl_se->dl_density		= 0;
>  
> +	dl_se->deadline			= 0;
> +	dl_se->runtime			= 0;
> +

Thanks,
Juri

