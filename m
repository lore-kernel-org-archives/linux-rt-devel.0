Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154B248F57
	for <linux-rt-devel@lists.linux.dev>; Thu, 11 Jun 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172552; cv=none; b=J1I2aJS8N4/w3PuUjjojGYeEhPaK/0VhfP39h23PPuw7av73GCm7uxuFGkhprpOSBrWGY0ymuM52yB57ac6K58ZtVuZAwzgbAQzEs1jyWQUwfSfSsQVycuk6xLjZAx/YNLs6gY12sTbnu7pYiJp6/wegbiXwgeAmWYstdyVrHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172552; c=relaxed/simple;
	bh=nTx93AR1aY7GkqgxCW3v7jFb7bWauh7aek4igYUdrY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPVS9+2MSzNH4zolwrEBBPu5QaJqf8zsItwakCozCLl/GoTaH8mfzeUH1II8OCMeADbKgM9h2vn1h+J0PdP+pUGxdDeEeNi33Z6V4aGEKtjuyN4mu95zj6ppzDRnEACcd+13NyupQ1I5q76GFFWwiw/7h46XJgsdjK5Z6gnnx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQ6b6aWA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6+2+V9RI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQ6b6aWA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6+2+V9RI"
Date: Thu, 11 Jun 2026 12:09:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781172549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9K/0LIzyGDcFy4hIlVFGXNab83Bz1FNfGNyLqdLYSM=;
	b=cQ6b6aWAijh1nArUq9dDV8vJ0M1rMoldBNuWGoz5qP86/wLH+mGwE+MFbazscDl7DXK1k+
	ILvfdjW1XvXxsw6WOOjq2PVYCSFkzulgfgppHtDvup8OEUt4cEzKdHBH4NxSobyKFo0kWh
	Q2/el6oy4V9KatLe5+rOmJ24f1qz8Igiowq5Y/g9/4rRF2WIv2UDSTgnvLzThKqfyW/qtP
	9x/uwQMzIbg3MCf8UtlNGoCZZYQp/1XLwa6VhCjGG7F1Tcpz5mAqZcmprZTCndA7N041sU
	UE+rHS1iejw5A5icmjVlC77P1LMNFt3mv1lIfIi/cmd3jMM1HzbtaNk/wbVGFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781172549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9K/0LIzyGDcFy4hIlVFGXNab83Bz1FNfGNyLqdLYSM=;
	b=6+2+V9RIEY3ED1HU1rMjhTAime6FaVoBX4te6oLXiwvHBhR6CE1GjqFfBH+RZzuEqFpJxM
	kfgoMSvUue7iCRDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 5/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Message-ID: <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
 <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>

On Mon, Jun 08, 2026 at 04:21:45PM +0200, Thomas Weiﬂschuh wrote:
> Depending on the system configuration, the restricted pointer formatting
> might call into the security subsystem which takes spinlocks, which
> might sleep under PREEMPT_RT. As %pK is intended to be only used from
> read handlers of virtual files, which always run in task context,
> this should not be a problem in practice.
> However, developers have used %pK before from atomic context without
> realizing this restriction. While all existing user of %pK through
> printk() have been removed, new ones might be reintroduced accidentally
> in the future.
> 
> Add a lockdep annotation to unconditionally introduce a fake spinlock in
> restricted_pointer(), so lockdep can detect misuse even if the current
> test system configuration would not exhibit the issue.
> This is intentionally a single lock instance shared by all callers,
> as that mirrors what can happen in the security subsystem.
> 
> This check comes intentionally after the in_task() one, to have the
> clearer diagnostic first when the function is called from IRQ context,
> which will trigger both.
> 
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> Link: https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/vsprintf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 09e0e5194d41..728a1acd69ae 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -864,7 +864,14 @@ static noinline_for_stack
>  char *restricted_pointer(char *buf, char *end, const void *ptr,
>  			 struct printf_spec spec)
>  {
> +	/*
> +	 * has_capability_noaudit() may use spinlocks.
> +	 * Make sure %pK is only used from valid contexts.
> +	 */
> +	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAIT_CONFIG);
> +
>  	lockdep_assert(in_task());
> +	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);

The kernel test robot found a lockdep violation with this patch:
https://lore.kernel.org/all/202606110945.d3871219-lkp@intel.com/

My suspicion is that this is a pre-existing problem that was not visible
to lockdep so far, exactly what this patch is supposed to mitigate.
I'll investigate some more and try to reproduce it.

>  	switch (kptr_restrict) {
>  	case 0:
> 
> -- 
> 2.54.0
> 
