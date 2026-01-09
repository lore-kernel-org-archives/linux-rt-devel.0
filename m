Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B53559F6
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Jan 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949086; cv=none; b=kGD8xXVmHL2w6+o0l8hVqDbktt3oWpNTzgH80PE8MuLtNG7x2SAqBsIlNKYLOEBP/dTVh5RQIX4btT7dTX26ee2tyaGz/uP48r0VQGCtfyX1rPW2nojAtBlTtM15Vd0z3JS43AnyVBJwqqHoKv+bErpwFkKyVaFrbkfvNdbyiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949086; c=relaxed/simple;
	bh=Ye1BtRyDyCZ7fcEJvKPT/mRELE9PMSLftW7wgjHmKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxcmlAbmjgbRUr+X+E6hq6gWb5U9Tos+zAyPLhNkBsq9yVGHKdnGcJeZfW9L/ro37FIoW0QDOyndak3CElhgcRZC6w+P3c4w38MDiZQG2UnjcCq1TngSOpZhwiIM3skDbKjsxLQEsM/LJ5KRvWwoti95V12/i2yOLjGNdW4B++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AFYx6xwx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AFYx6xwx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47928022b93so7594025e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Jan 2026 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767949079; x=1768553879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXYuN6xeN+Ya8/ES460opJxIhbpHbZkVlPrAHWs4g/A=;
        b=AFYx6xwxF/DrRVL56NimH5GspzOURn7TBwNBY6Kvh9FMnUrauWvevtSR1czzj7Gxhw
         ZPG/A81rz4Xed4RxcmhP6rTnA1YxtKItQss5dDn3+ZwNbW86q2UqWKmaX0kbCUvs3TL/
         8St1dmGCKhyKf9RqL8mkjIngdcQ84sfWukFARqPvBLcIYSUQyoA0Gbpd74NXV8blzAP/
         VD659srgnQ2NO78TiFBdyEtsjt0Yd+mJkDTJFjF/F43R+z/4C4rb48KZXMSHW4va0E/q
         ThjyJv/InalV0sM0ECA+Pth80vwrhGt7PzfH5KPdytD6AvvtEA4OdPGyhw+qOBH4Hh5e
         eZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949079; x=1768553879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXYuN6xeN+Ya8/ES460opJxIhbpHbZkVlPrAHWs4g/A=;
        b=bB8R5JbWvMOvRAys9MkOojCQe9bGBUDXJVuyjes9xoCFDrb8appJmGobvCW21nhm6k
         Aba122bLMnssSGZ7pNp92MTVJgtPVR9dMXvT2hF3rJaDo4GpXjcTGr78dCPphmgbHcts
         ngXCQlJIzSBSLyAjdaPPJ3O1fQCClE4J+CiYHN1IsChIgCvzI+o9vVotcUINV06iL7Zj
         iRvfWq0QBcO8libKmFhl48980eVnQVtUHSGIyOC2f0CiF6vqMOw8FT+3d5FcSY1RWuBC
         4VkmU+UeETxNPZxB8SYlDxqes5jlwCOoKwy3b1oATqj6fCAhTDOtGU9pd3gyu6ChdwSc
         zCKg==
X-Forwarded-Encrypted: i=1; AJvYcCXDEI3icdd2Tg4UcJllteh78JK7G7cPpvSftnAz3p6gITSykTXB2FItLPPixSwxHKyTofvSlFNg7BMP06XjAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOhajiGGfxanU6lqJcytikR7nYZQcdbC2hR1HynWlsMUFinz4Y
	U/knAYVTpLVosVJ5L7OC61zVfV5O9mtGABbpKNrwxNdeYrt/IqmzVYHMZwzCHi3K28w=
X-Gm-Gg: AY/fxX6TVVVEWZPKWK9PtpoUQ6urmHo4mqJo/5bNQYz53/Z/9+Cw6F8UpxX2vw4coMP
	MVKmiO0xCNO9ql8DbkD+iiLEhv+z8oUebm+8t+Zb4sYox61nPqJOy+FvP0LPL41yHiVZEpUS4q/
	0B9huX0e4UZTS2vYlfytH2UcLjOMg0nMepUts4iO0pdUW17tFUwufXu6NBlyKkC9s35VHMbXpxF
	aqohoCyIFKOf+DoQt6x/lhTxQYbTA+5XeO5EE5TgKeIf4ULiHhtBTOY8HTLnnW08XNdqVPbhI0U
	xIo3Dy4TC6CXPg75faiUHzWesbGcbi8pDckViFSZHGNO1B0kkOH+Fwz22IBygnG44sv9Js59e/I
	cewCBAMDARfpr5ipdel2ACem/sbZFBYDjglWdgQvjibkNUmH7vmKuA745YHCslEy0hCNqBOyvku
	kz8tJVNkg940MuondGdYa7fOAXUAd9ADkErMYIWWw9K8cefIuadvmFCksrBz0N4EHgYP/BPKIAc
	qB7
X-Google-Smtp-Source: AGHT+IFgxQgdBinp7wbCc/TkbY/jHrzbeepppdW/KOxOAc/R3j+vhEOCPBjEv3iR0E9dqk/KefCpyw==
X-Received: by 2002:a05:6000:26d3:b0:42b:55a1:214d with SMTP id ffacd0b85a97d-432c379ddebmr6492578f8f.1.1767949078874;
        Fri, 09 Jan 2026 00:57:58 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm1002142f8f.27.2026.01.09.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:57:58 -0800 (PST)
Date: Fri, 9 Jan 2026 09:57:56 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260109095756.13deb429@mordecai>
In-Reply-To: <20260108115800.7a7fc8a7@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
	<20260108115800.7a7fc8a7@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 11:58:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 8 Jan 2026 09:39:32 +0100
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
> > > > Or we simply change it to:
> > > > 
> > > > static inline void      
> > > 
> > > Actually, the above should be noinline, as it's in a slower path, and
> > > should not be adding logic into the cache of the fast path.    
> > 
> > However, to be honest, I'm surprized this is considered slow path. My
> > use case is to record a few selected trace events with "trace-cmd
> > record", which spends most time polling trace_pipe_raw. Consequently,
> > there is almost always a pending waiter that requires a wakeup.
> > 
> > In short, irq_work_queue() is the hot path for me.
> > 
> > OTOH I don't mind making it noinline, because on recent Intel and AMD
> > systems, a function call (noinline) is often cheaper than an increase
> > in L1 cache footprint (caused by inlining). But I'm confused. I have
> > always thought most people use tracing same way as I do.  
> 
> The call to rb_wakeups() is a fast path, but the wakeup itself is a slow
> path. This is the case even when you have user space in a loop that is just
> waiting on data.
> 
> User space tool:
> 
>   ring_buffer_wait() {
>     wake_event_interruptible(.., rb_wait_cond(..));
>   }
> 
> Writer:
> 
>   rb_wakeups() {
>     if (!full_hit())
>       return;
>   }
> 
> The full_hit() is the watermark check. If you look at the tracefs
> directory, you'll see a "buffer_percent" file, which is default set to 50.
> That means that full_hit() will not return true until the ring buffer is
> around 50 percent full. This function is called thousands of times before
> the first wakeup happens.
> 
> Let's look at even a waiter that isn't using the buffer percent. This means
> it will be woken up on any event in the buffer.
> 
>   rb_wakeups() {
> 	if (buffer->irq_work.waiters_pending) {
> 		buffer->irq_work.waiters_pending = false;
> 		/* irq_work_queue() supplies it's own memory barriers */
> 		irq_work_queue(&buffer->irq_work.work);
> 
> 
> So it clears the waiters_pending flag and wakes up the waiter. Now the
> waiter wakes up and starts reading the ring buffer. While the ring buffer
> has content, it will continue to read and doesn't block again until the
> ring buffer is empty. This means that thousands of events are being
> recorded with no waiters to wake up.
> 
> See why this is a slow path?

Thank you for the detailed explanation. So, yeah, most people use it
differently from me, generating trace events fast enough that the
reader does not consume the previous event before the next one arrives.

I have removed both "inline" and "noinline" in v2, leaving it at the
discretion of the compiler. If you believe it deserves a "noinline",
feel free to add it. FWIW on x86-64, I didn't observe any measurable
diference either in latency or instruction cache footprint.

Petr T
