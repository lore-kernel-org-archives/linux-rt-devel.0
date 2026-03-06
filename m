Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8834DB79
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Mar 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795821; cv=none; b=DumukOqA0JhMQ/EU/KaRHmP+egaHmB+37n+NR3p2/8WWgwtAn56DPkO4+M7ZAGe8iLVbIU3Kpbl/aEu3pFqysJ8UPJIyvGczXhBfqMIJx6YD40yMncMEi3DbsCvN3TLpJVztwDnB1OrkhuUINf7kH4SZvDurKFTVMiaeMNBk1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795821; c=relaxed/simple;
	bh=0ct0kpKeDc+z2OOgJb8NVSmKtUsozpuK8513SX1J5pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQNboLL/1zrK5xSDNXOd+bXaQ5Vai64erLBdeBLPPUFpQK9B5AhyhO7z6GAOEEkpvyCol9fLqoo+Kudzrv8/gMDpHcAjiYcDIa/uJzHSM6uRE/1gOxOBuKoVXk8X+0CO6jHInxNTNb8+DAXSPqWJ15dqtVrUDLoePNtZgO6sLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mai2BBne; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OEBLTa5P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mai2BBne";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OEBLTa5P"
Date: Fri, 6 Mar 2026 12:16:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772795818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=edgyxK5qi6Ep8DqwcjmWXemGWVZZ1w6pXK2DL1BBElk=;
	b=mai2BBne1Lvz/o4lG4LVp1PHvaevfcxrH2Pa+kzYR2eFhnNCPfgJzUk3oAEIMjINmunPan
	52Pq2znicPpmIqcLfo52ws1HBIp5jLUyOoOoDoAha+JQBMhzB9UhEBBb4rwczD1+WfGUSL
	eddh5Vv0szLz0gqKB5VJk39gIEd6TjomNAgwhg5a+XcA/X2DotqeSKJEde/W82HcIQx/hi
	IfFT/ZJUPwneQ5szp77UlOaZZHs7HDfty7pqG/4kMrf9iuCHcPiplcc5yWwSCgCVVsIGJT
	tZxajdpvxJGFvAdf7ogxRNMy1d9RgvvuwzoQ4JMrFyBOhRBLcO1eLOWVICkQCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772795818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=edgyxK5qi6Ep8DqwcjmWXemGWVZZ1w6pXK2DL1BBElk=;
	b=OEBLTa5PmPF5m1WV/SXWK4ehaTH7Al34TIPSQaG77cUS64gJMn/2EJBhlC9cPzyyXnGbgF
	ARy5lta9E5rY59Aw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <aaq3qN_mdpvJ0ixY@lx-t490>
References: <20260305205023.361530-1-darwi@linutronix.de>
 <20260305205023.361530-2-darwi@linutronix.de>
 <20260305180741.7bd114f4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305180741.7bd114f4@gandalf.local.home>

On Thu, 05 Mar 2026, Steven Rostedt wrote:
>
> Very nice document!
>

Oh, thanks :)

>
> > +
> > +``CONFIG_PREEMPT_RT`` enables this option by default.  If this option is
> > +disabled during the kernel build, pass the following boot parameter [1]_::
> > +
> > +  efi=noruntime
>
> The above reads a bit funny. Maybe reword it to:
>
>   ``CONFIG_PREEMPT_RT`` enables this option by default. If this option is
>   manually disabled at build time, the following boot parameter [1]_ may
>   be used to disable EFI runtime at boot up::
>
> Or something like that.
>

Yes, much better; will do.

> > +
> > +There is ongoing `development work`_ to allow EFI variables access for a
> > +real-time Linux system.
>
>   .. to allow access to EFI variables for a real-time Linux system
>
>  ?
>

Yup.

> > +``CONFIG_TRACING`` (and tracing options)
> > +----------------------------------------
> > +
> > +:Expectation: enabled
> > +:Severity: *info*
> > +
> > +Shipping kernels with tracing support enabled (but not actively running)
> > +is highly recommended.  This will allow the users to extract more
> > +information if latency problems arise.
> > +
> > +.. caution::
> > +
> > +  Users should *not* make use of tracers or trace events during production
> > +  real-time kernel operation as they can add considerable overhead and
> > +  degrade the system's latency.
>
> I wonder if a special note should be called out for:
>
>   CONFIG_IRQSOFF_TRACER and CONFIG_PREEMPT_TRACER should be avoided as they
>   do incur measurable overhead even when tracing is not currently active.
>
> Maybe the above should be added in the "Problematic debug options"?
>

Oh, didn't know about that; I'll add them for sure.

>
> > +Kernel Debug Options
> > +====================
> > +
> > +Most kernel debug options add runtime overhead that increases the
> > +worst-case latency.
> > +
> > +.. caution::
> > +
> > +  During development and early testing, users are encouraged to run their
> > +  real-time workloads and peripherals with lockdep and other kernel debug
> > +  options enabled, for a considerable amount of time.  Such workloads
> > +  might trigger kernel code paths that were not triggered during the
> > +  internal Linux real-time kernel development, thus helping to uncover any
> > +  real-time latency issues in the kernel.
>
> Hmm, perhaps there should be some note that connects the use of "lockdep"
> with CONFIG_PROVE_LOCKING below (as that is what enables lockdep). The last
> sentence above makes it sound like lockdep can uncover latency issues, but
> it will most likely cause latency issues. Perhaps a bit more explanation
> should be used here.
>

will do.

> > +
> > +With that in mind, any false real-time kernel configuration could cause a
>
>   s/false/incorrect/ ?
>

Yup.

>
> Nice job!
>

Thanks!  I'll send a v2 on Monday.

All the best,
Ahmed
