Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395436;
	b=JNEL7BVwIO6BqPqu4L1l2VKkceDNmfKGOkXmsAfmXiBI7KQzrmzlE1acn6ntU0G8Vdg5
	 4LgyBU2kQ78smIQnB6nd9COrceJ0IJKkUlZ6D6I8vqg3az2E+2UvI3x0Ceebicm8mxm0j
	 AIT5NgFghyzEvwqI3IUFTWURtWYFa+PBdKDNcMy6bZI/LRXHhF3a1hfDxVi47HwP4MCiI
	 8b7nfmHxXy6OrbQYKtTwU7vpTX/5KEGa6FVER0kCauC/OualEP8nSrk+gO2M2rdaMZgNd
	 SaGkk+DS8Io8N4QH/JqdwbswWEJWhlK1rNF+9HoiJH+y7l0ZRBeoCJb32umJ3nDcmlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395436;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MPS9RDCKJsXmogjILpx6IfNjyJ/9Sva18zyFQsvPCR8=;
	b=1l/hkaYOiMc46yVThfn1cYpabZAyfRbRU+8ebJjQrWfyRqUpAlELBmbS8qzpkCK1ysYS
	 R/MgHxIKcyQ6vI+hFYCp0BZSIfe41x+FoFC4HLRlvppQ6k/cHfsouPWa/+prrOS/EQN0F
	 1hzpjZlRD7HjMVG9Lq+rRtXp3w8ri2xVtZGRbPAHdi8LrHDDG50echB+RGGdLZp2V8G1+
	 3zC04EbpX5yiXtf0nzZcY/K2w+NS0YHOKN44saAuLyclDaQMfKlIxRzu3aMRJd2g+dSv+
	 BAxA4mR0wl2spq6ROc2jEwIsUCFo7Zr+uYROCDQEjtXxnS6AQQ6GU6TPxeQR1g3bxpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=IM42Jxh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2E606A98D;
	Fri, 30 Oct 2026 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=IM42Jxh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA511F000C1;
	Fri, 30 Oct 2026 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793395435;
	bh=MPS9RDCKJsXmogjILpx6IfNjyJ/9Sva18zyFQsvPCR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IM42Jxh5ux0XJor0AFuAttJAvIMJ6d58hMioBo9mpOFm61SkgVY9UfLa1mUWWDBS4
	 8o4/couykb5LBUPdW319mSne0G0NHI76tIe/XODdH+EaxxJ+K5QvdcjAX2nEP9fWcZ
	 9sAfeJrJgbpXTXFHNrk7EhoGsOJA9gEUXGqQCmvs=
Date: Fri, 30 Oct 2026 14:23:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko
 <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Marco Elver
 <elver@google.com>, Bradley Morgan <brads@mainlining.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] sched/core: Pause KCOV in __schedule()
Message-Id: <20261030142354.bbc5e7f26fbfb6a8eee21290@linux-foundation.org>
In-Reply-To: <20261005185803.39170-5-kmehltretter@gmail.com>
References: <20261005185803.39170-1-kmehltretter@gmail.com>
	<20261005185803.39170-5-kmehltretter@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 20:58:01 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> kernel/sched/ is built without KCOV instrumentation, but it calls code
> that is instrumented with KCOV, such as sched_clock(), architecture
> CPU-capacity helpers and profile_hits().
> 
> During preemption and schedule() calls, these callees can add
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
> ...
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

I applied this series and poked around in kernel/sched/core.i, with CONFIG_KCOV=n:

> @@ -7123,6 +7123,9 @@ static void __sched notrace __schedule(int sched_mode)
>  	struct rq *rq;
>  	int cpu;
>  
> +	/* Callees instrumented with KCOV would leak coverage into current. */
> +	guard(kcov_pause)();
> +
>  	/* Trace preemptions consistently with task switches */
>  	trace_sched_entry_tp(sched_mode == SM_PREEMPT);

This expands to

 class_kcov_pause_t __UNIQUE_ID_guard_1782 __attribute__((__cleanup__(class_kcov_pause_destructor))) = class_kcov_pause_constructor();

and class_kcov_pause_constructor() is

static inline 	__attribute__((__gnu_inline__))
		__attribute__((__unused__))
		__attribute__((no_instrument_function))
		__attribute__((__always_inline__))
class_kcov_pause_t class_kcov_pause_constructor(void)
{
		class_kcov_pause_t _t = { .lock = (void*)1 },
			*_T __attribute__((__unused__)) = &_t;
		_T->paused = __kcov_pause();
		return _t;
}

Adding all this goop to core scheduler functions on non-KCOV kernels
won't be terribly popular!

A bit of macro magic can trivially make all this go away for non-KCOV
kernels.  The overhead is probably acceptable with CONFIG_KCOV=y
kernels - seems it's only enabled for debug/research/fuzzing kernels.

Ditto the hrtimer change.  Aim to make these patches produce no change
in generated code with CONFIG_KCOV=n.


