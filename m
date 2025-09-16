Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447651EDA2C
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022351; cv=none; b=MHwFsFhpSO0c4PjpFY8rXtLM+YUhFjurOl+Gca90CbgTbOoRCBW7+9KgOURWnJR9HLPIoIa48bQ/uJ+mINW5TGGs4v3F4R86nX1QHqjVhG1ERwErWcB7nZEPP1LB8JeQHkrze8Kg9fyMz5aTFcpJ4WhieD9jFrgRf1jQKcj3aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022351; c=relaxed/simple;
	bh=qrKm7Hjc2f6pjKnmdlrxFhFRJ74oWb1RCb7bzHCChWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBLHMG5/42hrx23C0ickPufuE0hAUCg11DJpbKrBDWG0B/dZnCOXp5iOynB5I6QJUtoprtxpD0Wa+xat/lQ9KV3//n//q8qMUghM26bibSOL8L0KSX2vmmKhyfqmHLTP2Cjqpa13uizJQKpT4758/1I6u9hYo9Jv3HH2+OTTz7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvnILw2n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvnILw2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758022348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9hCLZ50vYlDxaPnHwAZOwSPKZAjcTojGhWt+bNONuqk=;
	b=VvnILw2npz5dsOBFwt7dOpOVduRHIoHNV3wiIM5SqFR4sdlaWqcIR0oUYVBfibnhSIxwvl
	UffO0Fp0JCBqbK23m7sA6t1Nz51Go9yn90pDSARhOBQA5i54VijUe0a39cPHhrLPTV23Ro
	YTbmfQhpuAyOznIlzUAtUGPiMNHaJq8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-AtP0HQ_5NM6pJLds3SjhZg-1; Tue,
 16 Sep 2025 07:32:25 -0400
X-MC-Unique: AtP0HQ_5NM6pJLds3SjhZg-1
X-Mimecast-MFC-AGG-ID: AtP0HQ_5NM6pJLds3SjhZg_1758022343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1983F1800298;
	Tue, 16 Sep 2025 11:32:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7A2121800447;
	Tue, 16 Sep 2025 11:32:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 16 Sep 2025 13:30:58 +0200 (CEST)
Date: Tue, 16 Sep 2025 13:30:49 +0200
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
Message-ID: <20250916113043.GA32038@redhat.com>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
 <20250915123539.GC23082@redhat.com>
 <20250916100953.GG3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916100953.GG3245006@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/16, Peter Zijlstra wrote:
>
> On Mon, Sep 15, 2025 at 02:35:40PM +0200, Oleg Nesterov wrote:
> > On 09/15, Peter Zijlstra wrote:
> > >
> > > Why have !RT behave differently? That is, why isn't this simply a
> > > 'buggy' comment/changelog issue?
> >
> > Well, this was discussed several times, in particular see
> > https://lore.kernel.org/all/CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com/
> >
> > And task_struct->rcu_users was introduced to avoid RCU call in put_task_struct() ...
>
> Ah, I forgot about that thing.. Although I had vague memories of that
> argument on rcu_assign_pointer() vs RCU_INIT_POINTER().
>
> > But I won't really argue if you decide to remove this !RT optimization, although
> > I think it would be better to do this in a separate patch.
>
> Right. So when they wanted to remove that preemptible() clause, I was
> like why again do we have this !RT exception at all, and can't we get
> rid of that.
>
> If git isn't confusing me again, this got merged in this cycle. But so
> far no benchmark came and told us this was a bad idea.

I still think it would be safer to merge this patch from Luis before
v6.17, then possibly remove this special case in a separate patch...

> So what do we do now... do we restore the !RT exception (so far there
> aren't any numbers to suggest this mattered) or do we let it be for a
> bit and then go and clean things up?

It is not that simple. Please note that put_task_struct_rcu_user()
delays put(tsk->usage), not free(tsk).

So for example with this change

> @@ -305,7 +288,7 @@ void release_task(struct task_struct *p)
>  	if (thread_group_leader(p))
>  		flush_sigqueue(&p->signal->shared_pending);
>
> -	put_task_struct_rcu_user(p);
> +	put_task_struct(p);
>
>  	p = leader;
>  	if (unlikely(zap_leader))

This code

	rcu_read_lock();
	tsk = find_task_by_vpid(...);
	if (tsk)
		get_task_struct(tsk);
	rcu_read_unlock();

becomes wrong, get_task_struct(tsk) can increment tsk->usage == 0.

Oleg.

