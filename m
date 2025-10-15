Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4E318156
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Oct 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556442; cv=none; b=sEEoXI0Wjj3ilzc2+kI0KMST/tZHjAi/LyX0pdu1JdeXi1mE7fF4/b4aGpelBk6T862Z+QwQPkETVLGTQ09dLwdfGvB/1+70nY69aPF88W3PChV3+qK0x4VyExXwDw9Xvac7wr6zpvFot3fV4wskYbcFkbV4NmayxsxMov4U92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556442; c=relaxed/simple;
	bh=b7+VVKuQt07nzlyEQz2RWm1WHImBaM3oaudzfFp4l8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WguZjUlVAP773VRjnD2XGVIsFlgFMdVpdsv+8aA2i+agVXI5m5TLHN4d5q5TNg/sA40NxaaRDjV6zlwUTV3fa6cdMV3Ooj6XFKyhlCBFBTaYrUVdx9nzw07qH9aM5QvcGuDz3lZMNpvbewf6PD7TETjX0mp9dcvusu20H22TBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xh+i9IUV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uxd0icnL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xh+i9IUV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uxd0icnL"
Date: Wed, 15 Oct 2025 21:27:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760556438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWtiYUPlnQw9OtpmC0sdUUXx3SYzXSM1Q0xsiYsFZNo=;
	b=Xh+i9IUVqRb3vPqw82EPo4YL+Si/vG4jdJ39jG480GAqiXK/6Iw/zC+FHSJ1b00Tcc8Qhf
	z9DClQzxp8L5Vnn1AOxJKiMQkMPcG5jSYMlbi4eSbRfdzmYyU5V+ddaHev3z9nMGCl2Jm8
	pdjJXBlTwhtljL+6ozc0MIossZcAPwRkkDqrQc9EJtF/DqEXLokwYtGrrH6mgffKDK2F3s
	ANt7WHWyvkf9TpSUbjn98qhhFB674qCrPiU4N1apS/jMmvezTOeGTg60dbDAUPoyqv7LGf
	Pue1VsbiK7FAk6qrFdnytHdyUlO5FVTT1vTrmXucB6FBH/V5sgz3ZRsxkSLlew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760556438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWtiYUPlnQw9OtpmC0sdUUXx3SYzXSM1Q0xsiYsFZNo=;
	b=uxd0icnLjLD+M6AEofEoOm/uV3l3o88dWkR6JQyvg4e5o1D3QzonjA3gi85qdBfxwhk2pK
	pXHx4lbAX4YOBVCA==
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
Message-ID: <20251015192717.HvwzCChE@linutronix.de>
References: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>
 <aO_taH9CKxmJPnhV@fedora>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aO_taH9CKxmJPnhV@fedora>

On 2025-10-15 11:52:24 [-0700], Vishal Moola (Oracle) wrote:
> > --- a/mm/mempool.c
> > +++ b/mm/mempool.c
> > @@ -461,8 +461,8 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
> >   *             mempool_create().
> >   *
> >   * This function is similar to mempool_alloc, but it only attempts allocating
> > - * an element from the preallocated elements. It does not sleep and immediately
> > - * returns if no preallocated elements are available.
> > + * an element from the preallocated elements. It only takes a single spinlock_t
> 
> Might it make more sense to say "It may sleep" instead of "takes a
> single spinlock_t"?

May sleep usually refers to something that can not be used in an
interrupt handler.

> I feel like the fact that we take a spinlock isn't the important part
> here (especially because we always drop it before returning).
It actually is. A spinlock_t can not be acquired in hardirq context or
when interrupts are explicitly disabled via local_irq_disable().
Therefore you should use the function in a local_irq_disable() section.

Sebastian
