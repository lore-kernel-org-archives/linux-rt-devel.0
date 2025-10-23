Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D3328613
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Oct 2025 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227602; cv=none; b=fCp+kyklXu6pWjcDABFr8944pe++MlF925nZsK50h/c2CwR4HR3Saa5Uhrqb8c7Ti6JlI+WjjF6UBJiZsL8PE5Z6f26Sd8vFodJT34YlO4gGgYOKECVHO2bDwbkTSi+v7RfJGDcYeJ4GSAiU68p8aiRRzIejtRwsEYlILv3yR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227602; c=relaxed/simple;
	bh=On/yckDKKiF+EFR0uGo6hOHdxgssUvTV3nxiyNhHf6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6YTXsuUxIoBGjulvSTvTljH8CS3plsf3q5qOJBARb28X6RAWggltRX87aYm338CV1GyJekQfm3cFPDL+cCLxZOVKIRaU5eZUzpwMyTGBXj0jKBdoBl3BxinIgvpFMnfjszWwWMBr+hTtUHoxkfbITuR99KpUcQIPSqxHFPAGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXp9T6fl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rtm0eFfB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXp9T6fl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rtm0eFfB"
Date: Thu, 23 Oct 2025 15:53:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761227598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRAusrPVOYEO1ClBZpA951BRZx8PMSxnPOWyXbmsS2E=;
	b=iXp9T6flSOXELfe2ZZmzybkkOsRgW86acJCjsGBfuSsoTAEoq+xTDvejqlumN9ShUkMc7V
	Z8eFTaJ140miuAXk3a1PSNMPjcvjJ1vZEy2KvInzmSAga99abMpLjijh3FatjgnNWR5vw0
	HvsM3etXucLUkGXNdrUSNbSyXl+tc1gwiZ+MAdTBdelb/RNzow+HuBdy7RqNnXGkh8LcTh
	kBRCLArholLTNTbN/946PLdR3E38pMh7AHclKXA5/2IWXGWzfjlDpA4ZWTZJx//p5w2+a0
	Hk8Z0geA2qxncQ44dznCTwt1qGdG+QREUObdhcoGJkUFOoZMa1Hx8LaFkNzQrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761227598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRAusrPVOYEO1ClBZpA951BRZx8PMSxnPOWyXbmsS2E=;
	b=Rtm0eFfB7vhEQc95RDb5MKDHkjj+Q9GSpZkpN28XEY4x8FrQKx4qKITMtBf83IkQsI8yF7
	sktYxRcEY4qI5nBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: usage of DEFINE_WAIT_OVERRIDE_MAP(LD_WAIT_SLEEP)
Message-ID: <20251023135316.1ZRx0UU5@linutronix.de>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020145310.GA9608@redhat.com>

On 2025-10-20 16:53:10 [+0200], Oleg Nesterov wrote:
> Hi Sebastian,
Hi,

> > You are correct Oleg. I've been just verifying it and yes: LD_WAIT_SLEEP
> > suppresses also mutex while the intention is to only suppress
> > spinlock_t.
> > We have four users in tree, based on quick check all four should use
> > CONFIG, three of them do use SLEEP.
> 
> No ;)
> 
> I was going to send the patch which does s/SLEEP/CONFIG/, but this
> would be wrong. printk_legacy_map can use LD_WAIT_CONFIG, but lets
> look at debug_objects_fill_pool()
> 
> 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> 		/*
> 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
> 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
> 		 * the preemptible() condition above.
> 		 */
> 		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
> 		lock_map_acquire_try(&fill_pool_map);
> 		fill_pool();
> 		lock_map_release(&fill_pool_map);
> 	}
> 
> If CONFIG_PREEMPT_RT=y and preemptible() is true, LD_WAIT_CONFIG won't work.
> lockdep will complain if fill_pool() takes a spinlock_t, spinlock is
> LD_WAIT_SLEEP on RT.

Where is this? This is then wrong then because _SLEEP is for MUTEX and
those things that sleep-sleep and pretend to sleep.

spinlock_t should be LD_WAIT_CONFIG. This is used in
include/linux/spinlock_types.h via SPIN_DEP_MAP_INIT which is only
defined once as LD_WAIT_CONFIG.

rt_mutex is defined as LD_WAIT_SLEEP but this one is not the one we use
for spinlock_t.

What you want to have working in the end is the following scenario:

|static DEFINE_SPINLOCK(lock_spinlock);
|static DEFINE_RAW_SPINLOCK(lock_raw_spinlock);
|static DEFINE_RAW_SPINLOCK(lock_raw_spinlock2);
|
|static void lockdep_test(void)
|{
|        static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_CONFIG);
|
|        raw_spin_lock(&lock_raw_spinlock);
|        lock_map_acquire_try(&put_task_map);
|
|        spin_lock(&lock_spinlock);
|        spin_unlock(&lock_spinlock);
|
|        raw_spin_lock(&lock_raw_spinlock2);
|        raw_spin_unlock(&lock_raw_spinlock2);
|
|        lock_map_release(&put_task_map);
|        raw_spin_unlock(&lock_raw_spinlock);
|}

This will work. On RT as well but is wrong and will not happen due to
the preemptible() check. On !RT it will so you want lockdep to be quiet.

> 
> Oleg.

Sebastian
