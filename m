Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB1390CAE;
	Mon, 20 Jul 2026 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784531821; cv=none; b=YNtNvMWTrgpS8DALVKOMZU26sLxOgRHUMtITpZwAmWvXqo2jxHFsk9Q9no2e8I3d53U7rpBxkegoYbOqoJoemFE8cgY4lZZ3Xvwkgg8VbMSASlLN95KoU274lwwlAuFiFXBWyxGKlm/+QqymazqFicSMLabXWiWyqU4YAb3c02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784531821; c=relaxed/simple;
	bh=epsTS/jP3psX3vbmk99EJQIjXfSYyKREinlzgEFLLkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qD2+bEddju1YZskwCGdiEl1Wzj0BaTwoYJl88o1PktXkA9vNLTkdtnKm05I1QXaapgVWdaw62c8tL0QvQCqNI1uMJrBRhhAmINqO9mJ6oHDqAZUavHo8JlYYNrb84dRDPwvJSx6BuTm2c5R4Ep4tMYCGSudALD0nqkxdlRBGLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xVhqwbFd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVcA3nNE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xVhqwbFd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVcA3nNE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784531818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ay563GPbUHJfxO2/V5nNeoqveZV7Mrck+0g2v7AhyZo=;
	b=xVhqwbFd9leTBosbj0oUgV/HllvotUr4LvRttIrQAmcrADVcnRMEwAh2R4JsqHNLs6geh6
	x/NEcGOUACojOzN/jjbZr5m1stDJ9UjGqXjxFG0YrWoJM6VC/0CH0gjwhxB11i/B+Hm2Kc
	hM9D7HQiUm56dUOQlrGakeNokHLj7BuSMn+vHrjazgUlGniEeblqcTuoZpFYbM1qwlbENv
	XYkrn0uRsWM3FBVSzIyCeH49fluYnfndHmE7QWheWSw76Qo8+9jIg2wIbyS5bTNuhKEfo5
	3+qMA1vXBbE9UFiYpIqflieKVKVLCtZAJ8Pr0x3U74GqUt8a/DAui4nhHr4+Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784531818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ay563GPbUHJfxO2/V5nNeoqveZV7Mrck+0g2v7AhyZo=;
	b=qVcA3nNEEzas3I9aASe5JzMhl7WMSZ+FJzWMsu3LcYQqEsJsFNerLhYAjHr7qGmkhM4d3e
	A1uGALnMYoe/4zAA==
To: sashiko-reviews@lists.linux.dev
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next v2 1/3] af_unix: Schedule the garbage collector
 at task exit
In-Reply-To: <20260718062736.199E41F000E9@smtp.kernel.org>
References: <cover.1784268931.git.namcao@linutronix.de>
 <d500ff36af658ad412e5d6f8d5665070359ef68e.1784268931.git.namcao@linutronix.de>
 <20260718062736.199E41F000E9@smtp.kernel.org>
Date: Mon, 20 Jul 2026 09:16:57 +0200
Message-ID: <87cxwif7va.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:
> [Severity: Medium]
> Will this race with concurrent task exits and leak cyclic sockets?
>
> In net/unix/garbage.c, unix_schedule_gc() only queues the work if a garbage
> collection is not already running:
>
> void unix_schedule_gc(void)
> {
>         if (!READ_ONCE(gc_in_progress))
>                 queue_work(system_dfl_wq, &unix_gc_work);
> }
>
> If Task A and Task B exit concurrently with dead cyclic sockets:
>
> Task A calls unix_schedule_gc() and triggers the work, which sets
> gc_in_progress to true.
>
> Task B then calls unix_schedule_gc() while the GC is running, observes
> gc_in_progress is true, and silently skips queuing the work.
>
> Task B's newly dead cycles might be missed by the currently running GC pass.
> Since no new GC is queued by Task B, won't those sockets stay behind
> indefinitely until another unrelated task exits, defeating the purpose of
> the patch for concurrent exits?

Yes, this is a pre-existing issue and has been discussed at:
https://lore.kernel.org/lkml/871pde3o54.fsf@yellow.woof/

The solution would be removing gc_in_progress and always calling queue_work().

Since this is not a critical issue, I would fix that after this series
is done.

Nam
