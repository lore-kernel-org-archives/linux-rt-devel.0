Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09262F5E
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 May 2025 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747270018; cv=none; b=AHc6n26rCqJ02L6AtWeTkNAZT9BDkhjmhy34Ej67uFHLZTPG/vArjN3eNxzB5QUrMVHI/kJlslMooAdp1isBRFMJPb4npxw+imERpanOtVco//ZtnGCm1p2UVQ7bbroNeRZmcjy1TwNYZgDgsxpbrdj9zz2va1KrFD7WVFdAtbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747270018; c=relaxed/simple;
	bh=CFLN9/cxyNLTlzc+Ux5r4nx7pH3h6oCprO5dPG3iVAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhEtjSrNN4xuw/8+dXASrCdDtqQzy3JCv/0RzklQ+GByKozzY9mw6jbQ/9ZO5sVC4nluHqmQFNSdydIcXT1O3+GJMJCqMipt6h7NsXFzKE8BwD2cY28RfbOYx3qrbm+qddoe8xXKJHw7mT3HIm/dGQyEPd5+BAyzA33ysaC/Uho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF1GhkqL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF1GhkqL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0af41faa5so159579f8f.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 May 2025 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747270015; x=1747874815; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPQI1WS6AB+A/U7AWpPuLM+DOikiei6WxX6ByvDP9Zk=;
        b=fF1GhkqLqo/Lh6uzO/fAA4SYuDKwzuhbdNATXMIRATA4dsb9Wg+KlNJY59ufcwfCdj
         aNqBnXdyzhM3Insb7DyAUGn14Bs/P1qt7sy7zVFZlNJYfxnUFAT1yzr1jbdb1rN6/Jhv
         tJFWxvHqe4fjAAw7h0EWZucCGswZg4HqhfDOHrbBGLRBdKUDH+GfWdFm7gdZgev4fiNW
         ePSA4nnfRpRueDEM0m2VV6H49p7X13lHA736xQvOS/J9dZY8MBYl5bGhwLCuzro1F49p
         J1diET4kswCEA8oy35lAZnNAhNZErCkk0nCOvXCM4CzuP3/vlnaYJ6dp5zsS3nVMLRAq
         rXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747270015; x=1747874815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPQI1WS6AB+A/U7AWpPuLM+DOikiei6WxX6ByvDP9Zk=;
        b=oSFjgEVTj1Sut8Ko+AJJCGk4vb2mog7B85EjT3im760WFJNRJ2wkNCj5IHNZdvhbKr
         5ZoCUc9+aJZI6zDzxj42H6xFbCb6LtHWv54q40M9Hg+oANEDLaRgo/LFBZg6H7n7WMqF
         0w2NbXJB6df9JMxuKWX/nu5mNUncrQBZtNn2oB+BGsce1ajSuIapNBO6XTrM/YrmE4jc
         xI+kzfYtMkJrOO0i0TxBpoNjDfZVsLVXEwMmoEHiROXlkwNfdAc5FvVmVxbhe2DhYfPp
         IJKUBX5+IJnRiVRJWToTeidGg+kcRWWhowSYQKyZAaOTQ2KsgBZ8YBjXvIWS+Rly1Upg
         Bhvw==
X-Forwarded-Encrypted: i=1; AJvYcCX0kcPa+kZj2yr++5ufbMu6u3BPENMIeO6mBfdRqqMQfho6JFb7J1bHltEAQEHhbMh6MsrZP3HyY4ShwKZOxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVaaR9VO47YUHeKrM4aFuZnDfbO1M8WDYK1k+toK567PI6qhpJ
	nhuw73KXLEI63VKYqcdVWg8Cab9RbPs1BcAXkMWCMfvY/3pITPjDliKVeST3MU16dHSG+0DmNkW
	aPc1Jc0ITCoOinN9HhkoY0PSqA0M0ujqA
X-Gm-Gg: ASbGncubl1AtXPUpEytKI5fEqSVDJW6nUqux2xe+s274Qzgd9S0M+q2eVb4KOgYudI8
	2rL4FJamxQ4PFzBPHHFt6Pq9+hJOUX1HeaOND3u2Jsnt1pT9KN3NNXdx3aEMNgGxC6HxxQTAlxk
	Rce7pRGqiFstNOyZfPW4kWfOVgiibp7bBjD5nijN+27iHlLMv1M5EmNkGYFLAts+xsnJXKWsjH
X-Google-Smtp-Source: AGHT+IFvguK5EGohjnZtpt0PIlv1IYbXz5WvOlqrdtAP/4VH871pPVsi6cP0RCNRby9CG3Qd89iv5iHFbtSkDcWDoKk=
X-Received: by 2002:a05:6000:3112:b0:3a3:47cf:5b6 with SMTP id
 ffacd0b85a97d-3a3537a904dmr375228f8f.43.1747270014837; Wed, 14 May 2025
 17:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250514110750.852919-1-bigeasy@linutronix.de> <20250514110750.852919-2-bigeasy@linutronix.de>
In-Reply-To: <20250514110750.852919-2-bigeasy@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 May 2025 17:46:43 -0700
X-Gm-Features: AX0GCFvl1zo_ilDqc1Rp5K1Hv8APOcGDlYJ2RgUVqR2HL2PRN2984xNmivjT_cU
Message-ID: <CAADnVQLz=+FN8-B_QmmT-eg7PB7jGHiah=9B-s5WpfmQbAF3eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] local_lock: Move this_cpu_ptr() notation from
 internal to main header.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:07=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
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
>  include/linux/local_lock.h          | 20 +++++++++----------
>  include/linux/local_lock_internal.h | 30 ++++++++++++++---------------
>  2 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 16a2ee4f8310b..2ba8464195244 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -13,13 +13,13 @@
>   * local_lock - Acquire a per CPU local lock
>   * @lock:      The lock variable
>   */
> -#define local_lock(lock)               __local_lock(lock)
> +#define local_lock(lock)               __local_lock(this_cpu_ptr(lock))
>
>  /**
>   * local_lock_irq - Acquire a per CPU local lock and disable interrupts
>   * @lock:      The lock variable
>   */
> -#define local_lock_irq(lock)           __local_lock_irq(lock)
> +#define local_lock_irq(lock)           __local_lock_irq(this_cpu_ptr(loc=
k))
>
>  /**
>   * local_lock_irqsave - Acquire a per CPU local lock, save and disable
> @@ -28,19 +28,19 @@
>   * @flags:     Storage for interrupt flags
>   */
>  #define local_lock_irqsave(lock, flags)                                \
> -       __local_lock_irqsave(lock, flags)
> +       __local_lock_irqsave(this_cpu_ptr(lock), flags)
>
>  /**
>   * local_unlock - Release a per CPU local lock
>   * @lock:      The lock variable
>   */
> -#define local_unlock(lock)             __local_unlock(lock)
> +#define local_unlock(lock)             __local_unlock(this_cpu_ptr(lock)=
)
>
>  /**
>   * local_unlock_irq - Release a per CPU local lock and enable interrupts
>   * @lock:      The lock variable
>   */
> -#define local_unlock_irq(lock)         __local_unlock_irq(lock)
> +#define local_unlock_irq(lock)         __local_unlock_irq(this_cpu_ptr(l=
ock))
>
>  /**
>   * local_unlock_irqrestore - Release a per CPU local lock and restore
> @@ -49,7 +49,7 @@
>   * @flags:      Interrupt flags to restore
>   */
>  #define local_unlock_irqrestore(lock, flags)                   \
> -       __local_unlock_irqrestore(lock, flags)
> +       __local_unlock_irqrestore(this_cpu_ptr(lock), flags)
>
>  /**
>   * local_lock_init - Runtime initialize a lock instance
> @@ -64,7 +64,7 @@
>   * locking constrains it will _always_ fail to acquire the lock in NMI o=
r
>   * HARDIRQ context on PREEMPT_RT.
>   */
> -#define local_trylock(lock)            __local_trylock(lock)
> +#define local_trylock(lock)            __local_trylock(this_cpu_ptr(lock=
))
>
>  /**
>   * local_trylock_irqsave - Try to acquire a per CPU local lock, save and=
 disable
> @@ -77,7 +77,7 @@
>   * HARDIRQ context on PREEMPT_RT.
>   */
>  #define local_trylock_irqsave(lock, flags)                     \
> -       __local_trylock_irqsave(lock, flags)
> +       __local_trylock_irqsave(this_cpu_ptr(lock), flags)
>
>  DEFINE_GUARD(local_lock, local_lock_t __percpu*,
>              local_lock(_T),
> @@ -91,10 +91,10 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t =
__percpu,
>                     unsigned long flags)
>
>  #define local_lock_nested_bh(_lock)                            \
> -       __local_lock_nested_bh(_lock)
> +       __local_lock_nested_bh(this_cpu_ptr(_lock))
>
>  #define local_unlock_nested_bh(_lock)                          \
> -       __local_unlock_nested_bh(_lock)
> +       __local_unlock_nested_bh(this_cpu_ptr(_lock))
>
>  DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
>              local_lock_nested_bh(_T),
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index 8d5ac16a9b179..b4d7b24882835 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -99,14 +99,14 @@ do {                                                 =
               \
>                 local_trylock_t *tl;                                    \
>                 local_lock_t *l;                                        \
>                                                                         \
> -               l =3D (local_lock_t *)this_cpu_ptr(lock);                =
 \
> +               l =3D (local_lock_t *)(lock);                     \
>                 tl =3D (local_trylock_t *)l;                             =
 \
>                 _Generic((lock),                                        \
> -                       __percpu local_trylock_t *: ({                  \
> +                       local_trylock_t *: ({                   \
>                                 lockdep_assert(tl->acquired =3D=3D 0);   =
   \
>                                 WRITE_ONCE(tl->acquired, 1);            \
>                         }),                                             \
> -                       __percpu local_lock_t *: (void)0);              \
> +                       local_lock_t *: (void)0);               \

Are you sure this is correct?
Have you tested with gcc 14 or higher?

It looks to me that moving this_cpu_ptr() up one level should
still preserve __seg_gs modifier.
