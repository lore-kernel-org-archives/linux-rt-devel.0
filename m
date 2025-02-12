Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2025743B
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381062; cv=none; b=NowCoGbuSC9/IEQZGfyhWwPrkYTwFSq0xzFlFQOhreCsqki5Ik1gP1chH+nL/LCTKblhCDTmeS3w0gAuAFql/W/8ynseGdhldNmxWJGdDe63BcNWL2bNQnUAmI+mjE7RjY+tWb4HnHtEEceZa+W6eJ2qY267LWIflEEQbLs6btc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381062; c=relaxed/simple;
	bh=gECyfn6DsAr5S6ZbbomepHdszNPYnmxsgmNNisuoJew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHb+/XzZJEeZthQ91bE91jwGJagTHiICRFOZxF1itXlyIurebWDrwrns44MlXIflsLxvCZrjVmhXVlaX34d5WRZJ84U0NUh0CYFDaZloFRwu8ooPq4KKdQoVCFE8do9vPPe37wR7QhaOq0UuZWZOnUf40aDgHzmCNHfASsaVSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMHkmrXp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EZ1GhOBf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMHkmrXp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZ1GhOBf"
Date: Wed, 12 Feb 2025 18:24:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739381058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuuJgFYbtOA03q3xnM0c0igztDQtqZl7WgVLStU14yg=;
	b=RMHkmrXpyWnnbBc1Vj8Yb51zgJB0EVLPwNliS7bspfkchuNUEVLwJQyKlTOLgpQSGKnLfk
	GXDw43sqIx7pZy7touJcX4r32xBCbgyt1kX1hNqZ9kRx5jVGhsRiyRcw8JMxp6eMrVSu2C
	J0wBg+a7kUmGRtNRXtngU9xZ1c9UJpe15//g4VtfwKbMsDErbWReZjuUGZkuEdCk3Adqip
	Xm8rtZvhNgRXstVv2XNRf0KicpLFPgAQKuHjCHSQUBTRObAJDNGaTvo0aD251OJWHbGPkp
	7xYj1orSgPX1hSdzYOc9l8/MZoOCr97ZOPEojxDdmNwdJZAO7tIFSuh5UyhYiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739381058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuuJgFYbtOA03q3xnM0c0igztDQtqZl7WgVLStU14yg=;
	b=EZ1GhOBfk0MCZm2McW+2Du1EwG6DRimU486e4g04VSOi3bVTGVw2ayate4Oj1GgsPeTXZ8
	A+aO0vbYpogf9OAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212172417.DQF_YTTy@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212114531.4e95ffe7@gandalf.local.home>
 <20250212165908.DoNnHJ5v@linutronix.de>
 <20250212120328.28fe4123@gandalf.local.home>
 <20250212170955.x1oRhNjr@linutronix.de>
 <20250212121837.3b25b941@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212121837.3b25b941@gandalf.local.home>

On 2025-02-12 12:18:37 [-0500], Steven Rostedt wrote:
> On Wed, 12 Feb 2025 18:09:55 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > Why not? It keeps the same paradigm as non PREEMPT_RT. Do we really want to
> > > litter local_bh_disable around all these cases that spin_lock_irq*() is
> > > used to disable bh?  
> > 
> > Yes.
> 
> OK, after testing that patch I see the issue. The local_bh_disable() makes
> it look like we are in a softirq, and that triggers a bunch of
> BUG(in_interrupt()) that are around the kernel.
> 
> Couldn't we make the spin_lock_irq*() also disable softirqs without making
> softirq_count() return true?

Maybe. But I don't see the advantage. See my other reply.

> That would keep the same paradigm between non-PREEMPT_RT as well as
> PREEMPT_RT without having to litter these all over the place.

I am working on getting rid of the lock in local_bh_disable(). Guess
what happens then in terms of "same paradigm".

> -- Steve

Sebastian
