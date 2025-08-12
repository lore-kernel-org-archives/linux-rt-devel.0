Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19192ECE8F
	for <linux-rt-devel@lists.linux.dev>; Tue, 12 Aug 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010444; cv=none; b=FvK9W2oM1b6D5YO6xEWct//+136rpdlt4llywrhtuxPvTdU6V0Rm3lZU6gsZa7JOEC9+QXTj6oFXmll1H65L7Y7XM8ivkryjXTz+o3mCeXfMsC+KKCSRkrvyz7II0nWmI4lABlpGs59YrAfeAductdFqklxHFQVklkklCVsr464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010444; c=relaxed/simple;
	bh=fy0XHvCZs/XNFtBtEjnrZKQjlqp0c9f8kE5QViMyQz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIkhsgeovfUx/Gj3R/+S269yddPo0ESOtQxoZwHqoHkuYYMzGevl/A0D4BbOgqeBCBvI3FpmQiuQDQb5hjATA8xZ1mtRKdopGv9dH2ZcgiUuk2JGB7Mq3nzRKysgyp6J7luxjTfb0ObnK5EaJK+vrBewQajH2Qu6x6sjcEwg6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wo3ULoeo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=198D86nl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wo3ULoeo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="198D86nl"
Date: Tue, 12 Aug 2025 16:53:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755010441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEO0a0GGfeWYMpYSeodTHZZUAF2zF1OonsfItXVLzJ4=;
	b=Wo3ULoeo4cuCjEkDcapvrZKRKQb68LHJZCyg4k9cOSCEkZOV8wKifY8Ku9B7XH1bLyN4zf
	GMNbFc4Fvkm1lV4DzQ1ekJnB/28+PQBuOjfjSC2afmbf3uhb+d6STtuAf6sPXx7jaTMUU5
	Z5bg9Cb+juY/S7ArXwG71E/wmqBSHkNWAH/CpQUO5zEiuQJI4OO4sahB3nL/3iYXXo6199
	k6PJo/ISH1fZo9iUZ9OeajSSd6NTGh8PTZY+hUzNdV3ei45NzB+7HWzKqV59/azHjRgGrY
	PyhfGMacKLBm1zipZibnxbv8ieIWzmnl0oLCM8n3p+xRTxPJdbGQo+k8lytwlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755010441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEO0a0GGfeWYMpYSeodTHZZUAF2zF1OonsfItXVLzJ4=;
	b=198D86nlbgMCKpyTlXm6iqSklnq+OJH6EMmn78DI+vBlTQ8ET9UFCqUjB8OVJaLJ2/B6xB
	+ShsZxdcZCgpB3AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250812145359.QMcaYh9g@linutronix.de>
References: <20250812143930.22RBn5BW@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812143930.22RBn5BW@linutronix.de>

On 2025-08-12 16:39:32 [+0200], To linux-kernel@vger.kernel.org wrote:
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

Tejun, Lai, I noticed that the BH part of workqueue also relies on this
mechanism (__flush_work(), the PREEMPT_RT ifdef).
This is a fairly recent API so there should be no "legacy" users as we
have it the tasklet interface. The majority of users use tasklet_kill()
(or seldom tasklet_unlock_wait()) and not tasklet_unlock_spin_wait().
The plan was to get rid of the spinning API but I didn't manage to get
rid of all users especially since some of the code could not be sanely/
safely converted (+tested).

Does the workqueue-BH code require the canceling from atomic context or
was this just added because the API for BH and non-BH work items is the
same and __cancel_work_sync() allows it?
Could we avoid the busy-waiting for BH work items and rely on the
wait_for_completion() below or do we need something similar to what I
added here for the tasklet API?

Sebastian
