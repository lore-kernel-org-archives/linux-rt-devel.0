Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD634EEF3
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250390; cv=none; b=HTYzqFqaJiSjq0M6rXpPqVvoqfs58krOhd4fUZfJsoTvWN8fm/Z2tUs4CnwRnFrNjiUsbAJ0TB1PMkb8fLOjdsQhrJACuc0Cq1HZMY8MfNqV2C6WE+/ozSWpVZNZBHR/dTCx7X6Lbf1qAe/CjEckhBIHE94A5WpzpfXbMHLD8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250390; c=relaxed/simple;
	bh=jjCz2TabJi+/x1vQtOC46X250QApM+BcOxzlUrO7iVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcalAjnOtKXS8WBGnVzbEYCFUHqL8LmmA7DWvA8l4a7IFAKptHEZ+RpyzIZSOWQhBXf+0BsDCtxb/Jt7ENiSS63nVt891M+3R85T5n+7j3daw1r4egpaNIVaS6D0+zwaqE1QWFvYB18AKxOiwzngFEgfW5+w9MLwcpcrsrYKzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0tsUEKu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0I1YAUbI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0tsUEKu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0I1YAUbI"
Date: Sat, 17 Oct 2026 17:19:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792250386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yKd0bhU2GOaJ2Qi+7hd8qIJi8QNf15TA8ob+y0du4=;
	b=U0tsUEKur58lNDFFhdaMHXF8gXUUjQKh2nKXQWYiAg0DvysDDtO5hE0VreHctIThGICFqP
	UWt5DpfvL4ZKKFmBy1KyTLEPQcok4nDKx9tonFh+p0GSgGAcQRAJF24tC/pF7jACcw6i4W
	XiNgW3e8gk3iDGrgCNxl4Avhw2/jtRfsP7ttsZZ07oilv8+LotgL4xp2Nu8DHEMcH6sQhM
	V0wnStiBmvsGfjWDOJvZFsTKLGfUIRH4LDH8G2mHRHdZbbik6c0Wo+JYLeQmuJikbzKZuJ
	x2lJJEJGq+r6FYuza8LGTqusXpkkjBlYy7EUJ45uQNRyawpVJ54VE6D3WXu9Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792250386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yKd0bhU2GOaJ2Qi+7hd8qIJi8QNf15TA8ob+y0du4=;
	b=0I1YAUbI65DA+mfFwc56AsSwnFNgGa9Qkv2VEM2U8ZevIxPg/PmHCMRknq8Djcp0LmXrbb
	T/3S6T+zQR+tfUBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Austin Schuh <austin.linux@gmail.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, clrkwllms@kernel.org,
	rostedt@goodmis.org, tglx@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io_uring/wait: wake real-time waiters from hard
 interrupt context
Message-ID: <20261017151945.q-LijyqZ@linutronix.de>
References: <20261017013303.3919170-1-austin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261017013303.3919170-1-austin.linux@gmail.com>

On 2026-10-16 18:33:03 [-0700], Austin Schuh wrote:
> --- a/io_uring/wait.c
> +++ b/io_uring/wait.c
> @@ -120,23 +121,39 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
>  	return io_cqring_timer_wakeup(timer);
>  }
>  
> +/*
> + * On PREEMPT_RT, hrtimers not marked for hard interrupt expiry expire in the
> + * ktimers thread, at the lowest real-time priority, so a real-time waiter
> + * isn't woken until every runnable real-time task on its CPU has blocked.
> + * Like hrtimer sleepers (see __hrtimer_setup_sleeper()), expire the timer in
> + * hard interrupt context if the waiter is a real-time task. Both callbacks
> + * only look at the ring and wake the task, which is safe there.

Please simply refer to __hrtimer_setup_sleeper() for the policy.

> + */
> +static enum hrtimer_mode io_cqring_timer_mode(void)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && rt_or_dl_task_policy(current))
> +		return HRTIMER_MODE_ABS_HARD;
> +	return HRTIMER_MODE_ABS;
> +}

Sebastian
