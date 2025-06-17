Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823A2E716F
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Jun 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166216; cv=none; b=c9L4mTRGbDUcukKW3zEk/snOgWDecOS7kHU6l/1YKH5rArKhLCKJny7Ha4257Y4r20Y84ioOi3kc3lZQ1PNJRh/kH6zB1sxg4wA2cFkEAtzVk+77FNaSJ6zy9V9FWcWiuzSpZRgAb+nG+jRUf+hYKyz3ZTh84dALHU5illpur+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166216; c=relaxed/simple;
	bh=6AE3cwlgBTJbnn/0JLZ399FEdH3CAIVJTwPh9xZWwbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtUhJKvi1bjfJI/9iXUSFpaSI0nanhzvBEFzTVJYXr0YB+74uUVCT7BQ1zkZhn25odkSjC6LmImDfxztwspzVwmJBRwmIJL8dnA8/a3a/9/p1r0dvqdkbORtFLZ7Obg1cSJVyjquSp9xBblNjr3LG/jswaDWw63Wr3DiNwEw9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A++eY2YE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A++eY2YE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750166213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vGBMMpihI2Ab+ZxJItEOOP/a/RoDjfzgn/J756SWLwk=;
	b=A++eY2YEIP+lrvLtRuEqH2EoF0LbLDPjxIdfhLROKSmHT/G94NV4vd+wM/9fmCon5yMTM+
	CTpEmao1ZIxKgBMBVy1c1S327Ld1cPBPlEERjOWW8+s5fCpkloWj7nKyWC+EhvncPt8BzS
	QV7FOBfv/6JeoDOhPVuXTbq2+Axxkhk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-ordY2egaNL6bPgtoApHhwg-1; Tue,
 17 Jun 2025 09:16:50 -0400
X-MC-Unique: ordY2egaNL6bPgtoApHhwg-1
X-Mimecast-MFC-AGG-ID: ordY2egaNL6bPgtoApHhwg_1750166206
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCA0C1800284;
	Tue, 17 Jun 2025 13:16:45 +0000 (UTC)
Received: from localhost (unknown [10.22.89.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8023B30001B1;
	Tue, 17 Jun 2025 13:16:44 +0000 (UTC)
Date: Tue, 17 Jun 2025 10:16:42 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	DietmarEggemann@uudg.org, dietmar.eggemann@arm.com,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH v4] sched: do not call __put_task_struct() on rt
 if pi_blocked_on is set
Message-ID: <aFFqugD6y2OytiaA@uudg.org>
References: <aEw-KjUjjP2gYH6z@uudg.org>
 <20250617092609.GR1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617092609.GR1613376@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 17, 2025 at 11:26:09AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 13, 2025 at 12:05:14PM -0300, Luis Claudio R. Goncalves wrote:
> > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> > with a mutex enqueued. That could lead to this sequence:
> > 
> >         rt_mutex_adjust_prio_chain()
> >           put_task_struct()
> >             __put_task_struct()
> >               sched_ext_free()
> >                 spin_lock_irqsave()
> >                   rtlock_lock() --->  TRIGGERS
> >                                       lockdep_assert(!current->pi_blocked_on);
> > 
> > Fix that by unconditionally resorting to the deferred call to
> > __put_task_struct() if PREEMPT_RT is enabled.
> > 
> 
> Should this have a Fixes: tag and go into /urgent?

Makes sense! I will add the tag:

Fixes: 893cdaaa3977b ("sched: avoid false lockdep splat in put_task_struct()")

and resend.

Thank you!
 
> > Suggested-by: Crystal Wood <crwood@redhat.com>
> > Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > ---
> > 
> > Resent as a gentle reminder, because this issue results in scary backtraces,
> > not obvious to debug and pinpoint root cause.
> > 
> > v2: (Rostedt) remove the #ifdef from put_task_struct() and create
> >     tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
> > v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
> > v4: Fix the implementation of what was requested on v3.
> > 
> >  include/linux/sched/task.h |   17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index 0f2aeb37bbb04..51678a541477a 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -134,11 +134,8 @@ static inline void put_task_struct(struct task_struct *t)
> >  	if (!refcount_dec_and_test(&t->usage))
> >  		return;
> >  
> > -	/*
> > -	 * In !RT, it is always safe to call __put_task_struct().
> > -	 * Under RT, we can only call it in preemptible context.
> > -	 */
> > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> > +	/* In !RT, it is always safe to call __put_task_struct(). */
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >  		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> >  
> >  		lock_map_acquire_try(&put_task_map);
> > @@ -148,11 +145,13 @@ static inline void put_task_struct(struct task_struct *t)
> >  	}
> >  
> >  	/*
> > -	 * under PREEMPT_RT, we can't call put_task_struct
> > +	 * Under PREEMPT_RT, we can't call __put_task_struct
> >  	 * in atomic context because it will indirectly
> > -	 * acquire sleeping locks.
> > +	 * acquire sleeping locks. The same is true if the
> > +	 * current process has a mutex enqueued (blocked on
> > +	 * a PI chain).
> >  	 *
> > -	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> > +	 * call_rcu() will schedule __put_task_struct_rcu_cb()
> >  	 * to be called in process context.
> >  	 *
> >  	 * __put_task_struct() is called when
> > @@ -165,7 +164,7 @@ static inline void put_task_struct(struct task_struct *t)
> >  	 *
> >  	 * delayed_free_task() also uses ->rcu, but it is only called
> >  	 * when it fails to fork a process. Therefore, there is no
> > -	 * way it can conflict with put_task_struct().
> > +	 * way it can conflict with __put_task_struct().
> >  	 */
> >  	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
> >  }
> > 
> > ----- End forwarded message -----
> > 
> 
---end quoted text---

