Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9D1CBEAA;
	Wed, 12 Feb 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371752; cv=none; b=XoVFtHSfK5N3YY0adf1CpDaOW74J28/PaM3NiXt00RTCa0G5/0C0jcrDH8mL52KwKz9iUNd/SJJN4Ox3AZ5dSgTFsyzLExZnrmEbTtVigDHwkpI7NLSeO1UYefFFOEKZmRNQR2J+IH72PXTVByXd3VYFvwO+YrLwdXqFzA9U54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371752; c=relaxed/simple;
	bh=1SeO8cxzH0/mw6NOXalw/fJw/wCSMCqyfPlFj00AO68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gondszwyXG6hhzSiao5ZPD3uJ9NI3QGF2InjZvcaXIhjpBMq729VdXV3ni71o4rPsDh0hpt5IcQ6+sAa1Fe9a5mJze5eCkxgJ2NFy7EIHLmHBgaZK4enrv7ojUngjo8kHf6WgC18qfiobi8xoJtVmyw0d4DLItSiBjmvAd1g+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2481C4CEDF;
	Wed, 12 Feb 2025 14:49:10 +0000 (UTC)
Date: Wed, 12 Feb 2025 09:49:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long
 <longman@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Clark Williams
 <clrkwllms@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: Don't disable interrupts on RT in
 disable_irq_nosync_lockdep.*()
Message-ID: <20250212094917.1ca8cc13@gandalf.local.home>
In-Reply-To: <20250212103619.2560503-2-bigeasy@linutronix.de>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
	<20250212103619.2560503-1-bigeasy@linutronix.de>
	<20250212103619.2560503-2-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 11:36:18 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
> avoid false positive reports by lockdep that a certain lock has not been
> acquired with disabled interrupts. The user of this macros expects that
> a lock can be acquried without disabling interrupts because the IRQ line
> triggering the interrupt is disabled.
> 
> This triggers a warning on PREEMPT_RT because after
> disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
> with disabled interrupts.
> 
> On PREEMPT_RT there is no difference between spin_lock() and
> spin_lock_irq() so avoiding disabling interrupts in this case works for
> the two remaining callers as of today.
> 
> Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net
> Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/interrupt.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 8cd9327e4e78d..a1b1be9bf73b2 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -448,7 +448,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
>  static inline void disable_irq_nosync_lockdep(unsigned int irq)
>  {
>  	disable_irq_nosync(irq);
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)

Hmm, should you also add a:

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

?

  https://lore.kernel.org/all/20250211182113.4875751a@gandalf.local.home/

    ;-)

-- Steve

>  	local_irq_disable();
>  #endif
>  }
