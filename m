Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9923D813D
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453610; cv=none; b=VfjbTjgm7f5D0vIGr8CSO7Ahd+ORs9W7U3kyloOAsCz4ndEjtnLNn2C6NK3J2EC6GlbSVF3Sp3gRCRL5X/pZsCwi/eb5NuKNV2/BWtaeiOPH+gOjDX5pwx/q0wDuQ52UepVzPoI1+ilY8oGp3JNmMFr5+tVHdg48GDyESUIZ8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453610; c=relaxed/simple;
	bh=roOdp5+9RfOaV19N9xbhXpUnI7r9yJMybkmJKkwon48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPaUYAzHQCUVSRLhTjAyYJWAkpnA/+IF6lTxbMM7uuimva3iBv34FGmIrE3Gmm+m6yhYa6WTCMal6K4LP6xVl/oPjXycHNP2hJSXxZUjtZXmvlky4imJJVJTdE1q7hIgIKc+fTgfSDT5jQMGlpMixl9FrZFcL9wAMEJUK823V5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAxuHaWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAxuHaWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780453607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rOR5km6YfCyj0nbyeMEcSDOCyb8+wIiQ+mebWMKZbc=;
	b=bAxuHaWG/OmNpXWENEz2WKEaMSu4fAM6UG25q1sRDPO1ZpdFvS0Tso5zNgm9cH9Ml/MNki
	ucrZKKOsUkwhhmM3Fpuk1CNxXr7Q1bPRszYcPm0G2XaIzx3aHEDKrhW8+6nCFhuIjoUKOo
	HF8VoTTmJqzubfdZwZNe6dXwXPs6hcM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-zKNFk-BkNSqRQDG8FyhqDA-1; Tue,
 02 Jun 2026 22:26:46 -0400
X-MC-Unique: zKNFk-BkNSqRQDG8FyhqDA-1
X-Mimecast-MFC-AGG-ID: zKNFk-BkNSqRQDG8FyhqDA_1780453605
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83B13195608B;
	Wed,  3 Jun 2026 02:26:44 +0000 (UTC)
Received: from [10.22.80.32] (unknown [10.22.80.32])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EB321681;
	Wed,  3 Jun 2026 02:26:42 +0000 (UTC)
Message-ID: <19e9e41f-8590-427e-94ee-50911ccdc962@redhat.com>
Date: Tue, 2 Jun 2026 22:26:42 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-tip v3] debugobjects: Don't call fill_pool() in early boot
 non-task context
To: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260520201509.931905-1-longman@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260520201509.931905-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: L2SCnn-acOBzPECG692ENPWpaNyN51eg2fzAAv0VMHo_1780453605
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/26 4:15 PM, Waiman Long wrote:
> When booting a debug PREEMPT_RT kernel on an arm64 system with grace
> processor, the following lockdep warning was reported during early boot.
>
>    ================================
>    WARNING: inconsistent lock state
>    7.1.0-rc4-test+ #1 Not tainted
>    --------------------------------
>    inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>    swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>    ffff0000803346a0 (&n->list_lock){?.+.}-{3:3}, at: get_from_partial_node+0x74/0xa0
>      :
>    Call trace:
>      :
>     rt_spin_lock+0xa0/0x400
>     get_from_partial_node+0x74/0xa0
>     ___slab_alloc+0x94/0x4f8
>     kmem_cache_alloc_noprof+0x2d4/0x598
>     kmem_alloc_batch+0x54/0x170
>     fill_pool+0x12c/0x438
>     debug_objects_fill_pool+0x58/0x60
>     debug_object_activate+0xfc/0x3d0
>     add_timer_on+0x250/0x3a0
>     add_interrupt_randomness+0x2d4/0x340
>     handle_percpu_devid_irq+0x2e0/0x4e0
>     handle_irq_desc+0xc0/0x120
>     generic_handle_domain_irq+0x20/0x40
>     __gic_handle_irq_from_irqson.isra.0+0x3c4/0x708
>     gic_handle_irq+0x7c/0xe0
>     call_on_irq_stack+0x30/0x48
>     do_interrupt_handler+0x134/0x158
>     el1_interrupt+0x48/0xb0
>      :
>
> The {IN-HARDIRQ-W} usage happens when debug_objects_fill_pool() calls
> fill_pool() in the hardirq context during early boot. It is caused by the
> "system_state < SYSTEM_SCHEDULING" check in debug_objects_fill_pool()
> which allows fill_pool() to be called from any context during early
> boot before scheduling is enabled.
>
> Calling fill_pool() from any context is problematic as deadlock can
> happen even though the early boot window should be pretty short. Fix
> that by restricting the fill_pool() call to only in_task() context
> during early boot.
>
> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   lib/debugobjects.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
>   [v3] Rebased on top of tip/urgent/core & trim call trace.
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 772ddabcbe7d..76bfc2571591 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -736,11 +736,15 @@ static void debug_objects_fill_pool(void)
>   
>   	/*
>   	 * On RT enabled kernels the pool refill must happen in preemptible
> -	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
> -	 * on the fact that spinlock_t and raw_spinlock_t are basically the
> -	 * same type and this lock-type inversion works just fine.
> +	 * context and not enqueued on an rt_mutex or in task context during
> +	 * early boot before scheduling starts.
> +	 *
> +	 * For !RT kernels we rely on the fact that spinlock_t and
> +	 * raw_spinlock_t are basically the same type and this lock-type
> +	 * inversion works just fine.
>   	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> +	    (system_state < SYSTEM_SCHEDULING && in_task()) ||
>   	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
>   		/*
>   		 * Annotate away the spinlock_t inside raw_spinlock_t warning

Ping. Any comment on this patch?

Cheers,
Longman

