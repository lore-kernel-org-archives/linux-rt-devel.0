Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67797263F
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Jun 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689056; cv=none; b=q7wxPREOjAp6TrZc2PriMQJ4VLjuEf584AtNsKxyo6eLFkCTCdwDoSLOwk1EBg9oylJJaQDu8ITAXRpvExbBdleQJeQkUUcPjzW0sYnGjaUVrxt/NvJPVUUCNl2cI4QgpF8b+MnmJcfJ5Lo/A6BAACeDRaoH/1fD7bzbzDSrWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689056; c=relaxed/simple;
	bh=k4ey94IS37L+UFax0w8pC41J0bqKc/mFx3eS2PhQVbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBuylkhhVU4FnZ/JgQ9RkjjSGr8oRcqKoggjoxpIolXN2CJwU2q8i07xEkaaY9Qvsgm45MvMD303y4G4nR/PbAz7f5Cyb/waeS2n5Ky7NwtQUWv0ig20A7A/AoQPBl1rg4pmm0Wi+97BmKLIbNc9j2DAbopwPcWMPppknFQYvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcNbzUzT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HgZuYhiu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcNbzUzT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HgZuYhiu"
Date: Mon, 23 Jun 2025 16:30:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750689053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqUKnV2rshrUszmkgK14mpM+y5P7xCTVJxxCr3ZgnNk=;
	b=vcNbzUzTsPq7DTHDNgjq6HoShb2qs7C/CD31/7ZGV+yxXejs6RqIlNJTD3Ejog/Eqc6NQK
	oAGBLttsanFyJX7IEA4umfYKORdFCN9utMKGsjptm0q8Zqfgl/s9S8Nc8tDsnQ2iwJ+4QF
	axfBLlmIKYbfiwZJWuP13xxEPPvPnFNM8wo1e1hVflaynyCpdLP+7WO0FEqVvGI+Znk66I
	4ZABmDRW9iiNK9jIpdWlzGP1WrMzNn8+9RsmPaJErbIJRWsSDXaUNyKXBXIbj00oGFpA9+
	+RPxTpCAtZXQyyIPjpex+vPvAyAQnRwzG7G+gSDf7zvTYUHmyf66puD9w0xACw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750689053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqUKnV2rshrUszmkgK14mpM+y5P7xCTVJxxCr3ZgnNk=;
	b=HgZuYhiugehK/0m6BXVcF9jsyUDzbse+w08B1E/2TQQ5DI3Ef0SpaLeB1FyAFpEnMTzmQg
	Cxw8cgVv70D2LDDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kegl Rohit <keglrohit@gmail.com>
Cc: linux-rt-devel@lists.linux.dev
Subject: Re: ksoftirqd priority inversion
 wait_event_interruptible_timeout/schedule_timeout/del_timer_sync
Message-ID: <20250623143051.pCoclIs7@linutronix.de>
References: <CAMeyCbgeL-UuxiJPVy_=zLSJfWgudKAvSQVViL8=u05yty_Pyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMeyCbgeL-UuxiJPVy_=zLSJfWgudKAvSQVViL8=u05yty_Pyg@mail.gmail.com>

On 2025-06-17 09:52:07 [+0200], Kegl Rohit wrote:
> Hello!
Hi,

> Using 5.10.184-rt90 on arm (nxp imx6q).
> 
> A proprietary driver starts a `kthread` with `SCHED_FIFO` -98 priority.
> This `kthread` waits for a completion using
> `wait_event_interruptible_timeout(comp, 1000)`
> and wakes up every second to perform its work. The completion itself
> only fires very infrequently.
> 
> Tracing the kernel showed that `ksoftirqd` was periodically boosted to
> the same `SCHED_FIFO` -98 priority.
> This is caused by the `schedule_timeout` handler within
> `wait_event_interruptible_timeout`.
> 
> del_timer_wait_running takes spin_lock_bh and causes the priority inversion.
> This is very bad because e.g. network softirq processing happens with
> very high priority for some time.
> 
> Was this issue addressed in a more recent kernel version?

The timer related bits moved to ktimersd thread (instead of ksoftirqd)
but the basic boosting problem remains.

There is work in progress to address this. The endgame is:
	https://lore.kernel.org/linux-rt-devel/20250613105653.1860729-1-bigeasy@linutronix.de/

Sebastian
