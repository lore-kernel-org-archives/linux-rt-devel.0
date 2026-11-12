Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476285;
	b=ipwyDob2ajE9/xNfPf0SdDubkpfMsYdethiAZSbK7QZ0CQ+t6xr1AQ7cWRVr2NFie/Eq
	 kN+k0E6vhiRQwd7XzBdQ22CnI9/XWSHPzm41TF5vcQNrfy39P5mLGnvb63B1WHXwk3dW7
	 l9LBR7xBQa3LORVdYGelqzOmIjib6U2hVYbGLdEIybF52cuGptHdscI342YHVgTqJkyGd
	 ti8cSWV1n4A554Iw/wprNiNFZCo2SHDx7s73lXhIJAoXQYYiU1HfrH14C42zWYNEyPLx7
	 ogFUTJGASYr5wt8HvXys+CQHU5tZkU81nqVuUYsRlzaskIXG1Hzv9iarnJX4BiQRRWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476285;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=2Q2wLBAvQA7zhI3hvi4k1wNI9CYCQNcNSH4dFF1LSMs=;
	b=hDifQ1h4FAtAlqaQ2OZRY7Gw2yhtDpcCvpNwem6rZVOuf0GHgXeXKuNg8r0p61mGDaQ+
	 ReFwlWaBnrL6asdCDi5LwSh8Q/Hu4fQsJ9cz2DX1b1lYd27H4EuOpEszhpfBwaUa6wSyc
	 sMjgZZ/KtuIeNeg0APPxzp5Jy1JDz1wCs8CY2NZ2evY4BO+RlJwwYDtX0vZT1nFt8eF/3
	 9+xs0GBU8X83QDiSDYoj6AqbB5ulXUnfarqcTjcEfdVjtIfw4KVe4EZ+Kt7hhLTS1KwZN
	 pHbB3JBbhiIoeFlUce55dspJh7EoOJEeufAaIBzSlNxqV8bDHXvLgk8Q3QCR7SMdEPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MUz+cl08;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03300606A31C
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 09:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03300606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MUz+cl08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794476284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q2wLBAvQA7zhI3hvi4k1wNI9CYCQNcNSH4dFF1LSMs=;
	b=MUz+cl08ak+OfTibrMm7X6gZQ0AW5YqWpKn5A0JOj3zqrn0Hl3dDc/ewJTok31/vOeIh8N
	v2bwYL/MXLD5OX+hLfacoIcrmZW6U1obqh8qZRVz/B1XD2a/06dYzyMV0TmZ0Zc9ORmTQU
	GXNNdb00bfIxE5XJACUHeazlfu4d5ug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-GHVQSDDRO4WIXcBlPp5PVQ-1; Thu, 12 Nov 2026 04:38:02 -0500
X-MC-Unique: GHVQSDDRO4WIXcBlPp5PVQ-1
X-Mimecast-MFC-AGG-ID: GHVQSDDRO4WIXcBlPp5PVQ_1794476282
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso29728355e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 01:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476281; x=1795081081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Q2wLBAvQA7zhI3hvi4k1wNI9CYCQNcNSH4dFF1LSMs=;
        b=vxQ2/jRHBPdnBAWrRxZSO2fHLfBeowgXRyHKqWjJpGFLOc1fMOUNWR3EgCY87uqg5f
         1FzDCUS0qL+7KP4rFW6G/gdw9Q2pdRw465nKaki0ua88Uem23B9N4enTYn5qVH85IRz+
         va+gC/IpkXNWVA3DaYUkp3lNOnJ5l6GcNekzJ1sAeIWpF1F7SMHe7zos1SLvQ8Q0lmlg
         uHlMSfyzfyddkbOgdNmI+oq6L+fuX+PC7Jvv8KPvhW5FbvbP955dUC3BqMJ763C1SK8u
         Z7w3O53wBFtlsAZfmENODTCx3HD7mJPEfFxHETy9zuXIcCi0gGfF+a6bitRPNZORsWlf
         /qMA==
X-Forwarded-Encrypted: i=1; AL+hErELO5kmk7lRUMFEljXDNA9rc4hinr/l+acY7HyYIHJ+V5ULcPflR7J3+0LEwkk7vaoOrh2XK2q+DffJexCujw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VjkWJEys96zTawAPZSldCW2iHmQ2em37XQxsXOyYEko4vbZgx
	gQji7qvmOTF9py4oP+5mUUw6UDDUWMX/5UI/xlDspTXrX999oid1IaqkuZ+vHKzP5rGEVL9k0we
	XsXqInobS2Ks/YSeCBXo6J2v9oH/e0lyIDtSy3j7IPgSfwsKczW7r/Tq39UXdcEfoMwOD
X-Gm-Gg: AYBFou3bFj10XHEbLOjrS9oataVkzprh+D4CLdFa3xjZQaCj9XvnMISI5EPQfc8L6Zc
	eWTqrlE6EA0Iwhhx7teQT5WSkWMAP726dTz1AQfFIWHgf+iIB7giE7gyvFg69gcoB2vZCPm0GIF
	uZb6a7kBufHEyHpS+aKtB/eduwjmJcdrL/hcdB3L1ZNGrh79JOzQR3tn2rLOnxfF4P0tkxeoO5H
	P3fg/1q0sSyyhcvZ6oD4uV6hNdTw58H0VUPUtqE+CRuiGXb3VR+3lUoR04250AfqUA8tKjqsBQb
	MSrWjk7+gRdlyF3ME+p5WVQb5E0NMtIpoaQtRq2x4MuesroUs0Y3uSNlz8cP/5+C1mxosw/B4pc
	ueauLh+g5JvyfTKiMT4B/jHb891RwhC9eiRcTufnWwYIXoCWKFIK51cmkNy354w95rZ5L7QAu2c
	K4aqk=
X-Received: by 2002:a05:600c:8b31:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4ba0938af50mr81189265e9.25.1794476281627;
        Thu, 12 Nov 2026 01:38:01 -0800 (PST)
X-Received: by 2002:a05:600c:8b31:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4ba0938af50mr81188685e9.25.1794476281207;
        Thu, 12 Nov 2026 01:38:01 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm103301585e9.1.2026.11.12.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:38:00 -0800 (PST)
Date: Thu, 12 Nov 2026 10:37:57 +0100
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
Subject: Re: [PATCH v5 24/29] sched/deadline: Cancel the replenishment timer
 with the parameters
Message-ID: <avWI9aAp46J0ezI6@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-25-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-25-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 39dXsxdNYbDM4ph9jxAqoDJNc5yoBvrsbqwKg53dDvc_1794476282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:54, Mathieu Desnoyers wrote:
> A task that leaves SCHED_DEADLINE has its parameters cleared at its
> 0-lag time. Its replenishment timer can still be armed then. If the
> task comes back and throttles before that timer fires, start_dl_timer()
> does not restart it, since it is queued. The replenishment would then
> come at the period of the reservation the task left. Too early, it would
> give the task runtime it has not earned. Too late, it would delay the
> task by up to a period.
> 
> Commit a649f237db18 ("sched,dl: Fix sched class hopping CBS hole") armed
> the replenishment timer when a task leaves the class. The timer then
> reset the task if it was still out. Commit 209a0cbda7a0
> ("sched/deadline: Improve the tracking of active utilization") moved
> that reset to the inactive timer, at the 0-lag time. Nothing cancels
> the replenishment timer there.
> 
> The timer of a throttled task fires at its next period, which can come
> after the 0-lag time:
> - A task that yielded is throttled with runtime left. Its 0-lag time
>   comes before its deadline.
> - A constrained-deadline task that overran by little reaches its 0-lag
>   time before the end of its period.
> 
> Fix this by cancelling the timer where the parameters are cleared. This
> includes switched_from_dl(), when it releases the bandwidth of a task
> that leaves asleep past its 0-lag time. A constrained task that overran
> as it blocked has the timer armed there too.
> 
> The Sashiko AI review of the first posting of this series found this.
> It has no reproducer.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

