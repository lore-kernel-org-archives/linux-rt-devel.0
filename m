Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837543;
	b=5ZzNezlHARcTDUKXrY8u/Cg3XtMi4Imxrgww9iClAGCVhljp6p1MaemVuhUdPiLlYyb2
	 8iW4Gqe/l9iRIVfEXrDc6ctPU6rkeJ2arQf5MHCZwlZvbZJN9NgccGpjc24zj8JnKooRa
	 xdQLE5Tn0yGfQs4ytJ2tgc2Kh8AXRdrHoCC+gRub4KrrFPcx/TtpoiXVgTosGfDmC2kvL
	 AKpZ9qSuVHYZ86mduoEd0numcSgKRjjQ0ZKsgYTzahqaeJVCVIt3nx9avwdnuH1Mhnf6i
	 1e4xfcUk13nyDOlzCWPKVxph+qGwfPFkuHlBqk8369tZFvFC20wJlOyO0NFl8R9S0yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837543;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NvBQ7GFPfohCX3fcyNyGmyAGg0QVOAtg04t1p2J8sGc=;
	b=FjO9fLkqUbwCBgPg7xfzfYu7UcK8/XcM/TrktZ7Zo2kwY1MVMXFVZXQ8K/gUX6tBm4ea
	 25DEygQikD4+9utHFS7u4uZddMyWhmhnpPSpyuflOPWO7nBhQ+XotQCDVcpDBLxjPDrqI
	 JNgm37TTm1F/khcAH0EOGf7eyrj9Po4RehFm9b8m6cZwWhxxhwN9y+IDjYdkE84cj4lFC
	 pkzbSMkFI2m2NfIqnvrTCA6ejABOC5wk1JZ0hClS74kUWgUJa/2RepfPbEPuvV5R4LpIf
	 N/TxI0jX0Uzj28zqFqYC1E9Es6nuK4zmguyIKGAnk9kISCaR5K2u9CyI8GKq/QZb5hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pEXmeg2G;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="u/d7VO3f";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F5606A31C
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 13:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA8F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pEXmeg2G;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=u/d7VO3f
Date: Mon, 16 Nov 2026 14:58:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794837539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvBQ7GFPfohCX3fcyNyGmyAGg0QVOAtg04t1p2J8sGc=;
	b=pEXmeg2GIjcpwZUxa9ZZ30PChKgwhfwV+xoGkof7MhdMDK+rdNYfGvqHhj9Z217QkkRfUz
	TseNWdSaMnB2WWKtqsusUQtFFGx5gqjo7CaAspVhsmWMjt+cPhQQiwdvJwlUhxkgYF8IrK
	ZgjRk27uhlFcUMUThPchCdMt1weMUOxqpZL8b0E7kySOunzvP/zFmzlgEVZYESXCgFTtJL
	FKM2SuoSqVTE8pR9MYenqS9XpZWhRdN9PAwvwYn9SwaLWRSPUL+occp6vLsbpcRh7AobJK
	bIAklnozgQGcnPaPkzw3lHsMUWN5bh7z1sCZH6xm3XPcANiv5u6fjMQpN9064g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794837539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvBQ7GFPfohCX3fcyNyGmyAGg0QVOAtg04t1p2J8sGc=;
	b=u/d7VO3fZ9fNHwClcrd+LYOgPMKQ/eAMKZBFzPbxmwnOHeHtYQIcEbMz4qm/O6v6IwSmu3
	nEHE/B7wpAdLE4Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
	longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] locking/rtmutex: Initialize the ww_mutex context
 of a waiter
Message-ID: <20261116135857.5t9HGji5@linutronix.de>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-3-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108141347.1525532-3-mathieu.desnoyers@efficios.com>

On 2026-11-08 09:13:44 [-0500], Mathieu Desnoyers wrote:
> With PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, FUTEX_LOCK_PI reports no
> deadlock. Two threads that each block on a PI futex the other holds
> sleep forever. Without PREEMPT_RT, the second one gets EDEADLK. A chain
> deeper than max_lock_depth is also admitted.
> 
> With PREEMPT_RT, ww_mutexes are built on rtmutexes. They can create a
> cycle in the lock graph legitimately, and the wound/die logic resolves
> it. So the PREEMPT_RT chain walk turns deadlock detection off when it
> finds a waiter with a ww_mutex context, waiter->ww_ctx. It also drops
> the -EDEADLK of a walk that started from such a waiter.

I *think* this is unrelated because the futex caller shouldn't end up
here. The __rt_mutex_slowlock() -> rt_mutex_handle_deadlock() should be
different for the futex and ww_mutex case.

> But rt_mutex_init_waiter() does not set waiter->ww_ctx. Only
> __rt_mutex_slowlock_locked() sets it. So the waiters of PI futexes and
> rtlocks keep the 0x11 poison of CONFIG_DEBUG_RT_MUTEXES. Without that
> option, they keep what was on the stack, unless the compiler zeroes it.
> The chain walk then takes them for ww_mutex waiters.

Is this really the case?
You have a lock chain where the ww_mutex and a regular rtmutex interact?
This doesn't sound too crazy. __waiter_less() expects it to be NULL for
those.

> 
> The ww_mutex build of the chain walk can also requeue such waiters. On
> two of them with equal priority, __waiter_less() would dereference the
> poison.

I *think* the enqueue part is only affected if a regular rtmutex already
exists. Because the rtmutex enqueue would ignore ww_mutex/ treat it as
equals.
This will affect rt_mutex_adjust_prio_chain(), the futex interface which
is the only user of the chainwalk.

> Fix this by clearing waiter->ww_ctx in rt_mutex_init_waiter().
> 
> With this patch, the ABBA and the deep chain both get EDEADLK. The
> futex_lock_pi_inherit selftest added later in this series found this.
> Its deadlock and max_lock_depth cases cover it.


> Fixes: 6467822b8cc9 ("locking/rtmutex: Prevent spurious EDEADLK return caused by ww_mutexes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

This is the right thing to do. Either my analysis is wrong or the
changelog confusing. I would argue that the full-chainwalk depends now
on a random stack value _and_ __waiter_less() might access the random
value if ww_mutex is enqueued and a regular mutex exists in the lock
chain.

Sebastian
