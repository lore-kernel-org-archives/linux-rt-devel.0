Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B28378D94
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Mar 2026 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492041; cv=none; b=PrmWtN7e1fhR3CH9nUrbY8Jr9tNY1YSbnXmUd7vbzCBaFWVzpxej6Tdm0ZGQqZCSzuC0a2yh6lYmdi4J9Fr0fugfw/ZhhL4aPFhZKRNI8GAWEXxgY7Url28bs2n7Qt2Gj9vCZxVkwf3ALKsE22WIWcOpD2f/X9hEnOaWWmG/CUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492041; c=relaxed/simple;
	bh=+a9H0Zb7iTRvIf3ZdeDogj9x0e7LDBgLVFV8ICLq6iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asNfR+LFdvzdPeCb6rdt6cagoMafObsTDSeuCzKbw4a3chX2AARpYR3tkyNCX9RPzdBqYh7hIUbGqd18e0bJO86DGAk/FhPFhqSTjEbQTWiZWCuB8v+Cw3UNtPG2myeMDqzyOu4FJWY+L6bWfVxfgcX2eJcusuO5VBbqa5qmN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPvupjyS; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPvupjyS"
Message-ID: <b4a90c71-f559-4a47-beea-1f915fe97321@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774492036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+a9H0Zb7iTRvIf3ZdeDogj9x0e7LDBgLVFV8ICLq6iw=;
	b=DPvupjyS+Dxdkft5Eeto1FLF4fqVBQGes8uiJhhLR3wXgHLOSmK0xD4mfPRNlgDs+5s8db
	0hImlXkCLaO5bV90XVQ896AvJjlz7Rgi+QTblNjx0FtH2S3cmBIBObFNQveVyTkJoU7fPa
	4aV0mRVfbwBNjVTEUvfu0wxtyVjVcEI=
Date: Thu, 26 Mar 2026 10:27:10 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
 <20260325111351.1d38a0bc@gandalf.local.home>
 <20260325153826.EbSqlX_n@linutronix.de>
 <20260325115315.052e34ac@gandalf.local.home>
 <20260325155504.tm4zHWMI@linutronix.de>
 <5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
 <20260325170539.MHkr49jU@linutronix.de>
 <20260325134433.7d46507d@gandalf.local.home>
 <20260325175150._IrYQldq@linutronix.de>
 <20260325135540.4d127635@gandalf.local.home>
 <20260325175915.YufD1Y8T@linutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260325175915.YufD1Y8T@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/26/26 1:59 AM, Sebastian Andrzej Siewior wrote:
> On 2026-03-25 13:55:40 [-0400], Steven Rostedt wrote:
>> On Wed, 25 Mar 2026 18:51:50 +0100
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>
>>>> Perhaps Jiayuan's idea is better as it will not require modifying current
>>>> callers and does fix the issue.
>>> Don't you need to replace irq_work_sync() with this new one?
>>>
>>>> But it would still need helper functions from RCU as I really do not think
>>>> it's a good idea to open code the rcuwait logic.
>>> Why is rcuwait a concern?
>> Oh, I was talking about how the patch open coded rcuwait (which we shouldn't do).
>>
>> Are you saying that if we stick a synchronize_rcu() in irq_work_sync() that
>> could work too?
> I was thinking about your helper doing synchronize_rcu().
> I haven't looked at irq_work_sync() but it would need solve the problem,
> too. There shouldn't be any user of irq_work_sync() which does not
> intend to free the object, why else should they wait, right? So it might
> be even simpler.
>
Combining your and Steven's suggestions, I think the simplest fix would be:

static void run_irq_workd(unsigned int cpu)
{
+   guard(rcu)();
     irq_work_run_list(this_cpu_ptr(&lazy_list));
}

void irq_work_sync(struct irq_work *work)
{
     lockdep_assert_irqs_enabled();
     might_sleep();

     if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
         !arch_irq_work_has_interrupt()) {
             rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
                                TASK_UNINTERRUPTIBLE);
   +             /*
   +              * Ensure run_irq_workd() / irq_work_single() is done
   +              * accessing @work before the caller can free it.
   +              */
   +             synchronize_rcu();
                 return;
     }

     while (irq_work_is_busy(work))
             cpu_relax();
}

