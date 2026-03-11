Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39F2D3739
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Mar 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221588; cv=none; b=WQvcprBvAUkEh0QbrICzHUFDY9DE9recbgtzN8I4O2UCscOvUuNFZDjCbyWzQR9TNRlHWxdk/r6FLzz/IM8ieBfr+7xEXZIeUxw2WlRCks7vaxNV/d+Z1tgH+ATlr3UtLWZ77B9EPO7WnrxvtgnCuLI3L9avuBza4f2KKm2rOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221588; c=relaxed/simple;
	bh=Uo/WFMyyLYkQK2fW4PX3D2jIIaJrDZZFvmXbqR7i1BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJOEJBgJjZV5Kep/o98vF2598Ai4AMPvHhqEDk39Ve3vHUoFEKXsXyBaYvJLhrnRSeB7+7VBOMtPaLSQ+pJ5moWVgmKqGmLWJiA51+X9ZGgMBz+xeNv9m8HRhSUMA5F9eaBhTTpbbdkyTkX9q/l4eixcwcH20EP/1LkSzh4j6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YBV4dH62; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t0ZgbFzx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBV4dH62";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t0ZgbFzx"
Date: Wed, 11 Mar 2026 10:33:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773221584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPO9/jAsrJnbrmUysSJObJZpJ0ZJ8yKQltHxnfgv7YA=;
	b=YBV4dH62x9FvTSEQrBopLe82NB0FZ44mbh50EQ95urlQIeoA0BRf4G8Na4uZCliHNE9zA+
	IHnKYDwDTvbq2+h6QeVEIPiHKSao/1fRquFlfTxBzIgeVHH4mfqb2ggFDjkl33TKC3DTle
	0oxHh0ync9HV9QHdEKFdyojyKq3UVt5XYOWPOkYoD+fbl5xk2TDFRgFhA4n+yNyRguFgVC
	gETMbmmJnDEbqPWVvO7VaCeH9SpNG6gsWNL4l0lmI9oEVyENpXuJvRLpQjcsTr7ICxwcd3
	P4+Q8v5OAcRr+RmMg7yff0H7HuIGI3LR/MY/zBndv76untISINUYViaROZviMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773221584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPO9/jAsrJnbrmUysSJObJZpJ0ZJ8yKQltHxnfgv7YA=;
	b=t0ZgbFzx84VZWDD0ueg5Zc9cIURpgeQC8jfVDPqiTqSWdoaXE+stpLlIXfTSa7mmZIkzbO
	nDcem4uZ11wVG7BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	boqun@kernel.org, longman@redhat.com, clrkwllms@kernel.org,
	rostedt@goodmis.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in
 bh disable on RT
Message-ID: <20260311093303.4_1N-y3-@linutronix.de>
References: <20260310115534.3477871-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310115534.3477871-1-jackzxcui1989@163.com>

On 2026-03-10 19:55:34 [+0800], Xin Zhao wrote:
> In RT-Linux, when enabling CONFIG_PREEMPT_RT_NEEDS_BH_LOCK, calling
> __local_bh_disable_ip() when !preemptible() is illegal because it uses
> local_lock, which might sleep. The only exception is during the
> cgroup_init() logic in start_kernel() while preemption is disabled,
> cgroup_init() calls cgroup_idr_alloc(), which calls spin_lock_bh().
> It is sufficient to only exclude the system startup phase in macro
> DEBUG_LOCKS_WARN_ON.

No, cgroup_init() should not be quoted as an exception. It is okay to
exclude cases while the scheduler is not active because here lock
contention can not happen.

> Although the original check of this_cpu_read(softirq_ctrl.cnt) can also
> prevent the WARN_ON print during the boot process, it may hide some issues
> that should be exposed immediately. Because softirq_ctrl.cnt maybe 0 when
> __local_bh_disabled_ip() is called in !preemptible() context.

That is actually the point. If it is known that the call chain does not
origin from bh-disabled context the it is fine. Well, not fine if you
stick to the details but good enough if you don't to constantly complain
to everyone about the little things which don't make a difference.

> In RT-Linux, __local_bh_disable_ip() will be used by numerous _bh variants
> locks and local_bh_disable(). Since locks call __might_resched() check, we
> analyze the scenario of using local_bh_disable() in !preemptible() context.
> 
> If CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled, __local_bh_disable_ip()
> does not enter the local_lock lock and thus using local_bh_disable() in
> !preemptible() context does not lead to might sleep problem, but using
> local_bh_disable() in !preemptible() state is not meaningful in RT-Linux.

but it does not cause a locking or scheduling problem either.

> In non RT-Linux, we use local_irq_save() followed by local_bh_disable() to
> keep soft interrupts disabled after restoring interrupts. However, in
> RT-Linux, when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled,
> local_bh_disable() merely increments the softirq_ctrl.cnt counter without
> actually disabling the soft interrupt behavior, because other tasks on the
> CPU can preempt the task that wants to disable soft interrupts and execute
> soft interrupt-related logic.
> Consider the sequence diagram below:
> Task A                        Task B
>                               __local_bh_enable_ip()
>                                 __do_softirq()
>                                   handle_softirqs()
>                                     ...
>                                     local_irq_enable();
>                                     ...
> local_irq_save()
> local_bh_disable()
> local_irq_restore()
>                                     h->action(); -- it is serving softirq
> local_bh_enable()

Okay. How is this a problem? You can enter this scenario event even
without disabling interrupts within Task A.

> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

Sebastian
