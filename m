Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8F3C2BAC
	for <linux-rt-devel@lists.linux.dev>; Tue, 12 May 2026 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600292; cv=none; b=lfN/haicJh+L9vD7RyJoVIgoph5RbYGFF8twRuA/0pNinp2HF+Y8KVokCNo20czAYm24FJvlihWFXJLI8BH/euvaKQUVzzxoa0hCEs0H2er0T0cnn528EJEz0uEpKKrFbiZoQYt/pUNIrn6XicN7FriKyyLbRCc/jcWy4UEkpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600292; c=relaxed/simple;
	bh=PEunEfBsFEd3BCqfKr0g9AtG5jN5mbPKWr8r6Zo34gM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7pXURYR07791bbBktIkxczThjpqpT5sDzbPOMalyI0avcOzj/AyvAWbOOcDI3zjrS9l+13nq00Y8Z3+gxUcKRxBHkR6MbQOpoRRm83hqGwXN45A16jOoTp7FEHfH+5IlUT4r9hYe+//gDTwaXGHY5uLWf0ogTZGXy8yx0sgNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4C5228D5A9;
	Tue, 12 May 2026 15:38:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id B8EBA20031;
	Tue, 12 May 2026 15:37:58 +0000 (UTC)
Date: Tue, 12 May 2026 11:37:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kyle
 McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <20260512113754.448c1f5b@gandalf.local.home>
In-Reply-To: <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
References: <20260506235716.2530720-1-tj@kernel.org>
	<20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B8EBA20031
X-Stat-Signature: ws3emhhjkuzmjgaei5qx1rk7n3p4m95y
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18EFwMW8A7e47eXGxsFyuycSny+GUknB/Y=
X-HE-Tag: 1778600278-40241
X-HE-Meta: U2FsdGVkX1+BtrksngkS2hZyMmbAs1ZwZg5hH9eYCwGA68RVDLr1qAnwLmzGkPv/t1p3eyObi+ryULiYmYZYr1GLDzmNOIsT+yqWafZSMS216tpWp4HylsG1yovlBsYSBmTSPsuNjUF4YPlDHlWQljpb6q9g/vhviHOCa3p/1hNRgGzZkePc0/XmFTJ2TORqxZ7nfpSkmo5mGGxTi/V0pSNpxnvOLDL/+fy4TTiFZDwKcmV8Qf/tHpn7LGStqBxas0owkvCIJLbgwNn9UJBz23qh8OvId644GkwIeVHjgXMaNHA1BWVeZ9phPs+vh5zLmfS6it9MGpaJCovUbi9zgmhYcm1twoV/JwA4wBerFJ69dPn4QEaEUc9CkMFEWuo6eLM3SDrLQh/ZaPCYtzJbKetYGrXDzPszj5WxPFCeXvVduylJwIphewmTJyHiJlwYffSyFJidwWvzulo77rI10toXlxyubbpBy/pCce2qFxOqN2wEyOkvWpsqfwPp8+hE/Vn6ayMKJ+Q=


[ Adding some RT folks ]

Also, Valentin, can you look at this, because I believe the issue was
introduced by your change (see below).

On Thu, 7 May 2026 16:14:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 06, 2026 at 01:57:16PM -1000, Tejun Heo wrote:
> > push_rt_task() picks the highest pushable RT task next_task. If it
> > outranks rq->donor, the existing path calls resched_curr() and
> > returns 0, trusting local schedule() to pick next_task soon.
> > 
> > The RT_PUSH_IPI relay caller (rto_push_irq_work_func()) cannot rely
> > on that. When this CPU has a steady supply of softirq work (e.g.,
> > incoming packets), the next push IPI arrives before schedule() can
> > run. Other CPUs keep seeing this CPU as overloaded and keep sending
> > IPIs, this CPU keeps taking the same bail, and the loop repeats
> > until soft lockup.
> > 
> > Seen in production on hosts with sustained NET_RX softirq load:
> > the loop ran millions of iterations before tripping the soft-lockup
> > watchdog.
> > 
> > Skip the prio bail when called via the IPI relay (pull=true) so
> > push_rt_task() migrates next_task to another CPU. Verified with a
> > synthetic reproducer.
> > 
> > Fixes: b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration instead of pulling")

Wrong Fixes tag. That commit doesn't even have the code that you are
changing. I think the correct commit is:

 Fixes: 49bef33e4b87b ("sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race")

Which adds that if statement that exits out of the code early.

> > Cc: Kyle McMartin <jkkm@meta.com>
> > Cc: stable@vger.kernel.org # v5.10+
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> > This looks minimal to me, but happy for suggestions. Thanks.
> > 
> >  kernel/sched/rt.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1968,8 +1968,14 @@ retry:
> >  	 * It's possible that the next_task slipped in of
> >  	 * higher priority than current. If that's the case
> >  	 * just reschedule current.
> > +	 *
> > +	 * This doesn't work for the IPI relay caller (pull). When this CPU
> > +	 * has a steady supply of softirq work (e.g., incoming packets), the
> > +	 * next push IPI arrives before schedule() can run. Other CPUs keep
> > +	 * seeing it as overloaded and keep sending IPIs, this CPU keeps
> > +	 * taking the same bail, and the loop repeats until soft lockup.
> >  	 */
> > -	if (unlikely(next_task->prio < rq->donor->prio)) {
> > +	if (unlikely(next_task->prio < rq->donor->prio) && !pull) {
> >  		resched_curr(rq);
> >  		return 0;
> >  	}  
> 
> IIRC Steve has a test for this stuff. If this breaks things, an
> alternative is keeping a counter/limit on attempts or something.

IIRC, the test we had was simply cyclictest that we ran with the following
parameters. From commit b6366f048e0ca ("sched/rt: Use IPI to trigger RT
task push migration instead of pulling"), it states it runs:

   cyclictest --numa -p95 -m -d0 -i100

The above runs a thread on each CPU at priority 95 and will sleep for
100us. Each thread should wake up at the same time. You can read the commit
message for more details but the tl;dr; is that without the IPI push
request, if one of the CPUs ran another RT task besides cyclictest, then
all the others would then ask to pull from it when the other CPUs
cyclictest would sleep. Having over 100 CPUs send an IPI to pull a task
when only the first one would get it, caused a large latency. Especially
since it took the rq lock over and over again.

But, the code being fixed wasn't due to that commit, but due to the commit
that added the short cut of the logic. That commit fixes a race with the
normal call to push_rt_task() and I think the pull logic issue was a side
effect.

I agree with Tejun's change, it actually puts the logic for the IPI pull
back to what it was before commit 49bef33e4b87b. The bug was added by the
shortcut case to push_rt_task() that was only meant for the !pull scenario.
Adding !pull to the if conditional seems like the correct change.

Valentin, can you confirm please.

Please update the Fixes tag to point to the appropriate commit as well as
update the change log. With that:

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
