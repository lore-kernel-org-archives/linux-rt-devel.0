Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F2429CCE;
	Wed, 12 Aug 2026 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530958; cv=none; b=b6mQnlLdG6L0My/Nhg28hiLyIuhVkgSQfiz/Ji9NpzjXS6QQXcuSkEfhxaU4WKTKdu9dJnbdSAbXcykPvipLbNK8D4i18A1rtbmo7WI2HJIK1GWG14ezneGftgvc6Gse29kS0S0c1JV6Ug1ZIPvgJn6iC4OwqYn7RNPIW+IctxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530958; c=relaxed/simple;
	bh=vPm3grlkHc6pD440XBA+E8sxb6nAqTB/ADO9KDCPaPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1ko4WWmiWEFIkh7VL4qzfKlhiEaSO4UCx+500X8bLK1DXeUr754X4IqfuXVkVbJBo4922iQ3r2tSfnJT6txzasHGmB5gXFttwGf9CLJGvM+gJz1q2EfvnS4Ohp+yibGJJrDecAFf778qXEtn+kEOlAeNfrqUEE3nHQg/W9kZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I5fZP8EJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5fZP8EJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3COCkry9q8e+KkRgduBrjMvDdbbEHNdYJdq2BIpVdRQ=; b=I5fZP8EJwRd5SV0eyb9nBMypxr
	hf+Z6d8SUxaH57ANiJhNoRv1ru/BV2iXPPXVpGfG7Tbgf9YwWfa5abZ4sNG6OvjCmSOMBwzK2Cf+F
	6nQhS+oQqz9AR6kPrnZAMSy9eOSfVsOLnQDi63yQscQ6FlXWX3crzllTEOjMM/cqE1d57uHBH0NLx
	YVzOqRY2zKWActZlfGCLekftSGhS0kDrOV86cEHLBbQARh1gke255FGmZkocFcuuXHzPDPUFCYUl5
	yA2r9pP+VAYEj4tKZUu4Ix40H0MzasRCH9F+73rrt3gzEpEcv89guqSR6v6kFYFzivfKRC4Tvuy1h
	hDfseKJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6JD-00000001pQA-32vM;
	Wed, 12 Aug 2026 10:35:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E73D3012AB; Wed, 12 Aug 2026 12:35:43 +0200 (CEST)
Date: Wed, 12 Aug 2026 12:35:43 +0200
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
Subject: Re: [PATCH v2 5/6] sched/core: Pause KCOV in try_to_wake_up()
Message-ID: <20260812103543.GH776954@noisy.programming.kicks-ass.net>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <20260811154111.64669-6-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811154111.64669-6-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 05:41:10PM +0200, Karl Mehltretter wrote:
> try_to_wake_up() is uninstrumented, but it calls instrumented helpers
> such as kthread_is_per_cpu(), CPU capacity helpers and SCHED_HRTICK
> arming. They can record into current while in_task() is true.
> 
> CONFIG_KCOV_SELFTEST exposes this under PREEMPT_RT. The interrupt
> selftest fails on x86_64 in kthread_is_per_cpu(): RT runs the timer
> softirq in a thread, so the wakeup runs in task context during the
> selftest's spin. The same helpers leak into non-RT syscall wakeups such
> as a pipe write waking a reader.
> 
> Pause the wakeup body with the kcov_pause guard. Wrapping only
> select_task_rq() would miss SCHED_HRTICK arming during enqueue.
> 
> Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Notes:
>     v2:
>      - take guard(kcov_pause)()
>      - describe the paused wakeup body precisely
> 
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e49f0bfa0ca73..e863fac02e38f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4253,6 +4253,9 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	guard(preempt)();
>  	int cpu, success = 0;
>  
> +	/* Instrumented callees would leak coverage into current. */
> +	guard(kcov_pause)();

Same problem again. All of this code is instrumented.
