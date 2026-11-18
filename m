Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016029;
	b=XJXWQo29S4SyfUQBcFQC1DrwPSN9KCM/2R0mh/P2MNmUDmjXF032+BWhRQHpN2iu1e6F
	 kuSuFDTExdjSPPlJWm2Hz8TBWbr1s2aGQspX+f4cwyKrBhHIqTebXH/T73vhZZGZLLoE2
	 ajvgGxhGd8BjmBTz4efqb0idl+3dzGo6ezOx3C3K+uLjWPGvjfjI5nOpQCWmkmYkdXpoV
	 JWY2aL5QPeW8k2ZvNM8I36m5LLMdigF1hVQUwwdKnGuzJltjC4drQxfeTm8n/CIppkkCI
	 lsUf+HI1LE7I8ggJKuqVksKYkGaML4FusPTSLKCM/99TiYWSK1IC0ymAlHL/awmGtRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016029;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=x85cpobaf638Fe9w3ZW1Zro4FQs+4uIPwl9i5atMIvg=;
	b=Th2S0jc+/BUfvGCKuCSZIKTm4KlD95Qdkyak7DxnMP0s/VpG+NhUEMvRErDejZlvwhZl
	 Z5oX74tiQ1nVKG7Kc0c1qHVq3wt7FVu7dUauiuklThmkBYSlWL/n/O9ym1Zm85piIBcC3
	 eeljXiUug1iVT7xXcow417O+OJOp5sM84Ww3Sg/ORZ1ahrJ3HA9hg9futi1raDoRVwmrJ
	 Yydhs0oXOOOWRWxX7WoBaQZrqiObvWC0LJJoblvc0Ey2d+aflCqNFIXVqQGHzAgbJPt9Q
	 cYYGudKSV+pO6ikVnyOg9T86kjd4IeVsfS7WPyEwPdySdgJtZmqFvtQeDzKpG6nmy/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jR6z1g3P;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5319606A320
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5319606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jR6z1g3P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795016027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x85cpobaf638Fe9w3ZW1Zro4FQs+4uIPwl9i5atMIvg=;
	b=jR6z1g3Pl7lB3lx1bZU2sMEsJNeB1Mo+CQpkJWPAsp0mZW5yKHYm9fUSmXX+NOEZWfR4ER
	PoLpZhj8R3xvge+Wtx8rZKdwH2SfjrO55XyAoN6EZVlwxa700OIqbl2Ku9TW3XirmCfgoa
	zIcntlHifRgpgVxu3icb79bMwqdMNhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-04-ORCPoORmEo2-6HDvBMg-1; Wed, 18 Nov 2026 10:33:45 -0500
X-MC-Unique: 04-ORCPoORmEo2-6HDvBMg-1
X-Mimecast-MFC-AGG-ID: 04-ORCPoORmEo2-6HDvBMg_1795016024
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49febef74e3so14438885e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 07:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016024; x=1795620824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x85cpobaf638Fe9w3ZW1Zro4FQs+4uIPwl9i5atMIvg=;
        b=kxQRaYCKW+xNaTbyl5TmJBmO2btmZHmA2mvNnxN/LJdB7jv3LnR8zbdkJhXwcF2kr+
         oe6EZH6YF9OGzcWxj7vJsrrFY6cTxTH06PM1b4cKiUdegPbNP740rEDbAznOmUKk+ft/
         53AybyTXNK/cm87ZyYRLTNoNBkv7WJ84r6mYUTt/C3WIrtN3pbYptK02nyF8JZ85wiZP
         jDHvUF2cuSUMppeA9ZHPjhyt7fAp6GBOLT+kqC9t2YfFmFCYA4g+R7pYNh1NoghtRJXq
         QWzzCNH8biMYD1DEwOBvEuu/vFgamN0RrcdNOovckIfCLh8ofDXPERw5okF7LK8erlRa
         dDsQ==
X-Forwarded-Encrypted: i=1; AL+hErF9NCicCy4ILLBaoZFz1sdDZlw254gdd4JBQZRuWEv1KXfjmgCXXz+YhrcR9aYvWWev4f5oDRbr9k0keWJCUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8GuzCCxjxS8irY67wTejP9Zmzb+Ujbg5WxrFw8vha/3pQ9umQe
	vLFy6iLxMScWIM4oqv7nSxU4muFsKj6vMhOY13v7cy6p7a1SzT9/RDvRU46jrcNqMBmKrPeGg7h
	go7adYaBe85P/4zXt9q/vyhribbOLvSfjfTw3Gdp7d9lx70+7zs/GKtZ/6akCbdrmlqwP
X-Gm-Gg: AYBFou1N2IS7egX8y2ttDPR1oS8IwTVozPdOJ0TP4yA5JhnUBye2OEDJowSNtFcriEf
	fptmujqeKllIUtq8E14sfo7OVkFiJvMTPOAi8wom3L9Vle/BTr3Wxq5c0bYik19bcf6759KltrH
	ckb2LN81nRFrBzFAHD0GDU+/BtmkxzZZZJ4+OQ8GDuj4cJK3pIus8h1PwQPlKgMEkrKncOomS0b
	rVR0vgNFItUSX7zeZ+5G2TwM+XJhsSRdIh8tVGB0SpDCrk1AzurOxYGMNCagPecHqL+/iPr4meQ
	KVlZhVZA9BQcevihv810H+WO4zSDN0J+NN3N5hB/bXRwAWO1fXmkL5OhoYPfDRW9YVCH6WgKvcR
	o3Uiq++rXZ0F6H3giPoEnWboYHAqXTw6quKDT0rSRr+etHNKXplBEd2HpoW1uF6gW6ACd3WOTZb
	bOhhA=
X-Received: by 2002:a05:600c:37c3:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb7d6cd4ffmr53090025e9.2.1795016024091;
        Wed, 18 Nov 2026 07:33:44 -0800 (PST)
X-Received: by 2002:a05:600c:37c3:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb7d6cd4ffmr53089605e9.2.1795016023651;
        Wed, 18 Nov 2026 07:33:43 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e50e992sm37379485e9.0.2026.11.18.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:33:43 -0800 (PST)
Date: Wed, 18 Nov 2026 16:33:40 +0100
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
Subject: Re: [PATCH v7 13/40] sched/deadline: Release the bandwidth of a task
 that leaves the class asleep
Message-ID: <av3FVDh4PX-5gWSW@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <a809425266acca7cfadd2e8187a7b5a815ba32cb.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <a809425266acca7cfadd2e8187a7b5a815ba32cb.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J6M8eChqqVSuULGjOBCcZvCSJghmsR6Jx_AzXRNJcFY_1795016024
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:
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
> But the timer is not always pending when the task leaves the class:
> - The task blocked after its 0-lag time. The timer was not armed.
> - The timer fired while the task was still in the class. It only
>   removed running_bw.
> - The task was woken up on another CPU and is not enqueued there yet.
>   The wakeup cancelled the timer.
> - The task came back to the class asleep. switched_to_dl() cancelled
>   the timer.
> 
> Then nothing releases total_bw.
> 
> Fix this in switched_from_dl(). For a task that is not queued and has
> no timer pending, call task_non_contending(), as for a queued task. It
> arms the timer if the 0-lag time is ahead. Otherwise it releases the
> bandwidth now and clears the parameters, as inactive_task_timer() does.
> 
> Clearing the parameters keeps later paths from releasing the bandwidth
> again:
> - A timer handler that already started finds a dl_bw of 0.
> - The deboost of a later priority inheritance boost finds no
>   parameters.
> 
> An owner that the task boosts as a waiter can find the parameters
> cleared too. "sched/deadline: Do not replenish a boost from cleared
> parameters" handles this, so a backport needs it first. Without it, the
> owner's CPU can lock up as soon as the waiter leaves the class.
> 
> Juri Lelli's first fix, since dropped from tip, released the bandwidth
> here without clearing dl_bw. The bandwidth of a boosted task was then
> released twice.
> 
> Juri Lelli suggested the call to task_non_contending() in review.
> 
> The Sashiko AI review of the third posting found the two cases with the
> 0-lag time ahead. deadline_bw_test, added later in this series, tests
> this in pi_former_owner_asleep and deboost_released_resets_period.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Reported-by: Tejun Heo <tj@kernel.org>
> Closes: https://lore.kernel.org/all/2b5fb3f22bca6aa383be8f4781923392@kernel.org/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-2-dd761fe005b4@redhat.com/
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

