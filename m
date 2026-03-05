Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A234E75E
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Mar 2026 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747120; cv=none; b=bdrE0R7fdxCBYyWXHsGPY5p4LD9Tpon7kABEUNgHmT9UQBj4ZAqU8ZomGQwRygjrNkyaX/0nYeb87UZqaWiT3jS4obDQ5YzfiuSOhTBKCcJvO59SpjkCmimq/SKgSDZrM3N2dPgQUt1k0J/dOlFcPvGS17w5CT+5bzWcc0Dw6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747120; c=relaxed/simple;
	bh=1Buo9vAlhqmAm+KzCR7loWt/SQaWaK3cl4Ka2WMq67M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfmrmMUcVUgRCkMOABZqR6SmhvrI2b1FBk7qnxDCYBNOaY4J2r24jBgTkixsNHu+Ubt4NrLgFzDf5ob0vzL2d+/4Jez1O4giPZ4iclwP0dP7Oa7Ouos3a/FGzOP8nFgJW3GCKxC2Qgk30O9lZiAvMpkm0ytcPxkwexN7wCE/4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TcT32NJk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EeqHCikQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TcT32NJk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EeqHCikQ"
Date: Thu, 5 Mar 2026 22:45:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772747117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6p/JX1Fj2JbUtkVANhZChBGnz22n6wW+j2nV07N3q+I=;
	b=TcT32NJk0CPsjQ+XaRMEfwMYtDbNDek9uYLSjG5ViGYjhKMFXY9NlXGYcz2KVqK1529lBZ
	mDsHj2vOhgPjikBHzvBH779M/XvEKfiePZxGMq5atFYGHcK8iOx3e72bOx2MC60lxG+2d/
	8o4cBnRdmpB6aQJ3VRb2GD4rn9VdArep448xGYL6FQhZOEC6CylM9DsthEhtqAlbpl8J/Q
	KK4TpnNYI/3fJo81TV28HFCfCVktMMbmrlwHR3L2kC6Nhl41c7ANN0E9xlcYxA/vWiOZVL
	6kmuS0ttNf1CZX0q9qc3pwwarGD0nP6WqGs8e+xrNn5iSgF7bB4Dg3jAqAY66A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772747117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6p/JX1Fj2JbUtkVANhZChBGnz22n6wW+j2nV07N3q+I=;
	b=EeqHCikQPBWlCQnKWHkAMooYIpcKJ4+R8bDCmfwMmzWSLHjJ7BzSgBHo28ipbpnk2yReMf
	X37RhuCtVh17nLBw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <aan5a0QPKvwk7HF7@lx-t490>
References: <20260305205023.361530-1-darwi@linutronix.de>
 <20260305205023.361530-2-darwi@linutronix.de>
 <aanwC228bGTa38LK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanwC228bGTa38LK@casper.infradead.org>

Hi Matthew,

On Thu, 05 Mar 2026, Matthew Wilcox wrote:
>
> On Thu, Mar 05, 2026 at 09:50:12PM +0100, Ahmed S. Darwish wrote:
> > +==============================
> > +Real-Time Kernel configuration
> > +==============================
> > +
> > +.. Add a ToC so that all options can be seen in a glance
>
> Is this a useful comment?
>

I thought I'm the only one explicitly adding a ToC.  A quick grep shows
that to be false so I'll remove the comment.

> > +.. contents:: Table of Contents
> > +   :depth: 3
> > +   :local:
>
> [...]
>
> > +``CONFIG_CPU_FREQ``
> > +-------------------
> > +
> > +:Expectation: enabled
> > +:Severity: *high*
>
> Importance rather than Severity, perhaps?
>
> And high/medium/low rather than high/medium/info.
>

The info sections were meant to provide extra info on the kconfig options
w.r.t. PREEMPT_RT.  So, the CONFIG_DRM entry is not of low importance as
"Importance: low" would imply.  I'll think of something here.

> > +With that in mind, any false real-time kernel configuration could cause a
>
> incorrect rather than false, perhaps?
>

will do.

Thanks a lot,
Ahmed
