Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64385410D07
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461562; cv=none; b=kM3+hfoJMOkgBp+XCc5v6AqGCwHlRSRsZxvCw67hofyCp0LLeAtuHhHz4BzB50iqQ1maPYH58/pf1RANEIEFHPNhUX1wZM86eVIwkJPQF900LhXlP2bkLcTuAzQr0Xksi4vserRdXplxjThbX377bE7pPOnXg1dM9ZX94gmXDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461562; c=relaxed/simple;
	bh=WFyb9EuOz64PfY5LVUuyB/xLZjW6/SplawQsoSfq23Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/tV5BpZn7mWwzm7382q78qZjg17aIBThJkiu4nHzhGOaiMbGx+qZ7uMtT3t6xEtJZhbrZ6pvHtdubvwqWJp7xd9MqAT8a1nV+VKI7BCfVIMKae4xG/bcy+zPH1Bp2iUsI6ctSLAuMe62JQ8SzTPAyE+5sx/1P8VxNfZO97MQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZepXLvYj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7CqVs7YY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZepXLvYj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7CqVs7YY"
Date: Wed, 25 Mar 2026 18:59:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774461557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjRj5tFUhn4wQAK1rOJzXPmHO3K4s5RYcXJL3hKctZM=;
	b=ZepXLvYjzbOYa7m5HzXuMZBj8+0PKE/9/1O0QRexVJe0QmHfMR7mAZP1RGwTZLrtEQYJTG
	7Ady5LgWz5FJVarXZe2pB59+tJp6Upm1uyIRpDrFJdJdJr1CkQRQHzuNw6E1peFP/Uhe0i
	ovG6T4ayeIQYns0HTvb5GjwbOXuElHhzB7xJeEb6QpAL7f7tqi6DhpwwfXeRToi/Ddt8Sz
	wISP3P7eA1trqME/U6TbPFaGM14blLO+sdZpMp8AuDvBEdzja72T66n2VKepM9WDpt1Ehb
	4xrhllPKS6dioceglQ1akA6w2R+xCa/23JJ9SugAv0s06g3xq6JijBb69THUhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774461557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjRj5tFUhn4wQAK1rOJzXPmHO3K4s5RYcXJL3hKctZM=;
	b=7CqVs7YYZInBwYQf7q2ZAHhpTOf445YKwzc1NlcBdZVYhuza1dsxyJTUpZ3Mugb4pXRbIx
	zBcLoztSCHrXvYBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325175915.YufD1Y8T@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
 <20260325111351.1d38a0bc@gandalf.local.home>
 <20260325153826.EbSqlX_n@linutronix.de>
 <20260325115315.052e34ac@gandalf.local.home>
 <20260325155504.tm4zHWMI@linutronix.de>
 <5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
 <20260325170539.MHkr49jU@linutronix.de>
 <20260325134433.7d46507d@gandalf.local.home>
 <20260325175150._IrYQldq@linutronix.de>
 <20260325135540.4d127635@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325135540.4d127635@gandalf.local.home>

On 2026-03-25 13:55:40 [-0400], Steven Rostedt wrote:
> On Wed, 25 Mar 2026 18:51:50 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > Perhaps Jiayuan's idea is better as it will not require modifying current
> > > callers and does fix the issue.  
> > 
> > Don't you need to replace irq_work_sync() with this new one?
> > 
> > > But it would still need helper functions from RCU as I really do not think
> > > it's a good idea to open code the rcuwait logic.  
> > 
> > Why is rcuwait a concern?
> 
> Oh, I was talking about how the patch open coded rcuwait (which we shouldn't do).
> 
> Are you saying that if we stick a synchronize_rcu() in irq_work_sync() that
> could work too?

I was thinking about your helper doing synchronize_rcu().
I haven't looked at irq_work_sync() but it would need solve the problem,
too. There shouldn't be any user of irq_work_sync() which does not
intend to free the object, why else should they wait, right? So it might
be even simpler.

> -- Steve

Sebastian
