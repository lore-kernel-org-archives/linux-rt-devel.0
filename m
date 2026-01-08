Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340A3D6046
	for <linux-rt-devel@lists.linux.dev>; Thu,  8 Jan 2026 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869186; cv=none; b=SXOLFOZOn8KKQnDy+4wxiAhccAfeLhDZ9hb8SqXVTS8kaPVBmLKrML9ysRo7/fMjULzkAKagUY+m7sCHwEpnDJflOYzYXB+KyLNKog//1eS3jtZ5mmV392NAw571keexV2lKbHZ8CkeBCh6/UMpChmHqGa/P/F1cFfXPzsuGyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869186; c=relaxed/simple;
	bh=8DMIYjsADq5oGXB/idiFns1XxpaSaoX5Tvu7oL8sKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO+ymDPRLnjlYEeVq4H8o02MHrKXBc1B6zYkzAfTtHNRLHBSdSSDn2+/57A7EXr8ZfvwyYHrNTQKKc5wYmwI8A37IUVlqhNCQIN4qsJSxew3dMHCV6s8VcVHi6FqZz6KMTmLTY+CAXDTWkuT8U9M1MZN2yBJSxPmTSmSHGl0b1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YcKts3nm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YcKts3nm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477985aea2bso3852865e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 08 Jan 2026 02:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767869178; x=1768473978; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib649LYcFubip2cWtXdZTA/LYveMY5mkmekbtPClLBw=;
        b=YcKts3nmf0e6tT5DZZqYokKnSnBOn33jMaUd/k9DGEgkkY7ea7+w4ToXAu2wEIiD7K
         Uiv5VAYA+q7IWPHHSip49ElVh2wfoA3sbAu6RUAPJ0vYnk1/lwOJ0SreaskXpRRjwZ3v
         l4MHDyGM1xNaIYv9dlhlKhaTUccakph6Q6vHVQgJMde1Qpdcow4Bp4vlL9xgA2rN8luR
         TLytTjmew6+IFqbUGAtiQ8qnDG6fKYzP+s/OikCyjfOo10XTq5NWiA942yXTRZoEULG2
         KUMIlE1kMscL3Lv62Geuci83qUZn8GCu/v1zudb8mpD5M9fS2aVRpA4gO/zdYxpulW5q
         f2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767869178; x=1768473978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ib649LYcFubip2cWtXdZTA/LYveMY5mkmekbtPClLBw=;
        b=o6aZ0FPbi4NxXRC6QO8IG/yT0v4emZERD8twkP0ntYrDTFSaIINSUUqln99CeasgFi
         13dTNWf6cT6KC6ZGevjNtt+dP7CveEMfHGqduEaiE7nDwpJMR7dwraLAC/PdW7rD3TKg
         o8p0Ik3EyYNksq37BdrbVBPFLZIyT6rAbKbLwxtJ/eE1g/tCemeWmIbibaBMOKITfFbC
         SzS4izvxCNMkcXoltlEbeE8heeR4cUThnP0/t2tsoqJrEDbgyzNDJkiBPyqlo+TiDK1o
         7JDcYB9ZBSM7w4qjzqEpCzJbQF/cn7OePq7mNwhcHgrRzQ9m/ZFJR3zlzcDdapT40xyy
         xBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUagQWmGrNr7UdY8fy29kM2BSb2bpZH7E9AmCy1G/Ey1m2l3f3bQpxIIwHc1tJbrHI0tJAlP9XkBp9C3Zo2fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZRKAhBmDMh3uqpz18sGsrst0gbVqUxXzIHrkstMj2ioPksVpx
	bC+r1Ptaw93UlihxVT8cQlLcW74nluUy25UfcX7YNSnBCJdUE0Hnht3sV5yCXJf/+ZE=
X-Gm-Gg: AY/fxX4W3lofz+youf8a7U+QxWqlHgMY5UzdjcFyGTj7VTQw+JwQU2C8wyDtTChUcpF
	eX/JFchRMacPPuKUkCxT9TSI1RdBpY8iYVTGZBe1QPZIR8R3MDqMC1Zjb+g8yj752DFeldSPH+S
	jnKd+B8jojcFdmoz7u8N1pj2hnXl+dP73H3UzPdR9Aknpe4+ET2Y1EokLLZybCArzS59qhdmBXZ
	puwq2/SpCQw9+QzjMXOooe09Ks57bpLMuvUdqteNIflEvZ+Cp6ymP5YBK+viafEVtjLEZH920KO
	skLX0g4Bj9b5pEYSKpLXyRwJjhU+3JJFBiBGkDHzlTUz/efzJbCfA8DFoUKhitNtlIYQjWlv++/
	uEe5yFL3yo86FqQ7NceckAImuEUMeqMFaglN53ZgvES2DKGuJo/IgJ6+hsTANvNqkEUBV5d1nlf
	3norQb0yud6BLwHa6QL12s5Q6wqjCgN/ZAvSaYrLB2ntiOmaNR7eCIjYEWoHItYVcwJck+nEIU8
	E0T
X-Google-Smtp-Source: AGHT+IFJqp1SOAxk3q3pW4y2QgpTbPyTlEjg0+NaiBYrsrzs+VyELuO27rZMwFwlcACfdvU9pFjKyQ==
X-Received: by 2002:a05:600c:34c5:b0:47d:3ffb:39ed with SMTP id 5b1f17b1804b1-47d84b30104mr42672595e9.4.1767869178019;
        Thu, 08 Jan 2026 02:46:18 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86637b90sm38000875e9.2.2026.01.08.02.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:46:17 -0800 (PST)
Date: Thu, 8 Jan 2026 11:46:15 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260108114615.02cd0c7c@mordecai>
In-Reply-To: <20260108093932.252f6bc7@mordecai>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 09:39:32 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> On Wed, 7 Jan 2026 11:19:35 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 7 Jan 2026 11:17:09 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > Or we simply change it to:
> > > 
> > > static inline void    
> > 
> > Actually, the above should be noinline, as it's in a slower path, and
> > should not be adding logic into the cache of the fast path.  
> 
> However, to be honest, I'm surprized this is considered slow path. My
> use case is to record a few selected trace events with "trace-cmd
> record", which spends most time polling trace_pipe_raw. Consequently,
> there is almost always a pending waiter that requires a wakeup.
> 
> In short, irq_work_queue() is the hot path for me.
> 
> OTOH I don't mind making it noinline, because on recent Intel and AMD
> systems, a function call (noinline) is often cheaper than an increase
> in L1 cache footprint (caused by inlining). But I'm confused. I have
> always thought most people use tracing same way as I do.
> 
> > > rb_irq_work_queue(struct rb_irq_work *irq_work)
> > > {
> > > 	int cpu;
> > > 
> > > 	/* irq_work_queue_on() is not allowed in NMI context */
> > > 	if (in_nmi()) {
> > > 		irq_work_queue(&irq_work->work, cpu);
> > > 		return;
> > > 	}  
> 
> Thanks for the idea. There are some downsides. IIUC there is no
> fundamental reason IPIs to other CPUs cannot be sent from NMI context.
> It's just a limitation of the current Linux kernel code. As such, it
> may be lifted in the future, and at that point nobody will remember to
> remove this condition.
> 
> My current plan is it to keep the patch on hold and have a look why IPI
> backends are not NMI-safe. In fact, I'm not even 100% sure the comment
> is correct. The issue may have fixed itself e.g. by removing the last
> affected architecture. ;-)

This turned to be an interesting digression. Since we still support
old xAPIC (not x2APIC) systems, there is a reason in hardware. The xAPIC
ICR is programmed by writing to two 32-bit registers. If an NMI occurs
between those two writes, we'd have to restore the upper 32 bits of
ICR. Alternatively, we could queue the request if ICR write is in
progress and flush the queue after finishing the write to the ICR (out
of NMI context). The code could even be arch-independent...

However, it's not worth the effort just for this one corner case.
Besides, it seems that other people have always been aware that
irq_work_queue_on() is NMI-unsafe, so in case the future brings a
better reason to make it NMI-safe, there's a fair chance that all
the extra code in rb_irq_work_queue() gets reviewed.

Petr T
