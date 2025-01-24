Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1364193073
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750998; cv=none; b=iEZoezk5P/4r8duUFMif9CqEFlBN1E08gmzr2LI87kl2ykO+r2At91pkDbMIz7vLzhLxqqFNDiXoLfmV5fmXUrKTRXOT1+4LRGo/lKgGaMhiwQ6sOionn5Wvczi5MHZaQR0o+v7r1Fb8m/QPD+AppBIPawKMzMn4TfX1bF4ecpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750998; c=relaxed/simple;
	bh=oT/I0HTK1NGcwl7T9NpHluv2cwWMvqfm3nX16zXk8h8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lMavThqLt/ZjFEPNWYatbmltvgEGaRsVpoVqUsiJOZmCqHBNylkFS38xHAClWzY8OEjlaq00JOTy45eWGSIuPQut1URc+2Rlotr8OnPptT2v/FtMYI9Uhmi73g+jszeWYzPVzS4kSwOz/H0kFCtjI0DpD4HZcIzyGsIgXOtmnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsabQjpZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsabQjpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737750995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLs21lZZ8aY4y/zUCxxiI+oFbe6UlNBhVMGVIgTnCD4=;
	b=UsabQjpZLxJWSPaLCq4Jw8nhW6QB3WHV+gBV9L2smV+M9yItI4ZrMSFLELwKullNJLBP/v
	iN+ByF8DH38CzlHV1axOZAGipec6igWv3SFr16MhefylfAj7Q5+si4qfIcPbo/i939Q15d
	a76m2anIeb5veMgcq2NAiF7SmmoS3Ds=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-Fjz2ivJPORKXRLM_9EY5mw-1; Fri, 24 Jan 2025 15:36:23 -0500
X-MC-Unique: Fjz2ivJPORKXRLM_9EY5mw-1
X-Mimecast-MFC-AGG-ID: Fjz2ivJPORKXRLM_9EY5mw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6d0be4fb8so402815085a.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 12:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737750983; x=1738355783;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLs21lZZ8aY4y/zUCxxiI+oFbe6UlNBhVMGVIgTnCD4=;
        b=hY9w2HhX/3/dF61ZrgMPYXmUYmkWdVZhnUocegPg9u+kf11wq4/xNhPnrNFm9MfDyd
         4K2pyQScDkg9V9VCgeNXSXPmUUrbT9iIxM8id7odCtHTLAUlD9NIpGKnDs2J6NBRt/rK
         w5i0qYOyA0vHUiMlcGNuUsYpGyIUx2oZCZIVJ4OgQIQq408qNjZzlWFgrNhkSEeSE6Cc
         sJryf0iY3w+nu+W72QuMzp3fUBjDhUfiXA5xkyq8vwSNt5uEe9O9co2mg7RCkjjGmpIm
         9b/HaBvsWDTVxP7760VVFYaTJGRR0ljEIpU5muKlHQEomDSMEWs63+JXBlDhHmr1oS5k
         dIKg==
X-Forwarded-Encrypted: i=1; AJvYcCWDsWgO8kqMKH2MtjhRmkyLqxH9lCi+xV7rR38CVP2FKNdkXOlxkOFXwLZV6NHEiKsHqEBskGspOODB9zOcGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTfexdh67ZvENLd/C0cEa5Ad5bkMswheFovc9iP+pcPOqeKLGY
	xs48eUvVP39nWvupVp9X0bSctBR66rDIzSlCJw6rZ3KwEKLfO/jJyyu8LHte4tbLhwn1lNSAPVQ
	GLgyTYr7LJXDyMGY126piVK5gntM++SxEDhKXX5xs2bTuPNqbEzX/6TqL5fXS1E3k
X-Gm-Gg: ASbGncveg3+G8lDdyxYBo/MlJ76lDsBKhimsUCitZfJ7JgUaTxRu6oI7TFMCgj95tAw
	q82QRkng4VQ4ZnSElMWxTwrJrMg8d6lkjNcKMfNZEROKzzNoVsvjJnaz/98TuLth0y9Y/7ZV88f
	12D9Ll6vi1/Q2gByjDsjW4I1wsak+V+XhruF9F4Ixf98mJ62AXtxhPDDNfEc1L3aizoq4U8hGuc
	3+JuDPbeCv2yPLCKejDBRyL5Ko0HIpZRDAM7oPGBXCcKmq+nZu25TFdx0nKsILNmU1G9c9/G6ce
	RJ/f+9zKVo75Av7SXb58DeI49VKYoPMRa4qBfGcm
X-Received: by 2002:a05:620a:1790:b0:7b6:d089:274c with SMTP id af79cd13be357-7be6320bb6dmr4766308085a.34.1737750982995;
        Fri, 24 Jan 2025 12:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKfqgIyKNMUv1Jn9Z0ULjM0OcUzrITU84FYxPBzFidccy5R3c5ppRNBE5sbKwfbh8JuSMSVw==
X-Received: by 2002:a05:620a:1790:b0:7b6:d089:274c with SMTP id af79cd13be357-7be6320bb6dmr4766304285a.34.1737750982609;
        Fri, 24 Jan 2025 12:36:22 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af03b3dsm127803685a.90.2025.01.24.12.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 12:36:22 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <901c9b9f-d393-4b84-9b6e-fe79e316ee2d@redhat.com>
Date: Fri, 24 Jan 2025 15:36:21 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource: Defer preempt_disable() after
 clocksource_verify_choose_cpus()
To: paulmck@kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250124185923.3610964-1-longman@redhat.com>
 <20250124185923.3610964-2-longman@redhat.com>
 <a6818bae-1993-47ad-ac39-75fcfca38fc6@paulmck-laptop>
In-Reply-To: <a6818bae-1993-47ad-ac39-75fcfca38fc6@paulmck-laptop>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g8qxbq1se--do_KwY-Wy73WMfvUP7wAyL3t_M8_WLPw_1737750983
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/25 3:25 PM, Paul E. McKenney wrote:
> On Fri, Jan 24, 2025 at 01:59:23PM -0500, Waiman Long wrote:
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
>>
>> It is due to the fact that get_random_u32() is called in
>> clocksource_verify_choose_cpus() with preemption disabled.
>> If crng_ready() is true by the time get_random_u32() is called, The
>> batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
>> it is a rtmutex and we can't acquire it with preemption disabled.
>>
>> To avoid this problem, we can't call get_random_u32() with preemption
>> disabled. However, smp_processor_id() has to be called with preemption
>> disabled though and we have to exclude the current CPU from the
>> cpus_chosen list to be tested.
>>
>> Extract current CPU removal code out from
>> clocksource_verify_choose_cpus() and defer the preempt_disable()
>> call to after clocksource_verify_choose_cpus() and before
>> current CPU removal. Also use raw_smp_processor_id() in
>> clocksource_verify_choose_cpus().
>>
>> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Good catch!
>
> But we don't need cryptographically secure random numbers (or blistering
> speed) here.  Substituting something like torture_random()%nr_cpu_ids
> for get_random_u32_below() work?
>
> 							Thanx, Paul

That should work too. I can update the patch to use a less random 
generator if others have no objection.

Cheers,
Longman

>
>> ---
>>   kernel/time/clocksource.c | 19 +++++++++++--------
>>   1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index 77d9566d3aa6..8ffec49971ac 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -313,7 +313,6 @@ static void clocksource_verify_choose_cpus(void)
>>   	if (n < 0) {
>>   		/* Check all of the CPUs. */
>>   		cpumask_copy(&cpus_chosen, cpu_online_mask);
>> -		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
>>   		return;
>>   	}
>>   
>> @@ -322,9 +321,13 @@ static void clocksource_verify_choose_cpus(void)
>>   	if (n == 0 || num_online_cpus() <= 1)
>>   		return;
>>   
>> -	/* Make sure to select at least one CPU other than the current CPU. */
>> +	/*
>> +	 * Make sure to select at least one CPU other than the current CPU.
>> +	 * raw_smp_processor_id() is used opportunistically here as
>> +	 * preemption isn't disabled.
>> +	 */
>>   	cpu = cpumask_first(cpu_online_mask);
>> -	if (cpu == smp_processor_id())
>> +	if (cpu == raw_smp_processor_id())
>>   		cpu = cpumask_next(cpu, cpu_online_mask);
>>   	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
>>   		return;
>> @@ -349,9 +352,6 @@ static void clocksource_verify_choose_cpus(void)
>>   		if (!WARN_ON_ONCE(cpu >= nr_cpu_ids))
>>   			cpumask_set_cpu(cpu, &cpus_chosen);
>>   	}
>> -
>> -	/* Don't verify ourselves. */
>> -	cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
>>   }
>>   
>>   static void clocksource_verify_one_cpu(void *csin)
>> @@ -373,15 +373,18 @@ void clocksource_verify_percpu(struct clocksource *cs)
>>   	cpumask_clear(&cpus_ahead);
>>   	cpumask_clear(&cpus_behind);
>>   	cpus_read_lock();
>> -	preempt_disable();
>>   	clocksource_verify_choose_cpus();
>> +	preempt_disable();
>> +
>> +	/* Don't verify ourselves. */
>> +	testcpu = smp_processor_id();
>> +	cpumask_clear_cpu(testcpu, &cpus_chosen);
>>   	if (cpumask_empty(&cpus_chosen)) {
>>   		preempt_enable();
>>   		cpus_read_unlock();
>>   		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
>>   		return;
>>   	}
>> -	testcpu = smp_processor_id();
>>   	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
>>   		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
>>   	for_each_cpu(cpu, &cpus_chosen) {
>> -- 
>> 2.47.1
>>

