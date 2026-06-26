Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E23F23D0
	for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489210; cv=none; b=lVQxxcMcUf7hrqfGNekDFX8PVcJA+DdTLOZCGXidi5Bx7R3QZNL7caUyoegnVNsaRmqMxyABMm8k69r1S5keb6nmO7I8jCM9dvrCn441RanYii2e0a+qGLtNBu3wwU3sEQXs/bWzshllmRneG9QcmfGltPB9agjciNP/mEnGGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489210; c=relaxed/simple;
	bh=9RF1KgpRJzVAJ7EKBMOO+N0Mzn9cN7TfE0w9YRWXN+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hoh9HiW88MJGRvpUUq/5zcU8mJLTu+b3VwCFUnqcD9aPXNsY2Lr50vaELfArKCNNRhyjr5ZR8SAacmpKx69BCesrj3Z0Fmj0kUC+WKJ2ZpQiJcgGIBzUJU9m1LlsBhAXsRhz2r8AN/JJWmJep26kdr/EO/ruxB3woEqDks7hQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fz4iET1z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fz4iET1z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-464192ab2e1so787758f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782489207; x=1783094007; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnmL4YKjQTqsAYZ6FQdKoT9MUZZ6vTkTBWCeGCu3EwY=;
        b=Fz4iET1zt1aykH8UnosUqDt3RaWWMkiVJNMr8GMWz8fS0ZXGcgX3YZbmsRc9Qa9kaV
         ogwdQ5zwaEJHmdZ5BfREtAcBMABlv3qv50+5IC5s5MU7vkmtVQ3+fOTwHg1hFUr9JHr5
         94OD9EmC2uYQZ40yOWoYqeUmeegP+Sf+SF+MfQbhhET61lZVj+i7vw1H8BiqWqOXE9ij
         qGLksi5v2VNmtkds2mmoVudM8Zphh1oZTgQnV7ftvEk6s3UfOkJyQ38cy9gcKSxvvT4f
         by363kCVok/l2qWie+XSLcdg9UFRTYbWc5DZh5Fudtq0EvdeHFDBPWtwFQM65QMpXgcF
         AkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782489207; x=1783094007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnmL4YKjQTqsAYZ6FQdKoT9MUZZ6vTkTBWCeGCu3EwY=;
        b=Zk01SQB7wjfhglYJZRJaCHipP56uz461EbGMcfcaZZE8F6nxyTujVcJLyxP1WEtGJI
         kRa0YOYyri4GIlf+tDThlduCu7cwD7ykbbRS3A0rwxZBIZLvQ0Cson64dVBzEqjdNeqR
         KbU7aruUGUlxmB+IC+hcIZg5D09Wp/OIwtHje2yhjuQyVCUUZM0ks7LMpBL+brP7ynaA
         rUFwwLVeH+G6kmCqDDYrUqc65k8hxW362Wfj/FLxDqXghE/ZpS+AHcgH1UCXwGZWFH2h
         OKhpPBVK6M7v4iuslb2pHM+DNXWdQcSTorWOH8zcxjfr0l0mfx9Sghyvt6xCMbF8CqhQ
         EKig==
X-Forwarded-Encrypted: i=1; AHgh+RoYhzy4CjtYammi6j1PnoCY6hshzp32fVTie8OD7twNEC/ljXjEGrFKHRXOURYWzJ9BQIk0eEIbyN5rOzve/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhkqJSa1KXXk9854rhu5b3H5BtKTzSFRzWQxq3woSJ5FdYvKZB
	qlxWaC+9/frEmgr0apwiJsewwnVz16xvdh6bNyQkDC3/cY4zRlIDmrRHbFXrDpzbOWE=
X-Gm-Gg: AfdE7cn+4aCymndS7Za/1M79heXD4HxPUJu/xCZfpQtRB1HxuCLQ860Qh8Gr9HVOhbW
	aLiq7r0TjfwcDfiIMLbyftjvUQRkENPACOxabDC+CrnO79twUP4yJGgv1Q4e342nYx2j2iNEUE+
	uS8pDDBZ3AdlNGSFmzXEE7+TS83NN+RBb5jtIc2xAZb5iCJSeTTTmqyyw4uuvi8fMr0NfbEFtQb
	pIk5Fylx4TMJQ6PtQQK3V5F75MEhHVXtlJSdxV6A6GU4T+YxP0+J+Ye1gzCFwolgchFDVQUuGQI
	qI5rbJ33JszX/GOIS+XqO19o2yDtGKC6t3sDUqOHJYoj7nwF5Opp8ZJyMcfHqXAnMs84y3FnIEu
	ctRE8NNBvkmZxa8ahX1OUlhjCQ/KyWByiv0XuIJimQADVHeiPS0DM6LjJZRyDSwqUm5h/NsV5T7
	0ITgPjQXvgfiLDen8=
X-Received: by 2002:a05:6000:4692:b0:464:5df5:332a with SMTP id ffacd0b85a97d-46dc14cbd7fmr8903578f8f.34.1782489207418;
        Fri, 26 Jun 2026 08:53:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b85csm24201068f8f.28.2026.06.26.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 08:53:27 -0700 (PDT)
Date: Fri, 26 Jun 2026 17:53:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 5/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Message-ID: <aj6gdH2KS_XrNjIm@pathway.suse.cz>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
 <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
 <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>
 <20260625145115.KZ9l1-lv@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625145115.KZ9l1-lv@linutronix.de>

On Thu 2026-06-25 16:51:15, Sebastian Andrzej Siewior wrote:
> On 2026-06-11 12:09:08 [+0200], Thomas Weißschuh wrote:
> > > @@ -864,7 +864,14 @@ static noinline_for_stack
> > >  char *restricted_pointer(char *buf, char *end, const void *ptr,
> > >  			 struct printf_spec spec)
> > >  {
> > > +	/*
> > > +	 * has_capability_noaudit() may use spinlocks.
> > > +	 * Make sure %pK is only used from valid contexts.
> > > +	 */
> > > +	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAIT_CONFIG);
> > > +
> > >  	lockdep_assert(in_task());
> > > +	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
> > 
> > The kernel test robot found a lockdep violation with this patch:
> > https://lore.kernel.org/all/202606110945.d3871219-lkp@intel.com/
> > 
> > My suspicion is that this is a pre-existing problem that was not visible
> > to lockdep so far, exactly what this patch is supposed to mitigate.
> > I'll investigate some more and try to reproduce it.
> 
> The annotation is "wrong". What you say "I do spin_lock() here".
> Then lockdep figured out that this lock is acquired under a lock which
> is used also from within softirq. This in turn can lead to a dependency
> problem based on softirq:
> 
> |       CPU0                    CPU1
> |       ----                    ----
> |  lock(vsprintf_restricted_pointer_map-wait-type-assert);
> |                               local_irq_disable();
> |                               lock(&ptr[i]);
> |                               lock(vsprintf_restricted_pointer_map-wait-type-assert);
> |  <Interrupt>
> |    lock(&ptr[i]);
> | 
> | *** DEADLOCK ***
> 
> If I'm not mistaken then this will not happen in real life because the
> hook callback does _always_ spin_lock_irqsave() and as such it avoids
> the interrupt+lock on CPU0 in this example.

Interesting, does the spin_lock_irqsave() even allow sleeping under RT?

I mean, does spin_lock_irqsave() violate the raw_spin_lock
vs. spin_lock nesting rules?

Best Regards,
Petr
