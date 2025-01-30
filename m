Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B54322B
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jan 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254499; cv=none; b=OSzRQODELSEegEvCgoCsXOuvLg32X14r5jRJtxyg/gcQSgIHphxf+uQuI+X8LFxiOIl8YIweH+xkdKeFAXhpseTdXTmyZabK/+/OLfeZFb4gDPSaVWXd5QzrW1gnrulYfb9v0/huFTvGWS3MtA0vu6wvcgZfvX3zX/kvtNdF+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254499; c=relaxed/simple;
	bh=JZmAvfHWDNE9P3TCEIAYWOpJfX6mCFuuzPHnTBNRHOE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YGeu4qK1NaBoN2ubTDZ3c5LZOAICxWVC7wE1NS+jY2hdCMHNYcRK5T4Q94FUkYnPlMRkWOeVvmX1Q+675ptQvmpWc7imWpuja1vsMTEd1dCeqN33FwJml/ewFpQOPGIHpjwjo0n9PnP9rczGhxHIHiR0y5X1gshuRpiivH6MZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbjamxqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbjamxqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738254495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9BjlGQKeWeaMgeK1g6I2+q5DgMoSFGoqGyfk70GI8=;
	b=YbjamxqZcAGjAFVpFt7iG+VjmyViO54Qify1bM1C+eELvUG9CGs+6gox+iB3HRwTRYwnkA
	h6abNW7HSi52akPFJxuCpfLf0wH9DUyguBcNvQYa1dAjesd01lSWHDDHNvhSxiab7wqZ7T
	RsauE/eVzFW/OvMqdAzJRT9rP198S3A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-sQM8QeiYMQ-oa_Zi7Jkj8Q-1; Thu, 30 Jan 2025 11:28:13 -0500
X-MC-Unique: sQM8QeiYMQ-oa_Zi7Jkj8Q-1
X-Mimecast-MFC-AGG-ID: sQM8QeiYMQ-oa_Zi7Jkj8Q
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d884999693so16166876d6.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jan 2025 08:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738254493; x=1738859293;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0q9BjlGQKeWeaMgeK1g6I2+q5DgMoSFGoqGyfk70GI8=;
        b=o0lkCp9ZUNtIwrFXJ+mSlcXjFhL5w4qye/2pnwZIm734OQdLlyuAY40OPIz9m//btB
         jr4tBwwpqlcECSyQtaQBX14j8/YN7IoDCM1CAeagMCmhL8DdK0IIudHvaI8okib/4qoF
         bGH9xBPPWQe86BoYJoqvSrPd3VZ4nitKrv0S0Q8UW2YqtBoUN1oFMz4OhtMgLM/fWhTg
         Gnjdy86RIWha76RMEx7JfpA/8VPlCppBZVbbdQop3/JUldiX9GVfMG+KB0nMxgNKyDKO
         8lxz8JOHcdH9uvumiahyMnEfTvDwvZBym49Qn4AVupU6n2InD8niOV7H2YIpoh8J8hVl
         uU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxkXped0LScDlLh1RDNn4Q5Swx3zq6SXDkWOIbLRsCls1cJQrXtkQ6xLR/XUAD2QcKFINpLrdCeKUD82HpYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6rOb/xkBRmpj9mkn5PBV+s25Re/K0tdXaV65ZH2kDDB58S1pn
	HlR3vmG0a28qM6bQbR5tF7ujhfKdiISJxaXwd1SqAr6zj/v8dRR5q7yB1zFNYoArtwHjYrqHM/L
	/CofQGbj3ymQtwYDaKnfI8FPQkEC4tRedqfUgMFudEP4BlqbinC3zlzotRLfoJHO7
X-Gm-Gg: ASbGncvuAQ8/pJIjHmpIcOdGCpqlITnvZFy4pFMzyCThf0a7j/xPDrAY9/BX/V1pIyp
	B9FeK3zFWyG8/AK3O0NY2h+lQtnQVY49WMXJ77uaeU4skshCOjYAGCwJEydv1rG44Y90xzgIdws
	6v/x9HpoOFJP1RCYij0laUiv354H+/JNw3AjAX2SiNMt5n9uOlM2uq5fGt+5pBH8KYjfDBJlevE
	W3yTGb4/e1KzZQ1lDveioaI4iLn5/96ADXbXGeD+/JlMYJx7aA0wBa9uk88CA3gNZ2gpceQjPx4
	T1q8ZVzUxIecSKN7LgzKp+VVeVWbnUcXEV9te9nMXfIQBAVdVAo=
X-Received: by 2002:a05:6214:5d87:b0:6d8:a5da:3aba with SMTP id 6a1803df08f44-6e243c3b07amr119214586d6.20.1738254493381;
        Thu, 30 Jan 2025 08:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuS41GuDwjWEVyrWWhvDUX3niA7k91DK+a/unzSePN1quwBtNSdrSr7UsQKA+g4DAs566cgg==
X-Received: by 2002:a05:6214:5d87:b0:6d8:a5da:3aba with SMTP id 6a1803df08f44-6e243c3b07amr119214326d6.20.1738254493099;
        Thu, 30 Jan 2025 08:28:13 -0800 (PST)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814192sm7712256d6.37.2025.01.30.08.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 08:28:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <43690463-f0ab-48ba-a31b-b514112c4ec9@redhat.com>
Date: Thu, 30 Jan 2025 11:28:11 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250129224001.430506-1-longman@redhat.com>
 <20250129224001.430506-2-longman@redhat.com>
 <20250130073704.2h2vRBTJ@linutronix.de>
In-Reply-To: <20250130073704.2h2vRBTJ@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GGB2IOEV-oZnOihXzmiVBZ6FRpVDfjIDqK7C3T4YFsM_1738254493
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/30/25 2:37 AM, Sebastian Andrzej Siewior wrote:
> On 2025-01-29 17:40:01 [-0500], Waiman Long wrote:
>
> Instead of the backtrace
>
>> The following bug report happened in a PREEMPT_RT kernel.
>>
>> [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
>> [   30.962673] preempt_count: 1, expected: 0
>> [   30.962676] RCU nest depth: 0, expected: 0
>> [   30.962680] 3 locks held by kwatchdog/2012:
>> [   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
>> [   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
>> [   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
>> [   30.977827] Preemption disabled at:
>> [   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
>> [   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
>> [   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
>> [   30.982846] Call Trace:
>> [   30.982850]  <TASK>
>> [   30.983821]  dump_stack_lvl+0x57/0x81
>> [   30.983821]  __might_resched.cold+0xf4/0x12f
>> [   30.983824]  rt_spin_lock+0x4c/0x100
>> [   30.988833]  get_random_u32+0x4f/0x110
>> [   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
>> [   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
>> [   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
>> [   30.993898]  clocksource_watchdog_kthread+0x18/0x50
>> [   30.993898]  kthread+0x114/0x140
>> [   30.993898]  ret_from_fork+0x2c/0x50
>> [   31.002864]  </TASK>
> which is huge and doesn't provide much unique information could please
>
>> It is due to the fact that get_random_u32() is called in
>> clocksource_verify_choose_cpus() with preemption disabled.  The
>> batched_entropy_32 local lock and/or the base_crng.lock spinlock will
>> be acquired. In PREEMPT_RT kernel, they are rtmutexes and the above
>> warning will be printed if the fast path fails because of contention.
> extend this?
> clocksource_verify_choose_cpus() is invoked with preemption disabled, it
> invokes get_random_u32() to obtain random numbers. To do so it acquires
> the lock batched_entropy_32 which is a local_lock_t. This lock becomes a
> sleeping lock on PREEMPT_RT and must no be acquired in atomic context.
>
>> Fix this problem by moving the clocksource_verify_choose_cpus() call
>> before preempt_disable() while moving the part that needs preemption to
>> be disabled out into a new clocksource_verify_fixup_cpus() helper that
>> is called after preempt_disable(). In that way, the get_random_u32()
>> function will now be called with preemption enabled.
> Could you replace the patch below with
>    https://lore.kernel.org/all/20250129202909.GQNNqNoH@linutronix.de/
>
> Or is there anything that makes it not work? It looks way simpler. Just
> to disable preemption during the measurement and keep the task on the
> same CPU for the whole time.
>
>> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
>> Signed-off-by: Waiman Long <longman@redhat.com>

I will send a v4 to incorporate your suggestion.

Cheers,
Longman

