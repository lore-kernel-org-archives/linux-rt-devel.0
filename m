Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1C44BC91
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522444; cv=none; b=Tm6+D46d2JCy4BrZ03+bjEjuMAm3rup+k7IGUQNHO2fqqLXHVLFk1yNb3tpEusiCwTqGOXEhnbevXkijScsa8oW+NGG1Z6yIE9PRiZGX1A3GlLwnQ2WyN6y+IYYiksFgOgH3hQYWq8W2zyy17Xh1G5g7dI2Q3FDQBSEzOPhIkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522444; c=relaxed/simple;
	bh=ZR9JzMNshGYeFuHvZKFIl3qBflNkGq9LavCpGJg7rqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=baWDohUv4LoBXEguPOdMavzzdgNHDrHSRUEvaCPjh8kfJ8j3zne9CIDWf9MvIPy4T4la8xNBcELwCC7zmZNfVB8XVfnfpwBZMXu3PYa/1alr+uVlaYm2BZ8ofvA44NvMOTFULT781Pim+DgzY/Ez/dG7YfRT8xH6ALZw8U4oyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WpLRTgKv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t9ji51pJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WpLRTgKv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t9ji51pJ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783522438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3VGnXCa8/+c+qXxxpDN0SzecjTWYnKYnTQWIaynhzc=;
	b=WpLRTgKvqxcp6FYh952df/n+IomBdU93YPgLSN0mmevxMFmXWgFd6nWPQeIA3zWNoP6kSQ
	neIkQIOanLS4Ekt9VH9fQ3iHSMv3O3Pm3mJnFQDYq1dhAnnnyJY0A/t+Mxs7rYQhMeqAZS
	EyWQ9u1VfKxeJKJCCtpn8Xy4TPtvbTg5IdKsUT4MiY4e4w5zUGLC/HGAABQMtkyYEpRZF2
	aK7IOmVyQwpAD9RutNxvz6NZ1jY2yitTw75cEQmd/84vJI2Y00+RszK5YoHyAc01DLWwxz
	vLlOruTCeeNYWHe22uiI9yc24cwBOV/ejJ8W2e4bA9BXu+cMRrlwlVb4hf8qIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783522438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3VGnXCa8/+c+qXxxpDN0SzecjTWYnKYnTQWIaynhzc=;
	b=t9ji51pJCgLujO8YuF77uRSc/fBfpumhfWE8RcPnNA3u0g700c6Qp+4PIL1DE10oy4ZDiT
	BfnkJjMTr5jmJlDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Benedikt Spranger <b.spranger@linutronix.de>, Andrew Murray
 <amurray@thegoodpenguin.co.uk>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
In-Reply-To: <ak5eCp5qw9LYrnAH@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260703165654.71be8707@mitra>
 <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
 <20260707145411.53a10893@mitra> <ak0VguIf-PxmbUOS@pathway.suse.cz>
 <87qzldvqpm.fsf@jogness.linutronix.de> <ak5eCp5qw9LYrnAH@pathway.suse.cz>
Date: Wed, 08 Jul 2026 16:59:57 +0206
Message-ID: <87zf01ttve.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-08, Petr Mladek <pmladek@suse.com> wrote:
>> The synchronous mode would rely on the driver being nbcon. I envision
>> something like this:
>>
>> ---- BEGIN SYNC IDEA ----
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -1200,7 +1200,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>>  	cookie = console_srcu_read_lock();
>>  
>>  	flags = console_srcu_read_flags(con);
>> -	if (console_is_usable(con, flags, false)) {
>> +	if (!(flags & CON_SYNC) &&  console_is_usable(con, flags, false)) {
>
> The dependency on con->flags means that the sync mode can be entered
> only in task context where synchronize_srcu() can be called. It might
> be good enough. But I am afraid that people are creative and would
> like to have even atomic variant sooner or later.

You mean it can only be _modified_ in task context. Yes. I expect it is
either specified as a boot arg or modified via some sysfs interface.

> Also it will do the flush in NORMAL_PRIO which is good. But it might
> fail to get the context ownership when it is blocked, for example,
> by uart_port_lock() which might be even sleepable context in
> PREEMPT_RT kernel.

Indeed. This is the same limitation of the atomic printing in
general. But I do not think this can be worked around during normal
operation. Ignoring locks is not an option.

John
