Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BC459AE1
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147083; cv=none; b=R+AQx02DxBhrIK+HJ3DEDikowGRfn+4iuxLWKA9P3bXNB7hSuA3VH5KLyem3tW9VKhD8TDjg+YVttQffEQcGnApDL/1BcIiH/8djaRutxLSbZsJccNX5XMGwArglMrDgr+2nns2Gnq133xtdBVLs92+aBuz3Dr6tJ3IGPDQa3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147083; c=relaxed/simple;
	bh=AJSOjXZDHj/o/pVbZRp+OIJYhd2zvwmKYCPjs4w80fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDCZgo7fPNJQ1z6Y3cSoYTvpPH5DroWMNgI8P6LUg6TffFiZrU9Ir2Zo6uQXUTCFLsAhnq94/3Iu4sVcQNOrFZoq8L/7SbW6n/Bt8HMf0c1F8KWreIAskfECIfzNC2KvXrzU+d5HDIRNOA25Lx6/EJlKqaSho35Y8xMFT6vmyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRs2Hojs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRs2Hojs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso449995e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789147080; x=1789751880; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2FmsgEl6y3i0C3oGLtZ2cN9LSp12HsdgI4FBDotuE0c=;
        b=cRs2HojsKB9FYtLNDMqbz2ZKOJ+DdssXhzM29B5szhJVkwLang04cSfn+Pgk/v31T6
         nMeaR0egc6p1YT6bFeoJ8mgPnwt+3pa1sKHksG0KE3XmjwB0O8HQF1n4vlu8puKGhMk+
         hcTnQ7Pz7jj8M9K6IHjXyIDsn8QB+8YNXeYosMSF5TYovJZ4Aqp/LrePQHm+PZ/j6nJW
         5ZDTtv7KIoYmXiq46htcmQRvX7hzmA5iwNOf19oGAJyA/prT9+SnpwUZX7A7aCFeK5X5
         /7nhoQ73W/xTNtZaAGo/M1DdgiU5ZoMb5UbbMUsPnOVxGymTpR61lig6gDu/iXgw9ek1
         VXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147080; x=1789751880;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2FmsgEl6y3i0C3oGLtZ2cN9LSp12HsdgI4FBDotuE0c=;
        b=OKnEpT91i0/N7Vwz9iQ7nplcQULIclXaZSt8ujbNoEsDfQhQwLni2agIF2wtpMrxrB
         6P5v9YBxMyTqvJPaCqOvZlPf9Lff8cy9DricAiYIQh3RPjuiaDxXxCAtVczbShCIxVCg
         euggFWdCvcvy0ki/kUsJyj+yuNg/HC1nYXzJusKCLP6npJSYbf6WNp+wHoOWj/MrERDN
         LR5AJreBvMe9EueqHuvnHGbA1IBfuzAbXxhpAWgbbFfWQRAXf4+3TWcfK/BlVTqbgnV6
         o8zu+qg64lxUrtRvI+vwWiZqsGmMBWflu6Gs5jeD0kETumqafkUBpLFPMGQ1S2tRw3Rv
         wkNA==
X-Forwarded-Encrypted: i=1; AKwUvBzXQoBRSGKqgNzlgXGh8X2q1P4p28TFfMdbt570RyWYh+ZjI45GMuwT6ciCEK4ajFV991e6jHfrzmqUcx5HHA==@lists.linux.dev
X-Gm-Message-State: AFuF++kDnp6DlBOHZh4z/I59Zp99b0wzsF7c3VeMneLL7HUmn0I+g+MU
	btXFrkqgsK70BUPCo7qOE81tB5D5DwYhKIRAKavwKHwoIb1i9Q1QPoE+91wB8SjVOQ==
X-Gm-Gg: AYBFou3230Xs08nUTYaJHN/UfCH62akbN09eKrwY4JqrTB2dzVy7GQq/GKEY4XFZZne
	HOWDCgYgTeJUeNQepRyAFj87filklYR1khSWQNBJvtSMHMIoCxxIkmmFFfJNd9suXShzt8nk6h5
	APljYrDqsJhESzpqHiYE1W9jPxtVPbi9tf4N4FhzNn57RCAW/2QWFqmn/CTHbuDag35uEgFAytO
	jQc9E16Ba9Z0eoLd9Mi91vBzXLOVeXHtT5YmbQD8fI4SwNua3/AL9O2kLXWEyYWnPuw1nrC/umD
	1HUrNxAYXYGJaMMAgtBzqHm2W8AvTVw1CtNB5lqCeEYO82CPPtUQe5C14XXlNTVxe6r+gc5t2o3
	Ex8PVRp/q0NTiL/waZuP1r4zyLvE46Gyo6lPg9udHpcdFVoa+CCIoIgAaEVw2EQhfxPAI58snKo
	9KTkNCp9MIKZhkdak4+6pYzpqgqNjTNt2chVcYAivQc1fw3p/5aHKaPzEqVacVLBFYEwAitA9+7
	i//L3r5+N8bwx4IzY8gAUFZy4jwTCliHBlQZM/IZRs=
X-Received: by 2002:a05:600c:4683:b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e6106d393mr64742525e9.8.1789147079818;
        Fri, 11 Sep 2026 10:17:59 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e69f02c92sm20593625e9.2.2026.09.11.10.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:17:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:17:56 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] ring-buffer: Acquire the lock with irqsave in
 rb_wake_up_waiters()
Message-ID: <aqQ3xIlG9a1LlXbg@google.com>
References: <20260911102152.YEtwkBj9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911102152.YEtwkBj9@linutronix.de>

On Fri, Sep 11, 2026 at 12:21:52PM +0200, Sebastian Andrzej Siewior wrote:
> rb_wake_up_waiters() is a irq_work callback which is initialized with
> init_irq_work(). As such it will be invoked in thread context on
> PREEMPT_RT. Invoking the callback in IRQ context on PREEMPT_RT is not an
> option due its usage of wake_up_all().
> Since this callback may run in thread context, it needs to acqurie

nit: typo "acquire" 

> ring_buffer_per_cpu::reader_lock with disabling interrupts and may not
> assume that they are disabled.
> 
> Use raw_spinlock_irqsave() to acquire ring_buffer_per_cpu::reader_lock.
> 
> Fixes: 68282dd930ea3 ("ring-buffer: Fix resetting of shortest_full")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/trace/ring_buffer.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a6ba2..681f9daf6fabb 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -904,14 +904,13 @@ static void rb_wake_up_waiters(struct irq_work *work)
>  		struct ring_buffer_per_cpu *cpu_buffer =
>  			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
>  
> -		/* Called from interrupt context */
> -		raw_spin_lock(&cpu_buffer->reader_lock);
> -		rbwork->wakeup_full = false;
> -		rbwork->full_waiters_pending = false;
> +		scoped_guard(raw_spinlock_irqsave, &cpu_buffer->reader_lock) {
> +			rbwork->wakeup_full = false;
> +			rbwork->full_waiters_pending = false;
>  
> -		/* Waking up all waiters, they will reset the shortest full */
> -		cpu_buffer->shortest_full = 0;
> -		raw_spin_unlock(&cpu_buffer->reader_lock);
> +			/* Waking up all waiters, they will reset the shortest full */
> +			cpu_buffer->shortest_full = 0;
> +		}
>  
>  		wake_up_all(&rbwork->full_waiters);
>  	}
> -- 
> 2.55.0
> 
> 

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
