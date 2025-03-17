Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6822356D5;
	Mon, 17 Mar 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208413; cv=none; b=r30L1/3DESFZ0rd25G3FhMzKxKOzjtlSClfciwn36Daw24AGSSCYysNONCDW/Qygdydl4kznoglBUkwkxxfLRxNJHqxa+VGUpMpgYw4AlTdLbrmby1nmlm4xVDemh/La60ciZ2uUYlQ8ff7TlOpgBaLMlDWhYvLM8JZEs7K4RJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208413; c=relaxed/simple;
	bh=ocTFdTc6yd3mJfLws1Cc4o1Y7dxCQqvNycNtrFIYbpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET2843aRfqsZz5IQZwU+sPWXOgSL4CaE9IysA4CG6xwNT/ZqnbI7LhDwIl8qU+XynB7UZvyTtTXflnqEW24UJNy78MXhe61XvRboomsWrNR79d190sNyieTEVxBChVSYXB1wU/Y3K+tophR79hBY7rk3vTmq3d2p1wtZZqoDbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjExmyb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjExmyb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10596C4CEE3;
	Mon, 17 Mar 2025 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742208412;
	bh=ocTFdTc6yd3mJfLws1Cc4o1Y7dxCQqvNycNtrFIYbpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjExmyb8HNtxK1o9bnzisOVz5oyUVxcgOOH3ZowkzxncKYxbJp/RlUf7bBrp8EcAD
	 GREgtyVRl0e+yySX2tm5cih9T6x1LZMdvEfQrgxZnf/YrxDHzim2edK4ZQltMppIvx
	 zR9JKz1XtzeCHa5y8RBq6TFmjJrj8XmY8FaFj1JPfFGmvNRowhEI/48HmP2eMIkTef
	 uQ59w3C8sv0OYk9I2pYgkiwrDPUjENZq01wxT29g3ZGtXfnd0kksPKy/OXmyIcddKh
	 E2mmJAlH9CNr2TsGK0VxlaPz4IGzgmdMvQqWuBTCgJ2NxbBqS+VXOkRAEjTSW6Fahq
	 Ivw5zMri293yQ==
Date: Mon, 17 Mar 2025 11:46:46 +0100
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
Message-ID: <Z9f9ljbTDGOGZUSb@gmail.com>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
 <Z9ay49NsoC73dKXe@gmail.com>
 <20250317083155.9g9ksofZ@linutronix.de>
 <Z9fnf9g_zmbNXICh@gmail.com>
 <20250317092526.S1MfZldy@linutronix.de>
 <Z9f2_exjFEpTpuRr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9f2_exjFEpTpuRr@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2025-03-17 10:12:31 [+0100], Ingo Molnar wrote:
> > > 
> > > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > 
> > > > On 2025-03-16 12:15:47 [+0100], Ingo Molnar wrote:
> > > > > 
> > > > > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > > > 
> > > > > > +const char *preempt_modes[] = {
> > > > > > +	"none", "voluntary", "full", "lazy", NULL,
> > > > > > +};
> > > > > 
> > > > > > +	/* Count entries in NULL terminated preempt_modes */
> > > > > > +	for (j = 0; preempt_modes[j]; j++)
> > > > > > +		;
> > > > > 
> > > > > I'm pretty sure the build-time ARRAY_SIZE() primitive is superior here. ;-)
> > > > 
> > > > It would be but it is not an option.
> > > > That array is defined in core.c where it is "always" required while
> > > > debug.c needs it optionally. core.c is its one compile unit while
> > > > debug.c is included by build_utility.c. So I don't see how this can work
> > > > unless we shift things:
> > > 
> > > Why not have it all in debug.c?
> > 
> > The debug.c include is behind CONFIG_SCHED_DEBUG. This needs to be moved
> > into debug.c itself so that code can be added regardless of
> > CONFIG_SCHED_DEBUG. It is not only sched-debug after that.
> 
> Yeah, that's a valid concern.
> 
> The thing is, CONFIG_SCHED_DEBUG is mostly meaningless these days - all 
> major distributions enable it because of the statistics are useful for 
> system administration, tooling and general software development.
> 
> So we should enable it permanently and remove the #ifdeffery. I'll send 
> out a series to do so soon.

Here's the series:

  https://lore.kernel.org/r/20250317104257.3496611-1-mingo@kernel.org

  Ingo Molnar (5):
      sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()
      sched/debug: Make 'const_debug' tunables unconditional __read_mostly
      sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional
      sched/debug, Documentation: Remove (most) CONFIG_SCHED_DEBUG references from documentation
      sched/debug: Remove CONFIG_SCHED_DEBUG

Forgot to Cc: you - will do so in future versions.

Thanks,

	Ingo
