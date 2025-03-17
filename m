Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87568221F36
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203696; cv=none; b=ofuzBg9qrmX/H9Tfj4ba5Q3143xhIiv1hQ+ZcKX45dIx+K5lksqnMZC4+DQezpthRGMX97eN4Al21YQhxJQ3vXOgQ8oO6HmYUUM79PosT80bLLGxKRTBZs2SMNuyEZEHI5E7n8ftQC9NgnWKLiKBZM9TvZOz+evx+SEPulJBxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203696; c=relaxed/simple;
	bh=cn3pnNqQ/ylAyxiZ7z5cCxJkQFxKq5pG7frJjiVfsVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEIvXkK7rKa/lpJoCb2KVfBPxSFH9x++V8cNFhUHk8MNJjVzG/vpMDrIz5GkPs0K6Mf0v8H0SCkgIZGsRvwDlouwkka1dgkU3X/w7T1LiVRthuQJA1EOtVDfMezin9OjJCDFKi4RkP9TPH6rGIqxENW6CcZWXuCcxRiqtfoZlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bY+AVRea; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=arTsO19T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bY+AVRea";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="arTsO19T"
Date: Mon, 17 Mar 2025 10:28:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742203692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYjDnz882eQPRNoAR6NhgU1hGmz0GQ15sjV4f+ly7kI=;
	b=bY+AVRead4ovc7ZlxXujvQPJwj5V5UnBa1HAiBhsz8SmpdpH0cv2HKBQwsNxM6XwFDL0sj
	JZeO2sEaQbAChmrfTWMj0kTrrs7/UmQ+oiI8kMwwBn9ZYB73HknueNANl/6pkjET/gLu6e
	H2lLX3FT5ctGSPUSJJafDVsxHCdGj+BziaAptEUJDUN+qHBaP9NExi75BqXRv42A980m1H
	g50Qcm8LBFWdiA4bcr6aABBw1T4ttAoql4K0uZ/+GppneWk1sdKcOffgkVSnaP2uAawazz
	jo6GdrnAO3lt1IB2YH0mDzSWOmgCJlie4idUL4MTH0JxHnP97MKj49MZwQbJLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742203692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYjDnz882eQPRNoAR6NhgU1hGmz0GQ15sjV4f+ly7kI=;
	b=arTsO19TbJXHb1bQH3O5bLmVPfI3bXEM+j9O23JlOpDVBQRAQWJhruNXJI2uqy20wzuE2r
	Y/Oe8bMICy3yPiBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 0/9] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250317092811.nGfJKPUZ@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <Z9fn-UqDPXEr8vs-@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9fn-UqDPXEr8vs-@gmail.com>

On 2025-03-17 10:14:33 [+0100], Ingo Molnar wrote:
> 
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Sebastian Andrzej Siewior (9):
> >   sched: Add a generic function to return the preemption string.
> >   lib/dump_stack: Use preempt_model_str().
> >   arm: Rely on generic printing of preemption model.
> >   arm64: Rely on generic printing of preemption model.
> >   powerpc: Rely on generic printing of preemption model.
> >   s390: Rely on generic printing of preemption model.
> >   x86: Rely on generic printing of preemption model.
> >   xtensa: Rely on generic printing of preemption model.
> >   tracing: Use preempt_model_str().
> 
> A meta request: please do not put periods into patch titles in this and 
> future series...

No full stop at the end of the sentence then? I've been asked once to do
so.

> Thanks,
> 
> 	Ingo

Sebastian
