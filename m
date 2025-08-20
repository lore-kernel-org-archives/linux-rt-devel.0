Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580725A325;
	Wed, 20 Aug 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719094; cv=none; b=R+BrNHmnXnJSd+t/kjXLwCRV8fv9CKetoKvCFBeNWuDFI4KpX8xcVNbnoX4gTf6hzwlbu5nB+zM10uSzhuxnPXzgApiTaCGWM5MObVWI6zR0zfoic7GHaMoItQN46kZdp1e72eEAgBduGgUUOXNliqkb4srheLXAhdy9iMF+VPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719094; c=relaxed/simple;
	bh=Zvb+Vfh+eSxi8V3LzfMzob6KCrLVAFgE71unoyyC+Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re7Ejne1ZGa0FqC/Ebs/a49pQG4NcM/DwySH/liLToyQpbfQhx5jyMFcIKV37eECenbnGpSxdvZYEJ3fMlwEPTHYvwxG17CU5IoOK8Hy4QtrfIXrq5IUKjN32PU9jxtED7N/4MKJSafwFVl/PXNQcJhrJVYV3gxNru+6pu6fxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKFvubFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKFvubFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DFEC4CEE7;
	Wed, 20 Aug 2025 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755719094;
	bh=Zvb+Vfh+eSxi8V3LzfMzob6KCrLVAFgE71unoyyC+Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKFvubFJvIzab1gqKBT2fd1UkMlrjZrfmL5T3963UqcwOioUazgGebAsKSjyzjPNR
	 fLaN1NsWBtXt47P7MbeboT4AgkaWpDHOBsmk1gw9NeFAHrl/fOF8ZVYxe7hKnpMrYj
	 /HZT2h7WrayxTYLadOXUfgrGnGOqxKFAIEoVwf5WWeDkUqShaMVbw1NoxfdI0zfx3C
	 2p0+RALCB+Wb6hlhFZkt9aZbgc7KlbwYPHrs05fB6oYb+KkDGkb0rXJK8X9mhBXtkx
	 89ktvRM3LGU0YBGAeSLAW1PcsviPE4HcMqCfMe2TMNB63n4Jl9SwWQFjwJRZyupfSK
	 2VLYiKn5UTacA==
Date: Wed, 20 Aug 2025 09:44:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <aKYltdkLBRZJF0Ok@slm.duckdns.org>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820105518.Yf36NzJd@linutronix.de>

Hello,

On Wed, Aug 20, 2025 at 12:55:18PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-20 12:36:59 [+0200], To Tejun Heo wrote:
> > Subject: [PATCH] workqueue: Provide a handshake for canceling BH workers
> …
> > This will flush all BH-work items assigned to that pool.
> 
> We need to flush all items because the inserted wq_barrier is at the
> end of the queue. So if the cb_lock is dropped after
> worker->current_func(work) then we will live lock. Just tested, I
> somehow assumed it polls on worker.

Is flushing all a problem tho? I think the main focus is keeping the
semantics matching on RT, right?

...
> -	if (from_cancel) {
> +	if (from_cancel && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		unsigned long data = *work_data_bits(work);
>  
>  		if (!WARN_ON_ONCE(data & WORK_STRUCT_PWQ) &&
>  		    (data & WORK_OFFQ_BH)) {
> -			/*
> -			 * On RT, prevent a live lock when %current preempted
> -			 * soft interrupt processing or prevents ksoftirqd from
> -			 * running by keeping flipping BH. If the BH work item
> -			 * runs on a different CPU then this has no effect other
> -			 * than doing the BH disable/enable dance for nothing.
> -			 * This is copied from
> -			 * kernel/softirq.c::tasklet_unlock_spin_wait().
> -			 */
>  			while (!try_wait_for_completion(&barr.done)) {
> -				if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> -					local_bh_disable();
> -					local_bh_enable();
> -				} else {
> -					cpu_relax();
> -				}
> +				cpu_relax();

I'm most likely missing something about RT but wouldn't the above still lead
to deadlocks if the caller is non-hardirq but higher priority thread?

Thanks.

-- 
tejun
