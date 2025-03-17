Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2021B1A3;
	Mon, 17 Mar 2025 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202757; cv=none; b=GCHWjX4va5sUtkxKALT25hYdRYH58RSFCpgG3TPBi4wn0OX9o1xlplwHmrLUqgw170eHMCtop3C+d2AQcP5C5zYGpnCvKn8A9dmVcvfDWcuzJz8tuTSsB1uO3sNpvCkcC6/kZ1uRHu7cMExbhZyWo4DPDL4oYabtOrt0P0sUvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202757; c=relaxed/simple;
	bh=WyudbIIYAxKH4VpoJyRRWBe+Uj3PJB/gFMDKRIhNpuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8jZF/SJUI6HsvEbi6RhDj0isYmon25Ith2ZKDtbs7Szs9xMStHl+0QhKeMCU5X1MwwXYGE3iwOLdGQpeeTi85xiBf0q5EIbjFhI0sTDssQ7pYWbi3qzjSUaSs5uLOaig6PUWMkDIjgM9d/R9unlOKsZm6Wd15qLzpm8Yyz8QzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQAhXQbf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQAhXQbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1790C4CEE3;
	Mon, 17 Mar 2025 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742202757;
	bh=WyudbIIYAxKH4VpoJyRRWBe+Uj3PJB/gFMDKRIhNpuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQAhXQbfIvFsfhRS98Co3IxSKOrpkn1nLGvulXPUIkoAXaXpCGfOkDfpOB987s5Yg
	 jrlc6R2WiZZTvk5ur74H556nU9tuoWKnvEHaeIz7auN06t/5RjnS9HGWyuZuGCs/as
	 djLKWETmKPEbOYIxPrWmBaG1fcB8PKwPoxGOo5EIlfB8+DTszqFdQOruo/J1KhLhoC
	 ZGjHkLP5FGzvzBttSDYnCUlEnyMbhjJF7izTUM5dhyJzfptVccDmO6RE6nFr1aCjfB
	 /dXeLBlytSCJA/OxjL3Y4wNCYC6G8NRMh+Z7OZBh/pH1B4aJIiQmCrETBwcT54WVef
	 CvTvaHnLpKNug==
Date: Mon, 17 Mar 2025 10:12:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Subject: Re: [PATCH v4 1/9] sched: Add a generic function to return the
 preemption string.
Message-ID: <Z9fnf9g_zmbNXICh@gmail.com>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
 <Z9ay49NsoC73dKXe@gmail.com>
 <20250317083155.9g9ksofZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317083155.9g9ksofZ@linutronix.de>


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-03-16 12:15:47 [+0100], Ingo Molnar wrote:
> > 
> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > +const char *preempt_modes[] = {
> > > +	"none", "voluntary", "full", "lazy", NULL,
> > > +};
> > 
> > > +	/* Count entries in NULL terminated preempt_modes */
> > > +	for (j = 0; preempt_modes[j]; j++)
> > > +		;
> > 
> > I'm pretty sure the build-time ARRAY_SIZE() primitive is superior here. ;-)
> 
> It would be but it is not an option.
> That array is defined in core.c where it is "always" required while
> debug.c needs it optionally. core.c is its one compile unit while
> debug.c is included by build_utility.c. So I don't see how this can work
> unless we shift things:

Why not have it all in debug.c?

Thanks,

	Ingo
