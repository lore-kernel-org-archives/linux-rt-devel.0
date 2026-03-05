Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A228643D
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Mar 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709114; cv=none; b=Rp/UhEgIccAmZ9QvzHHSLsHWOgv5yaAViH9Po91ashA27HEDRyDwADyZJEZB6HgaK2xt5g6WwGDsuJoeUjA7oYZJXZ9MCcBP6Ecv46atImbYy3M2+RpBtqFymapUqzBDA2WteflYXdrYkhgRbdjDzmyc64puMtFzBsR/Gvhq2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709114; c=relaxed/simple;
	bh=wa7+Aea3F916j67zXQlWhpl7Fp1/xJSsF/OHIDAj0Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwgqLQ/JLzpppvBCDxPVbiAaJpdYhM6lfWvWpOa98EMqX8Lm6PK7ekPNHxdyBYxT214borDIqxkYhL719jy3Sc2xhydaA9KuAZzHQoNdvMXxSrvaKLTVcMBq8RguROVjPj0pqTkdJ8cRjmHhlo1IhGvyjYCC9jqUHbdNsUSho9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=UHq0f49b; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="UHq0f49b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1772709111;
	bh=wa7+Aea3F916j67zXQlWhpl7Fp1/xJSsF/OHIDAj0Dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UHq0f49bk9ezP9FF9aNJukLEIaLEyLz6H6ZRdRog+XQ5Zjhe+a++l2PQuB+O9ieLY
	 LdsN7/hsjrQrzgdwEBOjYbyIrG9YGOAuRRJnoHId5zIcRVL1akAWzcuhStyOfiktG6
	 EpGcqp1mFMVz26zYm7+a3gmwgJH+c19SlsziVioeup2eULWgAC9AmdxLF1I2Ica0ay
	 fxr9+gikXc9Telq++3PXzhC25gz5u99OA7UjfOiJSJle2R7k2+bzEz6UyNQtYenMRC
	 DYWRzLkMprgkcOYBXFTkbx1SAEY46jztPhUasGaE/D0w51QW7U9iALjrDHwQhgun30
	 D7Sor/HQn5XZQ==
Message-ID: <08ff34aa-acb2-4110-9dec-db6dde6edd5c@lankhorst.se>
Date: Thu, 5 Mar 2026 12:11:50 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [i915-rt v6 00/24] drm/i915/display: All patches to make
 PREEMPT_RT work on i915 + xe.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260224162703.Q_taYjEC@linutronix.de>
 <20260224165903.2mn24oQy@linutronix.de>
 <20260225075806.XNtXjZ5E@linutronix.de>
 <7ee8b784-a714-4329-aab2-a571f25c3baa@lankhorst.se>
 <20260226120715.6Ug1Qkse@linutronix.de>
 <20260226141942.Z6vUrEQ3@linutronix.de>
 <20260226143857.4ZJAFzf6@linutronix.de>
 <98af7aba-f86f-4ff0-a53b-60e0e9784e37@lankhorst.se>
 <20260305105022.cc1qAMoO@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260305105022.cc1qAMoO@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2026-03-05 kl. 11:50, skrev Sebastian Andrzej Siewior:
> On 2026-03-05 11:42:19 [+0100], Maarten Lankhorst wrote:
>> Hey,
> Hi,
> 
>> Den 2026-02-26 kl. 15:38, skrev Sebastian Andrzej Siewior:
>>> On 2026-02-26 15:19:42 [+0100], To Maarten Lankhorst wrote:
>>>> On 2026-02-26 13:07:18 [+0100], To Maarten Lankhorst wrote:
>>>>> series somewhere I could pull and check. In meantime I would look what
>>>>> causes the lockup on i915.
>>>>
>>>> I think I got it.
>>>
>>> This the atomic sync as-is, IRQ-Work (FIFO-1) will be preempted by the
>>> threaded-interrupt (FIFO-50) and the interrupt will poll on
>>> signaler_active while the irq-work can't make progress.
>>>
>>> This will provide the needed sync:
>>>
>>> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
>>> index a2b413982ce64..337f6e88faf05 100644
>>> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
>>> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
>>> @@ -209,6 +209,7 @@ static void signal_irq_work(struct irq_work *work)
>>>  		intel_breadcrumbs_disarm_irq(b);
>>>  
>>>  	rcu_read_lock();
>>> +	spin_lock(&b->signaler_active_sync);
>>>  	atomic_inc(&b->signaler_active);
>>>  	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
>>>  		struct i915_request *rq;
>>> @@ -246,6 +247,7 @@ static void signal_irq_work(struct irq_work *work)
>>>  		}
>>>  	}
>>>  	atomic_dec(&b->signaler_active);
>>> +	spin_unlock(&b->signaler_active_sync);
>>>  	rcu_read_unlock();
>>>  
>>>  	llist_for_each_safe(signal, sn, signal) {
>>> @@ -290,6 +292,7 @@ intel_breadcrumbs_create(struct intel_engine_cs *irq_engine)
>>>  	init_llist_head(&b->signaled_requests);
>>>  
>>>  	spin_lock_init(&b->irq_lock);
>>> +	spin_lock_init(&b->signaler_active_sync);
>>>  	init_irq_work(&b->irq_work, signal_irq_work);
>>>  
>>>  	b->irq_engine = irq_engine;
>>> @@ -487,8 +490,11 @@ void intel_context_remove_breadcrumbs(struct intel_context *ce,
>>>  	if (release)
>>>  		intel_context_put(ce);
>>>  
>>> -	while (atomic_read(&b->signaler_active))
>>> +	while (atomic_read(&b->signaler_active)) {
>>> +		spin_lock(&b->signaler_active_sync);
>>> +		spin_unlock(&b->signaler_active_sync);
>>>  		cpu_relax();
>>> +	}
>>>  }
>>>  
>>>  static void print_signals(struct intel_breadcrumbs *b, struct drm_printer *p)
>>> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h b/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
>>> index bdf09fd67b6e7..28dae32628aab 100644
>>> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
>>> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
>>> @@ -40,6 +40,7 @@ struct intel_breadcrumbs {
>>>  	struct list_head signalers;
>>>  	struct llist_head signaled_requests;
>>>  	atomic_t signaler_active;
>>> +	spinlock_t signaler_active_sync;
>>>  
>>>  	spinlock_t irq_lock; /* protects the interrupt from hardirq context */
>>>  	struct irq_work irq_work; /* for use from inside irq_lock */
>>>
>>
>> Thinking some more, replacing signaler_active with signaler_active_sync might be the best fix.
>> I'm not sure there's much use for parallel completion of the same breadcrumb, and using completion
>> might be too heavy handed.
> 
> We have something similar in timer, tasklet and other "similar" code
> where on RT you have preemption and therefore the possibility of another
> user on the same CPU while on !RT it is only possible on a remote CPU.
> Using the spinlock_t for synchronisation would restrict to one-on-one.
> The closest API that comes to mind would be a sequence lock. One writer,
> multiple reader. So that would be an option that you might like ;) If
> the pure spinlock_t is off the table.

I think it should be possible then to remove signaler_active, and change
the reader side to if (spin_is_locked()) { spin_lock(); spin_unlock(); } ?
