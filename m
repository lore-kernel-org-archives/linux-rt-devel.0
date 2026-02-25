Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB8392C3D;
	Wed, 25 Feb 2026 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016842; cv=none; b=JL8S19ciif93j9i0GW7JkR99VlxHKtYeCNashVXEki5U93FBCXp/AQqCmlNAX0UA7oi2O54rSAFuPPO80PI+8pKBQLRKjGgfhMc7qwBd24GRIihEMgDEtQiYkK1Yw4ex0XL/2qZy4a9TaP9BVlKf956CQ7X45s5vY7/LzvQK63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016842; c=relaxed/simple;
	bh=sFbhEjNrAtstDXvNy70LXI85QuQNuZkXmDBa+DkWzQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYsFqppHT9AXqcONtnLYmn+BugPm0xDX6zQscJdYPOWH+Zh4DxBUqnQfvUqRt9QTssNEZebNaDlWoDN4uLQ1TftPxG3XKSP1FMtLscOuWYy4FvdKZqN1P1NPX3TKT2t2PvcUBehIyRF/g3ZTfUfY/0pjClDCOiElwtcM6v/pw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A9K7EATH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A9K7EATH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J6k886DB94AoAH014hwm2wW2wTj+PsDK85Xe3Oe7LV0=; b=A9K7EATHuWySCn5BZ9TWl+3yLo
	zljeR5AervvKgA0yx8EiOsjfWArArln6O/9vCe93hYMxQGhGs8TSfXDO4h3/cP5nmanQ1W4Ay3FkT
	8ViBU4H8GwMzKGNdxxK0q18t1E/tOLYR2SbZsjTFu3sLwyS0pGf3FietwLFPmssJk6PTAqKKsy8lp
	dKVlP9n6YpjkiARhKBcbuUDb22t7SqRvikk/r1hLHQHykNdlEULH6eQ2CMfYfPwLk4U9nv70t/nm2
	Vea3F/brXN9tHyGZIXrpgiAKDc7u09FI1Hayj6bcwBMWEjOUiXr4nBoyo4a2hlBcn2xB6TsmYZq+y
	dWlRDbPQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvCWd-00000000w01-3np6;
	Wed, 25 Feb 2026 10:53:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 570DC30095A; Wed, 25 Feb 2026 11:53:45 +0100 (CET)
Date: Wed, 25 Feb 2026 11:53:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>

On Fri, Jan 09, 2026 at 04:53:04PM +0530, Shrikanth Hegde wrote:

> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -243,7 +243,7 @@ static ssize_t sched_dynamic_write(struc
> >   static int sched_dynamic_show(struct seq_file *m, void *v)
> >   {
> > -	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
> > +	int i = (IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY)) * 2;
> >   	int j;
> >   	/* Count entries in NULL terminated preempt_modes */
> 
> Maybe only change the default to LAZY, but keep other options possible via
> dynamic update?
> 
> - When the kernel changes to lazy being the default, the scheduling pattern
> can change and it may affect the workloads. having ability to dynamically
> change to none/voluntary could help one to figure out where
> it is regressing. we could document cases where regression is expected.

I suppose we could do this. I just worry people will end up with 'echo
volatile > /debug/sched/preempt' in their startup script, rather than
trying to actually debug their issues.

Anybody with enough knowledge to be useful, can edit this line on their
own, rebuild the kernel and go forth.

Also, I've already heard people are interested in compile-time removing
of cond_resched() infrastructure for ARCH_HAS_PREEMPT_LAZY, so this
would be short lived indeed.

> - with preempt=full/lazy we will likely never see softlockups. How are we
> going to find out longer kernel paths(some maybe design, some may be bugs)
> apart from observing workload regression?

Given the utter cargo cult placement of cond_resched(); I don't think
we've actually lost much here. You wouldn't have seen the softlockup
thing anyway, because of cond_resched().

Anyway, you can always build on top of function graph tracing, create a
flame graph of stuff and see just where all your runtime went. I'm sure
there's tools that do this already. Perhaps if you're handy with the BPF
stuff you can even create a 'watchdog' of sorts that will scream if any
function takes longer than X us to run or whatever.

Oh, that reminds me, Steve, would it make sense to have
task_struct::se.sum_exec_runtime as a trace-clock?

> Also, is softlockup code is of any use in preempt=full/lazy?

Softlockup has always seemed of dubious value to me -- then again, I've
been running preempt=y kernels from about the day that became an option
:-)

I think it still trips if you loose a wakeup or something.

