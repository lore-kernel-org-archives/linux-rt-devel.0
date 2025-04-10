Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91C280CE3
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Apr 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287609; cv=none; b=NJo85vf2pcxTRfijFspl4K7KPmH8ItTO3xsQxyBkAEbRKAH/DTDHHDkqeU1VZKM5rLuHaB3ClONb7+xYUIRJkliPmHKC9GxnTQOV0YVc3o5UtyKS40VEZKgP6gIMwx9gk9xh+XHN2eG5xKf41Dyi2El7BZztZW2i1RJVa9To39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287609; c=relaxed/simple;
	bh=r4YN+6THFRqD857AEAmFYAZV7Q34wl4AiyDmQEvfLag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHLM2POQ5d9XuUWL/VWfiLDLEKJi7vIQ5Qinq+ompklhGrjgUeMeGLzr7ehTj0W6rOqjuqpmN5vdZcPQ70LQiYLGkx/BxEi1vVww1OvbOfhegBiCePTByPRbj3MGGq6V6jiCTmqSqOdEcqRXtm+zwe8oEKIBGaNpFMxydmqJ/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xkIbW/xH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjJ7laHp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xkIbW/xH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjJ7laHp"
Date: Thu, 10 Apr 2025 14:20:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744287604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUz3XfGhWfvbtgammCb+KQml+nvemb+oZndlJttITBI=;
	b=xkIbW/xHzPrqrZSEg8QZABEM2E43uwvLYpnzekfDMX/S5T5oB/pyi/qX+6lVflR56xbdQA
	L8PNimBmMeW0N/T0tZYJNiW9txpXW05yO19kdcyQMMk9tCMhabwUppJaa6v3444BRk/KzJ
	zkDwLFbHBqkkMCeArPBl0CGCukWDmr5dgpLhjxwI1Fplea8KspYiwVuDoEK+vjQB2tktR5
	NPR0zdtuFEiO46RlU7d4u9smbnFsmrEdVGR7zKRbspJ9RdCpx9WnTiZMkcmtu/aN5vSMgF
	uZuasbxwcupiZmIEMW2tiCZMw0Kuefhv+XN8NGrw5m89DgBnu/utf2okp7lJXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744287604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUz3XfGhWfvbtgammCb+KQml+nvemb+oZndlJttITBI=;
	b=XjJ7laHpjd0V25mYg0lVL2+d69SdVU0UL0vnH+fdxAX9CAUHzbg35jYa7vEJtR2G8Hx9K8
	pCTP6BAqF483UhBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, lclaudio00@gmail.com
Subject: Re: [PATCH v3] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250410122002.JxN9F-nE@linutronix.de>
References: <Z_e0uh36Ezz6isYo@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_e0uh36Ezz6isYo@uudg.org>

On 2025-04-10 09:10:12 [-0300], Luis Claudio R. Goncalves wrote:
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -134,22 +134,12 @@ static inline void put_task_struct(struct task_struct *t)
>  		return;
>  
>  	/*
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> -		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> -
> -		lock_map_acquire_try(&put_task_map);
> -		__put_task_struct(t);
> -		lock_map_release(&put_task_map);
> -		return;
> -	}
> -
> -	/*
> -	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * In !RT, it is always safe to call __put_task_struct(),
> +	 * but under PREEMPT_RT, we can't call put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
>  	 *
>  	 * call_rcu() will schedule delayed_put_task_struct_rcu()
>  	 * to be called in process context.

Did you test it with lockdep with and without PREEMPT_RT? It would be
nice to throw some testing on it.
This comment here "call_rcu will schedule bla in process context" is
wrong. It will schedule the callback in softirq context. Unless RCU is
configured to run the callbacks in rcuc/ thread which is the default for
PREEMPT_RT. Also delayed_put_task_struct_rcu() does not exist, imho
never did.

Sebastian
