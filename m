Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057602F6935
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414492; cv=none; b=hNtLV73uz8KtfYdY6b6hABXAdrl709/su27k+PE7t0FrbD5qSdUj4o1ssaDxXfQkce6l0RzBE8oxFW59w1pqSY2yPqopg/Krk+bkIeDdrMLk3BexuUBr5FDIadQTaRZMLdXnu6zomgj73jAiJvxUOML8Eu9EhNMHO1RqqbvDDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414492; c=relaxed/simple;
	bh=f59A5o1vN4CEQvytvjCpiycHWQSjuFK8Xl9F5GvJqTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UacWRQUe1cqgCdiPILl0/b1ew7wWckdPXh2ddVqkFi+Yn1ER9b7PAigYqdGVs9oIjZLsQg6LfesEXSFSyPjyXBZE1+OWLAQyy4hkYEEbydJJ+yeOWmw+H/AL1iALLZmUpEbfIBYvPSD3fKC1vM1rtT1cXZvKve4B3PKZy0DaePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNVZtrop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uB/+/pPz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNVZtrop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uB/+/pPz"
Date: Mon, 26 Jan 2026 09:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769414480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixmO5ckIsijXR3o9Y9Ub8ZmZFsHwqWkNhY66q18gfQM=;
	b=oNVZtropLx8xIn30Hhd50l7kIZMTJgkL7lJ7lNcJtzFDrQZWx8+NPsq6Y2CVDFKt3MQ2xf
	nDwnUhz58hWV5Whdg7ZRFyg9+WTrDB75iiv5c4AkOnB6TER0G6NXBq+IZy2s0+tKWIY5+Y
	SSv+zwoWvf4AL0vqI1JAyMizaseJKfi7rz08wJ0WcsnpojBQy9twnvM74CcTP19xjSc+1c
	+y4JvqDoLlFkXbTLE4rmBAgVT9VIev+f7BL8smYG+HktXIxAyj9TeQb4/mRs3s/CaAgV53
	YA7jNSigBVJ80oiV8LETccy+47MNH3l36RcYGAQdfnpFyV3s6KL8laZvrBX9RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769414480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixmO5ckIsijXR3o9Y9Ub8ZmZFsHwqWkNhY66q18gfQM=;
	b=uB/+/pPzce51d7yNhjgs5Q7QKRaM6W2S/x18fHcy8FeG25xB6qA109aKCZw0T6k4QJOYqE
	PLHDAznD8FKu3/Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <20260126080119.AEjgGgaw@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
 <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXOLS_ZP7o0xaHII@smile.fi.intel.com>

On 2026-01-23 16:52:59 [+0200], Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 12:37:03PM +0100, Sebastian Andrzej Siewior wrote:
> > Using a threaded interrupt without a dedicated primary handler mandates
> > the IRQF_ONESHOT flag to mask the interrupt source while the threaded
> > handler is active. Otherwise the interrupt can fire again before the
> > threaded handler had a chance to run.
> > 
> > Mark explained that this should not happen with this hardware since it a
> 
> "it is a" ?

yes.

> > slow irqchip which is behind an I2C/ SPI bus but the IRQ-core will
> > refuse to accept such a handler.
> > 
> > Set IRQF_ONESHOT so the interrupt source is masked until the secondary
> > handler is done.
> 
> ...
> 
> > Cc: Lee Jones <lee@kernel.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: patches@opensource.cirrus.com
> > Cc: Mark Brown <broonie@kernel.org>
> 
> Cc list can be moved out from the commit message.

If I move it out, the list won't be CCed.

Sebastian
