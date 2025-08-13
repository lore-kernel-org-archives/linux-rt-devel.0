Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152C2DCF5F
	for <linux-rt-devel@lists.linux.dev>; Wed, 13 Aug 2025 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070952; cv=none; b=EftZyNdsVf82J3Hcl8LAvflhe3O81gTk4MCVRzoftEbylIUhxjiarPgIKFYvx2OyyMU8hynxyVCxPGcaWjI/y3jj6CCt7dyEf0PSA3dNALTrMf6Z1+NATfYSplrBuqBHf2WbgVoKH0dkYskGRVl5N/1KfXDCA0+si/rwt5a3OPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070952; c=relaxed/simple;
	bh=HdN0XMRFktS6aaDUEEo85Pl2LmbyxkiHp3apivFUIDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhWxvz4LezqAWIR0hIzfJUDDm9r9YYkCDPV+/QbJoMdPC6tbzusm2YGGVtlROfoPC2LQ0ZhqW2PqlZN0jJxULft5x6UVJ9naGrRshUcoWFe8iMFEvAmmeku7GOJUaLBUxWvBsqrVPpRP0zfVPus6bK26PKNpG4kJj/IgnswaLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-321d4484aa9so43369a91.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 13 Aug 2025 00:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070950; x=1755675750;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpiYdySHhrFSLFvt+ZXWlE3IvVelgPZB7slyigr8p3I=;
        b=jjkdQvBNxoDSWgxfqEwK6rpwIvnnhHRzi6ltjb9L46fcMVGup3fu9k7M6IYUr7ukd1
         oUQMJxVuAplexWsqq/HdwF5ojPxmoBgA3UAdSkQwIRVwL6p0hkRcyzaH2fz6uSSCPCXd
         UtqM0QfiVI+oXZYiAQBhh8fAkqpKZhp2u/w/A5Zn5twwKcX1WYBOIyOoofZHuw1aTSoc
         +Jrl8UdU5zsyU51DuHC+yoMSNH+rH5qRQzEW0cf2/YS9hmfkKeHO+6z23K5DKVlBbNzd
         CWOtc/vW4G5pJJnPDXKnFWapZwBiwZQrvmV88QHAnevhYzI3io5u13ob5NIKP4xcB46W
         LMLA==
X-Forwarded-Encrypted: i=1; AJvYcCXVxZUoAMhgVrVf/VgjwhLkCM4c0syofYpbzXGVw5oiuqXyVULEsn1kCUJ6Mtlw6hinI5Idejxqc67W36xuIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6/l9dU5OfOfTUjHE0ju+8+HIzW+BWJasDnR39R1iI7+5XL76N
	Y9PBk+go6/ZzBKz55pJOdGuWIx833JMdd+txQNmZZ3cqktMOxoAH6Yg3
X-Gm-Gg: ASbGnctfT1L68jFTh81WdUG2madYVmYf/5j9/XL78gJNKS5dUpRBibqQrUs4YSGOmCj
	QVynbHd0lsf1Tx9OtdAQAMM5D0V21eJJD/A6vq/mgAl6rw4kxFCZCdmPcgvPo9U537atPft8YqV
	hu4J2pTN35l4tT/7V/nL5P5EoD8kEHmAWomPwLFAKR6YlTN5eWRghq0tIwf5Vm48pliPXkI1ktx
	eiHufGkGIQIGabpJtw2/YTGnbBHbGDRyjuqiZcUeo7eRgVw5PI3mdRSoQXnGl8ZKeXqkcUGlEbw
	y8+jleKC5IDUWf1aWpLc5EbqTDz5koUTo7UrS0lw0B2MtW3yf7or/u+WekwyyAbseCQWE76/qBJ
	RBzabALWYqSlW+fqTTB8tol5JDzU7tzdu
X-Google-Smtp-Source: AGHT+IFyRulOk2yEiytouE8c1ifGVIrW23F74ZO8AVJB/Bv0ruH/ZKMqF0l+0q/T60XygCbCXcCjWw==
X-Received: by 2002:a17:90b:224f:b0:31f:23f0:2df8 with SMTP id 98e67ed59e1d1-321d0ecb6aamr1294794a91.6.1755070950304;
        Wed, 13 Aug 2025 00:42:30 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b429920ab6dsm11951099a12.58.2025.08.13.00.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 00:42:29 -0700 (PDT)
Message-ID: <17f91b9a-0a3a-47e1-bdfb-06237ae5da55@kzalloc.com>
Date: Wed, 13 Aug 2025 16:42:24 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] arm64: Sleeping function called from invalid context in
 do_debug_exception on PREEMPT_RT
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Austin Kim <austindh.kim@gmail.com>,
 linux-rt-devel@lists.linux.dev, syzkaller@googlegroups.com,
 stable@vger.kernel.org
References: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
 <aJw3L7B7u5qAPOMz@e129823.arm.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <aJw3L7B7u5qAPOMz@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yeoreum,

Thank you for pointing it!

On 8/13/25 3:56 PM, Yeoreum Yun wrote:
> Hi Yunseong,
> 
>>
>> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> | in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 20466, name: syz.0.1689
>> | preempt_count: 1, expected: 0
>> | RCU nest depth: 0, expected: 0
>> | Preemption disabled at:
>> | [<ffff800080241600>] debug_exception_enter arch/arm64/mm/fault.c:978 [inline]
>> | [<ffff800080241600>] do_debug_exception+0x68/0x2fc arch/arm64/mm/fault.c:997
>> | CPU: 0 UID: 0 PID: 20466 Comm: syz.0.1689 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT
>> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
>> | Call trace:
>> |  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
>> |  __dump_stack+0x30/0x40 lib/dump_stack.c:94
>> |  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
>> |  dump_stack+0x1c/0x3c lib/dump_stack.c:129
>> |  __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
>> |  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>> |  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
>> |  spin_lock include/linux/spinlock_rt.h:44 [inline]
>> |  force_sig_info_to_task+0x6c/0x4a8 kernel/signal.c:1302
>> |  force_sig_fault_to_task kernel/signal.c:1699 [inline]
>> |  force_sig_fault+0xc4/0x110 kernel/signal.c:1704
>> |  arm64_force_sig_fault+0x6c/0x80 arch/arm64/kernel/traps.c:265
>> |  send_user_sigtrap arch/arm64/kernel/debug-monitors.c:237 [inline]
>> |  single_step_handler+0x1f4/0x36c arch/arm64/kernel/debug-monitors.c:257
>> |  do_debug_exception+0x154/0x2fc arch/arm64/mm/fault.c:1002
>> |  el0_dbg+0x44/0x120 arch/arm64/kernel/entry-common.c:756
>> |  el0t_64_sync_handler+0x3c/0x108 arch/arm64/kernel/entry-common.c:832
>> |  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600
>>
>>
>> It seems that commit eaff68b32861 ("arm64: entry: Add entry and exit functions
>> for debug exception") in 6.17-rc1, also present as 6fb44438a5e1 in mainline,
>> removed code that previously avoided sleeping context issues when handling
>> debug exceptions:
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/arch/arm64/mm/fault.c?id=eaff68b3286116d499a3d4e513a36d772faba587
> 
> No. Her patch commit 31575e11ecf7 (arm64: debug: split brk64 exception entry)
> solves your splat since el0_brk64() doesn't call debug_exception_enter()
> by spliting el0/el1 brk64 entry exception entry.
> 
> Formerly, el(0/1)_dbg() are handled in do_debug_exception() together
> and it calls debug_exception_enter() disabling preemption and this makes
> your splat while handling brk excepttion from el0.
> 

Do you think a fix is necessary if this issue also affects the LTS kernel
before 6.17-rc1? As far as I know, most production RT kernels are still
based on the existing LTS versions.

> 
> --
> Sincerely,
> Yeoreum Yun

Thank you,
Yunseong

