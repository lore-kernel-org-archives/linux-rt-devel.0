Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD233DEFE6
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456519; cv=none; b=q8cGqhnEYOFh3ZkiGkRuQj3QgQb7Sp49zwooP86+IbCQfvQVRV62KjD13wOyDQVBPtbDgGxhPAH3+ZMQFvYroHskiox4RLV6PwqNkjf+q5yVS0Rya6ygdi0z0+iWaXgWb8hitho6fF6w97L03iHOxV1GILGFMirAKin/c3jzFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456519; c=relaxed/simple;
	bh=nzVqXk7SzvCXJefGrS0gLfYGum2f4xT5KIsm5j5kx9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVO2noZWgkHX2JePzwOLLdl0dXXMH7SVUFQXObJFEZotyzsy/Agkg7MIgcR3Je1DQaIUPRAAFLrhcEO5GhWo6sh1O+Y5xULXb3rVseXfYuVvtPhab/Ci5nixOozPhMUFEpPYGJwd/EytXaNqjWNS3a0L+ed55+WQISlgig7wnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N9h/kV2U; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N9h/kV2U"
Message-ID: <5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774456513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnhM0wid1WsEL3SfiHuRpVP6AUKFQCaDXaNL0hOBE30=;
	b=N9h/kV2U5tBEFPvuzzM1JxnDmbcPBc5diS0tQl6utOP+x9zC+lJSOVGptsgjnDVCZmiJuW
	mTOGT5FDyKz4JxJmIc3pcxsNORxTZnxapRqoUQ94wWQEg6kcaGSGi54pvWZ4u3+qcuMNlf
	fTtdiNI6MjOcNWA+8ZWvEJNZYXEhId4=
Date: Thu, 26 Mar 2026 00:34:58 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260325155504.tm4zHWMI@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/25/26 11:55 PM, Sebastian Andrzej Siewior wrote:
> On 2026-03-25 11:53:15 [-0400], Steven Rostedt wrote:
>> On Wed, 25 Mar 2026 16:38:26 +0100
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>
>>> Most irq-work aren't free()ed since they are static and remain around.
>>> There is no task assigned if there is no active waiter.
>>> Wouldn't it be easier to kfree_rcu() the struct using the irq-work?
>> I guess we should add some kind of helper then. Like tracepoints have.
>>
>>     tracepoint_synchronize_unregister()
>>
>> Perhaps have a:
>>
>>     irq_work_synchronize_free();
>>
>> Or something like that to let developers know that they just can't safely free a
>> structure that contains an irq_work?
> That sounds great.
>
>> -- Steve
> Sebastian


Hi Steve, Sebastian,

Thanks for the review!

I came across this issue while working on the BPF side. In bpf_ringbuf,
the irq_work is embedded in struct bpf_ringbuf which is vmap'd — after
irq_work_sync(), the whole region is vunmap'd immediately 
(bpf_ringbuf_free).

Looking further, this pattern is actually widespread. Several other
subsystems embed irq_work in a dynamically allocated container and free
it right after irq_work_sync():

   - kernel/trace/ring_buffer.c:
   rb_free_cpu_buffer() syncs then kfree(cpu_buffer)
   ring_buffer_free() syncs then kfree(buffer)
   - drivers/gpu/drm/i915/gt/intel_breadcrumbs.c:
   intel_breadcrumbs_free() syncs then kfree(b)
   - kernel/sched/ext.c:
   scx_sched_free_rcu_work() syncs then kfree(sch)
   - kernel/irq/irq_sim.c:
   irq_domain_remove_sim() syncs then kfree(work_ctx)
   - drivers/iio/trigger/iio-trig-sysfs.c:
   iio_sysfs_trigger_destroy() syncs then kfree(t)
   - drivers/edac/igen6_edac.c:
   igen6_remove() syncs then kfree()


I agree that open-coding rcuwait internals is not ideal. I'd like to
check my understanding of the direction you're suggesting — would
something like the following be on the right track?

In irq_work_single(), just wrap the post-callback section with
rcu_read_lock to keep the work structure alive through an RCU grace
period:

'''
   lockdep_irq_work_enter(flags);
   work->func(work);
   lockdep_irq_work_exit(flags);

+   rcu_read_lock();

   (void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);

   if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
       !arch_irq_work_has_interrupt())
           rcuwait_wake_up(&work->irqwait);

+   rcu_read_unlock();
'''

Then provide a helper for callers that need to free:

void irq_work_synchronize_free(struct irq_work *work)
{
   irq_work_sync(work);
   synchronize_rcu();
}


Callers that free the containing structure would switch to
irq_work_synchronize_free(), or use kfree_rcu() if appropriate

Thanks,
Jiayuan





