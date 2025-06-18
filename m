Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDD27D786
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Jun 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750230236; cv=none; b=jcbwhMHRBxg5REqVD7BLiD/eda8IiBrAyqxXqizhKwBD3K9OB9G+EpTVeYCw53ofDUsQrIru2P6YB17N2Mtz2BzDIYBk0ShySfwRwoK42XDYBru9i4UZ5xm3AfvX6qfJnhnOJnFsWU3Kptc47s5lerGbXA9UcUvlfunPmWdUCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750230236; c=relaxed/simple;
	bh=tpMeZf+mN9kBLrjXf5FHDPHTPfTNTbh9zWys0Rqi8yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2KRjxqfPG+CFHcKzSNLsZ74aSVf7dCVA4pffttsfH1IZzu942/5cNF27z69udDjpTJa1hGQK3YeDuPMCNFnJKi9+cnlK5XvpHFZtFZ2iRJllNL5WCfSU3HfFm9Ct+/l/riPz32hb5t+iUXHkXfTTL/ep5JBhD2o3+W3K7Ckoqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XP9PPGv+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mMlBIbcY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XP9PPGv+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mMlBIbcY"
Date: Wed, 18 Jun 2025 09:03:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750230232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mG9fFOBRDbeQxvHMnRmO2UT0m6S7Pz44AblusdQZk6Q=;
	b=XP9PPGv+jwYqKLE0hcLg+amb2E14gjSFPhqn5I7Wd99Yjfe/030v4qYcztsso8cplynlB1
	Q472PuNdf4rCR44GrrzCQrwUC6H6YSGKxfMWBC4zNlru5R3S0Zpq66dqa93RiPqXcLaT+O
	UNL5CbYl6vovfiJXYTQ2O4r65TpWLwByE+LbfKfFI0zx7FYUXkpcAuqB1bU/BWfFi3ZN9E
	kcTaJ329rgMvu7zbECW0uDlF2duLK59N6Dgr/xUQBraxzBYOgKM5z0VZ+T1x/5LGD2+HGi
	s6qcS1Gb9Bi5zH//rHgK6xizDnB4RaPDosft5foY60VdRTEh97QG+x0pwXhwOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750230232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mG9fFOBRDbeQxvHMnRmO2UT0m6S7Pz44AblusdQZk6Q=;
	b=mMlBIbcYZetCscJxFrWtzIRZC57pd9oJDuIvP96i6dGQ0Q/1sJLbqfyoyEIMUfOhPfBY6q
	vpxV/b0pSunxK5Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v5] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250618070350.19JbjFnG@linutronix.de>
References: <aFF1BKtdQCnuYMaS@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFF1BKtdQCnuYMaS@uudg.org>

On 2025-06-17 11:00:36 [-0300], Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
> 
>         rt_mutex_adjust_prio_chain()
>           put_task_struct()
>             __put_task_struct()
>               sched_ext_free()
>                 spin_lock_irqsave()
>                   rtlock_lock() --->  TRIGGERS
>                                       lockdep_assert(!current->pi_blocked_on);

Maybe with the addition of

| The first case was observed with sched_ext_free(). 
| Crystal Wood was able to reproduce the problem to __put_task_struct()
| being called during rt_mutex_adjust_prio_chain().

The first sentence will imply a Fixes: with the introduction of
sched_ext. The second implies that the original fix was not complete and
nobody managed to trigger it until now.

> Fix that by unconditionally resorting to the deferred call to
> __put_task_struct() if PREEMPT_RT is enabled.
> 
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Sebastian
