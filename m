Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53A3F1654
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697574; cv=none; b=l/xPNMVaXbadpQlDGwhf41SktFkh7qnojCxfKB3arwjj3dhgoXhoRMU6oMFWNg+imEJcR82eoVJE9h9Nf/AhafWiZqTrpF2/nLZqJV3Tj1SZZvYH4zbAcve4qGxnD1KseIRL/QFzokVRwHUHw3HkVLr810eHsRQKQ8O8FEtDr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697574; c=relaxed/simple;
	bh=cvsxccTzFVOpMQezm4HlOWz2aB8KWwD6zxOBa9D3eA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpb6u3lUSy2w5Ncewof5g/AdDGSdEQBUzZJrv8WhaR/91/XWdRugmyJWpyRzVIwn5X1I5emI7RjWVv5Yet3dK7E2RJd1mFNCg5HpxCf7f8k2lHuY0ilkLgGdo7eFFxfYbF0ZdjLszliJ6I6WiBox4PUh2+W4ibE3C7W76GMBuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IqmE9WqT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IqmE9WqT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso8542405e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781697570; x=1782302370; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFy1siI5GPA02P4SigwJOvEY2/GCKPj1mDQV6Az/rvE=;
        b=IqmE9WqTTG4jaz44lcRhibLWHxPAJ3cQpvB21LIJDjSdo9Dn9LSvTHsi4G9UEd8eYU
         4armkfXjUeECGImD6LZ36FqRg7SqB5/NHrLVveaOKv5gI/G4WQc/qZjYJ7ZXHZGuuHqT
         xYItqs6PPu0uMqo/6c8+dmEi7RGlBqY2nEHnY1uAvopmx0GCpa0g9gLL8tVvDB9klKB/
         jnggam/FAM8xrXoO+uFr+AcFwfJEAkTbhVljEuBWLOkY3bVZdJJxSd8BdraOCS0dIyzJ
         aU3Ex3sVkpr2cbJoGpZxG5VaVdrzHBNx5UstQzIWqilx+hpNikQVPitZdpM+D99a5oWx
         IE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697570; x=1782302370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFy1siI5GPA02P4SigwJOvEY2/GCKPj1mDQV6Az/rvE=;
        b=f9OaDhfsZbqMjNSfHy5wcA8KMcYdBBlMnsGNUXQIhdT1bnofpKQyY1LbA1++UDOED2
         T2cRXUQyxDFUu9FIH0z7AYkNn6hZAy9CSTONODHfC/fdGQkV3RGD3xcCvZMoTAJuAJ5/
         30uBFKsFH5bc9bnTQp6PBOijkByCE9qLlq99JwKOkRraXXM+IuL/CGlVt3vCnqFqDeu8
         AuxqCbfCKNGfm4cFztbTLqjOhmJ4CaH/PO7pHCEWE5Mzund8b5pDkhEUBZlwOOaPoxqM
         CiwaHv8DIMGKXhQwnvfNhfgoNJdjt0wPGFYVo+hKXwVVATBGgCm3hznVH9SgphUbpOT6
         1WXg==
X-Forwarded-Encrypted: i=1; AFNElJ/43UvBL32qsVANWZW75Cu1OQ2C7NdvtjpXP+4pssIaf6WVvB6I1KIFiJgchKVBE2RvmV8aEofISQQ4oYc2Dw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/GUvJCvCat1COFyY2pkwqyIRAJxj0KP1L96c6Y8awD1CMJS8s
	28bAWS0Axag8BHPYcGpgfo6Yszf8vJuBMGjqFyPXb3xAvroZvcyGRunVF2WWFJ6B4ZM=
X-Gm-Gg: Acq92OH7/iAh6Nbfc8UVu7ekNHbot5LSlIvCm4YqCnCZXy/LhOoK5EYnsKNKB5gyu7H
	99Abp+mI5sE4h3TjsbZPTnRn5xYM1Wdx1adDP6+mMuG7EHxXtjW6Xm5OhNqQQap1HPc+COWL0nS
	uxeZlOc3hT2v/PbKfPVHuqJnxDyUuOXHpAPBPhaEzJdDge51Wv4Db3N/25Neol51HPmMIdGiDoH
	JZVUnpLQeKQQnIdLwi1nKQ79wrU4aX/bRn96cm4cgKMKy8P1m7Z6wj9RKTQXHgvvFcqFZTUIrGH
	oPxaLmpvmcbQ6C35UGSiO5u3sFQ3S5MxHUCvI5YU9awWanx7ouqwoGYw46iVNt7LCDGMptAQwvl
	Yap7JcDrUqPAnwcENNEP7rttsvrprRDMJgS01m9+1zUu2hq3l1qGfOuIARaUaDAclVEfqMSpN2X
	ckJuOekTVpD3FZXoo=
X-Received: by 2002:a05:600d:8450:10b0:490:4035:323 with SMTP id 5b1f17b1804b1-492340e75cdmr33496715e9.9.1781697570289;
        Wed, 17 Jun 2026 04:59:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm48879291f8f.14.2026.06.17.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:59:29 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:59:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ajKMH_LmiZhjNlOW@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
 <ajJy92ES-Q8ro97A@pathway.suse.cz>
 <20260617111504.GK49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617111504.GK49951@noisy.programming.kicks-ass.net>

On Wed 2026-06-17 13:15:04, Peter Zijlstra wrote:
> On Wed, Jun 17, 2026 at 12:12:07PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 17:31:22, Sebastian Andrzej Siewior wrote:
> > > On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > > > > 
> > > > > Adding sched and printk folks for opinions while eyeballing
> > > > > WARN_ON_DEFERRED().
> > > > 
> > > > Thanks a lot for looking into this! To be clear - the printk_deferred /
> > > > WARN_DEFERRED would be just for stable? Or there's still some
> > > > sensitivity even with nbcon?
> > > 
> > > We already have printk_deferred(). WARN_DEFERRED() would be new. I
> > > *think* this is not limited netpoll/ netconsole but all console drivers
> > > not using CON_NBCON if the printk (via WARN) occurs with the rq held.
> > > I don't remember all the details but printk_deferred() was introduced to
> > > circumvent this until printk is fixed.
> > 
> > Just to make it clear. The problem with the legacy consoles is that
> > they are called under console_lock() which is a semaphore. And it
> > calls wake_up_process() in console_unlock() when there is another
> > waiter on the lock.
> > 
> > > Once we get rid of those legacy drivers and NBCON is the default we can
> > > get rid of printk_deferred() :)
> > 
> > Yup.
> 
> Can't we push all the legacy consoles into a single legacy kthread? I
> mean, converting all consoles is of course awesome, but should we really
> wait for that?

I am afraid that converting the consoles one by one is the deal with
Linus. I could imagine to moving last few sinners into the kthread
when the majority is converted. But we are far from there :-/

Best Regards,
Petr
