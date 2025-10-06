Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEB247281;
	Mon,  6 Oct 2025 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777678; cv=none; b=QGon7vBFmNeB9rnuJmCrqsMurK4sR3KGhjaXKuSowwp1suvQoP1wU3Gxm89i+BSi3Cf9QUAHzzN8x2GmLwrpAlvDeGDGHnrjvmGPMncpRkLWjky8ggAwfw8RV1obxNK7Nm7oMrr0AM/ARTXyRBK9GUcZT9UhtRxpKfS6btnCMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777678; c=relaxed/simple;
	bh=K++5qxJVpYqWIl/13U8wEuzPuzmB0ihAKHJzOja16LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXEwR/NDeYDjBuTagGqXvvx8PPCyLYUC29lGb5CuHZtFGNNcNZh6FWvoUV4xxkbeQ0VULGI2E80a4gWeY7Tcn3LscGLM2TDv6+E9rq5xfQmddedsMPXdDAWfut8hKdw2s4BHBDt7G3bNeG8nXIcDUyaFDDsSfp61PwxSaBLrZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cKaSIEWl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cKaSIEWl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Gt6UOW/sVchKMmtHmO/QIVQId/DdO6/CiuTOEihhEPo=; b=cKaSIEWl3S9EuI52fXbr9UQl3o
	eK8mc2PZIaxMQ9t5WI0kcHPz1IC+mCSReym7NzbC4Og13D7RtOp7OQe2d8zfX4bjDpKgPJGjmydWa
	TczjmNdAuvpoyFuYdy+I0kbVIRB945K87HCTKvOCHiPstsrIAim+c3T6qd6lJfLvUIJFMnWwIbruw
	y+MNuilGsstVRRLWpAIeVHHn7NWjS+dMjWvJKCQ6thcApbvUNt/gYw8OLvAb7oDzy5N8Lj6V00Ey8
	+91opC2ib1Rr3IggpvpRpi1NKeOULpR6sz8AKLWQWQaLTSSFd8Ad4lQ3z6xTXkeGDzFyOUVKKB+FK
	7yk+Lsog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5qYd-0000000H7kP-49ye;
	Mon, 06 Oct 2025 19:07:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 86AFD300325; Mon, 06 Oct 2025 21:07:39 +0200 (CEST)
Date: Mon, 6 Oct 2025 21:07:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: cuiguoqi <cuiguoqi@kylinos.cn>
Cc: rostedt@goodmis.org, bigeasy@linutronix.de, bsegall@google.com,
	clrkwllms@kernel.org, dietmar.eggemann@arm.com, guoqi0226@163.com,
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, mgorman@suse.de, mingo@redhat.com,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH] sched: Fix race in rt_mutex_pre_schedule by removing
 non-atomic fetch_and_set
Message-ID: <20251006190739.GZ3245006@noisy.programming.kicks-ass.net>
References: <20250826095615.14259d90@gandalf.local.home>
 <20250827081750.3606616-1-cuiguoqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827081750.3606616-1-cuiguoqi@kylinos.cn>

On Wed, Aug 27, 2025 at 04:17:50PM +0800, cuiguoqi wrote:
> The issue arises during EDEADLK testing in `lib/locking-selftest.c` when `is_wait_die=1`.
> 
> In this mode, the current thread's `debug_locks` flag is disabled via `__debug_locks_off` (which calls `xchg(&debug_locks, 0)`) during the blocking path of `rt_mutex_slowlock`, specifically in `rt_mutex_slowlock_block()`:
> 
>   rt_mutex_slowlock()
>     rt_mutex_pre_schedule()
>       rt_mutex_slowlock_block()
>         DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock)
>           __debug_locks_off();  // xchg(&debug_locks, 0)
> 
> However, `rt_mutex_post_schedule()` still performs:
> 
>   lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
> 
> Which expands to:
> 
>   do {
>       WARN_ON(debug_locks && !( ({ int _x = current->sched_rt_mutex; current->sched_rt_mutex = 0; _x; }) ));
>   } while (0)
> 
> The generated assembly shows that the entire assertion is conditional on `debug_locks`:
> 
>   adrp    x0, debug_locks
>   ldr     w0, [x0]
>   cbz     w0, .label_skip_warn   // Skip WARN if debug_locks == 0
> 
> This means: if `debug_locks` was cleared earlier, the check on `current->sched_rt_mutex` is effectively skipped, and the flag may remain set.
> 
> Later, when the same task re-enters `rt_mutex_slowlock`, it calls `lockdep_reset()` to re-enable `debug_locks`, but the stale `current->sched_rt_mutex` state (left over from the previous lock attempt) causes a false-positive warning in `rt_mutex_pre_schedule()`:
> 
>   WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:7085 rt_mutex_pre_schedule+0xa8/0x108
> 
> Because:
>   - `rt_mutex_pre_schedule()` asserts `!current->sched_rt_mutex`
>   - But the flag was never properly cleared due to the skipped post-schedule check.
> 
> This is not a data race on the flag itself, but a **state inconsistency caused by conditional debugging logic** — the `fetch_and_set` macro is not atomic, but more importantly, the assertion is bypassed when `debug_locks` is off, breaking the expected state transition.

Yeah, I can't really make myself care too much. This means you've
already had errors before -- resulting in debug_locks getting cleared.
Fix those and this problem goes away.

debug_locks is inherently racy; I don't see value in trying to fix all
that.
