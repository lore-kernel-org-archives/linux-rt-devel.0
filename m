Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFA2BE655;
	Tue, 16 Jun 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599378; cv=none; b=qbAHBxQyGj/0SDxWMRuNkLbjneE09Tq6v0M4hbXLxIGk+gXl2bQkdyo3skClEvQjMy9iewNtLykDdEiM4h6LfCTruL9HSp9JkGNyaB2k0jUAuu45ZM5Wzhdr6L3W4RP+fYHeA2RY93z2itpjq61g996ibUHYfOFlTPzUI7b2Gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599378; c=relaxed/simple;
	bh=v3fHJVl5ONcdvYSJEKJkSO+iQB0w021T6jrAFShW4VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDt4QTt+GwctwYztfxFQu9RSrzKPw//swO3QpM8RS4zTc3AgaTKd8DFvaaD3EG701w6jnbGRoti0wqBLJAk7qbW7/yU/csbkA0Nlwu5PUFHfrxxlkCJrJvs+UfMiCyeQu40xMJNM2bUiWZZOFvEzPMnqsF6eIitCo3Th3Kw4dBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vZTt8EQm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vZTt8EQm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B8jnQZvMblKBYe36izNr0q9WBNLBoBeu4kD5d6rr5GE=; b=vZTt8EQmzahMHdwBNNG/F2pWCN
	balPEGzVSntBiuTRH2jAIZV2QpyrQQUahEG0/xcAOclDQt0kaOFzSPaDmcO8I7bhrjEqTL6PIZfZU
	Y8hC5APVLJKyd3tng92cVIdMf7l+9jByP1p5UQF3YjowOGzsL6PpMQl7rDbZHSZeH8xx9DREGwPs9
	6xN4GBd8NLgK2GemQCaPR48Ib5v+7JXHbOqFzDx8Jm6RtaI406AzHqiXSZdTsDDV+2eaHp8wmjIUf
	l4cxA8j3iCqiV6Ans4aiUUemAdfl0CWiw8TCd5bYE3hobQz51172leLaHgCbQJUGp4+3sT07Hr1HM
	4gO2jd7w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZPNe-00Divz-2e;
	Tue, 16 Jun 2026 08:42:47 +0000
Date: Tue, 16 Jun 2026 01:42:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] timekeeping: Register default clocksource before taking
 tk_core.lock
Message-ID: <ajELmhO0cT9gKQUl@gmail.com>
References: <20260616070914.65818-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616070914.65818-1-mikhail.v.gavrilov@gmail.com>
X-Debian-User: leitao

On Tue, Jun 16, 2026 at 12:09:14PM +0500, Mikhail Gavrilov wrote:
> Commit f24df84cbe05 ("time/jiffies: Register jiffies clocksource before
> usage") moved the jiffies clocksource registration into
> clocksource_default_clock(), so that it is registered lazily on the first
> call. __clocksource_register() acquires clocksource_mutex, but the first
> caller is timekeeping_init(), which invokes clocksource_default_clock()
> while holding tk_core.lock, a raw spinlock.
> 
> Acquiring a sleeping mutex while holding a raw spinlock is invalid, and
> lockdep reports it on every boot when CONFIG_PROVE_RAW_LOCK_NESTING is
> enabled:
> 
>   =============================
>   [ BUG: Invalid wait context ]
>   -----------------------------
>   swapper/0/0 is trying to lock:
>   ... (clocksource_mutex){....}-{4:4}, at: __clocksource_register_scale
>   other info that might help us debug this:
>   context-{5:5}
>   1 lock held by swapper/0/0:
>    #0: ... (&tkd->lock){....}-{2:2}, at: timekeeping_init+0x1d5/0x320
>   stack backtrace:
>    dump_stack_lvl+0x84/0xd0
>    __lock_acquire.cold+0x39/0x63
>    lock_acquire.part.0+0xc7/0x280
>    __mutex_lock+0x1b2/0x2440
>    __clocksource_register_scale.cold+0x289/0x609
>    clocksource_default_clock+0x31/0x50
>    timekeeping_init+0x1e3/0x320
>    start_kernel+0x243/0x3f0
>    x86_64_start_reservations+0x24/0x30
>    x86_64_start_kernel+0x134/0x140
>    common_startup_64+0x13e/0x151
>
>
I am seeing a similar issue, although from a different code path.

	 =============================
	 [ BUG: Invalid wait context ]
	 7.1.0-next-20260615upstream-14023-g8d6dbbbe3ba6 #32 Not tainted
	 -----------------------------
	 swapper/0/0 is trying to lock:
	 ffff800084e4bd80 (clocksource_mutex){....}-{4:4}, at: __clocksource_register_scale+0x5c4/0xa48
	 other info that might help us debug this:
	 context-{5:5}
	 1 lock held by swapper/0/0:
	  #0: ffff80008ca99930 (&tkd->lock){....}-{2:2}, at: timekeeping_init+0x158/0x290
	 stack backtrace:
	 CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-next-20260615upstream-14023-g8d6dbbbe3ba6 #32 PREEMPT(full)
	 Hardware name: linux,dummy-virt (DT)
	 Call trace:
	  show_stack+0x24/0x38 (C)
	  __dump_stack+0x28/0x38
	  dump_stack_lvl+0x94/0xe0
	  dump_stack+0x18/0x24
	  __lock_acquire+0xba4/0x3520
	  lock_acquire+0x150/0x390
	  __mutex_lock+0xe4/0x1240
	  mutex_lock_nested+0x30/0x48
	  __clocksource_register_scale+0x5c4/0xa48
	  clocksource_default_clock+0x40/0x68
	  timekeeping_init+0x164/0x290
	  start_kernel+0x2b0/0x4b8
	  __primary_switched+0x8c/0xa0


> On PREEMPT_RT this is a genuine sleeping-while-atomic bug. On !RT
> clocksource_mutex is uncontended at this point, so the boot survives, but
> the locking rule is violated either way.
> 
> The default clocksource only has to be registered before
> tk_setup_internals() consumes its mult/shift/maxadj. Neither
> clocksource_default_clock(), the ->enable() callback, nor the registration
> itself need tk_core.lock, so fetch and enable the clock before acquiring
> the lock. This preserves the "register before usage" ordering while
> keeping clocksource_mutex out of the raw spinlock section.
> 
> clocksource_default_clock() has a second caller,
> clocksource_done_booting(), which invokes it with clocksource_mutex
> already held. That path avoids a recursive lock only because
> timekeeping_init() has already run and set cs_jiffies_registered, so the
> registration is skipped there. This change does not alter that; it only
> fixes the invalid wait context in timekeeping_init().
> 
> Fixes: f24df84cbe05 ("time/jiffies: Register jiffies clocksource before usage")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Reviwed-by: Breno Leitao <leitao@debian.org>
