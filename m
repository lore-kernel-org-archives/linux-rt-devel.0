Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B241442B
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194307; cv=none; b=PzxRU+1dsIEvJEe3/PvRobaQWThgV9cUWUxqukV2n/uIX5cQ/7R+FOEE0/Jt2+41VLZA+kTKrXDlRQHbnD+y2M80MQdnJ9nU3o1/mdBh+VVO6ZC+4D1ArXpx9w8KnnFdpxcujnu3hQ1946fadzRXDAnhUws4UBkC3lROaTfpZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194307; c=relaxed/simple;
	bh=2JfCyBRps6S6bAimm0cpeDoknY97UOn/uJ9b+H+aLTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoLejXaSJz4cVBodckF4nBqtRGXL0VLmyqLSCOdzJ4t0rsT29hqKXPsVjDH66c01oqJ1XIh/zpn9IdS5HYEftwqQOuEySSKn1T7ZA+zjnbzmxYS+Z+Cc1t7+op7Jm0oeRydP1XFhi5E7ia7Y+XSAlMWS4yWcYY8wV9vqSUx3SXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVVGoi3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVVGoi3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6427E1F000C4;
	Fri, 16 Oct 2026 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792194306;
	bh=wZIS6Wfb3KUcANEb8OqGV7dB3G4p2dQC9QUuMMU02Vw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=BVVGoi3uhN9xADcQHTFAwns+ZzwTkopjGmZi3tZPWHG2g/L89UU207kMHnb7UMRSE
	 +dJgkz0KbrojK3ApcmWJGsWfBj0Khq8sh38LbfGHJRidui+Z3qzMsg/9U+Uehjsen+
	 4kkjG4Q47s0OE9Pdk7v2j9Mcx7zwXssS3e/qlSexrPP3Ec/V+eo5iov4YKY3sIL15d
	 lbZvNCL0f1apoZvdBU5TIM6GaALd6X20HepKeDnYpmOIGZ/3M6XGF8wb8ch9BUSUpC
	 xWO3NwqaztQqt/Gtm427ztlRryffHEEiZp4Xhr2iCqhnB6MjhT+rm6hKXBVDt1/5mZ
	 fXsDolcAkNazw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1BAD4CE0D69; Fri, 16 Oct 2026 16:45:06 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:45:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
 <20261016112339.6d6ac80a@gandalf.local.home>
 <7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
 <20261016121753.0da4e4e1@gandalf.local.home>
 <d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
 <20261016125453.36ae8efe@gandalf.local.home>
 <112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
 <20261016134030.6791c1e4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016134030.6791c1e4@gandalf.local.home>

On Fri, Oct 16, 2026 at 01:40:30PM -0400, Steven Rostedt wrote:
> On Fri, 16 Oct 2026 10:05:02 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Which might mean holding the rq lock in check_slow_task().  Except that
> > task_call_func() already does that for me, right?
> 
> Does it? It looks to only take the run queue lock if the task passed in is
> running. But isn't this task usually blocked?

You are again quite right, it does not always acquire the run-queue lock.
However...

> Maybe we can add a special get_cpu_curr(cpu) function that could not only
> return the task but also get a reference for it too? Or NULL if idle.

Or we can rely on interrupts being disabled across the full call to
rcu_print_task_stall().  This interrupts-disabled region acts as an RCU
read-side critical section, so that the call_rcu() in put_task_struct()
cannot invoke its callback (and thus cannot free the task_struct
structure) until some time after rcu_print_task_stall().

Does that work, or am I still missing something?

(And yes, even if it doesn't work, comments might be nice.)

							Thanx, Paul

> -- Steve
> 
> > 
> > Like this, to be folded into the existing patch?  Or am I still missing
> > something?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 33e953bb40b33..b314d79c07840 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -336,6 +336,8 @@ static int check_slow_task(struct task_struct *t,
> > void *arg) rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
> >  	// Interrupt are disabled for RCU read-side critical section. 
> >  	rscrp->rcu_rdr_cpu_task = th = cpu_curr_snapshot_rcu(cpu);
> > +	if (th)
> > +		get_task_struct(th);
> >  	if (rscrp->on_blkd_list) {
> >  		rnp = READ_ONCE(t->rcu_blocked_node);
> >  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
> > @@ -402,6 +404,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp,
> > unsigned long flags) }
> >  		lockdep_assert_irqs_disabled();
> >  		put_task_struct(t);
> > +		if (tc)
> > +			put_task_struct(tc);
> >  		ndetected++;
> >  	}
> >  	pr_cont("\n");
> 
