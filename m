Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58434F483
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899747; cv=none; b=QpC2c3XobWi5JwUfOk5BZi2Arnn7YmMIr9WhwheFA4mo5e+PLwwFHcnasYDobn6W9uMhYBzL4T3kKvRR8FGqmue+xiHemg6LBL4XvJ9q8hWb1vj/arcXci9kJ0xYzme6HVUwjrP27YMeb4M1YsNh1BCzsdMLvYLhl1WxqxrL5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899747; c=relaxed/simple;
	bh=vXfa9b49aNfOSx+xd87n50+mFdnZ7fTcwEZmIwRHSp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpK200a5zhLkb5zPWIsrrElEA4tLhbAW6bSMF+oicGw0+xnpnSQl9XGPOIWt1z4RwAcFZa9eX7eWosq3B95YmKlOgpajjQawkrVF8XP+6it/quUm1B+VjQBZVWGPGx484xntpm61aNHIqVA1dSGzUYoX1DBbthi0BfixtidQBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=spNXDWCa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0pwwhgfb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="spNXDWCa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0pwwhgfb"
Date: Mon, 4 May 2026 15:02:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777899744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Moq1AIiOY6+orwYxMHjvFbcg9N4LBlAImmAeoGhrj5U=;
	b=spNXDWCa/87xl6MVwQ+Dr4qbInoxlOSNcGpCd6wYVejRuWHJmjCCuiDI8u8/0TTEc3ytin
	ZBIJbSp+1K71moeIcbze+owvnsblycgmlXWFwbmbpJaTKYFgsfIcn/1rRgjGomqfIpB+SS
	S/q2ZEGl29/GfDY+9dxzk+AeLHPBGrD7tKSq0ZhporDq6dYU7/aL8JJjGjMHlvGUdcIV/K
	4S7kzS+4SV9VNr6qotx20jLff3UQiQdS56zmIwWul9/CVIiBbm9RX3vyQkMamf+4NyqWIG
	SjlKpCeFGIkdLyaqZzzx+Dzr4xa3/ySf2GkH4vYLL+YNsi2jGIuAyWK18deIMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777899744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Moq1AIiOY6+orwYxMHjvFbcg9N4LBlAImmAeoGhrj5U=;
	b=0pwwhgfbSbZsc8jITdy2fydwmEAIUl7Ux0lFx4JCdrp84CyqqJA1ltrHZ9jm9cppJs3rcd
	S/to1I709Y4n+OCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/4] lib/vsprintf: Always check interrupt context
 restrictions
Message-ID: <20260504130222.5BAuYwxV@linutronix.de>
References: <20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de>
 <20260504-restricted-pointers-final-v2-4-4934933503e5@linutronix.de>
 <20260504130044.GU3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504130044.GU3126523@noisy.programming.kicks-ass.net>

On 2026-05-04 15:00:44 [+0200], Peter Zijlstra wrote:
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -871,6 +871,10 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
> >  
> >  	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
> >  
> > +	lockdep_assert(!in_hardirq());
> > +	lockdep_assert(!in_serving_softirq());
> > +	lockdep_assert(!in_nmi());
> > +
> 
> did that want to be:
> 
> 	lockdep_assert(in_task());
> 
> 	?

I remember halfway suggesting that. But I also wanted to poke networking
folks to get rid of this which I haven't done so far :/

Sebastian
