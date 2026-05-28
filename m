Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60C2E7365
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 May 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983862; cv=none; b=LW7ENOToSqUWL2MpqtHa8pmXu87b1ev0xVL8NfVxNWBiut0nJ4vIZm3It9ub/k7vwcTSlBg/sUrsd3rVboYd6sb5aXKM3BQ1Lpa60BbDX5sXkTCiKtXdF2/70suC2gtoS0NEq0oJQ7ciyF+ex0uYlcf+m51t/EPAlggyXxC58B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983862; c=relaxed/simple;
	bh=3eQvAi+JnY18HZzTMnVefo405IJLJIQvvyZBy9td/4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNRQqDnrMPh/fpmCPuJOV9XGKB+glm/Apyhbzr3COMv/RQFWr5A0fyqWZKiwgGlrAZkprQtNGMd/tij0ekQGCex3oYKBe2ANO6BUYNDN9EYpwMCLNP922f5RL8LPpxwiCauA/zWbziAYhD4CO0eY9t5v1Z4a76+r+Mr35HIgB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=XB0Gxo3X; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="XB0Gxo3X"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d7f31215so750732eec.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 28 May 2026 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1779983860; x=1780588660; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYJ8jsoIX+C39boVptH4RiVMiQ0/kaxh2tJJVom94sM=;
        b=XB0Gxo3XN5PxVG1xcFm8Rz9Yq9P+sCaImQmh/uvPVgqcXTKD0ol2RNACcWASIbuhw+
         muzY+nrT6Wstbozk7Qqal3q+175xIC9oo6GC/3WZf22x4dxU+8R7DxeW9ByJw7kU/lDb
         pA56Q0Xs2DhhO46SmQGGENf+DDKk86+OChBxUk2XHusqDUhEfx8s9RWu7WBxbh6KbBMG
         FPtu4CkmqJSof0/6nc98D9Pu0VLhUeQNs7m2G7kf+qwaTTiAKhOF1KHizHhVWw7aqRG1
         wFHju43odhvF6mer7eijGgcNy0U41ey9VouDgfARtLUo1fgILSgj5oT5c0a5kisW8NRX
         B63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983860; x=1780588660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYJ8jsoIX+C39boVptH4RiVMiQ0/kaxh2tJJVom94sM=;
        b=LgZmB06md0i/AIGZoohX7Ps4hnbq38TQc9lx2qoH+LiZfUEN7dxAbnZNHj/8qq8aQj
         RM/kf8rel/gI6dIbpc52OiUZMxJXSLSxhBssPMN+bVR5IAHQClCxENbXjnTaQpyg330m
         4P/q9ZEKvDMarCnhEZaIkuslTjcY6KC6k1n1LoEVBqaOD+2HCdh3hcGzFCpR4pRGui8t
         q5HeGdgQaXCnwDN/unKLLV0ySToOeerAY2h/xsKFAbiWF7R00TXBbAlJ46rszDo4bbEC
         62HX8zv2IPa68NReH55kt6i9yKVRKuBmILCNlGZUGRG8XHQCgZ3+JUox4G0FHQ0KBH7p
         ZoYg==
X-Forwarded-Encrypted: i=1; AFNElJ+wfNs/L3LPLQx6hs2NURgSEIby4HvPyomr1u5IJsLMuu5U+7OQ8JTE7yeXr6wm9ugpIV+soI0GFh3WZaGk5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywna1FMxZml4IZWnZRrAPejPN81Zl92rlFvzlwZvEOIdEHgooYs
	RG4lSSiP2ua5ZOt2nZ608HEL0J20VWJBUEGD7bMdlMb3NLV5RP3uHG/N9ES30oX/yFM=
X-Gm-Gg: Acq92OGSAPUtCcAMRhLTivqhwT9AtgwIXN1R5AqVRJdA7JqdTzt2/ryEZdavn8+c7wk
	308DgBBLgcU74lKnB9Ep3TapRnOXE2C6P+EWmOPVNTez2XGvH8chDbPfhG2GKw5A1sNNc4bv6Sm
	Wnj/1Y3lRo2F2C1RKatW/Rqi36E6QLvOn4v6xTUV31/spf2WGZnScmJXjD96Q68PXaE1E1SmueY
	bcLaBWudnHsg+vDA5EOwVxb7s5WVD+CvGxQP8HO0wI1N2c/sykPxJ6WhrxpyT+8epbr7uupnlNq
	a4MCFFzMR/TYgY0Pdh1hUBB2CdeRSEeK3Jxf55ruEchZmi2k9HkhVZBPWE1L+8yEhvBnIEyBtw+
	MvHA8lioBvVXdLPHsViEDgZ6gtf5+NYWzKbjgmNMTcmDKMcFIW2dNQk9kUbLmtB5OU0G8nElegn
	Yn4JZCstcPYVNijjaNRqob5t2lr1qNsebvzGHG4uYlrRlUqq4=
X-Received: by 2002:a05:7300:b104:b0:2f3:3daf:3496 with SMTP id 5a478bee46e88-304490b7eafmr12367698eec.26.1779983860346;
        Thu, 28 May 2026 08:57:40 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:bcfc:16b1:27b6:2870])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30458ab1a46sm15599051eec.24.2026.05.28.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:57:39 -0700 (PDT)
Date: Thu, 28 May 2026 08:57:37 -0700
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
Message-ID: <ahhl8dZ-uMM8gmDO@mozart.vkv.me>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me>
 <20260528074939.7MLrIhrM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528074939.7MLrIhrM@linutronix.de>

On Thursday 05/28 at 09:49 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-26 10:50:28 [-0700], Calvin Owens wrote:
> > It does seem to be correct, with CONFIG_DEBUG_ATOMIC_SLEEP I get:
> > 
> >     BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> >     in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 31, name: ktimers/1
> >     preempt_count: 1, expected: 0
> >     RCU nest depth: 2, expected: 2
> >     CPU: 1 UID: 0 PID: 31 Comm: ktimers/1 Not tainted 7.1.0-rc5-00004-g85f7c8ee247a-dirty #3 PREEMPT_{RT,LAZY}
> >     Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
> >     Call trace:
> >      show_stack+0x1c/0x38 (C)
> >      dump_stack_lvl+0x58/0x78
> >      dump_stack+0x14/0x1c
> >      __might_resched+0x128/0x168
> >      rt_spin_lock+0x34/0x180
> >      __wake_up+0x2c/0x70
> >      pps_event+0xdc/0x2b0
> >      pps_ktimer_event+0x44/0x80
> >      call_timer_fn+0x34/0x2d0
> 
> This is all threaded and the atomic contex gets here due to the lock
> swap.

Yes, I thought this was from a threaded context.

> > The lock isn't part of the lifetime of the pps_device object, so I think
> > fixing that really is as simple as not holding the raw lock across the
> > wakeup, something like below?
> > 
> > diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> > index dc7fac75ec27..f85929d01e3d 100644
> > --- a/drivers/pps/kapi.c
> > +++ b/drivers/pps/kapi.c
> > @@ -203,17 +203,16 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
> >  
> >  		captured = ~0;
> >  	}
> >  
> >  	pps_kc_event(pps, ts, event);
> > +	if (captured)
> > +		pps->last_ev++;
> > +	raw_spin_unlock_irqrestore(&pps->lock, flags);
> >  
> >  	/* Wake up if captured something */
> >  	if (captured) {
> > -		pps->last_ev++;
> >  		wake_up_interruptible_all(&pps->queue);
> > -
> >  		kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
> >  	}
> > -
> > -	raw_spin_unlock_irqrestore(&pps->lock, flags);
> >  }
> >  EXPORT_SYMBOL(pps_event);
> 
> This does not work because the commit message claims to allow
> pps_event() to be called from hardirq context. So if this is called
> indeed from hardirq, context as claimed in the commit message, then
> dropping the lock early does not help here.

It isn't called from hardirq AFAICS.

> Does it need to call pps_event() in hardirq? Patch #1 takes the
> timestamp in hardirq deferring the remaining part to the thread. What is
> the crucial part here that needs to happen in hardirq context?

This is the artificial testcase which just uses a ktimer, it both
"samples" the time and calls pps_event() from the same timer callback.

But I understood you to be saying it's threaded above, which mirrors my
own understanding. If that's true, I don't see why dropping the lock
early wouldn't be sufficient here?

This is what lockdep says on v6:

    =============================
    [ BUG: Invalid wait context ]
    7.1.0-rc5-x86-kvm-00005-ge4dc519be2c8 #7 Not tainted
    -----------------------------
    ktimers/0/15 is trying to lock:
    ffff888107303118 (&pps->queue){....}-{3:3}, at: __wake_up+0x1f/0x50
    other info that might help us debug this:
    context-{5:5}
    6 locks held by ktimers/0/15:
     #0: ffffffff82c3f540 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x38/0x230
     #1: ffffffff82fd7340 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x126/0x230
     #2: ffff88856bbd93e0 (&base->expiry_lock){+...}-{3:3}, at: timer_expire_remote+0x42/0x70
     #3: ffffffff82fd7340 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xd9/0x1a0
     #4: ffffc90000083c60 ((&ktimer)){+...}-{0:0}, at: call_timer_fn+0x68/0x250
     #5: ffff888107303540 (&pps->lock){....}-{2:2}, at: pps_event+0x3d/0x1e0
    stack backtrace:
    CPU: 0 UID: 0 PID: 15 Comm: ktimers/0 Not tainted 7.1.0-rc5-x86-kvm-00005-ge4dc519be2c8 #7 PREEMPT_RT 
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x5b/0x80
     __lock_acquire+0x896/0xbc0
     lock_acquire.part.0+0x58/0x180
     ? __wake_up+0x1f/0x50
     rt_spin_lock+0x32/0x1a0
     ? __wake_up+0x1f/0x50
     __wake_up+0x1f/0x50
     ? assert_show+0x40/0x40
     pps_event+0xaf/0x1e0
     ? assert_show+0x40/0x40
     ? assert_show+0x40/0x40
     pps_ktimer_event+0x48/0x70
     ? assert_show+0x40/0x40
     call_timer_fn+0x91/0x250

If I drop the lock early, lockdep and atomic_sleep are both slient.

Thanks,
Calvin
