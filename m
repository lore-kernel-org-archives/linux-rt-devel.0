Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53D238D43;
	Mon, 17 Mar 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206725; cv=none; b=hlJy4gG8pOU/PwSByoRPGkmVpMdwez7GiX24jHLBqtTEhcDpCXYqtP2fxK9jYfvdyjLEwv+znhSnhnzJKzJ6Zp5ZfpvTyuPVeo1udF2j1H3wJ+YbW8qPmn+H8m6UDTIPovG7S2FsbcCEgGTwzlBn70z7TGPkNFQRXelrZpV+iFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206725; c=relaxed/simple;
	bh=tdihrKE7tzndVFnw9dWBP73Eu2/SjZoCbquhjXvIpzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuxy0aBF2PjlnZHj3vgbdV9BSTuv7IoVyV9ZB/3SUYA1eMqiKK4WWyk+EoXNLZ5iKskl0bO3SvimOLITPQWkM1GhcJaqn8fmUaS1KlloFRuOkew37DZTgfAl4AFY/sph5iGx2g5MVqsT2znwFIUFLiAyiFTMycD45MMTbwct/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRNhqbJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRNhqbJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A62C4CEE3;
	Mon, 17 Mar 2025 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206723;
	bh=tdihrKE7tzndVFnw9dWBP73Eu2/SjZoCbquhjXvIpzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRNhqbJPLHmdKTQyG4guXvGs+c8P4CPGjccAaxa0KUdhiMJz6C4UNRN1PLTIDipvf
	 y+D2H0C1NCXJYgrAui99at8QYk4LbtlGPVtyjCQl0u+DNqbEE6LwXyWMrSd9OyUd8Q
	 ZKJWpojx74Z/BrI1j8Ms2pSud4PL3bLgSHsE92GLzbhWyYKTbJ1+JQqhymCEFAHLJh
	 GQ7cBwvnm5ZcIpEAHYvpuY58qCBDpeRRYCWLJ1N6D3IIgtZd+P1DdiD3UCkybzT5h/
	 Q9DuMqPWv9D8xtmkpZeIbhVcdncyZqaVDY9DYQni/ujtlj3o3E4CQ5kaR6uO3ZPEby
	 6iqR/IgM/QT5w==
Date: Mon, 17 Mar 2025 11:18:37 +0100
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
Message-ID: <Z9f2_exjFEpTpuRr@gmail.com>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
 <Z9ay49NsoC73dKXe@gmail.com>
 <20250317083155.9g9ksofZ@linutronix.de>
 <Z9fnf9g_zmbNXICh@gmail.com>
 <20250317092526.S1MfZldy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317092526.S1MfZldy@linutronix.de>


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-03-17 10:12:31 [+0100], Ingo Molnar wrote:
> > 
> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > On 2025-03-16 12:15:47 [+0100], Ingo Molnar wrote:
> > > > 
> > > > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > > 
> > > > > +const char *preempt_modes[] = {
> > > > > +	"none", "voluntary", "full", "lazy", NULL,
> > > > > +};
> > > > 
> > > > > +	/* Count entries in NULL terminated preempt_modes */
> > > > > +	for (j = 0; preempt_modes[j]; j++)
> > > > > +		;
> > > > 
> > > > I'm pretty sure the build-time ARRAY_SIZE() primitive is superior here. ;-)
> > > 
> > > It would be but it is not an option.
> > > That array is defined in core.c where it is "always" required while
> > > debug.c needs it optionally. core.c is its one compile unit while
> > > debug.c is included by build_utility.c. So I don't see how this can work
> > > unless we shift things:
> > 
> > Why not have it all in debug.c?
> 
> The debug.c include is behind CONFIG_SCHED_DEBUG. This needs to be moved
> into debug.c itself so that code can be added regardless of
> CONFIG_SCHED_DEBUG. It is not only sched-debug after that.

Yeah, that's a valid concern.

The thing is, CONFIG_SCHED_DEBUG is mostly meaningless these days - all 
major distributions enable it because of the statistics are useful for 
system administration, tooling and general software development.

So we should enable it permanently and remove the #ifdeffery. I'll send 
out a series to do so soon.

Thanks,

	Ingo
