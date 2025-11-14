Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA74334371
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Nov 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134923; cv=none; b=m43cvpTJdqqVIMkHl/K5PCfATAqQ8wJ7jRq8Ww/HjR3G8/Vell3z0Ln+QS7TXpSrUXfet1NyPcBMeLBr+KeClr/lGLgoYt/1rukjqfs4xHs7WcTuGpazQs2fDyGV9W3KbaHDygOTNRyi2z46aB46YXUFPQ+Qx/SCVJOwDOvep34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134923; c=relaxed/simple;
	bh=awJcRbOIqi/NwQQHQ2KUQztGb8zQCe0HWVKs51hyDdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMIf2B509Eys2aT9gnsz9EDCS7s7+pW6yd8uuwCcLWjzJJKn8Z9PnVznqgJxxA2PsPSNnHF2nUGv8TxeZSs66kGEyOr/SUmMGfAC/cRRF9EREnvsQfwi/gc6BYJezSvBtO2VeHZwUCv6ruy1t0AvMNzyOI8iW1ffCa1qwndxSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/xYp0G8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1UNmPUpC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/xYp0G8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1UNmPUpC"
Date: Fri, 14 Nov 2025 16:41:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IskL8g7V3/rjeI+B2keztCszWthJqS4V60vo4lqe23U=;
	b=2/xYp0G8gfGd+laJWCiEwdSYzyy0cpWMKWQX2hJXX4Pk54k/BykHZ5JG/cVvPS+Wsn7H+0
	WLNJRgQ4p4pMqRnc8SjyH7V0/ML9mF88HJHx/fnedHteLct0irWewocBVB0gMPPWYSf6su
	jZCURrq+6cJN5E8y+i2ziMm9H48ha5K3oGsBDLI18UZvGlTDP9OxAXGBa+z4A9/tAM92Xy
	sLubAubwjj12OJ4pnWg64qe60bFbNMNVHdLx209N/6/e5Alro2l6hQQ3eS4WXqBTMoehPq
	/pkeznxB7tEmjYS3zOdhCjWzcgdxnxZemvMhT8HgtPgBUlPLqW3QCifza5K/IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IskL8g7V3/rjeI+B2keztCszWthJqS4V60vo4lqe23U=;
	b=1UNmPUpCAzoKgao/nDnE4YrxQ7LVAUFPTfXHVYTgDW8b/8hLYGpfdK/yO0HjM/HQ4zLNNa
	kJxcpTfhpp3ajwBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] debugobjects: Allow to refill the pool before
 SYSTEM_SCHEDULING
Message-ID: <20251114154158.es3XCFy-@linutronix.de>
References: <20251106120628.AxWa_Viy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106120628.AxWa_Viy@linutronix.de>

On 2025-11-06 13:06:28 [+0100], To linux-kernel@vger.kernel.org wrote:
> The pool of free objects is refilled on several occasions such as object
> initialisation. On PREEMPT_RT refilling is limited to preemptible
> sections due to sleeping locks used by the memory allocator. The system
> boots with disabled interrupts so the pool can not be refilled.
> 
> If too many objects are initialized and the pool gets empty then
> debugobjects disables itself.
> 
> Refiling can also happen early in the boot with disabled interrupts as
> long as the scheduler is not operational. If the scheduler can not
> preempt a task then a sleeping lock can not be contended.
> 
> Allow to additionally refill the pool if the scheduler is not
> operational.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

A gentle ping.

Sebastian
