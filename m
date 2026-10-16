Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4434E06F3
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164232; cv=none; b=e5BCBko2gWfU+zo9hi0zlDtv1SoNgqyySyAZtBOqTZAjiHLs8vxqv7nXbhSQER0ZoBAou7rLG8J2feBpSXjw3EhuLSrOqkCwFjlwAV8QYMrMT1XhiguLuYhPKgr+a2zxtwTMPdf26Q3VII+dEKsp6kF/hzHL6zHj7blfaqw0Xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164232; c=relaxed/simple;
	bh=jM8W66dQ0jdgy21WzvKCsXEVkJytefh+zmisrptpmCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqWTumzyX550FrfVvOdEgB7pvLFjQpIHrYIoRA08Hb/4P/OjnOtELndyJMJAl3QhMp7Us3WaOdHSZMbeYZZBkdWNz2InTJisXdWmyQijz/RcRyq2IxkLRbAYTdU+fDutXYgiXl2HM7t0hsBvaa84j3nY399hDeNMZNV3Y8b+A9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=AW0bzyPs; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="AW0bzyPs"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D4134804CE;
	Fri, 16 Oct 2026 15:23:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 329C52002F;
	Fri, 16 Oct 2026 15:23:41 +0000 (UTC)
Date: Fri, 16 Oct 2026 11:23:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261016112339.6d6ac80a@gandalf.local.home>
In-Reply-To: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qhe8fnbygq6z4yyr6q13krras86pswnb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 329C52002F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/R6jk7kh5AhmWdj7scREAR0AmNABHc4gg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=W7lCxImOvrT0eaA6785qEw090MCMDuvUlV/GrcFMVjo=; b=AW0bzyPs2xCLBcRgnMgchJ2vZLcma6sS+DunHdcIZ4kW/Kubj1+PFDQ29/s9zQumsmNwa5xa7e4vnV1U2MadSikRFFJhBYT2zPzh9tL9ZjqRbC3/myjSpy1aX6K1XGqpEFXCvelIDIOnF9kINbRo74Rs//1MLrX7zTqoz2pJbZw=
X-HE-Tag: 1792164221-156296
X-HE-Meta: U2FsdGVkX19xADf4IrBeJGPTNBfLMzzPMJRYG+i8OGez3xb5rAXeYX+LLpNBKKCdnOpH3uqgGUcWP9KJJGg1yhbi8+SSzW9+HqFLhpYDbbXtLpKXsIa6euxvaSUkNXQAg1vx5ACRCt5YN/K5uIESU5Bxp1TfE4moN5eKbi8AmXo+fYinlPbl5hEi9LoGYYUibycmYbXwh0h2xLPvVxIYtzxXbFukH1uitPb6hM7PhO5q3cLwpg9H8ji/3rl0zCTtnB8VbPeDh4pnxHLUsLtl9YIv/Nq5NKuh4fNDaFgauBfO6GdSxL6AJsG5DfNF1ARVCd/3qG1FI3LgJQam2VfsefUjp8wxliZq

On Tue, 13 Oct 2026 17:41:41 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8b3d47a325cca..a8b3434edb2b4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2532,3 +2532,5 @@ extern void migrate_enable(void);
>  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
>  
>  #endif
> +
> +struct task_struct *rcu_cpu_curr(int cpu);
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 803a56af3259f..7826c4d905248 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -309,6 +309,9 @@ struct rcu_stall_chk_rdr {
>  	bool on_blkd_list;
>  	bool rcu_rdr_running;
>  	int rcu_rdr_boosted;
> +	int rcu_rdr_cpu;
> +	int rcu_rdr_cpu_offline;
> +	struct task_struct *rcu_rdr_cpu_task;
>  };
>  
>  /*
> @@ -317,8 +320,10 @@ struct rcu_stall_chk_rdr {
>   */
>  static int check_slow_task(struct task_struct *t, void *arg)
>  {
> +	int cpu;
>  	struct rcu_node *rnp;
>  	struct rcu_stall_chk_rdr *rscrp = arg;
> +	struct task_struct *th;
>  
>  	if (task_curr(t))
>  		return -EBUSY; // It is running, so decline to inspect it.
> @@ -327,6 +332,9 @@ static int check_slow_task(struct task_struct *t, void *arg)
>  	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
>  	rscrp->rcu_rdr_running = task_curr(t);
>  	rscrp->rcu_rdr_boosted = 0;
> +	rscrp->rcu_rdr_cpu = cpu = task_cpu(t);
> +	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
> +	rscrp->rcu_rdr_cpu_task = th = rcu_cpu_curr(cpu);
>  	if (rscrp->on_blkd_list) {
>  		rnp = READ_ONCE(t->rcu_blocked_node);
>  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
> @@ -352,6 +360,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>  	int ndetected = 0;
>  	struct rcu_stall_chk_rdr rscr;
>  	struct task_struct *t;
> +	struct task_struct *tc;
>  	struct task_struct *ts[8];
>  
>  	lockdep_assert_irqs_disabled();
> @@ -372,17 +381,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	while (i) {
>  		t = ts[--i];
> -		if (task_call_func(t, check_slow_task, &rscr))
> +		if (task_call_func(t, check_slow_task, &rscr)) {
>  			pr_cont(" P%d", t->pid);
> -		else
> -			pr_cont(" P%d/%d:%c%c%c%c%c%c",
> +		} else {
> +			tc = rscr.rcu_rdr_cpu_task;

Is there a possible race between the call to rcu_cpu_curr() and here, where
that task could have exited and is freed?

There's no get_task_struct() on that task.

-- Steve


> +			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
>  				t->pid, rscr.nesting,
>  				".b"[rscr.rs.b.blocked],
>  				".q"[rscr.rs.b.need_qs],
>  				".e"[rscr.rs.b.exp_hint],
>  				".l"[rscr.on_blkd_list],
>  				".R"[rscr.rcu_rdr_running],
> -				".B?"[rscr.rcu_rdr_boosted]);
> +				".B?"[rscr.rcu_rdr_boosted],
> +				rscr.rcu_rdr_cpu,
> +				rscr.rcu_rdr_cpu_offline ? "!" : "",
> +				tc ? tc->comm : "???",
> +				tc ? tc->pid : -1,
> +				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
> +		}
>  		lockdep_assert_irqs_disabled();
>  		put_task_struct(t);
>  		ndetected++;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b77152edafd92..e137cba24fc92 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11321,3 +11321,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
>  		p->sched_class->prio_changed(rq, p, ctx->prio);
>  	}
>  }
> +
> +// Not for mainline, but hopefully someone has a trick that gets this
> +// job done.
> +struct task_struct *rcu_cpu_curr(int cpu)
> +{
> +	return cpu_curr(cpu);
> +}

