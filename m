Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD942D94B7
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Oct 2025 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596248; cv=none; b=hlEDMFNkVpAvYTZ57WD8c5mDx9+aZXPL+PSKjuftAaKVFoeAtqbTzg52/kpTdEtGPVuoG053JXvpLwIqkgLZNSTF7F46q+bcN+2a5OetGUL2uj7JLkardXvp3ePFH4RUK2Iq8lIWneDCcdoW7ewDlF+g12/vg8f17y7pHAp7JCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596248; c=relaxed/simple;
	bh=yBL5A4Na3FGC+z4XJ151spiPKRURWgsUeaEkruh1Vz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luG2h6dt2PYs06fDlbjwkrZIjf68BIEoHGt/80D+8XUwbJ2eknRuYPXFAGdtv4d1U9kgUPH0Wf7iCHj37v0CYRZLkFCv8AZfLrB2O+OYAaNkenje6JSlyhNKBhQBoRNjgc9vsDKfdGI+laJxUjsy1EAV1+Pk7+3ACLLH3FJdN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kS8thQE2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsQG4Jpu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kS8thQE2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsQG4Jpu"
Date: Thu, 16 Oct 2025 08:30:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760596244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6IbjrRyjIzJUEdaRWMx1gg2BH4tKEtdFB7rtOCxaFg=;
	b=kS8thQE2Zc4rb0h4PzRI5Lxac0/ZR7EKxYmT53N42hsNkIkcBSl+WW7KNAXlrO+VxxT6+j
	8QNHgR7fTaTA0ks2XVXgJhgzCN9+uZyHTPWwd3fk5QwIa+TgLW/hQ1hQST88IQWJ8WNfLr
	VXKmqLMyLJVwCgXyp/azHrKXtE4asWAIbgEvo+gdfxxWAvOuCDrkCPQISf0jWkP1CabynH
	cegCTyu/WmbEE4ig03rD4M3Z1xFIzFb4yeyMiVKeszyPYmYWdMnjHjtUgN7JlYjEDRgNJ8
	Wx00LSM22OFmSWLHV99+J0jgUm2TDXBNWfXpH3ueCDRDNcZ6eXnXa/zmGx/kVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760596244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6IbjrRyjIzJUEdaRWMx1gg2BH4tKEtdFB7rtOCxaFg=;
	b=gsQG4JpuEXx2WtyG9BB4RZX6kMF/vuCCYpilNX3xbWHvvlJ6BtMmNjFzmsSPlwRRYJsWEH
	TeuX3dawgh8NP4Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] mempool: clarify behavior of mempool_alloc_preallocated()
Message-ID: <20251016063043.AqrS2HeR@linutronix.de>
References: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>
 <aO_taH9CKxmJPnhV@fedora>
 <20251015192717.HvwzCChE@linutronix.de>
 <aPAkNZDr_HAA_d75@fedora>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPAkNZDr_HAA_d75@fedora>

On 2025-10-15 15:46:13 [-0700], Vishal Moola (Oracle) wrote:
> On Wed, Oct 15, 2025 at 09:27:17PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-10-15 11:52:24 [-0700], Vishal Moola (Oracle) wrote:
> > > > --- a/mm/mempool.c
> > > > +++ b/mm/mempool.c
> > > > @@ -461,8 +461,8 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
> > > >   *             mempool_create().
> > > >   *
> > > >   * This function is similar to mempool_alloc, but it only attempts allocating
> > > > - * an element from the preallocated elements. It does not sleep and immediately
> > > > - * returns if no preallocated elements are available.
> > > > + * an element from the preallocated elements. It only takes a single spinlock_t
> > > 
> > > Might it make more sense to say "It may sleep" instead of "takes a
> > > single spinlock_t"?
> > 
> > May sleep usually refers to something that can not be used in an
> > interrupt handler.
> 
> Gotcha. 
> 
> > > I feel like the fact that we take a spinlock isn't the important part
> > > here (especially because we always drop it before returning).
> > It actually is. A spinlock_t can not be acquired in hardirq context or
> > when interrupts are explicitly disabled via local_irq_disable().
> > Therefore you should use the function in a local_irq_disable() section.
> 
> As someone not too familiar with how the locking intertwines with the
> scheduler contexts, seeing something like that makes much more sense
> to me than seeing "it only takes a single spinlock_t."

I am not too happy about this wording but I don't have a better idea
either. However "may sleep" is too broad. The spinlock_t is at the very
least documented in
	Documentation/locking/locktypes.rst

Sebastian
