Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236797;
	b=v8Fq/fHiJIfL1Gd18P/iufK2YGXIhM3A0OQebe8HuZlK2fm4UKbjQaBMLm5PzpSilXiX
	 JxHSPCPEIvCyb9LG8jfbcvEGV0+93GFu4MA16R+OClMFmyg9t1IzhdJz7vls0HopLPZLa
	 nr8yrMGF5tQm20n1l654L3hNprGn8TGUQ2UAoKE+VZvI1HIqx8fI4gE5VtaVMTW4MsF7w
	 dSQFQEvBKNJwaMdMwjTQALiX/Xbl8dxZyWQld3wiNAZuEhxrDxqVgc5b3J4/mnsVijrW9
	 dYLwQ6vivGbfqXlG7AdUCShJTHGgnJH2AMC/pgEI1Vrl6t900FE0A0F4kv1SeAHbe9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236797;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=BKWvO8qzTjmjevKuD/TnU304VnpW4id+UFVdK+d/vMA=;
	b=DSG0WtWjWvet7ZAGxf7TN1PpIUZzwi20sBtTtOsYFIzAO+3nJ+J5lQwcoWJE2E+5rxFg
	 gJ/aT7dVD7+WSod3QyaB8Lk9w9Uyjw5/okg8mf3R1zOcTb5n4AC7Iq0fgX1CPGdJW/vKU
	 hrk372I7GfkXNK4x1ikS1iE+QqaP0nxra6Bhvo5VOiHbW3w3LUuYF+G+eRNmBlzbg15P3
	 UIfewOmNwfuLT7795i+Z/1WmHqA+t7YQElGEtv2zN1vCBXKTnU3jbUXSYiFGcN+WpRUXJ
	 bGhd+6KUKN4VCm8AW6MO4/XEXAje60B+FtAZAsXLLFSgid8FrQRHCQ2WvwvvxAXmQ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZtTOxdY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B49606A321
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 15:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42B49606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZtTOxdY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794236795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKWvO8qzTjmjevKuD/TnU304VnpW4id+UFVdK+d/vMA=;
	b=CZtTOxdYiOV06/b4G9u/MJS1T/tHIenPkm4Tye5dseKzbgTce6+wQKECgWb4H0RmG347ZN
	0+QZIRkyslHJemUDm5tbRxNnzXPa9YjyNCYwV7uXxk9BjPd5ifS4Sh4NC0m44RUcyzVk9V
	LirEs6UCZcoV6J7nX0TDqAU3dhTjrE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-szmDLAJWPMab9OMYGxL_yA-1; Mon, 09 Nov 2026 10:06:33 -0500
X-MC-Unique: szmDLAJWPMab9OMYGxL_yA-1
X-Mimecast-MFC-AGG-ID: szmDLAJWPMab9OMYGxL_yA_1794236793
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso671602f8f.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 07:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236793; x=1794841593;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKWvO8qzTjmjevKuD/TnU304VnpW4id+UFVdK+d/vMA=;
        b=iC6hptslA1oFIw833bnvuwNrY09XYY1KLi4QYauUeQP2botBXbxUZnQ7OWnOAgNYOa
         8GWcgrPoVqNgOC1UxQplfymnvVsZt7hQdbWLT7/5l8c061/xRf1NDm/Y0dyS3KH2nGZG
         zqP/rIRt99eZVj545A1+4WqVNzVJ1hF7iptFRVmo7QLLwhi5eBwRbQ7kGj429nMOL1cq
         YON3MBXIuL5NzYcrobhQSN9YqgLeADijWx9fjcJ/aqiej6ysuIoFzcFXljVHO2GthTGH
         DhmHwS64BtW0PZ7mnijoXfH7qHcJQbnPdUQXPs2/OuvLHD4Y/6fbDAP8c54jB7qNxYJ1
         bO9g==
X-Forwarded-Encrypted: i=1; AL+hErHD8Y/hI61fvtdDi4WbILhJDWnU6lOtTEhkzHB0e4MYKm3UDCiI5IawUSA0vzQUi2yLneY48q/hCnCA3p0fUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ggmt3AdRCLcfGbGKrQ37kitWFpGGfVXomEuP1A1vxzRR4Q8gj
	400UX8jncGmL+KK2Ny0I9zidg4ZOxD1lFIffuuJOR/OtOxVlu+GyIfrTaR4e6A4bp/5Xun6EaEU
	lK+79LUp4yVIsVAghwCjLBr6OECn/AWBwyOPCq2kFZ9xtpRVzTLywYcaBFQejggVqEYnk
X-Gm-Gg: AYBFou0fu/KfQFSRCPGvGuhvh2yUEKDcwcRnbqDeRPPd5ViLlTdTDrrTb3UQt5+PM86
	qYc6x9s57lTSbD01jFLvZxzSBgus1sWVU28FnFZDjhZE48OX9RlQ8pzSRUhE2WTyq+1K9rLNjXZ
	nMkf/MaJT4BGv2Xn3MiHRp9IfqUBcn7KvYyx7dRQ7nWvRJQIxRyOybV6peVk+W/RuYkom3e9nBq
	2M9CQuMZY45iO3KyNywMrcgy6+kXT9kgmigYgUftMVCC0w3rxE8eZ4Y3/cZ34fpUEA5XDu4rNR4
	SexDfQHS94i4aWSnjvO43uHytfmUhHLkznjYMsa/KIakD2j+DvYkzTImikCmIZy4pzeVO4316rj
	GCXiKVoORvA+6o2W4QtX8GIvApbUNKE+yljhn9mr7nF3eMunjt38aXOpNjCafXLk=
X-Received: by 2002:a05:6000:2212:b0:48e:5071:420 with SMTP id ffacd0b85a97d-49586743510mr7911108f8f.2.1794236792621;
        Mon, 09 Nov 2026 07:06:32 -0800 (PST)
X-Received: by 2002:a05:6000:2212:b0:48e:5071:420 with SMTP id ffacd0b85a97d-49586743510mr7911029f8f.2.1794236792118;
        Mon, 09 Nov 2026 07:06:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm10850687f8f.47.2026.11.09.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:06:30 -0800 (PST)
Date: Mon, 9 Nov 2026 16:06:28 +0100
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
Subject: Re: [PATCH v5 06/29] sched: Take cpuset_mutex for a deadline policy
 change only with pi
Message-ID: <avHhdDqeMpe7wAay@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-7-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-7-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GG8b8mZjnUfIkdSwLgZp3yg2QMDCkWrATP6Hv6CtT94_1794236793
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> __sched_setscheduler() takes cpuset_mutex for a change that involves
> SCHED_DEADLINE. On success, it releases it only when pi is set.
> normalize_rt_tasks(), for sysrq-n, is the one caller with pi unset. It
> runs under read_lock(&tasklist_lock). So sysrq-n takes the mutex in
> atomic context for a deadline task, and never releases it. Every later
> change that involves SCHED_DEADLINE then blocks forever.
> 
> Commit 710da3c8ea7d ("sched/core: Prevent race condition between cpuset
> and __sched_setscheduler()") took the cpuset lock only when pi is set.
> normalize_rt_tasks() cannot take it under tasklist_lock. Its changelog
> accepts this: after sysrq-n, the deadline guarantees are gone anyway.
> Commit 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex") then took
> the mutex only for deadline tasks. It replaced the pi test by a policy
> test, and left the release under pi.
> 
> Fix this by taking the mutex for a deadline change only when pi is
> set.
> 
> The policy test reads p->policy before the runqueue lock. It is checked
> again under the lock only when the caller gave no policy. Otherwise,
> the task can enter SCHED_DEADLINE in between. The call then takes it
> out of the class without the mutex. A rebuild of the root domain
> accounting could run at the same time. So check again under the
> runqueue lock, and retry with the mutex.
> 
> sysrq-n on v7.4-rc1, with a deadline task and lockdep on:
> 
>   sysrq: Nice All RT Tasks
>   BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4356, name: deadline_switch
>   locks held by deadline_switch/4356: 4, last CPU#3:
>    ...
>    #3: ffffffff83006098 (tasklist_lock){.+.+}-{3:3}, at: normalize_rt_tasks+0x34/0x150
> 
> A sched_setattr(SCHED_DEADLINE) after it never returned, in 2 VMs of 2.
> The sysrq_normalize case of deadline_switch_test, added later in this
> series, tests this with DEADLINE_TEST_SYSRQ=1. It passes with this
> series.
> 
> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

The change in itself makes sense to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

I only have cosmetic/minor comments below.

>  kernel/sched/syscalls.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 56ce2352e89e..0bc778c12af4 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -561,9 +561,11 @@ int __sched_setscheduler(struct task_struct *p,
>  
>  	/*
>  	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
> -	 * information.
> +	 * information. Do not take cpuset_mutex when pi is unset: the
> +	 * caller is normalize_rt_tasks(), which holds tasklist_lock and
> +	 * cannot sleep.
>  	 */
> -	if (dl_policy(policy) || dl_policy(p->policy)) {
> +	if (pi && (dl_policy(policy) || dl_policy(p->policy))) {
>  		cpuset_locked = true;
>  		cpuset_lock();
>  	}
> @@ -654,6 +656,15 @@ int __sched_setscheduler(struct task_struct *p,
>  		goto recheck;
>  	}
>  
> +	/*
> +	 * The task entered SCHED_DEADLINE after the unlocked read of its
> +	 * policy above, so cpuset_mutex was not taken. Retry with it.
> +	 */
> +	if (pi && !cpuset_locked && task_has_dl_policy(p)) {
> +		task_rq_unlock(rq, p, &rf);
> +		goto recheck;
> +	}
> +

For a cursory read this check and the one above look similar. Can we
maybe have more descriptive comments for them, e.g., for the first

 /*
  * The caller gave no policy (SETPARAM_POLICY): the request was
  * derived from an unlocked read of p->policy above. If the task
  * changed policy since, re-derive the request from scratch, and
  * release cpuset_mutex: the re-derived request re-decides whether
  * it is needed.
  */

and, for the second, that this patch adds

 /*
  * The caller gave an explicit policy, so the request needs no
  * re-derivation (oldpolicy is -1 above). But the decision to
  * take cpuset_mutex used the same unlocked read: the task
  * entered SCHED_DEADLINE since, and the change below would take
  * it out of the class. Retry to take the mutex.
  */

Also, maybe add an unlikely() to the second check as well?

Thanks,
Juri

