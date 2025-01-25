Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222523774
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Jan 2025 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737770510; cv=none; b=mut3eMk1qLxqKF8nmOLUeSmDTYAKDzqQKZoY4KtyxfKHTwdpvMJm+TONEYXnTj3vaZWCaBi3nv9UnqJbLXQUh6516AAdHosHMlZgfk2P5QCOGBi++oGuBRMzWnArBESbBLOgNPdUS2LsE9/tRdjOWU+WgSBmqFn6AOSbxAXtVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737770510; c=relaxed/simple;
	bh=cVEMb9FKyX9wTgcy9cjYTqErLhwV8AbS8czvEY5N/DY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eVtpjxxUrlkNzXw3WaE/0OsHRjlXNLeZE/097F3OmfIT01YI/htd0VCyz0QO08fayEvgw+TKGbhp6YVxCI4IpDUzUfm5GmLGLt2m9m9Y/eIBZeT6F++WvYuI/lXASSqcMwQ+495L2s63i+qRhqE0LuNU0XoLChaljfG3KCzPSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwnwVbl+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwnwVbl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737770507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pULPbujCUbYv0/SSC4HB9iAi0YMWoPGg99OUkg1EGMI=;
	b=OwnwVbl+5a4oJIdeKTmUYQm0CTkHefTl5OpoMbb4hK1ozi6YWHoGflT44YOcu1/7rGbjpO
	J5SN4yLjSZXQ5oXqv2RMdx52Q6b3rUvZJTGVPN/IokrCM8kwCV/UPfzhbYUcDGNeh0bvtI
	ShZ8ZD1ri6ucRqF/4u7sqlW4CQpAIpY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-kYu5v1XGMXWUKt612X8oHQ-1; Fri, 24 Jan 2025 21:01:46 -0500
X-MC-Unique: kYu5v1XGMXWUKt612X8oHQ-1
X-Mimecast-MFC-AGG-ID: kYu5v1XGMXWUKt612X8oHQ
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e572f6dee18so7497147276.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 18:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737770505; x=1738375305;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pULPbujCUbYv0/SSC4HB9iAi0YMWoPGg99OUkg1EGMI=;
        b=fHwuBHlionlyGQCCG2gUeK0uK051iKGo/jYwpPjUOHEYW9D65N3gpF0ZSgT6cgu4on
         bZDKZ1x7eMxYx8qQf+vScNB1QiK1IezD/Ug0/hCWRexn/UFjQ2STUefehTIUk0A8uG8J
         Z5TqtaIsnrsxz4FdAknefvENLL5aR/SOmeYVWpp1/lJgSpI83mrh9eHXGDibKuK1ZEhz
         E7QuXMUUXhtqR5gSoJhGHFLCLPiR5dyKAaYcLFtIV64ISJ72sak5mExMAvnVTCdZR//u
         HEIaB2zYdsJ7gKygNfiUfYJKv7fEVihk5NKqlTftNJkGPMdd0LPE6u9Jl/J65EFA3Ujl
         kRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxs61p6PwnCflVdMOxnd4ebvjGAkcIrn/WwP8yGQ7rUzOZ69eeNpBJKfYgwnwBjzmp1V4kQlPHn+JVymz2Cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyICLVRDd6N4zafdKKMzrXOhZ5cYYoiTXBgh7KgvR+UFuCUjYNA
	BdYd8o0K4Fvh6kbwg9CEGVAmvPAzbdDnQDt0Ly6zAS422uwsea0cyEirfbtEb78AgEurxGwTgb1
	Pv//E9tfo6lkop41ANHLbow8TIRC0iCfUu0vmJfOzS83HdTWO3ZF7bJBM4LG1CinU
X-Gm-Gg: ASbGncvvx0iKuQNe8lpE+YZXP9BGaKBIWjSG39Uv+AusljI0LCKR0dknqpTzsVtz/vH
	U2gcF03DBl6vZvTutB7yFQWnjK7xOHo1lsl8N3RUq/hZW1c7ZElAW58nUKD0bltZsW7k0V4xctq
	poBed/AyqkS0m/uPSwmRRsuNtdrLv3canDR/KYyrhOUuDH5at1rnOkgbouSGJWbuag2W7+m/V8Y
	AK89JmB4Y+hjMuPkk6EjpJuINdzYS/6Tv6Y1A/ADEZovWuN6lnqqiTqraEHUrCvx6miZRLgV1B7
	2dTNvXXX5w6ux7tERuYm7n3qaX0eNS6hu7w1RCQmh9Y9uBVfmkA=
X-Received: by 2002:a05:690c:ece:b0:6ef:a4ec:f69b with SMTP id 00721157ae682-6f6eb677e0emr297923627b3.10.1737770505524;
        Fri, 24 Jan 2025 18:01:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPOVr9kdwg8fegJZPgixvzFDPsgRoEc5ZSnzWu7q9SxrVa6+xNZ17nkGmJj35ABrQwGAP2lQ==
X-Received: by 2002:a05:690c:ece:b0:6ef:a4ec:f69b with SMTP id 00721157ae682-6f6eb677e0emr297923377b3.10.1737770505211;
        Fri, 24 Jan 2025 18:01:45 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a2c0f8sm5881497b3.104.2025.01.24.18.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 18:01:44 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c618d56d-5e7d-4100-92c2-33ff3934019d@redhat.com>
Date: Fri, 24 Jan 2025 21:01:43 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource: Defer preempt_disable() after
 clocksource_verify_choose_cpus()
To: paulmck@kernel.org, Waiman Long <llong@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250124185923.3610964-1-longman@redhat.com>
 <20250124185923.3610964-2-longman@redhat.com>
 <a6818bae-1993-47ad-ac39-75fcfca38fc6@paulmck-laptop>
 <ba435a6c-ace6-4e14-bda1-5289cde23176@paulmck-laptop>
 <33340159-3bee-48cc-85a0-830305e736aa@redhat.com>
 <751e87e0-4113-4887-8436-c4a69c82abcb@paulmck-laptop>
In-Reply-To: <751e87e0-4113-4887-8436-c4a69c82abcb@paulmck-laptop>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dgaRTSSVRkaFHQo5yS_Td3CCeiROKFvZ8UqbRJklmQQ_1737770505
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/24/25 4:37 PM, Paul E. McKenney wrote:
> On Fri, Jan 24, 2025 at 03:41:45PM -0500, Waiman Long wrote:
>> On 1/24/25 3:37 PM, Paul E. McKenney wrote:
>>> On Fri, Jan 24, 2025 at 12:25:19PM -0800, Paul E. McKenney wrote:
>>>> On Fri, Jan 24, 2025 at 01:59:23PM -0500, Waiman Long wrote:
>>>>> The following bug report happened in a PREEMPT_RT kernel.
>>>>>
>>>>> [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>>>> [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
>>>>> [   30.962673] preempt_count: 1, expected: 0
>>>>> [   30.962676] RCU nest depth: 0, expected: 0
>>>>> [   30.962680] 3 locks held by kwatchdog/2012:
>>>>> [   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
>>>>> [   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
>>>>> [   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
>>>>> [   30.977827] Preemption disabled at:
>>>>> [   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
>>>>> [   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
>>>>> [   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
>>>>> [   30.982846] Call Trace:
>>>>> [   30.982850]  <TASK>
>>>>> [   30.983821]  dump_stack_lvl+0x57/0x81
>>>>> [   30.983821]  __might_resched.cold+0xf4/0x12f
>>>>> [   30.983824]  rt_spin_lock+0x4c/0x100
>>>>> [   30.988833]  get_random_u32+0x4f/0x110
>>>>> [   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
>>>>> [   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
>>>>> [   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
>>>>> [   30.993898]  clocksource_watchdog_kthread+0x18/0x50
>>>>> [   30.993898]  kthread+0x114/0x140
>>>>> [   30.993898]  ret_from_fork+0x2c/0x50
>>>>> [   31.002864]  </TASK>
>>>>>
>>>>> It is due to the fact that get_random_u32() is called in
>>>>> clocksource_verify_choose_cpus() with preemption disabled.
>>>>> If crng_ready() is true by the time get_random_u32() is called, The
>>>>> batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
>>>>> it is a rtmutex and we can't acquire it with preemption disabled.
>>>>>
>>>>> To avoid this problem, we can't call get_random_u32() with preemption
>>>>> disabled. However, smp_processor_id() has to be called with preemption
>>>>> disabled though and we have to exclude the current CPU from the
>>>>> cpus_chosen list to be tested.
>>>>>
>>>>> Extract current CPU removal code out from
>>>>> clocksource_verify_choose_cpus() and defer the preempt_disable()
>>>>> call to after clocksource_verify_choose_cpus() and before
>>>>> current CPU removal. Also use raw_smp_processor_id() in
>>>>> clocksource_verify_choose_cpus().
>>>>>
>>>>> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> Good catch!
>>>>
>>>> But we don't need cryptographically secure random numbers (or blistering
>>>> speed) here.  Substituting something like torture_random()%nr_cpu_ids
>>>> for get_random_u32_below() work?
>>> I suppose I should add my concern...  If we don't have preemption disabled
>>> across this code, we cannot reliably avoid attempting to IPI ourselves.
>> Does the CPU choosing process itsself needs to have preemption disabled? I
>> thought it was because of need to use smp_processor_id() and have the
>> current CPU excluded. Preemption is still disabled after that.
> If the function is migrated from one CPU to another, the check against
> raw_smp_processor_id() doesn't mean much.  At that point, you might
> as well just rely in the calling function clearing it.
>
> And the extra preemption happens only in an error condition were extra
> debugging is enabled.  Plus clocksource_verify_choose_cpus() should be
> pretty quick.  So do we really care about the additional disabling of
> preemption?

I understand your concern about using raw_smp_processor_id().

Anyway, I took your suggestion of using another less random 
pseudo-random generator and call it a day. Unfortunately, I can't use 
torture_random() as it is only available if CONFIG_TORTURE_TEST is set 
:-(. Please let me know if you are OK with the v2 patch.

Cheers,
Longman

