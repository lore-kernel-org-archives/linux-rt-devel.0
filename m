Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30C2641E3
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910305; cv=none; b=nRwCd/8nopFAG3up8frBmmJzCRhhkFGMXNo7YnscFJYjYq8YnbKUYjWZDWWAdDdHKmzYg2ukyYpdYkyXolQQD0pf6iBq8Q9fYLKgZ4QfRMTZ3xqFmozpFBlwaP1MzlHgYPwZrn1t/kDzfhQRkG0RtZGDIO/1GeEZFymBrOvGBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910305; c=relaxed/simple;
	bh=C/Oc+ZJznEw26a3qqdzHnr5Ck+HqU+Ubji8kVfkbYEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5z2lU0OY3xNE1cgwaKzRQTNpnRy3TiSB4ZQtiGLDgLYBhRShbTIdkPUKnQmNUeLiOxYamYqlwEdPzfXBFrDIIzLTThokCBhrnL8qtFw8UWBYwDrVbV4Vj+0JknkW3T7gssBfbWbdNOr3T7yMzmgHjj8hjpkCYWdzZQofcoFOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9QbDcKa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nc3HRIcS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9QbDcKa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nc3HRIcS"
Date: Mon, 11 Aug 2025 13:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754910302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Fd0fAgyABcANleBghCjE/c6htnzRnk3cOaQFaucm98=;
	b=q9QbDcKaZb3oxJac3i+ji1KsvvJT9h1Sc7/LFCMFzg1mzigKGVUVy+yeiGlVjw8cnIj1Mx
	ZiuvWQLUtakuhOlN4Iym18Gwtng46o8Oh9gzafxrWeYK8ICyZbrSWAMeCVwwPIutuMhV1q
	OKiae3F2C9t9DRpkc7AJ49m1DjuLSVxz3Jn/UgJ8wtW8m/16QrGMckD2/dFLFYOtIqZ8xp
	GPYc/RTRIjH0GrRS7bExVtNBWiRU0iGcWE+UcLL0CZ5uemxeVmkaIeBwriFeMMEqSqeGAS
	WPUwxFBxNzaW6ZHDpIebTO+wlDZ3F1dzMi5FZyDXrkxcAi5YcfijPA41Ei0uQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754910302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Fd0fAgyABcANleBghCjE/c6htnzRnk3cOaQFaucm98=;
	b=nc3HRIcS8QhrbPTUX1RzJ9hegLxJDsLebyjoQBCMuv/fqhvsPo7LwMMcROUeKX8vHOMPWz
	d+Jk2+NITgQQMCBw==
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
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <20250811110501.nTDNkPnM@linutronix.de>
References: <aJOwe_ZS5rHXMrsO@uudg.org>
 <20250811100624.LuYV-ZuF@linutronix.de>
 <20250811104033.GA5250@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811104033.GA5250@redhat.com>

On 2025-08-11 12:40:34 [+0200], Oleg Nesterov wrote:
> On 08/11, Sebastian Andrzej Siewior wrote:
> >
> > I don't want to drag this but this comment is obvious for anyone who is
> > fluent in C. It is just a statement with no explanation.
> > An important note would be that the atomic context restriction only
> > apply to PREEMPT_RT and therefore we have this context override for
> > lockdep below. The other question would be why don't we do this
> > unconditionally regardless of PREEMPT_RT. The only reason I could find
> > is that releasing the task here from the "exit path" makes the vmap
> > stack "earlier" available for reuse.
> 
> Sorry, could you clarify your "other" question?
> 
> What exactly do you think we could do regardless of PREEMPT_RT?

Do what we do now and have one free path for task_struct regardless if
PREEMPT_RT is enabled or not. The one via RCU which delays the freeing
until after the grace period.

> Oleg.

Sebastian
