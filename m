Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32F1F875A;
	Tue, 13 Oct 2026 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873498; cv=none; b=d4+gJGtj/95Epd53Mo9u0rbY87wYrYE2uPNb8AICCAXsL++o0SttC6Ktf09ab2DO2kMaeArJrxHYP9UAMHz8VWTeyWr+rs6MLrOOdmVlEIRwa/M7KS8WwiAjQKiJq5h0ZKibWYMVl1yupSobfqkHs3jX1HCq8rBXEuVLHXLv2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873498; c=relaxed/simple;
	bh=5iBTYOGPdw2/i1l9kfkD6M/4ZKAtn1UDvtcKynwhC8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWTvoDYEuYs/213EHlNrD6zZ5T/SDS9Dahy/LR4KMSal1GeP2KJ4Mcl+uNth9QNzeecuKI5TKG+mB7oRwB4hLoBf1dYyyDpe90zZiJM2rYyFh1/RnwiG/UZ+F9wPe9xb9Qcux/6qTgMHaE/pbfuecjFD7Qcj1hbMgsLjI4leFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WMTWFKRh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WMTWFKRh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HM1tO2zUuq3aHDKS8jcZb4shFXJCucSmuz2o7ICzeXY=; b=WMTWFKRhyqeXSxK1yVeP2hwGdf
	9lqF2r1m4Wzu7NwPLJY6wbsSmYUzcEqFqH9JEIS/fzAPuils5lXJIKFpKyaGw77NCKxJ0mr1trSCe
	Z8hX0AGgRAhZRUMyjzXurAbFoERyQeeRdjWIM4WZevix8gjUWYMAzFUGp0zqjfN+PCzvSp52mvj6X
	YOF8QdYJjjaaTKC7YH7g720w36ap+dXNF0N7m9ceqmSbvFAOAyUbnu8MH7zp0uPwCHBCZpgU5yVvq
	5JALc3VdBwYIIQXq7hknKWpo3r4zZIT/ICiGXVD4P4JBE/LJ/nDaIvBRgSwE2Y2vAheXJQfADg42m
	kc+zhUtA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGW9G-0000000FAXd-2MNv;
	Tue, 13 Oct 2026 06:38:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0228930045A; Tue, 13 Oct 2026 08:38:05 +0200 (CEST)
Date: Tue, 13 Oct 2026 08:38:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH] entry: Account the deferred hrtimer rearm as hardirq
 context for lockdep
Message-ID: <20261013063804.GX2009045@noisy.programming.kicks-ass.net>
References: <20261012152120.GT4121339@noisy.programming.kicks-ass.net>
 <20261013060448.751816-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013060448.751816-1-mikhail.v.gavrilov@gmail.com>

On Tue, Oct 13, 2026 at 11:04:48AM +0500, Mikhail Gavrilov wrote:
> On Mon, Oct 12, 2026 at 05:21:20PM +0200, Peter Zijlstra wrote:

> > That said; I wonder if we want more of irqentry_exit_to_kernel_mode()
> > wrapped like this. The schedule_preempt_irq() thing will now also stack
> > rq->lock and the like on top of 'random' kernel stacks, rather than
> > keeping it in 'empty' hardirq contexts.
> >
> > Or am I making a mess of things?
> 
> Apart from the rearm, the preemption is the only thing in there that
> takes locks, and I don't see a way to run it in lockdep's hardirq
> context: preempt_schedule_irq() enables interrupts before calling
> __schedule(), which trips the lockdep_hardirq_context() check in
> lockdep_hardirqs_on_prepare(), and hardirq_context is per CPU, so it
> would stay set for whatever task __schedule() switches to.

Right; that won't do.

> Nor is the shape specific to the interrupt return: schedule() under a
> held sleeping lock stacks rq->lock on that lock the same way. In the
> 46.6 hour boot, chains with rq->__lock on top of other held locks were
> 18.1% of the pool, and lockdep_chains does not tell which of them came
> from preemption.

That's roughly 2 out of 11. Not sure that's worth it. If I get another
crazy idea I'll let you know ;-)
