Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1D280325
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Jan 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772219; cv=none; b=NQ3QU0CX/omeZQvN5tRhU51M7PnORVt6gvLuM7ASedzuBKqy+ZVYlJJqh/JAWOyojg230cmLKDUBJkmqLHrvf+m7dh+yzLfwuSumRZ48FvxJIZo33+LJrFT9g7AxefbBL4Gjde58PCJeafkrz9jILlWF5weoy0nUVwDHKGdWg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772219; c=relaxed/simple;
	bh=7tiwIhJYnE3dx5jyQCWjPRVoHabKi0Yd5MocQaeuTG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kw31qxzm8WCRHaQJSVE+MXbLXBzCrIS8p3khtT7VxdxXVNBHWpPmXOxDJsIN6RzeWkeq/dwckYG847ADvVvsmdjWX7MbFsx3gPJA5So+EJlkZxX83Z/cw8fvrouegHi8suWAi7aKKLZvh/nbMGyqarU3Xy4nFs+R5vDHODWMew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BYYvGIkP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BYYvGIkP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779d8286d8so2112975e9.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 23:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767772213; x=1768377013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTwsEdCvk1LcWq9yzHvV8qXzDbqu/xI5jjC5aep5ibc=;
        b=BYYvGIkPa8+/JXAr9K+BAuo0v8SgS8CGa4Ozi9+htdtIRLANpkHbLgZGPXFlbJfNKf
         OmIrZBMEsrb6IN0y4GicXGuh1zlBt2qT7Zqda+34qXIbDCxTp6WL4/+jjvcDvBBvsaqR
         pBNID387nHsQpNUqQU/HS/IQf0KWuPA+rMDxHMEBS/+jELOrU/w3RHaRsF+UwckKDcJq
         FudhZQjnCDLmeB1kl67e5pSuzIdNcKandS/BgfKIGhylti6Zp3meUWdE+zOzNs4abIfb
         KRdgHE7OvTfTqK/77TJTvu3Yo+Eo+DzWdl48Uk0mLcz0sS1zDJuEUiXKDP1x5THFtt9r
         VCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767772213; x=1768377013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTwsEdCvk1LcWq9yzHvV8qXzDbqu/xI5jjC5aep5ibc=;
        b=vH2b1i06JTSysRwx5ihnCHpkhkb9KYy7cbD3meYPccfDh6PspF9QiiM5WgKA+A61Jw
         ZQWthMAajneAq4NxCsfn3ONOjAh5Vl+wX39TOp1K6dESfqWRbz9NzGzKYGNm/jVOxqeY
         JmRceICCa668KIos2bTebHVj6lT1Pngvd4AKLhgpg+YGsdcPRGqFtggBu+X1YNfTRIqm
         tDZd8yGmuJ3tv3oECDbchIJuF2OmAuYQqrsjdWGSwGUJ6uOo4lhpNlKbZOnqxAY7VkZy
         uGreY89gwoCn8WPZHlqJ0nZ9HanP9/hH7CPW//OwFdIH44uatA5A7T89qEMOjWLMdWhH
         g3sA==
X-Forwarded-Encrypted: i=1; AJvYcCWrMgkBbiK0uxrbtqvEkpbNlfxEw/Xu4+y/ktnA3L2B0qFKjUeArbcV8CRAzw6pEbqPzZtNk7K3g/OJiS2tkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjA8TEnHrUELCpQygvagspHez6fAtB3IX4k9SQUvoJdHYs8aJG
	wbiwEXpp9kJLISGNy9lQpGDXlg6FFJ9KN6RLIc8c+Q7ZgGzLz4eymk+pxBGvmFC9k14=
X-Gm-Gg: AY/fxX7ZPVDA+fUm/DxH4nU30mgEsrZAZmztfRzK7KmTqamqPnCFNA234KDscTNrQRI
	D0vlMy7TnZc4WJMQzI7XDtjAl/76V7Le03hWbJIePwwnZIqa33tw6twYR0cOeHDRGAR8QgplTrX
	wkUXSPrnQegWe3RmBvviznGiMRzChTWi8yhChx0qiF+fljKCezPkOWCPZsy5vNdEiMpWsyIjylP
	gtqR3lU4nCI7yKR4ZOfBPYYPhagYN9ALI8NIS0AUh8+7FZYLEyOglU2FHK064Vvwv1DKG6dMdCU
	AqyW8dS24jegGnb1SmnU7hIbsPNp7NKJC/Y63jjlNboHM0SuN4GLTUL20sKPyySkN+7GzwuoKKN
	4AswoEwgSW7ir1NSCrRNPEJPrpa/SZDG1N/tDg9hW50hwi2JGhhu4i+wZh7sFgJKss/v9b+0V9f
	+Vv3O4LxKWO5a48Q7t/EL5hvzdKvhKuYTRa+ziqA4Sga9A5FeDpyWK/9mdULTw7kIbhmAqarCPh
	YeS
X-Google-Smtp-Source: AGHT+IEeSL9a0sO/p+itJvQV8zFNgZvIXQnOGqZK2SqTOEnng5pUuSMZXMvpl/vjk4ZvT6vQlklhNA==
X-Received: by 2002:a05:600c:310b:b0:477:9a4d:b92d with SMTP id 5b1f17b1804b1-47d84b37d1bmr7849795e9.5.1767772212776;
        Tue, 06 Jan 2026 23:50:12 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm85554685e9.7.2026.01.06.23.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:50:12 -0800 (PST)
Date: Wed, 7 Jan 2026 08:50:09 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260107085009.58fcffd4@mordecai>
In-Reply-To: <20260106170405.425f469e@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 17:04:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  6 Jan 2026 10:10:39 +0100
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
> > Avoid running the wakeup irq_work on an isolated CPU. Since the wakeup can
> > run on any CPU, let's pick a housekeeping CPU to do the job.
> > 
> > This change reduces additional noise when tracing isolated CPUs. For
> > example, the following ipi_send_cpu stack trace was captured with
> > nohz_full=2 on the isolated CPU:
> > 
> >           <idle>-0       [002] d.h4.  1255.379293: ipi_send_cpu: cpu=2 callsite=irq_work_queue+0x2d/0x50 callback=rb_wake_up_waiters+0x0/0x80
> >           <idle>-0       [002] d.h4.  1255.379329: <stack trace>  
> >  => trace_event_raw_event_ipi_send_cpu
> >  => __irq_work_queue_local
> >  => irq_work_queue
> >  => ring_buffer_unlock_commit
> >  => trace_buffer_unlock_commit_regs
> >  => trace_event_buffer_commit
> >  => trace_event_raw_event_x86_irq_vector
> >  => __sysvec_apic_timer_interrupt
> >  => sysvec_apic_timer_interrupt
> >  => asm_sysvec_apic_timer_interrupt
> >  => pv_native_safe_halt
> >  => default_idle
> >  => default_idle_call
> >  => do_idle
> >  => cpu_startup_entry
> >  => start_secondary
> >  => common_startup_64    
> 
> I take it that even with this patch you would still get the above events.
> The only difference would be the "cpu=" in the event info will not be the
> same as the CPU it executed on, right?

Yes, this is trace of a similar event after applying the patch:

          <idle>-0       [002] d.h4.   313.334367: ipi_send_cpu: cpu=1 callsite=irq_work_queue_on+0x55/0x90 callback=generic_smp_call_function_single_interrupt+0x0/0x20
          <idle>-0       [002] d.h4.   313.334390: <stack trace>
 => trace_event_raw_event_ipi_send_cpu
 => __smp_call_single_queue
 => irq_work_queue_on
 => ring_buffer_unlock_commit
 => trace_buffer_unlock_commit_regs
 => trace_event_buffer_commit
 => trace_event_raw_event_x86_irq_vector
 => __sysvec_apic_timer_interrupt
 => sysvec_apic_timer_interrupt
 => asm_sysvec_apic_timer_interrupt
 => pv_native_safe_halt
 => default_idle
 => default_idle_call
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => common_startup_64

The callback function in the trace event is different. That's because
send_call_function_single_ipi() always uses this value. Maybe it can be
improved, and I can look into it, but that's clearly a very separate
issue.

> > The IRQ work interrupt alone adds considerable noise, but the impact can
> > get even worse with PREEMPT_RT, because the IRQ work interrupt is then
> > handled by a separate kernel thread. This requires a task switch and makes
> > tracing useless for analyzing latency on an isolated CPU.
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>  
> 
> LGTM,
> 
> I'll queue it up for the next merge window.

Thank you!

Petr T
