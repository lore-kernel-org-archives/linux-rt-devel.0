Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA72101A0
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155749; cv=none; b=RBVml6z95DmcczJbn0zI0vP31AdJjX4gWfUmoJGJz8sxHKSTBt4r9fGgW3DiEmkTYislzBeuZneEfrAXZOCKwuk7NkFERCHohyLxuvQMQKAM2LUdZ73AhU5odmwU3xAoHuw0On76//JeOqCQMaBzjXFpJXxRVmEjN+uTkxiKQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155749; c=relaxed/simple;
	bh=t6ZudQBUA++0XfVdIvEWYDfnTIj4HRou8x2rmZc+XCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA5preCmIfMb/9aE5DNHzAytAWaGXQByrh6l46F9LkEWgx9nlebUL9W6iW52OHj5OCzqRFT6QfS+G1gKBr5/SL2XxZ6WI/gI4DalFimE7Dpu8Jwt4fmqwcokKhs/L9aJ2g4GMgYDRajKpqOadfA8cF0MLXkvrf5/GfQZsM/3RCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mYWpmjpN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8OTyGVN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mYWpmjpN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8OTyGVN"
Date: Fri, 21 Feb 2025 17:35:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740155745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6ZudQBUA++0XfVdIvEWYDfnTIj4HRou8x2rmZc+XCU=;
	b=mYWpmjpNLtzKJEiLEH2jyeaBamwMEiPmDHCM/V6vvvr1xOS5mAd6WKx7EVH1YlXDkazsDs
	juLH4ckJxI3LQ4Le4L1mhOM0e6SxnCG0Fie+QfcQzeySOt7GDJ/AUSmWiNwSZwz/UgKbbC
	xj9/V89LFBkzihe021rrv26CLv3N/Dhp28c4VQsKlXqTQ6LO/WQ1SKZzfIrBuG9CIJgjTr
	MRKhfZIIbFtb5thEYZYE4KtMQEKGlXVvbzCbPCPaeYwNqTh+AxiOtJoDejyw/cXN3OUEpL
	tcdlRMOSFY99HjjDtc1wz5ELiInmFpeLziTB1DA/mh4Ov215tPYH0joBNe8AXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740155745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6ZudQBUA++0XfVdIvEWYDfnTIj4HRou8x2rmZc+XCU=;
	b=t8OTyGVNdd3rNU4n4pvwbbn/mpMKWNpuRbQTJgGOkYYGJuBWXg6YX8mfelmF6XB8YFcA0P
	zBcrTt1ICrrLseBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] lockdep: disable_irq_nosync_lockdep.*() for
 PREEMPT_RT.
Message-ID: <20250221163543.erVpjzHa@linutronix.de>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-1-bigeasy@linutronix.de>

On 2025-02-12 11:36:17 [+0100], To linux-rt-devel@lists.linux.dev wrote:
> Guenter reported a sleeping-while-atomic warning on PREEMPT_RT with the
> NE2K card. Turns out it is a questionable construct which requires
> lockdep tweak to not get reported. It was added long time ago to deal
> with the NE2K and has today two users.

ping.

Sebastian
