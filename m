Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409713D332B;
	Fri,  3 Jul 2026 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083787; cv=none; b=nZjXq9GxNTlrUY7TAd3JsTtqtjvMKOBGZ7mXRr0RAtfkXwP9y9bPte+01A7Qq59iFkVBE6N6tqIyTbBjEvhq5zC+Gedw6x82ru5fKXHY2PWFf088+NphCk0MLzDd26v+LGJO+QX95ewLDBM/9SUrxvjy3AkxMve1547NU99x4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083787; c=relaxed/simple;
	bh=i0wVsjjfiwpmEdymOOL7VT0RwNY7PjhAPz9kvqEJd8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GCu5CR7FakyFtJJE1L4Fa/9qmqXKQFjw1NuHBYeL5wq7qVtxX3UeAmlwZv2xxJ6NzJ7hs3zWqPc3ub9P8abBtXkqAb6CA4g4vKHJ6VLi6wv2oZtggauW6XuJpcDBdef5fWHOUQ+aAHZegv+4bx/xYCSJRMrvJOgAUCyHUzRwhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v6wEnpqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kgi49st3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v6wEnpqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kgi49st3"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783083784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/Vp/LWVqQ/qQsU77myt4wLL3PES5CU5PgTieY4PMoo=;
	b=v6wEnpqYj4raRuoPuBF0KpmZ3mQZOo5w+Ym3raYYsSRWrdMoqlFqtEtuHxIJr6YWCsnAhL
	5CavmOqBzyN8nqBHWN+rVDOOtYJKaKJF0RnMM0r/RrV4yDhKYpltLvEMuxF0Z2uzYOqMJP
	0gVx7vEXPNqklJiyO61FwInD25nQ8gv7i9pIb16k2fbvJj0BC0ajdeQEuYEcib0xpx0SGc
	PlGU9t/W3eKtYmqhmyvJugQpz7ZCxwgx5WBuwPn9x7qSg3W0lpKujzcQAg+wrjDh4UTXaA
	Fi2kzjeBA9MNawD4XoIzF6mf09VcF2w4D3gBT+JMKmADgKsg8sbhTw12ZAkd8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783083784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/Vp/LWVqQ/qQsU77myt4wLL3PES5CU5PgTieY4PMoo=;
	b=kgi49st3132MeXMV0ooNIHRdRsOhUbkIkSVTSsC1S29JaY5aCfUbIGZAfNO0dyxLCgRL06
	4jYMe1eiughG7eAA==
To: sashiko-reviews@lists.linux.dev, Andrew Murray
 <amurray@thegoodpenguin.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
In-Reply-To: <20260630170903.099D61F000E9@smtp.kernel.org>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630170903.099D61F000E9@smtp.kernel.org>
Date: Fri, 03 Jul 2026 15:09:03 +0206
Message-ID: <87wlvcw7i0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-06-30, sashiko-bot@kernel.org wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>
> [ ... ]
>
>> @@ -3211,6 +3208,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>>  		*handover = console_lock_spinning_disable_and_check(cookie);
>>  		printk_safe_exit_irqrestore(flags);
>>  	}
>> +	printk_delay(true);
>> +
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does the expanded delay
> create a use-after-free window for the con pointer in console_flush_all()?
>
> In console_emit_next_record(), if a lock handover occurs,
> console_lock_spinning_disable_and_check() releases the SRCU read lock.
>
> This patch inserts printk_delay(true) immediately after this lock release,
> adding a multi-millisecond busy-wait delay.
>
> During this expanded window, another CPU can unregister and free the console
> because the SRCU lock is no longer held.
>
> When console_emit_next_record() returns to console_flush_all(), it
> unconditionally dereferences con->seq before checking if a handover occurred:
>
> 		if (!console_emit_next_record(con, &handover, cookie))
> 			continue;
> 		printk_seq = con->seq;
>
> Could this massive delay guarantee a use-after-free if a console is
> unregistered under contention?

This is a legitimate bug report (even without this series). I will post
a patch for this.

John Ogness
