Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C02874FA
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454107; cv=none; b=dqUht0bDcWk16VTe/kdiWrYzlLxLGD7ZY3wq6h36b0rg7aVAcuhM4ACvPEZxKbnIgoSKnM37q1ZwXRFm1Uw1BuMbDnINEAY8SxsXQQ0Uuvsl7LuGsEMxiu6xcMx10S2owe+JfZ3TuJH5R+gssXrxPXU8g5aHfeU2EpJMXi4+huQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454107; c=relaxed/simple;
	bh=moHfxT/f085nSkpmvMrpSmZfPUCfV7Q5fG2skk9knrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIy2lWR0ROQnHYqNS8c1KBse3Hdgn1NtQCI/kQY+EMH87PqP5qb7m5B3+zaBUa1EyvNTAKrbc94vl93oMbtWfEIQncr6n/l2/wn8VA9I4oinmO+rUQjbuVy8uz8Czxz3KrwA10ugEUaqbPnOZ9EGUJ9KHkJYaDicuTOISQC3vAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y7D/4Xbr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dLMoI46W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y7D/4Xbr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dLMoI46W"
Date: Wed, 25 Mar 2026 16:55:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774454105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsanpHlZQpby0OwpcN88OFhDZMJLlWKRSlX5pitFPgQ=;
	b=Y7D/4XbrHJLi/aspNlEBUHOkwdbHF0nZAzeCLatNoxvl5QKqBshPqh0argum+5OcmodiZt
	iXCFrOfLzrG6Z9Bjv3GrxpB+40eI4jCbODt01fKaKZtEx/2ICk6llwqsqf1WVHqjgSPjp7
	Ll3mX0Nj1pJlKmxlMcCeotvPXEoJ1qklMCqRetqwBebJtrC13AlXSWW9t+Y/v4vwRlJim0
	DBPNyQKAIpuSuU3NTQh8fx453HRTYS5VqfvYMY1yBqZ399+XikyHpu2QHv9AO+t/gvvVYL
	zQX306ldCtJ5olokOmSE+Z+8FCqyrKT1UUACSN/MaYvFhCCNNLobHG+LcUz8Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774454105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsanpHlZQpby0OwpcN88OFhDZMJLlWKRSlX5pitFPgQ=;
	b=dLMoI46W7bxr+iNJsVFDy/VrL31qyVfgJzl/wK1iVf4iZ1DyER4d13tK54Vf5yxlhQ9KUf
	/4Q0Oe2XkUzKKpDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325155504.tm4zHWMI@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
 <20260325111351.1d38a0bc@gandalf.local.home>
 <20260325153826.EbSqlX_n@linutronix.de>
 <20260325115315.052e34ac@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325115315.052e34ac@gandalf.local.home>

On 2026-03-25 11:53:15 [-0400], Steven Rostedt wrote:
> On Wed, 25 Mar 2026 16:38:26 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Most irq-work aren't free()ed since they are static and remain around.
> > There is no task assigned if there is no active waiter.
> > Wouldn't it be easier to kfree_rcu() the struct using the irq-work?
> 
> I guess we should add some kind of helper then. Like tracepoints have.
> 
>    tracepoint_synchronize_unregister()
> 
> Perhaps have a:
> 
>    irq_work_synchronize_free();
> 
> Or something like that to let developers know that they just can't safely free a
> structure that contains an irq_work?

That sounds great.

> -- Steve

Sebastian
