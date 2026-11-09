Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234614;
	b=N7FLkBnl3BDNNomzWF7wUvS/1kRjFKfMce2sLs/u8HvJvCp4BwHl//qMhBDlahTEat34
	 evCwrVaTtaRSjOJyFqO/b+eAwGySClC7ITKJEl9TUWNkIgxWsv2oksC6iLJGIbO88jdlw
	 98zrtbhk4/VCT27syURu1A5jxzVZFZAJquowgbhjEQSLd3eSNn5k6rvxurWl901D+Ze7y
	 jCFvjASXLVOfl420MMgIHsSN/SWNzEvQKrEg2vzMdV74cP4OvGfn1UT0sN5yzKaf6tdx8
	 QdBcaC6pd2wlGqj5cluID6SlMWfbMsfmyo4YIDx6TrDlTBSv9ygsaRjDSUtnQb565Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234614;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=I/6OXbgLV4bCZUWKV0/koAsoiTh094pqrHlSP0k4YPc=;
	b=UuINHtPVmwRr0HR/YdYYC9s7D4aDK0tj9GsTaPGWGVzS+TDG+p07sHZZi4GmKiSE8GqB
	 vq5FcI7kHjQql4qNM95UfIWk9KUdSlYi2tn/Im2SLMFlMm+MsD8Zapz1Tpm6YM1A48kxH
	 KcJdTeVh8LjLnsnRqD31sy3hR44pX0Lxqpw4RXmHJnplsSDTzNFuV7QJ3S9D+zWvexoF1
	 8m4MwC9B1OwYIaP0mHCqKeRx3KcN2RNNi878BHCyJnJF95PkddqX3hrRL1Q9ECmkLWy6U
	 Gn0VMuC8WiqwUZ2a6fm5UhsjbWsdM5P7gl928zw5Xfz//+sFPzGrnkgozodVP/LAb1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gjh+K8CB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493B606A33A
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 14:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B493B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gjh+K8CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794234612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/6OXbgLV4bCZUWKV0/koAsoiTh094pqrHlSP0k4YPc=;
	b=Gjh+K8CBtHRplJUjh8Z6lW55vteLw/9Cfmmob4fXONPeuzLIzivkKJlQCRyxcgT++kYVJ0
	toYWOli8le+po3/VN0OMIXrY7S+DehqUdKu0WZ7mhX3dwwVBcFJcx/yCR4+ErXnkF5plZT
	MgtzY7PjWYbRK2R2hdvqI7t6u9aa2kA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-FmGIszXdP9yN8iQQ0hcT8Q-1; Mon, 09 Nov 2026 09:30:11 -0500
X-MC-Unique: FmGIszXdP9yN8iQQ0hcT8Q-1
X-Mimecast-MFC-AGG-ID: FmGIszXdP9yN8iQQ0hcT8Q_1794234610
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so9504785e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 06:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234610; x=1794839410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/6OXbgLV4bCZUWKV0/koAsoiTh094pqrHlSP0k4YPc=;
        b=JkOlrTKLNEEi7U8M94z9EWliwx3yHnO8UUFORodfR+LQgl15VzmyAD9j/3VXmbow/x
         9vEgN5hvgNqfpZAbOMzyHUFc1A0Rr0SrO6RBk15VojOXedu38MU6v7gqKhiPAY5dDG5R
         KnAD/Szf/Lvw2XS2dt9TC21IrZvDN+2ejcvRdwACVl83QIhfK3R8rby7CPuA+dcyiDpk
         f/pcN7OVChAh83E1hdcE8JUHNdx4L/fZsNIgvBH0RkzsBABwzmJJfsmBLh0Jjaj+Gf4T
         4olcn3GbgnyLgrLoo9MQQRyGC6ifnK+gF9zFzaIJ6vhSeUC86y9hjTjHpGqWLf4AsKb9
         HP6w==
X-Forwarded-Encrypted: i=1; AL+hErEyd5U7LUABi6mVDgPprRzWn1sdzGyzwQfwLuNlNZ94nukCui0ONzTL2IOm3f+PVfc3u3yO+283SQZM2Be2xA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+kS2SRbMEYWe62Jxb+C6P+tbYdBMTiMVu9GJtE2Xw0PupdPVLt
	TlTF3wwadT445pnu6LgsT0krIB4PtvtXVNdO4PUihBblljNx7alHgNLz1q5UO9I86X/3hnvEIaf
	ajq1EYNGx62bFomQKCeUUXf7bua4+R38j6pCNbvGxQG57ovJnVEI81WnoNODtvo2roMGz
X-Gm-Gg: AYBFou3yMvlfxxNWtblcYhmWMcNyPNakRTmrFeicK7aHxSesjPlGoU/SXK/JiWudge3
	YxqDPUfQvQLG6f+hoJObjpyDV+qsrzKOVuUoCwnjg4y2gHmuvRAlU8qk7XJ5qRr2p/i2buSH4IL
	yMAV0d312EksuMMvkfox8kDhmEqLrCcIqC8ys6xNmCldayMK520Wj3UCyrO9EAMEjzZq3KaIcNP
	DdtlSSob8XkeZvbFZV9xaiRS2Ass9g8+ds1yjDyg7VY/ghYcQzxlgW8UCDbe5cXzUkl/LspZCIz
	qzBVGrOTGbxQtMzw/PYySsHj6+aPCbmMJbn8Dz2vzVbs/XGoq5wFcsr5uwlpVMStF+y8x8ZdTuX
	wX7KqZgK9c9G4+mJSth8CgJ1zRVSq1R0rh/YeI/BQKXqdD38FeHnwKd8OGojPW2LSjHceWXoyqA
	65FA==
X-Received: by 2002:a05:600c:1c09:b0:4a3:5991:719 with SMTP id 5b1f17b1804b1-4b963c858d8mr92853805e9.31.1794234609932;
        Mon, 09 Nov 2026 06:30:09 -0800 (PST)
X-Received: by 2002:a05:600c:1c09:b0:4a3:5991:719 with SMTP id 5b1f17b1804b1-4b963c858d8mr92852865e9.31.1794234609470;
        Mon, 09 Nov 2026 06:30:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad610sm553074535e9.3.2026.11.09.06.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:30:08 -0800 (PST)
Date: Mon, 9 Nov 2026 15:30:06 +0100
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
Subject: Re: [PATCH v5 05/29] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Message-ID: <avHY7oNeuvjsLT4I@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-6-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-6-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Y7C3zaGvZoDQ5Eftmk1Z1JD0G3J16Oj2cZLgMpvCVo_1794234610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> __dl_sub() and __dl_add() divide by their cpus argument. Most callers
> pass dl_bw_cpus(), the number of active CPUs of a root domain. That
> number can be 0, and the division then traps.
> 
> Commit daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl
> tasks") added extra_bw, the bandwidth that deadline tasks can reclaim
> on a runqueue. A change of a root domain's total_bw is shared by the
> extra_bw of its active CPUs.
> 
> During hotplug, a CPU sits in the default root domain, which can then
> have no active CPU. This lasts from the rebuild in
> sched_cpu_deactivate() to the offline, and from the online to
> sched_cpu_activate(). A debugfs write to its fair server's runtime or
> period divides there. Commit 4043f5498416 ("sched/deadline: Reject
> debugfs dl_server writes for offline CPUs") refuses the write only once
> the CPU is offline. A write of the same bandwidth passes admission in
> the window. In 8-CPU VMs of v7.4-rc1, a loop of such writes oopses at
> the first offline and online:
> 
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   RIP: 0010:dl_server_apply_params+0x335/0x380
>   Call Trace:
>    sched_server_write_common.isra.0+0x1c0/0x260
>    full_proxy_write+0x58/0x90
>    vfs_write+0xcb/0x550
> 
> By reading, two other paths would divide by zero:
> - inactive_task_timer(), for a task that left SCHED_DEADLINE or died,
>   if its CPU went offline.
> - sched_setattr(SCHED_DEADLINE) on a task asleep on an offline CPU,
>   with admission control off.
> 
> Fix this in two places:
> - Refuse the debugfs write while the runqueue is offline. The server's
>   bandwidth is not counted then. rq->online is set under the runqueue
>   lock when the CPU joins a root domain that counts it, after
>   cpu_active() is set.
> - With no active CPU, have __dl_sub() and __dl_add() change total_bw
>   alone. This covers the other paths.
> 
> With this patch, the reproducer survives 20 rounds with no warning.
> 
> Fixes: daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl tasks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/sched/deadline.c | 11 +++++++++--
>  kernel/sched/debug.c    | 10 +++++++++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index dfae08625342..b614d5fc1a1a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -189,18 +189,25 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
>  	}
>  }
>  
> +/*
> + * Spread a change of total_bw over the extra_bw of the active CPUs of the
> + * root domain. @cpus is their number. With no active CPU, as can happen
> + * during CPU hotplug, change total_bw alone.
> + */
>  static inline
>  void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  {
>  	dl_b->total_bw -= tsk_bw;
> -	__dl_update(dl_b, (s32)tsk_bw / cpus);
> +	if (cpus)
> +		__dl_update(dl_b, (s32)tsk_bw / cpus);
>  }
>  
>  static inline
>  void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  {
>  	dl_b->total_bw += tsk_bw;
> -	__dl_update(dl_b, -((s32)tsk_bw / cpus));
> +	if (cpus)
> +		__dl_update(dl_b, -((s32)tsk_bw / cpus));
>  }
>  
>  static inline bool
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index e6a3b516c703..e0d6cd3bd607 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -410,7 +410,15 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
>  			return  -EINVAL;
>  		}
>  
> -		if (!cpu_online(cpu_of(rq)))
> +		/*
> +		 * Refuse the write while the runqueue is offline. This
> +		 * includes the windows where the CPU goes offline or comes
> +		 * online. The root domain then does not count the server's
> +		 * bandwidth, and may have no active CPU. rq->online is set
> +		 * under this lock when the CPU joins a root domain that
> +		 * counts it. cpu_active() is set before that.
> +		 */
> +		if (!rq->online)
>  			return -EBUSY;

This 2nd hunk complements and tightens 4043f54984161 ("sched/deadline:
Reject debugfs dl_server writes for offline CPUs") which has Fixes:
d741f297bcea ("sched/fair: Fair server interface"). Do we need both
fixes (if that is allowed) or maybe we need to split this change in two
(as this second part won't apply to old kernels w/o dl-servers)?

Thanks,
Juri

