Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B013B5AE
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927387; cv=none; b=eqFcGKAgrWmk/pnbFGTdXJP52V95wnhBQN8O0ij5NKWd7qXxeKzvcjCOMHiLEVD39xAtxTTBoCSPG4wTE0I+O7CAuICHqREkR7jf1CXQ6kA3W8JIhuExrlxJpOdojWL2r4NXMvBUhzQZNlKVf1AjZkmNI3sbQvNm4GgsOx2gkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927387; c=relaxed/simple;
	bh=VYnDkKDEgNRMvHk30Ty1wbkQtydCavhWBQSP6IHkfj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpevOH3Xh93MyiUAjfarF7lQ3xL56gzrp5dSlix+ir4vuQ9S6l/WaJOrJ8VLPbDh6qP58egD16qqTlg9iaFIZAnb70fXrOfLXof+KaaUbdBx3KSDUhoyU02cOlC7MWDnY7yJ7ucX15g6A9/mp3DRMKNPYRWmeWYFOOQoE9Vh66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oaorEDpZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFwD8Ztm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oaorEDpZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFwD8Ztm"
Date: Wed, 11 Dec 2024 15:29:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733927384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VOYpxZqhqq/1CTP1KVnyG6EjZzQVJC8nCc0zAYnT2Ps=;
	b=oaorEDpZ5pd/zIm5/szMN1cUc953JQSng7kwU3JeVF8zP9wfx/dfGjVKrqAYgCpYOA3LYv
	+VmluxpmYYG2DYuK44a13pjzQ0w4wH68F4v1juE/Vy0sb4S5U0MkSRimdlecca2Afh31Zf
	wzRGzagYDThICL3GF6836nP0YQbKMyq94EeEfmKSMvZ8/0gIJYIkL9jIM01t6nAh5Z5YRG
	uu/9J+/R663w+MBQqVVTLbCpYETvho0i91WGOCEKnt/xaKMjVLyqutG8W0oBZXUuoolEr7
	Aj7igL5KExaO10gulUVR7UxAvoez8118eazQwB5vdSus5OAYy/ytygrgjMllsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733927384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VOYpxZqhqq/1CTP1KVnyG6EjZzQVJC8nCc0zAYnT2Ps=;
	b=BFwD8ZtmoJb0Q7PAOBgonmnOLnsQK4bfFGatcd76wYSBrZPXGpwZB45nz6+f+aH2Bxs4lD
	HibuAKfKRRMPIrDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/4] mm: drop HIGHPTE support altogether
Message-ID: <20241211142943.cp0Wcuxk@linutronix.de>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210160556.2341497-5-arnd@kernel.org>

On 2024-12-10 17:05:56 [+0100], Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
> architecture is left using it, so remove the remnants in common code.
> 
> It is likely that further cleanups are possible in the page table
> code but those are not obvious from the config options.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
