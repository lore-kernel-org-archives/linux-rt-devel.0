Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAC2E716B
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Jun 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165824; cv=none; b=ciay41sa89fKG0YGyBmZmmQ2WenNiy7ZDGd7OWEo2KWNnYTSz7TBJNqG5+eDVHST87N7izF5fjjQ7kN/d3IHoOAQijDlZTiaYUQz2Z2j+calSFbTjDpWciABe+BORUTWmWcFqvKM9H8JSdTmQbxjyLLWofTHPKuJVOZS/Rk0sK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165824; c=relaxed/simple;
	bh=/+Qev5ZixSm+PeJ3Y22CDie9pW5HM+UR+Aim1JqHFpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyPumiC28MZXWqXtdbeRhFbGVtwfU4E04raoeI6UkPx0gMu+IiprR/4e+NfmE3KdhLQ4Q5qAfUeoz0W31H9tPTn0078eATcoqz4tCpZhZMXvxA7ADJCaC2/7DesNY+UgALhGKTo4WtJObg/dK6GvYjik6htEsKXEHyf9rZgBKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFGGWI9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFGGWI9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750165821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfbx2bhvNqJG4cR2xnKGL2cg6Kwa3zcjDRyQFAhyr84=;
	b=OFGGWI9J7EQig0utmI1N4IGwk/uMgCELnchc/tWNNAHVUrIbxOeATA1v/wQ1D/jHEXaA9k
	I5vqO/xVmnwsQ6B7f8qHaNd4alAJhH1MrgT6gW7GHavl8PSE2Zso0R/s4xvLpXvKF7uE10
	1WKM673Bvc99xznejwttaTGEkb6MfS4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-GKrD5du4MCCu8jI_DwTSNA-1; Tue,
 17 Jun 2025 09:10:17 -0400
X-MC-Unique: GKrD5du4MCCu8jI_DwTSNA-1
X-Mimecast-MFC-AGG-ID: GKrD5du4MCCu8jI_DwTSNA_1750165815
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ABCD1956095;
	Tue, 17 Jun 2025 13:10:09 +0000 (UTC)
Received: from localhost (unknown [10.22.89.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99E8D30001B1;
	Tue, 17 Jun 2025 13:10:06 +0000 (UTC)
Date: Tue, 17 Jun 2025 10:10:05 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <aFFpLWyrxZ5CRbBG@uudg.org>
References: <aEw-KjUjjP2gYH6z@uudg.org>
 <20250617092609.GR1613376@noisy.programming.kicks-ass.net>
 <20250617093627.ykSeZMqk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617093627.ykSeZMqk@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 17, 2025 at 11:36:27AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 11:26:09 [+0200], Peter Zijlstra wrote:
> > On Fri, Jun 13, 2025 at 12:05:14PM -0300, Luis Claudio R. Goncalves wrote:
> > > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > > from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> > > with a mutex enqueued. That could lead to this sequence:
> > > 
> > >         rt_mutex_adjust_prio_chain()
> > >           put_task_struct()
> > >             __put_task_struct()
> > >               sched_ext_free()
> > >                 spin_lock_irqsave()
> > >                   rtlock_lock() --->  TRIGGERS
> > >                                       lockdep_assert(!current->pi_blocked_on);
> > > 
> > > Fix that by unconditionally resorting to the deferred call to
> > > __put_task_struct() if PREEMPT_RT is enabled.
> > > 
> > 
> > Should this have a Fixes: tag and go into /urgent?
> 
> I would say so. I'm not sure what caused it. I think Luis said at some
> point that it is caused by a sched_ext case or I mixed it up with
> something. Luis?

You are correct, all the initial cases we observed were triggered at
sched_ext_free(). Later, Crystal Wood was able to pinpoint the real
problem, __put_task_struct() being called by an RT task with a mutex
enqueued. With that in mind we were able to identify other cases with
a similar cause.
 
> The other question I have, do we need to distinguish between PREEMPT_RT
> and not or can we do this unconditionally?

After you mentioned that idea in the v2 thread, I ran stress tests (LTP,
stress-ng, perf bench all in a tight loop, ...) and a few benchmarks, o
kernels with and without PREEMPT_RT enabled, with and without lockdep.
Everything worked fine, but due to the lack of a specific benchmark to
run, to ensure no penalty was added by the patch, I was not confident
enough to suggest the change.

Luis

> Sebastian
> 
---end quoted text---

