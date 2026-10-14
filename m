Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACFF3DB30F
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993934; cv=none; b=AEIOKJHD4HvsGgm5MGdgSLHdhgesmadH2ysKRztrjK4sqMxGHhFJ1GP2mdSql5vGJM/GdOa9TDQzlUX3nrST3oNwuNK1cZo3YtXLouIMWArW7sLTurRGwHwdpmqVz38vMeLVb4zQwaYm9dfuGfFN7kh2id0Z5vtpb5QDkbOhIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993934; c=relaxed/simple;
	bh=TvVa8VD1/jSgIE5rJZj/6VyTJ2z2mRr4KL+bt64zyp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NivkFnbulTmTv8mDhvvP+2R+eNp+aR6dkKOT8GCmGeSc+9a6XxoOY9ZuO0rNoCcZgttMgEpxyY4rmtxLN8nAJfghZ1n7qeFSWpqozso7KUfivTLT05yq9tGEEuoogqwhtBXUnVC23po3cgdOkVifCopXR5f7C1BNJa5n0nPOarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=g7h5Tw52; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="g7h5Tw52"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id ED5B012065D;
	Wed, 14 Oct 2026 16:05:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id D8B2C34;
	Wed, 14 Oct 2026 16:05:22 +0000 (UTC)
Date: Wed, 14 Oct 2026 12:05:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>, Boqun Feng <boqun@kernel.org>, Lyude Paul
 <lyude@redhat.com>, Joel Fernandes <joelagnelf@nvidia.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Jonathan
 Corbet <corbet@lwn.net>, Bradley Morgan <brads@mainlining.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>
Subject: Re: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20261014120524.5e6e6efe@gandalf.local.home>
In-Reply-To: <20261011060742.30584-1-kmehltretter@gmail.com>
References: <20261011060742.30584-1-kmehltretter@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D8B2C34
X-Stat-Signature: 4ytci1imuk6j68rhem6xiqeus5bpcii4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18kNUPpWgNdwoIYJtq6y1/YSNUaniTWa2Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=wgnkwS81DfcOH3m8SDI9jB+FxQMIwgwNYQYXq22rC+g=; b=g7h5Tw52Bk8d79HZYF2VBj+bjy7gLs+wPGWbBfXgn1TdVukCGhWCITdKnZ7MLmPsvXhBTjd2L/5fio6w1DIVwVEYwSKLEr0itAiFVPzU/6wuo6lSe3e6E+SLHsow0eF3/oa9py0wNCLLL7mSXB6mOA1uIsj2N25pd4fmFZEecco=
X-HE-Tag: 1791993922-392996
X-HE-Meta: U2FsdGVkX1/GohG4bVfb6S1Vt0LfBt9h+d0r0pWOzdtSqJCxoHdavacBAITVFOr6RWFwqXh92ZPryF7AY/lYJIeqz0QmZfun7Z0X7V0FI1H0wwigS9LVXo6RnEilfvgv1fe1EDRV5Cl6T2+4FaPxmnKX3aen8ZGs7Omm21udh4XN4/oBIy5GWT+8SFRrtwDr4jf57UaR18qSaAPZohWYhRPeZ0P1zrPZb/uK9LZ33X22NhTMBxoiOwtsJnUZx+IWyMN825jI8vBLdMvFEEEeJaaNT7Gim7H21R6ClvffLpvg4yVGaPoYoOsk/0uhc1fQ2JqerFIuacs6aXfgms4AOIaLG5NuDKl7sZINXwj/6cBrLKHZ8Uj9+VTEWtnUp8BGRHoYWZC/17jnNwIzsQ+ZoXUqkSRifuHy+ohhvSkto5OZs8fYPxKNh8y2XZnksULd0t7m9gZDxqlmPzFXMlDuxgpDRhN5S5gh4EKAwcF5lOs=

On Sun, 11 Oct 2026 08:07:42 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> __irq_exit_rcu() removes HARDIRQ_OFFSET from preempt_count() before
> the IRQ exit work. On the outermost IRQ exit, with no NMI or softirq
> state remaining, this makes context checks report task context. The
> softirq-dispatch, timer-wakeup and tick-exit checks account for the early
> decrement, but other code reached in this window sees the wrong context:
> 
>   - ftrace, perf and the ring buffer record task context and use the
>     task recursion and context slots.
>   - KCSAN attributes accesses to the interrupted task. KMSAN uses and
>     changes the interrupted task's KMSAN context. KCOV and the printk
>     caller id see a task.
>   - On PREEMPT_RT can_spin_trylock() and local_trylock() reject hard
>     interrupt context to avoid interfering with PI when the interrupted
>     task is blocked on a lock. Those checks do not reject calls made in
>     this window. BPF programs attached to sched_waking or sched_wakeup
>     can reach the trylock path through kmalloc_nolock().
>   - An oops kills the interrupted task instead of ending in "Fatal
>     exception in interrupt".
> 
> The early decrement predates git. No failure caused by this
> misclassification is known. lockdep is unaffected because
> lockdep_hardirq_exit() is the last operation in irq_exit().
> 
> Keep HARDIRQ_OFFSET until the end of __irq_exit_rcu(), including
> tick_irq_exit(). Softirq handlers must run in BH context, so replace
> HARDIRQ_OFFSET with SOFTIRQ_OFFSET while they run and restore it
> afterwards. Use one raw counter update for each transition to preserve
> the preemption disable location recorded by irq_enter_rcu(), and update
> lockdep explicitly. Detect IRQ exit with in_hardirq() in
> softirq_handle_begin() because __do_softirq() can be reached through
> do_softirq_own_stack() and cannot take an argument.
> 
> Adjust the exit checks for HARDIRQ_OFFSET still being present. Use
> irq_count() == HARDIRQ_OFFSET for softirq dispatch, as in irq_enter_rcu().
> Use hardirq_count() == HARDIRQ_OFFSET for the timer thread wakeup and
> tick_irq_exit(). NMI exits use a separate path. An IRQ nested in an NMI
> has an extra HARDIRQ_OFFSET from NMI entry, so it is excluded too. The
> timer thread check must ignore softirq_count() to allow wakeups when an
> IRQ interrupts softirq processing or a BH-disabled section. The timer
> thread handles all pending softirqs, including any raised during its
> wakeup.
> 
> A softirq raised from a tracepoint on the final preempt_count_sub()
> waits for the next interrupt exit and can trigger NOHZ tick-stop
> warnings. Handling that instrumentation case does not justify a check
> on every interrupt exit. A tracepoint on tick_irq_exit() can also raise
> a softirq after the normal softirq handling has finished.
> 
> The number of counter updates and interrupt time accounting are
> unchanged. The preemptoff tracer now reports the interrupt and subsequent
> softirq processing as one section. With nofuncgraph-irqs, function graph
> tracing also skips the IRQ exit work, including the __do_softirq() frame.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> 
> Changes in v6:
> - Keep HARDIRQ_OFFSET through tick_irq_exit() and use
>   hardirq_count() == HARDIRQ_OFFSET for its nesting check (Frederic).
> - Update entry.rst to document NOHZ handling before the final
>   preemption-count decrement.
> - Test in_hardirq() directly in softirq_handle_begin() (Frederic).
> - Drop the in_nmi() test from the timer thread wakeup condition
>   (Frederic). NMI entry adds HARDIRQ_OFFSET, so the equality check
>   excludes IRQs nested in an NMI.
> - Drop the earlier Reviewed-by tags pending reconfirmation of the
>   tick_irq_exit() behavior change.
> 
> Testing:
> QEMU IRQ-exit probes (v5/v6):
> 
>                                                         v5          v6
>   Tick-exit calls (hardirq/total)                   0/5553   5339/5339
>   Tick-exit function-graph records                    5555           0
>   KMSAN selections (task/total)             427205/3492324   0/2992433
> 
> The two tick-exit rows count tick_nohz_irq_exit(); function-graph
> tracing used nofuncgraph-irqs. Captures had timer activity and zero
> trace loss.
> Each KMSAN kernel passed all 28 KUnit tests; those tests generated all
> KMSAN reports.
> 
> Additional testing covered 67 guest boots and 10 kernel/softirq.o builds
> across five architectures, including RT/non-RT stress, KCOV
> configurations and 600-second rcutorture.
> The KCSAN probe deliberately triggered reports to check IRQ-exit
> context.
> 
> Matched configurations of the unpatched base and v6 were compared on
> Pi 400, Pi 500+, BeagleV Ahead, AMD/KVM and UP ARMv6 Pi 1B+. Pi 500+ and
> AMD tick-exit traces confirmed hardirq context with v6 and zero trace
> loss. The NOHZ_FULL tick stopped on both versions on Pi 500+ and BeagleV
> Ahead. Pi 1B+ base/v6 workloads completed without reported errors.
> 
> On physical SAM9X75 (cpuidle-at91), base/v6 tick-exit traces showed
> hardirq flags in 0/556 and 540/540 calls, with 558 and zero
> function-graph records under nofuncgraph-irqs. Both kernels showed idle
> and Ethernet activity, with zero trace loss.
> 
> On Pi 500+, accounted CPU time exceeded wall time under intermittent
> workloads on both the unpatched base and v6. No v6-specific regression
> was established.
> 

LGTM.

So this handles the transition between hard irq and softirq?

I wish there was a way to get preempt count updated earlier on entering a
hard irq so I can get rid of the transition bit in the trace recursion. As
there's still places that can trigger a trace in the hard irq before
preempt count is updated.

-- Steve
