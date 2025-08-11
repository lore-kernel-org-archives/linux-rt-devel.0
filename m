Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA82475C2
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914543; cv=none; b=FlKFvNM39XimFUW5Qgxx7WrQE8GhbaXJ/PhCUkRBwkQEmTvKErH97vRWpBuIA24i0P5cpxhJTwe8VNJQHrvGzKSGDEAGtRVP0z+OE622EAduuwWEBXKv4n+yR03r0qUI85j+fBvrq5SXW67TQt6DPTRh4fQK/SKthpGXoaFHrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914543; c=relaxed/simple;
	bh=9PnvPcABKmV5/6CiDXaIWcLuszwQ2TJZvbfPWm7Fz4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwfUyCBub/Fg+9P5MQop2YAVewvs8yVkd2LeKgDpR83p4Moe8Dhl0SUZxudar+1zjR+Y9uZEFR9NrOVKX9y6mlq7GySYA+rnat+QZckemgA2oGUjj8CpLg7xgDF155KQ7T0NPJRDmemngYUomtTwV4adn7BZtkRSxd7XWOSQ6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c5MhxCyg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYOVlijP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c5MhxCyg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYOVlijP"
Date: Mon, 11 Aug 2025 14:15:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754914539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UoZC7pWHR1le4ztGf7xVwWXArkfm6+gF20WfXJ9xuM=;
	b=c5MhxCygIjWf+6kNje5tX4aaAlPJ7hnNvjJO8fd3zhjx8GgQIzpFi+mg7iJYsI9S9G/CcY
	WDLre2lEH8tw0hFVheUvSGZijRcW05CBXW2LZwLEtQ/qXYtIXyFOOtMLyczh//DWkcl32v
	4schXWwyv/Laq7GX0sOdwN8aAfArecdPuJ7CSxk2W0TJa/p4mnbLOXdkJ2FcgZ0LJCB9fi
	Tl+6R34ZHf4Xl+GF02XOt5flnXJSJCFcpbVa1eHBRzJHVbMjVdP2il+ymy1anshmIx83Ol
	MLKVyV69aEzWIFSzA5Oa+78kOuF5fkCYP2AsBTqhDiotdC1R3S3LRjFJ2ao9NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754914539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UoZC7pWHR1le4ztGf7xVwWXArkfm6+gF20WfXJ9xuM=;
	b=gYOVlijP+K6UFI9N7g+msJLL6TQGfKlHEJydhP+dF68uGUdOAUCAwKtnoGtGuTDqrsIbEl
	9s/Yx1b0sMnpQJAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20250811121536.taFIcCHt@linutronix.de>
References: <aJOwe_ZS5rHXMrsO@uudg.org>
 <20250811100624.LuYV-ZuF@linutronix.de>
 <20250811104033.GA5250@redhat.com>
 <20250811110501.nTDNkPnM@linutronix.de>
 <20250811112119.GC5250@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811112119.GC5250@redhat.com>

On 2025-08-11 13:21:20 [+0200], Oleg Nesterov wrote:
> On 08/11, Sebastian Andrzej Siewior wrote:
> >
> > On 2025-08-11 12:40:34 [+0200], Oleg Nesterov wrote:
> > >
> > > What exactly do you think we could do regardless of PREEMPT_RT?
> >
> > Do what we do now and have one free path for task_struct regardless if
> > PREEMPT_RT is enabled or not. The one via RCU which delays the freeing
> > until after the grace period.
> 
> Ah, got it. I won't really argue, but...
> 
> call_rcu() is not free, it obviously delays free_task/etc. To me this
> !PREEMPT_RT optimization makes sense.
> 
> But lets forget it for the moment. This patch
> 
> 	https://lore.kernel.org/all/aGvTz5VaPFyj0pBV@uudg.org
> 	[PATCH v6] sched: do not call __put_task_struct() on rt if pi_blocked_on is set
> 
> removed that optimization by mistake, this doesn't even match the changelog.
> I think it should be restored, and this is what the new patch from Luis does.
> 
> Then we can discuss this all again and possibly remove it, but this
> should be explicitly documented in the changelog.

Certainly. I am not saying we should keep it as is. The added comment
appears wrong but I am all for getting this merged and then sorting out
later.
Thank you for spotting this ;)

> Oleg.

Sebastian
