Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D80F26FDB2
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Oct 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247438; cv=none; b=rwMcu7PJ0FaMw99783ESdBY/aFaTlRiPZctU/BHwjsWP+53u4LRh/QydBTKDQhv7DLpILDlXjnUK6ICZ7LBWFaFSgiWDHCqabOT/j5yGNv/ipdDDjuzVikHuN6QN/Zr0WXtdodwmepcD7DvX/loEoVCYrsf1VGpUJ1IACV1V/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247438; c=relaxed/simple;
	bh=dyJm5kfT+wwoAXrFOv1gzXzfXi6fTeq4CMgppAJ+OhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax8PvHKLGF/wzoTs7vR+CT43FExI/5RezarH+rMLBlqro8oP/GB0WolyFRnCCHSuxHOuWE/v5ueXTRGK+5lEggzN4nzt08pvtE3bCqQ39AURQ1tmsnV6Vm6E0TAaIWEtJEhcGoV1FSOS3JBt+5Oxsbgkjj8Npj7Lv1PjcL7fCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BeQGsgjY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/gBCSeI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BeQGsgjY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/gBCSeI"
Date: Thu, 23 Oct 2025 21:23:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761247434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ogCKyf+ZhAJJt4mNbS3YCVOVR0Q9eZHL6eEX+BzXhU=;
	b=BeQGsgjYWkHrqj61jTAtbdLkEkbM+BrPGF0fak3f6Nl7kwgutaNbZdZI0jEZQlrtL2kmWV
	WZ9h/S6kvquom8JHnBsL+fBYXy70DtqieGcJB32RiLgvlSS1WZWJ0r0LeZtgPEEd/y/UKu
	iD5m+qsy/c+3biYKXrIJRD1PaQ+rDadhWDWqS8ixGERuFkmVLywROrgHCJTjLT3oJLNCnw
	U6EH9MnFBqyWpdT/PNDtyXJRSboAlYTPevXZaDk+uIoI/v7FMbczxzRzESXGgrG3h9lfSU
	xnFrd1x+CBMCipSd07+98oDVApltPbObyM+8ceG/fSbvTFy6hgmUAyc4acRNkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761247434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ogCKyf+ZhAJJt4mNbS3YCVOVR0Q9eZHL6eEX+BzXhU=;
	b=m/gBCSeIxN6gk9DMIZ21dwkb3pz8ZXcoe2RRMqk6rf5DA8e+oC3uTtxz9QX4L3O5MYIiMo
	MXTGyLm05jG1pCDg==
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
Message-ID: <20251023192353.Wkng87fi@linutronix.de>
References: <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
 <20251023152942.GC26461@redhat.com>
 <20251023153750.C6EU9NL6@linutronix.de>
 <20251023155339.GE26461@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023155339.GE26461@redhat.com>

On 2025-10-23 17:53:40 [+0200], Oleg Nesterov wrote:
> Sebastian,
Hi Oleg,

> sorry. I guess this is my fault, but I can't understand your reply...
> Could you spell please?

So you refer to this:
| /* PREEMPT_RT kernels map spinlock to rt_mutex */
| #include <linux/rtmutex.h>
| 
| typedef struct spinlock {
| 	struct rt_mutex_base	lock;
| #ifdef CONFIG_DEBUG_LOCK_ALLOC
| 	struct lockdep_map	dep_map;
| #endif
| } spinlock_t;

spinlock_t on PREEMPT_RT does not use (struct) rt_mutex as the comment
claims. It uses just the basic building block which is "struct
rt_mutex_base". This requires linux/rtmutex.h. 

spinlock_t on PREEMPT_RT uses LD_WAIT_CONFIG via SPIN_DEP_MAP_INIT as
!PREEMPT_RT. Nothing changes here.

struct rt_mutex on the other hand uses LD_WAIT_SLEEP and this one is
like struct mutex but with PI.

Sebastian
