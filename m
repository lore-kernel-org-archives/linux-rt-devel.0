Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8812193073
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751312; cv=none; b=NvEK8F6qd3S3UWBLvIzO2+7q5r0Orij5XmgfXE45l/km/5tMDRDtvRDThpFD61BzBUi5u6g11wgVTPj0FijoCWRxe96tK7wcGyMH4azy0CE1eQzmqD6z3ueQReDXgSUYVLyrbxa/H+1bdGoN3IDhtBlTSLndNJrWQkc47gbO7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751312; c=relaxed/simple;
	bh=cdGFXcsehHzjccMA0addH9qHb6t8Bq8DG7VzEUYUbzk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wr0GJi8lcoIb4+t/KlehUj+Mrfl/qYsJIhZUzWVE6pjcoNC3f65UOka3kLckBgTgh+2RpFWM9NPYRyCZAHzAcL/TGn+sWRcwv15fJuuSFOw+0H4FfMUcuK/E1QAt4Eig4pyDLTns9vC8deM7bnqqbfvbQ/i/rfAkDYvBeRBivTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpAYu+7l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpAYu+7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737751309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z06IwRsUK7sR4WjL2LvTrEnN/ElRx2oGu5/nibKY9WI=;
	b=BpAYu+7lGR/XjpLrmBOTT0iXUxFryUFNvBXyaQJDUfITFhXlRksSJK/1cW8E4pyEn9UgI1
	kR/sC4ULCwHR7EdfhX1Dh2fNVazmv5FTByRAr6+yqgThiJYGVMslU5i1JIPH4jBT251E3a
	b+BilZkQHQV/wa76F2h2VCNUNwYSCis=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ebaK35v8MjeqAPcL_AZhpQ-1; Fri, 24 Jan 2025 15:41:47 -0500
X-MC-Unique: ebaK35v8MjeqAPcL_AZhpQ-1
X-Mimecast-MFC-AGG-ID: ebaK35v8MjeqAPcL_AZhpQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46790c5b1a5so62195591cf.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 12:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737751307; x=1738356107;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z06IwRsUK7sR4WjL2LvTrEnN/ElRx2oGu5/nibKY9WI=;
        b=LYazktOZvSk4cEFzN5TglzM23yRHSkxxhjNDTxdgp5CY4X1l4MQkMuN4Bsyx7J4NC7
         xP9HyVnJYSFg6nGosaviP+n4gX7PrNjP11gLjeifSu9Jz8tkytvxO6i93h5bSG/ufl6A
         vpvDxH+hf5cCf0SwR+q8xNCj3NBKRm/p8k7lyOg6ak0ldFLi++nZrSJuBGwXbrA17zXv
         VRhsef15YNQ6jO9oIMg08CNNJszrVtWISG6M/Wa+v8dddEfpA4YA+gCPxACVlNgfELiD
         /YzP4GLAQOl52xoSRtzUCRQEzdr4r4G1SDoKlumaH/DE08me8hcYyHa660GqBiXMpdb1
         d9rw==
X-Forwarded-Encrypted: i=1; AJvYcCXwUVK0GfvGrDD5S+CQ5a+bZEyfo3VX9UnlXpxDvovSoq4OOte4TP42GMasA271LTXoGy3JO19QsPlTv1T6tA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznv6CTpnOHG8odG8NtJRKTbwxzl2XWzulRij1FoJEOjYmHuau0
	g0u7Fby8gZ2mzend5wKL47HIGS0K1Wt57ZiaWWpkmfVvNn+ImFqOl2IHPULXJ+qRyURAEPrn1Fc
	0fVtHZCX2NXAzqFS+p6nONuYOn0DWWAbfXlyMOlXAs/MV478gYiUcrVG0Jq59DBLX
X-Gm-Gg: ASbGncurUGQuoFk1RdZMEfkfunEsgX9on6R6Bm6DPhSsiZ3IkmdLSSlriTPfCBFS6WK
	eYaxpIiGSDsrnY105dlDmGmkbWzVpC4Rs+Tgeem5IQVhuQEdkrNGZThMEs5hexQFS3EmN2I718l
	7+yJCgdlz5QiJomorSSZgUkyxaoH5MV+CwBl0BTRN9IpIGi+hH0MXo9bhcjmej8FLImSrn07mYx
	QsP8gHQsryp/x934SfXLH4wIAaX7EQm++yySFS5hVcA4qyq4+kBkiONzErcar/zQon2Ht5rp8pI
	ljQ1kMyCHJJuRQHGsFCn++/i3UH8ye+WDBOq7M3A
X-Received: by 2002:ac8:5753:0:b0:467:5926:fce8 with SMTP id d75a77b69052e-46e12a2c49fmr357524541cf.9.1737751307173;
        Fri, 24 Jan 2025 12:41:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ9H3z92UfAxjZzKeIrLn3vB87WeMWbf3eunuDpEgOe+BYKFxFhOw5HvqNI6y4Ac/30fUvTA==
X-Received: by 2002:ac8:5753:0:b0:467:5926:fce8 with SMTP id d75a77b69052e-46e12a2c49fmr357524261cf.9.1737751306809;
        Fri, 24 Jan 2025 12:41:46 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66b676b7sm13421501cf.61.2025.01.24.12.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 12:41:46 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <33340159-3bee-48cc-85a0-830305e736aa@redhat.com>
Date: Fri, 24 Jan 2025 15:41:45 -0500
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
 <ba435a6c-ace6-4e14-bda1-5289cde23176@paulmck-laptop>
In-Reply-To: <ba435a6c-ace6-4e14-bda1-5289cde23176@paulmck-laptop>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iWjoYzTVBi2_VBj5wVlUSToTBCfzLqsVitKq-0sBi4U_1737751307
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/25 3:37 PM, Paul E. McKenney wrote:
> On Fri, Jan 24, 2025 at 12:25:19PM -0800, Paul E. McKenney wrote:
>> On Fri, Jan 24, 2025 at 01:59:23PM -0500, Waiman Long wrote:
>>> The following bug report happened in a PREEMPT_RT kernel.
>>>
>>> [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>> [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
>>> [   30.962673] preempt_count: 1, expected: 0
>>> [   30.962676] RCU nest depth: 0, expected: 0
>>> [   30.962680] 3 locks held by kwatchdog/2012:
>>> [   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
>>> [   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
>>> [   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
>>> [   30.977827] Preemption disabled at:
>>> [   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
>>> [   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
>>> [   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
>>> [   30.982846] Call Trace:
>>> [   30.982850]  <TASK>
>>> [   30.983821]  dump_stack_lvl+0x57/0x81
>>> [   30.983821]  __might_resched.cold+0xf4/0x12f
>>> [   30.983824]  rt_spin_lock+0x4c/0x100
>>> [   30.988833]  get_random_u32+0x4f/0x110
>>> [   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
>>> [   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
>>> [   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
>>> [   30.993898]  clocksource_watchdog_kthread+0x18/0x50
>>> [   30.993898]  kthread+0x114/0x140
>>> [   30.993898]  ret_from_fork+0x2c/0x50
>>> [   31.002864]  </TASK>
>>>
>>> It is due to the fact that get_random_u32() is called in
>>> clocksource_verify_choose_cpus() with preemption disabled.
>>> If crng_ready() is true by the time get_random_u32() is called, The
>>> batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
>>> it is a rtmutex and we can't acquire it with preemption disabled.
>>>
>>> To avoid this problem, we can't call get_random_u32() with preemption
>>> disabled. However, smp_processor_id() has to be called with preemption
>>> disabled though and we have to exclude the current CPU from the
>>> cpus_chosen list to be tested.
>>>
>>> Extract current CPU removal code out from
>>> clocksource_verify_choose_cpus() and defer the preempt_disable()
>>> call to after clocksource_verify_choose_cpus() and before
>>> current CPU removal. Also use raw_smp_processor_id() in
>>> clocksource_verify_choose_cpus().
>>>
>>> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Good catch!
>>
>> But we don't need cryptographically secure random numbers (or blistering
>> speed) here.  Substituting something like torture_random()%nr_cpu_ids
>> for get_random_u32_below() work?
> I suppose I should add my concern...  If we don't have preemption disabled
> across this code, we cannot reliably avoid attempting to IPI ourselves.

Does the CPU choosing process itsself needs to have preemption disabled? 
I thought it was because of need to use smp_processor_id() and have the 
current CPU excluded. Preemption is still disabled after that.

Cheers,
Longman

