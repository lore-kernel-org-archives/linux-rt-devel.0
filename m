Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467033;
	b=YL5wZ5/cv+pgJ0Z/W6Ky2lXTDuuPtz9v1y9Gt9OaRZBjs7h2DtqLRuvZY1rnRjMj6x8i
	 qQV8ShksvHtd17tyHguIm64KvJy2WvzxPaEXgRqsb/0fhM4sbgte7dN1Q5LDcCRw00cMX
	 Vl8PDOIqzFUd0SvGyXfI8gcgXhy5ISTB7l6PzUHm+QAVCckJtOOxYDcdm3tu5KmlNoruw
	 z6NZHVPir1W/X8HfN2npjz3PiBKaTyuyc+n+idxqlZgFERm15lJ2i1aWz6/7Laq2KKDqJ
	 qJHVI/o0Af3CirivxXVl0DaoC1VZspgAOnRS325Cjf0Hadh2DSf/7ASekQhvqfY0qSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467033;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=MzKSTO8LvpR1kk43PP3scsPYLloAVo4g9q+JhIcdw+g=;
	b=5g/fDlKm8oGK+dBE6JcrxIdOe0JufKc4aurvKAjwLP1ZWtnqEMoy7zawL7oOqSc90ljx
	 Htdcm6j8Cb1WcrD4CXWhBYtqTBrz5MiN3Zgf+DCmk3jQ/cUOwWHTwvNV8H+0CcoPJKG3J
	 FZ3cOAuONKNYL9rRmu4aCWtyvX8KI8BUVUx/EBVn83hvTO98XLQooEU3i22hNXIZBB8eW
	 HfmPUcskni2GMt3WhVjiQiSGbGkOG/xRgLJxk6hYJuWkPjvJF/DEF79xEOXIoU7SN03fa
	 FgPRSDRjwv0V5Lzverq5UNzChFtXZdEue5P9ebzVOEyeY245LnoC1x3YlVcRT+Ts/0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UU4sr+KE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAF606A32A
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 07:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCAF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UU4sr+KE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794467032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MzKSTO8LvpR1kk43PP3scsPYLloAVo4g9q+JhIcdw+g=;
	b=UU4sr+KEXLWG/VMn1tojphdaL3NHxohGi1XR7H6d1DZnX2DZ/Dmoe4EXaCaFOPROeVmBuD
	2Bfbh3HCYBFXXQFQrUCiXcYUeVnOSG812IacDyGUJsnzLOreHMjOSegjGGe6KiHolligtl
	OeRD6FxIHNmw1C/SrndI+EtsqjnDOk8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-WsPCR3pYPKGQHM-ASvBhvg-1; Thu, 12 Nov 2026 02:03:50 -0500
X-MC-Unique: WsPCR3pYPKGQHM-ASvBhvg-1
X-Mimecast-MFC-AGG-ID: WsPCR3pYPKGQHM-ASvBhvg_1794467030
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ba01393800so21913125e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 23:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467029; x=1795071829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzKSTO8LvpR1kk43PP3scsPYLloAVo4g9q+JhIcdw+g=;
        b=APo9poDrlxfBRMxl7pOy0b12TovwKh+ZF3KNl5I01O3SWfaGYPqKINtFSO0YRIk7LA
         wN7NxbJWo1EJQzWwK6elqbBqSkADC23hgw56M7QvdAKKFrCXffwKhl/b+3Do3bk0osd+
         rmEp230R04ZEafo2XD9cpOfL7XGjZwjPodEa0pOt/svK+L56r3GdjBKpz0n21qZEC7Q+
         cFqKgaA9Vfa58/AdXjVHM6AiUYxgeufOCp0KwlJo3gtx6XoaO3rUdpB9YhEq+SUEVP75
         gSt63fcpO1gMCG3IgXzW7w1eKUz4agjh9yRWL0DC0RX+b0ceNRzZfE/Pekfo0aRGvpiG
         kn/w==
X-Forwarded-Encrypted: i=1; AL+hErEAgj1I5lnSSa83inuQo8M9Wx2wGvN2cV72Y/7BCq2YtLhvIQWZEeMQX14jDRUCwXBNGt0551ynbvKlGCXcIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9YOqBEQKf9tuFxue5JOxeQSkOhqwzr/DQ32yTFP8hzGZ//LAwB
	leNml8Aq816G5dsRuG6zqSnvCDocI17GQEh6kdYOmKH6uUdJq3uGG4K20mL7yS/Szu6TNsD8haa
	54xm87S3nzdWigFEiUG4TMvXw4EF/OTYy5iERK/Yq5iMq+jiMhdo3JmJQd7AdQGza5waT
X-Gm-Gg: AYBFou1GNe4/B5gBmA5e4K7HR9ZuToN/0S8C/VN2mnPbv1BdUUXDCcjWEMxBeE/hUqg
	+oWQ2TEWYLV84UoN3K805sSPj6Xgg8uEqOdZPeq+/D7EVC2iOuYbjZkWHQVGTkqKsB3fgLR1qWm
	L4E1/mcRiXqEeoEzjCRfXEp5+6as9aGeJa5jUzlIgC+NQIY5QMpgKEyC0zjXhINN9WoK31vi0ll
	UoTY/KQafM1TreaDEDDBPDIuNfR6Le0FhceG6yg2DwlB8ajW8ayQEqF+sBPhtczvjXmpg9Gzq6u
	eCi93Sdgt3nXBBxBEqROj+1MnK1unM92ZwWEPsT2YJxcGGPvZVk12H/yBvVxeWnAGZXqkgYbOmS
	VpbO2r0LQ7fUuGAvwJVBvlUdOnaru6tGEeNnFgpGqlwjYGJlm6+fP7pgKDBiRO8D8FPBZZlFw5u
	g5QY8=
X-Received: by 2002:a05:600c:46c5:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ba093ab88emr83497375e9.32.1794467029368;
        Wed, 11 Nov 2026 23:03:49 -0800 (PST)
X-Received: by 2002:a05:600c:46c5:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ba093ab88emr83497045e9.32.1794467028991;
        Wed, 11 Nov 2026 23:03:48 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a495csm14952955f8f.55.2026.11.11.23.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:03:48 -0800 (PST)
Date: Thu, 12 Nov 2026 08:03:45 +0100
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
Subject: Re: [PATCH v5 18/29] sched/deadline: Move a task's bandwidth only
 where room was made
Message-ID: <avVk0UU8IRGoo77v@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4bM-GvSugOIybRqawDtMddPD8nit1yKkVCS98knX3tw_1794467030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> Commit 7f51412a415d ("sched/deadline: Fix bandwidth check/update when
> migrating tasks between exclusive cpusets") moves a deadline task's
> bandwidth in two halves. cpuset_can_attach() reserves it in the
> destination root domain. set_cpus_allowed_dl() then frees it in the
> source, when the task's affinity changes. Its comment relies on the
> first half: "We already made space for us in the destination domain".
> 
> But set_cpus_allowed_dl() runs on every change of affinity. It frees
> the bandwidth whenever the new mask leaves the task's root domain, with
> or without a reservation. sched_setaffinity() gets there too, if the
> task's cpuset spans two root domains. With admission control on,
> __sched_setaffinity() refuses such a mask. With sched_rt_runtime_us
> at -1, nothing refuses it. The bandwidth then moves with no room made,
> and no root domain counts it any more. The destination would underflow
> when the task leaves.
> 
> Fix this by flagging the affinity changes that come with a reservation,
> as SCA_DL_BW_RESERVED. cpuset_attach_task() sets it, through the new
> set_cpus_allowed_bw_reserved(). set_cpus_allowed_dl() moves the
> bandwidth only with the flag. Without it, the bandwidth stays where it
> is counted, until the next rebuild of the accounting counts it anew.
> 
> The attach still flags a task that became a deadline task after
> cpuset_can_attach(), with nothing reserved for it. "cgroup/cpuset: Give
> back the bandwidth an attach did not move" fixes that.
> 
> Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

...

> @@ -2957,6 +2957,8 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
>  #define SCA_MIGRATE_DISABLE	0x02
>  #define SCA_MIGRATE_ENABLE	0x04
>  #define SCA_USER		0x08
> +/* The caller made room for the deadline bandwidth in the new root domain. */
> +#define SCA_DL_BW_RESERVED	0x20

Why not 0x10?

Also, nit, the comment looks off compared to the other flags w/o
comments. But maybe they just need to gain comments (I keep forgetting
what SCA stands for - Set CPUs Allowed, maybe? :).

Thanks,
Juri

