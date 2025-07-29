Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C540855
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Jul 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794664; cv=none; b=hkNoBuCRvJz4KTooS8sEOvZjMUV2KK6DUj87wYc+Lrs+R51AEd6PUkyPw621jYGEVRYJ6NvjFYsbB3pI8CxC808oZ8SvSgMcXTNmOWDjypPDVZ/aj88steIk9dh31+NFAk9czzrOt5komy1MnlUXN2eRTFNbXa4fGSJLyyVtCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794664; c=relaxed/simple;
	bh=xaWzu6g+ccgR00Y6GpZPkAW40xv/vfig59QiiS9kFrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YElMBfxcP/twzXtO1o7viywtPQ3dj0NGul+Wzj9caGE8NyyW0nU+ndlkCUJvwqiCJgZDdl+aPTCKw8uvMZVWAL+wB4O9Un0FmFCNlSL1rs5kZBA3QeFLQLc0rigxR0P3yFYA3Ck7/UxzjpNG8O6/PhaEhcg87+fJH0tOYcU2gK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPrftPii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPrftPii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753794662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQqNRXbyWnooUNuvo+Gq1oeZqGv2RnPfEdo++Sxi2sM=;
	b=LPrftPiiGcZ+4xjzxwopKtw6uJMiKwULPm29dY8kHCx5wPObei2sIgG6SRlYjjDa07+TQ9
	/c1bcksWzEoOouUlmE0PjXUjOJZPmUx38er3XBV69R9tAKMe2c11MGHkwOze8uq1Bjwt1T
	3V44RpPnvInd5A54s7j/OgNm9UsFdWE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-jngmDRu6O3mWunBjIPS5PQ-1; Tue,
 29 Jul 2025 09:10:56 -0400
X-MC-Unique: jngmDRu6O3mWunBjIPS5PQ-1
X-Mimecast-MFC-AGG-ID: jngmDRu6O3mWunBjIPS5PQ_1753794654
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 028061800131;
	Tue, 29 Jul 2025 13:10:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 393571800242;
	Tue, 29 Jul 2025 13:10:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 29 Jul 2025 15:09:46 +0200 (CEST)
Date: Tue, 29 Jul 2025 15:09:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
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
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250729130936.GB18541@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIjCYEkgNvVpMYCS@uudg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/29, Luis Claudio R. Goncalves wrote:
>
> On Tue, Jul 29, 2025 at 01:47:03PM +0200, Oleg Nesterov wrote:
> > On 07/29, Luis Claudio R. Goncalves wrote:
> > >
> > > +	/* In !RT, it is always safe to call __put_task_struct(). */
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > > +
> > > +		lock_map_acquire_try(&put_task_map);
> > > +		__put_task_struct(t);
> > > +		lock_map_release(&put_task_map);
> > > +		return;
> > > +	}
> >
> > FWIW:
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> >
> > At the same time... I don't understand this DEFINE_WAIT_OVERRIDE_MAP().
> > IIUC, we need to shut up lockdep when put_task_struct() is called under
> > raw_spinlock_t and __put_task_struct() paths take spinlock_t, right?
> > Perhaps this deserves a comment...
>
> I reverted that code to the previous state, commit 893cdaaa3977 ("sched:
> avoid false lockdep splat in put_task_struct()") and simplified the "if"
> statement.

Yes, yes, I see and I have already acked your patch.

> In the original code, PREEMPT_RT could call __put_task_struct()
> if the context was preemptible. But in the proposed code __put_task_struct()
> is only called if PREEMPT_RT is disabled. In this case I believe we could
> simply do:
>
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		__put_task_struct(t);
> +		return;
> +	}
>
> Does that make sense?

Hmm... But, again unless I am totally confused, we do need the
DEFINE_WAIT_OVERRIDE_MAP() trick even if !PREEMPT_RT ?

Looking at lockdep_wait_type, I think that with
CONFIG_PROVE_RAW_LOCK_NESTING=y lockdep enforces the PREEMPT_RT
locking rules even if PREEMPT_RT is not set?

But:

> > But if I am right, why LD_WAIT_SLEEP? LD_WAIT_CONFIG should equally work, no?
> >
> > LD_WAIT_SLEEP can fool lockdep more than we need, suppose that __put_task_struct()
> > does mutex_lock(). Not really a problem, might_sleep/etc will complain in this
> > case, but still.

I still think LD_WAIT_CONFIG makes more sense.

Oleg.

