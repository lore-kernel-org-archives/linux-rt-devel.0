Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E943DC4A5
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453111; cv=none; b=cLiBDMDrSaNrA5PVuBuXh81oz+ExNlf+EkyQCeyaa9yIpGWUcJP2QzDa9uNGpb6UazGd1YwmAjTdqqNLio1SERXrkzC2F9dub9pf6tIma0Nvu9OkwQmXvtocy+BQlElUDto32Zog+IPH6x5vZ/eqYbD5ABndQ/wmzEEfNi3sBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453111; c=relaxed/simple;
	bh=Kody0E3eEHgA2ZKscDSYrcxL7vn2TdzbFApD173ke4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab5rxrOT85u4jl4yfaGLYR5CS4Ert/mCKprJzyLv/PvngLBIX6aWJgO2ZtXXWt+QddHy3XI7mfRrUa6M8RNcR+z2HWWi0znIF9GAOsLVS1TiyyZb1gG4y73SbHQK0gCjlk0gOMmJ7RUXeVV6MYSjKFExo7bKLllGnHXRNP7Bi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GgdF0Yvq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nxg9dy1/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GgdF0Yvq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nxg9dy1/"
Date: Wed, 25 Mar 2026 16:38:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774453108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnNqFjBQrHkj8KRI+erA1rmmzz8d41IzUSmzqozWlN8=;
	b=GgdF0YvqHwVwDlWpleii47niARDz7xkXrEiYpuICv1iu5+V4mjknPlXwp0xS+4PGMcHSJX
	D7c+w2FewtxRp/gC4DyMQyi8EObTmSOcc6KxLtc44EStLmoKid4IOX6bkF6rzOEeKHGQ5p
	T6MpmqqtzBavGMb0j1BNdn/4VeGHfhwHZOrRaJ4tEYA8SgScM9V3x2ARTZxbmmO1FuOmlR
	ZEDhTMGrBJYvPgtfqbxj5NPWJD5W5zL0iHtmBIU7nVJlN+L/EfUb/LHeUjjqB1lCPIlRRI
	vr+gtUr/Q0fZSU4KNN4luk3RyoS6ps8Bz+2lWwZmQCLX7SAD2dYYC2R5RklHlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774453108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnNqFjBQrHkj8KRI+erA1rmmzz8d41IzUSmzqozWlN8=;
	b=Nxg9dy1/CpCwclwqCebINzdXPtfxRuj//k5Y6h0Q1poVWeIfGelJMgx++Vi1b7oZqoYhXZ
	htUQIiTn0iFmNZBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325153826.EbSqlX_n@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
 <20260325111351.1d38a0bc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325111351.1d38a0bc@gandalf.local.home>

On 2026-03-25 11:13:51 [-0400], Steven Rostedt wrote:
> Yeah, this is open coding the rcuwait_wake_up().
> 
> I'm not sure we want to do this.
> 
> Perhaps RCU could provide a way to save the rcuwait?
> 
> 	struct rcuwait = __RCUWAIT_INITIALIZER(rcuwait);
> 
> 	[..]
> 
> 		rcuwait_copy(&rcuwait, &work->irqwait);
> 
> 	[..]
> 
> 		rcuwait_wake_up(&rcuwait);
> 
> ?

Most irq-work aren't free()ed since they are static and remain around.
There is no task assigned if there is no active waiter.
Wouldn't it be easier to kfree_rcu() the struct using the irq-work?

> > +		put_task_struct(waiter);
> > +	}
> 
> -- Steve

Sebastian
