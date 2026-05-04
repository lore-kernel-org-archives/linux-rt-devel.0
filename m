Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2F3D75D5
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900807; cv=none; b=iIV7EL+p6gKmpzpbPNgDkiFCW+nM0oVc/QrKw7rFQLKj/9/mi00CcWRu6WETygl1sDSgcm8qm4+uo5/wyaep0w7k/qRH5dCPC8ozI6tAkzM9prDVc/ARWRaNwPhfmMHB5ftWHHO0jKsJGwy2FB1Kk7n1WRVLLv+9xfBxUdCyQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900807; c=relaxed/simple;
	bh=uwoqMZiA1JwzvSOs8CNeN9TFEkIOO+JpC9s66vD6BlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTEFGOFHcVBEyAHZuDY04Wg+abMsu96925K/8H1SqjNgo92hZogb2zw7bprPMQi8JqGak7cI07Wp6k96YY/JQ23ZzFPKIp/WOL/HOK67P9OZtapiSjk6flUqLfrVuIYypTPqqelmsORtYpQj2Nt39gazQv4vj6Hnj1fj30Zzwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2+0XkuB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7bFumLoy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2+0XkuB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7bFumLoy"
Date: Mon, 4 May 2026 15:20:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777900805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23zNFjVXp5emnZKvzMsQJyph8oZyyMwB8MZByKV2FPE=;
	b=c2+0XkuBwACRjziMyFO/Ocwbe2IBYHYPrNXzXDCPNaaA8W+kKcm0BG+KO8YEBAPnoxL9kt
	Ym2PvGYPLBYkSvyBinsQzP5iTFvrS/lxlehAK70JUTUfpHOeybyl+BdRPRbFpF2oeDEUVq
	KYR//AHr6o18Vhnu/LcJh1DbKhWBZc9yjjl8ofk06OuPniIJsOIF8jGSicc6+vzgUZYR96
	QPNYlFyqJC3WtSWAFyeyVKnwIjfV5x5EIjN984bjMiD1H3lklBiKGbAx8dUVh02Fq9jU6z
	Cn1c2Sd7S7m8zWRXPqV9SrZdP8Cpgtjoen8PKx2ieKApb5gLdQ59zMTWjLOQVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777900805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23zNFjVXp5emnZKvzMsQJyph8oZyyMwB8MZByKV2FPE=;
	b=7bFumLoy7Y843Ged7kqX6g/UL9TplzoqFSA88WtIDNx0+D7Qjo2fEK06zILzQXKUkEocj3
	w6MVEPZHKkHBYCCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/4] lib/vsprintf: Always check interrupt context
 restrictions
Message-ID: <20260504151430-78d11666-d263-4d98-8d13-4f69418a4df1@linutronix.de>
References: <20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de>
 <20260504-restricted-pointers-final-v2-4-4934933503e5@linutronix.de>
 <20260504130044.GU3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504130044.GU3126523@noisy.programming.kicks-ass.net>

On Mon, May 04, 2026 at 03:00:44PM +0200, Peter Zijlstra wrote:
> On Mon, May 04, 2026 at 12:47:20PM +0200, Thomas Weiﬂschuh wrote:
> > When kptr_restrict is set to '1' restricted pointers can not be used
> > in IRQ context. As kptr_restrict can change at any time at runtime,
> > this means that restricted pointers can not be used from IRQ context
> > in general.
> > 
> > Add some assertions to detect misuse early, independently of the
> > runtime configuration of the test system.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  lib/vsprintf.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 021db95087fe..185bd9e61144 100644
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

Primarily it wants to be the inverse of the check further down the function:

	if (in_hardirq() || in_serving_softirq() || in_nmi()) {
		if (spec.field_width == -1)
			spec.field_width = 2 * sizeof(ptr);
		return error_string(buf, end, "pK-error", spec);


But in_task() looks like the better choice indeed, thanks!
I'll switch both locations to that for the next revision.

Unless Sebastian manages to get rid of it all, that is.


Thomas
