Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963084;
	b=qwWSDRSONIbtHT0APn32+mIoxwg7EmBWm8LWbc1RoiaP+52HWuUkOqmP8Sj+KZ3xerjL
	 kRvuAHGZMoRseqtBq+vvO1txYnczKHlnOvSq5ECjse7rPwRmg3fp71FIikzaBA25YiqSZ
	 h6VY2ackNCdzMkzHYjqBljoovRwSkz6abRdFJ/LqAxhIGE4AmamnHeM4kn+ixsq8WI54A
	 gXGEw/XFGONxDFWak9ZVLASQJT1vzWaLOzeyDo5GBp8/UJeR2cOnEtNBenmlvnZP0gmjm
	 EOsV6GyUCmVbjjTDntLp+5Epr6yqGQ0J0hBniTscTHA0lYsX7L9bleJ8cPBlqMY6S1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963084;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=9O2vKxr3vIPnGovxy920EtF3PDuvoKhJLdNO+mkZXkw=;
	b=LMRdtlJ6hq5V3GyTTgTbo9O5p/wdIC2KlwFbKpACAoXWNJAjqFi6+PzuDoNk6BrN3OTL
	 qSTrdOSwBygLnZnlAMk61BoKoqBguZytbgtAJKfsh2/KjK6xKBaixmVPPxAaPnwVUPvRX
	 iAKbhAr0+yaEiROOSTVhPCvEuHp6fTQoc5+xLmSU669SwlCKhrcxA3eQhsJeT65ZYiB4l
	 uuiYlb+PeAcMVhl0tJ2k1YKG1m2kk1kLFlVBNCJBt8rEQsPVQ9IVkiMUBY7CookNFITAB
	 uRrzfZASyVJeirZ9csh7wkcfhHMo1azP7FgAc+SjIDn2AYkdSf/NnJ3ItKjek09NHQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HtyHjLYm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=44LMbXC1;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30931606A329
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 11:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30931606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HtyHjLYm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=44LMbXC1
Date: Fri, 6 Nov 2026 12:04:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793963077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O2vKxr3vIPnGovxy920EtF3PDuvoKhJLdNO+mkZXkw=;
	b=HtyHjLYmmh1VG/Af1qQAAKmwuCkuqAQEF5RlWvyqH+1HCUqgdnos4eYr82H9lI2lp8Oty3
	a8ogFjsk9K1T7dY8/3KO7wEreD5yCs6kZLhEW7E+EV2EpwxQe7h7pvJdF3AorUjPIhum/M
	jC3mji5amnbDvR4O45i8oeYTD/TheNcPHlH4tEPln/nWkB2rJq0lgtuRFlpy6ja1lJIVA3
	Aaa/PT7catdNZ51RJal8jEpSg885TDcdvNfjw0Rk/UvGuX0+N8K/k2BSOY111+rpyUyyI8
	a/glYmgwoZVZ3aoA2+b82udb/JX55xcGQiFh/n/n740s/IlzQuCERMzZSmu80A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793963077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9O2vKxr3vIPnGovxy920EtF3PDuvoKhJLdNO+mkZXkw=;
	b=44LMbXC1z2hogBrAf+RVFd6f+/6xUuu+52pujs91eMqtr4+g3rwmjiLKqYUHbF9xbQlsx1
	G9NxWbV/oOTGLHBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-rt-devel@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	luca abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [PATCH] sched: Remove CONFIG_RT_GROUP_SCHED
Message-ID: <20261106110435.5MWA_4Hw@linutronix.de>
References: <20261105164724.yxONBd03@linutronix.de>
 <auy6nyTUuHBlgrV_@slm.duckdns.org>
 <20261105193010.tXUDDu2w@linutronix.de>
 <20261106105003.GU1813469@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106105003.GU1813469@noisy.programming.kicks-ass.net>

On 2026-11-06 11:50:03 [+0100], Peter Zijlstra wrote:
> On Thu, Nov 05, 2026 at 08:30:10PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-11-05 07:19:27 [-1000], Tejun Heo wrote:
> > > Hello, Sebastian.
> > Hi Tejun,
> > 
> > > 
> > > I'm not against it but wonder whether it'd be useful to do it more gradually
> > > so that people can pipe up if they depend on it. ie. Mark it deprecated and
> > > put it behind EXPORT for a bit and then BROKEN before actual removal.
> > 
> > I would be surprised if this is actually used especially since it is
> > cg-v1 and v2 is the default/ used by everyone (?). 
> 
> So I would love to actually delete this. But IIRC there were actually
> people who used it.

That would mean that it is working which does surprise me.

> But yes, we need to replace this with that other thing.

so no removal, keeping this thing that nobody can use? You don't give
your love a chance?
The plan is to make HCBS appear as CONFIG_RT_GROUP_SCHED or do I mix up
things?

Sebastian
