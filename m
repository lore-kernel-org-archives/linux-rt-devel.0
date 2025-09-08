Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3F7E107
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Sep 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353578; cv=none; b=AzffFqLZVSpKRpBO6/vGHXQ0F/VtJYrxB+KAElnahR/GPZA4UJDZO7o/KVR/3f4FAeFd7ucXkSUIsGR4LEepLU+GmBI3Mmj7mZJ+JWG+/ZX5q/pg1rrKjHvXEeeeSsbYveyig3/dCGmD9jynurhIA0slpBJpSMkyancs4uaMuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353578; c=relaxed/simple;
	bh=U9mIGQYeM7KMvpqqqe1twONjr05I6uT0bqv1dQkYKPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqFJBCO9fKr3vYnIj0RHAr25mZem44o1k8gsx01SqyG+gLQVnXHg20K6QodXxohLVh8tGRHNLEEq34V5b+FgofwD/F20gzM6oXG6CtvMQMVuLY3zfMH44By+AisXZizQC/+zPK+xVXRiR4gKo5SvF806yyCNM04n4jCQztW8SyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNcVrOaR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNcVrOaR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445806df50so40681025ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 08 Sep 2025 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757353575; x=1757958375; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NWrXMo8Vi/Oy/cg2Z8vpZiP6mpdtqyZacXHbSjYG1HU=;
        b=XNcVrOaRy/PUcY/3ro1c0ycfHGcBK1taOe4PCA2O044k2btTY7K4shpMExTK+TUuIH
         HFNlmp83i2XUc47R25MQxQVy8CR0OUIvHes5CTOjFx/E2Cm8KOmLZMAFJfTGp/iFMcQ8
         SE3KdpDgwVjgRL4pe1O1elMkZ0MhBGpRl8IXhLM4pHXd7w3wMJZN4/kBnqlDRComg/zW
         6Ztffrzn9zprGxYEB+zxkQ5bIpHNCz4NQ/tEekqiyTLwsa528c17j7Nddf3FqU8v7KIK
         K8kw8wQk80/Soqhb/ITOot8+JUzhhShNSP3sLWBQABekyqgLljTg86Hz6MksnEMuPv+c
         0syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353575; x=1757958375;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWrXMo8Vi/Oy/cg2Z8vpZiP6mpdtqyZacXHbSjYG1HU=;
        b=NJmj9gB2SGvu28DdCkZrUSU3g2J/VbVKgEzsiBQBJVGtHZR0reQQwbS3G05TAV+u30
         zuufcNULaeuXXA3fLFly8ugH3WZsVtnQjL8Ump6nlCxAxM8KhfR9l8hRbJnygiWABZsj
         p5I4PlBN579uozxMYshWIVu70gDtkJyK0lzgUnBt4INf20a2ZqPN2KVJ1gum0JaiR2mG
         PCK/CatJO9btG1NCZ3Xly6ybdLRELiQ5zZ8F+velv5sJPNuE7mrTILCDf3Zh0yH7J7HD
         EB10lN4NAo/c8x5NeTq5FI8rCQ7jKRTDsW/dyfuyiAPvd5kGj5diS+Hb7lHHaijTxUdm
         iZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVhkv84OpPLFF5SuOhGcjix0G/lnAr2TzrkUGohySrMc/aFwVoz0mIHXQPDxFWLghagtvrPlc9xWofhk1PUYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYBB2uFjeAPUcdP4Aypqlz4tORkQ4VDytW+beUxBtnXk8zvADu
	Tc6meeHaKQG+pEpnbepncPWTfgnJJn3vx2Pjy9kFpQ/uQ+c8+rwdS9Poo804ZSZXzCk=
X-Gm-Gg: ASbGncvm+fAXMfjoykuhfFsqWqQW2q80PWHVlMSco/jjEVb90L++O6ToAMSnCGPyux3
	9sX9a3mXedicyc8nAB+5altbw5tt7ZJGsL1HkKxmUEmWQK4s9FIrWxidkaexxih2oRkB6Y3Yyug
	FLkjaooZP7ahYr9FHHq0R82bCB0rMLk3NHZAmEBz7hckF5iy2Cb0zfJaE1WuLgZvYwSfvpZXur+
	9DI8z9pNDk+1cSKDQsj/hhKTPa1FnSnAoAk547eowYL5GejNd5fKgWZMUQX6tfSjkTDhQcvCtOb
	dtl6X6uqOD/YaSSdAASVabwvMc+/HfEKAR4D71Rl+pb+878WnzAECoMlE6IyB8r0OD3cPt7W1/Y
	B5SuwShlXEcm2M1yby0bkPD3SYzjEU6L6kCLsMnCnTo51itXEAF6KTO0Ns2xp+MfuO58sY4CZX+
	RjXT+54wh7KvYqISCS8ywpqfhVqUBCY+CMhGv0pM3XL/FHpA==
X-Google-Smtp-Source: AGHT+IHE84GmzfbxhrskQsq8HrTGoe4xm+qrDh1bY7Xvo4JlNT/NlkOtULkh3zMXAKk62ZBpCPc4Vw==
X-Received: by 2002:a17:903:a86:b0:240:48f4:40f7 with SMTP id d9443c01a7336-251734f2f64mr106988035ad.39.1757353575516;
        Mon, 08 Sep 2025 10:46:15 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:9993:549e:6cce:f6f6:7dea? ([2804:1b3:a7c1:9993:549e:6cce:f6f6:7dea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccc79a345sm116356165ad.132.2025.09.08.10.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:46:15 -0700 (PDT)
Message-ID: <4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
Date: Mon, 8 Sep 2025 14:46:12 -0300
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 libc-alpha@sourceware.org
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-devel@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Carlos O'Donell <carlos@redhat.com>
References: <20250908163329.Qq79ujq_@linutronix.de>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20250908163329.Qq79ujq_@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/09/25 13:33, Sebastian Andrzej Siewior wrote:
> The pthread_cond_t structure provides an internal lock using the lower two bits
> of __g1_orig_size. This lock is always used by the signaller. The waiter uses
> it only in certain corner cases such as when canceling a wait due to a timeout.
> 
> Under contention, a thread attempting to acquire the lock invokes the futex
> operation FUTEX_WAIT while waiting for the lock to become available. This
> behavior can be problematic in real-time environments because the priority of
> the waiting task is not considered. As a result, a lower-priority task may
> become runnable while the lock owner remains preempted.
> 
> To address this, repurpose the unused member __unused_initialized_1 as a
> priority-inheritance (PI) futex named __pi_lock. This is the futex word, not a
> pthread_mutex_t.
> 
> __condvar_acquire_lock() performs an atomic transition from 0 to TID. If it
> fails, it falls back to __futex_lock_pi64(), which acquires the lock via
> FUTEX_LOCK_PI.
> __condvar_release_lock() performs an atomic transition from TID to 0. If it
> fails, it falls back to futex_unlock_pi(), which releases the lock and
> wakes a potential waiter.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This is a follow-up to
> 	https://lore.kernel.org/all/20250829145659.KhM4kIoQ@linutronix.de/
> 
> This change expects that PI-FUTEX is supported by the kernel. This is
> the case since a long time but it is possible to disable the FUTEX
> subsystem or the FUTEX_PI part of it while building the kernel.
> Is it okay to assume that PI-FUTEX is available or should there be a
> check somewhere during startup and in case of -ENOSYS a fallback to
> current implementation?

We removed the __ASSUME_FUTEX_LOCK_PI (f5c77f78ec03363d5e550c4996deb75ee3f2e32a)
in favor or always check for PI support at runtime during pthread_mutex_init
(prio_inherit_missing).

Since the kernel still might return ENOSYS for FUTEX_PI I think we should
keep probing its support as runtime.
> 
>  nptl/pthread_cond_common.c              | 58 ++++++++++---------------
>  sysdeps/nptl/bits/thread-shared-types.h |  2 +-
>  2 files changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/nptl/pthread_cond_common.c b/nptl/pthread_cond_common.c
> index 2708d262958f2..74010787b18de 100644
> --- a/nptl/pthread_cond_common.c
> +++ b/nptl/pthread_cond_common.c
> @@ -106,41 +106,23 @@ __condvar_fetch_xor_wseq_release (pthread_cond_t *cond, unsigned int val)
>  #endif /* !__HAVE_64B_ATOMICS */
>  
>  /* The lock that signalers use.  See pthread_cond_wait_common for uses.
> -   The lock is our normal three-state lock: not acquired (0) / acquired (1) /
> -   acquired-with-futex_wake-request (2).  However, we need to preserve the
> -   other bits in the unsigned int used for the lock, and therefore it is a
> -   little more complex.  */
> +   The lock is the futex PI lock (PTHREAD_MUTEX_PI_NORMAL_NP) using just the
> +   futex word. */
>  static void __attribute__ ((unused))
>  __condvar_acquire_lock (pthread_cond_t *cond, int private)
>  {
> -  unsigned int s = atomic_load_relaxed (&cond->__data.__g1_orig_size);
> -  while ((s & 3) == 0)
> +  int oldval, newval;
> +
> +  newval = THREAD_GETMEM (THREAD_SELF, tid);
> +  oldval = atomic_compare_and_exchange_val_acq (&cond->__data.__pi_lock,
> +                                                newval, 0);
> +  if (oldval != 0)
>      {
> -      if (atomic_compare_exchange_weak_acquire (&cond->__data.__g1_orig_size,
> -	  &s, s | 1))
> -	return;
> -      /* TODO Spinning and back-off.  */
> -    }
> -  /* We can't change from not acquired to acquired, so try to change to
> -     acquired-with-futex-wake-request and do a futex wait if we cannot change
> -     from not acquired.  */
> -  while (1)
> -    {
> -      while ((s & 3) != 2)
> -	{
> -	  if (atomic_compare_exchange_weak_acquire
> -	      (&cond->__data.__g1_orig_size, &s, (s & ~(unsigned int) 3) | 2))
> -	    {
> -	      if ((s & 3) == 0)
> -		return;
> -	      break;
> -	    }
> -	  /* TODO Back off.  */
> -	}
> -      futex_wait_simple (&cond->__data.__g1_orig_size,
> -	  (s & ~(unsigned int) 3) | 2, private);
> -      /* Reload so we see a recent value.  */
> -      s = atomic_load_relaxed (&cond->__data.__g1_orig_size);
> +      int e;
> +
> +      e = __futex_lock_pi64 (&cond->__data.__pi_lock, 0, NULL, private);
> +      if (e != 0)
> +        futex_fatal_error ();

The __futex_lock_pi64 already issues futex_fatal_error() non-expected return code;
so I think we should only use it futex-internal.{c,h}.

And I think we will need to handle ENOSYS here, maybe to use the old locking logic
if the kernel does not support FUTEX_PI. I think it should be fair to assume that
if your running your workload on an environment without FUTEX_PI support you are
not subject to the issue you raised.

I am ccing Carlos, he has helped fix some issue on cond vars recently and he
might have some idea if using PI aware locks does make sense here.

Also, I think we really need regression testcases for this change.

>      }
>  }
>  
> @@ -148,10 +130,16 @@ __condvar_acquire_lock (pthread_cond_t *cond, int private)
>  static void __attribute__ ((unused))
>  __condvar_release_lock (pthread_cond_t *cond, int private)
>  {
> -  if ((atomic_fetch_and_release (&cond->__data.__g1_orig_size,
> -				 ~(unsigned int) 3) & 3)
> -      == 2)
> -    futex_wake (&cond->__data.__g1_orig_size, 1, private);
> +  pid_t id = THREAD_GETMEM (THREAD_SELF, tid);
> +
> +  if (!atomic_compare_exchange_weak_release (&cond->__data.__pi_lock, &id, 0))
> +    {
> +      int e;
> +
> +      e = futex_unlock_pi ((unsigned int *) &cond->__data.__pi_lock, private);
> +      if (e != 0)
> +	futex_fatal_error ();
> +    }
>  }
>  
>  /* Only use this when having acquired the lock.  */
> diff --git a/sysdeps/nptl/bits/thread-shared-types.h b/sysdeps/nptl/bits/thread-shared-types.h
> index e614c7f3c900e..9b362d5282cd9 100644
> --- a/sysdeps/nptl/bits/thread-shared-types.h
> +++ b/sysdeps/nptl/bits/thread-shared-types.h
> @@ -99,7 +99,7 @@ struct __pthread_cond_s
>    unsigned int __g1_orig_size;
>    unsigned int __wrefs;
>    unsigned int __g_signals[2];
> -  unsigned int __unused_initialized_1;
> +  int __pi_lock;
>    unsigned int __unused_initialized_2;
>  };
>  

