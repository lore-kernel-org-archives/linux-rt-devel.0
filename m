Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379E2EEE7D
	for <linux-rt-devel@lists.linux.dev>; Mon,  6 Jul 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357521; cv=pass; b=W6WUmT59WKtdrc/W0/GY0xa75QY+lHJ6YmHe8LExhof/uUdrDyO4XVnEtwLekw/Fr84TQrfBl3Oxwy+8Pr9hpWowZnPePcIlCQr1lsd2xWBCcKsfYQjKg47aWHCgDsizbX2OIWEeSaQppJ46gJFnn1AhfxN7cuv/ulGD9kzyOlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357521; c=relaxed/simple;
	bh=VO6PHtsgdagbB7FtJTbI+v2k78zEYcWzywMO5KXVgHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKZTuHk/w/9Fqu50EpIpyyUmfIZuhW+CkuN+xo5uM90wAc7dKlEvg3/Og9xr50gLH02e15efVaa7NWvlA4TGqdMJpbwBC1g3haLSIblO3w2lnLPBh3Cvtr4xxJAXaOZSGnlSUc7ezOq/XF+1q4fVhTobsxZQdGH0IhlHIz/SfhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=O47YKSVA; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="O47YKSVA"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-48751bd4abeso1180329b6e.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 06 Jul 2026 10:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783357519; cv=none;
        d=google.com; s=arc-20260327;
        b=UMzkkyrMDK/6uyNu0TSkuFz37zjtui7CFJ1YDhp4wXhTCOnMKDgvfDgWxWJR7An7nq
         KpMK/zB4tkFis+743An3oIiPdce0ZOrCkkDn/Qld4yK7tUuZfqPSrocmHgDPkcbF/C2s
         Ff8MecRun++aKCtie5IXmfAtc4ncDVp/r0InBO/EVoWkDIPgAKe/mJJteYNp76wcVaX6
         HeqfDrnOUgChLbj2DKcpsKhAyfGabfc9EFnmHYddH6emjjrGvLSInbo1mQkhmDChwZxo
         jYAq4MlSNy8LvhUcJToXGP5Z2vYSBtyB/GLQyaldwf4YUaB2bSwjT+t1ViL1ISdmuLc2
         6t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67X5LYINdi0M9S36BvC7qBNu0eKXvr2elw+XJ07fWOc=;
        fh=o9RylDXz0gv6PaBH7sB+5HnEt7tpN+itDc3MUn9+LPM=;
        b=ZrKdkSNI7jE+NNqL3Mgxb/OzR/siHDyux+4YnHR0lyMbJfyfxI1ULyEevGnkk2wJJg
         AA/+p6ftKDDBd4+mBlwxjstHsTOletYSSjq9TJAiL5fOTWPDGELWrewGJdmZs+CPy/DA
         lqqEVjdR1nMx+L0HMRkPhAwXhrhtMbRS1YOUlxtC8/C/PH0KLPgp1Xz3tuiOot9O3ZD2
         Fre2dOijblcsFsJfre0wqrTKZHAqcoPJ5efF7EpUmSpHDuN6AXHazp7NqbI8CWseA9oW
         x0EpCpoIHrqAfzV/ZOF81rw8NeRXKqVd3h8CIfDYA9GOTtZzO9pP+UgTWPvezHC/4+M5
         75SA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783357519; x=1783962319; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=67X5LYINdi0M9S36BvC7qBNu0eKXvr2elw+XJ07fWOc=;
        b=O47YKSVAqGaUuyWat8Ii/y152Zws3mgIOtVUVN2hPdNK+pqe/ZOHfffvY1FMuNPSP7
         /kQAl0znHzpuC/gClAFgKY5d/EKOkvfWq0BXhaYVF/qunPsCU53dXygKZHeBjTNuJCw3
         gL3uDKKcBkdxcEg7lX/NkioXAltmD/GpTqwwUDWxng8UITaYyIYEWIS9b9fpI91avLt9
         ei7HOp8kz39fvOLQoCa4LkP2K2fLY3Ap5tNgrcJ08INnxWE9oxm3y1hvOhZwwUjH7LoR
         sk592fcwcHv8PK9ElPmGJU8bgNRPUaTb4XkZX2CmSQOQ7551JVqPb2AlLbrblwxX/pH6
         6mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357519; x=1783962319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67X5LYINdi0M9S36BvC7qBNu0eKXvr2elw+XJ07fWOc=;
        b=ZkRNLlJzwJZETgMMjTDVgZA0kXboltibQ/Sv97QD1wltxlnRMT8NzkThlq9SwP7rc6
         k0Q7VvbeMwopR6YYQepCOTV+oXz5c5VWJJLhel+AwjtcROcETuXgXIfMj8YpegTr56bn
         5WSK+tU5oPPmhlEG3PxPKcIC/yT6TCvZYrmOGOxnTSv73eC46FIXgfiQy0NqkHXVE30p
         lQaj/4/N2cNn/J4bkOlyqlQhOa+GavCPeJvt7s96uOVrx8tg2+iUor/yik8ZYgmrg0v2
         gWaTatSlSTABtwJ3iyX7QOn+Pp0iwWElbTqNncryDxBEyFIaIfTC5oqdXnHQJH93BK1b
         PCjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MXIH+YFqO7/LE4VOn1xOLK7PBFiC3fKEt/6GnTz2IE1mTnpXV2MZu9CSsa3cDwqQEOqdhp21LR3qjOr2QtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXhazLcOcx0UKabQkxg2nHRtAwtQQheb8nVkLaadygSiPksuft
	LD1Q3gAZ/WerQYKnzSFZDTsKEXbMUWEjeebLDDttspmv+HJFL36j1RuJ6tDnS1a7/ZR+lCgM97A
	c1B0qqBW/ND2hykMHGNdCw/Eu32xayGpwBq/epk/xBQ==
X-Gm-Gg: AfdE7clW5wFavCVAcoB1Vys4rlylvrvnGH6QO4BaU6wI2o/TkOKZjLcMihSHppK9ru7
	Qss4ydfNM2PIq6p6sdDoMqjrEI+2la5ESh8RlFiYcO0K5w6/XQDzRUGZEYd6CkfjbfA/QtQwf2c
	1XrkPvrIE7veLQL6zgbA2em4f+EP3BtYvJEgh332VdBIYsulvTLDBUu2R9UkSfq09hPnjdIePKX
	iCffM1MSG3olkfD2BINgd6QmuRD9UW2n1991zg3XLE8EOmNbx3lltWndjqhQN+hfl5XCG+5MQTR
	WXaQO2wR/dIjqmMgEpUP9DqiR7Wp+C1xa7Mb5pfQ9N5cqSy7eZwUTQCRKG0qOzyownNjm6V1yVQ
	dcEGU9cFx48Fb0a2Ej62PTJNVX8k5
X-Received: by 2002:a05:6808:d51:b0:489:f088:5f70 with SMTP id
 5614622812f47-49fdc43fd75mr863942b6e.12.1783357518923; Mon, 06 Jul 2026
 10:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk> <20260703165654.71be8707@mitra>
In-Reply-To: <20260703165654.71be8707@mitra>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 6 Jul 2026 18:05:06 +0100
X-Gm-Features: AVVi8CcK4KThiGNbLieHoBIY_N240yIFnZsI-soA1OiCf8SyfTEOi9AvBW_Bzmk
Message-ID: <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Benedikt,

On Fri, 3 Jul 2026 at 15:56, Benedikt Spranger <b.spranger@linutronix.de> wrote:
>
> On Tue, 30 Jun 2026 17:35:59 +0100
> Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
>
> > The printk_delay and boot_delay features are helpful for debugging
> > as kernel output can be slowed down during boot allowing messages to
> > be seen before scrolling off the screen, or to correlate timing
> > between some physical event and console output.
> By now, it slows down the boot process, which is the handy part of that
> feature.
>
> > However, since the introduction of nbcon and the legacy printer thread
> > for PREEMPT_RT kernels, printk records are now emited to the console
> > asynchronously to the caller of printk. Thus, any printk delay added
> > by boot_delay/printk_delay continues to slow down the calling process
> > but may not have any impact to the rate in which records are emited
> > to the console.
> Using this feature to slow down the boot/suspend/resume process and
> implicit make printk() happen, is the usefull part of that feature.
> Imagine this sequence (which hit me on suspend/resume on i.MX after
> shutting down all secondary CPUs)
>
>   printk("A");
>   (do some stuff)
>   printk("B");
>   read from peripheral --> system got stuck here since peripheral was
>   not clocked or powered or both any more.
>
> The delay (and later on a ugly patch to make printk() synchrounous)
> helped to locate where the failed access happend. JTAG did not help,
> since the CPU got stuck --> no JTAG communication to that CPU.

I understand the use-case, you sprinkle printk's so you can find the
point where a read to a register causes the CPU to stop. This requires
that the printk happens before the read, and the output from the
printk is printed before the read.


>
> With your purposed change you *may* see "A", but never "B".
> Quite challenging...

At present you may see 'A' and you may see 'B'.

Prior to the changes in this patchset, and assuming an nbcon console
(which may not be your usecase, but is perhaps representative of
future use-cases), then the printk delay will always happen within the
call to printk (and always before emitting). However, depending on the
context, that printk call may return (and proceed to your CPU halting
register read), before the message is actually emitted to the console.
I.e. it's a race.

This series moves the delay to the emit side, as well as moving the
delay after the emit. Thus the calling code may make progress more
quickly, but depending on the context, it may also flush/emit before
returning from printk.

In my view, with or without this series, there are no guarantees that
you will see 'A' and 'B'. And in any case, achieving the functionality
for debugging required you to modify the printk anyway.


>
> So please leave the delay on the calling side - it is helpfull there.

If you want to ensure printk is synchronous, perhaps you could call
nbcon_cpu_emergency_enter() prior to your printk, or perhaps there are
already printk wrappers that do somthing similar whilst debugging?
Would that provide a more reliable way to guarantee output?

Thanks,

Andrew Murray

>
> Regards
>     Bene Spranger
