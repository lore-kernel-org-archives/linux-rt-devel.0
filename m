Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF42556E
	for <linux-rt-devel@lists.linux.dev>; Sat, 18 Oct 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760793096; cv=none; b=kqHpYlK/o/xfd1iuNR21LE3uiLVEYkUZQwMlnzozDNKZOotm0fMceESyIttkyv1g7HP9GhKYe4FGnPnvl/ADI4ERletCw4lg5D/cVGG+5jkLOYu4V4qNKJ+ll2a+mNbf4yG+IVrSJ+x0d2YLmRRI/QqRUpJTD0cXbywaGNgbkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760793096; c=relaxed/simple;
	bh=uQTvxX50ZJfMiCQOZSLOkiFdQCWCU4TR/M1b9/H4Es4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRuKJhshDpx1ZRLeXC+IN1VlynWXMb+c5MmjjssEHWoD+c/lBG2W9Q6P1PvEsBMbaMPJ9Yn1bb5//rGzloTxDgbxzEUwQh2qezd99iYIHQ8dJdoZg1XwsRLWGDwTWxY9BX2I5Mo3Emzy6HUKpNtBWIAbPEOPEhIAFpckqdoGr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2PhoXeW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2PhoXeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760793093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JbI+XjGZmYi6Q0RgYQx+mf1W/BhBhNTX2xUtn+SVKxw=;
	b=e2PhoXeWlXSOXSqOVteLiVTfCe85v4dGtEmY7LcljN0Layf1sKpMS9rG8BweN6rULIirn4
	x66ZR3cyoCpxXHFNn7JswSiXEfaSNpZP/+2DTtOaxTnLQDsFgEfXAYIaTKLGLbsKMX9HfB
	lGE5aDVUGx6JrJYSMqQ6c5ba6lzF5cM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-y2Uf-UiYNk2BdZzovxydcg-1; Sat,
 18 Oct 2025 09:11:29 -0400
X-MC-Unique: y2Uf-UiYNk2BdZzovxydcg-1
X-Mimecast-MFC-AGG-ID: y2Uf-UiYNk2BdZzovxydcg_1760793087
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED9BB18002C9;
	Sat, 18 Oct 2025 13:11:26 +0000 (UTC)
Received: from localhost (unknown [10.22.88.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF1E5180057E;
	Sat, 18 Oct 2025 13:11:24 +0000 (UTC)
Date: Sat, 18 Oct 2025 10:11:23 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <aPOR--HRHViqmyQ-@uudg.org>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
 <20250915123539.GC23082@redhat.com>
 <20250916100953.GG3245006@noisy.programming.kicks-ass.net>
 <20250916113043.GA32038@redhat.com>
 <20251017143944.GB21102@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017143944.GB21102@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Oct 17, 2025 at 04:39:45PM +0200, Oleg Nesterov wrote:
> Peter,
> 
> So I think that delayed_put_task_struct() has to stay and this means
> that we have 2 RCU grace periods in the "typical" case when the exiting
> task without extra references is reaped (or autoreaped if a subthread).
> 
> As I said I won't really argue, but what is your final thought on this?
> Should we forget this patch from Luis? I'd prefer to restore the !RT
> exception...
> 
> And another question. Sasha and Greg are going to add 8671bad873eb
> ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> to -stable. Do you think it is fine to backport this commit as is?

I am not aware of any specific RCU fixes that need to be present in order
for commit 8671bad873eb to work properly on older kernels. That was my initial
fear when Sasha and Greg mentioned the backport to Stable in August. The
reference I have is that the deferred __put_task_struct() calls have been
working for RT on older kernels for quite a while.

Anyway, I asked them to hold because this discussion here was still happening.

If that helps to get the ball moving and sounds reasonable to you all, I could
propose a STABLE-only patch that isolates the change to RT. Does that make
sense?

Luis

> Oleg.
> 
> On 09/16, Oleg Nesterov wrote:
> >
> > On 09/16, Peter Zijlstra wrote:
> > >
> > > On Mon, Sep 15, 2025 at 02:35:40PM +0200, Oleg Nesterov wrote:
> > > > On 09/15, Peter Zijlstra wrote:
> > > > >
> > > > > Why have !RT behave differently? That is, why isn't this simply a
> > > > > 'buggy' comment/changelog issue?
> > > >
> > > > Well, this was discussed several times, in particular see
> > > > https://lore.kernel.org/all/CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com/
> > > >
> > > > And task_struct->rcu_users was introduced to avoid RCU call in put_task_struct() ...
> > >
> > > Ah, I forgot about that thing.. Although I had vague memories of that
> > > argument on rcu_assign_pointer() vs RCU_INIT_POINTER().
> > >
> > > > But I won't really argue if you decide to remove this !RT optimization, although
> > > > I think it would be better to do this in a separate patch.
> > >
> > > Right. So when they wanted to remove that preemptible() clause, I was
> > > like why again do we have this !RT exception at all, and can't we get
> > > rid of that.
> > >
> > > If git isn't confusing me again, this got merged in this cycle. But so
> > > far no benchmark came and told us this was a bad idea.
> >
> > I still think it would be safer to merge this patch from Luis before
> > v6.17, then possibly remove this special case in a separate patch...
> >
> > > So what do we do now... do we restore the !RT exception (so far there
> > > aren't any numbers to suggest this mattered) or do we let it be for a
> > > bit and then go and clean things up?
> >
> > It is not that simple. Please note that put_task_struct_rcu_user()
> > delays put(tsk->usage), not free(tsk).
> >
> > So for example with this change
> >
> > > @@ -305,7 +288,7 @@ void release_task(struct task_struct *p)
> > >  	if (thread_group_leader(p))
> > >  		flush_sigqueue(&p->signal->shared_pending);
> > >
> > > -	put_task_struct_rcu_user(p);
> > > +	put_task_struct(p);
> > >
> > >  	p = leader;
> > >  	if (unlikely(zap_leader))
> >
> > This code
> >
> > 	rcu_read_lock();
> > 	tsk = find_task_by_vpid(...);
> > 	if (tsk)
> > 		get_task_struct(tsk);
> > 	rcu_read_unlock();
> >
> > becomes wrong, get_task_struct(tsk) can increment tsk->usage == 0.
> >
> > Oleg.
> 
---end quoted text---

