Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604232E126
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Oct 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712080; cv=none; b=Xj8WT5K/rQnX+LcxYaPpHZmrJogJpfx1lmfXrdzBttwvQ1AHE4gNVwUrVCWk4Ly0oKxgbCWrWghov8WAYKzgTZXcCKf6Dk/E54ygLrOns/1Tqbk53AFBeKaa9cuKpkokduY5epej36Q/cUhP8TkvXxeV9W6hni6gguE0bzFz49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712080; c=relaxed/simple;
	bh=mV+y5b8s0cJZa3zlLL+rOha+CPveUHdKmGcQc0YzlF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAtD6Or1VQ0IvOP55hCtzCpTlFu2+//yGOxXverl79q0iaNDwxlAF88sqnAInBOQIBD6fYNeG5RtCTe1Z3+BEkQ7J0fFShhGXUS7LplPeYQZ2PuATL+wG9WrCTE3bgFoEiBW3/oyCn0njWEX8qYEr3mhSTN/fZXiqcJy51Vv7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4COkUjF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4COkUjF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuiYUfx2UQmSZfg+6sdpv7icyFzK7DxF2mfdCQCP5oQ=;
	b=e4COkUjFlGm9N4WbVBcTKPlc7yYeLL7e5YO4DdCdjnP0qJ9ttTAB+5lGt6bVLniWD1hWxk
	E1zrI6XEdpUfw6PplEMXDzFN++ztG25BoSySXPLsX+RqA29w5SJAEQdQ1z8VsWFJyjSbGl
	uzaede+Hl4QU2W3ypuQSWXgAC6AWHP4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-pBeb2vfEMfijmMAnVTVENQ-1; Fri,
 17 Oct 2025 10:41:15 -0400
X-MC-Unique: pBeb2vfEMfijmMAnVTVENQ-1
X-Mimecast-MFC-AGG-ID: pBeb2vfEMfijmMAnVTVENQ_1760712073
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A337619560B0;
	Fri, 17 Oct 2025 14:41:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.241])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A684C19560AD;
	Fri, 17 Oct 2025 14:41:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Oct 2025 16:39:53 +0200 (CEST)
Date: Fri, 17 Oct 2025 16:39:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
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
Message-ID: <20251017143944.GB21102@redhat.com>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
 <20250915123539.GC23082@redhat.com>
 <20250916100953.GG3245006@noisy.programming.kicks-ass.net>
 <20250916113043.GA32038@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916113043.GA32038@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Peter,

So I think that delayed_put_task_struct() has to stay and this means
that we have 2 RCU grace periods in the "typical" case when the exiting
task without extra references is reaped (or autoreaped if a subthread).

As I said I won't really argue, but what is your final thought on this?
Should we forget this patch from Luis? I'd prefer to restore the !RT
exception...

And another question. Sasha and Greg are going to add 8671bad873eb
("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
to -stable. Do you think it is fine to backport this commit as is?

Oleg.

On 09/16, Oleg Nesterov wrote:
>
> On 09/16, Peter Zijlstra wrote:
> >
> > On Mon, Sep 15, 2025 at 02:35:40PM +0200, Oleg Nesterov wrote:
> > > On 09/15, Peter Zijlstra wrote:
> > > >
> > > > Why have !RT behave differently? That is, why isn't this simply a
> > > > 'buggy' comment/changelog issue?
> > >
> > > Well, this was discussed several times, in particular see
> > > https://lore.kernel.org/all/CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com/
> > >
> > > And task_struct->rcu_users was introduced to avoid RCU call in put_task_struct() ...
> >
> > Ah, I forgot about that thing.. Although I had vague memories of that
> > argument on rcu_assign_pointer() vs RCU_INIT_POINTER().
> >
> > > But I won't really argue if you decide to remove this !RT optimization, although
> > > I think it would be better to do this in a separate patch.
> >
> > Right. So when they wanted to remove that preemptible() clause, I was
> > like why again do we have this !RT exception at all, and can't we get
> > rid of that.
> >
> > If git isn't confusing me again, this got merged in this cycle. But so
> > far no benchmark came and told us this was a bad idea.
>
> I still think it would be safer to merge this patch from Luis before
> v6.17, then possibly remove this special case in a separate patch...
>
> > So what do we do now... do we restore the !RT exception (so far there
> > aren't any numbers to suggest this mattered) or do we let it be for a
> > bit and then go and clean things up?
>
> It is not that simple. Please note that put_task_struct_rcu_user()
> delays put(tsk->usage), not free(tsk).
>
> So for example with this change
>
> > @@ -305,7 +288,7 @@ void release_task(struct task_struct *p)
> >  	if (thread_group_leader(p))
> >  		flush_sigqueue(&p->signal->shared_pending);
> >
> > -	put_task_struct_rcu_user(p);
> > +	put_task_struct(p);
> >
> >  	p = leader;
> >  	if (unlikely(zap_leader))
>
> This code
>
> 	rcu_read_lock();
> 	tsk = find_task_by_vpid(...);
> 	if (tsk)
> 		get_task_struct(tsk);
> 	rcu_read_unlock();
>
> becomes wrong, get_task_struct(tsk) can increment tsk->usage == 0.
>
> Oleg.

