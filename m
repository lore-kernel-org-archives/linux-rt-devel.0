Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F7519E15;
	Wed, 14 Oct 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983966; cv=none; b=WJFg3fzM/k9ENF9g7HlqacuaeF3kS1J2Bu9BK1u4YN5c0iAIk/1cp3W0zB2gSj4cVuPzhcfRv1cv71X62owappZev4JEcojC335F/8rNWVZYEtt1oTHlSgRWxnCC38eS3A26zKPrY6Y58UXU3y31udztNYjYssiK0kBx8z/uBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983966; c=relaxed/simple;
	bh=uaiGgrGG503lygQoD1TkFzsttYu2oumGISniMtzuEac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiCubc9WoubZ3waMEnvItdSiIBRFCoBiTXfrZS6mE/BMYd9ugR6NKLboikBwJHysDSMmlgg2MkFUhKS1FzWXJXtO9PMD/zNerw0grR8Zi+cFuT7kneoI9XBNYj8GA6WeJK7FjZsPuHFDkByaj2QtvRFwqAXwZBy0G0tvjH+/rTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LurmvTeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LurmvTeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AA61F00907;
	Wed, 14 Oct 2026 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983961;
	bh=9lqmNqph/NmDgl+ER8M2XQtqx8qAD+LKW0gr+nEYDKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LurmvTeIXSUWZQebtHo97qzfQAH3TW/WiQsh4lwRc+CAjIQZbgybYs0fUOSfBjeQ5
	 mV4Sl18v9dqs7W2jGk5Ymw5NdcbZl2BkuGv5pPTc4h12PEvtYBwj6y7GhAEZVrwJSv
	 F+TpzXJl5sBih3giUVRaC85iyFpvin9bissRrV83ekZQqSvsVAJUBc102K3fx0m43R
	 y8OHQKnNfSlXn3TGCJxVCe6LMJXNob4xaKzJ/KBqsiwaO+A03cMi3mCakNn0NVoASR
	 xPP+VQssvMvsnsu0DyZuM8hobrIFJKjtR5cLAYBkohqtTlHkmEQba2NlUmFdfhJEmj
	 8szDg5EbSWgBw==
Date: Wed, 14 Oct 2026 15:19:18 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
Message-ID: <as-BVqMyaphswYz0@localhost.localdomain>
References: <20261011060742.30584-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011060742.30584-1-kmehltretter@gmail.com>

Le Sun, Oct 11, 2026 at 08:07:42AM +0200, Karl Mehltretter a écrit :
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

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
