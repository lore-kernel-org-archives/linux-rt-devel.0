Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06428259C94
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502557; cv=none; b=iZHK/EcDCNTpjo2dNt8xVDGVAlgGNrQ2xwe2dAjUTnUJFOXFaDAUQZD4TeGP5uKL8pJy0aCEzasmCIUunzGUQRGYC+RDIg/gOAgvlicykuctX+3TgpdOaWlIsCv0tR7gVAN4oNBPTgYywAiCLUiXYWv7fjm3v8YHxJqjMZCq0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502557; c=relaxed/simple;
	bh=n24eQ8LHgGDDv2ugupnTXxv0mbA6T1YDoBoGXgQpG6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR6yW2EG4o3DFUkqKzRw1fZLU/4ZhS8QGT9f+Xn6H5Zs8R8kHVAQnTzFLaP+l4Y8/W7nm0dqYV7EUAXCll6hT93c57QysOupiDwwYdBQjq42Tw1I0LQ7R8tRL+jSQ3Ce+gXCluNmyge00o65tLWR+MvoFWxMVXTUCbJjEgpDvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mdOdDiaf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=apuRX5PM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mdOdDiaf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apuRX5PM"
Date: Mon, 14 Jul 2025 16:15:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752502552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17Qqqm75cz837kgNMKsvPCvgtSIkAYWoBnH00UWbgM0=;
	b=mdOdDiafTTKGKKfV+Wq/LOt+7ohyqyUelW5q52J56UfF+VAMWjmvHYsiCDcyigEx8tTmZR
	x5W0VeNZy2eApHbdhRDa2JheghC0F3wPIjV0W6O78o0jNFwmIF5zHCCMFTHO7GnngiWUl8
	OMHcQHz1gfsfrK5JxOw214EJFg//sky0ZUzILQPBnYowz8BI2LlWjFiYOZNuxXgOT3c5j5
	8SOETUV5z1PowdIJty3FnUCbUy5Dcf2/hwLGt7T56OetnRGZC1361bjbTCrlq8s+tTg1y6
	2x4HH4hJTC3SirVq4aA0CCdw2cynWMKDnpoLpotEhwrKslgfS7kkqpQi9mTfgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752502552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17Qqqm75cz837kgNMKsvPCvgtSIkAYWoBnH00UWbgM0=;
	b=apuRX5PMnL4qY3MEu+5CEnKqMxKwhuRHRFv9JNqGdT8ZUpNGbS69yhQ/z5Aadv1Lg68p7z
	1HfcYMAwNP8KaLAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>, lclaudio00@gmail.com
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250714141551.l07CZvFl@linutronix.de>
References: <aGvTz5VaPFyj0pBV@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGvTz5VaPFyj0pBV@uudg.org>

On 2025-07-07 11:03:59 [-0300], Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
> 
>         rt_mutex_adjust_prio_chain()
>           put_task_struct()
>             __put_task_struct()
>               sched_ext_free()
>                 spin_lock_irqsave()
>                   rtlock_lock() --->  TRIGGERS
>                                       lockdep_assert(!current->pi_blocked_on);
> 
> This is not a SCHED_EXT bug. The first cleanup function called by
> __put_task_struct() is sched_ext_free() and it happens to take a
> (RT) spin_lock, which in the scenario described above, would trigger
> the lockdep assertion of "!current->pi_blocked_on".
> 
> Crystal Wood was able to identify the problem as __put_task_struct()
> being called during rt_mutex_adjust_prio_chain(), in the context of
> a process with a mutex enqueued.
> 
> Instead of adding more complex conditions to decide when to directly
> call __put_task_struct() and when to defer the call, unconditionally
> resort to the deferred call on PREEMPT_RT to simplify the code.
> 
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Reviewed-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Side note: This simplifies the call chain to always free the task struct
via RCU. This also means that the stack is not immediately available for
recycle (CONFIG_VMAP_STACK) but after the grace period. Based on my
testing the new task was also deployed on a remote CPU therefore I
wouldn't worry too much here. Just wanted to point the only difference I
could come up with.

Sebastian
