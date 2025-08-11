Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAF214A91
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906789; cv=none; b=PA4jWynMWoNdjDzWX4LzR5Wd5mCWlAe46rVG4PCHxBoraAK/DhmkHjAMZ0VIQ24cetowVy+THbYeIkM7llJ0iYmseGmOjQA2eBVgyyoRb9Yr8jGRBTH0udMHGsBB/SbmbIGRQhjX8cR+trwG+tghQx1bD4oa8R1KD2k8ahq8Mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906789; c=relaxed/simple;
	bh=/029OGICgOstJIarIv1HWcrJNV0YszZiteVd1Zck31o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G28PD64n/uqzPzy8s2q3B2wPLLr0XYVCchYmiLY/TGQGww6cK+cPaJR+G58197eDdkjhXi4wNE0OHTQ800gnAgJZKEJXLLDddr4jWG0G5yEH1kpPPgMgXzfgIfHH56+kZ58olRzA2xrR4c1/JGEmUZS5mx5aS8bh/7QN2ebnWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2WVyVuc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=peQXIuol; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2WVyVuc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="peQXIuol"
Date: Mon, 11 Aug 2025 12:06:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754906785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsxDNvVqemD/2wPn8jBzJb7mtx3d7CZLew7y1CcraZA=;
	b=P2WVyVuc7eR1TjzCeNEhVEoesqMsQvUIJFWEBqZQoM33ja8HjqtDFF+OFsk8D9UTfg/xWA
	/hdqnFsIp/0Z3UG2GY6B1h7bipvEJ7Am9PnqGls2uxhAxr+mvzQ5rY2G1MqMpkbb2eSG+o
	X7NUwkPlUscgf4sgbu+xjR9uzp4WRucfcxT3EOEPVp/He5jgQCQOirOKoCIdc3k7Ti3ldi
	FFpns1+QYJH0O8DwKnQtOr/oFL5NpPAA1QvhC9EC399HGTtEr15CviO/KhTuEa8sXrI973
	wKSkDYo1uesnLyeqFPL5w1GXgoaUCDhXtw9MiRdJAoW3vwkY9dB2Fiqeug4gUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754906785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsxDNvVqemD/2wPn8jBzJb7mtx3d7CZLew7y1CcraZA=;
	b=peQXIuolIaxib6yAruwF+dMwzYLkdVdjtQd4PyhA442knjq3EZ3M7eXdiAlTrewTLs6xgX
	EWj5q4Qxxokox8Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20250811100624.LuYV-ZuF@linutronix.de>
References: <aJOwe_ZS5rHXMrsO@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJOwe_ZS5rHXMrsO@uudg.org>

On 2025-08-06 16:43:55 [-0300], Luis Claudio R. Goncalves wrote:
> Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
> if pi_blocked_on is set") changed the behavior of put_task_struct()
> unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
> with the commit description.
> 
> Restore the previous behavior of put_task_struct() for the PREEMPT_RT
> disabled case.
> 
> Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> Acked-by: Oleg Nesterov <oleg@redhat.com>
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

I don't want to drag this but this comment is obvious for anyone who is
fluent in C. It is just a statement with no explanation.
An important note would be that the atomic context restriction only
apply to PREEMPT_RT and therefore we have this context override for
lockdep below. The other question would be why don't we do this
unconditionally regardless of PREEMPT_RT. The only reason I could find
is that releasing the task here from the "exit path" makes the vmap
stack "earlier" available for reuse.

> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> +
> +		lock_map_acquire_try(&put_task_map);
> +		__put_task_struct(t);
> +		lock_map_release(&put_task_map);
> +		return;
> +	}
> +
>  	/*
>  	 * Under PREEMPT_RT, we can't call __put_task_struct
>  	 * in atomic context because it will indirectly
> @@ -137,10 +150,6 @@ static inline void put_task_struct(struct task_struct *t)
>  	 * current process has a mutex enqueued (blocked on
>  	 * a PI chain).
>  	 *
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Though, in order to simplify the code, resort to the
> -	 * deferred call too.
> -	 *
>  	 * call_rcu() will schedule __put_task_struct_rcu_cb()
>  	 * to be called in process context.
>  	 *
> 

Sebastian
