Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC03283C87
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679901; cv=none; b=d5PqeDdWTNsDNmrhoiyKlSS9AAhfkgH9EeuZgv08z27bHexZDNT0IopnweheTv6A9rkew94HjfyllRIS6r2eULp0zUOlDhbEJP7gQKtseiQx7ilGE4wz9hHlRVV47hsA7OxHC9vFC/9vKhUTbANN7fbW7HQ4Ol/B5D8J4Y0+D0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679901; c=relaxed/simple;
	bh=O3RQ+OLu3sKR3qH4v5ECSihvluWb5n/3NqvLKtMGYi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxCN1FCCBLwjOJWrR8ixxmBdaCOXjwZX/b0ztTpTxPW4Em/2hs3u4tp8a1j8GHf/w3z2LcVu0iEo7LOuttZ/5+P9qFOe4H0gIHrkMowwlVfpcq43Gux3aJTkcLOa5cN7JSJpCBlLuuQGFuacTT2a0eNEYd5OnAUX6+0xWGqVXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beKELJu5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beKELJu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780679899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZFJgaGSPZ85nAai8ura62PQcmITN13W/WYFfpUcB20=;
	b=beKELJu52rNIlkbHSSYr98uVqEMWW6ECna2PjyuS4/DfGc3x/+3Flxh5jVkNaPENbKzHbI
	84Z7NURnDUhOpMM3/Tv0Z9bExycE0JIdHPeQce0YSHktUfg/9EDD//eRguy5ypKB54Kp7P
	0HUZBFkY1hAItuO4XGnB83AVCCbpQ1Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-RhCywwyQNYyMB-R_4nnpRA-1; Fri,
 05 Jun 2026 13:18:11 -0400
X-MC-Unique: RhCywwyQNYyMB-R_4nnpRA-1
X-Mimecast-MFC-AGG-ID: RhCywwyQNYyMB-R_4nnpRA_1780679890
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE4BF180034B;
	Fri,  5 Jun 2026 17:18:09 +0000 (UTC)
Received: from [10.22.88.138] (unknown [10.22.88.138])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C38227A;
	Fri,  5 Jun 2026 17:18:07 +0000 (UTC)
Message-ID: <70e3c4e4-7a20-413c-be2b-75f1b18edc54@redhat.com>
Date: Fri, 5 Jun 2026 13:18:07 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] debugobjects: Don't call fill_pool() in early boot
 hardirq context
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260603195250.362595-1-longman@redhat.com>
 <20260605063115.ff4VR-pH@linutronix.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260605063115.ff4VR-pH@linutronix.de>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: Qmn8FFbjjsvaKIosaeds0mEpHDGM61jvUZNZ0kpRdqk_1780679890
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/5/26 2:31 AM, Sebastian Andrzej Siewior wrote:
> On 2026-06-03 15:52:50 [-0400], Waiman Long wrote:
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
> I would strip that backtrace since it is obvious from the description
> below.

Sure. I can do that.

>
>> During early boot, interrupts are getting enabled before the scheduler
>> is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
>> can fire and attempt to fill the pool from within the hardirq. This can
>> lead to a deadlock the interrupt occurred while in the memory allocator.
>>
>> Add a new can_fill_pool() helper and reorder the exception rule and
>> forbid this scenario by excluding allocations from hardirq.
>>
>> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
>> Co-developed-by: Waiman Long <longman@redhat.com>
>> Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Thanks,
Longman
>
> Sebastian
>

