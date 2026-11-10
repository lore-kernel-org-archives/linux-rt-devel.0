Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309289;
	b=1NmqH/IKtJgHJt+uOxu9GzUgNi3N3kOeDQcmrHW/2dxMDfTtJjONXEpH9xgcjIpRuWcB
	 +Ks0Nm9OZ+Iq/1AODzLw/evC2nh9694wgFDKx7vnUZ0EbUESUl3bqFFEiy3gMHdfSZnlC
	 wpJMxnjxT52HMSWwcRuQXymEoqRUjkXsM/XjVHJ8snLZgen9lUP7AKCZ3fMO8g9xMkjUr
	 7zZtmASrfqSxwuL8bP6RcwPEnrc4Tw8IIdfFpkU8m31+scrv4DQw0tz5g4qc3S8oanAFz
	 APs0CuDkRi0ub4Av0NOnfiRCoz5ZE+DGjbhQpVXVJnuw6R9VPsGkj9XCrBdOISvcfAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309289;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=qOR1to8DwDNMHvVPWKTNupvvaYNTxEjClRGA3vc5Xw0=;
	b=d6cC6OsEqDYn4m0WTH+ahiWaLvUZSRqCW2w1PSx4jnZHyNe+Y85HGJdNmwA4IJrB9Uqu
	 +XJ41QoU5wS3v9lKEU4Hc7in6CrUOVIo0wg5C7TyYfX2B1rhoShweA3oXz8+ZZ11Kn44w
	 izTqe9aa0EwGMF0QgcPVGKFHcYB4JyY23XvgJ/2rNMrI9gU87xzjIk8DZHfY1bOTamN7+
	 etBMhzpDOHdIdXByYYX93cwmJNY8NOqv1NejndE78GJoN7/DBkuJjYqwFWSyepAUoSHny
	 wXCK1R2Z3QXbNlxBKG+KsrufFiIhNerXSWQlcRuDAfpWys5g2a4XZS2/gzv/YzHNajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDpn1RwU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109E606A321
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 11:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E109E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDpn1RwU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794309287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOR1to8DwDNMHvVPWKTNupvvaYNTxEjClRGA3vc5Xw0=;
	b=YDpn1RwUdLQlgZduobbPDr9/9saVl0zxovoMLB80YFqlAGY9A48iB3H4qQF0aemfsxVKsS
	EGtnRxwNtt4xzYR4PmUlvEYMhxZdgEPCl++QCjMEANzgMrh/86/YK0xXdtT3+gl4VjS5GV
	I3eMZlTwAtkVIBL6DYcAzLJBn5xv9yg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-3y92gyQAN1KOzbMlLRCbmw-1; Tue, 10 Nov 2026 06:14:46 -0500
X-MC-Unique: 3y92gyQAN1KOzbMlLRCbmw-1
X-Mimecast-MFC-AGG-ID: 3y92gyQAN1KOzbMlLRCbmw_1794309285
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4916d47eeb5so1560566f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 03:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309285; x=1794914085;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOR1to8DwDNMHvVPWKTNupvvaYNTxEjClRGA3vc5Xw0=;
        b=GnOqkJ1jnLwkB7i/ZUBO3ZOrWBTm49vOI81ZOB6MPPyVrpxcSlYhECK8dSec5vKeve
         f3nfRb1sMOZOMxB/Zjb8sxPY5OpR3kugEyxVeb2myl2KUc2TWCuqYlDjC5jS16S0XjQ5
         Tq0MvR8ciiFz+mJ/J+K9u9rzgKzfKD1ko9AGiXUAaPt82r0l+BP7G6OMWcIOYiKzLeT0
         hwq6UEN4eogbJG3VgJNpOu69SATEKzG9pIBKeXv9MRUMD+jgCEDRddSTwwRHI+iteGMv
         UfR50u454sb6rvpKFxh3sdtqIqCSy3R1uj3rChqCUs8x0gOUoj8EjjgqX/HdskGnWsu+
         dyBQ==
X-Forwarded-Encrypted: i=1; AL+hErEzA3Ypu2HIzdRb/cBx75oZ1rul3dc/lqvqZrriIWIDOjDwsWezoGkfwTeNZgvi5nrtKSSj/tPEfiIJCY3+JQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9oBWsPMBpxhh5MtqQ02PQKHOUX5WIoNg1aX0sRI4RsSl1nOead
	VIGEm1GidgRZGtwbRLHeSwN5K3goTJ/S1fiAtU5rN34FrocP42K1S9BFfEaHw5ONYxFPWffgn4v
	CFJtyzRKyia1q0vEylPx2euM2TFBdpcl1JYoczxCMYlu4y7xXhRY1rcCVxlNHwoZbKgAf
X-Gm-Gg: AYBFou2v3L+uFGosclTPH2MCS75A8rUUHiQWD3+K9NSu7q/Zdxb2L4ujQL0Q/v3EXsI
	t1ND2QcJsgX933REHLd5mVUhROGFTuRw0JHmJDNG9AVkai/cUbpl3bRqxYjo6TdMX3ZDPqNQ0zy
	fS/9yw95+VRqX6UwGEVlhomAg8JOAWROzBpt/uGWnz/iemCR5er3IjGe8YYmukGzmDfFLyBNdkw
	TswDMLMEQf6aZEYCjnMSCk25+4zV8TQHWVyPHLwAcb/m8zA7CRHmYE9fNq3M7m/weBoTeBbUPZt
	a7P9umpwuWtd88GutbsXlQgmiyzmV+vtongjQUVuTvzZZQ6MywLDkA19x46NXvZuT38NHGQ5blb
	mSPnYAWMPmvFIby2/pJcZODWgqQJOLwpeVZjYM4zpj4b3oInVrnx7ZD8zLiaT5sA/Cr+CqenPu+
	6yTT8=
X-Received: by 2002:a05:6000:2010:b0:490:50c1:f359 with SMTP id ffacd0b85a97d-498305da0dfmr4850202f8f.39.1794309285000;
        Tue, 10 Nov 2026 03:14:45 -0800 (PST)
X-Received: by 2002:a05:6000:2010:b0:490:50c1:f359 with SMTP id ffacd0b85a97d-498305da0dfmr4850140f8f.39.1794309284563;
        Tue, 10 Nov 2026 03:14:44 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988f5b1ce3sm2904341f8f.14.2026.11.10.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:14:43 -0800 (PST)
Date: Tue, 10 Nov 2026 12:14:40 +0100
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
Subject: Re: [PATCH v5 08/29] sched/deadline: Take a deadline boost from the
 waiter's rt_mutex node
Message-ID: <avL8oOtjKqVNR7-l@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-9-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-9-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JCVOwTy5AOihYQagahDODdxIhqNMQ44-jBNnGB4z2GY_1794309285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> When a SCHED_DEADLINE waiter boosts the owner of an rt_mutex, the owner
> runs on the waiter's live parameters, through dl.pi_se. The waiter can
> leave SCHED_DEADLINE, and have them cleared, before the owner is
> deboosted. When the owner's runtime runs out, replenish_dl_entity()
> loops forever on a dl_runtime of 0. It holds the rq lock, with
> interrupts off. The owner's CPU warns there and locks up.
> 
> rt_mutex_setprio() also reads the waiter's live priority, not the one in
> its rt_mutex node. Commit acd58620e415 ("sched/rtmutex: Refactor
> rt_mutex_setprio()") found this fine: if they differ, a PI chain update
> is imminent.
> 
> But the update can come too late. Leaving SCHED_DEADLINE clears the
> parameters, so that admission control counts the task again when it
> comes back. __sched_setscheduler() walks the chain only after it drops
> the waiter's rq lock. In the change itself, task_non_contending() clears
> the parameters of a waiter woken past its 0-lag time.
> inactive_task_timer() clears them later, when a sleeping waiter reaches
> that time.
> 
> O is a SCHED_OTHER task that holds the rt_mutex L. W is a SCHED_DEADLINE
> task. T is any other task:
> 
>   CPU 0 (O)                         CPU 1 (W)                     CPU 2 (T)
> 
>   locks L
>                                     blocks on L
>                                       rt_mutex_setprio(O, W)
>                                         O->dl.pi_se = &W->dl
>                                     sleeps
>                                       task_non_contending()
>                                         arms W's inactive timer
                                               ^^^
We know that PI is broken with DEADLINE and this adds to the count of
broken points. :)

>                                                                   sched_setscheduler(W)
>                                                                     W leaves SCHED_DEADLINE
>                                                                     task_rq_unlock(W)
>                                     <W's inactive timer>
>                                     inactive_task_timer()
>                                       __dl_clear_params()
>                                         W->dl.dl_runtime = 0
>   <tick>
>   update_curr_dl_se()
>     replenish_dl_entity()
>       runtime += W->dl.dl_runtime
>       loops forever
>                                                                     rt_mutex_adjust_pi(W)
>                                                                       rt_mutex_setprio(O, W)
>                                                                         spins on O's rq lock

The hang of course is real though.

> A copy of the parameters at the boost is not enough. rt_mutex_setprio()
> would read the waiter's priority, then its parameters. A change of the
> waiter can clear them in between. A stress test switches the waiter in
> and out of SCHED_DEADLINE. With such a copy, the owner's CPU locked up
> within a second. With this patch, the test runs for 600 seconds.
> 
> The rt_mutex node records the waiter's priority and deadline under the
> waiter's pi_lock, which every change of its parameters holds. Fix this
> by recording the reservation there too. A deadline boost then takes the
> priority, the deadline and a copy of the reservation from the node of
> the top pi waiter. rt_effective_prio() now reads that node too. It used
> p->pi_top_task, which try_to_take_rt_mutex() does not update. The chain
> walk and rt_mutex_adjust_pi() also compare the reservation, so that a
> change of it alone reaches the owner.
> 
> This needs "locking/rtmutex: Clone the sort keys in
> rt_mutex_enqueue_pi()". struct rt_mutex_waiter grows from 112 to 160
> bytes on 64-bit. With PREEMPT_RT, every sleeping lock waiter has one on
> its stack.
> 
> A 300ms debug delay before rt_mutex_adjust_pi() locks up v7.4-rc1 in
> 8-CPU VMs, but not a kernel with this patch. The locking API, ww_mutex,
> locktorture and futex tests still pass with and without PREEMPT_RT.
> 
> Found by the Sashiko AI review of v3. Before v4, a second model found
> the window of a copy, and the stale node of a waiter that becomes the
> top waiter.
> 
> Fixes: a5e7be3b28a2 ("sched/deadline: Clear dl_entity params when setscheduling to different class")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

I am not completely sure that we want the additinal machinery below
though, if we can find a simpler stop-gap solution until proxy execution
makes things right.

I was thinking 2 alternative potential bandaids:

 1. Don't clear the parameters of a blocked waiter. Every live donor is,
 by construction, a task blocked on an rt_mutex. Guard the
 __dl_clear_params() calls in task_non_contending() and
 inactive_task_timer() with p->pi_blocked_on (both sites hold pi_lock,
 which is also what pi_blocked_on is written under). The bandwidth
 release still happens at the 0-lag time; only the parameter wipe waits
 until the task is no longer blocked. 
 
 2. Even simpler, considering that the above is of course still far from
 ideal: replenish_dl_entity() already WARNs on pi_of(dl_se)->dl_runtime
 <= 0, and then hangs. Make the condition bail instead. The deboost is
 already in flight: the sched_setscheduler() that clears the donor's
 parameters ends with rt_mutex_adjust_pi(), which walks the chain and
 deboosts the owner through rt_mutex_setprio() and needs the owner's rq
 lock to do so, which is exactly what the infinite loop holds. Bailing
 releases it; the owner then sits throttled until the walk lands
 (dl_task_timer() is a no-op for boosted entities) and moves it back to
 fair. The stall is bounded by the walk's latency. 

Don't get me wrong, the proposed fix looks OK to me, but it also looks
more complex to backport to stable, it will be anyway ripped apart by
proxy exec and doesn't unfortunately make DEADLINE PI less broken (yes
of course the system won't hang, which is very desirable :).

Thoughts?

Thanks,
Juri

