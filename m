Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B233BBBD
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590929; cv=none; b=BjzxC8t9MWNIbYrHI9E63cQAfcZdximA7vX326th1nXCtfFRJEWYfZHQW/FwCOHq6q9e/59DscqzquOaVC1qrsfgRVzETYrUI2b3FYih/c/vrexaebZkHTqHB7KoX41Vzuiphx1IOy3GKLuDxL2X/X6ZIQGbx0iRh/v/uNK7uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590929; c=relaxed/simple;
	bh=1GPlGKZgcb1DldoonD0OPHNoXEsNDWUi3TBlJQ2/goc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8Urbhy7jYO+aW04n6SDh4zs5tMahUYol9dcJLIq69V3XspOLut6Y/xi4/OKrdyn1zDz7HcGRqCxydCHf2dS4vOejbz7UdW3SgyOyYzXHFRJlqKeSwJnXQrrKvBINaXX/7amWmC517cHGTPOfTQzQES1JGdhKefWiiF77uoeZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TZmqyVlQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TZmqyVlQ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso4224505e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769590925; x=1770195725; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAOxIVYTEue9E0jsTADeINvfipVSQ2+6/g8YDctDKvU=;
        b=TZmqyVlQVbiq6IyLERUdqCHiNO9Atl0ZLyIAt72MT4DySRPtasOdhOZ93Z0lLbDCSx
         lcxx2oylaX2eCh7HgPpBASWkoIC9dYJbEmnt9mKDptE8/kcSN+JTqN3PT+YOLSQyp1p3
         eXKR5JxwAYV+TAGlGWh10mHw4cpzyokMa1sMacg8W70WgadlUf31BSDblcbfC3uPkUkr
         3eODooKNxwivKZ14NiffTmTjrLyTuP3FZMzb7UG1G3JrcoUOC7Tq9qU8o/FgsHbJmPMU
         uvU1YHboDXt777ZNF5580x6gDw3s5KyxrdkV0M0JHr57U4T8zPzoHyN/Eu2KweXrsd/Y
         1acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769590925; x=1770195725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAOxIVYTEue9E0jsTADeINvfipVSQ2+6/g8YDctDKvU=;
        b=La2yWP06IZZta0DyOaQ4XfR27uVAS1xpGvZJnjGvBX34KTbPbY3TA/p5Tk21i5DC2O
         rS4hnz9h57B2KsVq18J/Bx9G1GiZ9i6QdLfQCzMQ3XO+SLhY44AlbcupbVM61GTwzLZZ
         F5rqYN9YgBTMZwf2M6esi0wmJSVpzGV8QnRM0NkAczk5xdY9ELGSEFy5CoY3xorLp8lm
         tOCXnjgD6e7xCSueBwa/Dp0k2vugxUK1VkvUSwvrPOjG06TVsWpchcLRPvCI2sIHbToh
         p7wY/2pCwvo3Nrri0DYDgYnvIgvMEwZguQ0oXo5ao95CGb6z0glaKMay7mPoLENk8j7k
         jS3A==
X-Forwarded-Encrypted: i=1; AJvYcCWeurAW/2f2F2ZyeKSdRcuY2pFO25yQosaYVT1ZOfFDOC6Y5k9cj9vAMcpaXz4OcG9wqDZJspfoRIRTWFFvyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4h8TY3Kc4F7gEixKIm5kIqyDH2g5it4P0QY/O6qA+0NkJuIDR
	b0eFJyhBs0q6J+C9k+1gooHLXb/zJIjGpKuVfPJxtQsf9Bu3LW5bAuipWR0u0zz9DQU=
X-Gm-Gg: AZuq6aKm5AJGUdWHOVih1cskJEuylce8jA0L1SxmCyo3QepnEbWH6MbpTyDqDx/AvSe
	YNBaHbroUGEQwANgb6BakoUAS+iD5BfKB8RXjz5Kpndu85waTxbqswG5Vm3ENT42plvHl303tHY
	dmD0of3tbZLFV9l9fjptxpLyKYLd1hvHXYNBGL62K+/fBvq45V2R/33hKNIX/QDBxMkNFx8P8VR
	7e9x2bOpCfZNo31NbKt30ixmL09vEWTlCgFX57NukbdKb/QG2Es62mNFCq5n5LZ5zAZsx9m8ieR
	BiHIyaUF52MB3p5VQ36THSE8xNj7cvsl4hYSK2hJYbc/fOOvNgw1uA76Wm32YCgxD8H4hjU1Z0u
	MRpCYt3Jl0+CZh+B/mox9sxpgJIcoqM6plqs8PAwUjjBSmJH0eixkbz5rHrqMGQj3m/fIP1MlBU
	elAkEEHWuTeOLM1A==
X-Received: by 2002:a05:600c:3154:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-48069c1a7ebmr50821355e9.11.1769590924606;
        Wed, 28 Jan 2026 01:02:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm122234435e9.4.2026.01.28.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:02:04 -0800 (PST)
Date: Wed, 28 Jan 2026 10:02:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] printk, vt, fbcon: Remove console_conditional_schedule()
Message-ID: <aXnQiSBskXo4RDAL@pathway.suse.cz>
References: <20260126180836.SNCdMW2f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126180836.SNCdMW2f@linutronix.de>

On Mon 2026-01-26 19:08:36, Sebastian Andrzej Siewior wrote:
> do_con_write(), fbcon_redraw.*() invoke console_conditional_schedule()
> which is a conditional scheduling point based on printk's internal
> variables console_may_schedule. It may only be used if the console lock
> is acquired for instance via console_lock() or console_trylock().
> 
> Prinkt sets the internal variable to 1 (and allows to schedule)
> if the console lock has been acquired via console_lock(). The trylock
> does not allow it.
> 
> The console_conditional_schedule() invocation in do_con_write() is
> invoked shortly before console_unlock().
> The console_conditional_schedule() invocation in fbcon_redraw.*()
> original from fbcon_scroll() / vt's con_scroll() which originate from a
> line feed.
> 
> In console_unlock() the variable is set to 0 (forbids to schedule) and
> it tries to schedule while making progress printing. This is brand new
> compared to when console_conditional_schedule() was added in v2.4.9.11.
> 
> In v2.6.38-rc3, console_unlock() (started its existence) iterated over
> all consoles and flushed them with disabled interrupts. A scheduling
> attempt here was not possible, it relied that a long print scheduled
> before console_unlock().
> 
> Since commit 8d91f8b15361d ("printk: do cond_resched() between lines
> while outputting to consoles"), which appeared in v4.5-rc1,
> console_unlock() attempts to schedule if it was allowed to schedule
> while during console_lock(). Each record is idealy one line so after
> every line feed.
> 
> This console_conditional_schedule() is also only relevant on
> PREEMPT_NONE and PREEMPT_VOLUNTARY builds. In other configurations
> cond_resched() becomes a nop and has no impact.
> 
> I'm bringing this all up just proof that it is not required anymore. It
> becomes a problem on a PREEMPT_RT build with debug code enabled because
> that might_sleep() in cond_resched() remains and triggers a warnings.
> This is due to
> 
>  legacy_kthread_func-> console_flush_one_record ->  vt_console_print-> lf
>    -> con_scroll -> fbcon_scroll
> 
> and vt_console_print() acquires a spinlock_t which does not allow a
> voluntary schedule. There is no need to fb_scroll() to schedule since
> console_flush_one_record() attempts to schedule after each line.
> !PREEMPT_RT is not affected because the legacy printing thread is only
> enabled on PREEMPT_RT builds.
> 
> Therefore I suggest to remove console_conditional_schedule().
> 
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Fixes: 5f53ca3ff83b4 ("printk: Implement legacy printer kthread for PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Just for record. This change looks OK from printk() POV.
printk() does console_trylock() and calls console_unlock()
with preemption disabled anyway, see vprintk_emit().

VT code still synchronizes some operations using console_lock().
It is possible that some non-printk related operations rely
on this. But it is hard to say. It might actually be a good
idea to find it out.

Also I have seen many printk-related softlockups. But they
were always caused by slow serial consoles. I can't remember
any in VT code.

Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com> # from printk() POV

Best Regards,
Petr
