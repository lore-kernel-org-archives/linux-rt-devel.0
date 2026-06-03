Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297003AA1BB
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498806; cv=none; b=nl3el7jnpdwV56UxStegVWKE/d4dAzU2O5xPDve+sBV4GK8SQWtBbulbdhznAVhT7KVwIc0JyeEKgJ/+B0jLsapFNA6pwhVOpYIOLPtXs/b+ZT6xPAwtPuM1PxIEmhALQqbghrwkBzCUbc6ZMMlER3p+W+9wIdlvMoiS3ddOiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498806; c=relaxed/simple;
	bh=HF7Pw8t27pdFeee3aPhJ9RxmwKkFUQ+WakN3wn83alE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzxByxJ/CRg2QoXc6dvbV+RE1Dmd2PKk1p+HJGnhLkJbFYpUY/WMkTSmYI5az3Or2VyEMrgVAusXnS4ULgH918iYGCZOe3UQgNesE0hQSte1vf0JzriTGzAa3GxDN/Wa3njsSSaHhR4jy5lHK5aj74Ln9+q6W8EgyUgNgQvUIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eisa3Jdm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eisa3Jdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780498804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a4AQvzUbdFQoP8yXZeVD7mtb3CITE9LWbpgatSijxgE=;
	b=Eisa3Jdm7vvdJcObxDdtfTkovVibXDytwuvo5rDkTGY9el5caUWtDTf7KbpCI7zEZW1izG
	TfbmBRLADIItLgl+Latg4CuUy2RPSB2G36tmC6Jk0Nq+YWXlOqULLsckaoncF1sdHjihtQ
	CfBrybeiXQJD0IuRSs3tIfJ+TiKSFUM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-neE4Ee8nPhmgU4hhJKL0FQ-1; Wed,
 03 Jun 2026 10:59:58 -0400
X-MC-Unique: neE4Ee8nPhmgU4hhJKL0FQ-1
X-Mimecast-MFC-AGG-ID: neE4Ee8nPhmgU4hhJKL0FQ_1780498797
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 207ED180035C;
	Wed,  3 Jun 2026 14:59:57 +0000 (UTC)
Received: from [10.17.16.204] (unknown [10.17.16.204])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D41B9195E483;
	Wed,  3 Jun 2026 14:59:55 +0000 (UTC)
Message-ID: <b4b54ef3-5488-4577-9743-d6ce01f7405e@redhat.com>
Date: Wed, 3 Jun 2026 10:59:55 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-tip v3] debugobjects: Don't call fill_pool() in early boot
 non-task context
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260520201509.931905-1-longman@redhat.com>
 <20260603075656.S1aZM9PO@linutronix.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260603075656.S1aZM9PO@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: aNFiDne-Y2JtXHt4WTr5llv6PrYelj0N52k5d9544FE_1780498797
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/26 3:56 AM, Sebastian Andrzej Siewior wrote:
> On 2026-05-20 16:15:09 [-0400], Waiman Long wrote:
>> When booting a debug PREEMPT_RT kernel on an arm64 system with grace
>> processor, the following lockdep warning was reported during early boot.
>>
>>    ================================
>>    WARNING: inconsistent lock state
>>    7.1.0-rc4-test+ #1 Not tainted
>>    --------------------------------
>>    inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>>    swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>>    ffff0000803346a0 (&n->list_lock){?.+.}-{3:3}, at: get_from_partial_node+0x74/0xa0
>>      :
>>    Call trace:
>>      :
>>     rt_spin_lock+0xa0/0x400
>>     get_from_partial_node+0x74/0xa0
>>     ___slab_alloc+0x94/0x4f8
>>     kmem_cache_alloc_noprof+0x2d4/0x598
>>     kmem_alloc_batch+0x54/0x170
>>     fill_pool+0x12c/0x438
>>     debug_objects_fill_pool+0x58/0x60
>>     debug_object_activate+0xfc/0x3d0
>>     add_timer_on+0x250/0x3a0
>>     add_interrupt_randomness+0x2d4/0x340
>>     handle_percpu_devid_irq+0x2e0/0x4e0
>>     handle_irq_desc+0xc0/0x120
>>     generic_handle_domain_irq+0x20/0x40
>>     __gic_handle_irq_from_irqson.isra.0+0x3c4/0x708
>>     gic_handle_irq+0x7c/0xe0
>>     call_on_irq_stack+0x30/0x48
>>     do_interrupt_handler+0x134/0x158
>>     el1_interrupt+0x48/0xb0
>>      :
> What about:
>
>    During early boot, interrupts are getting enabled before the scheduler
>    is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
>    can fire and attempt to fill the pool from within the hardirq. This can
>    lead to a deadlock the interrupt occurred while in the memory allocator.
>    
>    Reorder the exception rule and forbid this scenario by excluding
>    allocations from hardirq.
Yes, the debug_objects_is_pi_blocked_on() check should cover the 
system_state check as well.
>
> …
>> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
> …
>>   	/*
>>   	 * On RT enabled kernels the pool refill must happen in preemptible
>> -	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
>> -	 * on the fact that spinlock_t and raw_spinlock_t are basically the
>> -	 * same type and this lock-type inversion works just fine.
>> +	 * context and not enqueued on an rt_mutex or in task context during
>> +	 * early boot before scheduling starts.
>> +	 *
>> +	 * For !RT kernels we rely on the fact that spinlock_t and
>> +	 * raw_spinlock_t are basically the same type and this lock-type
>> +	 * inversion works just fine.
>>   	 */
>> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
>> +	    (system_state < SYSTEM_SCHEDULING && in_task()) ||
>>   	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
>>   		/*
>>   		 * Annotate away the spinlock_t inside raw_spinlock_t warning
> I updated the comment to explain in more verbose why this and that is
> done.
> I re-ordered the whole thing stared with the pi-locked-on part since
> this is always valid. It shouldn't happen during early boot I think it
> is easier to read that way. Then we restrict it to the preeptible case
> which can be overruled with the SYSTEM_SCHEDULING exception however as
> long as it is not an hardirq. It looks easier to parse and hopefully
> brings an end to this.
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index b18a682fe3da2..2adfe2a79a086 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -736,12 +736,17 @@ static void debug_objects_fill_pool(void)
>   
>   	/*
>   	 * On RT enabled kernels the pool refill must happen in preemptible
> -	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
> -	 * on the fact that spinlock_t and raw_spinlock_t are basically the
> -	 * same type and this lock-type inversion works just fine.
> +	 * context and not while blocking on a lock which can trigger recursion
> +	 * during PI. During system boot (before scheduling) preemption is
> +	 * disabled and the pool gets exhausted. Without scheduling a deadlock
> +	 * is not possible if allocations from interrupt context are excluded.
> +	 * For !RT kernels we rely on the fact that spinlock_t and
> +	 * raw_spinlock_t are basically the same type and this lock-type
> +	 * inversion works just fine.
>   	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
> -	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> +	    !debug_objects_is_pi_blocked_on() &&
> +	    (preemptible() || (system_state < SYSTEM_SCHEDULING && !in_hardirq()))) {
>   		/*
>   		 * Annotate away the spinlock_t inside raw_spinlock_t warning
>   		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching

I guess softirq won't be active during early boot. If in_nmi() is true, 
we are screwed for non-RT kernel as well. So only checking for 
in_hardirq() should be fine. I will adopt your suggestion and send a new 
version.

Thanks,
Longman

> Sebastian
>

