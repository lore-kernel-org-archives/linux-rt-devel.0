Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE820C009
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Feb 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435916; cv=none; b=DcmVfJkwMP57pBMOAiCvrp7f+qRMyWa1Nqa8hMl1M9dsk+Y/sU25UVDmRPJ3wqYCOQQBCUItkJK9iHu1uA0/p1VqYo5IG3ZxH35cP1PyA8QuYJOl75XoVf5C2TY7rhayluYS2sbifYMDt99mO6jl+Fhj6tSLqFA6FNuN1gjOEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435916; c=relaxed/simple;
	bh=sTcjSyDdkE4DYLh4ZK1+GLmrzqkh2FgtU7WsY/UwxYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2Prf08DuepCo95vBwPriyY0gEp3bexvqLI7N7jgykp5Ei4BIVh9Cl1aAvUu8MzsrlsvY5EHh+Kgz6sjgnn4nV0Wv9rZBBLHRCfSZGnntbkW6LKAINA0biBrVicFxzU5hYAS9tgvW9+/MoVK0nNScwF5tLZVGqxRUhU4pRFrt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wq6ME91h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ve5+95E0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wq6ME91h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ve5+95E0"
Date: Thu, 13 Feb 2025 09:38:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739435911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTcjSyDdkE4DYLh4ZK1+GLmrzqkh2FgtU7WsY/UwxYI=;
	b=wq6ME91hYodwUAQfMAvRVgwOnnyocV8Y0hR3NnJEslwQd1h/6z4MwBgxUqpMGWB9Zw8/63
	vUuS7uZn4tPZLHaNrLjQ3x2LtfKFFmxfhIUxDgFkeF1SL+ZPqFbAAXvqLkSJeG6Rf4rF26
	DQrcq2Hziw4MV6UAsOEyEww7eX9kPuOFEwHEGGW/VafuXSZlnH+pa2A1JPfIr/9EqbWMsN
	KsJJ7GBV1df5hbZ2ZANlIxv7tpduOfC9jQnJU5ynaxkvb0c0m6EvDl2DBsaE/th8WZ0nSO
	fs6RsL1Y6pm4FZt9VTa/H2iy5VsQz8UguzYGcJRu4tlbG9ZLXu5iJL/ABAAPmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739435911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTcjSyDdkE4DYLh4ZK1+GLmrzqkh2FgtU7WsY/UwxYI=;
	b=ve5+95E0sTv8bNwJiQCQ9++FDxIfQrd9uLky3yXSRU/dp179Ae0x1wnxWf2k20m108M0Ki
	7XQdBGMD5vt6FjCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250213083830.UAaGrqwY@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212114531.4e95ffe7@gandalf.local.home>
 <20250212165908.DoNnHJ5v@linutronix.de>
 <20250212120328.28fe4123@gandalf.local.home>
 <20250212170955.x1oRhNjr@linutronix.de>
 <20250212121837.3b25b941@gandalf.local.home>
 <20250212172417.DQF_YTTy@linutronix.de>
 <20250212123302.0f620f23@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212123302.0f620f23@gandalf.local.home>

On 2025-02-12 12:33:02 [-0500], Steven Rostedt wrote:
> I guess it also comes down to how many places this happens. If it's not
> that common, then perhaps this is the simplest solution. I just don't want
> this to become the new cond_resched(), where we have to sprinkle
> local_bh_disable() around to solve issues that are reported here and there.

Don't worry about that. Both, the ne2k and the pcnet driver are _old_. I
had the ne2k as ISA a while ago. Maybe even a PCI later on.
Converting the ne2k to proper NAPI would avoid the problem.
Adding a bus-lock to the pcnet driver would avoid the problem by in the
driver by not having to disable interrupts for the entire NAPI routine.

> -- Steve

Sebastian
