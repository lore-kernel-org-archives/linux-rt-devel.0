Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADA264A60
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Jul 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789719; cv=none; b=oy1iytYy3gCkgdE8yzhgwfIziApRBrD+c4KRbKNClQPUbOXbjx+kHhoUZC1igCuIKISk9glPPnlyWZO8M5yoNe7rWsh4BHiSVZe3enBCMx+CktCC8VJVMCQx2XUkbVpUNZie4kkDsjRhcPFz3PJUAxcyaHMp7ZeBQ5CP3zZ6cLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789719; c=relaxed/simple;
	bh=3XEferhsEMHAhTNCVVg/lW95/LYKaoyywrPabs/mAsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwjmokta9JuDOVuyl+tVHEmNNkXHlhxkvXL7i30Zw6eBQLQf+w534uDJtMrBgWY8LpNOFG4U6PVgsZXAO+ty//fkoiBokm5ji8cXqiUzci41Qwh80zkErruyHjx6SaUs/R6/DMn9hYPOIIdDJrTmfb3R9QSDTDjX1L/Hm3IFqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y09jg9cT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y09jg9cT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753789713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHhBE2etiwERNACXev54KrLIkaeEriXEB12xk62PpE4=;
	b=Y09jg9cTz8DnENkVqatSJz+keYAVYXxUSi95WnAG9p5uZyRsJN6uUvLjSe7i1Sw25XFFEJ
	scmHZfTeTZfECJVRddiMdN+JnqIkQOfYKdFt48ucl+z4dmeJzhcscoJVf12eQ8i4Mrq33C
	Mpx4fJvlA9YYDK+3jmHI9GEKl/muAKQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-YKc8odR7OtK9g1wEYQ6a1w-1; Tue,
 29 Jul 2025 07:48:30 -0400
X-MC-Unique: YKc8odR7OtK9g1wEYQ6a1w-1
X-Mimecast-MFC-AGG-ID: YKc8odR7OtK9g1wEYQ6a1w_1753789701
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A964F18003FC;
	Tue, 29 Jul 2025 11:48:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5AE741800242;
	Tue, 29 Jul 2025 11:48:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 29 Jul 2025 13:47:12 +0200 (CEST)
Date: Tue, 29 Jul 2025 13:47:03 +0200
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
Message-ID: <20250729114702.GA18541@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIh5QajyaVT7MtVp@uudg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/29, Luis Claudio R. Goncalves wrote:
>
> From: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Subject: sched: restore the behavior of put_task_struct() for non-rt
>
> Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
> if pi_blocked_on is set") changed the behavior of put_task_struct()
> unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
> with the commit description.
>
> Restore the previous behavior of put_task_struct() for the PREEMPT_RT
> disabled case.
>
> Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index ea41795a352b..51678a541477 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -130,6 +133,16 @@ static inline void put_task_struct(struct task_struct *t)
>  	if (!refcount_dec_and_test(&t->usage))
>  		return;
>
> +	/* In !RT, it is always safe to call __put_task_struct(). */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> +
> +		lock_map_acquire_try(&put_task_map);
> +		__put_task_struct(t);
> +		lock_map_release(&put_task_map);
> +		return;
> +	}

FWIW:

Acked-by: Oleg Nesterov <oleg@redhat.com>


At the same time... I don't understand this DEFINE_WAIT_OVERRIDE_MAP().
IIUC, we need to shut up lockdep when put_task_struct() is called under
raw_spinlock_t and __put_task_struct() paths take spinlock_t, right?
Perhaps this deserves a comment...

But if I am right, why LD_WAIT_SLEEP? LD_WAIT_CONFIG should equally work, no?

LD_WAIT_SLEEP can fool lockdep more than we need, suppose that __put_task_struct()
does mutex_lock(). Not really a problem, might_sleep/etc will complain in this
case, but still.

Or I am totally confused?

Oleg.

