Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440710F9
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jan 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170220; cv=none; b=HuWpkbUNHw+MuOiTggzy7PwX/u/MsqIF3Fquam2YUWiOQtJ6QJkptP7LodivsS1Rq1iot+7KI//4i95RjLdoA1mlSbaUmvjsNB00NfuTLJZyp8AJqHOltATOZAo0dTMffLECZ0B8gmOCdRcamgZt7h7kLmHDg+kWE8pFTjWX8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170220; c=relaxed/simple;
	bh=2TTwdKklraHYomZrGXBGqZjTgxzSjLWVPQYctmw1ZHY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MNTAPa1kRfMesfmUsv9Ntuhy+iBN1sY36O/2VKysEl5tXJGFAbiGMcxkN/hbXirBcm2B4Qb+EkGsO4d6D5SS0PIYpLa09UX3+TRoWPL+AMk42d6mYsW/NzS5jkEnpxE03AShqUkQWmhpF4m0IG+p2URnDOH15HtxseY4cPFQSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ly3SfGXM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly3SfGXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738170218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ye1xyBra/0rih/flelrQKuAGjII/XW7CPUWlmNVnDc=;
	b=Ly3SfGXMMq9HjMgnFJl20kPT2bP0HY0B8xJ8VfeelzFHkeBX3q+6aRe0h1Cm7DrTpVsw+a
	35fb4CdlSPKBHtoTqRb3nc+vUtnDJoHT+hD7KJ4qQjXt0bEIsHZc3MROyCk1zcCW1Ktisz
	QxOj3hHAOeg5XQAoD29pPLt1NspYl+E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-zW8gH8NJOHiVgw6ztOkDbg-1; Wed, 29 Jan 2025 12:03:36 -0500
X-MC-Unique: zW8gH8NJOHiVgw6ztOkDbg-1
X-Mimecast-MFC-AGG-ID: zW8gH8NJOHiVgw6ztOkDbg
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e7f07332so1104436985a.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jan 2025 09:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170216; x=1738775016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ye1xyBra/0rih/flelrQKuAGjII/XW7CPUWlmNVnDc=;
        b=rQkrjPZVnDRsoZ99VE47lyp+v9e5RvLTkYLckaqfy4DOXArFPWWsAkWUjNNKU6lzsd
         uRuU1gCFXUCb6r48RCvE+NWeefJmEDsAp7GBDFVsaPDf2AbEg9IYO5ZAX23InUKu0uld
         OGnpHPYNNTIPJhlNzOXlskoP3VP55ASBrjmlgDx9ukH2ivQoaX/As6m7SWjEl2aemqwS
         T1BV2UF/Z7QJ8BoJVf/XssLbt7QkDdB0oKZx3oTRtKd98YYO91PJS2XP21WOb57hu/EP
         3QWpGFhUCct6QeAACUjAdBC7i4WY3LWTRqC87FmBKR5CkdNGa9x/i8gMPIhXZJ4/CvYB
         rJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxRuslmAgxfTdBPnMoFvwHEZWbUYr++/2Dk82L6ddlk546mE9B3sgzsUMd0h/rYC9NPXVOoLrzQh3GCCpzmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw/X9PcRIcH2ARC/KGLS/1LU4NO+2Il9+lCBj1oLgOrX6CZzHA
	s5qF4T351z3Gn9lNbKBnHufRRvYY3kKzEPY0HeQUlPLfXfcAi8vdP5SDZLoc/g4/C99wHmBhKtt
	+V5ZYvLw1v/T1lw6Dj/eGuGp232R7De088qWwYvPSmcIKg1RDHORvigpFhuG93aSY
X-Gm-Gg: ASbGncu2lue9FZtTBRHG1USoEz/rSOZVNWjTlzsW9weUZ7oEt5V8OphxUUp00ce1M9r
	it8LBSFHBw15rggOb2qvKN6AUWJDo14awAGnXcUrFR4Oau6WlZTU5aGTfaqlz5IWxuDsFVG6HqP
	BqnIowI7hERsqbSuU7SJ3vtpAzS2jWrr7sEU5FsreAXyd8DgkClcyYFfbDCyBPCaiUpR367ndlH
	tk+uPBiJJYdzXG8humo1qEDK+7U2DKk2ji7oXGE4jw10aCn+XU583hzRLw+kjpYOZWqfWuuOjVF
	02adJsirHFh3a8OjswYWOh6qbmmVEAaP1cMQCXEKBEzGXscuZIs=
X-Received: by 2002:a05:620a:278f:b0:7b6:d58b:9de5 with SMTP id af79cd13be357-7bffcd14cc8mr650203085a.13.1738170216347;
        Wed, 29 Jan 2025 09:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrWE1/4Zj1nnLdqik4mpC4pfeNi38xUT7n99j0anMC/IUemwTH7eEG2cIlKpp32x7hF96Trw==
X-Received: by 2002:a05:620a:278f:b0:7b6:d58b:9de5 with SMTP id af79cd13be357-7bffcd14cc8mr650195385a.13.1738170215802;
        Wed, 29 Jan 2025 09:03:35 -0800 (PST)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7f879sm637015485a.14.2025.01.29.09.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 09:03:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5abcb42b-91be-4043-a138-5d97cbcb5378@redhat.com>
Date: Wed, 29 Jan 2025 12:03:34 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250125015442.3740588-1-longman@redhat.com>
 <20250125015442.3740588-2-longman@redhat.com>
 <20250129163442.vczSGi63@linutronix.de>
In-Reply-To: <20250129163442.vczSGi63@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bt9Rqf199QhU0Iad8hJkHRk2HrLeBIwN7OMVCBpZ_e8_1738170216
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 11:34 AM, Sebastian Andrzej Siewior wrote:
> On 2025-01-24 20:54:42 [-0500], Waiman Long wrote:
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
>> Fix this problem by using the less random get_random_bytes() function
>> which will not take any lock. In fact, it has the same random-ness as
>> get_random_u32_below() when crng_ready() is false.
> So how does get_random_bytes() not take any locks? It takes locks in my
> tree. You two have a lock less tree?

You are right. I forgot to check the crng_make_state() call in 
_get_random_bytes() which does take lock.


>
> In case your tree is not lock less yet, couldn't we perform the loop
> verify_n_cpus+1 times without disabled preemption? Then disable
> preemption after return from clocksource_verify_choose_cpus() and then
> either remove current CPU from the list if it is or remove a random one
> so that we get back to verify_n_cpus CPUs set.
>
> Alternatively, (and this might be easier) use migrate_disable() instead
> of preempt_disable() and only use preempt_disable() within the
> for_each_cpu() loop if delta is important (which I assume it is).
>
> But all this would avoid having to run with disabled preemption within
> clocksource_verify_choose_cpus() while having the guarantees you need.

I guess we will have to break clocksource_verify_choose_cpus() into 2 
separate parts, one without preemption disabled and other one with 
preemption disabled. I don't think it is a good idea to just use 
migrate_disable() as we may get too much latency that can affect the 
test result.

I will send out a v3 patch to fix that.

Thanks,
Longman

