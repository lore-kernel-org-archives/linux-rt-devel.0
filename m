Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38F3812EB
	for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489975; cv=none; b=AewdJKSRBYi9/E9/1YI2PLHSLyjhiCWKWS1z5QBmP+xgkuxacfbxeeKfOoYtJGzlCQsXaFtcqFpio2N2BhXE5tlBqGGDYShLYmVw9gqJrKe3qDU7NuaFLIesHCUMTe+voVdhHUuQHmTMjeXk2j0W20JgjYVCo/wZWFusLjciDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489975; c=relaxed/simple;
	bh=qt5HD8bUfk/9ZmL23t0BwS0aectgMZVMUD7ozrAqS8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ3mdYARcbZ8TYA9+/c8vYmrnmYM+2ch3gbOzyEQO1JfME5TxzAKidEyhpGKAHR9btS0RNg3Dk8T9XhcEY0L9l/XvYIZuTA8OhuOL5KrNcopq1oQzrg4jj8k25mGk1avg1/8kVj9/wI3Jty1g0fsuUfuqfPDUxcaHY1ydQW74eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KycbdcE3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KycbdcE3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-462342ac290so1234094f8f.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782489972; x=1783094772; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cIyznuCJGHdYtVx6T4GJ4NqPqFSjKnRR9CX5npGDio=;
        b=KycbdcE3ncnVwjoyHwfkKklXhJPsazslGBRslIxBHch5jl1y8SAgBPXonw1t/nVR1l
         Rja0n04HilWwW5EIoEMF5HiDe5nq4OBWO66QJJ8F1LJqFO0Fgnpeh2WOt2DNDe/ktMiF
         natilxgAvp/K4zDSNb9kBopLvhbZCAGjpXRlBN8c67bQuqwlnmPiQeOZUHAGDWbkssDb
         Vedv4GLyqpDbn79eZ4p0C8tMXWgEjG2j++7HZXl0CSWzhYEO4ddMemD08UvMmdCB1Si9
         SK05MRzmfh0mdlxPw/+JevK9gcuIMtQyaqxWMNdvqJn0FesShTLpeAcDkmxmAmbCmixo
         8JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782489972; x=1783094772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cIyznuCJGHdYtVx6T4GJ4NqPqFSjKnRR9CX5npGDio=;
        b=OnOXnnPCnhmuyUEK5xmgbpFoHQCZYYnMX8iLkPoZ06HQOMXc7Rp5wN0EpLeDvIb6Hm
         fIk0Ycs+IC/l/Lt60/46D7pm6cR8Y3d6w54TKw1W2lQsLdG1EZaLK8ZyG1EA1AAUitca
         lgxSbsdm8IWnZAMwIC3Xtbi8Hdu3diWXMz7x5u9m9FH5x6fY9Ot7t+r/Uaxrk4b7g+KB
         FkhsP0IqZHlG1yuxQTf2+MrQXMEcg2vkZ+yEg9eKvFxpXRBMBuul/UxjWZffjnq1yG70
         aLmVK+0HAbHA4s8AkqJIPNWrTRWBqOEmsU7KWe9oCrkiJi6AarLvpWItFsiDb3tzdi3I
         VXiA==
X-Forwarded-Encrypted: i=1; AHgh+Rpn4/kXkLvXf2DKTJgj9MWqCBiP6IhS0qit/uyhXjyoeuwu2OMyzUyS3lasVvWrxwioM8NtKen/XxzLP4Vr6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQoLmOpi75dohS+gprucCU4gMO93YHSJ50WTKlu9+1B13bV6CM
	764m/07MiGRIWdvC0c35gTyglx/kfpoRbakYd88tyd3qWSefrrPD+JCq0BRED/RSUiY=
X-Gm-Gg: AfdE7ck/2liqYHRHnntKR7LhtWgmzStngiqGvyjX0CAtjDjDLJqKJ48PS/clYmbSdM2
	qKRP2SEKaNcIXPX6/MEKq2GQ8xlD2LvP76RlmKXa4eREy5qM95K3sArAS4Nk/jwf4xjVWyyfFqJ
	+A1FLNAHP9ecv/TIfEnQlmYJdxuyqbeT6af9zt0ypq8pxBXVNChaTkdtNrWeT+dnWDTBEvJTQfO
	uiJLwYqxzuwPE1hmD146qGVvbzcRa5QB6jocyVAMKeZl9OSK6fztbagmHwQBi4KYWHlq8gQ2ual
	7yUNf/xxakTzE4gS/aVYCZdJ3V/BXb/whcAHtwG2h7A2xkcPZtcljGp+8kcq1buJizXfXtDSKIH
	dACAMH2hq6XcbLfPglZ9tfAWjW0lnVmVHB+m6bt8K8RtQWx52mAubnsPSMDVwNGZX665s1e2vHC
	O1mpJHQB13sPi52BI=
X-Received: by 2002:a05:6000:41e6:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-46dbbdd7173mr12681438f8f.0.1782489971984;
        Fri, 26 Jun 2026 09:06:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fccca2781sm1609955f8f.6.2026.06.26.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:06:11 -0700 (PDT)
Date: Fri, 26 Jun 2026 18:06:09 +0200
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
Message-ID: <aj6jcajaZXMF_BYG@pathway.suse.cz>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
 <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
 <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>
 <20260625145115.KZ9l1-lv@linutronix.de>
 <aj6gdH2KS_XrNjIm@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj6gdH2KS_XrNjIm@pathway.suse.cz>

On Fri 2026-06-26 17:53:27, Petr Mladek wrote:
> On Thu 2026-06-25 16:51:15, Sebastian Andrzej Siewior wrote:
> > On 2026-06-11 12:09:08 [+0200], Thomas Weißschuh wrote:
> > > > @@ -864,7 +864,14 @@ static noinline_for_stack
> > > >  char *restricted_pointer(char *buf, char *end, const void *ptr,
> > > >  			 struct printf_spec spec)
> > > >  {
> > > > +	/*
> > > > +	 * has_capability_noaudit() may use spinlocks.
> > > > +	 * Make sure %pK is only used from valid contexts.
> > > > +	 */
> > > > +	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAIT_CONFIG);
> > > > +
> > > >  	lockdep_assert(in_task());
> > > > +	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
> > > 
> > > The kernel test robot found a lockdep violation with this patch:
> > > https://lore.kernel.org/all/202606110945.d3871219-lkp@intel.com/
> > > 
> > > My suspicion is that this is a pre-existing problem that was not visible
> > > to lockdep so far, exactly what this patch is supposed to mitigate.
> > > I'll investigate some more and try to reproduce it.
> > 
> > The annotation is "wrong". What you say "I do spin_lock() here".
> > Then lockdep figured out that this lock is acquired under a lock which
> > is used also from within softirq. This in turn can lead to a dependency
> > problem based on softirq:
> > 
> > |       CPU0                    CPU1
> > |       ----                    ----
> > |  lock(vsprintf_restricted_pointer_map-wait-type-assert);
> > |                               local_irq_disable();
> > |                               lock(&ptr[i]);
> > |                               lock(vsprintf_restricted_pointer_map-wait-type-assert);
> > |  <Interrupt>
> > |    lock(&ptr[i]);
> > | 
> > | *** DEADLOCK ***
> > 
> > If I'm not mistaken then this will not happen in real life because the
> > hook callback does _always_ spin_lock_irqsave() and as such it avoids
> > the interrupt+lock on CPU0 in this example.
> 
> Interesting, does the spin_lock_irqsave() even allow sleeping under RT?
> 
> I mean, does spin_lock_irqsave() violate the raw_spin_lock
> vs. spin_lock nesting rules?

Ignore the silly question, please. Sure, even spin_lock_irqsafe()
is a sleeping lock in RT.

That said, I am not sure how to effectively pretend the right
context to lockdep. It looks a bit ugly to disable interrupts
around all the code which is guarded only by a fake lock_map.

Best Regards,
Petr

PS: I am sorry for the rummour. It is Friday evening and a very hot
    weather here.
