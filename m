Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149732BE641;
	Sun,  7 Jun 2026 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809312; cv=none; b=FvxPMvmvB98MEoSksidcCa5sV9MUk8j6Rv8Cw/tYjgV+reGwTsl+tSNbFhbVZxjCfj4egEZrr3cx4e1eJnEW1BqHT3uxWW6F7ZqwSCH4g57GFONGcJJbbCtMODsb2GPdeA/ffyzR1Pv1xkZr7HIbOjb/wp6+pQKZaQ3HpwXZGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809312; c=relaxed/simple;
	bh=cPZcfHcMEnciJwgq98IQsKaZZSXQn5VLVYPno50fMys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMCOLNuv8cc/2VhHvHBMi2eqYZxu8gC1kJLvt7MzIvUdDKZxZByzsdUC48oZd/bxH47HSu4tqx9or2BGTG86DvgWR7nGzL4MgqX8r/JKgg+we18Qr6E9ZDrtOPtkC9H2s5TEFmK/St/CCMjjM+OC3j4obW2sBTt/8CO6QcxQo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjKmPCcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjKmPCcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE40F1F00893;
	Sun,  7 Jun 2026 05:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780809310;
	bh=yi9JxIpfojKHJlYMWLhkoelG5lv+z0Nj1VKA5dPABhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fjKmPCcg3NhVbivMs2X3tHviz0o08DReTRWh2e/Dl+h5BXpHVDi+YgGOe1x4wQOMQ
	 ecXOe7jK+LEuXmh+lTkxjHkU46hCIPaOYQDCjYqJlwcufJeXbftQeARDxbHXHl82FC
	 cOUveTGnGJue2QNaUWr4mfre4v9F34Wk8iI9as9QjnD0AtztDsdWU3D/JkIUZd8wiU
	 yjJvNl0VCxEZyu3XymNJ9dL76Ttaf3/Ju1PyFTr8P51CO1ahljWLEJPs7+jN+CcEI2
	 Gb3z9laXlTv7tDV1QGf36qKaGqq3TNd80lIyQfUDROAwoNSzAbFTmMuCGSULPzyAn3
	 BsrLYEpFpzUCA==
Date: Sun, 7 Jun 2026 07:15:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5] debugobjects: Don't call fill_pool() in early boot
 hardirq context
Message-ID: <aiT-Wp4rAvJoN6iG@gmail.com>
References: <20260605173038.495075-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605173038.495075-1-longman@redhat.com>


* Waiman Long <longman@redhat.com> wrote:

> When booting a debug PREEMPT_RT kernel on an arm64 system with grace
> processor, a "inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage"
> lockdep warning message was reported to the console.
> 
> During early boot, interrupts are getting enabled before the scheduler
> is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
> can fire and attempt to fill the pool from within the hardirq. This can
> lead to a deadlock the interrupt occurred while in the memory allocator.
> 
> Add a new can_fill_pool() helper and reorder the exception rule and
> forbid this scenario by excluding allocations from hardirq.
> 
> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
> Co-developed-by: Waiman Long <longman@redhat.com>
> Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/debugobjects.c | 46 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index b18a682fe3da..6fb00e08a4e2 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_blocked_on(void)
>  #endif
>  }
>  
> +static inline bool can_fill_pool(void)
> +{
> +	/*
> +	 * On !RT enabled kernels there are no restrictions and spinlock_t and
> +	 * raw_spinlock_t are the same types.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return true;

> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
> -	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
> +	if (can_fill_pool()) {

Would have been nice to have this as two patches: first one
factors out the check into can_fill_pool() without changing the
logic, while the second one applies the fix to can_fill_pool().

Thanks,

	Ingo
