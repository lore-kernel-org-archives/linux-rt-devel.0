Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE5130A54;
	Thu, 10 Apr 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271472; cv=none; b=c4Lkx5X338p/A1OPZQkAcvfqkLwaDBs5uKK8B06S7/IlCqyAe55QtFV1yzuW5fcBUwZq1LRYXOADUJRurMIIV0RpVOsJWB4ZJJn41R249JkleOlecKf8+1f+0PZ3X6uY+o8/wCxd3xn1meJSpIS02717fDok2+8Uk8PdghFwP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271472; c=relaxed/simple;
	bh=nqHGPSBLFMVb6zNIkLbW8Xh/UDnLsFSAe+ttgFjEpaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeusoM37fc9xyiNA90E+89pYK+R/K3ZoPrSmXRi/vTOQlVMGvXuacGUyWEZG3Fnmmiy/MPlqiLYqyEqXmZNJh6S2b+UUpAbEbOu0Y1kAGxAjFrK3D527GmRHf0zeQSiv3MtEdyB32wkbyS5/xkWIbf7zrGyajgVq9ngHvvuXAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Eu2GP9bM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eu2GP9bM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ul3fRUTDaWphipRh/Y+75H+crUiNwI6dx/AJfmaauK8=; b=Eu2GP9bMK9NyhOXvBYCrb+2TTI
	i8Any0NXMAwKiZzfvCm7tqTsvDyGzzEpgptjIpK9hNSkAog8qWCvR1Y+KzzR6tmYAJLtUhojIHEfv
	VrTm1nIAm/V2Kle+QVSkUMqV43WPSM4aai0OJcEoWnQNqvH490GiOaocK9FIAQjx02v5xLm5MYeKV
	/bvoAJrVDIxUgR2Y3ZMyw1fTcGsXTz1FcmlIu7IlCztDBTRT38C4YecWKnb1AEyEn2YlgQB9zLulj
	zDzzBgvwd6s41QORA2Y8Osfi1AGoGq1JmkwW1M+HEmnHSDWhIC1ZSRoqfDuihQQNrFPUKT4MDs/xZ
	4JckaQoA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2mgh-00000008m8q-3YM4;
	Thu, 10 Apr 2025 07:51:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1BA183003C4; Thu, 10 Apr 2025 09:51:03 +0200 (CEST)
Date: Thu, 10 Apr 2025 09:51:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, lclaudio00@gmail.com,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250410075103.GV9833@noisy.programming.kicks-ass.net>
References: <Z_bDWN2pAnijPAMR@uudg.org>
 <20250410064844.wm4KbunL@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410064844.wm4KbunL@linutronix.de>

On Thu, Apr 10, 2025 at 08:48:44AM +0200, Sebastian Andrzej Siewior wrote:
> + sched folks.
> 
> On 2025-04-09 15:58:32 [-0300], Luis Claudio R. Goncalves wrote:
> > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> > with a mutex enqueued. That could lead to this sequence:
> > 
> > 	rt_mutex_adjust_prio_chain()
> > 	  put_task_struct()
> > 	    __put_task_struct()
> > 	      sched_ext_free()
> > 	        spin_lock_irqsave()
> > 	          rtlock_lock() --->  TRIGGERS
> > 	                              lockdep_assert(!current->pi_blocked_on);
> > 
> > Adjust the check in put_task_struct() to also consider pi_blocked_on before
> > calling __put_task_struct(), resorting to the deferred call in case it is
> > set.
> > 
> > v2: Rostedt suggested removing the #ifdef from put_task_struct() and
> >     creating tsk_is_pi_blocked_on() in sched.h to make the change cleaner.

Oh gawd, this patch makes a sad situation worse.

> I complained about this special RT case in put_task_struct() when it was
> first got introduced. Couldn't we just just unconditionally do the RCU
> put?

Yeah, please make it simpler, not more complex.
