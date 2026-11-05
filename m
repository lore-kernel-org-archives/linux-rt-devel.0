Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890147;
	b=iOEy3YF51MoKIRrOAZNX8TLO/f8h399LBd2go8LtgDZwkSU3LCXUMPo8aNDd15NAP3kS
	 28/qVvF5r9f6EFxzKcy2MmIgf7Tn7Iq+S8hi0/fubwdsOdZCg3Dt6xTvbFeX8kizJOT+e
	 ggoI785D9ObUw9/RPxmjWlbcyjAgp3cEx47QeM6VH/OaJcBdC956vcwjarDWfgAAWVhII
	 3cDX7w4kIK8rb2OfnZmxUHMgsWAXUVI7y/3Hw93MRO2Grv31UgQ75XOS39rZZp5yDe/mW
	 yxR/C/re+RB38ZUv9ecvrJvgs9vleZB+fnan5QXkIWY3Q2AUlHdP5+lHHA54YmaXW6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890147;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=0oZXaqilvDmJS1hNMgdeAwWlpvrdojNG02VoZz9o0R0=;
	b=F2jSj7C3sqf+yrAuwEJGmn7Z+iaHpGiMUrBikjhakUOCqmzkwskBEb8DFESLl1Bo4tK5
	 RDDEuqMw+iSG7EaHJMg8FHY2hRibk57EdDo6lWq31RUMr7HTdEWVO8PNMaFb7WA3T8Iq9
	 909BRbSx7GBeI15wP86WY/Qq/7z/B/nqhx9w2XuZuJYKriRQIrhn0ltGPjTN/0eYSMpXm
	 k2/qPBge/eVTlfaE/3c0pbRzoz0yNTdwNdOyFT6pBP8CNOP7Wq0Wkil4g3aQ42Z8pCaOM
	 gR166hdyUsypDSuJz+c3BNqBex7glpZ0fPfagMapuLPeY5q4JcnCmiiiFKh0RxDbzZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IjFkXB9R;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C842606A332
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 14:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C842606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IjFkXB9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793890146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oZXaqilvDmJS1hNMgdeAwWlpvrdojNG02VoZz9o0R0=;
	b=IjFkXB9Rnrw6+aJnLxxAIkMmv3l1JTothelpQIjt3FEYPRXyJJ4NGc6c9i+/2Exh4eTwxK
	EObppp6EHmJ0za2cr5IdnKselH0c/hZOuwFz9cRgJBl3yWGRPr0BTso3QRYmJSe9lDU8ze
	Z50dQFrkOW96swIWCyFCyd3jDSSoaI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523--vguVJ6NP2mHCnZYFG_trA-1; Thu, 05 Nov 2026 09:49:03 -0500
X-MC-Unique: -vguVJ6NP2mHCnZYFG_trA-1
X-Mimecast-MFC-AGG-ID: -vguVJ6NP2mHCnZYFG_trA_1793890142
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso15633305e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 06:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890142; x=1794494942;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oZXaqilvDmJS1hNMgdeAwWlpvrdojNG02VoZz9o0R0=;
        b=CUHBQdlpKlkNx+4cIWQTKxks2pg2Q82ofszBZwHnGqh/spixbDm6fOogq73vPiWbGI
         +/0mM3l7Yi800aWvHens0+GbrpAlMpJorVSY55pFtW9gbazBgLv2eMfftBo/16Nb/gv1
         D59C+9Jnw8lEMa4k+qM5f98gFFW6E/Ir+AgtbJFqgJMStZonSO5LDDLVhP7Ywd/B0ftL
         dPDQD8ErOqOQeHE8le5kj5U+z0QAVgODYO22iNVDXcqGjao05C1vt5LQhl1ry87LihKg
         jcJWT5iLQJMdXqeKOrc/WGsy+gai9PwfPi5dSA4Qo77DMn8m2qHeRPLApqVO51xMDLBD
         h89w==
X-Forwarded-Encrypted: i=1; AKwUvBwaceTpTxl8XeKCKvvdppFARmyO81S7FjBPUnTr6o0GN5ipaA26NsNlFY24ZG8W1engWwHOvclNwEMRoGRQ8Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8xwgNlo0v5LMAcSgJm1ot+SHbOJzkzOgyBlmdC0NwQU/98Atc
	JQpjd6fe/UCZ6/PU+mKiXMa/AKw7kKTcE9+X14xqIV7Xh/L23js+RWwhGIQtF5rrjnbIAeB+sEH
	ksVqlFkp/fUcT39pEibyF5fi98fsP1ZzcMailqK9jHKUjoHznLGjUCOQfOId2qJ4EO1M9
X-Gm-Gg: AYBFou1F8ygr/PZfRW6nwrSUVOhuDeOy9uI9871ML3OctrmKiDRxYqQhZSKnnzuiNS9
	MVUorVZ2G8EfvVxkiCKH9lq9i4QTFVP3egJSJy6gM9m1XekEmBgVx1dNENaBA5SHRAR/ujjWaeT
	pnAHGL8dXSfVCZHFrHL11UqI+NIuFEMB79H+G2kGnQWRmps+xoEgV4d6zKfBpK37LfmaTZdmo8r
	DJ6GFPiq6NoDoDAKACPgpG2xwxHrnn+HkYRDK3jZh/0pVYyxWb86OoQ9OLoidRcvCgKKf1w4n9b
	6niPQoPW3AhI3BlYc+Akn4TF4ZKvXP/5OgiIJAz/Vx7u94Sl3MyC44T/FR63aMBuXRks7Ck2YJX
	ewFryLQhXdhtHIybsbfHvti4qRvxOE+CI7ERXAmhK3G3QZPfKUsC+sbasEo/ObQrnnNtjS9g2dp
	qZ/w==
X-Received: by 2002:a05:600c:1f93:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4ac180f2fd3mr448854195e9.30.1793890141849;
        Thu, 05 Nov 2026 06:49:01 -0800 (PST)
X-Received: by 2002:a05:600c:1f93:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4ac180f2fd3mr448853555e9.30.1793890141421;
        Thu, 05 Nov 2026 06:49:01 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e65b0sm79732955e9.11.2026.11.05.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:49:00 -0800 (PST)
Date: Thu, 5 Nov 2026 15:48:57 +0100
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
Subject: Re: [PATCH v2 06/21] sched/deadline: Do not lose a throttled task
 switched out and back
Message-ID: <auyXWR01Lqb_yam3@jlelli-thinkpadt14gen4.remote.csb>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-7-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104211207.1392343-7-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zt72Hmo1yqV8rWQj_HpUSkuzebk9NMnXMnoaAKauVy8_1793890142
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 04/11/26 16:11, Mathieu Desnoyers wrote:
> A SCHED_DEADLINE task that is throttled, switched to another policy and
> switched back before its 0-lag time can be left throttled with nothing
> to replenish it: runnable, queued as far as the core is concerned, but
> on no dl_rq and with no timer pending. It never runs again, and a fatal
> signal cannot make it run; only another switch out of SCHED_DEADLINE
> requeues it.
> 
>  1. the task exhausts its runtime: dl_throttled is set, and the
>     replenishment timer armed for the start of its next period;
>  2. sched_setscheduler() switches it to SCHED_OTHER: switched_from_dl()
>     calls task_non_contending(), which arms the inactive timer for the
>     0-lag time; the parameters are kept until then, so that leaving and
>     reentering SCHED_DEADLINE gains no bandwidth;
>  3. the replenishment timer fires: dl_task_timer() finds a task that is
>     not a deadline task and returns, dl_throttled still set;
>  4. sched_setattr() switches it back before the 0-lag time:
>     switched_to_dl() cancels the inactive timer, and enqueue_dl_entity()
>     leaves a throttled task to its replenishment timer, which has fired
>     already.
> 
> The window between the deadline and the 0-lag time is the overrun
> scaled by period/runtime: about 100us for an overrun of 20us at 20%
> bandwidth. The replenishment timer cleared the parameters, dl_throttled
> included, of a task it found out of SCHED_DEADLINE until
> commit 209a0cbda7a0 ("sched/deadline: Improve the tracking of active
> utilization") moved that reset to the inactive timer, at the 0-lag
> time.
> 
> Give the task the replenishment the timer owes it, as the timer already
> does for one that is throttled and not queued: the overrun comes off the
> periods that follow, the deadline moves past it, and dl_throttled and
> dl_yielded are cleared. A return before the 0-lag time then finds an
> entity it can run on, and a return after it finds the parameters reset
> by the inactive timer, as before.
> 
> Clearing dl_throttled alone would leave the overrun in the runtime, for
> the new period of the enqueue to forgive, the deadline behind, for
> dl_check_constrained_dl() to throttle the task on again, and a yield of
> that period set, for update_curr_dl_se() to throttle it at once. The
> first version of this patch did, and the Sashiko AI review of the first
> posting of this series pointed the three out.
> 
> The selftest added two patches later fails its throttled_round_trip
> case 8 times out of 8, on v7.3 as on v7.4-rc1 with the four deadline
> fixes of sched/urgent, and passes it 8 times out of 8 with this change.
> It was found by a cgroup selftest under development,
> test_concurrency_deadline, which hung about once in 1350 runs.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/sched/deadline.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 30a52e42c26d..b646063a7b0d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1232,10 +1232,23 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
>  
>  	/*
>  	 * The task might have changed its scheduling policy to something
> -	 * different than SCHED_DEADLINE (through switched_from_dl()).
> +	 * different than SCHED_DEADLINE (through switched_from_dl()). It
> +	 * keeps its parameters until its 0-lag time and may come back to
> +	 * SCHED_DEADLINE before then, switched_to_dl() cancelling the
> +	 * inactive timer: give it the replenishment this timer owes it, as
> +	 * the !queued case below does, and leave the enqueue to its return.
> +	 * A throttle left behind would never be lifted; an overrun left in
> +	 * its runtime would be forgiven by the new period its enqueue
> +	 * starts; and a yield left set would throttle it again at once.
>  	 */
> -	if (!dl_task(p))
> +	if (!dl_task(p)) {
> +		if (dl_se->dl_throttled && !is_dl_boosted(dl_se)) {
> +			sched_clock_tick();
> +			update_rq_clock(rq);
> +			replenish_dl_entity(dl_se);
> +		}
>  		goto unlock;
> +	}

This should fix the subject issue. Sashiko points out a follow-up
re-entry case that looks problematic (and I think I'm now seeing more),
but that should all only concern limited bandwidth overruns. This change
fix an actual hang, so we might want to take it and work on the
remaining issues separately.

Thanks,
Juri

