Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340042;
	b=p38nv/SAiUtS4McZGKga3VnvInLMkGnPE46e9PsE0D4UI2bNPF8S6nCit2jKL7f7uSDa
	 KRLvp6mc1HnFAwdCPNEr91DWCgX4+12sRH4EjQ2kknnI9ifByHDww8qol6KOQUO1wMOje
	 EYTggluDbsUW0ZTgDLD3QGIPJK5DFpwexkbrx/mTRIa7ACKDLOnTa+mhvp8MMD7XBWkdv
	 kMrhc86F2LTTosiHlidJ97Lv9+1fwaQ6u0VVE253Lqk7Ak9dtEeX+kJT4SbkQmIESC8j6
	 rpRQ8coMkVRPg9r3eJLn2crqaDIMT0XYzCGHGgZjDGLbMHWjNh8MnKYilCrWmavN8Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340042;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=dqGz2Ceiqh+ClSBXpHsYkjX+5pBbS+WZ/wLFaJOG/RQ=;
	b=qjUMsNOaN4Ke0Eh+45+w+hJTuHoYJtCpCYsMoP1HwDjiq/wKq8M2F12nzLWqRD21IV2F
	 mytVy9tG1j8l3SZUtsqXUvfLTLHRHjEwzPNSQxeplKp15o4eGiqar+0WW6EDTuH2//2QE
	 6+1+oj32SFJdDyWdr7e8X/aZyWv0x7i3XD41ksN1Mz6VkYOGF6dhg7r3LiJZIv6U1apNT
	 +EReZCZLz1ZEJHA/h0966OVxfWlCkdUC7iaAAD6MHds8C+4EHdc2bDIJ0XvRHgjACDlZ+
	 ta3jokaQm3FtFOriZdIWWsMpp5W/r9JCZHqUNsUyBaH2byI3Q4f66qmyUlL+R/mLesw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFsQoIbT;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B240606A323
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 19:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B240606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFsQoIbT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794340041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqGz2Ceiqh+ClSBXpHsYkjX+5pBbS+WZ/wLFaJOG/RQ=;
	b=AFsQoIbToRtVBfKbZYZXx6UY5SQePeCRt2uY2xa1EoWVQ2yKRXfeuU6zzufjtiIE9GpHsM
	y6DTlzGJpUNFQXGIrxV4rwl6DMFrVj5+RYx1WwmB6i/N6947NDuolrVCavhhstCQZBah18
	sWjXPjt0OpivTzcU/geJCwD9aOknlxA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-qWnGBifsMxO-dhCsz_R5-Q-1; Tue, 10 Nov 2026 14:47:19 -0500
X-MC-Unique: qWnGBifsMxO-dhCsz_R5-Q-1
X-Mimecast-MFC-AGG-ID: qWnGBifsMxO-dhCsz_R5-Q_1794340038
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so1689294f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 11:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340038; x=1794944838;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqGz2Ceiqh+ClSBXpHsYkjX+5pBbS+WZ/wLFaJOG/RQ=;
        b=F0LmFLW2lXI8so6LNuZZ8ZVr7a8a74h5CS0H6uCn/1RQfPpqc73pD9GCy7t4yfBl/S
         iuaRk4S8dAIAK4uNWSFwjk7SVZPfqUqVI6qiEiTrbvpwMyI8Qu1a7uDQE4DkGZVMvNWW
         jbjzNfiu0yggtHU1xNT5du2iuDyc4R+UW/Vk9FauK26/JhEiydtSKBms5W5+/ud1Qzs4
         X07xQuN89AYbXAW876+r9xQ+xQHKSKo3CbcRgk7b/RY+D2KUNQfZ/3u3UsQ02CiL9D5Y
         syWvCZ1eHc/gS9SGC/jCKlYgcJdHrVen9nle35prJMMINESXQ3NYbxCIsvV27LeBNVVs
         H9jA==
X-Forwarded-Encrypted: i=1; AL+hErGU7UEDnG7ooIAi1BqOdP/PGv1q/Irzq9rTGuPnD4eU/YcAsgnjL3j/HXD/N7PKqNhzFSq9fsdRALfLFKD6zg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+UJxtgrwgzGvv4w89fG70j508BdyA/CoobE1MfDFL52jgedSbV
	hZ1XDXs+MD43PktOWxtooNy9gQN9JTLgwRVZCuoQxUc85FwJP6405/YcoQDqPLQ2FE32gpDBJy4
	xnfhYUNq8KUgNY8Wy1uz7OBAyPutktcJsan5iGtygyOidfPuFUIrBnDg6luXIJnqw0e9N
X-Gm-Gg: AYBFou1J5pfhyTz44V1e+u6rdYhbbkDJqV39KYGub7XfPXUz5rae+68FTeVwOvkcSOL
	982+euXcpEjbp2S3rTWCHsRdouKkcp2YpRByaTOAVbJ0O/9MW44ifs8AaX+oUD5mAZqSyZkVdJU
	pc1YFbQyaar8rGiReioV7BktodARRebw4cDBN/fQGT3OU4vJdxC6+VDYyGVyoxiuSj+T1NIhusy
	BfJz/TXRMVOsb8gsL5C5r2LXaSyY/6IiYg04ZCfkt+W/4fV/wGnbPZXqgG5pHPMNnD6fidpl3dF
	bquK3u4fdzHcPaTYqGS0+qstNGui7SXZ5dMY8rnp1CsFjer7CBWiEtxC8TmHiMJjEx7N8U8qEkz
	Pexnrgec1yeWc017ml7AP9VQbPGisP0eUOD6KuVfBFOkbBSOHapg5BXsHyEDur8O6GBh6WYKEci
	9CpWE=
X-Received: by 2002:a05:6000:2dc1:b0:497:bd30:8e39 with SMTP id ffacd0b85a97d-498304e5dd4mr6728829f8f.44.1794340038306;
        Tue, 10 Nov 2026 11:47:18 -0800 (PST)
X-Received: by 2002:a05:6000:2dc1:b0:497:bd30:8e39 with SMTP id ffacd0b85a97d-498304e5dd4mr6728770f8f.44.1794340037803;
        Tue, 10 Nov 2026 11:47:17 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836a9951csm6505110f8f.56.2026.11.10.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:47:17 -0800 (PST)
Date: Tue, 10 Nov 2026 20:47:14 +0100
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
Subject: Re: [PATCH v5 11/29] sched/deadline: Release the bandwidth of a task
 that leaves the class asleep
Message-ID: <avN0wpOY2zoRnK8q@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-12-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-12-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U2dWiLo7D1sgus_gDuF12--ZltwNCqYJggS9v5X-jOY_1794340038
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A task that leaves SCHED_DEADLINE while it is not queued can keep its
> bandwidth in total_bw until the next rebuild of the root domains.
> Repeated, this fills total_bw up to the admission limit. Then
> sched_setattr(SCHED_DEADLINE) and CPU offlining fail with EBUSY.
> 
> A task that leaves the class keeps its bandwidth until its 0-lag time.
> Releasing it earlier would allow temporary overloads. For a queued task,
> switched_from_dl() calls task_non_contending(). It releases the
> bandwidth if the 0-lag time is past. Otherwise it arms the inactive
> timer, which releases it then. For a task that is not queued,
> switched_from_dl() relies on the timer armed when the task blocked.
> 
> But that timer is not always armed. The task may have blocked after its
> 0-lag time. Or the timer fired while the task was still in the class,
> and only removed running_bw. Then nothing releases total_bw. The timer
> is also cancelled before the 0-lag time when the task wakes up on
> another CPU, or comes back to the class asleep.
> 
> Fix this in switched_from_dl(), for a task that is not queued and has no
> timer pending. If the 0-lag time is ahead, arm the timer. If it is past,
> release the bandwidth now. Then clear the parameters, as
> inactive_task_timer() does, so that no later path releases the bandwidth
> again. A timer handler that already started finds a dl_bw of 0. The
> deboost of a later priority inheritance boost finds no parameters. Since
> "sched/deadline: Take a deadline boost from the waiter's rt_mutex node",
> a boost that the task gives as a waiter does not read them.
> 
> Juri Lelli's first fix, since dropped from tip, released the bandwidth
> here without clearing dl_bw. The bandwidth of a boosted task was then
> released twice.
> 
> The Sashiko AI review of the third posting found the two cases with the
> 0-lag time ahead. deadline_bw_test, added later in this series, tests
> this in pi_former_owner_asleep and deboost_released_resets_period.
> 
> Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-2-dd761fe005b4@redhat.com/
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Reported-by: Tejun Heo <tj@kernel.org>
> Closes: https://lore.kernel.org/all/2b5fb3f22bca6aa383be8f4781923392@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/sched/deadline.c | 98 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 81 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e6c55afcfd01..d5d0f87d3a94 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -403,6 +403,23 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
>  
>  static void __dl_clear_params(struct sched_dl_entity *dl_se);
>  
> +/*
> + * Return the 0-lag time of @dl_se, relative to the clock of its runqueue.
> + * After @dl_se blocks or leaves the class, its utilization counts until
> + * that time.
> + */
> +static s64 dl_zero_lag(struct sched_dl_entity *dl_se)
> +{
> +	struct rq *rq = rq_of_dl_se(dl_se);
> +
> +	/*
> +	 * Using relative times instead of the absolute "0-lag time"
> +	 * allows to simplify the code
> +	 */
> +	return dl_se->deadline - rq_clock(rq) -
> +	       div64_long((dl_se->runtime * dl_se->dl_period), dl_se->dl_runtime);
> +}
> +
>  /*
>   * The utilization of a task cannot be immediately removed from
>   * the rq active utilization (running_bw) when the task blocks.
> @@ -476,15 +493,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
>  
>  	WARN_ON(dl_se->dl_non_contending);
>  
> -	zerolag_time = dl_se->deadline -
> -		 div64_long((dl_se->runtime * dl_se->dl_period),
> -			dl_se->dl_runtime);
> -
> -	/*
> -	 * Using relative times instead of the absolute "0-lag time"
> -	 * allows to simplify the code
> -	 */
> -	zerolag_time -= rq_clock(rq);
> +	zerolag_time = dl_zero_lag(dl_se);
>  
>  	/*
>  	 * If the "0-lag time" already passed, decrease the active
> @@ -3606,15 +3615,69 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  	dec_dl_tasks_cs(p);
>  
>  	if (!task_on_rq_queued(p)) {
> -		/*
> -		 * Inactive timer is armed. However, p is leaving DEADLINE and
> -		 * might migrate away from this rq while continuing to run on
> -		 * some other class. We need to remove its contribution from
> -		 * this rq running_bw now, or sub_rq_bw (below) will complain.
> -		 */
> -		if (p->dl.dl_non_contending)
> +		bool released = false;
> +
> +		if (p->dl.dl_non_contending) {
> +			/*
> +			 * Inactive timer is armed. However, p is leaving
> +			 * DEADLINE and might migrate away from this rq while
> +			 * continuing to run on some other class. We need to
> +			 * remove its contribution from this rq running_bw now,
> +			 * or sub_rq_bw (below) will complain.
> +			 *
> +			 * inactive_task_timer() will find !dl_task(p) and
> +			 * release total_bw via __dl_sub().
> +			 */
>  			sub_running_bw(&p->dl, &rq->dl);
> +		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl) &&
> +			   dl_zero_lag(&p->dl) >= 0 &&
> +			   !hrtimer_active(&p->dl.inactive_timer)) {
> +			/*
> +			 * No inactive timer is armed, but the 0-lag time is
> +			 * ahead. Either the task is waking up on another CPU,
> +			 * and migrate_task_rq_dl() cancelled the timer. Or it
> +			 * came back to the class asleep, and switched_to_dl()
> +			 * cancelled it. Arm the timer, as for a queued task.
> +			 * Its handler finds the task out of the class and
> +			 * releases total_bw. running_bw is already off this
> +			 * runqueue, or was never on it.
> +			 */
> +			task_non_contending(&p->dl, false);
> +		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
> +			/*
> +			 * No inactive timer is armed, and the 0-lag time is
> +			 * past. Either the task never ran in the class, or it
> +			 * blocked after its 0-lag time. Or the timer fired
> +			 * while the task was still in the class. Nothing else
> +			 * releases total_bw, so release it now.
> +			 *
> +			 * A timer whose handler already runs also leads here,
> +			 * since hrtimer_active() is true. The handler waits
> +			 * for the runqueue lock, then finds a dl_bw of 0,
> +			 * cleared below.
> +			 *
> +			 * A task deboosted from priority inheritance, with no
> +			 * parameters of its own, has no bandwidth in total_bw.
> +			 * Neither has a special task.
> +			 */
> +			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
> +
> +			raw_spin_lock(&dl_b->lock);
> +			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> +			raw_spin_unlock(&dl_b->lock);
> +			released = true;
> +		}
>  		sub_rq_bw(&p->dl, &rq->dl);
> +		/*
> +		 * Clear the parameters too, as inactive_task_timer() does at
> +		 * the 0-lag time. Then no later path releases the bandwidth
> +		 * again. A later priority inheritance boost sees a task with no
> +		 * parameters of its own. task_contending() and
> +		 * task_non_contending() skip it, and its deboost releases
> +		 * nothing.
> +		 */
> +		if (released)
> +			__dl_clear_params(&p->dl);

The fix looks right, but I wondered if we can condense a bit the above
if-else tree. It's essantially doing what task_non_contending() does
already (special and non-DL tasks checks included)?

What about something like

     if (!task_on_rq_queued(p)) {
         if (p->dl.dl_non_contending)
           sub_running_bw(&p->dl, &rq->dl);
         sub_rq_bw(&p->dl, &rq->dl);

         if (!p->dl.dl_non_contending)
           task_non_contending(&p->dl, false);
    }

I ran the same collapse on top of the series and it passed the selftests
with LOCKDEP w/o warnings.

Thanks,
Juri

