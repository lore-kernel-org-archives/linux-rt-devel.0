Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C51DF25A
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184765; cv=none; b=E4usl2Zz8gNr9BivkhE90PKrnS4XGXT6mJpaatbU/XjICglVYDB6uqR+IYNQ96UWkZ0TZGOEDuyeRpmFBEiBPqgH9L2pekrhGKEygOvjgjjCr4BwX3p7WexCyTnFPpkv1j+BE9jrRJwIMVDY+7aDzj21nQvg5lEmuSnTJbeuqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184765; c=relaxed/simple;
	bh=TVgz4F8n8xb28tD1JbQKYqBfeaq1esvg4NCEu2OO4u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJvdfr1qjT/pQa+efRhhptNKwrc9/1CEN64SZVw3nMd4yk4Oj98iSVFctNKQZrj2X1FwJ+lIj/1A+Sidggim7pG3l/Vzz1VyPu0FryDYtfBkg4TfDgVuCTRMy4vm7CeRdHgoTCE1eyKE40ocky3vO1UazuAuzXUS112cwdirwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJivngPh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3PHL0Ef; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJivngPh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3PHL0Ef"
Date: Mon, 10 Feb 2025 11:52:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739184762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yy/GObOa1fnTW6oS5CZAvUQ9JjU/MNR/nBjtOngZ/9I=;
	b=bJivngPhU02qDRMCFZbTSTqYX69X3L9yNqTubx3w5LB72yRnh9Be7UlWfdqswetkgRDS4K
	SXUpLjzXs6TT1Q9rAWMIUyJ0SoQ1BzZyFZGc6jK8BB4OWvL94baLqA86Uh9TOlLWZZqpV6
	GdoQzL4Y8n/wBHCulNU6jrQV129Pn2qOrzxqIE6W64ZDe4lUNAdNlL4F+kzLbgyJjoclmn
	YXw2++g3H4uSdxRss9P+Pg5FaV5GYMGyYKgeo4XYGLVZDl8Bef314mo5m43oIQF+NSrQj9
	fOBH+5DcsXnA4+mXWnJwVTg05Wn/2a56vywkunA2WvIngbw9zkjuoglJ4ZUMMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739184762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yy/GObOa1fnTW6oS5CZAvUQ9JjU/MNR/nBjtOngZ/9I=;
	b=O3PHL0EfgENdWJmWVpr47OIAlTwq7YTSEdMC0fRp5Is1ntmIw43vQua9OG0ex5EnNoUniJ
	GNid+7RWVY3phMBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/9] sched: Add a generic function to return the
 preemption string.
Message-ID: <20250210105240.FTbUbs_F@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-2-bigeasy@linutronix.de>
 <0d4418ab-d531-413c-bbbd-6c97ea320490@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d4418ab-d531-413c-bbbd-6c97ea320490@linux.ibm.com>

On 2025-02-08 13:31:27 [+0530], Shrikanth Hegde wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 165c90ba64ea9..bd2664755b09a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7646,10 +7646,57 @@ PREEMPT_MODEL_ACCESSOR(lazy);
> >   #else /* !CONFIG_PREEMPT_DYNAMIC: */
> > +#define preempt_dynamic_mode -1
> > +
> >   static inline void preempt_dynamic_init(void) { }
> >   #endif /* CONFIG_PREEMPT_DYNAMIC */
> > +const char *preempt_modes[] = {
> > +	"none", "voluntary", "full", "lazy", NULL,
> > +};
> > +
> > +const char *preempt_model_str(void)
> > +{
> > +	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > +		(IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
> > +		 IS_ENABLED(CONFIG_PREEMPT_LAZY));
> > +	static char buf[128];
> > +
> > +	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
> > +		struct seq_buf s;
> > +
> > +		seq_buf_init(&s, buf, 128);
> > +		seq_buf_puts(&s, "PREEMPT");
> > +
> > +		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +			seq_buf_printf(&s, "%sRT%s",
> > +				       brace ? "_{" : "_",
> > +				       brace ? "," : "");
> > +
> > +		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
> > +			seq_buf_printf(&s, "(%s)%s",
> > +				       preempt_dynamic_mode > 0 ?
> > +				       preempt_modes[preempt_dynamic_mode] : "undef",
> > +				       brace ? "}" : "");
> > +			return seq_buf_str(&s);
> > +		}
> > +
> > +		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
> > +			seq_buf_printf(&s, "LAZY%s",
> > +				       brace ? "}" : "");
> > +			return seq_buf_str(&s);
> > +		}
> > +
> > +		return seq_buf_str(&s);
> > +	}
> > +
> > +	if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BUILD))
> > +		return "VOLUNTARY";
> > +
> > +	return "NONE";
> > +}
> 
> nit: This means when it preempt=full, it is going to show PREEMPT or
> PREEMPT_RT. Maybe that could be put into changelog or add code similar to
> lazy for full as well, so it is easier for user to know if it is in
> preempt=full model. In all other models, there is a suffix like PREEMPTLAZY.
> Dynamic modes looks good.

Sorry, I can't follow. With PREEMPT_RT enabled, it will show einer
PREEMPT or PREEMPT_RT. It will add lazy if you pass preempt=lazy. It is
either 'full' or 'lazy'. 
You can't have VOLUNTARY+lazy or VOLUNTARY+RT.

What do I miss?

Sebastian
