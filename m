Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007739;
	b=ZRIA0mF63wjhaJfGHrCNqe56bQkba4RepvpSXAB87j+fNgS4o3zDF3t3lQBJeucTavIj
	 yqvW0gbE/NRxmlfCZxNvRFtCDc13waBwvTrhVpRghCcTzc3OyqoTYqiBMsw/xZvc0PTEX
	 rT8HoR1qIJzVIH8uZEmBOU5aal5VTUrGPcguHQiRl3B4mhd0UYgTjvox43zsBhCl5SROf
	 b1TNp9Y/QZVV+rp+mpvwopcUEpndBfG660Uk9qPxL2bT7a0OdQYXSyb6+D6XBCFJN6pMa
	 HanTaetZy6Jo2Cg5FxJSbWPoXrz0E0uCpV/flIuBJvgOwYFdkWqEC7GdJc+7+4UcNhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007739;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=GDBgSBwB9SZv912xAYmFSFm0+XZuKPzPjOZZNdWEPXQ=;
	b=Ylb1tuhyY+ljgr5b1/rENv/Fg/V+XerLmh/UQBJLTLt3JkTeBf8ZpgsXc2JIWG9FwBQe
	 hcJK2ExKrOg1Ud6Pux4R/5dlNwcilVs2qFcC4OKBAIPcGoaHEf1WE605IOy1ZNun1N9Ow
	 eCinXGoVp2pHlwZ1GF/+NToGFHEjQ7IBEnIS7eQ+IruecwUHUPOSYgwL86zkvHLjec+S7
	 OLqmH9lE202IS77ufjtmb7/yaVmTDmXxJFIv9XsvIv1HP0zS1LbT99TYW5ovbA7mQTMbn
	 yq1+0oRVJlLG4G/ITcGLCxkwqLOdiF4A1zUiJUgypMyLLiwxAk5PSsJEw+yreteaYww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gE1xSO8W;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C2606A33B
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 13:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 947C2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gE1xSO8W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795007737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDBgSBwB9SZv912xAYmFSFm0+XZuKPzPjOZZNdWEPXQ=;
	b=gE1xSO8WWn7BnShqmiifQY+VMN9xllmZ5+euU+vO5hBn2ChhwNexrsapHmSVQcp49xLnn0
	13uTGaKXFClXQGIKfbt9a4OtO09seF9b/i6qPoyyIv7TKntHL5PwQZIobqmlE6LfojwMVJ
	Z4/OTiGw42mYzlBDSA2h7Jq1nU2b0xw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-AFS-ZkdxPUGEJmj3ScAC-g-1; Wed, 18 Nov 2026 08:15:34 -0500
X-MC-Unique: AFS-ZkdxPUGEJmj3ScAC-g-1
X-Mimecast-MFC-AGG-ID: AFS-ZkdxPUGEJmj3ScAC-g_1795007733
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4a799d93bc3so276610f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 05:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795007733; x=1795612533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDBgSBwB9SZv912xAYmFSFm0+XZuKPzPjOZZNdWEPXQ=;
        b=pmiozBOZSzC6IZs/pQpLjKnLfO7/j2Mt3rKJg4gD7hN/9nCWISe/gOX5AezD837HFL
         Y/hV7xiX+73U0oLwksIoRFmL1ATkqaGfUbBlgtXWOeimytzaHq95GLZjax3zJ7dq1M/3
         ZrcG18IfRRxmmsdQijOHrtmqE8Ewt/WPIhBPCTaTp5q7PCjx4vbnfhYOtNSnlrn4r/mo
         nthYdbjWk03dYy2PS2uejobKglCTNZWXJJkRcjxEoDiKN4yoywlq9vkyZ24p8mQmaE+d
         kFVec+62FsP7Ex5UPM18yUpOoobM7S0aKuD8TVmrxDiWUTIYjAPpoiJUDWw/CK67I6CF
         CGJw==
X-Forwarded-Encrypted: i=1; AL+hErFo9GlyMVLjxzMtyVdA+TFWkHT93QR5HZEAWfhbdu/nwVCgdOR858CZU1BrJtw5VcFEFfac+2dRFwNN7zp3QQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/SBSSdurbO1qQGBlZ/GJ57ytFG+KGNlj/nkGbj2RvreHGN/AJL
	RRXs44i7oy5BHhT3U+aEKARw77vapKXO0wiLSLn4g73eiUmb0Wd2k1tHvB9SsyIHzsVmARB8mCK
	2R92j4KJdf50R549kwXBL39sr9ZY3VrqKusD8UbTkpDjIw1qPM0e4cjqGTykHTkdKibyA
X-Gm-Gg: AZFdTZfwTFLBUYGVs6PDo8E1iKqJ70t1NfYfZ7Jgvl6hJXmlAkX4zt0CxhsfFdkKYRC
	fk6q9AhuzbQRGY5ejfq7kY0kc7mldoa7hL2jS5YxbFwX/r/XYTarL6AWM0cfyYNQq8jw/7W4RDd
	KEhO7LRbPa5sqarOX/iIRJo+m+1vVvZAxo+8Z4GgSbCVZ8hm58R38dFZO6PzAZB9bla1xu/dF25
	gSCQ56YGnZ+2kVs0KZJU2dZVjzibIxTFRwyj/AY7Vav3N6b3ZEHw8x+fF1GkVZGeLMO9Xbn5+4b
	YKPeprmO07VdZabuqAW9QhXMoEm/pEsS5I1pssd49B8FBCGM/fzivwV/cZzV9upFNgBAqUW/Qsk
	R2VPkqq8JDMMAfI5yYm+NJEAKVkeIWIhdmuOwE078DUVROJloaadp+0DNDgTRzU2tYrhwvlqy7a
	DrdF8=
X-Received: by 2002:a05:6000:1889:b0:4a8:714:7ad4 with SMTP id ffacd0b85a97d-4a807147c78mr1864871f8f.32.1795007733003;
        Wed, 18 Nov 2026 05:15:33 -0800 (PST)
X-Received: by 2002:a05:6000:1889:b0:4a8:714:7ad4 with SMTP id ffacd0b85a97d-4a807147c78mr1864799f8f.32.1795007732558;
        Wed, 18 Nov 2026 05:15:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm4651876f8f.0.2026.11.18.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:15:31 -0800 (PST)
Date: Wed, 18 Nov 2026 14:15:28 +0100
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
Subject: Re: [PATCH v7 08/40] sched/deadline: Do not replenish a boost from
 cleared parameters
Message-ID: <av2k8JlLvUcBBOhn@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <cefacab5f1c0e7617f17e050af4ef5f6db01700a.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cefacab5f1c0e7617f17e050af4ef5f6db01700a.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nJ_5rnjJAF_jW5vN_xb2_amUAtOIG_CIUDhuWi-dFHY_1795007733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:
> When a SCHED_DEADLINE waiter boosts the owner of an rt_mutex, the owner
> runs on the waiter's parameters, through dl.pi_se. Commit 2d3d891d3344
> ("sched/deadline: Add SCHED_DEADLINE inheritance logic") calls this a
> temporary solution. The owner is never throttled. When its runtime runs
> out, replenish_dl_entity() refills it at once from the waiter's
> dl_runtime.
> 
> The waiter can leave SCHED_DEADLINE before the chain walk deboosts the
> owner. Its parameters can be cleared in between, at its 0-lag time.
> replenish_dl_entity() then loops forever on a dl_runtime of 0. It
> holds the rq lock with interrupts off, so the owner's CPU locks up.
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
>                                                                   sched_setscheduler(W)
>                                                                     W leaves SCHED_DEADLINE
>                                                                     task_rq_unlock(W)
>                                     <W's inactive timer>
>                                     inactive_task_timer()
>                                       __dl_clear_params()
>                                         W->dl.dl_runtime = 0
>   <tick>
>   update_curr_dl_se()
>     enqueue_task_dl()
>       replenish_dl_entity()
>         runtime += W->dl.dl_runtime
>         loops forever
>                                                                     rt_mutex_adjust_pi(W)
>                                                                       rt_mutex_setprio(O, W)
>                                                                         spins on O's rq lock
> 
> Fix this by reading the inherited runtime, deadline and period once, and
> by not refilling from cleared ones. They are cleared under the waiter's
> rq lock, not the owner's. So test all three. The owner stays runnable.
> It gets no runtime. A negative runtime is reset to 0: the owner's own
> reservation does not pay for the boost. An owner with no parameters of
> its own gets a deadline of now. A deadline of 0 would mark its dl_rq as
> empty. The wakeup of a boosted task already gives that deadline when its
> donor is cleared. The owner runs until the chain walk deboosts it, or
> until it releases the lock. That also covers sysrq-n:
> normalize_rt_tasks() changes the waiter without a chain walk. The
> warning stays for an entity that is not boosted.

The above paragraph is a bit hard to decipher. :)

Maybe something like the below?

---
Fix this by not refilling from cleared parameters. The donor's
parameters are cleared under the donor's rq lock, not the owner's, so
replenish_dl_entity() can see them change under it. Read dl_runtime,
dl_deadline and dl_period once, and bail out if any of them is 0.

On bailing out, the owner gets no new runtime, but stays runnable and
unthrottled. It runs until the chain walk deboosts it, or until it
releases the lock. Keeping it runnable also covers sysrq-n:
normalize_rt_tasks() changes the waiter without a chain walk, so a
throttled owner might never get to release the lock.

The bandwidth the owner consumed while boosted belongs to the donor, so
a negative runtime is reset to 0 rather than charged to the owner's own
reservation. An owner with no parameters of its own gets a deadline of
now. Its deadline must not stay 0: the dl_rq uses an earliest deadline
of 0 to mean that no deadline entity is queued (see inc_dl_deadline()).

Until the deboost (which should happen "soon enough"), such an owner
sorts first on its CPU's dl_rq and runs ahead of the other deadline
tasks there.

The warning is kept for an entity that is not boosted.
---

> The reset bounds the overrun. But a runtime of 0 still counts as
> exceeded. So until the deboost, update_curr_dl_se() still requeues the
> owner at each update. An owner with SCHED_FLAG_DL_OVERRUN still gets
> SIGXCPU.
> 
> With a 300ms debug delay before rt_mutex_adjust_pi(), v7.4-rc2 locks
> up in 8-CPU VMs. A kernel with this patch does not.
> 
> The Sashiko AI review of the third posting found the lockup. Juri Lelli
> suggested this fix in place of a larger one.

Also for other changelogs, I am not sure this kind of info adds much, as
I fear it will be hard to track down in history anyway.

> Fixes: a5e7be3b28a2 ("sched/deadline: Clear dl_entity params when setscheduling to different class")
> Suggested-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/avL8oOtjKqVNR7-l@jlelli-thinkpadt14gen4.remote.csb/
> ---

For the implementation,

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

