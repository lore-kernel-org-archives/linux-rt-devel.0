Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862953;
	b=GggZOi21zZq0OeE3Uos4nriyabiIHYGLUQzMg0BH0InHlLa+xhsmKXFq5VL6wNHeEOBI
	 y2qAhrQwPEkSV+XtOq7yzgYH/qn0Lf2KDXvtuvGMX5Tku73T//ePPeUbBvnvydI0DH7uv
	 kZFWbg6r5/CtLbkZOQe4SlYMQzTS0HnYr56EMnD8SLZlvxOuyqr0IECvNxqqleQ+ZU6Vi
	 AFx6MEYbmQZLQ76aCMMdgDZT3vuBomqhW2gCzUHV0RV2uJDMtAMr0LAQtXHsVEh2hzX3w
	 bVQ9PSKEov9PBdaggfH44gE+oBZWXtq3/m/Urf91kenMAYtuIJtfjA5/D5fJi5qlqPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862953;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=OhNvDsZJpE4KS30+qaZ5e8X21eLLhO3Q56fZ1Ek8d2I=;
	b=l91zY8DMkMzR6U31lFQwfZx2CiXVz5Bmwi2cGbVGaGEVuxgz0Fl/T/1Ao8GtXXSPQG9j
	 gN8EciWREmQSdrFXXb5p9ewRDfazsqmddrM5uso3jU9WtBJQa9rNF+oYxQoUyRZ2s5aN0
	 X+Fut6uT5bvTJ1YcCYTehfkG4fAQX4IGpsV9PZg9ovPKxNGFp+QbRgpmQCP27YrdUdsEf
	 QMgGY5LKEzNMKkeHgekqsOEehI1ZwxYTk/BeTT/eiixju5j9Kou6UE3omTjwnBSLkrbcs
	 Cx21uKsSYY3cHVS+yJ+Ca1HWy3SDETzYlKytdOJ+q/ils1Qw7a+NOyEsopExTPjCJJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpCupRSt;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25583606A326
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 07:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25583606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpCupRSt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793862952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OhNvDsZJpE4KS30+qaZ5e8X21eLLhO3Q56fZ1Ek8d2I=;
	b=UpCupRStGTKdg7B7YlB41BNskmU1W/sNMsDCUS2glDMpU3+XjxxGt8C031tAkmswQZaKbI
	m+waC29h34dcg2+DdVUcPms7xie7OY4yL9GY3II7wfqfoY43Xw9uHoUHocIs2NVXhZTT4Q
	9DWW0vUH777z0EJw5C1cLeH8X4ZlzyE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-rPTB1QSoPkG_GOyNt0816g-1; Thu, 05 Nov 2026 02:15:51 -0500
X-MC-Unique: rPTB1QSoPkG_GOyNt0816g-1
X-Mimecast-MFC-AGG-ID: rPTB1QSoPkG_GOyNt0816g_1793862950
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1fa972b4fso8602015e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 04 Nov 2026 23:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862950; x=1794467750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhNvDsZJpE4KS30+qaZ5e8X21eLLhO3Q56fZ1Ek8d2I=;
        b=JtsQkdOPztqrcMCET9/py7FOVhN6nQxMb1U46TbQavhg/f1Jadko4h3t56fpePVlsR
         haG/Sb2g15zNNJN+waAlxWJQruJnvgnIst1Q143kWWW5Yp+clGUe5PZK+sUwcPPNn9PQ
         kx5vaJB9zpdfmLzIKJcJricoOMDVhqt8PoHMLNqbL3MCIBIrhRFyTfLXK+2E+zAnrIIJ
         /E5q/yvROSEgLGFgT/A4aV+VRQzY2YUupw19XDJWQP3sFJYQuvigOEPNyvZ8wNnRAEaB
         cGgFIr+u78QkSOAYcUqv4gkMaw8P8ChUWj0/BnWHGNyJxcxB1POtj/47mgtZiGOct/i8
         uCTg==
X-Forwarded-Encrypted: i=1; AKwUvBwSUxE+zxlH+4ZZMSWJ4QK03isebi7EbyLYr0JD2Cwoqr4ZNhR3D4NvKV4qr1bVp9MZhBPVklAWHvu1T9JTFQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/K0ZQvaTcJPhRdD3pkycMBY7Taq/K9XW6FJS05kQfyZGssaEIf
	xhU9sgmR3q+xmURu8m9h9lNI4bRY6f1KevEVdcQPpOkV6q4zRMNHlqTruD9K1D+kuGsroRbwwIH
	8uUJ/1Q7p0mWhWUhw3pnwRj2asCk9qPK3Ppq354wnWaj1m0sQDwn7JDkAGCzEELZVz36R
X-Gm-Gg: AYBFou0jokVsIBVXzlzReqohm89+SVPcVyO1boS05p5MDoi9QNMMzz0wfhTodUNYF6w
	wr5vDkkRu7E+QoLXqP74EBN0Z3G4IMLr3Wr9w6+ZZyF80MzVPnIUFb0v7zJwnO4M4FOkD0sQ6gu
	dFgS+dQsbTIfrbDMooqfkHeSgQhjrvAV1750CqGZYIDzlQUST9wDmqNuzhg1HJva0MA/63GpX6/
	QOQDNa4+Avwt8CGhz4Y8awwhHO+gdD8Gcm6zj8WcEMuszpAkynPh92h6DMx+zAD9e1/pwFPU1sS
	LLZ4sWH9xFV+dCRv07eEDXs+t9Q6m/fAzRpKjW8QRNmjk5ZMOF1VRrAI+Y2uXbCkU9xD5RlHBDm
	6t1/d4UqHO01vdg5fhhAta0DX1R3Ur9yEHInh4VHIG6JeiUOhrrMfUYNxam7SCQrWFdv469YoAw
	qwXQ==
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4ac177539f6mr393038845e9.17.1793862949741;
        Wed, 04 Nov 2026 23:15:49 -0800 (PST)
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4ac177539f6mr393038455e9.17.1793862949360;
        Wed, 04 Nov 2026 23:15:49 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e65c8sm42015295e9.12.2026.11.04.23.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 23:15:48 -0800 (PST)
Date: Thu, 5 Nov 2026 08:15:46 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 02/21] sched: Refuse SCHED_FLAG_KEEP_PARAMS that would
 change the policy
Message-ID: <auwtIqa4H4Fqjq6V@jlelli-thinkpadt14gen4.remote.csb>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-3-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104211207.1392343-3-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dmR3tFf1sapfTEz-w9dg_bDPtJsy3fhg9YXCEFjCfBE_1793862950
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 04/11/26 16:11, Mathieu Desnoyers wrote:
> SCHED_FLAG_KEEP_PARAMS keeps the parameters of a task: it skips
> __setscheduler_params(), which is what sets p->policy. A request that
> asks for another policy is then carried out by half, and succeeds:
> SCHED_OTHER to SCHED_BATCH with SCHED_FLAG_KEEP_PARAMS returns 0 and
> leaves the task where it was.
> 
> For SCHED_DEADLINE it costs bandwidth. A task that priority inheritance
> boosted into the deadline class is of that class already, so
> prev_class == next_class and the class check of
> commit 8a70415351ba ("sched: Reject SCHED_FLAG_KEEP_PARAMS when it would
> change scheduling class") lets the request through: sched_dl_overflow()
> admits it and adds
> its bandwidth, which the skipped __setscheduler_params() never gives to
> the task. It keeps SCHED_NORMAL and a dl_bw of 0, so nothing releases
> that bandwidth, and total_bw of the root domain holds it for good.
> 
> Refuse a policy change as well, where the class change was refused
> alone.
> 
> A SCHED_OTHER owner of a PTHREAD_PRIO_INHERIT mutex with a slice of
> 40ms, boosted by a deadline waiter blocked on it, leaves 0.4 of a CPU
> behind at every such call: total_bw 419424 -> 838854 and there to stay,
> in 8-CPU VMs of v7.4-rc1 with the four deadline fixes of sched/urgent,
> and of this series up to here. With this change the call is refused and
> total_bw is as it was. The selftest added later in this series has the
> case, params_keep_boosted.
> 
> Found by the Sashiko AI review of the first posting of this series.
> 
> Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Makes sense to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

