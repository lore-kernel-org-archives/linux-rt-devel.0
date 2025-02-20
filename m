Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6E1E0B7F;
	Thu, 20 Feb 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048972; cv=none; b=LWNUr7xPrJ3r2Iv11hJjRpSJw2gIj8PBIsgwUDd0YOIQu1yoKZUzgAieowMzIkMKjcDtjmbcp65u/rShJtMslwalhTVuyNn0wrKvJgbzd4fYhSFrucQbOvjP2IWvUDUBcj9EQSPpQwk+nHajN1Y9fJYi7mIVXNIwTi1JW52Bka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048972; c=relaxed/simple;
	bh=lPkMdd3qnMsSSfWgq+AdsUEb6rpVf2KxmeT9QHn1xy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pfzayrv5QvdU3ZvGa0F9IOIEG/cmgNlNzpJ8z08pbGgUGqlaQamc0pPJ2LAi7UnL0qPGiNuXpNI0D76fv5pJ2VE+Y7VQY5O/GPLjC8qs3bECitv1ED4Q4WhiV9ec0TEJ0fdLL+MU0nROgy0w4QKNX/D0jTblzeg5Qd1BhgF7tAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ix3QrfaD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ix3QrfaD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wMxjzD5AOVXLF2tcKGKIBkbHXfnF4c0ZwE+vKU4UHSA=; b=ix3QrfaDNukzRToNctPtQ2eo5R
	x7mHnQpgZx91Di4/oU2/HAE0C0Bz3rMkmBYjsIhbYF4RqabjRF7Hzzq2JdRSPKi8LMDX8kCJsGfUo
	00wHjZ/+FE7ZLzAg5t9I4Z0yOfldvka1GQAlHbywDCNYqlVbK9GUTNzSKRlcHtt9jFbqtTWuJzv4L
	hEF/CvOvDSIcrdt2GcnbkaDFbWEJe4kECP55aVsQJSBVHPJKeH9DPaW9siaacSrsiDgwxNa4Y6kND
	JBwaDnyCPy/HihiRcKW5ejyfitGnS5i9T8KajS/UtesXF9767JF7U+TENNq2ua9QluIiILYRAsYot
	xrQJnJtA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tl4Dn-00000002Pcn-3yZm;
	Thu, 20 Feb 2025 10:56:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0072E300756; Thu, 20 Feb 2025 11:55:58 +0100 (CET)
Date: Thu, 20 Feb 2025 11:55:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Barret Rhoden <brho@google.com>, Petr Mladek <pmladek@suse.com>,
	Josh Don <joshdon@google.com>, Qais Yousef <qyousef@layalina.io>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Vernet <dvernet@meta.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
Message-ID: <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220093257.9380-1-kprateek.nayak@amd.com>

On Thu, Feb 20, 2025 at 09:32:35AM +0000, K Prateek Nayak wrote:
> Proposed approach
> =================
> 
> This approach builds on Ben Segall's proposal in [4] which marked the
> task in schedule() when exiting to usermode by setting
> "in_return_to_user" flag except this prototype takes it a step ahead and
> marks a "kernel critical section" within the syscall boundary using a
> per-task "kernel_cs_count".
> 
> The rationale behind this approach is that the task can only hold
> kernel resources when running in kernel mode in preemptible context. In
> this POC, the entire syscall boundary is marked as a kernel critical
> section but in the future, the API can be used to mark fine grained
> boundaries like between an up_read(), down_read() or up_write(),
> down_write() pair.
> 
> Within a kernel critical section, throttling events are deferred until
> the task's "kernel_cs_count" hits 0. Currently this count is an integer
> to catch any cases where the count turns negative as a result of
> oversights on my part but this could be changed to a preempt count like
> mechanism to request a resched.
> 
>             cfs_rq throttled               picked again
> 		  v                              v
> 
>     ----|*********| (preempted by tick / wakeup) |***********| (full throttle)
> 
>         ^                                                    ^
> critical section   cfs_rq is throttled partially     critical section
>       entry           since the task is still              exit
>                   runnable as it was preempted in
>                       kernel critical section
> 
> The EEVDF infrastructure is extended to tracks the avg_vruntime and the
> avg_load of only those entities preempted in kernel mode. When a cfs_rq
> is throttled, it uses these metrics to select among the kernel mode
> preempted tasks and running them till they exit to user mode.
> pick_eevdf() is made aware that it is operating on a throttled hierarchy
> to only select among these tasks that were preempted in kernel mode (and
> the sched entities of cfs_rq that lead to them). When a throttled
> entity's "kernel_cs_count" hits 0, the entire hierarchy is frozen but
> the hierarchy remains accessible for picking until that point.
> 
>           root
>         /     \
>        A       B * (throttled)
>       ...    / | \
>             0  1* 2*
> 
>     (*) Preempted in kernel mode
> 
>   o avg_kcs_vruntime = entity_key(1) * load(1) + entity_key(2) * load(2)
>   o avg_kcs_load = load(1) + load(2)
> 
>   o throttled_vruntime_eligible:
> 
>       entity preempted in kernel mode &&
>       entity_key(<>) * avg_kcs_load <= avg_kcs_vruntime
> 
>   o rbtree is augmented with a "min_kcs_vruntime" field in sched entity
>     that propagates the smallest vruntime of the all the entities in
>     the subtree that are preempted in kernel mode. If they were
>     executing in usermode when preempted, this will be set to LLONG_MAX.
> 
>     This is used to construct a min-heap and select through the
>     entities. Consider rbtree of B to look like:
> 
>          1*
>        /   \
>       2*    0
> 
>       min_kcs_vruntime = (se_in_kernel()) ? se->vruntime : LLONG_MAX:
>       min_kcs_vruntime = min(se->min_kcs_vruntime,
>                              __node_2_se(rb_left)->min_kcs_vruntime,
>                              __node_2_se(rb_right)->min_kcs_vruntime);
> 
>    pick_eevdf() uses the min_kcs_vruntime on the virtual deadline sorted
>    tree to first check the left subtree for eligibility, then the node
>    itself, and then the right subtree.
> 

*groan*... why not actually dequeue the tasks and only retain those with
non-zero cs_count? That avoids having to duplicate everything, no?
