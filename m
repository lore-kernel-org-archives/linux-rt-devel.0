Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404987;
	b=jSgYU90gayuubdltri/9F5DjF9BlcDLPiiZvQCHDxwEVOU94WwwiJvSLSQf3uB1mNGnB
	 YPC0Y6UszFKblv9wr4TaqtEHTPeVdaT5k4NgITB2KI/wwzcvXWxhd80asVSinUlhx5ArS
	 X08u66TXEqxDdc6zyH98PYIvmiqvpa9oCeYWpm9kMZlPLoy6yhgZ+hVJjReSAfc3hFP3X
	 bZfrTLqRUR0GdAc+IQhlbagxzPL289rR8Tfz3z0e78YWBzoQonX64woB/q/LNaLT7d1wq
	 VSBGpVoTRupWiHCUN8ajsbQ1ZX5TJ6XkP13B10+aLAI0E6H39PrV4uQnhsyMZW6jdWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404987;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=QrqbGrUeaMzxTtNKFPqZn9l9SynA7oL6rbPLiV4WlNk=;
	b=FtdPd+VlOL2MsqGDiDF0DttZB7Jy7E6SbO1pnr/CFoOoDBpgSTUBPxyrahGqmbYPobCk
	 Lo6Oy4ltwXijLHsZxfZEYG3pR8zKeS+9IMEV15R5fr2U7Pe86k0ljsVIGR84an0B7nURO
	 V3PSHLk3ydiMLbwCT7/Hv3q6KYKSl8qJlb8r1SNvpTKawLP8mHsK5ULdm/Q2YhasxIUWf
	 kqOqbAWjhgk43peqtTauOQBvQS7ZnudXOyCL3PAnlVYQYuGxmWmF6bgh5bDoJZfF2m/P2
	 MDUgueokPUR/Y3tOLGEtvYH+4DKvYj/Wlcryy8xw6O8JQn5kl2wEqhsrutIsEvvFeyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BmomZKnE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB169606A887
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 13:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB169606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BmomZKnE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794404985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrqbGrUeaMzxTtNKFPqZn9l9SynA7oL6rbPLiV4WlNk=;
	b=BmomZKnERiCLvTZBf+rGyUpjOH9owzoeey4V607+j5TL3slaQfmJPHlot0U3yUQyyHBn0K
	rFRLI14Wv6FNZGrRl0dxEAFPrfvUuPEglnR2rsSIJlchr1RL3GiOpzpqqhCLFduHQzBWTg
	o6UWVAirToOd/4tvemPnYAzZHonRlgQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-aEpRvi_JMOeaoNT2oBL5sg-1; Wed, 11 Nov 2026 08:49:42 -0500
X-MC-Unique: aEpRvi_JMOeaoNT2oBL5sg-1
X-Mimecast-MFC-AGG-ID: aEpRvi_JMOeaoNT2oBL5sg_1794404981
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e29c25101so1607695f8f.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 05:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404981; x=1795009781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrqbGrUeaMzxTtNKFPqZn9l9SynA7oL6rbPLiV4WlNk=;
        b=ogVS5HtSUwvvF6R8G/fODpHwWujq1x4JE34IM2n1fP/2FoYQbud0mP6wdBt0uNEF9M
         hWo1mwDpwSxalqG5PonTNoctW3Glc1t6X9yeIozb/yDaGUVa/4h7QkIY4WgLxXSzCXTK
         67K+TuPyCtScEAtxkctDTlpWDF6bygKHboJveHFQ6/3JJnCP1gl402XXYcow5s8ghtbV
         ErtweCqQKFOppql17/Ijc734U+isqLWKE5BCXLEprIIb2b3qzNOqrUxxKShnnK2Bw09w
         zPygMwKd2en5OEUUhwzuxXv0bVT6G60zTibL5YCYeUAMO+pneTQQL1p2EGCIcPYRuKWA
         qUyw==
X-Forwarded-Encrypted: i=1; AL+hErHSDE4G/WyBuhrBO8fX5EZM9pS232Z4uUXlzIvouTtxl9bJHT5azygkMN+1PSMy2N1YOrU8wLTqCW12OkpqBw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GpEtqiZZI7LmsQJJf17xCK5XDRs+DyBHyXOlLghl7IXaHCRkE
	1IqP+2jZ/hrtimenDby3CedscyLwFqdFb/GvMGUjldBDEnwvuKYEkpIVnUHVXVNXORqhNzts7P/
	ilIJwJz17kD0Y8izwOunPZBGWnje28ZvkLyqHy7OOIzcHbmjny8U78mtNqew3oHGUKkeP
X-Gm-Gg: AYBFou1jB7LhdBm4xqGok848w/gh9j6bABgMnc27hhBViy3QYbOSIr5Z+g3VInvZgWw
	JFSTUIM5OnO6x0iGsceAqk5VJgDvd6NNHSJakgfSb9jMb3C/MxYdnc4BxK6jrFhEB6tX0WaXCNS
	tk9PAM8f0xxsdmofsy/hOWEMB3VPS9Xx6qQqVwg8Fx4VXuedSyIsYJDvxcCBPpsJ558lZocpO55
	fgmchDpDjvA6xvyUGOGXe7hNRxu6Q6iC7nIfxMbh0r0lGSdMxl36AdGQMbT5Eac/61BR9rIksRd
	MssXvvSOyLtMcpKOaIuToOoZjmbhCobKM4xaqQBYxnneBxZ8O///2Q5LOUbgLZSTweMB70+wAMy
	Tg9quW1Oxox1bSgvMIG5gsTLtH7d+VfzgSDpBbp3yfRpxAsT94uNTzzilzc7CyKLpxP566uykSN
	9BDY8=
X-Received: by 2002:a05:600c:6308:b0:4a7:b304:253e with SMTP id 5b1f17b1804b1-4ba09381867mr49914195e9.22.1794404981075;
        Wed, 11 Nov 2026 05:49:41 -0800 (PST)
X-Received: by 2002:a05:600c:6308:b0:4a7:b304:253e with SMTP id 5b1f17b1804b1-4ba09381867mr49913635e9.22.1794404980722;
        Wed, 11 Nov 2026 05:49:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2f09sm159753605e9.4.2026.11.11.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:49:40 -0800 (PST)
Date: Wed, 11 Nov 2026 14:49:37 +0100
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
Subject: Re: [PATCH v5 14/29] sched/deadline: Fix this_bw when a task is
 changed during a remote wakeup
Message-ID: <avRycWTxtUr9gug6@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-15-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-15-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IuZRLIrUxtxftWAKk4gn6sdBdBFaEiFesFzuxvLpk-U_1794404981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> The this_bw of a runqueue is the bandwidth of the deadline tasks
> assigned to it, running or not. GRUB uses it to compute the inactive
> utilization of the runqueue. When a task wakes up on another CPU,
> migrate_task_rq_dl() takes its bandwidth off the old runqueue. The
> enqueue adds it to the new one.
> 
> Between these two steps, no runqueue counts the bandwidth.
> try_to_wake_up() can leave the enqueue to the wake list of the new CPU,
> and return before it runs. task_cpu() already points at the new CPU. A
> change of the task in that window gets this_bw wrong.
> 
> In this example, T is a deadline task that blocks on CPU 0. A timer
> wakes it up there, and try_to_wake_up() picks CPU 1. S, on CPU 2,
> changes the bandwidth of T from "old bw" to "new bw":
> 
>   CPU 0                               CPU 1                       CPU 2
>   T blocks
>   this_bw of CPU 0 counts T
>   <timer> try_to_wake_up(T)
>     set_task_cpu(T, 1)
>       migrate_task_rq_dl()
>         sub_rq_bw(): CPU 0 drops T
>     T on the wake list of CPU 1
>     return
>                                                                   S: sched_setattr(T)
>                                                                     task_rq_lock(T): CPU 1
>                                                                     T is not queued
>                                                                     dl_change_utilization()
>                                                                       this_bw of CPU 1:
>                                                                       - old bw + new bw
>                                       sched_ttwu_pending()
>                                         enqueue_task_dl(T)
>                                           task_contending()
>                                             add_rq_bw():
>                                             this_bw of CPU 1:
>                                             + new bw
> 
> CPU 1 then counts the new bandwidth twice, less the old one. Repeated,
> this makes this_bw drift until it underflows. If T left the class in
> that window, switched_from_dl() would take its bandwidth off CPU 1 the
> same way. A task that enters the class in that window would be counted
> twice, by switched_to_dl() and by the enqueue.
> 
> This needs a wakeup that moves the task, so a root domain of more than
> one CPU, with busy CPUs. CONFIG_SCHED_PROXY_EXEC=y makes such wakeups
> more common. In testing, a task sleeps and wakes in a busy two-CPU
> partition root, and another CPU changes its runtime. The kernel warns
> within a second in each of 8 VMs:
> 
>   WARNING: kernel/sched/deadline.c:352 at dl_rq_change_utilization+0x71/0x2e0, CPU#0: wake_race/109
>    __sub_rq_bw(): this_bw underflow
>   WARNING: kernel/sched/deadline.c:316 at task_contending+0x244/0x260, CPU#6: swapper/6/0
>    __add_running_bw(): running_bw overflow
> 
> Fix this with a new bit, dl_bw_oncpu, that tells whether a runqueue
> counts the bandwidth of the task. add_rq_bw() adds the bandwidth only if
> no runqueue counts it. sub_rq_bw() takes it off only if one does.
> dl_change_utilization() does nothing while no runqueue counts the
> bandwidth. The enqueue adds the new one.
> 
> With this patch, none of the 8 VMs warns. deadline_bw_test, added later
> in this series, tests this in params_waking and random_mix. The Sashiko
> AI review of the first posting found the double count, and a bit that
> the first version of this patch left set.
> 
> Fixes: 8fd27231c330 ("sched/deadline: Track the "total rq utilization" too")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

