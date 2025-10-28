Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940D36A5E3
	for <linux-rt-devel@lists.linux.dev>; Tue, 28 Oct 2025 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692007; cv=none; b=M/vyy6kgQbcaTHEBWM0PYAwfHXmutgZVWwP2XPZqH2jPiUQRR9VDhPKx2A8BQsTgW9OBRjMv0EA7SP2rrgMmxKWE3fQMkY0VFTYhme6W59FJnLwmaRxm7QkJTnntAN9PhZ43YcreZT73XBhx1qR33eEs1RrUl1Q34mx8lQAC+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692007; c=relaxed/simple;
	bh=VA/50lW1vCkT731hgvkr6oq1CNTztzPrIPAiyjCETNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIgf0iIX7raC2vrBTcWdIizKXzFPpx6R/D90ngPSDD7X0mICkqPihiRQhHdWiIT9QY98hxZP1vMZhupEM10laAX2+ttoml1U0dSCAn1jCzrr5PzD+u9IYnoNoeBz9eMZgW/zHeiPzxgBTxntHq6spPtmaiAf16xQpNvqManIJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47174b335bso625574a12.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 28 Oct 2025 15:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692005; x=1762296805;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjSnd5l8S3dUErL7gowllXRoXAKycS7W8eLKtMWtz7w=;
        b=R3csULQrBZdfvvQHjj5mcqkwKpsjxgBXwlGE9s2gXCKbQfo5ABRGRTOaGo8dX4Ovdj
         HfvNEW5lkWnN1x/O90osEyu9uyffFOs5hv+/wzDGz/2DyYZKSfsFKYDlNYNRa0x/xJda
         3Hq6fAE85ckifcOLSLTelbiCHqKds1tw8E9FJeqOJZTJ8QhzzvkuJXFIuw1sdd9tjbLn
         bJWmPRT77tzRc1o15StvgJ44tBNsVqw+h+4ZK9i5MidfEf+X4LBvqn/IrZuveHCpWzi0
         jhaTp6e0tAM4/yadVesn/vFYazL4SZapoq6CVrAP4tN1V0xOUrBSWykSnH9/R9XYi7OU
         X0YA==
X-Forwarded-Encrypted: i=1; AJvYcCVVcpWBNO5C0g93eV68xTpZHH342P2x25UXeIj41CD/ZGBYFczYUrxKhveZ4VLXORrT+Ta1LInjQv+uEnlEWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBbjmyDN74Cg5yvpS9+EFtPKUAvPDtwONAor8T3uynm6uF+tle
	CAtAcYujg4tDPDlZ7vkEv32/b1jXik3UeMZPLanbsPTWevdt3TDidB1A
X-Gm-Gg: ASbGnctSTNO4Zv+/t6KjwDoc/3TKBd6ay6BBt5Wnc0/ybmcjKsJD4vywIQlLFAdjLFb
	OkTl68C3h/ZegpYguFpqFJQDYBj23rG6BJljhjX7jye4cO6ITBbL9RCM6Gea9lNrsGCDI7mZgVI
	8j1n188rHkbfpDOJTkrXEWX+n6M4QGzUavWZ2Rwgf/zyOVLNu8gf3tnaKbNPkMZ0SfS11qFpDqt
	4E0RORsivvNfE5sNAf6JzQcd77WJqFpOl5mKCRlIqvkI8cJ+jnlVYrlgkN14Hf7TUMOyp3SfuzN
	U576DAT1TMlrV7OQQTQackKdhn1tlC23edOXcJDfNCfb2zH7UEf1bBAwb3NvIJBgGu4m/lakGv9
	27cDh0/N3KyRKq+Rtl8Oso8vmeHXrHRyeyHKCMsg3cv9Aj2fdRozmQsLTcWxm9GGMPykmxQR7Da
	eou8WxoS4T+2556Jmnpbb5JqfGf93XLqtZNelUXvlI+pYQSl99sSH+Th83255GmDZhz/NMjdq0L
	gTo
X-Google-Smtp-Source: AGHT+IEG6YZVGR3FN78i1rQlW8UfbphShHXpGFbD0oLHzjMRZ6d3TKgzn5msHJQixINYVCaCn2PhVQ==
X-Received: by 2002:a05:6a20:258c:b0:2e3:a914:aabe with SMTP id adf61e73a8af0-34652718874mr468308637.2.1761692004971;
        Tue, 28 Oct 2025 15:53:24 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f4a8833sm11430147a12.37.2025.10.28.15.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:53:24 -0700 (PDT)
Message-ID: <eed6ff19-a944-4e4c-96e4-0f44e888c71d@kzalloc.com>
Date: Wed, 29 Oct 2025 07:53:20 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via RV
 (Runtime Verification) monitor rtapp:sleep
To: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <nam.cao@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <d23d133b52ef574d669f1656789b78d07c91c9f5.camel@redhat.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <d23d133b52ef574d669f1656789b78d07c91c9f5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gabriele,

On 10/27/25 9:20 PM, Gabriele Monaco wrote:
> On Mon, 2025-10-27 at 15:54 +0900, Yunseong Kim wrote:
>> Hi Nam,
>>
>> I've been very interested in RV (Runtime Verification) to proactively detect
>> "sleep in atomic" scenarios on PREEMPT_RT kernels. Specifically, I'm looking
>> for ways to find cases where sleeping spinlocks or memory allocations are used
>> within preemption-disabled or irq-disabled contexts. While searching for
>> solutions, I discovered the RV subsystem.
>>
> 
> Hi Yunseong,
> 
> I'm sure Nam can be more specific on this, but let me add my 2 cents here.

Thank you so much for your detailed response! It cleared up many of the
questions I had.

> The sleep monitor doesn't really do what you want, its violations are real time
> tasks (typically userspace tasks with RR/FIFO policies) sleeping in a way that
> might incur latencies. For instance using non PI locks or imprecise sleep.

So that’s the role of rtapp:sleep you mentioned. Thank you again for
clarifying it.

> What you need here is to validate kernel code, RV was actually designed for
> that, but there's currently no monitor that does what you want.

It’s a valuable chance to make a contribution to RV!

> The closest thing I can think of is monitors like scpd and snep in the sched
> collection [1]. Those however won't catch what you need because they focus on
> the preemption tracepoints and schedule, which works fine also in your scenario.
> 
> We could add similar monitors to catch what you want though:
> 
>                      |
>                      |
>                      v
>                    +-----------------+
>                    |   cant_sleep    | <+
>                    +-----------------+  |
>                      |                  |
>                      | preempt_enable   | preempt_disable
>                      v                  |
>     kmalloc                             |
>     lock_acquire                        |
>   +---------------      can_sleep       |
>   |                                     |
>   +-------------->                     -+
> 
> which would become slightly more complicated if considering irq enable/disable
> too. This is a deterministic automaton representation (see [1] for examples),
> you could use an LTL like sleep as well, I assume (needs a per-CPU monitor which
> is not merged yet for LTL).
> 
> This is simplified but you can of course put conditions on what kind of
> allocations and locks you're interested in.

If the goal is to detect this state before the output from __might_resched()
under CONFIG_DEBUG_ATOMIC_SLEEP (i.e., before an actual context switch occurs),
I am considering whether Deterministic Automata (.dot/DA) or Linear Temporal
Logic (.ltl/LTL) would be more appropriate for modeling this check. I'm also
thinking about whether I need to create a comprehensive table of all sleepable
functions for this purpose on the PREEMPT_RT kernel.

If this check is necessary, I’m planning to try the following verification:

RULE = always ((IN_ATOMIC or IRQS_DISABLED) imply not CALLS_RT_SLEEPER)

I’m also planning to add sleepable functions, including sleepable spinlocks
and memory allocations callable under PREEMPT_RT preempt/IRQ-disabled states,
to the RV monitor kernel module.

I’m considering adding the following functions as a result:

 // Mutex & Semaphore (or Lockdep's 'lock_acquire' for lock cases)
 "mutex_lock",
 "mutex_lock_interruptible",
 "mutex_lock_killable",
 "down_interruptible",
 "down_killable",
 "rwsem_down_read_failed",
 "rwsem_down_write_failed",
 "ww_mutex_lock",
 "rt_spin_lock",
 "rt_read_lock",
 "rt_write_lock",
 // or just "lock_acquire" for LOCKDEP enabled kernel.

 // sleep & schedule
 "msleep",
 "ssleep",
 "usleep_range",
 "wait_for_completion",
 "schedule",
 "cond_resched",

 // User-space memory access
 "copy_from_user",
 "copy_to_user",
 "__get_user_asm",
 "__put_user_asm",

 // memory allocation
 "__vmalloc",
 "__kmalloc"

> Now this specific case would require lockdep for the definition of lock_acquire
> tracepoints. So I'm not sure how useful this monitor would be since lockdep is
> going to complain too. You could use contention tracepoints to catch exactly
> when sleep is going to occur and not /potential/ failures.

I’ll look into this lockdep realated part further as well.

> I only gave a quick thought on this, there may be better models/event fitting
> your usecase, but I hope you get the idea.
> 
> [1] - https://docs.kernel.org/trace/rv/monitor_sched.html#monitor-scpd

Thank you for providing a diagram and references that make it easier to
understand!

>> Here are my questions:
>>
>> 1. Does the rtapp:sleep monitor proactively detect scenarios that
>>    could lead to sleeping in atomic context, perhaps before
>>    CONFIG_DEBUG_ATOMIC_SLEEP (enabled) would trigger at the actual point of
>>    sleeping?
> 
> I guess I answered this already, but TL;DR no, you'd need a dedicated monitor.
> 
>> 2. Is there a way to enable this monitor (e.g., rtapp:sleep)
>>    immediately as soon as the RV subsystem is loaded during boot time?
>>    (How to make this "default turn on"?)
> 
> Currently not, but you could probably use any sort of startup script to turn it
> on soon enough.
> 
>> 3. When a "violation detected" message occurs at runtime, is it
>>    possible to get a call stack of the location that triggered the
>>    violation? The panic reactor provides a full stack, but I'm
>>    wondering if this is also possible with the printk reactor.
> 
> You can use ftrace and rely on error tracepoints instead of reactors. Each RV
> violation triggers a tracepoint (e.g. error_sleep) and you can print a call
> stack there. E.g.:
> 
>   echo stacktrace > /sys/kernel/tracing/events/rv/error_sleep/trigger
> 
> Here I use sleep as an example, but all monitors have their own error events
> (e.g. error_wwnr, error_snep, etc.).
> 
> Does this all look useful in your scenario?

Thank you once again for your thorough explanation. Many of the questions
I initially had have now been resolved!

> Gabriele

Best regards,
Yunseong Kim
