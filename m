Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462C379967
	for <linux-rt-devel@lists.linux.dev>; Thu,  8 Jan 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861585; cv=none; b=W3L3YW8iD4g+Y/iTF0J5sGQiFIKbhdfABQy9+2hkH6C2c6z9y9tz8SRDFy1ZXMgZ1yNwY7GMD438nsLxJFiZA7UM414lSOM4dcglTPxPCxEZp/nfzYDbOk0k74czZJeRsAoOENBJHfQ3pp1fFTwAfrt25hX5FLxjNpKjb44SPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861585; c=relaxed/simple;
	bh=KBSq5ozp9nWK7xE1oaTKEnG55tvkaczknOCnKuHL4hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbkLC1MRnPaLSA/549pp2BywNYkhxgLwpS4F6vtm0PbFxH/GhqBItcl+cdF7mfbANYxp7YRvc8FJUj19arB74gVstORyLR9YzvkQT9DbkYdyHa07jmSxUXoaJZTcO5c5TZKSrxeWIjTY/VsQqSrm43+Ofr/Wr46k4HUEZR3pspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f1juCo9O; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f1juCo9O"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43263e1ce4eso236078f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 08 Jan 2026 00:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767861575; x=1768466375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/vUisi3Mqmn3VVAgeiq/GIYmN1ZatSlGnG9ei2N00E=;
        b=f1juCo9Oi6tavfJpqp/g95JWaorIwikoPKy69KRe+2GCucNxSEnwxmvubyDZJifyZQ
         wPQO8vxefi5kOdeiqAoYYXha9yfHdXQvN/D1+bIGHba8vbtH3kzUFC88oX+FL0iK1BiT
         JEh7YM6NF05Z/GDUcqibThVYy5vi8PolgUXCdPnVJQwlNjFphaYFB9BBq4vttHTJArqH
         xtGzZmwefZi/IBng5rnw0J/QCUgVcKakgolRNDNeAY6t0nwb7DWHqCM9NGOkmro83Pr+
         B9nG8A0JZlNG1jxi5wCJViZnz+coA5h2HAkB1yxnP1Zc4BwtkC6IUGhGAan5CA9NpOiX
         h39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861575; x=1768466375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/vUisi3Mqmn3VVAgeiq/GIYmN1ZatSlGnG9ei2N00E=;
        b=pbJTdMPZ6pT38W9orpGn9M6SF2rZVFhp1D/Z8tffzO5ojS5cy/A4o0pHzJbl5ZZWEY
         L7ba0YSuCPERHpiHpxVUUnHRSjJ3wVar6K2T1Owg1LX3qRZo3Zl8cQQhBzWEV+0+PIMu
         bfeX4/REYraD+zYQa5sgRA2E+y4n+LOXVV7agerGFCAqz52Xh6Ei1DAPCoTxH3sIa+1C
         OZBTAyFcu6wyjWaU/Y4hGwWCy6C4yhA7IOr63vUJuo1KBDeivlAr5Dqhv/tOvQUmlB7Y
         gS5MHcbd6apZ+nAI4vaBN7kd6rRLdTg7OTpuQGiKT6j0qUNZbPjuOkMPScg72sLhvGLw
         mHWw==
X-Forwarded-Encrypted: i=1; AJvYcCXS1iuNYKkS6MKt9SYJv2RIAXJMCvy3zczHHUBxFft7wpa4xgtwp4FPNu8j+2jPnzX+yWls/4f8EPZy3OjIsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcBDA8Z1tgAOrVnoPCxMOADV74VVTo+l5H2duCtWsF+uAAkECQ
	8//NFWWnfoGCxpKWjZd7/QKYREoHC2HQpy56ZVamgtZKVRvf/AOI61QK75Wv5NqgaQA=
X-Gm-Gg: AY/fxX5hVk5HhhLhUOcKhYsEdUfvKx18xsKg6GiYiS8c5uk9XQkRs29Z2+YKOLvWtE3
	Cia9pqDWlnSyYQmhzZ2Y5wgpm5anHayl77LYMTvVpJRXbOVXWYgkU0SmiiBgKHYL5Z97gWBBTN6
	e+RcnAHo0ynPmsSiiyB0NDWDaNzE1yTZjWC0Xz4zFMAnIwx5yBxtwLzeyXrCF2IVTTtXXDgDqIv
	1qF5Vg8eNlSOmglU4uNsIVePepbDjNZKq0VslRLmzWS0iJtMZ+9QV3qVoxWva/OWxx0j0pfX/EO
	oV2LVdxjo+/cfYSPUUtUUkR7M+qvRk/eDzHGjBsCMI5TbDiehCRBE4gVJACpwTRno79yjiKC3v2
	og+N+bMybF0wMrLbDkEGuG/vsRq3ogEpDxrrCoUhkrJsWOIf/2zZgxjvm/ao2Hmmx6SUPf7kQO/
	hHI4fK3DYH2fWZ/uGcWog/OYBHD0sWeg48ojv3PIpGtzGDO2DsWAt+3g4q6uckKetmhm4EbXKxn
	nuL
X-Google-Smtp-Source: AGHT+IE+AxG15zz8e6XqsM+Ihev+zYB7TD2+tvKX+z3mSuMcV9zIClsWCLuPxib3hoIzZay0GziECg==
X-Received: by 2002:a05:6000:2c0c:b0:431:66a:cbcb with SMTP id ffacd0b85a97d-432c37c1eddmr3835457f8f.7.1767861574850;
        Thu, 08 Jan 2026 00:39:34 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe83bsm15596057f8f.38.2026.01.08.00.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:39:34 -0800 (PST)
Date: Thu, 8 Jan 2026 09:39:32 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260108093932.252f6bc7@mordecai>
In-Reply-To: <20260107111935.3befc296@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 11:19:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 7 Jan 2026 11:17:09 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Or we simply change it to:
> > 
> > static inline void  
> 
> Actually, the above should be noinline, as it's in a slower path, and
> should not be adding logic into the cache of the fast path.

However, to be honest, I'm surprized this is considered slow path. My
use case is to record a few selected trace events with "trace-cmd
record", which spends most time polling trace_pipe_raw. Consequently,
there is almost always a pending waiter that requires a wakeup.

In short, irq_work_queue() is the hot path for me.

OTOH I don't mind making it noinline, because on recent Intel and AMD
systems, a function call (noinline) is often cheaper than an increase
in L1 cache footprint (caused by inlining). But I'm confused. I have
always thought most people use tracing same way as I do.

> > rb_irq_work_queue(struct rb_irq_work *irq_work)
> > {
> > 	int cpu;
> > 
> > 	/* irq_work_queue_on() is not allowed in NMI context */
> > 	if (in_nmi()) {
> > 		irq_work_queue(&irq_work->work, cpu);
> > 		return;
> > 	}

Thanks for the idea. There are some downsides. IIUC there is no
fundamental reason IPIs to other CPUs cannot be sent from NMI context.
It's just a limitation of the current Linux kernel code. As such, it
may be lifted in the future, and at that point nobody will remember to
remove this condition.

My current plan is it to keep the patch on hold and have a look why IPI
backends are not NMI-safe. In fact, I'm not even 100% sure the comment
is correct. The issue may have fixed itself e.g. by removing the last
affected architecture. ;-)

Petr T
