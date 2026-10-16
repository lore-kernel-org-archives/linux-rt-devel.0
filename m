Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B00501F4E
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169296; cv=none; b=L1p+pkIeAdx60YgddnzrGbvcLdNrM8ZZN+8xK4A/nCpuabPQ4s1+kftpsXKS7NYRivHCqCuQRrXmp3YiAgV/HMAt5nDbMO2sSfBC6dwm5+b9uO2J2+PEJp0olRvtfKuiWaKmCoMA321cRqROwupL5M/phQj+HbzbmM+Mh5bWbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169296; c=relaxed/simple;
	bh=5kqFKEnmldNxq2LKNRQrT0blh6h8UwGkBd6tMmy1oDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twbQaX62fesRrQ5Px3PKMrn/oRIDK28KPmmo5DMorFYVYxJJj1my4X5JXz2GUA+/JB1TPf1/gbT5ACVUZLVYUbG/079T4INv0/T0olq4bbyO0Ck1dhvXIbcR0AImUoMYeThc8LQAaRe5g8RZaiVdt6ndoW8D5gM6KLBbQcu3nZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBuHADy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBuHADy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4747D1F000C8;
	Fri, 16 Oct 2026 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169292;
	bh=VvvSws+2GS3RjWsamcIOjekboBi4ebH3wcPIdqCEWbo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=cBuHADy6RA/PG04/d7Ks3GDnSxGFcfOxI0MZIFQWExS1S3I0Xi/ZqNEHZHjD+e1Y2
	 wTqI+UG2XWhmdB3SjpML6eLl5IaPGHItQl8v91u6paYoCAAPGyiOrwQBScGcTEX6XL
	 9RQ8irH2GN3XPKzglRffropXjfcg3pC2oXKVKRR5vdBwzm4ITH4cXTqzqhd73dNiVE
	 u/bPptZ/UmRjRFyApXf6A2e0ZeU0vCAF3RZGVEtAZhyl74e+7KCus+a4F7yno06b1O
	 hB4PR/tCrGg/l8o69I7RG1uwvuRMmHAODG6Y3Lu2vWfv6ROn8XSyaIT6SHhvRsbKeN
	 V19hPdQIC+/xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A384CE08CF; Fri, 16 Oct 2026 09:48:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:48:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
 <20261016112339.6d6ac80a@gandalf.local.home>
 <7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
 <20261016121753.0da4e4e1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016121753.0da4e4e1@gandalf.local.home>

On Fri, Oct 16, 2026 at 12:17:53PM -0400, Steven Rostedt wrote:
> On Fri, 16 Oct 2026 09:00:31 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > @@ -372,17 +381,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> > > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >  	while (i) {
> > > >  		t = ts[--i];
> > > > -		if (task_call_func(t, check_slow_task, &rscr))
> > > > +		if (task_call_func(t, check_slow_task, &rscr)) {
> > > >  			pr_cont(" P%d", t->pid);
> > > > -		else
> > > > -			pr_cont(" P%d/%d:%c%c%c%c%c%c",
> > > > +		} else {
> > > > +			tc = rscr.rcu_rdr_cpu_task;  
> > > 
> > > Is there a possible race between the call to rcu_cpu_curr() and here, where
> > > that task could have exited and is freed?
> > > 
> > > There's no get_task_struct() on that task.  
> > 
> > The get_task_struct() happens in the list_for_each_entry_continue()
> > loop that it right before the raw_spin_unlock_irqrestore_rcu_node().
> > 
> > Or do I have an off-by-one bug here?
> > 
> 
> But doesn't that loop just cover the tasks in &rnp->blkd_tasks?
> 
> Does that include the task returned by cpu_curr(cpu) ?

Here is the full function:

------------------------------------------------------------------------

static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
	__releases(rnp->lock)
{
	int i = 0;
	int ndetected = 0;
	struct rcu_stall_chk_rdr rscr;
	struct task_struct *t;
	struct task_struct *tc;
	struct task_struct *ts[8];

	lockdep_assert_irqs_disabled();
	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
		return 0;
	}
	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
	       rnp->level, rnp->grplo, rnp->grphi);
	t = list_entry(rnp->gp_tasks->prev,
		       struct task_struct, rcu_node_entry);
	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
		get_task_struct(t);
		ts[i++] = t;
		if (i >= ARRAY_SIZE(ts))
			break;
	}
	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
	while (i) {
		t = ts[--i];
		if (task_call_func(t, check_slow_task, &rscr)) {
			pr_cont(" P%d", t->pid);
		} else {
			tc = rscr.rcu_rdr_cpu_task;
			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
				t->pid, rscr.nesting,
				".b"[rscr.rs.b.blocked],
				".q"[rscr.rs.b.need_qs],
				".e"[rscr.rs.b.exp_hint],
				".l"[rscr.on_blkd_list],
				".R"[rscr.rcu_rdr_running],
				".B?"[rscr.rcu_rdr_boosted],
				rscr.rcu_rdr_cpu,
				rscr.rcu_rdr_cpu_offline ? "!" : "",
				tc ? tc->comm : "???",
				tc ? tc->pid : -1,
				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
		}
		lockdep_assert_irqs_disabled();
		put_task_struct(t);
		ndetected++;
	}
	pr_cont("\n");
	return ndetected;
}

------------------------------------------------------------------------

The ts[] array keeps track of up to eight tasks, the number indicated
by local variable "i", and the list_for_each_entry_continue() has
done get_task_struct() on each of those tasks.  Then the "while" loop
iterates over those tasks, printing each one and then doing the matching
put_task_struct().

Does that work, or am I missing something subtle?

							Thanx, Paul
