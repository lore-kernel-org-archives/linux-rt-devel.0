Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58678F3A;
	Wed, 12 Aug 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530930; cv=none; b=eS7nChKtpKuSA9oT/MToqemyrwW71ibAyy3gCHz20cuLDHDpRwPfRI+EXn1JDV+iqPiySxWDOR5Ti71w+tIQCGqWMaISwiyUZytCSpNXwgJSSD+9GhB9ToUFTW4YZ6ieBzyET0cMLNO3Xz4AQze7BQrsLG4mLEILNC8DACJIEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530930; c=relaxed/simple;
	bh=gG21ZO1/5qp9SKYLXAxzze5wJI50FOtSM20o2mTfBQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOD0ufOegIDkA6L96UBCs4jaZO0ocl4u3EqKgUmKLcQWgAKlwTwWgeln2SX4WSXNwZBYBEz3l09lusTJ/Ev8oRjZNb6JnPsp25KhHwcDKlStyUPgnJpC5EGlC+/9GKVM7fexQDfVOdr1lTSlosZWCCDfoaNl4+t20JlytummVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=paD6Puon; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="paD6Puon"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=708L8P9d07d0ljHL2Nibd6fJkNaukUu054I+c42ZSEQ=; b=paD6PuonGS3awSOTyFirAQDzNC
	O4KdkWw150YvUtsvsoZk5EIT33sG+2ZMu/Nvr9Yr1oNNFEpNwApIHNAnb7dnXQZ6wAzBkGQucfM8B
	1qvVeaBbag+e/FYwpKhPvEI809AZzay81D3mtcIuMqvfeWyE7uxcYwPSmzWvIVYL6V1Hb0JvwOIWS
	2e0bh2OFwMbDmzf48MNmhHJIyX0xf3oRPVZNyicurTVwBUtqIKa+104HuQF1kCTlfBHg4Z7R4pt7l
	U0dpiZRAV5xA2c0yA2ucZaPKSXJKQA1S53JAb/0rKuW/0rntPLIJqFvd6hqqMuOtoR0ENFQnNcQTt
	EVAuxv6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6In-00000001pOU-2473;
	Wed, 12 Aug 2026 10:35:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 977333012AB; Wed, 12 Aug 2026 12:35:11 +0200 (CEST)
Date: Wed, 12 Aug 2026 12:35:11 +0200
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
Subject: Re: [PATCH v2 4/6] sched/core: Pause KCOV in __schedule()
Message-ID: <20260812103511.GG776954@noisy.programming.kicks-ass.net>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <20260811154111.64669-5-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811154111.64669-5-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 05:41:09PM +0200, Karl Mehltretter wrote:
> kernel/sched/ is not instrumented, 

It bloody well is; there is no noinstr here, just a notrace.

> but callees such as sched_clock(),
> architecture CPU-capacity helpers and profile_hits() are.
> 
> During preemption and schedule() calls, instrumented callees can add
> nondeterministic scheduler coverage to current.
> 
> With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
> selftest fails under QEMU, detecting spurious coverage in
> arch_scale_cpu_capacity().
> 
> Annotating each callee would spread exclusions across architectures.
> Pause across __schedule() instead, extending the scheduler exclusion to
> its callees.
> 
> KCOV_PAUSED remains set while a task is switched out. The guard in its
> resumed __schedule() frame restores the prior state.
> 
> Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Notes:
>     v2:
>      - take guard(kcov_pause)()
>      - clarify the test configuration and reword the pause comment
> 
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3cbf817f52a4a..e49f0bfa0ca73 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7073,6 +7073,9 @@ static void __sched notrace __schedule(int sched_mode)
>  	struct rq *rq;
>  	int cpu;
>  
> +	/* Instrumented callees would leak coverage into current. */

This comment makes about as much sense as your Changelog.

> +	guard(kcov_pause)();
> +
>  	/* Trace preemptions consistently with task switches */
>  	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
>  
> -- 
> 2.53.0
