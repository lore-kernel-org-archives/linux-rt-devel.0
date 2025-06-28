Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E343B1AB
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Jun 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751137572; cv=none; b=lY5ji1ZAjUUet6km3/pZY7OPwhBgoxagM1QZv5R/220Nsc/ijn9Y0AGFJ7I9SVU0NTB8UtqS4ljcEdSxhw7D8l0xd0SEZue6vXdghcCQsTt2AmjGG+n3UvnVd6ZM4jLJXtw4+A2sAA1KJlFMNB01I8/o26hMlIHQXDGNbqITCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751137572; c=relaxed/simple;
	bh=8OfSFi2gveGtLJ5i712Fpbg8nVpbBqORffS4vCgLvNI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bGs9VzSxMbKQu3XvZTZPBPfeq+HfbDjP4TVGgNGpbi77YfOrUT6IdeS1ZrhrE9wGGAoOq7kfrCntDBe3pLVZw60NruexELTRF4PRgpvzn8OcBodlyViS1/6pPlVZF/uBO5GAawq5jjTjhCpZ27HOCzLBRZZi5GuaB9MLFxGfpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxsLALx9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxsLALx9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751137568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loOy29L9wjaHhM0YPQ+48N72XLeOxYKWvMsmgZtkh1s=;
	b=AxsLALx9OL/OVLl3Wk+hItvbBqnAw8OM3qBHikErZ45Dh3tGUH8wtlzNS+WuGRQ1BP81MS
	yemnIDjNnOFasWJegqIbRWN3gE4hQhefx/oMwLOq6p7N4uz3R2XOgsah5EjM6vBm2x59Dc
	4RKOLAjnh2SDo85Qm8b0OYY/TAWtZdM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-sxAhxbI2OmqVMMIO6dXMmw-1; Sat, 28 Jun 2025 15:06:07 -0400
X-MC-Unique: sxAhxbI2OmqVMMIO6dXMmw-1
X-Mimecast-MFC-AGG-ID: sxAhxbI2OmqVMMIO6dXMmw_1751137567
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-72bc82106cbso2602132a34.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 28 Jun 2025 12:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751137567; x=1751742367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loOy29L9wjaHhM0YPQ+48N72XLeOxYKWvMsmgZtkh1s=;
        b=A2cS6puUkRfiQvT/YqNGsYv7lt4V6cc1lxmfeAHa3WETwLfIO50o5i8NwjNnW84cFb
         42jP1g7bG5K7KYEldWsjeYA6NOU4QztjBdRv3IEEWAfx4rCZF/qoy30ffBpHmENlFmdz
         mQ8geW7a+stAQsPZy4sgLEsFvwI5+XsyRKFVoh7ij+mDZuVAY251xCLiGiW/iNGEmiH7
         9+q3bZUt7Q8/zP9HFEx3iu/oFJaRkZ0H+mf7CJw9ziqEnbE5nb+MkRZMKmYGn4t2q7G2
         +wV1DA1L4zCuZNSIxs3U3LEMcEPC4YMmg7zrTGFb/W78/pMdY3opA4/axctiU167BOun
         Bl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDZ01feD7u5RKU3NCe5sQYi0tgnL6KGaS647TbeWriJslEmHseNf/zqtDJL3Iwwf7eA+7y3iqji28ZbTR7YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBiRZMC5HGmeoNHgmOc7I2Z3RuBuA2l99xQ9buVbseEKArJuje
	+DXosgZPKrFjsz39Vdv3I3b6PvQUi8wwCE/x51O7FzgSHuXjgAAJLk0kYB3yyjZfX5S6iYPLAWJ
	L2XULCGdXGS1Ar0h5S58XJiU/jMhDc/OAevYPFWLGvAVJY6v0hY5BIMQazEQevp5aq2VH
X-Gm-Gg: ASbGncs3qIWwChIwPIiqYgigcLbzmEZbnU9I6FNwLyxmavecl+oDSGGAZ5H1mWB7tyS
	W2MLjzeUh4BlK1uSBomESRTVMu0T8OzsDHgITW5eFu2w6MJV75jaEM9w1/PohoaA6tZDaty8VSV
	MCvoKGUY7N1iJepsjVf9kOd6kJLIzWpbT5Ibxq/rVzlB/C5pMNP+hFHOTN7ToJw06DN2+BkMloL
	OhCVVq2SAb2U5JnHwSfDWDbA3edxovh59sHHDuxM3YeJd8Ni0Lx+ye1I/fzY16spu/D1fA9oWDJ
	tUanqE4gA6zc4XhgRw5pz60Dd5jHG+ATERmsMlwrmQPAzQg8dUxDwyNq3Ujun3Dq9Pr1
X-Received: by 2002:a05:6830:2c05:b0:72b:9316:d596 with SMTP id 46e09a7af769-73afc53ba33mr4172704a34.3.1751137566708;
        Sat, 28 Jun 2025 12:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmyDnp2EnTjJD009vL2C/UcuyHNh0RiwQQWhELjuIcYwQb0wYZ41BaMSWdPX4bF4Qor7uSOQ==
X-Received: by 2002:a05:6830:2c05:b0:72b:9316:d596 with SMTP id 46e09a7af769-73afc53ba33mr4172687a34.3.1751137566252;
        Sat, 28 Jun 2025 12:06:06 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb0089cesm918076a34.25.2025.06.28.12.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 12:06:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9933aa75-9c7f-4ae3-b580-5c68a63615ba@redhat.com>
Date: Sat, 28 Jun 2025 15:06:03 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] local_lock: Move this_cpu_ptr() notation from
 internal to main header.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20250610110205.1111719-1-bigeasy@linutronix.de>
 <20250610110205.1111719-2-bigeasy@linutronix.de>
In-Reply-To: <20250610110205.1111719-2-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JyxWvr9ByLIMauLpEdPS8TV_DHYrWM95qQIiB92PQ-Y_1751137567
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 7:02 AM, Sebastian Andrzej Siewior wrote:
> The local_lock.h is the main entry for the local_lock_t type and
> provides wrappers around internal functions prefixed with __ in
> local_lock_internal.h.
>
> Move the this_cpu_ptr() dereference of the variable from the internal to
> the main header. Since it is all macro implemented, this_cpu_ptr() will
> still happen within the preempt/ IRQ disabled section.
> This will free the internal implementation (__) to be used on
> local_lock_t types which are local variables and must not be accessed
> via this_cpu_ptr().
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/local_lock.h          | 20 +++++++++----------
>   include/linux/local_lock_internal.h | 30 ++++++++++++++---------------
>   2 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 16a2ee4f8310b..2ba8464195244 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -13,13 +13,13 @@
>    * local_lock - Acquire a per CPU local lock
>    * @lock:	The lock variable
>    */
> -#define local_lock(lock)		__local_lock(lock)
> +#define local_lock(lock)		__local_lock(this_cpu_ptr(lock))
>   
>   /**
>    * local_lock_irq - Acquire a per CPU local lock and disable interrupts
>    * @lock:	The lock variable
>    */
> -#define local_lock_irq(lock)		__local_lock_irq(lock)
> +#define local_lock_irq(lock)		__local_lock_irq(this_cpu_ptr(lock))
>   
>   /**
>    * local_lock_irqsave - Acquire a per CPU local lock, save and disable
> @@ -28,19 +28,19 @@
>    * @flags:	Storage for interrupt flags
>    */
>   #define local_lock_irqsave(lock, flags)				\
> -	__local_lock_irqsave(lock, flags)
> +	__local_lock_irqsave(this_cpu_ptr(lock), flags)
>   
>   /**
>    * local_unlock - Release a per CPU local lock
>    * @lock:	The lock variable
>    */
> -#define local_unlock(lock)		__local_unlock(lock)
> +#define local_unlock(lock)		__local_unlock(this_cpu_ptr(lock))
>   
>   /**
>    * local_unlock_irq - Release a per CPU local lock and enable interrupts
>    * @lock:	The lock variable
>    */
> -#define local_unlock_irq(lock)		__local_unlock_irq(lock)
> +#define local_unlock_irq(lock)		__local_unlock_irq(this_cpu_ptr(lock))
>   
>   /**
>    * local_unlock_irqrestore - Release a per CPU local lock and restore
> @@ -49,7 +49,7 @@
>    * @flags:      Interrupt flags to restore
>    */
>   #define local_unlock_irqrestore(lock, flags)			\
> -	__local_unlock_irqrestore(lock, flags)
> +	__local_unlock_irqrestore(this_cpu_ptr(lock), flags)
>   
>   /**
>    * local_lock_init - Runtime initialize a lock instance
> @@ -64,7 +64,7 @@
>    * locking constrains it will _always_ fail to acquire the lock in NMI or
>    * HARDIRQ context on PREEMPT_RT.
>    */
> -#define local_trylock(lock)		__local_trylock(lock)
> +#define local_trylock(lock)		__local_trylock(this_cpu_ptr(lock))
>   
>   /**
>    * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
> @@ -77,7 +77,7 @@
>    * HARDIRQ context on PREEMPT_RT.
>    */
>   #define local_trylock_irqsave(lock, flags)			\
> -	__local_trylock_irqsave(lock, flags)
> +	__local_trylock_irqsave(this_cpu_ptr(lock), flags)
>   
>   DEFINE_GUARD(local_lock, local_lock_t __percpu*,
>   	     local_lock(_T),
> @@ -91,10 +91,10 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
>   		    unsigned long flags)
>   
>   #define local_lock_nested_bh(_lock)				\
> -	__local_lock_nested_bh(_lock)
> +	__local_lock_nested_bh(this_cpu_ptr(_lock))
>   
>   #define local_unlock_nested_bh(_lock)				\
> -	__local_unlock_nested_bh(_lock)
> +	__local_unlock_nested_bh(this_cpu_ptr(_lock))
>   
>   DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
>   	     local_lock_nested_bh(_T),
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index 8d5ac16a9b179..b4d7b24882835 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -99,14 +99,14 @@ do {								\
>   		local_trylock_t *tl;					\
>   		local_lock_t *l;					\
>   									\
> -		l = (local_lock_t *)this_cpu_ptr(lock);			\
> +		l = (local_lock_t *)(lock);			\
>   		tl = (local_trylock_t *)l;				\
>   		_Generic((lock),					\
> -			__percpu local_trylock_t *: ({			\
> +			local_trylock_t *: ({			\
>   				lockdep_assert(tl->acquired == 0);	\
>   				WRITE_ONCE(tl->acquired, 1);		\
>   			}),						\
> -			__percpu local_lock_t *: (void)0);		\
> +			local_lock_t *: (void)0);		\
>   		local_lock_acquire(l);					\
>   	} while (0)
>   
> @@ -133,7 +133,7 @@ do {								\
>   		local_trylock_t *tl;				\
>   								\
>   		preempt_disable();				\
> -		tl = this_cpu_ptr(lock);			\
> +		tl = (lock);					\
>   		if (READ_ONCE(tl->acquired)) {			\
>   			preempt_enable();			\
>   			tl = NULL;				\
> @@ -150,7 +150,7 @@ do {								\
>   		local_trylock_t *tl;				\
>   								\
>   		local_irq_save(flags);				\
> -		tl = this_cpu_ptr(lock);			\
> +		tl = (lock);					\
>   		if (READ_ONCE(tl->acquired)) {			\
>   			local_irq_restore(flags);		\
>   			tl = NULL;				\
> @@ -167,15 +167,15 @@ do {								\
>   		local_trylock_t *tl;					\
>   		local_lock_t *l;					\
>   									\
> -		l = (local_lock_t *)this_cpu_ptr(lock);			\
> +		l = (local_lock_t *)(lock);				\
>   		tl = (local_trylock_t *)l;				\
>   		local_lock_release(l);					\
>   		_Generic((lock),					\
> -			__percpu local_trylock_t *: ({			\
> +			local_trylock_t *: ({			\
>   				lockdep_assert(tl->acquired == 1);	\
>   				WRITE_ONCE(tl->acquired, 0);		\
>   			}),						\
> -			__percpu local_lock_t *: (void)0);		\
> +			local_lock_t *: (void)0);		\
>   	} while (0)
>   
>   #define __local_unlock(lock)					\
> @@ -199,11 +199,11 @@ do {								\
>   #define __local_lock_nested_bh(lock)				\
>   	do {							\
>   		lockdep_assert_in_softirq();			\
> -		local_lock_acquire(this_cpu_ptr(lock));	\
> +		local_lock_acquire((lock));			\
>   	} while (0)
>   
>   #define __local_unlock_nested_bh(lock)				\
> -	local_lock_release(this_cpu_ptr(lock))
> +	local_lock_release((lock))
>   
>   #else /* !CONFIG_PREEMPT_RT */
>   
> @@ -227,7 +227,7 @@ typedef spinlock_t local_trylock_t;
>   #define __local_lock(__lock)					\
>   	do {							\
>   		migrate_disable();				\
> -		spin_lock(this_cpu_ptr((__lock)));		\
> +		spin_lock((__lock));				\
>   	} while (0)
>   
>   #define __local_lock_irq(lock)			__local_lock(lock)
> @@ -241,7 +241,7 @@ typedef spinlock_t local_trylock_t;
>   
>   #define __local_unlock(__lock)					\
>   	do {							\
> -		spin_unlock(this_cpu_ptr((__lock)));		\
> +		spin_unlock((__lock));				\
>   		migrate_enable();				\
>   	} while (0)
>   
> @@ -252,12 +252,12 @@ typedef spinlock_t local_trylock_t;
>   #define __local_lock_nested_bh(lock)				\
>   do {								\
>   	lockdep_assert_in_softirq_func();			\
> -	spin_lock(this_cpu_ptr(lock));				\
> +	spin_lock((lock));					\
>   } while (0)
>   
>   #define __local_unlock_nested_bh(lock)				\
>   do {								\
> -	spin_unlock(this_cpu_ptr((lock)));			\
> +	spin_unlock((lock));					\
>   } while (0)
>   
>   #define __local_trylock(lock)					\
> @@ -268,7 +268,7 @@ do {								\
>   			__locked = 0;				\
>   		} else {					\
>   			migrate_disable();			\
> -			__locked = spin_trylock(this_cpu_ptr((lock)));	\
> +			__locked = spin_trylock((lock));	\
>   			if (!__locked)				\
>   				migrate_enable();		\
>   		}						\

It looks better if the trailing '\' of multi-line macros can be made 
aligned on the right side. Other than that, it looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

