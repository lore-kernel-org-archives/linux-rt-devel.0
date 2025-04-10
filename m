Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36303283CBF
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Apr 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295542; cv=none; b=CHymXlR5GKy1BaeHwc58QC1z1g/eQwKZCOY9eaX2/wRFW6NPKNZin+Bq40DcBoiPoAepyY9jqyd4QgLAln1WC/2fLxElObFRDjYJYW8XT3ukmLT+UUIwMmAiPMZG3FRLT2Pbd1PJSZB+uBzx1aNUesdfeB4Dqeh8YO6xQnLHfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295542; c=relaxed/simple;
	bh=nEVCoHACgEoiWZBZMZn6+StID5s9px2ldOc7JB4/dh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9BBrs4OSB06ByUt/7a14PHj8JsxIQZxFQT6BDhC5igyzAq7DL3Cw6/VYIYD+wuFo6TLa0Qz2KbpDuKhLl+1Z1V/jvBRkjkmY1k5bHZ73mtx4l5XIpOSwXiWt5Eo6sp+h6plTGbEy0fyqYB5cr8JRiCZk6/xAI6HKTglogyi/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKaunANv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKaunANv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744295540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMvJ50dQpkxrfWyu4JmTkp9DvrEL/J+59XWwqjmG9wo=;
	b=eKaunANvFKpQ6aBf3YFt3dVe88Ae9c7C7TGX35Mn/4jGkfFU5aUbazDl/v8c6S8iD+TATb
	jwT1MQjueueJcALxPMEDt0Zo1OeSS2bobjpDIYMPM/pQyBinMuHxUMzoMsSeTpwR+wuzRH
	KhNnP6tlYANVARjdYka4h+HcOvJdoWk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-kQZez5x3P9qQN5axr0ueYQ-1; Thu,
 10 Apr 2025 10:32:16 -0400
X-MC-Unique: kQZez5x3P9qQN5axr0ueYQ-1
X-Mimecast-MFC-AGG-ID: kQZez5x3P9qQN5axr0ueYQ_1744295533
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FE331828A90;
	Thu, 10 Apr 2025 14:32:12 +0000 (UTC)
Received: from localhost (unknown [10.22.88.250])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AD5B1956094;
	Thu, 10 Apr 2025 14:32:10 +0000 (UTC)
Date: Thu, 10 Apr 2025 11:32:09 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_fWaT3UunvCFC1D@uudg.org>
References: <Z_e0uh36Ezz6isYo@uudg.org>
 <20250410124059.GA9833@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410124059.GA9833@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Apr 10, 2025 at 02:40:59PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 10, 2025 at 09:10:12AM -0300, Luis Claudio R. Goncalves wrote:
> > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> > with a mutex enqueued. That could lead to this sequence:
> > 
> > 	rt_mutex_adjust_prio_chain()
> > 	  put_task_struct()
> > 	    __put_task_struct()
> > 	      sched_ext_free()
> > 	        spin_lock_irqsave()
> > 	          rtlock_lock() --->  TRIGGERS
> > 	                              lockdep_assert(!current->pi_blocked_on);
> > 
> > Fix that by unconditionally resorting to the deferred call to
> > __put_task_struct().
> > 
> > v2: (Rostedt) remove the #ifdef from put_task_struct() and create
> >     tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
> > 
> > v3: (Sebastian and PeterZ) always call the RCU deferred __put_task_struct().
> 
> Changelog goes below the --- line.
> 
> > Suggested-by: Crystal Wood <crwood@redhat.com>
> > Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > ---
> >  include/linux/sched/task.h |   20 +++++---------------
> >  1 file changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index 0f2aeb37bbb04..49847efe5559e 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -134,22 +134,12 @@ static inline void put_task_struct(struct task_struct *t)
> >  		return;
> >  
> >  	/*
> > -	 * In !RT, it is always safe to call __put_task_struct().
> > -	 * Under RT, we can only call it in preemptible context.
> > -	 */
> > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> > -		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > -
> > -		lock_map_acquire_try(&put_task_map);
> > -		__put_task_struct(t);
> > -		lock_map_release(&put_task_map);
> > -		return;
> > -	}
> 
> I don't think you've substantiated why the !PREEMPT_RT case needs to go.

That was my misunderstanding of "unconditionally call the deferred
function". I see I took it too far and made the patch wrong.

I am testing v4 (closer to the original code with fixed comments) that is
basically:

	if !RT
		__put_task_struct (original code)
	else
		call_rcu(__put_task_struct_rcu_cb)

With the corrected comments Sebastian pointed out.

As soon as the tests complete I will post v4.

Thanks,
Luis
 
> > -
> > -	/*
> > -	 * under PREEMPT_RT, we can't call put_task_struct
> > +	 * In !RT, it is always safe to call __put_task_struct(),
> > +	 * but under PREEMPT_RT, we can't call put_task_struct
> >  	 * in atomic context because it will indirectly
> > -	 * acquire sleeping locks.
> > +	 * acquire sleeping locks. The same is true if the
> > +	 * current process has a mutex enqueued (blocked on
> > +	 * a PI chain).
> >  	 *
> >  	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> >  	 * to be called in process context.
> > -- 
> > 2.49.0
> > 
> 
---end quoted text---

