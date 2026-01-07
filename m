Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B8314D07
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Jan 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779507; cv=none; b=fjsTLCvf49Idlbf+5G355Y09MXbftSTU7GKBie/DXRUhrZyu/8bs1l42B32pehiofN7WTwYLP3T82xE/t+rwKIVzMi8TT/DLcMZUB7WHJlXj2bBg2Wy2+WB9VOhv4QWVjp6sUZX6jXY4uVga6KJOjM3OmhsDxxdSfEFUxEwmWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779507; c=relaxed/simple;
	bh=iiT2R8UnHUrK/rPGvAFhFVgfetfWj89nepLFbQiox64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTJo0aM5CjR7DFsAbUO9u1l4t3/4DQ4ox6g/ZU1b57em7eYbZYu9e1f0mIQN0PVl6FGR8OXxEzKhG25Sakdid0yEi/hUdl0ggSQy9bGBV2xCIi7t8TS5e9qO+T3iVUdPbCOohMJAI8a0yDvJUruCJPvi3ChxDnpM5hPbRaV9TVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I/tGYXT3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I/tGYXT3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779d8286d8so2263035e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 07 Jan 2026 01:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767779502; x=1768384302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkfocqoVaxgUjAmHmf02FgYq+uCwVg0Btx7TYoadT20=;
        b=I/tGYXT3wzmNbVFzhTS/kbOSpDpV54bs627a0s8iJqw6FXiPp3Ui/aeIPUX7Rs6/i4
         mv/c1a2GW2HjpWEm8qZfFWUKWlunGb0pdycVqyUTEo6thoiF2RXyMbuZgrcxcRfOHiiU
         Mmyo+ojS2ixNoyFaQz3qV8ZnXZPzB/i5z1M41XQXzlPKPcnEdGLyRIWiJhcSf2Sil1yn
         3aWQ0ol5d/3tfJNKxtyQakQMoBHF3jFRV7ruN6GCaTCwH/G25T+nLwNOS7pgupNGSM/g
         DUPI8LwDG44ukm8BmjxAdoRWZJZnJFxkN/tM7EpckvhA00+UjTUqdxDKIYHSuPbAVxRE
         kaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779502; x=1768384302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NkfocqoVaxgUjAmHmf02FgYq+uCwVg0Btx7TYoadT20=;
        b=GDFMuf/bWApT7oqh/40mSMTZZOGUdTE8LJTl75SQDxvKcfCH7wW8fX7QQ4OC0m9xMM
         fUf3HlECds/5Ug2sjZlTheQduGwPaOI1nzMt7DW5Is7Io1oMtxz2kZv3HRnR89dLoTBJ
         9GMWR9ZBFCyXf7cCozhW50fK1jrYlZNgtlqHcD/OwhMRskaSdSRrRaKTwy/YbWlbZinL
         Lc3GlZ+/8ujWPdItIC5+z3PrW0VZ7e+4AJ32N0x6I4dTseMkyEiCSBUisYgC5at6/+Ir
         BnBQphglvQfuyocYNhqN5YqL/JiXyxvPTylCtYNt1v7hXR3kay5iGETHUqY+cbv+ITiY
         u0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ivRYbtH1EP05FCFofOdPS0PAYTbpu+PT9ydN0sKmv+HcamJtJQG9Zn9qRF1K7fq/YOAGqaFUW6BGQqqXsA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7YwQmv0yYyF/3z5MlJiQFg++A+0+T22d7IsDRtt8DdpXC4xdf
	OArYVzfZY4gwvIallH08LL7m17PptL0Xl8frGopGsETKjOVro/rK2FE0lP7nQQq5rAA=
X-Gm-Gg: AY/fxX4I1AgIBqXreR81ozI0npnXZYXSVIXPciRnSvnZCiszr+vgHL/Ni66311Hh1fI
	13hMactbQ/DbOTUjFnO7jTy+7b1K3bnqk65xR245a+LGtQlwTu5iz4mT5Ko0xsjoUpeiGca4A/T
	OYeCeOArXns00N4/7TAJZT54xWp+xUo1Zwe447keeG2XsD9mP80cD6Voe2/q27ivEV3BH0VPFHO
	lYjkMQLq6YRH/msCZvyelCe1YV7SNNVCp6oKB8D44md/8pffVHhPKHz+/0RYnGgiX0qkf3HWu6b
	UedkEssJ7zFaxBAm8DWmsA0YhY/Qbb8Y1Sv4yAZ7eMZKQHm3xxd7zojqOsPOd4VjfVZABmQM6rt
	SxFrjOSVY91byMk0XUB82N8Uz7HYIBCedFaPmu+PBKyWIDBBy7ppBgeeJycDrFb5Dv3Oi1vtQ0h
	IHnNfFYsbhDGYh1Kd27YSHByY9+FDiBUdleFJsQQOpj6hvDV+Z/6YlMSFEW3bKbgGmRqiLGUjyC
	hQo
X-Google-Smtp-Source: AGHT+IFbMuCYRQqFyYc3iW2AQwZ3ygkAVP5hORsbEHKVe3DoFNpU5VkF5QR76ZXtOw48GVJBALlpkg==
X-Received: by 2002:a05:600c:3556:b0:477:9fd6:7a53 with SMTP id 5b1f17b1804b1-47d84b04e1amr11902665e9.2.1767779501536;
        Wed, 07 Jan 2026 01:51:41 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm88569435e9.13.2026.01.07.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:51:41 -0800 (PST)
Date: Wed, 7 Jan 2026 10:51:37 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260107105137.4cf9a67e@mordecai>
In-Reply-To: <20260107085009.58fcffd4@mordecai>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 08:50:09 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> On Tue, 6 Jan 2026 17:04:05 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue,  6 Jan 2026 10:10:39 +0100
> > Petr Tesarik <ptesarik@suse.com> wrote:
> >   
> > > Avoid running the wakeup irq_work on an isolated CPU. Since the wakeup can
> > > run on any CPU, let's pick a housekeeping CPU to do the job.
> > > 
> > > This change reduces additional noise when tracing isolated CPUs. For
> > > example, the following ipi_send_cpu stack trace was captured with
> > > nohz_full=2 on the isolated CPU:
> > > 
> > >           <idle>-0       [002] d.h4.  1255.379293: ipi_send_cpu: cpu=2 callsite=irq_work_queue+0x2d/0x50 callback=rb_wake_up_waiters+0x0/0x80
> > >           <idle>-0       [002] d.h4.  1255.379329: <stack trace>    
> > >  => trace_event_raw_event_ipi_send_cpu
> > >  => __irq_work_queue_local
> > >  => irq_work_queue
> > >  => ring_buffer_unlock_commit
> > >  => trace_buffer_unlock_commit_regs
> > >  => trace_event_buffer_commit
> > >  => trace_event_raw_event_x86_irq_vector
> > >  => __sysvec_apic_timer_interrupt
> > >  => sysvec_apic_timer_interrupt
> > >  => asm_sysvec_apic_timer_interrupt
> > >  => pv_native_safe_halt
> > >  => default_idle
> > >  => default_idle_call
> > >  => do_idle
> > >  => cpu_startup_entry
> > >  => start_secondary
> > >  => common_startup_64      
> > 
> > I take it that even with this patch you would still get the above events.
> > The only difference would be the "cpu=" in the event info will not be the
> > same as the CPU it executed on, right?  
> 
> Yes, this is trace of a similar event after applying the patch:
> 
>           <idle>-0       [002] d.h4.   313.334367: ipi_send_cpu: cpu=1 callsite=irq_work_queue_on+0x55/0x90 callback=generic_smp_call_function_single_interrupt+0x0/0x20
>           <idle>-0       [002] d.h4.   313.334390: <stack trace>
>  => trace_event_raw_event_ipi_send_cpu
>  => __smp_call_single_queue
>  => irq_work_queue_on
>  => ring_buffer_unlock_commit
>  => trace_buffer_unlock_commit_regs
>  => trace_event_buffer_commit
>  => trace_event_raw_event_x86_irq_vector
>  => __sysvec_apic_timer_interrupt
>  => sysvec_apic_timer_interrupt
>  => asm_sysvec_apic_timer_interrupt
>  => pv_native_safe_halt
>  => default_idle
>  => default_idle_call
>  => do_idle
>  => cpu_startup_entry
>  => start_secondary
>  => common_startup_64  
> 
> The callback function in the trace event is different. That's because
> send_call_function_single_ipi() always uses this value. Maybe it can be
> improved, and I can look into it, but that's clearly a very separate
> issue.

Erm. It's actually good I had a look. :-(

A helpful comment in irq_work_queue_on() explains that "arch remote IPI
send/receive backend aren't NMI safe". That's something I wasn't aware
of, and I'm afraid it's the end of story. The comment is followed by a
WARN_ON_ONCE(in_nmi()), and I can easily trigger it with "perf top"
while nmi:nmi_handler is traced.

Please, remove the patch again. I'm sorry.

Petr T
