Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFF233155
	for <linux-rt-devel@lists.linux.dev>; Fri,  1 Aug 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043957; cv=none; b=HAxfKaSdyWmLs0te0Q3xtF9LE/I/rsObQOnEUp1QvumsdQynZlLTJU8MOF49UatWvfakfTxE10xQq9bJPvdk5i8ZP48Q/OJbCVqX0p9MHpiRsZtdDJ6Vr9yo71nChXhiCx3VjUdnwEAxKtdkUUh31eox+6e1mjGm3Xx8Y0/dYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043957; c=relaxed/simple;
	bh=hapeyy6ZUbsbldLETwPLW02PG29HLqTfMFCCw/DwPiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGPZHCoSI41cmAHpFkI5j2HgoLUiTYFZL7/pVJYIH4hJFhQc6QPl9ymZPHDDYSN1oWTm6Z6DfrdeiZANFPMHl/BFhsKdB6gmACakbJtGh7a5w/hPRYo8G72JFaUi8dD2cJm1xUGPl7pme0mipmDpvjg3fqih5WfNFozHqltWsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNMjNZmu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNMjNZmu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754043954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fBy/ubE+PTLysJPtmvIHw7wyj6tGguI9dSijz7MCsA=;
	b=cNMjNZmu0HBnOs+ywqH4uKHFFHgje2nQ6RK+NNxjZ3b/hGZEVeOKRkS5jQLHCAH5vyKdj8
	rQLA7r74Hk5Ct5VV01bYLRqX/r1AJGodjTtYs7V7WABJcF8Oa2tVBUYXseN9ZcN9RyHrNG
	v9Tdf8VnjOmSda6WIq/QLuqICl5r3GU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-DAHlOX1YN0GXCAgaD-eg1w-1; Fri,
 01 Aug 2025 06:25:50 -0400
X-MC-Unique: DAHlOX1YN0GXCAgaD-eg1w-1
X-Mimecast-MFC-AGG-ID: DAHlOX1YN0GXCAgaD-eg1w_1754043948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC591956094;
	Fri,  1 Aug 2025 10:25:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A19F718003FC;
	Fri,  1 Aug 2025 10:25:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  1 Aug 2025 12:24:37 +0200 (CEST)
Date: Fri, 1 Aug 2025 12:24:29 +0200
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
Message-ID: <20250801102428.GB27835@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729130936.GB18541@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/29, Oleg Nesterov wrote:
>
> On 07/29, Luis Claudio R. Goncalves wrote:
> >
> > On Tue, Jul 29, 2025 at 01:47:03PM +0200, Oleg Nesterov wrote:
> > > On 07/29, Luis Claudio R. Goncalves wrote:
> > > >
> > > > +	/* In !RT, it is always safe to call __put_task_struct(). */
> > > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > > +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > > > +
> > > > +		lock_map_acquire_try(&put_task_map);
> > > > +		__put_task_struct(t);
> > > > +		lock_map_release(&put_task_map);
> > > > +		return;
> > > > +	}
> > >
> > > FWIW:
> > >
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > >
> > >
> > > At the same time... I don't understand this DEFINE_WAIT_OVERRIDE_MAP().
> > > IIUC, we need to shut up lockdep when put_task_struct() is called under
> > > raw_spinlock_t and __put_task_struct() paths take spinlock_t, right?
> > > Perhaps this deserves a comment...
> >
> > I reverted that code to the previous state, commit 893cdaaa3977 ("sched:
> > avoid false lockdep splat in put_task_struct()") and simplified the "if"
> > statement.
>
> Yes, yes, I see and I have already acked your patch.

So I think you should just resend it.

s/LD_WAIT_SLEEP/LD_WAIT_CONFIG/ needs another discussion even if I am right,
sorry for the confusion.

Oleg.

