Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964123;
	b=lOEZC4daVX3llMz6LONUg8O3VfWFcVDbJQhejSzw1njtE+X+UzqwF5GFIhPh33z09j4n
	 NBSDBr3x0B1Z3cbjQyoTraCEWqino9o2RP0Nd0Q3zqn212p4ildgI5z9nM0wbDbi/ftp/
	 7oCtTlWvt7EGJ9myk6nD3lVC/obLGKCR0T8GI5Fu1tkXWpHulEafDSUx/1HaM4YVld8jM
	 yWI6kGcddlOI5O7v4Rj0TTXT2A013AeQWKm+i4FjHpmdVfvN5nMn43r/MzDI8e4OgQ8Vr
	 ZJRyMTh+V/AS+izSWmvVqTN5BYnN4Cywzrl1oALi7/oEVBUtq5tzajYkCieztEwiJoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964123;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=13wYao7SgdJMFoNQ783acf3BVZUk+vlJR+o0bsh4/zI=;
	b=q+xWA/4qnQu3c9g7yhIrJkjmvCZSh27iFc9Of0bE6IU2pzc7vvU99fYTJjnvYf0+v6Q+
	 7YgLLx80Z8XxNkVSQ+5pVwJIu7ET2n++BOfNmaCm5iMLzu7G7g9IJ5HTPbhhOJvK0a52U
	 gsvny+XoZNGmcvTh/OjuohH5ydwM1X+J2cEyuQwzU0tG54o+MKkCYJfVCXQbzReltCcxW
	 60l5lW3Z+h+Q4Wt3juHqbKew6sKta776QBkPzR55IKOWpVbBVtFuoIxvBH3uTanvOu9mE
	 A2kk+Ukpj3dTteW0LR4yQoBa867aH0PWcR4AVfBIEotV9uyU3cAjtr73mdIQ0UMOpEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="4tAA/rN0";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gpc4LAiM;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AC606D80B
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 11:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE1AC606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4tAA/rN0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gpc4LAiM
Date: Fri, 6 Nov 2026 12:21:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793964120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13wYao7SgdJMFoNQ783acf3BVZUk+vlJR+o0bsh4/zI=;
	b=4tAA/rN02tM8q9N8U7ABvGBYdC7XxtVB5CXDihapFj6aS+jDFV2P5zRpqUa9F1JTqkXy7k
	In7WKEOL+i+H4A2gztCajpilXRc2lqU1OO0Yut5ZYJfd52x2HIFEp47wQaFxraEkmPUUms
	+9bH+WFe5UzPKQc4d7fzVJrlatdRl5yHPmmEBrj7PBAhlw2PVJ37IKIrfe/Nx4OxPWZzMl
	akdWQQyq3j6yk/UMXzuh8sM2RtDqNkEo1r51HI2d6vC1oy938S9N8RUkHYMsLiDRKNYzWg
	Rkl70qNOlP/TnRA+Vr07EjxKxJP+52hOqSoUDubOSaBPerJBYQoTyDe/uJ96tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793964120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13wYao7SgdJMFoNQ783acf3BVZUk+vlJR+o0bsh4/zI=;
	b=gpc4LAiM170jpseJlsCV0GRERdEQirPpS6mahNdPKPJ2BLabYPn1vhP5OfJ4QE94PlmrJ8
	unqw+qPeN9W/RCDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-rt-devel@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	luca abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [PATCH] sched: Remove CONFIG_RT_GROUP_SCHED
Message-ID: <20261106112158.-VI88lZb@linutronix.de>
References: <20261105164724.yxONBd03@linutronix.de>
 <auy6nyTUuHBlgrV_@slm.duckdns.org>
 <20261105193010.tXUDDu2w@linutronix.de>
 <20261106105003.GU1813469@noisy.programming.kicks-ass.net>
 <20261106110435.5MWA_4Hw@linutronix.de>
 <20261106111213.GG1779021@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106111213.GG1779021@noisy.programming.kicks-ass.net>

On 2026-11-06 12:12:13 [+0100], Peter Zijlstra wrote:
> On Fri, Nov 06, 2026 at 12:04:35PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-11-06 11:50:03 [+0100], Peter Zijlstra wrote:
> > > On Thu, Nov 05, 2026 at 08:30:10PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2026-11-05 07:19:27 [-1000], Tejun Heo wrote:
> > > > > Hello, Sebastian.
> > > > Hi Tejun,
> > > > 
> > > > > 
> > > > > I'm not against it but wonder whether it'd be useful to do it more gradually
> > > > > so that people can pipe up if they depend on it. ie. Mark it deprecated and
> > > > > put it behind EXPORT for a bit and then BROKEN before actual removal.
> > > > 
> > > > I would be surprised if this is actually used especially since it is
> > > > cg-v1 and v2 is the default/ used by everyone (?). 
> > > 
> > > So I would love to actually delete this. But IIRC there were actually
> > > people who used it.
> > 
> > That would mean that it is working which does surprise me.
> 
> For some definition of 'work' :/

despite that statement, no removal, depends on broken, anything? Just
keep everything as-is?

Sebastian
