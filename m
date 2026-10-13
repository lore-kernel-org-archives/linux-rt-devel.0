Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1E4F5DE4;
	Tue, 13 Oct 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892990; cv=none; b=bazX5ZIQ7qln0HLKQONQATK4Js52TjP/QUD8oe1NQNd5ULN9a7z1r2x0LgjTMbniIijYKGNjOyV27N/5OfZfpu+vZKBRKe0aRli9aqYuohpMhwaJDrDoPEjWXMlwF0cjx02kAYSyUwK3b42/TyZ9k8aXULLTw4kRmH6yDab4bOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892990; c=relaxed/simple;
	bh=TINdVUVnB8Zko5Okti+SHy5lVWI/uFlhVZbLYF+cxxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4syiqYEapOQHp4YjBmr8tsHDpTsrHGrCnr64NvKWDpVXS1iH9vKV3DUCw4b8ciq9E6Y0KtQ3eQVE5FUz9vVLQHDiZ7DNoTXbouKFiS0SGKap9x7Wab1M4/UTx4EC/p4/6hc1V625hp5+a7VKujrngxG6+H03F74HsocdAJzqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FKJFambo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKJFambo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YZOl0/Y1fZ+ipz8NqERLgfXbsWKnbtJ7TTNXDXnL3Q4=; b=FKJFamboC5lv/hXtJRwYIpyQ6O
	3fs2ip7l20xXY3qn4SKttEsTm3LmSTvYgJPcaBfi+tkDbkeB8kn31GocY1mlWpJurBOFLk8K/Dlpy
	7M/LY0eVTN2eXY6p7DvCSSE5zaU5xr6T3KbD1DrPEQ4MqSwt2CJSZCLAiv+M7z2LtbUoH1//b4vHv
	ISZzYnOjs/hcpd9Csci2tKSbp44UBxGNkgWtsCsnlNABlolcWPtsyFrkdk/vGaJff4h3Ft52z0tsX
	AKgeV98lgYcYZUraFA0PUBoowYJEmHX9doWMbKDYT0Z1amHQ5n+sEIsTia4X+F4/xTT0nEzcQaqUo
	vpUowDRw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGbDj-0000000D8ON-2dRr;
	Tue, 13 Oct 2026 12:03:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3B8930063F; Tue, 13 Oct 2026 14:03:02 +0200 (CEST)
Date: Tue, 13 Oct 2026 14:03:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: wangqk1 <wangqk1@xiaopeng.com>
Cc: linux-kernel@vger.kernel.org, xiedl3@xiaopeng.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 1/1] sched/rt: Avoid RTO push to stopped CPUs during
 shutdown
Message-ID: <20261013120302.GJ2009045@noisy.programming.kicks-ass.net>
References: <20261013030140.682182-1-wangqk1@xiaopeng.com>
 <20261013030140.682182-2-wangqk1@xiaopeng.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013030140.682182-2-wangqk1@xiaopeng.com>

On Tue, Oct 13, 2026 at 11:01:40AM +0800, wangqk1 wrote:
> During system poweroff, machine_power_off() invokes smp_send_stop(). A
> CPU receiving IPI_CPU_STOP parks without running the CPU hotplug teardown.
> Its RT overload state can therefore retain a stale rto_mask bit.
> 
> A CPU still executing the RTO irq_work iterator can select that stale bit
> and queue work to the stopped CPU.
> 
> Observed call trace:
>   irq_work_queue_on()
>   rto_push_irq_work_func()
>   irq_work_single()
>   __flush_smp_call_function_queue()
>   generic_smp_call_function_single_interrupt()
>   ipi_handler()
> 
> Stop RTO forwarding after terminal system states begin and skip rto_mask
> candidates that are already offline.
> 
> This is a workaround, not a complete synchronization protocol. The
> cpu_online() test is not atomic with irq_work_queue_on(), and panic or
> crash-kexec paths do not set a terminal system_state before stopping CPUs.
> 
> Signed-off-by: wangqk1 <wangqk1@xiaopeng.com>
> ---
>  kernel/sched/rt.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 85303add726d..716ac30c5afb 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2084,6 +2084,14 @@ static void push_rt_tasks(struct rq *rq)
>  
>  #ifdef HAVE_RT_PUSH_IPI
>  
> +static inline bool rto_push_allowed(void)
> +{
> +	enum system_states state = READ_ONCE(system_state);
> +
> +	return state != SYSTEM_HALT && state != SYSTEM_POWER_OFF &&
> +	       state != SYSTEM_RESTART;
> +}
> +
>  /*
>   * When a high priority task schedules out from a CPU and a lower priority
>   * task is scheduled in, a check is made to see if there's any RT tasks
> @@ -2131,6 +2139,11 @@ static int rto_next_cpu(struct root_domain *rd)
>  	int next;
>  	int cpu;
>  
> +	if (unlikely(!rto_push_allowed())) {
> +		rd->rto_cpu = -1;
> +		return -1;
> +	}
> +
>  	/*
>  	 * When starting the IPI RT pushing, the rto_cpu is set to -1,
>  	 * rt_next_cpu() will simply return the first CPU found in
> @@ -2155,8 +2168,13 @@ static int rto_next_cpu(struct root_domain *rd)
>  		if (cpu == this_cpu)
>  			continue;
>  
> -		if (cpu < nr_cpu_ids)
> +		if (cpu < nr_cpu_ids) {
> +			/* smp_send_stop() does not clear stale rto_mask bits. */
> +			if (!cpu_online(cpu))
> +				continue;
> +
>  			return cpu;
> +		}
>  
>  		rd->rto_cpu = -1;

This is horrific; lets not do this. The bug really is at the place where
you randomly and without warning take CPUs down. We're not adding random
hacks for things like that.
