Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030847D93B
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920721; cv=none; b=CLju16neqzOgapKjKeS0HxCJ4LiHNVpUyUO5LdUQGzDlRXsQqp7ul4VY9TlUnsPsO7fpCFB8Lr4JoDVCOyFunGpoQMixDuj9ZFnky2cn5z7vfQx5PCjNxZ67m/Gzh331I23UzjCxRdQEq9pKid+Mr3HxMI/+MOkR1EqwDY//3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920721; c=relaxed/simple;
	bh=4O6n6u0EOMzAWVyfuIjhmb0+uGmCwSvti3x0j2EronY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq32pxzLUrcxT8/nH2H1HqnNrfOAo7jccOKGX86d9RcXJy4vZSgxO2LPaYtVrlc7WVvF8RzAyha3TxWNO8CPgYz5phGE+adKmx9alcwPQ44soA4+QPT0WqLZIxSgWoanxtXhcmQMe4vCcO9ch4HhmvontOsxCA344KnPYBGhh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nb9tsEWK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oxw1OKyV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nb9tsEWK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oxw1OKyV"
Date: Wed, 1 Jul 2026 17:45:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782920718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz5N1mE7XZfvCLQWT4TJ/awmtfRtTz0aSf19PfVBnh4=;
	b=nb9tsEWKA0mcw/HnGLNNX4lt9n+oZ1kP6qdz3kiIotTtfJfK19a/W+WF6uv9wLcgmdfQcc
	laCPlvJI86/ATcD6EXktv2J6vvJOfDBXwBbIptD1VHb46Hol/dbCOUIuynql0x8S6HzZ0u
	3NsAqkX/RV5ya5EiCUfsEM9wY6l5GmWhKwIkHrKK+HNgw8WHNpmZEkcGc5s6rSbVj836zN
	g4LTOQYD8IKTti8J0heX3k76PHPMP2DGbHYpi6lFIBbcCOpoY7U8OdegwzvyoH/Mb8ijlP
	fyqxnCAtsXqr7t7iagvQ9yV8C9N93eKE4NhJ0G4oeo8gZhNo5AZqbXfSGfjEAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782920718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz5N1mE7XZfvCLQWT4TJ/awmtfRtTz0aSf19PfVBnh4=;
	b=Oxw1OKyVI43eZ/CkBnJfbfhbL7E69plo94NhCownvVnjJBdrjBPhgRkxodbgpdE8bGtB/y
	XfWE+JYouhT2+KBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: [PATCH] futex/requeue: Revert "Prevent NULL pointer dereference
 in remove_waiter() on self-deadlock""
Message-ID: <20260701154517.0u_G4dkO@linutronix.de>
References: <20260701131150.0Ijhq4Dw@linutronix.de>
 <87h5mipwa6.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5mipwa6.ffs@fw13>

On 2026-07-01 17:25:05 [+0200], Thomas Gleixner wrote:
> > That has been already handled by Davidlohr in commit 40a25d59e85b3
> > ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")
> > and requires no further acting.
> 
> No. If the self deadlock is obvious, then this should not even go into
> the proxy lock code. I clearly failed to notice the leak problem, but
> reverting it and relying on some magic down the road to handle it
> correctly is not really solid.

Davidlohr fixed the issue that has been fixed again. We don't need two
changes for the same thing.
We have deadlock detection down the road, why special case it here?

> The below should fix it properly.
>
Sebastian
