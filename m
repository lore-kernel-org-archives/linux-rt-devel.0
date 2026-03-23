Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F733985
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Mar 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272639; cv=none; b=gvyGfgEa64pddBrdwWcQsaRqzgpXgjFdup2puaihwhbYNkCU2CtTKAzlPBVWFzlhh+Gl2UDboJFbUcA/3neZZjivrsc9c7W3T/S0Thf3L7VgOHXQPwHpy49HCmY50OX34JPQIas9vc3rZH2HjjVLKQDoyuHUS1S2k00exQnlehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272639; c=relaxed/simple;
	bh=YOmfas63cIdBUKih8oE3fEQQyZfDIiSaNi9u/dLePCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5/syJDpUrt/0WEZyv5G0/3CQ3d3yRt3iBz5wxLLzarf7qZptP0wy7383xatuWKRNCqSFvaqdVbny3OCtREA3FQDc3zFxPRhzhL8zKp/TbQwb15ggNuecfAMUKXm27+l8kXdaV2HW4cNsIJEz0H/aYcnA84crKg5hoKUCE6YrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K35mt9/3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9PEDnX6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K35mt9/3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9PEDnX6"
Date: Mon, 23 Mar 2026 14:30:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774272636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/7T/+FODdt0sHTm9mc8jUUHpYNbf/RL2y5Eo/BAbqEc=;
	b=K35mt9/3i22ePKjrldc2iqt2N3Q/z5SSjuiZMPao+Dig9k+7XiASpBiRlkuwb+zl+n5Rfp
	DE59KBZ31GaZaTonkxkHwaAPBQzeuoi3csw4v78176k3G2/k15WOo4o9vIP3jLXp9nMBG1
	/fuiulY5mgKao6WVF0xt3ZjyPrqw/Vr6FGyj5HT5VWW2A/CrkK+0RHisjdDyMggOvPZ7/Z
	9+wWUTXaJ/fAbdvxehLRYQdyLHFkpgyqdRoDTRbks1nl1xos9WeYWrJQdoAb9FguWNY4SP
	6STZPrlmSGS94xPV/eNlugZLaNcSdgFqCKzbAQeOJTBT9DpKauyP8CyEfOHA9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774272636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/7T/+FODdt0sHTm9mc8jUUHpYNbf/RL2y5Eo/BAbqEc=;
	b=r9PEDnX6+ExR4LfxT65aWGTHsWyOvnc/FWEv9gDE++5a4t03NN1snfF82R+OF2xqsHDHEE
	R0j1L3J8X16RY3DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Moritz KLAMMLER (FERCHAU)" <Moritz.Klammler@ferchau.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Message-ID: <20260323133034.vk87xPj9@linutronix.de>
References: <VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com>

On 2026-03-20 19:23:01 [+0000], Moritz KLAMMLER (FERCHAU) wrote:
> Hello,
Hi,

> we're running Linux 6.6 with PREEMPT_RT on a single-core armv7l machine
v6.6.109+?

> and observed our devices getting locked-up every few days.  We're using
> RT/PI condition variables from librtpi [1] and determined that the RT
> (SCHED_FIFO) thread making the FUTEX_CMP_REQUEUE_PI syscall from within
> pi_cond_broadcast seems to occasionally live-lock inside the kernel.
> 
> Thanks to a possibly less than ideal design decision in our system, the
> "producer" thread calling pi_cond_broadcast (i.e. doing the
> FUTEX_CMP_REQUEUE_PI) has a higher priority than the "consumer" threads
> that are waiting on the condition variable (calling pi_cond_timedwait
> which eventually makes a FUTEX_WAIT_REQUEUE_PI call).  While this might
> not be ideal, I suppose that it still ought to be allowed; please
> correct me if I should be mistaken on that point.

Not sure why not. Worst case would be that the producer would snap all
locks and see no waiter because the consumer never managed to enqueue.
 
> What seems to happen next is that when the waiter exceeds its finite
> timeout [2] and half an eye-blink later, the producer thread decides to
The alternative to timeout is signal.

> call FUTEX_CMP_REQUEUE_PI after all, the lower-priority consumer might
> make it to the point where it sets the requeue state to
> Q_REQUEUE_PI_DONE in futex_requeue_pi_wakeup_sync but then gets
> preempted before it has a chance to remove itself from the waiters list.
> Now, the higher-priority producer thread calls futex_requeue_pi_prepare
> which will return false because it sees the Q_REQUEUE_PI_IGNORE.

> Subsequently, futex_proxy_trylock_atomic will fail with -EAGAIN and

So the syscall, that saw Q_REQUEUE_PI_IGNORE, returned and now a second
requeue-PI is attempted?

> futex_requeue "goto retry".  Which effectively results in the
> higher-priority RT thread busy-waiting on the lower-priority thread
> forever.  It will call cond_resched before the "goto retry" but since it
> is considered the most important task in the system, it doesn't seem to
> be scheduled away anymore.

Yup. Kind of obvious if you put it like this.
What about

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 7e43839ca7b05..ce02cc715c98d 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -307,8 +307,11 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 		return -EINVAL;
 
 	/* Ensure that this does not race against an early wakeup */
-	if (!futex_requeue_pi_prepare(top_waiter, NULL))
+	if (!futex_requeue_pi_prepare(top_waiter, NULL)) {
+		plist_del(&top_waiter->list, &hb1->chain);
+		futex_hb_waiters_dec(hb1);
 		return -EAGAIN;
+	}
 
 	/*
 	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
@@ -709,8 +712,10 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
 	 * We were woken prior to requeue by a timeout or a signal.
 	 * Unqueue the futex_q and determine which it was.
 	 */
-	plist_del(&q->list, &hb->chain);
-	futex_hb_waiters_dec(hb);
+	if (!plist_node_empty(&q->list)) {
+		plist_del(&q->list, &hb->chain);
+		futex_hb_waiters_dec(hb);
+	}
 
 	/* Handle spurious wakeups gracefully */
 	ret = -EWOULDBLOCK;


? It compiles and might work.

Sebastian
