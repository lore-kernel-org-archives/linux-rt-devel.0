Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE539F188
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698398; cv=none; b=j14C4EnNsD9PVutYhJSgWZbJpNsSQYquO85icXIL9fNyC+yk0hll6/pCTFSY1hmZhY9nbcFaJZJSpp2OiTRQzj9MhbwJBsTbBPRqd/RkNkATpg/sehUdnyMyFgIHKt5PZx4BrUL8XAfoqYqeI57OBKNX7ujXf5vS9qfNdTyqlvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698398; c=relaxed/simple;
	bh=drQjluxR83utrv7JFzAl3tgoSzQhMivNx3FdMfRDDGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxou+WQK11KwoBL5kf3kMAnfQN6uFxWA+beR23rryu1KBQ0sZcBnw4Z3AwTfanktl7FWhOiseT+iPM0A1KCDbt8/ZDva4jJhveidcIvtK/EOt/TSkkMYgwL9BUAHRXhNJb0tz2AvhKElhYBGY8WUbWh4GADa9VZ9OFpeegYBZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cSHZ92PO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cSHZ92PO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso7284265e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781698395; x=1782303195; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3Of6hY+HxCVg/UtNEg6WyP3LTybOpcyjydWiZNY5Yg=;
        b=cSHZ92PO+i7c4hHMZy2+CpnoesVxXqEkJsEXd27Zqeamo65iD6pzf2SYSG5QVHge3Y
         RSc0nIlNSUurAqkY1kVdGDG1yyJitjpBxNWYDYwzNNyagZgfQ3F8/h9dBy8acH9qlfpL
         cFy23MCPme5jzangdgS1I9VdrKScTR88XZMEgbnJRsI4GiwOtANdraf/U0jTPW4Jsdx9
         /NOxqQQwKdP34mAf83FGVgg+0asXlkYkoKvN31RfK7QaR2yhQeyEsjSogA2ckja+y0CZ
         2I9DZsGrk6TGiOqRlvvenTLzmUOxkfeAFlemOfPzckFTjdeE11lMhIJOIO0+5bn13t7f
         otIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781698395; x=1782303195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3Of6hY+HxCVg/UtNEg6WyP3LTybOpcyjydWiZNY5Yg=;
        b=nqB5aSVQNi4lMXcFSZn6og+56rCqnZ/DLW3CzoCwX/v0P04FglrAFlWRw8d8GpCl3U
         zyb2fhCNj6221j1kcEq8MTsI6Xuh4xJOhlIG97cyaGhXIVtZuFv/hXmaF/f2TyBVdydh
         4h/sFizN/cTxSR7EGjGulG+8DanTisq2MM6xzW0GUqqBsNhv0biwsNJfdNmzbtBeGOtr
         OWNBO2VtrTzAD7LG6o+7CUGniu0nnidhZYq7S4NB8V/ON5Jgv3pTpQ6vJ9d8CrEGW1sM
         00PKPXrqNa8Ca7WMEOjZDQOZh86P6o893gnYJTaKlRbVbq+rFmc+jbJFZV/nIDVmLZxk
         ebuA==
X-Forwarded-Encrypted: i=1; AFNElJ/a441l+8KUc7trbNfacdU0UExjERjH95/z9wiWA1A5Jfo0RVyKUKyHFMcmo7fprAB4Xtu0CNuLq3bwofDXAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPundhM5UJTWJ3StMpU6+X7Sf8xcPpxS6HCRI7ezn3nXZqhlqz
	ryv7kh85QPsWqbLIlqIuPCCiYSxAjquLdTiRv1oq1xUsHEqJfG684dAhZBkOURnuIvg=
X-Gm-Gg: Acq92OHMO2xic0cq2QRVdgsdX9u01mSXnC56pRWcQPOZiAvSGa4llpcwWK3Xiv5dBI3
	nNA5idkpJA7P5LJn6FuU8ZvtpvbmTW5PKzAy5NPzpxpdzZnJIQK935vDgajIdE+56VKLhZvnRmS
	dFXHK2wyLd/CNKVogZMLkW13yDrMbaMwe1VpdnmD6N7dvA6oAY1nzLGOE8WynL4lKyGro+FlGO2
	dC7GxghE321IpSh5dKfAVAWAMI/Ts0JJUkSfRhvgfUhB5qrQGPTaJL0QZLswqXGUH40bAVjB17b
	mj9sRJFWmAzSQMzsJ/IonzDBhnTtcMcyJND4c6P5inExYRio4EDFT54EqOUNz7FO81hmd+SvfQj
	d6sEG+EPJMyVjevQKHYMr/JvlX8KhAfOs8mc2AwbD8Xg6vXcOFb3BkKaQEZNhfIGQQsoW+8EGb1
	ClS6Hag0OqkBvGeEg=
X-Received: by 2002:a05:600c:46cf:b0:490:b4cb:3866 with SMTP id 5b1f17b1804b1-492340e7632mr36603905e9.10.1781698395410;
        Wed, 17 Jun 2026 05:13:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47d1csm159343545e9.4.2026.06.17.05.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:13:15 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:13:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <ajKPWUtGfJj6tfPL@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
 <ajJ46o4fomfxY5CX@pathway.suse.cz>
 <20260617111958.GL49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617111958.GL49951@noisy.programming.kicks-ass.net>

On Wed 2026-06-17 13:19:58, Peter Zijlstra wrote:
> On Wed, Jun 17, 2026 at 12:37:30PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 14:17:19, Jakub Kicinski wrote:
> > > On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > > > > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > > > > to NBCON console infrastructure"). Because from here now on writes are
> > > > > deferred to the nbcon thread. So this purely about -stable in this case.  
> > > > 
> > > > Hmm, I thought netconsole had some reserved skbs and could to writes
> > > > 'atomic' like? That said, it was 2.6 era the last time I looked at
> > > > netconsole.
> > > 
> > > Yes, that part is fine. The problem is that netconsole tries
> > > to reap Tx completions if the Tx queue is full. We can't call
> > > skb destructor in irq context so we put the completed skbs on
> > > a queue and try to arm softirq to get to them later.
> > > Arming softirq causes a ksoftirq wake up.
> > > 
> > > We already skip the completion polling if we detect getting called
> > > from the same networking driver. It's best effort, anyway.
> > > Networking-side fix would be to toss another OR condition into
> > > the skip. But we don't have one that'd work cleanly :S
> > 
> > Alternative solution might be to offload the ksoftirq wake up
> > to an irq_work. It might make this part safe for the
> > console->write_atomic() call.
> > 
> > Well, my understanding is that there are more problems.
> > AFAIK, some drivers do not use an IRQ safe locking, see
> > https://lore.kernel.org/all/oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh/
> 
> But anything using locking is not ->write_atomic() and should be driven
> from a kthread, no?

Right. I am not sure where my head was this morning.

Best Regards,
Petr
