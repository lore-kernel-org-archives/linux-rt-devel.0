Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683240D588;
	Wed, 12 Aug 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530974; cv=none; b=X0RCdlT3Jv0YEIiPXWd93zF+66BDBaJysAvxE364Jp5fDly+ZC7r0Y2nE9IBK+t5r6VGTHP1iY869n0CUY2Io6BBtCG6FjNs9A+UtaWHT1HavurhbIhLrp5Y8x+9pq5l1csRFa6gFXzKSzdKyZfobLjEueQVspfPXxS0Va24H9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530974; c=relaxed/simple;
	bh=In4n7zaUEhQcOsYlsgozGp3p2gHUIYFWintylNw48SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCahtKV2tU/B3RYIfTybeC0Vka+NAObQi73oxDBgo3MQnCKYSrbpC04PC7kXGk1+LVt2WYgtr4ATKyluYng/VyqB+K3UdyJpNAuGfuvXCQFMpixThtDRBMt1Z/NlPWRQiHIYSLLMQvyKgoVUGDUw0pbIYJ5867U9lqo81s23qFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=abeExLCf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="abeExLCf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LoRAvIVf+P6rfQXUkcFpDnWcziKc/O9MHKr0HBMCv+A=; b=abeExLCfZBK8F+9Auswhxl8oUP
	U35xgKr06AmYv2SUNwDZgMBc6UJeURnQXnztq5LM/wKSEUajwIaF24J6u7FE89QiKckmv5Z5TuQJJ
	773YRghA+FtWY1TmQeKzGCpSzIDJxGZ3CEbRKIxghML6RLAdykcIEN1V3hYrI85TXsIAQsbEMl3A6
	a8YeGftJgmvdZwBm+hGHS93qj3kmHBYtyazOTHAOTtfUmJwW2cYrX0Fg33DFfLGlIXLxOOoeFiwY1
	C8G5taeO5El4xD74fuoHFq38OX1aIULlCEGQ1JSSTGH7OSi75GILIEph1fdSuCDySgEpNN6V1HoxB
	SKRVcD+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6JY-00000001pR1-3TWu;
	Wed, 12 Aug 2026 10:36:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7C53D300382; Wed, 12 Aug 2026 12:36:04 +0200 (CEST)
Date: Wed, 12 Aug 2026 12:36:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] sched/core: Pause KCOV in wake_up_new_task()
Message-ID: <20260812103604.GI776954@noisy.programming.kicks-ass.net>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <20260811154111.64669-7-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811154111.64669-7-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 05:41:11PM +0200, Karl Mehltretter wrote:
> wake_up_new_task() is uninstrumented, but CPU selection and enqueue call
> instrumented helpers. During a KCOV-enabled fork, they can record
> scheduler, hrtimer and clockevent coverage into the parent.
> 
> The paths depend on runqueue and CPU state, so coverage varies between
> identical forks. Pause KCOV for the whole function, extending the
> scheduler exclusion to new-task wakeups.
> 
> Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Notes:
>     v2:
>      - take guard(kcov_pause)()
>      - reword the pause comment
> 
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e863fac02e38f..f7ddfbbb5a494 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4947,6 +4947,9 @@ void wake_up_new_task(struct task_struct *p)
>  	struct rq *rq;
>  	int wake_flags = WF_FORK;
>  
> +	/* Instrumented callees would leak coverage into current. */
> +	guard(kcov_pause)();

I'm sure you know what I'm about to say now, right?
