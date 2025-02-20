Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8381D5CC6;
	Thu, 20 Feb 2025 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051156; cv=none; b=EG0kYGw/ivymudgC7smKF9Q7cAs0r20Xc+goUJgcy6hn1heyHsnHZQPaDM2GqSeeO88pgRk3MCgNBFBuUK7Odctf3apRUXpYgb+rPwz4/E4K+PD9l4Uy/Mx04C93VVIKosOuSBJQjKt2JgEOVJcZrsYhBiVEQF9qbwQ7CDkNJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051156; c=relaxed/simple;
	bh=wzxlpv90u5xvYt4zcTq5GJZVHOFyXpboSAcPpUzatbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAM5pg5U8FybWdjSKnoaOvLUXl+dH+UfhJf0Xu9aDM6hES5724hF2kreUdI1vG1W1wBkfjS3x5o1EUy926ltnAi3EFaB1T9j/mNnJT0eilSKQLJR45Erhj8985d0+LBgnjFwu4+75uc2GJZhjM7DqgK89oLeeF5BvZ0BIeTmb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GOPexkO6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOPexkO6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UvsjlNFZFcOavkEr/eA5yIqt8c8rmuut9onsJ6T1myg=; b=GOPexkO6l0wY2VzBt84xrK68QR
	vjzvgvNLwkOAQf0CM4ganqHdnx0uoIOsqQKUdzRIZnn7xP0Gbg2xlaE16H7IQYrFbmRwUCVSYgBzV
	9Ekza2ALzsguzXzvaE6WJUX3xcj+goEWPwMb2G1udTRsPjSEi7TSEWqookSUlwGlcW4XxyBy0ITnh
	LKynVWyyIQ5H8GegPFM+He+eIxeNOcf5FwIrmoWovoYfV8BgPZz5yTT7W5TyovPInk/1XRoB6PJlI
	rBSRYmtcrgi41MIt9vaOBWMDzodJCZYvZ92imslKCLxYECmcCAmxBdSDyJmX/nrcR8BNsEKy8p6vU
	vmJO1SWg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tl4n6-00000009QRN-0yNZ;
	Thu, 20 Feb 2025 11:32:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6303300677; Thu, 20 Feb 2025 12:32:27 +0100 (CET)
Date: Thu, 20 Feb 2025 12:32:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Barret Rhoden <brho@google.com>, Petr Mladek <pmladek@suse.com>,
	Josh Don <joshdon@google.com>, Qais Yousef <qyousef@layalina.io>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Vernet <dvernet@meta.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
Message-ID: <20250220113227.GL34567@noisy.programming.kicks-ass.net>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>

On Thu, Feb 20, 2025 at 04:48:58PM +0530, K Prateek Nayak wrote:

> The rationale there was with growing number of tasks on cfs_rq, the
> throttle path has to perform a lot of dequeues and the unthrottle at
> distribution has to enqueue all the dequeued threads back.
> 
> This is one way to keep all the tasks queued but allow pick to only
> select among those that are preempted in kernel mode.
> 
> Since per-task throttling needs to tag, dequeue, and re-enqueue each
> task, I'm putting this out as an alternate approach that does not
> increase the complexities of tg_tree walks which Ben had noted on
> Valentin's series [1]. Instead we retain the per cfs_rq throttling
> at the cost of some stats tracking at enqueue and dequeue
> boundaries.
> 
> If you have a strong feelings against any specific part, or the entirety
> of this approach, please do let me know, and I'll do my best to see if
> a tweaked approach or an alternate implementation can scale well with
> growing thread counts (or at least try to defend the bits in question if
> they hold merit still).
> 
> Any and all feedback is appreciated :)

Pfff.. I hate it all :-)

So the dequeue approach puts the pain on the people actually using the
bandwidth crud, while this 'some extra accounting' crap has *everybody*
pay for this nonsense, right?

I'm not sure how bad this extra accounting is, but I do fear death by a
thousand cuts.
