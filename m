Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36943AE71F
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749252; cv=none; b=VVcxNQt/Mz/vLeLiFD+nejINsZLH/P2I2OBxxqSIzOSvWTUo47f/aSphI/H+5yxJ4tUPRij3kGptKX+qEmjXvuA0lD+4/F1maTq+IfPUUccAmoSN7GLa0GW1J6ZoSQzLUc88ocBiEXhSQPIYJUMBTjcLRs3Dlb7N6w0g+AxxUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749252; c=relaxed/simple;
	bh=H1GhD+wdiGfBFkkrXGiPA1yBJH1W/n/cUKvHuJo0hYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xdzqxw/WWf/x21fqrDpt6J37805U90kyqrMVZir8EgOD1lEakUqINY4JaJhTNgWfv+WJuFnjkvwuPahXKCcfJWWmDZhIeCPo8rmMLDf3AenV1l+UQKb1ppQPG0g4nfLde/ICyfN8s5Xu/UPFpYV4e9CUrqsXFvQX7wZepE7+IG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1X/8/Zj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXj8lngD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1X/8/Zj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXj8lngD"
Date: Wed, 22 Jul 2026 21:40:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784749249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IF2svoHyMZT2NyJ/aKZK4KhaQNgnII8nedcS032BJ8I=;
	b=R1X/8/ZjcQGhuAcoYMYkSuxwFD/HdWblJcEQXvGPeUObBKu/SidERA8uK+UmNvYDOJ90gu
	A63EvGGXLtorDnFVBmXxukfdeP+bXMTQx+URnu4bH/rTy7m65GH6irYQIVMIHu4xBGUFq9
	28PveXMU9v+MtLJjftPnl53FpYWaS56LMaeQjxN3WkAH4Jnv7JYbyrHQ1MwvYK9hZse/hr
	1Fi38GzpFb4x9tgMjkhrUoA285uf8zCRU1gPD07TTTGg8F7kimgZXM9wWNwuVSZkrL7+iv
	RikIkg4gcBMnJiDo7LsLel+nVoFqh63/E4mUrx3I01gIxcHmjp/EheMPaMbHFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784749249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IF2svoHyMZT2NyJ/aKZK4KhaQNgnII8nedcS032BJ8I=;
	b=LXj8lngDaqgVfuN/LRUFRwuX50Cbbyv7/e80vbgpEx62gk2/Fb6iCKuxYJ+Q95JEtD6Cb+
	mld5kJ8deqR3TgBg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <amEcvta4-GiFrg-Q@lx-t490>
References: <20260716195716.256025-1-darwi@linutronix.de>
 <20260716195716.256025-2-darwi@linutronix.de>
 <20260721130248.ndwsFtHE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721130248.ndwsFtHE@linutronix.de>

On Tue, 21 Jul 2026, Sebastian Andrzej Siewior wrote:
>
> On 2026-07-16 21:57:14 [+0200], Ahmed S. Darwish wrote:
> > +``CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE``
> > +-------------------------------------------
> > +
> > +:Expectation: enabled
> > +:Severity: *high*
> > +
> > +Real-Time workloads expect a fixed CPU frequency during execution.  Using
> > +the performance governor is an easy way to achieve that purely from kernel
> > +configuration.
> > +
> > +This is not a blanket rule.  Some setups might prefer to clock the CPU to
> > +lower speeds due to thermal packaging or other requirements.  The key is
> > +that the CPU frequency remains constant once set.
>
> A dynamic governor such as CONFIG_CPU_FREQ_GOV_POWERSAVE must be
> avoided.
>

ACK.

>
> > …
> > +
> > +- :doc:`Regarding hardware (System memory and cache) </core-api/real-time/hardware>`
> > +- :doc:`/filesystems/resctrl`>
>
> I've been told by Jonathan to avoid this and just use plain file
> references such as
> - Documentation/admin-guide/pm/cpuidle.rst
> - Documentation/admin-guide/pm/index.rst
>

ACK.

> > +- `Real-Time and Graphics: A Contradiction?`_
>
> And this might be included inline, too.
>
> > +``CONFIG_TRACING`` (and tracing options)
> > +----------------------------------------
> > +
> > +:Expectation: enabled
> > +:Severity: *info*
> > +
> > +Shipping kernels with tracing support enabled (but not actively running) is
> > +highly recommended.  This will allow the users to extract more information
> > +if latency problems arise.  Nonetheless, some tracers do incur latency
> > +overhead by just being enabled; see :ref:`tracers`.
>
> Instead of this jumping forth and back while reading, couldn't the
> CONFIG_IRQSOFF_TRACER and CONFIG_PREEMPT_TRACER be added here?
>

I'll think of something.

> >
> > +Non-performance CPU frequency governors
> > +---------------------------------------
>
> so here it is.
> > …
> > …
>
> Could we please merge this in the previous section so that we don't have
> two times the CPU frequency governors.
>

OK.

>
> Could we merge the caution box from before here somehow? The statement
> is that lockdep is very helpful in validating lockchains and so on
> especially on paths which are only seen if the real-time workload is
> active. However, since it can easily introduce scheduling latencies of
> 10ms it is hardly an option that ca be enabled in production.
>

I'll think of something.

> > +
> > +``CONFIG_DEBUG_FS``
> > +^^^^^^^^^^^^^^^^^^^
> > +
> > +This is safe to include in real-time kernels, *provided that debugfs is
> > +not accessed during production runtime*.
>
> It is safe to have as long as you don't use it.

which is what I said above.

>
> I would drop it.
>

Well, earlier I stated that debug options need to be disabled for a
real-time kernel, except the explicitly list debug options which are deemed
OK.  So I need to mention that CONFIG_DEBUG_FS is deemed OK.  The list
above is not saying, "enable it for RT".  It rather says, "if you need it,
it's not problematic for RT."

>
> > +
> > +``CONFIG_DEBUG_KERNEL``
> > +^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Meta-option which allows debug features to be enabled.  This configuration
> > +option has no runtime impact, but be aware of any debug features that it
> > +may have allowed to be enabled.
>
> This one should come first (if at all) because it enables to access of
> few of the options mentioned in this section.
>

All the options are alphabetically listed, so that the 3-level table of
contents on top (which lists all options) is clear and users cannot miss anything.

I'll think about this.

Thanks,
Ahmed
