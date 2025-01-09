Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17421A457;
	Thu,  9 Jan 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433429; cv=none; b=U4wgHoKJ+ex+ZHGZAGhetDwJQLym4BIxG0t3uFkCgWey1LiSbDh78ho/5O1DqXqTHPtV9SZqbzZL47Ft1zK/VKq/pEmKVyYiYRoCgS3NaHWp1xMyOCYm5FN+49FUqzwRUDMv6sAG4IvXioa23ni6PHWd6CSSRfpmuSX4wE8xSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433429; c=relaxed/simple;
	bh=rGNZlDroD7N+gvTXcgfDkbE3qNN3CnVp0eZ5DSJluPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzTPJd72sSLc6E+r8P2FG2Uvbg3yjQZVaiIzHfky6nWaS9BLc0tcsW8ex5sJ0UNgZJ+6tr0x68Zvj/uYdcxTJihBT/eV+X+67734BbCggHB8hhjXCT7aWeeSuUzJRWfFl4e29rKjYyCk2TFUwRkVMt60ObSNQYBNMvkYkdQtt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SGIi0LC7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SGIi0LC7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OgN7O/cmblCwnw5ERtHmMAJln0nw2I8X2+pIjRKtI4E=; b=SGIi0LC7YMKUmQH6dVyHJzhgrU
	7gTfEBQ89W6CjlhjDlUuy8im0bUplhe8OakzmcShLbS4PFYDcBFpGeeofMPku0zELVDeRzF67NVca
	UVnLNJyE2GxshzmH9t7XPe/YAKndyqeBIfDoTfEOVBqrw4fX31rAXVSxrYarODMwc5HuWOmQCsVPD
	Wp6ueMRYljqs5S0DkZiIAv2Qfk6nl041845Im1g6jbYdFaRkCytXioAzOzNRA2+//HA1swcjXg6e2
	jLMgU9zjw+9PAuloXCKGT69MyJAhFvPqyhYmhcY9rhI1iyC7JL3/m7AIFwf/FPF32R1jSytDR50pG
	9rJgvegQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVteg-00000006PxW-36YD;
	Thu, 09 Jan 2025 14:37:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D897A3003AF; Thu,  9 Jan 2025 15:37:01 +0100 (CET)
Date: Thu, 9 Jan 2025 15:37:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [RFC PATCH] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250109143701.GA5388@noisy.programming.kicks-ass.net>
References: <20241206113431.Q-VXMlru@linutronix.de>
 <20250109114339.GB2981@noisy.programming.kicks-ass.net>
 <20250109093702.5fe3400d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109093702.5fe3400d@gandalf.local.home>

On Thu, Jan 09, 2025 at 09:37:02AM -0500, Steven Rostedt wrote:
> On Thu, 9 Jan 2025 12:43:39 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Hurmph.. a bunch of those combinations are nonsense :/
> > 
> > Also, we have a string thing in sched_dynamic_show().
> > 
> > Can't we do something like:
> > 
> > const char *preempt_model_str(void)
> > {
> > 	static char buf[128];
> > 	size_t off = 0, len = sizeof(buf), r;
> > 	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > 		     (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
> > 		      IS_ENABLED(CONFIG_PREEMPT_LAZY));
> > 
> > 	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
> > 		r = snprintf(buf + off, len, "PREEMPT");
> > 		off += r;
> > 		len -= r;
> > 
> > 		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > 			r = snprintf(buf + off, len, "%sRT%s", 
> > 					brace ? "_{" : "_",
> > 					brace ? "," : "");
> > 			off += r;
> > 			len -= r;
> > 		}
> > 
> > 		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
> > 			snprintf(buf + off, len, "(%s)%s", 
> > 				preempt_modes[preempt_dynamic_mode],
> > 				brace ? "}" : "");
> > 			retun buf;
> > 		}
> > 
> > 		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
> > 			snprintf(buf + off, len, "LAZY%s", 
> > 				brace ? "}" : "");
> > 			retun buf;
> > 		}
> 
> I'm sorry, but I can't even tell what the above is doing without my brain
> hurting. Why make code that was easy to read into a cryptic obfuscation? I
> can't see this as an optimization as IS_ENABLED() is determined at compile
> time.

Upgrade brain. Also the proposed thing was just plain wrong.
