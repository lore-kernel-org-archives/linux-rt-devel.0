Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EC26159E
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451591; cv=none; b=NB6uQdrslS0DnK488TWOybvCH2ZqPTsXZxc7nGObdPIuhxWS5esje86wdw11dKHdyQc6telC2fMjng1GTqOpOndy4nIt+VyAH50G3LEPPwcT9ZaU7kjtN+v5OFe/J5MRE0ZMfVnNLqqWPPbfPe8PSDooYXnwTmPHUPYXFRjbHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451591; c=relaxed/simple;
	bh=6ocj4qEjyVftNEMWwIW93Y/J+R6GHmEzX0oMwJQ6Qf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAkAMz4iCPTpxOgJPl7YU69c+LXMjHSqj3UF3DGFQH8BNO56EFU0NqEJqTlE5TsHWOzdV4kIZT1VXTREf0rFTG2eoPTNeX0iiG9pcm9gpba59w8Ttt6o7pl1WNgrnD/F/UBzofX7jz9w2LPguXWWQLRc36TothFIvDEJ0jMH+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id BB79414099B;
	Wed, 25 Mar 2026 15:13:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id DE04360010;
	Wed, 25 Mar 2026 15:13:06 +0000 (UTC)
Date: Wed, 25 Mar 2026 11:13:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-rt-devel@lists.linux.dev, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325111351.1d38a0bc@gandalf.local.home>
In-Reply-To: <20260325030508.321405-1-jiayuan.chen@linux.dev>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wm9a3d4puf4cauzfo3ktwzccdbq6wxxi
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: DE04360010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ruENu1kZbjFjRh1/ZsxutJxp3lqEkmjw=
X-HE-Tag: 1774451586-184770
X-HE-Meta: U2FsdGVkX1/OqLxdTskqU0lmT8YhY7u8RwSi+q8YFg6102mIx2ygcqdwcUIUnOtAMAu0oNRgl0S9KWy3EqbBwq/6D2bUCbLqcxpCz57LmDzFtp0eDY+JqHbSTfmtsUTQDTfwkrBm7RitvYEHh0j+ZQym1hTwYMPaiqyT1yk8i7rGfLgb99UejtTciuSJMhXx+HFKOBfvNfsGoN6Alnvd5kTXtdU40XYHEIcPGgVLAGrsEclHSrf+pr2mq6awcej4ZxGYcKSG0Om24px8YffKWEmytWpwqSBEXu4VzZsIJDsz7tOl5husTkVIMfv6ZcQB

On Wed, 25 Mar 2026 11:05:04 +0800
Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

Hi Jiayuan,

Adding "v1" to your first patch doesn't show much confidence in the code.
As it implies there will definitely be a v2. It's kind of like introducing
your spouse as, "Hi, this is my first wife". ;-)

> On PREEMPT_RT, non-HARD irq_work runs in a per-CPU kthread, so
> irq_work_sync() uses rcuwait (sleeping) to wait for BUSY==0.
> 
> After irq_work_single() clears BUSY via atomic_cmpxchg(), an
> irq_work_sync() caller on another CPU that enters *after* BUSY is
> cleared can observe BUSY==0 immediately (without sleeping), return,
> and free the work. Meanwhile irq_work_single() still dereferences
> @work for irq_work_is_hard() and rcuwait_wake_up(), causing a
> use-after-free.
> 
> Note: if a sync waiter is actually sleeping, @work is still alive
> (it can't be freed until the waiter returns), so there is no UAF in
> that case. The UAF only occurs when sync checks BUSY==0 without
> going through schedule().
> 
> Fix this by extracting and pinning the irq_work_sync waiter's
> task_struct (if any) while BUSY is still set and @work is guaranteed
> alive. After clearing BUSY, wake the pinned task directly without
> touching @work.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/irq_work.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 73f7e1fd4ab4..b10b75d1cc09 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -200,6 +200,7 @@ bool irq_work_needs_cpu(void)
>  
>  void irq_work_single(void *arg)
>  {
> +	struct task_struct *waiter = NULL;
>  	struct irq_work *work = arg;
>  	int flags;
>  
> @@ -221,15 +222,37 @@ void irq_work_single(void *arg)
>  	work->func(work);
>  	lockdep_irq_work_exit(flags);
>  
> +	/*
> +	 * Extract and pin the irq_work_sync() waiter before clearing
> +	 * BUSY. Once BUSY is cleared, @work may be freed immediately
> +	 * by a sync caller that observes BUSY==0 without sleeping, so
> +	 * @work must not be dereferenced after the cmpxchg below.
> +	 */
> +	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
> +	    !arch_irq_work_has_interrupt()) {

Unrelated to this patch, but the above if conditional should be defined as
a macro as it is used in more than one place, and they do need to match.

Maybe something like:

#define is_irq_work_threaded(work)  ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) || \
				     !arch_irq_work_has_interrupt())

But again, that isn't related to this patch.

> +		rcu_read_lock();
> +		waiter = rcu_dereference(work->irqwait.task);

Hmm, is it proper to access the internals of an rcuwait type?

Paul, is there a more proper way to do this?

> +		if (waiter)
> +			get_task_struct(waiter);
> +		rcu_read_unlock();
> +	}
> +
>  	/*
>  	 * Clear the BUSY bit, if set, and return to the free state if no-one
>  	 * else claimed it meanwhile.
>  	 */
>  	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
>  
> -	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
> -	    !arch_irq_work_has_interrupt())
> -		rcuwait_wake_up(&work->irqwait);
> +	/*
> +	 * @work must not be dereferenced past this point. Wake the
> +	 * pinned waiter if one was sleeping; if none was sleeping,
> +	 * either irq_work_sync() has not been called or it will
> +	 * observe BUSY==0 on its own.
> +	 */
> +	if (waiter) {
> +		wake_up_process(waiter);

Yeah, this is open coding the rcuwait_wake_up().

I'm not sure we want to do this.

Perhaps RCU could provide a way to save the rcuwait?

	struct rcuwait = __RCUWAIT_INITIALIZER(rcuwait);

	[..]

		rcuwait_copy(&rcuwait, &work->irqwait);

	[..]

		rcuwait_wake_up(&rcuwait);

?

> +		put_task_struct(waiter);
> +	}

-- Steve

>  }
>  
>  static void irq_work_run_list(struct llist_head *list)

