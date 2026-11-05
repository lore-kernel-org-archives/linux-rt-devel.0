Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876022;
	b=o4OWTw/Jw5293Ov8ymY6XXtfPGj5KnuG0uoz8lHBE7Dt5pVMNkZRsCoEPlLdMufWLLpX
	 bAcK3yjOjVMkFi4la8bDeV6VXDbdvhQJND4ejbtNMBpAZdg/Mk0G/MG1CgUBVBDlp6aB4
	 ggJpyA+ihNBbfGpTYSzBGxhMLnfKhlw4toUOzUBRvG6shsKitWj0RFG9Kdo9uG9MCsmVl
	 1AQJ/tjEpTXxo/hx9eiHQ3XmQ28jbN6MCG2Pjrk+30Vi9BSvjrxmULwzEamyFQq9wA9uu
	 f3aG1K6tPIc+LfNDZoYttGj1qOiBWlM0FPKciuEG48za3+78LlGlj0KBef3WUDOenig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876022;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=oydf0WShTzs9KXsUGEwBFf3FiP0jpqy13hriGlAhxmA=;
	b=ikLJECUmlWxJT82rXHxycLw7iI4C/4SQpVgQ9QJl9q2XSzfXxE91jnrLacvXhUtzBkPH
	 +jhSZQ+GFChz00yl6ft+vSntug0XOE3o8lpssD7RFtC6sbGiWfLEYfsP5uIbPl1Gk2rE5
	 OHlo9PbEdYL2rfYMOTHjSC3Izg8b/9QiDKDipNEMNph9C60m/USGs8RgSoqOQAKPjieGf
	 iF65FQ03SRAN5ElDKT7SCwbr4ibSg/JmHVBRjOfOFHCjlACWMQXWRHVbFHJKR08r9xN58
	 WFazaaLH+AEh6/WLmwNDj4BGI7L8gfsc60lHderhDR2GJ5OzdG4lD4ZuG8ngtug6bvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJhdRZaT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11914606A31B
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 10:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11914606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJhdRZaT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793876021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oydf0WShTzs9KXsUGEwBFf3FiP0jpqy13hriGlAhxmA=;
	b=XJhdRZaTmaJV1wO67iNDI7eaGs0nMi5DGzpU3zV1b/2zQaYvtmiTNNU1H8E1/Q2mvYO/Zj
	jyibJ3ykWXvUd0bEZr+4b0boLyeejPAo/uolI9UHjL2KjVAIa2cXTSu82CZzHTq0DJxYBd
	GzChAlUJZqV3kxIgKiJDe74Uz8bekmY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-GC-rtAdtNeCrl0XpHhn5Wg-1; Thu, 05 Nov 2026 05:53:39 -0500
X-MC-Unique: GC-rtAdtNeCrl0XpHhn5Wg-1
X-Mimecast-MFC-AGG-ID: GC-rtAdtNeCrl0XpHhn5Wg_1793876019
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a9d51dc486so3674105e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 02:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876019; x=1794480819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oydf0WShTzs9KXsUGEwBFf3FiP0jpqy13hriGlAhxmA=;
        b=tPwy63+7ctfOnfN6spXhX8g5w1Np6v0RK0QymX1e52WhStvxOaDUOFRq2N2fpxu7yT
         6Dz3gkvR99UMF7ar9IRwE4mNBKKmLOVxzVUZzbru6pSfW2bSKUxTi0HYB6+GFJGeyFDU
         7vknuiO59K1XFIg4PO+Qo7Wgdl5Y7AGJrFysp6VefRgLn9ItVs0ADp+xa+f2l3uSze+S
         FPs+paoSYdlL6rKQCIS3fsNHpc2xEDkf4mn3FH8nZenbnFZGaBkzIgat62L0BOaGV8tz
         9Gdb28sqHF2WP3R+QVKyotKlcIv3WC7y6+6vR4GL6CKHJiH7ueUvci2Fo1fXF0NVQqwA
         k4eA==
X-Forwarded-Encrypted: i=1; AKwUvByd+7I5JLmNTAuWEpJrgYCOwgPEyJARUP3GsLBjrzWpH+aRKRnAZvGhViUAZ9MPXRYC/CDPrHWKrJNaqpiHzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9c3q9py6Z7nSpup0UukJKld2SzYymXMUwFRzAIMOJGQuXXfMfF
	LvsqskU77XFoTPgvWd5UG2HDLgdKeZpepZs+CeN1zy/qrBttPuWN08eiEIaEWFYEXGRZF8sANlw
	t2Z8hA1NQ9YDczxyq2cqCPzSpdJF23KSXiCugNGwlzT5xNpqHLQeNIBH2XJaY3MZV9CYW
X-Gm-Gg: AYBFou1mFK1SCnzmtKJayDet5HO+5I5YBbPf6jRPBogYqSxoX9hFvYHghZQgG9p7HaO
	z9VulomnUO70/WVvtbqxLRVEosWqJ9Vr+tbCN9EF/M8WRME5adwBWi5+IRrmChsHNUR7yZJyEe6
	srcm81NlyjJ3ma8WBsWzKbx4NAT8A31Pi8YwFi34SCsVHo14j5JTrsK59FzmEanoDHisCLXfdQx
	ylwvCaW3yO4CYCNN5BsBSDd5QwDO2XqDmH3Q2P4l0JcutUOysKaV5ZJ3bw0RivJ5MtErRv5XfvF
	sDM/Fh98SYu/EI2EYuvzcEK0SajQwsNKtyVMkYInk2XuKmRyLWs6p8Xk6SUJkRHmqyROaTP0iTb
	W8Gly1pPA98CdCvxAVOnnQ0KSwWJnCuoqjMVq2KkfqdWSwDgl+4AJoxNiVGLs2yiWCMvIyi6Al5
	seQQ==
X-Received: by 2002:a05:600c:1989:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b55dbb09dfmr39312175e9.13.1793876017140;
        Thu, 05 Nov 2026 02:53:37 -0800 (PST)
X-Received: by 2002:a05:600c:1989:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b55dbb09dfmr39281275e9.13.1793875986470;
        Thu, 05 Nov 2026 02:53:06 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56eb4da1esm94641375e9.6.2026.11.05.02.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:53:05 -0800 (PST)
Date: Thu, 5 Nov 2026 11:53:02 +0100
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
Subject: Re: [PATCH v2 04/21] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Message-ID: <auxgDv4hE-MLnM4b@jlelli-thinkpadt14gen4.remote.csb>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-5-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104211207.1392343-5-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yz3p3bXbJ2DQ4uFj62g0-G9NO6hgcyVYs1oB60qLfKE_1793876019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 04/11/26 16:11, Mathieu Desnoyers wrote:
> __dl_sub() and __dl_add() spread a change of a root domain's total_bw
> over the extra_bw of its active CPUs, dividing it by their number, which
> their callers take from dl_bw_cpus(). That number is 0 for a root domain
> whose CPUs all went offline, such as the default root domain, which
> holds the offline CPUs: the division then traps.
> 
> A debugfs write of a fair server's runtime or period reaches it while
> its CPU goes offline or comes online. From the rebuild of the root
> domains in sched_cpu_deactivate() until the CPU is offline, and from the
> CPU online until sched_cpu_activate(), the CPU sits in the default root
> domain, with no active CPU. A write that leaves the server's bandwidth
> as it is passes admission there, __dl_overflow() comparing that root
> domain's capacity, 0, with total_bw less the old bandwidth plus the new,
> 0 as well, and dl_server_apply_params() divides. Any other value is
> refused with EBUSY, higher directly, lower through the unsigned
> subtraction. Once the CPU is offline the write is refused, since
> commit 4043f5498416 ("sched/deadline: Reject debugfs dl_server writes
> for offline CPUs").
> 
> Writing a fair server's own runtime back in a loop while its CPU goes
> offline and online oopses on the first round, in 8-CPU VMs of v7.4-rc1
> with the four deadline fixes of sched/urgent:
> 
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   CPU: 6 UID: 0 PID: 110 Comm: dl_server_div0
>   RIP: 0010:dl_server_apply_params+0x335/0x380
>   Call Trace:
>    <TASK>
>    sched_server_write_common.isra.0+0x1c0/0x260
>    full_proxy_write+0x58/0x90
>    vfs_write+0xcb/0x550
>    ksys_write+0x6c/0xe0
>    do_syscall_64+0x109/0x5d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> inactive_task_timer() can reach it too, found by reading: it releases
> the bandwidth of a task that left SCHED_DEADLINE, or died, before its
> 0-lag time from the root domain of the CPU the task is on, and that CPU
> may go offline before the timer fires. With admission control off, so
> may sched_setattr() to SCHED_DEADLINE of a task asleep on an offline
> CPU.
> 
> With no active CPU there is no extra_bw to update: change total_bw
> alone. 20 rounds of the reproducer leave no warning then.
> 
> Fixes: daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl tasks")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/sched/deadline.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 963fda6ddb7f..dadda1a528ec 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -189,18 +189,25 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
>  	}
>  }
>  
> +/*
> + * @cpus is the number of active CPUs of the root domain, whose extra_bw
> + * shares the change: none once they all went offline, and total_bw alone
> + * changes then.
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

I wonder if it makes sense to add/sub from total_bw when cpus == 0.

Wouldn't be better, if possible, to avoid calls with 0 cpus?

Thanks,
Juri

