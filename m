Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA3D366DA5
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610476; cv=none; b=WyBZsIOqM40P3jhCF3S+7J+Tlpc2i7Nzl2wqw+nOVfcPHWuQwS4E5lIlcFV7iZc8FHhllC4VGpCrdKY3Zsfg8Hv4l96cFu0EWuozf/UStjyBn8SVjKtAz8WDbvAToeY9FbpQayoT7V5xK/fKmFz0gzJgEOQ0wUoyVkyVaeqHKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610476; c=relaxed/simple;
	bh=9+/P+XHbUPLPWvGhwXv03lbgWUb5sN9SZqDazJvnm5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8iyKW3KhwFci69Mw6fVPpxkkfKQCqhRPK02lX80OiC91TxKM9oGSo9Wf09FrlSTSj5oTnteKyl2Y1Y2OyMoF2iAslWLt6MflQZlaroJXgus/rWfzFSh1DASzijaWSi0EXdqb3rxBrTtaM4tLz0GybLm2PPKwmvGhZmOvqeOQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yPxeCtv7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bvJKA43v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPxeCtv7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bvJKA43v"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783610472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCvSGqbhj9/NhLA9ZbyAvA3dzoWQlSiAOLf8QjRL6Pg=;
	b=yPxeCtv7/v66gXx/D1fcRyKL1cphG+7D0+7gfqZuKG5TY3Lov3QxQicfiad2nf95WZilHe
	utDBJu89JL2Yz1xzvn/CqzATfh6OfU3NW4XH6tUL20l0tUE6yLZmhCajmqCiAIoLuyidOu
	D8WEMvAyXq7HJgmxiCJGnfYrMBsKrUU4S4Q1dGOk3PQZXhKlYD6v/GtkW2umOKDT5gsa30
	bxorj8UIbFEVTJRuPqQUX4Jje9dRhNgU9ho6TNhTcp1wnYlbMV1vsk/amHvLmPc0SOkf2f
	HCCzJjeXFQkCmLlYzKz8xyqkS4oA8LMfUjMKTsFtMNcH92sx+hk/Yq8JPgCduQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783610472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCvSGqbhj9/NhLA9ZbyAvA3dzoWQlSiAOLf8QjRL6Pg=;
	b=bvJKA43vE00gb5w8aGww1E5ceOM62dgrQ8tJ096LJSDDO76decZm7uufcWpQd/8ogpAWkH
	+ZRzcy3uOwxnWTAg==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Petr Mladek <pmladek@suse.com>, Benedikt Spranger
 <b.spranger@linutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Steven Rostedt
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
In-Reply-To: <CALqELGx+7RSKL0+kdOxu0TpXaOifYkzxmOTv+4gTSHqrbLEJ5Q@mail.gmail.com>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260703165654.71be8707@mitra>
 <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
 <20260707145411.53a10893@mitra> <ak0VguIf-PxmbUOS@pathway.suse.cz>
 <87qzldvqpm.fsf@jogness.linutronix.de>
 <CALqELGx+7RSKL0+kdOxu0TpXaOifYkzxmOTv+4gTSHqrbLEJ5Q@mail.gmail.com>
Date: Thu, 09 Jul 2026 17:27:11 +0206
Message-ID: <87jyr4jijc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi Andrew,

On 2026-07-09, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
>> The synchronous mode would rely on the driver being nbcon. I envision
>> something like this:
>
> Is it possible to apply synchronous mode for both nbcon and legacy
> consoles?

For !RT, legacy consoles are already "somewhat best effort"
synchronous. I really do not want to try to somehow improve on that. Our
goal is not to improve legacy, but to get rid of it.

> For the debugging case Benedikt suggested (is this the main
> use case for this feature?), it would be helpful if a developer could
> indicate a preference for synchronous mode without first determining
> the console type.

The developer is free to add ",sync" regardless if it is an nbcon or
not. My sync series (which I am currently testing) will simply give a
boot message that the console does not support sync mode.

>> ---- BEGIN SYNC IDEA ----
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 2fe9a963c823a..beb5bb3c037b5 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2456,6 +2456,8 @@ asmlinkage int vprintk_emit(int facility, int level,
>>
>>         if (ft.nbcon_atomic)
>>                 nbcon_atomic_flush_pending();
>> +       else if (have_nbcon_console_sync)
>> +               nbcon_atomic_flush_sync_pending();
>>
>>         if (ft.nbcon_offload)
>>                 nbcon_kthreads_wake();
>
> My interest in misusing (not proposing that as a solution) the
> emergency mode, is that the flush mode is nicely abstracted by
> printk_get_console_flush_type. Depending on how you trigger the sync
> mode, could printk_get_console_flush_type be expanded to look at a
> flag and return ft.legacy_direct, ft.legacy_offload or
> ft.nbcon_atomic_sync ?

Yes, I could do this, although it would only be "usable" for the
vprintk_emit() case. For the other two call sites:

nbcon_kthread_should_wakeup()
nbcon_device_release()

it would still need to be a @flags check because it is about a
particular console.

Of course, we could make printk_get_console_flush_type() per-console,
but that would be a considerable semantic change that would require
quite a bit of refactoring.

We can continue this conversation once I have posted my sync series.

John
