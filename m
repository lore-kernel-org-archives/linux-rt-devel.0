Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A945A2B4
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307726; cv=none; b=QcAYGSMpfekH0w0fNCjJYo1IsJrg+m3lhJLmkIaP1Wu+2aFD5UrzaXKKwRywBqwhq9Y771yTiNFuz6iJzafzsQ/GatxxeoPAoOlIcXVe/Ek0+bG8+jLsS4IBwZzaAHT6fT2TYtr4zVtM+BpvRS5bjvU3rE2idkcgilcvaBXYo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307726; c=relaxed/simple;
	bh=D7T3UtfflhoV2G9ZIgMDtKiT4UqcnH0ou93lxokpoWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L31Rwx1Lz8OTp6+1RmI4rPwKgV+jTBOPXNLWNxGghAbCkAwkh2Gqvdys2ASriw4ePOBWea0mmMAyX+OpHX0szh9X1ZB/xLoSEQI7KkLSlE/HICMGWzQNrZR9GgzHsV9S3K4IKTzaFdurhru/WCyePUeLAPQKHVbfdFZHzXu+Sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3aJjfDLC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BeJbw+0H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3aJjfDLC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BeJbw+0H"
Date: Fri, 21 Aug 2026 12:21:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787307719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eW4cW54k5WlLw//T8YhelMs6IrRZ4Y3oLGOQrsQ7L7A=;
	b=3aJjfDLCihf6RfOFDJFPcW3dSAtPzzwN9Ia3XV7Op3gfUlQOWJZg8+KbMPaoXD6JGVaYN6
	bAECglAtH4mJV8qxWhq5BKDx7E3+HQeE404XsZbv8I3L+uBBJP7XvsKoU0tHUaj8zd+q39
	wZ7rYtDbcLLMtVMzzaDROT64YGCC+dhqCFkBKb1NEWUhtIj0lkelpq6YaQ5+Galpgvk41M
	m8hggZoA9XjMCLofnkKsdh/89dXsz/oPha3JQfy5qzo7EwvAcyglwrWPDATwTFU3y+HSKG
	HQjOLhljE5LJljQX0SHLZuhycIiLCJfEKKvazYEh0Sjqecxplp80HfzsId0Keg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787307719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eW4cW54k5WlLw//T8YhelMs6IrRZ4Y3oLGOQrsQ7L7A=;
	b=BeJbw+0H2ibE3IOwqo+DASGXPh2pzpUnyTTblMnyFZYa/8Vw3HtUnDXFbQdLt8og7J8dWj
	i3DcX6bc80uUvJAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <20260821102158.dKDBLZH8@linutronix.de>
References: <20260820110008.v2Tlr0_H@linutronix.de>
 <aob12RahomSmpUQY@localhost.localdomain>
 <20260820135500.hXUAsbHR@linutronix.de>
 <aoeG1BhFsTV2T_p4@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoeG1BhFsTV2T_p4@pavilion.home>

On 2026-08-21 00:59:32 [+0200], Frederic Weisbecker wrote:
> > Urgh. irq_work shouldn't become a widespread user ;)
> > If the scheduler is up but irq_work thread is not yet created and the
> > irq_work uses sleeping locks then it would create warnings.
> > In testing right now I see just wake_up_klogd_work_func() which is
> > always LAZY but would qualify otherwise for a warning. We wouldn't
> > trigger anything yet but you get the idea.
> 
> Fair enough! But should we warn if a non-hard IRQ work is queued before
> the kthread is created?

It is not a problem in general. So for instance the printk thingy is
enqueued and is invoked later. The wake up can be delayed. There is no
need to trigger a warning here. There is no dependency and you can't
know that.
The difference with SRCU+tracing is that it first starts a grace period
(the irq_wake from SRCU for tracing) and then expects the grace period
to be completed (tracing). Even before SRCU is up, you can queue
callbacks or start grace periods, etc. This is handled once everything
is up.

> Thanks.
> 

Sebastian
