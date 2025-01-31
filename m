Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411031A8419;
	Fri, 31 Jan 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349553; cv=none; b=D5BaFoMDJKYiUT765AhaoqsIdOgKzo9hjssJdbQqKQJscNYm5QGNFIQQdqy0NlcJy6FHpYzYjpiKGKow/7lrvIucVy6VeypVZ4EjEVqBniOfNlV22bkW9Tnlg4XUdDIFXrBOivR7tB5qP9hcVMxr2X8uN8iJ+IpBWHZZweQ45C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349553; c=relaxed/simple;
	bh=s+wpQoOyI92VhWLuokk7zdNI55QPdHLYueG28IcaY48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbo+iqGmDWHUEasA4FwMZWMYnw/DUq8yQPo0iXc1POhY9FCL8uM4qZHZRv2Bbn4mzkclrTL9KZDxL+leEnNdLhU2C9ya8dzsiHQ+ct75mD9CzkYxWoO1c25ZkaxnldeDevsrql3NJ2f5chUi+ycOT97rMUCwEqEE3BQvIKHxB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK9IhEJO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK9IhEJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC4CC4CED1;
	Fri, 31 Jan 2025 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738349552;
	bh=s+wpQoOyI92VhWLuokk7zdNI55QPdHLYueG28IcaY48=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VK9IhEJOGTOYm2N7oSOLAD1vKNJxsbtqfIMq226CUMLqW0aIsQtaFv83gKF4vWKLH
	 xcBImQ4NAH4Uu1JehEmROxqG5C5XF54unKoR8N1rdRtYU8z/3Svkua07y+XDXOpOXh
	 X53VdN/WvzF+SIJGeO+b35WJlNH/3zLjNTAxKpyQO+A1ril+eR+cLAKsOzWOhhP1Ei
	 0qWx5nzouEjaJ/Pq5S6RI9byQ7z3GPKzQPMphDCv3qj64/hmvgwSRq9/9abaFGVGxK
	 aAx7s7d681osPF57m+yMDEtE9l/5M7HZcLdimPAgrFFwkP/yKQJpPZOT5HswwgirnW
	 NTPxVqLr3JMug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 37900CE3805; Fri, 31 Jan 2025 10:52:32 -0800 (PST)
Date: Fri, 31 Jan 2025 10:52:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 2/2] clocksource: Use migrate_disable() to avoid
 calling get_random_u32() in atomic context
Message-ID: <a747efb7-2b1a-4570-b379-d8a3bce606a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250131173323.891943-1-longman@redhat.com>
 <20250131173323.891943-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131173323.891943-2-longman@redhat.com>

On Fri, Jan 31, 2025 at 12:33:23PM -0500, Waiman Long wrote:
> The following bug report happened with a PREEMPT_RT kernel.
> 
> [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
> [   30.962673] preempt_count: 1, expected: 0
> [   30.962676] RCU nest depth: 0, expected: 0
> 
> It is due to the fact that clocksource_verify_choose_cpus() is invoked
> with preemption disabled.  This function invokes get_random_u32()
> to obtain random numbers for choosing CPUs.  The batched_entropy_32
> local lock and/or the base_crng.lock spinlock in driver/char/random.c
> will be acquired during the call. In PREEMPT_RT kernel, they are both
> sleeping locks and so cannot be acquired in atomic context.
> 
> Fix this problem by using migrate_disable() to allow
> smp_processor_id() to be reliably used without introducing atomic
> context. The preempt_disable() function is then called after
> clocksource_verify_choose_cpus() but before the clocksource measurement
> is being run to avoid introducing unexpected latency.
> 
> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/time/clocksource.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 77d9566d3aa6..2a7802ec480c 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -373,10 +373,10 @@ void clocksource_verify_percpu(struct clocksource *cs)
>  	cpumask_clear(&cpus_ahead);
>  	cpumask_clear(&cpus_behind);
>  	cpus_read_lock();
> -	preempt_disable();
> +	migrate_disable();
>  	clocksource_verify_choose_cpus();
>  	if (cpumask_empty(&cpus_chosen)) {
> -		preempt_enable();
> +		migrate_enable();
>  		cpus_read_unlock();
>  		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
>  		return;
> @@ -384,6 +384,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
>  	testcpu = smp_processor_id();
>  	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
>  		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
> +	preempt_disable();
>  	for_each_cpu(cpu, &cpus_chosen) {
>  		if (cpu == testcpu)
>  			continue;
> @@ -403,6 +404,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
>  			cs_nsec_min = cs_nsec;
>  	}
>  	preempt_enable();
> +	migrate_enable();
>  	cpus_read_unlock();
>  	if (!cpumask_empty(&cpus_ahead))
>  		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
> -- 
> 2.48.1
> 
