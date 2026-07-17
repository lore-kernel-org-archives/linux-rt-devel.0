Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C803E022B
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276102; cv=none; b=huXJq6uZc7NF8wao2F335MOERU+llzGwU9NvexNAzyBp5YAQSoucNLH/0KpKRwhWaRLs12ZJo4O6kq9CusGtW3m5CuUBCvZKUcEC5w1LQ8XVs20C827iK21jbdnJukmRatZDKGski3OXqX839yc2iCvfmsKfqrTjBiKK9nhr0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276102; c=relaxed/simple;
	bh=KAnXEA1nsygVFidnaeo2+sUgxuOJu0ToSdre2tYymvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYWQrCHvhTeLMTEpiaBvWZ5hmR4GjrDspkNOGvCmKuRKI9Iea4//22CMuthA0w6TLy0ckBsWReufp6gGCB4oT3LJQ3MdQeSN7Q+CKccOSg2k2PTlXfG8P5dR/4xmr74pcKgazSBYF4rLdCNr/twqmJYTUNXCK1GAepGNwd84OyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGYbIEjW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HUXqyjTz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGYbIEjW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HUXqyjTz"
Date: Fri, 17 Jul 2026 10:14:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784276095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJAuqZuWQqzjYYp+EEQS1LZ8rOxNC7QZm9D+4rKS8Uw=;
	b=FGYbIEjWVYSKMk9LPgj3WdJkaZXfoQTZ3KsZ0JQwFf4EveNoIU7dGfwNfi5pZ2Gc1fbT6+
	uvZ8pubJzbEoHzT24DjA/9gpZm/JimXqKF94fhuSn/5RBhYZF/Z30Ncxa1/m2jWB6aPHCu
	zu5RXqS9qJbXilhl0vrJ6Y59n1fP6jiR4WDPad4jigx7GfoT94yYPptUcX3YkuJVFkHHxT
	LpaUtotPtoSpBJlLO9CGAf0RqI07QlRdTxXWIi88DmySGwXKqYqwe6ZahWa/S3yQ8x3SWY
	4QNa7HNN/uaHEgAk58o74rJWEEGTHpRQG+Rs3GoJiVJqSNCLSlLvXbZdDEeznw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784276095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJAuqZuWQqzjYYp+EEQS1LZ8rOxNC7QZm9D+4rKS8Uw=;
	b=HUXqyjTzEg/UiDmkB4ctIsHB/e4PAgam+gL2OJUCKEPgyApAMtmlOxcA9CrposubCIt4+E
	l8aBk+0yBp4xpNBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v3] coresight: Fix scheduling while atomic in
 coresight_cpu_pm_notify()
Message-ID: <20260717081453.pSDTUQQW@linutronix.de>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>

On 2026-07-17 00:41:54 [+0300], Mohamed Ayman wrote:
> Dropping the last reference to a coresight_device can trigger a kernel
> panic on PREEMPT_RT builds due to a "scheduling while atomic" violation.

It is not a panic, it is a warning. A panic is after panic() is invoked.
[ Or a warning with /proc/sys/kernel/panic_on_warn=1 but in this case I
wouldn't count this a panic but as warning followed by consequences of
your own action ]

> When the CPU enters an idle state, coresight_cpu_pm_notify() is invoked
> with local interrupts disabled. It calls coresight_cpu_get_active_path(),
> which currently uses coresight_get_percpu_source_ref() to get a kobject
> reference, and then immediately drops it with coresight_put_percpu_source_ref().
> 
> If this put_device() call drops the very last reference (e.g., due to a
> concurrent device unregistration), it synchronously triggers the release
> cascade. On PREEMPT_RT, free_percpu() takes a sleeping rt-mutex.

Again, spinlock_t which becomes a sleeping lock on PREEMPT_RT.

> Furthermore, any parent device in the release chain might also acquire
> sleeping locks, causing a system crash in the atomic PM context.
> 
> Fix this by eliminating the get/put dance entirely in the PM notifier path.
> Since coresight_cpu_pm_notify() runs with IRQs disabled, it is safe to
> read the per-cpu source pointer directly under the coresight_dev_lock,
> check the mode, and return the path without unnecessarily manipulating the
> kobject refcount.

Right.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

There is coresight_put_percpu_source_ref() with holds coresight_dev_lock
during a put_cpu. I don't know why the lock is held, it is not obvious
to me. But it will lead to a similar problem if the put actually invokes
the release callback.

Sebastian
