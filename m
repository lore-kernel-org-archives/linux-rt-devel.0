Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682435A398
	for <linux-rt-devel@lists.linux.dev>; Sat, 19 Sep 2026 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789804274; cv=none; b=AQQVSAMBOtEVkSxfLBXYOUQGoxG4ioFXpAqgETkB25YK2iBe3ZH2Hcc82EqsSEnqKeKiy5kaHweeHZTOTNHL6cJRIHMf+VH7H5acpZ+8UC6EmqL4tyW75Nd12TcmKq+qOh2pu2ZcPqdIXZl/64F4mjlnuQkpnZZq77TCDA7qy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789804274; c=relaxed/simple;
	bh=SdGg69Lf2f/c7zlOy+yoaONpEyD18VUSaXFrrrqP2pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPlvwWjwPRvG+hfROwA5RnGj2AwoC4yphc32o/ZS9/hbqCK1v67v28Uqy+I/wyU8eUSckXfckBHxWrlC5U1D7kZZqCzG+iUiIpmyrTR32bGqcQ+ZzMCAG+pFJlmKxPl8g8gZfnnzoaEQNiUS+dFQDzWR7s/4p3JzMxyFhy2fRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3TE8gyc; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3TE8gyc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso18913735e9.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 19 Sep 2026 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789804271; x=1790409071; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRlk/WUzRZ0e9+e8R5qbLxPWlUEapE9AWMafOSpJ4n8=;
        b=k3TE8gyc6wujT6JD1/6CGvRRs0sF3Ztb3ou+i/SEeeHQa1VSUrFgyIESG0PlKefkZ5
         IR/mBX/01p/2eY6jNqIbh2iPgqIJGBHu3HCI/5r8YdcrmNDu9ig5h73g0NuDIY8B2NYl
         zqwzSiC/HoRgKa6dReRx+09nS4EhZKDuPlPsBAn4lZr9wXCv1vxhHgkgu6okjfFe1Pa4
         00iiycviHLOJwskyUlRXT2gMWU9O3NKrxAoB+a9PvuAgHZxJB8z3+jprVmkKXS5KGqSL
         6gBkhaXVepwof9b+jPenTfpA67HrakfDOv7H/Eana9uabwQB3L9yxBpGLmSvFvftqX4w
         kn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789804271; x=1790409071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nRlk/WUzRZ0e9+e8R5qbLxPWlUEapE9AWMafOSpJ4n8=;
        b=tslggeYgMzaOYPaomH1cTxwTOpCCKRJtzSArDwq/tb+QHE/jjW8bEnT8fpWwBzVjxt
         q/dUsGf/nbZoi1Mwq33P1bZIyJxKHPDl2NiltxiHE7MkWTclooGX0RNAHksii3bjH9JT
         eco8QvA6i3Gz6q4sAhyw9FkwgJTekEuM6Th0iILaEvwmHHeFCyI6BtDmW/Al0XkGPOKE
         g80NMXmDLZHyfmNFBFqkLr6lOWGFu5NIBj/Xww6eLoAcm7k9kf0rXKhq5ylqLlQa5C4x
         SrcgawtcOXeY08oT7DFvEyKaepxzm5CEu9wwh8OGNvLzvbB+bKUB4FVrvIBkxfuRFNVu
         /9mQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3APTYzzSQbrKFJhcXf8NhBoEg0+oma5uUoUBmMBmgxOgakuwJ6xn9Bj8/5tq9oCwQjd+98m29b4gv+B1f8Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kl67MgzBydi5aapXqumU1ktGplOS3upIj2qqhfjJ8LZyePUe8S
	65W7zxyBywa2H9G799Rne0Z4maUe9MHav3SchSAFE6pYf5+cGgun9epJ
X-Gm-Gg: AYBFou10qiyYBdUel300izAbgbfMMMNLdxSs/+lGO6zA4HBNlxGnBtZ6V+tTdcDoNTn
	g7sJrRvRhPEZo6vM4tukSt392/u5KbQ7s/w/m0PSAxgzaRKBFyq0JIe7giK7dVsmc1566h1Y9Fr
	ry47cdGodIZ40kX8BsO+5eynjmE7OtWLu1WY+L8uthTBPy72oq/4IvhFWY2k3IT/Xus8WVYiPtF
	UWl4uA0G9cSt8G5r2m5W/Ih/J+6kcpJB8zvC6roCk3BDKZZdGhWsL0kvu6/ZoKzZJhzqVWfFIf+
	HS+6czJNcqvu8DT+qleHP8nSvMhC/kHI52giCYC152d15HDAgLQWbsT3HG9KTQTMhqpx/07SQ6S
	MJXnZvqISkkLHXjjs17SVpx1yhyJJyaXdv5a8P7OcsvKw47s8oSURh4vyTyKQFtI7K/LynEEMxA
	b8eEAbq3LYyZWsoVBNe5f1Tqqin5gcfkz6YSZZpD9mI4bc7pVMSTEhO5hOKzjZMsuTkKhPUbA09
	7R79vHOmfh3vUJYwu8z9YSNtVH12d6oF70lrMayk3ec0ZuqHqgqaKzKHq9XUVlpZ+d8mKkGFKoK
	YJl2zB3EuAM0BuRA7wkT1S8+p9Bx1N4dGdu8RpFQh5JshpRlWEj6+DN3UL2fI2XlkeA5XPkxb2+
	BnW4lbjA=
X-Received: by 2002:a05:600c:4e86:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49fc566e6efmr63350715e9.4.1789804271212;
        Sat, 19 Sep 2026 00:51:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245636f2sm4701823f8f.17.2026.09.19.00.51.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 00:51:10 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] softirq: Preserve interrupt context during IRQ exit
Date: Sat, 19 Sep 2026 09:51:05 +0200
Message-Id: <20260919075105.34023-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260917152150.dvEKJ8B3@linutronix.de>
References: <20260905023210.82853-1-kmehltretter@gmail.com> <20260917152150.dvEKJ8B3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-09-17 17:21:50 [+0200], Sebastian Andrzej Siewior wrote:
> The breakage is limited to KCSAN & friends within the window during
> transition to softirq and out. There is nothing else? Well, the timer
> wake looks wrong in trace, noted.

I know of nothing that is broken today. It is more than instrumentation
though. Code that reads the context from preempt_count sees the
interrupted task in that window. Besides ftrace, KCSAN, KMSAN, KCOV and
the printk caller id I found:

 - can_spin_trylock() and local_trylock() on RT refuse hard interrupt
   context. A trylock on top of a task that is blocked on a lock
   confuses the PI code. In that window they do not refuse. BPF attached
   to sched_waking or sched_wakeup reaches them through kmalloc_nolock().

 - oops_end() and make_task_dead() test in_interrupt(). Today an oops in
   that window is treated like an oops in task context and kills the
   interrupted task. With HARDIRQ_OFFSET set it panics with "Fatal
   exception in interrupt", like an oops in the handler itself.

 - rcu_read_unlock_special() and raise_softirq_irqoff(). See the end of
   this mail.

I'll list these in the changelog. I will also say what the patch does
not cover. tick_irq_exit() and the other deferred rearm sites still run
after HARDIRQ_OFFSET is removed.

> /*
>  * This is only entered on return from interrupt. Preemption disabled
>  * locations remains unchanged, the context (-HARDIRQ +SOFTIRQ) is
>  * updated and lockdep is let known.
>  */

I'll use it, reworded, and add two points. in_hardirq() is sampled
because __do_softirq() is reached through do_softirq_own_stack() on
several architectures and cannot take an argument. The raw operation is
used because the preemption disabled section from irq_enter_rcu()
continues.

> The casts look odd. We need this? It is defined as long, yes, but
> preempt_count accepts an int only so it will throw the upper bits away.

The value is the same. Without the casts gcc warns:

  warning: overflow in conversion from 'long unsigned int' to 'int'
  changes value from '18446744073692774656' to '-16776960' [-Woverflow]

-Woverflow is on by default. I'll swap the operands:

	__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);

and use __preempt_count_add() at the end. The difference is positive
and fits an int. No cast and no warning.

> I think we want to ensure that irq_count() == SOFTIRQ_OFFSET

Will do. This path is !PREEMPT_RT only, so irq_count() is the plain
preempt_count() one.

> that is quite some WARN_ON_ONCE. We would like to see just
> HARDIRQ_OFFSET at the end. Or SOFTIRQ_OFFSET before the end. One should
> be enough or the math is wrong.

softirq_handle_end() will have one. It checks irq_count() ==
HARDIRQ_OFFSET after the addition. In softirq_handle_begin() I will move
lockdep_softirqs_off() before the assertion. Then the lockdep softirq
state is consistent if the assertion fires and printk runs.

> irq_enter_rcu() did preempt_count_add(HARDIRQ_OFFSET), did record
> task_struct::preempt_disable_ip. [...] This looks like an improvement.

Yes. The preemptoff tracer changes too. It reports the hard interrupt
and the softirq processing after it as one section. I'll add both to
the changelog.

> Why is this preempt_count() instead irq_count. Why is there
> IRQ_EXIT_TIMERS? It is almost as the first check except now we would
> like to ignore the additional softirq_count().

Yes, that is the intent. irq_count() would skip the wakeup when the
interrupt hit a BH disabled or softirq serving section. The old test
did not skip it, and nothing else handles pending_timer_softirq.

I'll drop the macro and the raw preempt_count() and use

	!in_nmi() && hardirq_count() == HARDIRQ_OFFSET

This is the old test, evaluated before HARDIRQ_OFFSET is removed. It
reads like the first check without softirq_count(). I'll add a comment
that says why softirq_count() is left out.

I also want to change the order in your code. With HARDIRQ_OFFSET set,
raise_softirq_irqoff() does not wake ksoftirqd. rcu_read_unlock_special()
raises RCU_SOFTIRQ instead of setting NEED_RESCHED. Both assume that
interrupt exit handles pending softirqs. In v2 that is not true for a
softirq raised inside wake_timersd(), because the wakeup comes after the
pending check. The timer thread would handle it, because run_ktimerd()
handles all vectors. I do not want to rely on that, but wake the timer
thread first:

	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
	    local_timers_pending_force_th() &&
	    !in_nmi() && hardirq_count() == HARDIRQ_OFFSET)
		wake_timersd();

	if (irq_count() == HARDIRQ_OFFSET && local_softirq_pending()) {
		hrtimer_rearm_deferred();
		invoke_softirq();
	}

	preempt_count_sub(HARDIRQ_OFFSET);
	tick_irq_exit();

Today the wakeup already runs before the rearm when no softirq is
pending. Does the old order have a reason that I do not see? Then I
keep it and document that the timer thread handles such a softirq.

Karl
