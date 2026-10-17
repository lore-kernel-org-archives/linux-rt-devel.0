Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FFF3E275F
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263731; cv=none; b=c5UAEOBlMaysO2GO3dRS8GtIMmduO7KRANkwMDoQQCa3mg4Q46IbT7r4/kVPCADWQwY4EnVSFUEM8GP6FJ7inSZ1fdxWLQmTvNKSaYY4Jivtf5pB3ZHNjbE9LmK48EnweBLi1utfxlrXNIFgiR8K+LtjXl9rGRrF/oERaP5VGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263731; c=relaxed/simple;
	bh=P7oEkGignlFqq9fFQaYULc1tT68y6CzrrbGtJGhPMEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kkxs0xMsIUvn3L3zpsnPF4dKy6yk6jWNKMGHO1/bq6TdhJemqOZI5BgNFDv7INbUDh2nijOBgR2vM/nLk/IbVkeDZatEDd3+AQZD8Bq0E8S143S3Hd9rAefYKhb5d3B89Zop3RZO1JEl0Nb+cwIXpsbmyEaqyqCkQ0CSazqq3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRmK5QBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRmK5QBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639871F000C4;
	Sat, 17 Oct 2026 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263728;
	bh=ayWlkfSTipewHdV8008L6w9CQMGhx4cRMzdLM6oFEEY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=JRmK5QBq25C4vBqKlGicf8AGId8mwmIjtGShdg2Pt5W1Os5N5EYs1pAE+uCbP3OHs
	 +Dbpve1f8WGzfC4Y3FeP+PA/pAR79GKUFqKR70lzVZCE5jxQMHlztqauXoF4aPREMJ
	 Tk/bd50BP0h9sDkhhFy73cLrJaXCOKSNdhopr6tdvQnIumC0tFE176F+0Xby3SpBZU
	 XHMJhoh6DwONDkQYFw1x+ssA5QpgCEwZUhZ11BprqdqtHAMKDtsjylugqoboUWNiwV
	 DgxgLnilWTxhQo6GMzv33fv7VXMmgUq/HCaWwse+oU2rk1B5s7tXBPVK3IWOP/vSd4
	 99zdvV4D3usdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A38FCE1ADC; Sat, 17 Oct 2026 12:02:08 -0700 (PDT)
Date: Sat, 17 Oct 2026 12:02:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
 <20261016112339.6d6ac80a@gandalf.local.home>
 <7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
 <20261016121753.0da4e4e1@gandalf.local.home>
 <d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
 <20261016125453.36ae8efe@gandalf.local.home>
 <112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
 <20261016134030.6791c1e4@gandalf.local.home>
 <4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>

On Fri, Oct 16, 2026 at 04:45:06PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 16, 2026 at 01:40:30PM -0400, Steven Rostedt wrote:
> > On Fri, 16 Oct 2026 10:05:02 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > Which might mean holding the rq lock in check_slow_task().  Except that
> > > task_call_func() already does that for me, right?
> > 
> > Does it? It looks to only take the run queue lock if the task passed in is
> > running. But isn't this task usually blocked?
> 
> You are again quite right, it does not always acquire the run-queue lock.
> However...
> 
> > Maybe we can add a special get_cpu_curr(cpu) function that could not only
> > return the task but also get a reference for it too? Or NULL if idle.
> 
> Or we can rely on interrupts being disabled across the full call to
> rcu_print_task_stall().  This interrupts-disabled region acts as an RCU
> read-side critical section, so that the call_rcu() in put_task_struct()
> cannot invoke its callback (and thus cannot free the task_struct
> structure) until some time after rcu_print_task_stall().
> 
> Does that work, or am I still missing something?

Except that if this is the case, then I don't need get_task_struct()
in the first place for any of them, do I?  I can instead just rely on
the call_rcu() in put_task_struct() that had to have happened sometime
after picking up the pointer to each task structure.

I clearly need to go through this one step by step and upgrade it as
needed from a debugging hack to a proper patch.

> (And yes, even if it doesn't work, comments might be nice.)

But this point still holds.  ;-)

							Thanx, Paul

> > -- Steve
> > 
> > > 
> > > Like this, to be folded into the existing patch?  Or am I still missing
> > > something?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index 33e953bb40b33..b314d79c07840 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -336,6 +336,8 @@ static int check_slow_task(struct task_struct *t,
> > > void *arg) rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
> > >  	// Interrupt are disabled for RCU read-side critical section. 
> > >  	rscrp->rcu_rdr_cpu_task = th = cpu_curr_snapshot_rcu(cpu);
> > > +	if (th)
> > > +		get_task_struct(th);
> > >  	if (rscrp->on_blkd_list) {
> > >  		rnp = READ_ONCE(t->rcu_blocked_node);
> > >  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
> > > @@ -402,6 +404,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp,
> > > unsigned long flags) }
> > >  		lockdep_assert_irqs_disabled();
> > >  		put_task_struct(t);
> > > +		if (tc)
> > > +			put_task_struct(tc);
> > >  		ndetected++;
> > >  	}
> > >  	pr_cont("\n");
> > 
