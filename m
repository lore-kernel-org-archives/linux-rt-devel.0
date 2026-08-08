Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810B2EC08C
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Aug 2026 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786152530; cv=none; b=KWMwaFzotbf365IUseA9h1lMK8jKQB0Peezln5b41QO5qw+m+jqP0qiAHnbUWVM/rrWTBNIkPAR6CyjBb6q8WSMh3BtPBpeQG0NCE9JI3olV39clpRAvRrFvF8mtBm9SKy/e6ahXhF33E0tXE7bub7CnDAef54lPEwc/gt4zgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786152530; c=relaxed/simple;
	bh=Wb9u+Dnx0F4XMJU/na7Hrbj+SYbk8MWRLGsQ87VLwZU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sQqrD9BvElvm0XeXtqWfXtrGxDRwWk9v5/A5HTZxzj6kdLN6jseW+CgwY8IKUx+mxWbQMcuCnHhihIzPUs9+leNK07ary19lBNNay3mzdwUkh2ER0yJ0Ytqn7LBYmlhmDv5GMye05RG7Ia2IfiXQ6PgavrfwV2h4PnxAdTSezFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=EBexOl7Q; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="EBexOl7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786152520;
	bh=g1wIUfbG4rpWH+kuBByWLcbiEwOL3Qbc/uWA9H4JYX8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EBexOl7QybAND4674CubIdmjd6PXrXPv88R0sZn6l3GMKBZ7jDx66TNPWEJbASrf9
	 3bM/fH3PXop/ZKcv+NLHCuhXMXcVxL8rwm4Uv+td/R8P3YAUEdupNGvILDSQwp7loW
	 MpXdNB57uzmSkUBgW3uLk6LGbBL5yngt3LkmNNlI=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hH3Lw2BlGzGpKL;
	Sat, 08 Aug 2026 01:28:40 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hH3Lv5VqlzGpK2;
	Sat, 08 Aug 2026 01:28:39 +0000 (UTC)
Date: Sat, 08 Aug 2026 02:28:40 +0100
From: Bradley Morgan <include@grrlz.net>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
CC: Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 4/5] sched: pause KCOV in try_to_wake_up()
In-Reply-To: <20260807205027.31972-5-kmehltretter@gmail.com>
References: <20260807205027.31972-1-kmehltretter@gmail.com> <20260807205027.31972-5-kmehltretter@gmail.com>
Message-ID: <DE2DA16E-1DD0-4975-8965-85B83F683B3E@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 7 August 2026 21:50:26 BST, Karl Mehltretter <kmehltretter@gmail.com>
wrote:
>try_to_wake_up() is uninstrumented, but it calls instrumented helpers
>such as kthread_is_per_cpu(), CPU capacity helpers and SCHED_HRTICK
>arming. They can record into current while in_task() is true.
>
>CONFIG_KCOV_SELFTEST exposes this under PREEMPT_RT. The interrupt
>selftest fails on x86_64 in kthread_is_per_cpu(): RT runs the timer
>softirq in a thread, so the wakeup runs in task context during the
>selftest's spin. The same helpers leak into non-RT syscall wakeups such
>as a pipe write waking a reader.
>
>Pause all of try_to_wake_up(). Wrapping only select_task_rq() would miss
>SCHED_HRTICK arming during enqueue.
>
>Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I don't mind.

Reviewed-by: Bradley Morgan <include@grrlz.net>

I saw sashikos "kind" reply, this isn't a bug, but a scoped guard,
could be built.

considering it would future proof against somebody adding a early return
later.


but tbh that's more a patch 1 decision to make.


>---
> kernel/sched/core.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>index d5663df6c702..1e562a7ff0af 100644
>--- a/kernel/sched/core.c
>+++ b/kernel/sched/core.c
>@@ -4252,6 +4252,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> {
> 	guard(preempt)();
> 	int cpu, success = 0;
>+	/* KCOV: sched/ is uninstrumented but the wakeup callees are not. */
>+	unsigned int kcov_paused = kcov_pause(current);
> 
> 	wake_flags |= WF_TTWU;
> 
>@@ -4418,6 +4420,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> 	if (success)
> 		ttwu_stat(p, task_cpu(p), wake_flags);
> 
>+	kcov_resume(current, kcov_paused);
> 	return success;
> }
> 
>

Thanks!
