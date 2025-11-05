Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012F261B64
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Nov 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333843; cv=none; b=KQbJf0XtJ1NjFM6yqgXiZXtEX+sUGfdpFjv2jKzC7Qy/ZLxWKg7I0uXKe298ap+ofNTD75lz5jLoO0poAXZNOFEJ97D/wvmJ36unAx//hLntVBZJtGj38/HwNm83GkUPKPSnbhI+li6YiGu8rMqamaqW82B84kFiBibzQsCM6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333843; c=relaxed/simple;
	bh=jSnonxPzHC1PeQUdXgsYKGfrm7afZVKnjvhyNLdHVBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GEg5VbQs5MxDU2AZLNbO0eT20XMbOf4pA4ApTCujojt0U7bB4/r6o95JvMUxk27mj/dKtC5biA21AFwKHBaNVDhmDi3FPd+hj385vE5fB1Krogyxzm4unzp73T334piVyZ6P9eQmIM0cuoYJWnd5XlkgB3HWeJRZSE6I9bEuuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=intYdcj6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRs+xrS9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="intYdcj6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRs+xrS9"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762333840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UCSLWqtet7bBD/KyvgRgi8v8pWDdnoQfrPmGjMa080U=;
	b=intYdcj61r9EuH3nnkTUQyjG937ZTpYIuGuZQllPhaThC8Z7H4u6sy1uI83qJJDgve/ef1
	bs6pD1HDLSPVvzSM2NOOqY/Se8NP/8I7gfB2wFpHdBE0z4WLID79l7H9GFlLQWDE/8e9jU
	iPMopG5zWfFg1KbIulV7gwM24AJpweSCBdbGpFWcaIjS/jzx3bWKCjjxAnBc6/nb5lZgoO
	d6cVICr1x8Nx4B3H21PjDUfSFJM7xn4L4Tr8/gI4Ei6QzP35o9qP55lT7epVJOJWiGMEXH
	z1UZ8N4zyFBpMQMRT79AjAVgRFaC89b3SEqbxZI75k3QqVrr6wdLECJAeuSjQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762333840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UCSLWqtet7bBD/KyvgRgi8v8pWDdnoQfrPmGjMa080U=;
	b=yRs+xrS9DIT4h5tPHy8tapqZlHCmRrHGQ3+tis85U3GBLP/YoBr3pNN2bU5jVVzhtb8frp
	eQguPf2Ral9oC/Dg==
To: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <nam.cao@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, Byungchul Park
 <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
In-Reply-To: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
Date: Wed, 05 Nov 2025 10:10:39 +0100
Message-ID: <87fraslu9c.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Yunseong Kim <ysk@kzalloc.com> writes:
> Hi Nam,
>
> I've been very interested in RV (Runtime Verification)

Cool, happy to learn you find it interesting.

> to proactively detect
> "sleep in atomic" scenarios on PREEMPT_RT kernels. Specifically, I'm looking
> for ways to find cases where sleeping spinlocks or memory allocations are used
> within preemption-disabled or irq-disabled contexts. While searching for
> solutions, I discovered the RV subsystem.
...
> Here are my questions:
>
> 1. Does the rtapp:sleep monitor proactively detect scenarios that
>    could lead to sleeping in atomic context, perhaps before
>    CONFIG_DEBUG_ATOMIC_SLEEP (enabled) would trigger at the actual point of
>    sleeping?

No it does not, as explained by Gabriele.

I am a bit confused, because CONFIG_DEBUG_ATOMIC_SLEEP seems to already
do what you need. CONFIG_DEBUG_ATOMIC_SLEEP does warn before the actual
point of sleeping. Sleeping locks and memory allocations are marked with
might_sleep(). When they are called in atomic context, we have a warning
regardless of whether actual sleep happens. See the comment above
might_sleep():

"This is a useful debugging help to be able to catch problems early and
not be bitten later when the calling function happens to sleep when it
is not supposed to"

For sure you can implement this functionality in RV, but I don't think
RV can do more. An advantage of doing it in RV is the ability to toggle
at run-time, but that's a different discussion.

> 2. Is there a way to enable this monitor (e.g., rtapp:sleep)
>    immediately as soon as the RV subsystem is loaded during boot time?
>    (How to make this "default turn on"?)

At the moment, no. But if you need this, we could look into implementing it.

> 3. When a "violation detected" message occurs at runtime, is it
>    possible to get a call stack of the location that triggered the
>    violation? The panic reactor provides a full stack, but I'm
>    wondering if this is also possible with the printk reactor.

You can use monitor's tracepoint to get the stacktrace, as mentioned by Gabriele.

> This led me to research ways to find these issues proactively at a
> static analysis level, and I created some regex and coccinelle scripts
> to detect them.
...
> Tomas, the author of the rtlockscope project, also gave me some deep
> insights into this static analysis approach.

RV is not a static checker, it is a run-time checker.

Just in case you are not aware yet, there is also Smatch:
https://github.com/error27/smatch. But I can't offer much help there.

Nam
