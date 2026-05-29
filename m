Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4D3CF69F
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058284; cv=none; b=J9s1TYdCbavfePg4BbG7MCKZHbAPTYn1oNlBXT/KurEiLaF7MBOByNpIle+HAj++ks8W4/TP5L+4DJAqEOMVwR1/+MCKIiPSBOIZXP4O2E97qwxc1zyJbuMZ5ff+GHiiP46puDSk3nee01VFEm71Su3NEHAK4lUPYQ4D9uHPGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058284; c=relaxed/simple;
	bh=G/NBeGxpIz2+MIXnXDS6wFn60/XahnWEL0wJaYcD/3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRS9hSJO+OwFr2EMQZXsn0hRKmOS81Zapupvhvy6y54kdGwFFeqpNazKXPp8nx9beZt1txQO9f22MWUkT6VwGUPJQ1JilMFAPIEPARRDb1nlMrxrtpGQc6m29xfh/KW3FciRjWQ7VN2WjVmRfyf2yDsEcsVKhP8qUjFuri1/WMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=IhILrC7S; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="IhILrC7S"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304d8e3bb72so409405eec.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1780058283; x=1780663083; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zn+tNHxxo4Bb1V1FgNrDi61FU3epwQvLPA7hIw1rx+w=;
        b=IhILrC7Sd704TyFcRz6wjTw8NqEbuZJA4Mm72vSQWRNY35ayT4fDk17ZAb/GcLSXav
         35lYX+trE2ny/o69/7Ik8p+ReYKkB7lTQJGUE5sswMDfcYVjqJOA5qo2C3xOUeg91SQc
         L0JUaDFlt++eTWHb2zwRrheuy1FJu+oDkz+C4dbJhWHedYO5l9xpFAwhv+9AvlCygo/Y
         C9oEC5zrIg0X1sKjUU1PA17z0teuR9grXmhIKE8eQGt0GuOL+2hWhnVQz/tgkoVbcW3q
         0Y7wkJNswEs0/OlSbMuUZ+UQhjYM329U5r5swDC6U/LCwgzwiHeClAxXU5GbC7Jbu7Xp
         cTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058283; x=1780663083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn+tNHxxo4Bb1V1FgNrDi61FU3epwQvLPA7hIw1rx+w=;
        b=OuDODeDbAKEO7dzYFVl+qN2nkAcIo5ILdNwfquFrmgu6npDJJredhcWNw/ozxzzVOS
         mOC9ORWOLwYrRWnmoWWk+c8vyvb3Z3AT2MMwzhIfxLPdC1pHkWqHhm1+t8wW88C6Vcki
         mmZvtLytQPK39yPYhbW8H+G8g4362iwAYG4Qi5m8FSAPzrGjmQVBsVQAMHawcvxRTg2R
         RwqBSTTmaWCFZMe6BmM6A47azhHmrU3SBZZHb0Bu4HVqwnaO4oVAX+y2cvq9lEqTuIMY
         hZ/KM19BdEQQBf1Ys2ELk2ZBdZ82rGKGJT67qEwvzfxI1KdfKbuI0rQ2oiznmP4lfWmR
         OkVw==
X-Forwarded-Encrypted: i=1; AFNElJ9TqY+/8RZo76skoEgJhPj4vxUd1e3Qxq3Zs8jIvmJEfizNgXWMdNc+KyI2Vu4qMcvbXo/g1I8O6oBwdfqZkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFfzHDf8eLKIJ/mLvJwNO1KI96o74sI3Q0vvAtROD3LqDjTrkK
	faTn1I2EzLvml9/MinoBujrn652ak+tzLCNGrncwdNp3UqZ2pMlwMFVDUCCi8R7pnZc=
X-Gm-Gg: Acq92OEJLEg+lOlQT+PgnsBfemfQ9MFd2GgM7XNvDPa4YDAMaEdLTzRS4KRp2FaEwyO
	nxMv6kyBs/s7ffvS/31AFU4j4u7OrpSJKvJEml6wJolCWI//JNlkrCapF+VavV+wdCFXKmCrWmz
	jKKtCsJpl96vo9GIkUUA1NmEtoKt3mk3Zetuc8jKHubL18ploYtOOEJEu0e8k6ozmbYyFSw5wHu
	2mdfmol0RPG7pY44ioFIHtPK5SXO88OwbQSNfKU3DLREBwk67+KLBzhuNXz4dz2qur7z1+RsoBA
	O2WtFGG90J8bIjCBq81FAl2aL0wN9EHbuaVmckWHLmXleDlUlQK9zxo69Z4Bucs+VX77E3a2UFg
	Cd55M7X2mtq/l9gAN659AU2rozakO59wfckllmPYyT2PCd0ciGDr1YAmtLhukP6SyImQsH+1Vzr
	tsr3hJpxX6DJeW1a51xuXSMG6yppXHILsn
X-Received: by 2002:a05:693c:3003:b0:304:819f:502b with SMTP id 5a478bee46e88-304eb133f8fmr1248265eec.9.1780058282618;
        Fri, 29 May 2026 05:38:02 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:c380:61c0:1acd:c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a9d27sm1255863eec.25.2026.05.29.05.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:38:02 -0700 (PDT)
Date: Fri, 29 May 2026 05:37:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>, linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v6 3/3] pps: convert pps_device.lock to raw_spinlock_t
Message-ID: <ahmIp6lEjoiy-EDJ@mozart.vkv.me>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me>
 <20260528074939.7MLrIhrM@linutronix.de>
 <ahhl8dZ-uMM8gmDO@mozart.vkv.me>
 <20260529071931.nSO7Uqb2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529071931.nSO7Uqb2@linutronix.de>

On Friday 05/29 at 09:19 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-28 08:57:37 [-0700], Calvin Owens wrote:
> …
> > > This does not work because the commit message claims to allow
> > > pps_event() to be called from hardirq context. So if this is called
> > > indeed from hardirq, context as claimed in the commit message, then
> > > dropping the lock early does not help here.
> > 
> > It isn't called from hardirq AFAICS.

Sorry, maybe I buried this short reply.

> > > Does it need to call pps_event() in hardirq? Patch #1 takes the
> > > timestamp in hardirq deferring the remaining part to the thread. What is
> > > the crucial part here that needs to happen in hardirq context?
> > 
> > This is the artificial testcase which just uses a ktimer, it both
> > "samples" the time and calls pps_event() from the same timer callback.
> > 
> > But I understood you to be saying it's threaded above, which mirrors my
> > own understanding. If that's true, I don't see why dropping the lock
> > early wouldn't be sufficient here?
> 
> So lets look at the series:
> - #1 splits the handler to take time stamp in hardirq and the remaining
>   work in the thread. It seems to be crucial to do so because doing so
>   in thread breaks something. Okay. Granted, makes a bit of sense.
> 
> - #2 ignore for argument's sake
> 
> - #3 says swap the lock so we can use pps_event() in hardirq context.

I interpreted that as saying "swap the lock so the lock can be safely
acquired from code running in both hardirq and threaded context".

But looking more closely, it doesn't seem that either lock is ever
acquired in hardirq context before or after this series.

So I think patches 2 and 3 are unnecessary.

As a quick confirmation, I tested only patch 1 on a bona fide pps-gpio
setup with lockdep and atomic_sleep and saw no splats.

Patch 2 suggests tk_core.lock being a raw lock was somehow a problem,
but it's never held across anything, it seems fine.

> Now. Why or where do we need to use pps_event() in hardirq context?
> If we use pps_event() is used in hardirq context, as claimed in the
> commit message, then dropping the lock early here does not help and it
> will lead to the same splat in wake_up_interruptible_all() because
> interrupts are still disabled independent of the lock here. It is
> hardirq-context after all.
> 
> You don't see this warning in your testcase because it gets here from a
> timer, yes. But. pps_event() can't be used as-is from hardirq context
> either.

In pps-gpio it's called from pps_gpio_irq_handler() which is threaded.

In pps-ldisc it's called from pps_tty_dcd_change(). That is called from
uart_handle_dcd_change(), the uart_port lock is a normal spin lock and
is held over the call, and it calls wake_up_interruptible(), so I think
that one must be fine (I only looked closely at 8250).

PTP calls it from ptp_clock_event() which itself takes a normal spin
lock, so if that one wasn't safe people would get a splat already.

In pps-parport it's called from parport_irq(). That is called from
parport_irq_handler() and mfc3_interrupt() which both look threaded to
me.

In the testcase the earlier trace was from it's called from
pps_ktimer_event() which is threaded.

I don't see anywhere pps_event() is called in hardirq context.

> > This is what lockdep says on v6:
> > 
> >     =============================
> >     [ BUG: Invalid wait context ]
> …
> >     -----------------------------
> >     ktimers/0/15 is trying to lock:
> >     ffff888107303118 (&pps->queue){....}-{3:3}, at: __wake_up+0x1f/0x50
> >     other info that might help us debug this:
> …
> > If I drop the lock early, lockdep and atomic_sleep are both slient.
> 
> Yes and might_sleep() would yell, too.
> 
> > Thanks,
> > Calvin
> 
> Sebastian
