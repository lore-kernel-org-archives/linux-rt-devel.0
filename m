Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA263D6674
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642590; cv=none; b=JiLV9Tf1zR+tEQoPmI5MsdJ+COjowA1h4vzhFbRt6qQd0o2xPLZwbOf5+a6oZCgkrfWmZzARNrOopdWBHz+zhr4SIi+TJ07dy/ZEpbY/WuyhJ1d/RSar0HptMA9xN32ffbVAPn/vtQ2Dwf7kXC4JYbSg28rt1WJ9mx3mJ+uYRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642590; c=relaxed/simple;
	bh=ZDvo2JB+1+eOw28zDMz66JG84t71fIwb6lfT3Y+53hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mC/6doD1N8PL1f/n+ai/+FQg4fE307uS9eUmUESlSb4ARj6/CjDRuacNPMP4ZzJiTqm9Em0RtZeef7pONYvXnlnHM/337V0gPxuchqDNEtYnblcRItU89/X3CmLKdR/vEV0lmQN86goaymrCXjr7La8b29krGqJpame3ZPUtnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCOFIPZU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCOFIPZU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso1059023f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 04 Jun 2026 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780642587; x=1781247387; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCTmNu4jgb4r7pFyMhscOVe9W8lUl5WIYLcG+5Yn3NU=;
        b=VCOFIPZUXpzLyRR8/VpZ54FKPs331zVo9+Wy7hdnnXV5AGZTz5GVPer895CSSpy7lY
         khbAQWdZjlj238lw3K0PHF6Is2pDMtOzhNGYyy5VEk2qtvCrhtewpM+ur2Hlgg3Qa5PM
         GfHNYwGXfdd3+7HMZzdrm8zIwqzSF9X1sdWgf3PXLyRwEPDUMV5xm015VRRaQ1fbKHjo
         UdnJmKcLfGUqpnU73wTGWthVdsRyDWkG691FcUzxy/yoODHja9n4cW4h9oDmq9h0bjag
         sxEK+oAYzUIOu2I1bERJ6B7VoLv6GkfQHxrC0GONPjHTdZ44VrME+BVutc1aysXERC7l
         XUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780642587; x=1781247387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCTmNu4jgb4r7pFyMhscOVe9W8lUl5WIYLcG+5Yn3NU=;
        b=g50tBUOnWciB9MhPVdQrOda+1ytCTtbkNULEBJuwXMPrSOAuKbSbE88CL+Df0osqSA
         1ErJLbnh97PB49ZfNUCh60vMm20tJzjot1UXrXC6hSg115gMrL/hgJZgS7GJ+6sZZOYw
         /PYXd03IsRNyoFU2/iscXh+MVDJ3EcjCoAtrAnokIWebLyrHDbqpSDbg+oX/ERSS4mQF
         tJFqgyLVVTn66T6gjzt99KE1QN/bYR4VYrwMM97pmtWYPMcW33uCNOz1NHf2QhyGKjzF
         4btl26jOeBZWodUib9DuUnXX6Nf9mNduRBBS5+bISCMNx988Uh7aq4t1QRhR8erQcGqd
         pZ+A==
X-Forwarded-Encrypted: i=1; AFNElJ+jtmkRKDp51+GYEaTVq9jQ7g/O1zMrNPkb0VBPlHE5kOzhzvc0NbYfvT2/7aM59iRuwz07A2FrE3wNdHAIfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze14UYtZ+2UmiNn7/Nrm5gYn/12kdzdunXMG2pEoG0NUmKqehE
	9KnGcv/TsBEy/RHTGM6Mp8MuaQHivBUaLq1KBBjqIs7yPLuzA24q1EaK
X-Gm-Gg: Acq92OGpspvoyvlT5iL4wmDEfrLrvkJFQZBEZ+brAh1JmmyLHnHjvKzHfoaCpqql0vw
	ccixTEW6VzIUTz0IQgeJls5rrMUad0ew+lyuV+I01ac1zQyQb3ekzFIdNRS8bo7wsQYJnqfTpTq
	MnahdhSoJLlAz1ROQcpKOawthB2TOqjJt9kzt6dV0WkMYEck7NZAeMfWrMb/6GCvNEVvGywBoAP
	A8/BRFwF/lt4ajKbVVqzIaHgMAuMMCVTatskTcvz42K/6JhaCUEKIz+NecN9zBMBhzwQMD5SHHl
	PKs2aIDO9Q+JZtX43HeZ6vlJpLUkuWIhpBs5ul6GLYkgC/pjaFfskjnHLOq0iQxOvYiP0eoCSrd
	pstb0LTYtT4rFg58tcd1nyGJFNit9AvFn7djG4a+3fPh8i+YPy9jXeJ9dXYCMCI2vHd4CD8Q4Xn
	bRjoo+aADiGN6HIE80tbdMPZhJaOTX2v8Chh/dln+lAVlnVGijevmB0Xr4lYkLBMEJOuVfjtTPB
	4jWV/bdcwAzWzSehnhZjLP0E9bcLvK3pw0h
X-Received: by 2002:adf:e006:0:20b0:441:1e8e:d8fd with SMTP id ffacd0b85a97d-46030658bc5mr2487297f8f.29.1780642586855;
        Thu, 04 Jun 2026 23:56:26 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f133:a901:840b:2bf2:919c:cec5? ([2001:9e8:f133:a901:840b:2bf2:919c:cec5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm22537060f8f.2.2026.06.04.23.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 23:56:26 -0700 (PDT)
Message-ID: <e009fc98-73b7-4d3a-9b0b-7b6d37570dc5@gmail.com>
Date: Fri, 5 Jun 2026 08:56:25 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
 <CAAhV-H6khmNSNLOpVzV2B9qmRVAZkY6w8nYVrJC6QBP5CrFd3w@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H6khmNSNLOpVzV2B9qmRVAZkY6w8nYVrJC6QBP5CrFd3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Huacai,

On 05.06.26 05:01, Huacai Chen wrote:
> Hi, Jonas,
>
> On Fri, Jun 5, 2026 at 2:25 AM Jonas Jelonek <jelonek.jonas@gmail.com> wrote:
>> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
>> marks the CPU offline for the scheduler via set_cpu_online(false) but
>> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
>> that are now spinning forever with interrupts disabled.
>>
>> As long as nothing waits for an RCU grace period after smp_send_stop()
>> this is harmless, which is why it went unnoticed. Since commit
>> 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
>> however, irq_work_sync() calls synchronize_rcu() on architectures without
>> an irq_work self-IPI, i.e. where arch_irq_work_has_interrupt() returns
>> false. That is the asm-generic default used by MIPS. Any irq_work_sync()
>> issued in the reboot/shutdown path after smp_send_stop() then blocks on
>> a grace period that can never complete, hanging the reboot:
>>
>>   WARNING: CPU: 0 PID: 15 at kernel/irq_work.c:144 irq_work_queue_on
>>   ...
>>   rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>   rcu: Offline CPU 1 blocking current GP.
>>   rcu: Offline CPU 2 blocking current GP.
>>   rcu: Offline CPU 3 blocking current GP.
>>
>> This issue popped up during kernel bump downstream in OpenWrt from
>> 6.18.33 to 6.18.34, since the suspected change has been backported to
>> 6.18 stable branch [1].
> Now 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single()
> on PREEMPT_RT") has been backported to as early as 6.1 LTS.

Yes, as also pointed out by Sebastian I should adjust this paragraph
to be more accurate.

>> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
>> generic CPU-hotplug offline path (and arm64's stop handling), so RCU stops
>> waiting on the parked CPUs and grace periods can still complete.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=18c0456ea2615b1a743a6db739c74411c3b42bc6
>>
>> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>>
>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>> index 4868e79f3b30..0f28b4a62e72 100644
>> --- a/arch/mips/kernel/smp.c
>> +++ b/arch/mips/kernel/smp.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/sched/mm.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/cpu.h>
>> +#include <linux/rcupdate.h>
>>  #include <linux/err.h>
>>  #include <linux/ftrace.h>
>>  #include <linux/irqdomain.h>
>> @@ -422,6 +423,7 @@ static void stop_this_cpu(void *dummy)
>>         set_cpu_online(smp_processor_id(), false);
>>         calculate_cpu_foreign_map();
>>         local_irq_disable();
>> +       rcutree_report_cpu_dead();
> I'm not sure but maybe it is better to before local_irq_disable()?

rcutree_report_cpu_dead() starts with lockdep_assert_irqs_disabled() so
it needs IRQs disabled already.

> Huacai
>>         while (1);
>>  }
>>
>> --
>> 2.51.0
>>
>>

Best,
Jonas
