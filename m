Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1EF2D23A4
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Sep 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067360; cv=none; b=KvDlcyj3G9W6BsSNtJ3SgyyHjjPbVfc5tChZyomGPngyiolNdnruCaBLijBCp8mNpq1yVtGYn5B/m7TKb4fJNN/NXZr8MoeFuY6X5gRzHV7hrCGdEzt+p+40WO1UUwWz6jAQMug3T+HDo9NPQHgoDTd9L+Kz4DahPvU+3juKIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067360; c=relaxed/simple;
	bh=p/uiPovj10ICfWpo4b/GpUl0eTwbtCjb4Q8Ox6U6FqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjYxtrZR1ObJlGEKvnV4RewimsZU9NAiNQfmfce+a6Q5vSsnp8t3IPPQv4+BB/SaIIGtMTE5mfjpQPPoq3q5yVY3s9jZ9oe6rHrEj7oAk8ec8ShJXn2biTVcEbtpdWxcoUm20ZVKWd+z0EdlY8XrAlKuE6zFGRuLPHovnU2x+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pSZNg6Z5; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pSZNg6Z5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757067350;
	bh=SDv4Poav655Z7AD9iiHWpHJzqs+HAT+cnYy3QViU30I=;
	h=From:Subject:Date:Message-ID;
	b=pSZNg6Z5vnyu2X5ogJP1hTwEYoYgLJCj60BmNPUtiQJvIIsberHbQn8InHTsCXyKR
	 JJLuuHh/RYLmJzay9EJ2pMq2dqlR7gDhbuv5Lq1Z1fBE2F+FHNiABC6WxNJ9emt0rV
	 U61EZwFYT6fXRTzlh4PjjAHJEv6jcUszodVMQjlk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68BAB82D00004AB2; Fri, 5 Sep 2025 18:15:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7022586685263
X-SMAIL-UIID: E3733E30E4614B2A8D06D23F523A1283-20250905-181511-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling tasklets via polling
Date: Fri,  5 Sep 2025 18:15:01 +0800
Message-ID: <20250905101502.6525-1-hdanton@sina.com>
In-Reply-To: <20250904142526.1845999-3-bigeasy@linutronix.de>
References: <20250904142526.1845999-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  4 Sep 2025 16:25:24 +0200 Sebastian Andrzej Siewior wrote:
> The tasklet_unlock_spin_wait() via tasklet_disable_in_atomic() is
> provided for a few legacy tasklet users. The interface is used from
> atomic context (which is either softirq or disabled preemption) on
> non-PREEMPT_RT an relies on spinning until the tasklet callback
> completes.
> On PREEMPT_RT the context is never atomic but the busy polling logic
> remains. It possible that the thread invoking tasklet_unlock_spin_wait()
> has higher priority than the tasklet. If both run on the same CPU the
> the tasklet makes no progress and the thread trying to cancel the
> tasklet will live-lock the system.
> To avoid the lockup tasklet_unlock_spin_wait() uses local_bh_disable()/
> enable() which utilizes the local_lock_t for synchronisation. This lock
> is a central per-CPU BKL and about to be removed.
> 
> Acquire a lock in tasklet_action_common() which is held while the
> tasklet's callback is invoked. This lock will be acquired from
> tasklet_unlock_spin_wait() via tasklet_callback_cancel_wait_running().
> After the tasklet completed tasklet_callback_sync_wait_running() drops
> the lock and acquires it again. In order to avoid unlocking the lock
> even if there is no cancel request, there is a cb_waiters counter which
> is incremented during a cancel request.
> Blocking on the lock will PI-boost the tasklet if needed, ensuring
> progress is made.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/softirq.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 513b1945987cc..4e2c980e7712e 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -805,6 +805,58 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
>  	return false;
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT
> +struct tasklet_sync_callback {
> +	spinlock_t	cb_lock;
> +	atomic_t	cb_waiters;
> +};
> +
> +static DEFINE_PER_CPU(struct tasklet_sync_callback, tasklet_sync_callback) = {
> +	.cb_lock	= __SPIN_LOCK_UNLOCKED(tasklet_sync_callback.cb_lock),
> +	.cb_waiters	= ATOMIC_INIT(0),
> +};
> +
> +static void tasklet_lock_callback(void)
> +{
> +	spin_lock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
> +}
> +
> +static void tasklet_unlock_callback(void)
> +{
> +	spin_unlock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
> +}
> +
> +static void tasklet_callback_cancel_wait_running(void)
> +{
> +	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
> +
> +	atomic_inc(&sync_cb->cb_waiters);
> +	spin_lock(&sync_cb->cb_lock);
> +	atomic_dec(&sync_cb->cb_waiters);
> +	spin_unlock(&sync_cb->cb_lock);
> +}
> +
	CPU0			CPU1
	----			----
	lock A
				tasklet C callback
				lock A
	cancel tasklet B
	DEADLOCK-01

After this work could DEADLOCK-01 be triggered, given no chance for DEADLOCK-02 ?

	CPU2			CPU3
	----			----
	lock A
				timer C callback
				lock A
	timer_delete_sync(timer B)
	DEADLOCK-02

> +static void tasklet_callback_sync_wait_running(void)
> +{
> +	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
> +
> +	if (atomic_read(&sync_cb->cb_waiters)) {
> +		spin_unlock(&sync_cb->cb_lock);
> +		spin_lock(&sync_cb->cb_lock);
> +	}
> +}
> +
> +#else /* !CONFIG_PREEMPT_RT: */
> +
> +static void tasklet_lock_callback(void) { }
> +static void tasklet_unlock_callback(void) { }
> +static void tasklet_callback_sync_wait_running(void) { }
> +
> +#ifdef CONFIG_SMP
> +static void tasklet_callback_cancel_wait_running(void) { }
> +#endif
> +#endif /* !CONFIG_PREEMPT_RT */
> +
>  static void tasklet_action_common(struct tasklet_head *tl_head,
>  				  unsigned int softirq_nr)
>  {
> @@ -816,6 +868,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
>  	tl_head->tail = &tl_head->head;
>  	local_irq_enable();
>  
> +	tasklet_lock_callback();
>  	while (list) {
>  		struct tasklet_struct *t = list;
>  
> @@ -835,6 +888,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
>  					}
>  				}
>  				tasklet_unlock(t);
> +				tasklet_callback_sync_wait_running();
>  				continue;
>  			}
>  			tasklet_unlock(t);
> @@ -847,6 +901,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
>  		__raise_softirq_irqoff(softirq_nr);
>  		local_irq_enable();
>  	}
> +	tasklet_unlock_callback();
>  }
>  
>  static __latent_entropy void tasklet_action(void)
> @@ -897,12 +952,9 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
>  			/*
>  			 * Prevent a live lock when current preempted soft
>  			 * interrupt processing or prevents ksoftirqd from
> -			 * running. If the tasklet runs on a different CPU
> -			 * then this has no effect other than doing the BH
> -			 * disable/enable dance for nothing.
> +			 * running.
>  			 */
> -			local_bh_disable();
> -			local_bh_enable();
> +			tasklet_callback_cancel_wait_running();
>  		} else {
>  			cpu_relax();
>  		}
> -- 
> 2.51.0
