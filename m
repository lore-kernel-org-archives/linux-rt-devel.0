Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32537E317
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239244; cv=none; b=CSERTvbVMBZ7oZtL0y6vuA7iBMZmPnwbmuSBpS2Nvuobutb6kZNretnlGjOZKPWFyTPMO35nKtuVg+LnxaXffjxaCu14QN+LgVJhIBUxUZz+ESbDhBcxY94Y9ZER637Ra57akfRd2sFNzJ59ynuDQA7Lp+NTxfTP5NdjTnLJkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239244; c=relaxed/simple;
	bh=uO0yHBbW4NFOGcdG/4kflmmtqX0ELaA9M6ePpTV5n5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nehmIuMSjRU8vmfVLsr8Hn8IE9effxPdHXKqbfSQ3SPfKbZD3LrouPvy7lqUurVygCenjKQQYurO2vd3k/F2u/EZk35kYd4Y4NPjd5XPHeQ0PDa3om4tOI3r+BroTEJhKVXg/CIU3l1aWYuPpdejAn0jvvfK44iCP9M1CioIKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C9DA713BD10;
	Mon, 12 Jan 2026 17:33:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 196652002E;
	Mon, 12 Jan 2026 17:33:54 +0000 (UTC)
Date: Mon, 12 Jan 2026 12:33:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
 liangjlee@google.com
Subject: Re: Regression in performance when using PREEMPT_RT
Message-ID: <20260112123356.5bc120b6@gandalf.local.home>
In-Reply-To: <20260112152702.-73BFhnF@linutronix.de>
References: <20251226110249.0c2f1d8d@gandalf.local.home>
	<20260112152702.-73BFhnF@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 196652002E
X-Stat-Signature: saka9igbyhgkpnz3jjk9boj886j4h4zp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX189AImW5+ksEVsAGftLwalSpyHttoZ4w58=
X-HE-Tag: 1768239234-329354
X-HE-Meta: U2FsdGVkX1+2ETPEeV3gQKrarwsMHe5iEoL151Di86OHuYO+72gd/RrIOM8tLEsVG8qlWa6KIWLsmal3UwMygNchhpzNfWvDjxQdWvYDOEgS9fvHash68C5PEYiZbyNl04BXBGqRM6OSD78PH/UF0TAYrIlU2Yf3BkBZQdi3qA1cwwxiIxOX17EUqfAg1ZlMsjYgDkK2Rh6jW1OyBL2A59SWvBRjd4cro+UGpfp/ThXsprkAxLYfMpQqFxQFL+dN3sOEPvqyUjZmcD5rfw5O/UUPuHvHFhBmxvErGMtdmRVFVI+e1zJ5oO7abzKxkKKq

On Mon, 12 Jan 2026 16:27:02 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:


> If I remember correctly, it completes in the context the
> threaded-handler. It only does the remote-IPI thingy if the queue is
> assigned to a different CPU than the CPU where it completes the request.
> In your case it seems that either the device has multiple queues
> configured and just one interrupt or the queue is configured to a
> different CPU than the interrupt.
> 
> If you have multiple queues but just one interrupt then the lack
> distributing the load is unfortunate. If the queue has been moved to a
> BIG CPU then I suggest to move the IRQ to a BIG CPU, too.
> 
> If you ignore the statement and allow the remote-IPI to kick the softirq
> then the request ends up in ksoftirqd on the remote CPU probably
> accompanied by a warning. Here it runs as SCHED_OTHER and competes for

I'm not sure it triggers a warning. Jack, have you seen that when you
removed the force_irqthreads() check?

> CPU resources with any other task on that CPU which different than
> softirq on !RT where it has to wait until other hardirqs complete.
> The other thing is that if something "else" is busy, say a
> threaded-interrupt then it will pickup this request (before ksoftirqd
> had the chance). The result is that handler now does the I/O at its end
> instead ksoftirqd. If the interrupt is important and has a higher
> priority then the average MAX_RT_PRIO / 2 then this block I/O might
> disrupt its schedule.

I'm not sure what the affect of that would be.

> 
> I think moving the interrupt to a BIG CPU (as the block queue), if
> possible, would be the easiest thing to do.

We have done that. It appears that the hardware simply picks the first CPU
it can use and *always* uses that. By setting it to a big core, it did get
some improvement but the problem is still that the softirq only runs on
that CPU.

> If the hardware restricts it, I would suggest having a dedicated
> SCHED_FIFO thread for its duty would be better than an anonymous
> catch-all ksoftirqd.

I think the solution may be to give up on PREEMPT_RT if that's the case,
unless there's a non PREEMPT_RT reason to make that change.

To give you an idea of what the issue is here, it is the distribution of the
block softirq (even when the irq itself is always coming in on a single
CPU).

 cat /proc/softirqs | grep -i block

non-rt:
	BLOCK:          6          0          0          0          1          7     162986     164750

RT unmodified:
	BLOCK:     329875          0          0          0          0          0          0          0

RT without the forced_irqthreads check:
	BLOCK:          0          0          0          0         11         15     164116     163619

-- Steve

