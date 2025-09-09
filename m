Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92133EAF8
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Sep 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423383; cv=none; b=Utfl1y/gP6O3VZ/MvHdk6+xLwpWqBbtCidfEH1CpCKTbVn/pPYnUhHewZcegysOVf3pzfYlbNgG6lWGUosM1XBPTpub6TmheHzrsLIbejSFxhqxM1G/c1H16dlG5mIqlJe5SRvv313HqtRp5r29A4jQVptkFwcQaO7U/v39CAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423383; c=relaxed/simple;
	bh=+UVfjwCoBbPWtTlBKBtHS7oAtn+6cbbaP0o4IdyZkfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkcY3RD2l4w9Rs8p/0dH2kGVZIrpzw0LmAIUEPFNE0zzSDgyxWtUFMUIILZSWU4E2hKA9g8KvSid/WhK4wyEH4Ij1RHUzz+uiK8J5tC/RX0srkdu6e6sAhjmbMwi2Bxfu0ZptZXmoe0SvaBV0QHNn8M7KtdbPGg5EADnvkdXmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVkYhNqn; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVkYhNqn"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-53410d0f4e7so4455043137.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 09 Sep 2025 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757423380; x=1758028180; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QxQ4D3devrX/oCb6PwEFal+/eB4lWSgr0y2485GZZpk=;
        b=PVkYhNqnR3BgiHCi0mr1Z+yE5REyOWtyCmswJPLcaDetvKWe4+aC27Dz5e6jfGPNpB
         krBMF/EjwXWBfgh94ttKP9qjW+f/IiW8baSTw8Jz8rbzR7sC2CtDEQSKch3qtb7Gl8cH
         I/OhA6bFOpgA8dt+7yQuRuQdXKn0dd510x9CUw5lf27K/ano1EiCvIQ7e8bjkkc25kJU
         3dOUQGnd25pVI07VeLzt6wBQPU+1ZJ10PFXjxFSSdcOC5sG3g7s41efI8d0iWl7lREDW
         b1EIongQD8bjW8vK4o0sWMoAOTtQRughyQv4oY0MLoB1r6rGenVHtMSABoZQcDS5lYDz
         EEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423380; x=1758028180;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxQ4D3devrX/oCb6PwEFal+/eB4lWSgr0y2485GZZpk=;
        b=Xi755rQdWlXrMrXheSFtLEEt50CU4n1VACXGhps/1va02XOekOs1o1acKfkA6jFF9x
         dC0cPLODcHhM2f4tJ+LXxKj6gf+5aW8qsYbSH4fKOaT89ZdJzYlt1PjzV857R170/UUo
         YnLSl6LiuhQwNzSqUQj1fFTBOGhTAu25ZWotFXIy1jkrMKE8CxUlhFvG1QTG7yXttOct
         oQUexe2aHXZ5AtWZalUP3uNPxT2hLGmKU19qq4nkDelTFRX+nSaEbcZc8dXTmEhPbCCY
         OPOgd9XnXZ5lYOjSSAhRz7dpHhWHyGunqKPUR6rElrTCxDrUhf1luUDcLgAKojWcnhrs
         qRHw==
X-Forwarded-Encrypted: i=1; AJvYcCWZkvl0WsrxLuMufvTv5gbNKqOAgH1fjeFl5RLeN/2yiI003U9BXsQ4RFVsTHk76ClhQTjdtgDthw9x9KTagw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHahiX6ZXHIGy33yZh7cWzSCbZtmP4S4EvyfOu2/n0mndJGB5W
	SmNBoO40VnWld9956M5Ivj4vdAcegyERZ6F11JbtDb4m305Nfu2DFIsliGsOONFqVbo=
X-Gm-Gg: ASbGnctWfAfAIe00vviFHutcfG65hZeCDSG/eyxspQu5bf+w7cqVwpSc9WGGoC+WPQL
	0NtsPAUn1S8o9YZeUnR4T6OzG5vkiYZ6j5NQ1cIshvMoQBV5Z7OmQc+VsQKjAPGaB+03wKmGV5d
	MspH1oMKzUsQkXvH2oC6AlGUI+4YkDdi0cSjRuylWmAm7OTfn8MlDh+3v5XhyyV18dtJ7WSfsLl
	ii2J2SmeszU7Ge43Qeu850rkEHOtpaxKtb1N4PJwNzyV1mhWuNdxOdTeJMqnZ8tv9X7GPcFtI7R
	kEYR9YMp5YM2mRtWnc3bkzFKke5spUXUE8ZlFEq4XhVlGAF45KiFsLxfWmwoVOpCIWPvQ6JgQTi
	Y07eAFCxqjcj2P1CWeBdI7Cd5zrVuZIgG5QHZOS0qi7NnzWkiSsQYnLdwF0rxhKwMUcQolAjkMF
	oKau1+TskAvSFvHLHpIIKOWdfU
X-Google-Smtp-Source: AGHT+IHiYpUe2mZ+yRaMgn6EJDMtGOSzXUMIZ/IGClH3mj79Yo98v45jN0CqC43bdWnV5p99F7GtRQ==
X-Received: by 2002:a05:6102:148a:b0:4e9:ba27:2c94 with SMTP id ada2fe7eead31-53d1aeacad2mr3659023137.6.1757423379796;
        Tue, 09 Sep 2025 06:09:39 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:9993:549e:6cce:f6f6:7dea? ([2804:1b3:a7c1:9993:549e:6cce:f6f6:7dea])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52af1e46f50sm10957301137.14.2025.09.09.06.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:09:39 -0700 (PDT)
Message-ID: <660fc0c9-7768-4812-b532-5afc94131cf8@linaro.org>
Date: Tue, 9 Sep 2025 10:09:36 -0300
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: libc-alpha@sourceware.org, John Ogness <john.ogness@linutronix.de>,
 linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>
References: <20250908163329.Qq79ujq_@linutronix.de>
 <4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
 <20250909073226.0qoHYZMo@linutronix.de>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20250909073226.0qoHYZMo@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/09/25 04:32, Sebastian Andrzej Siewior wrote:
> On 2025-09-08 14:46:12 [-0300], Adhemerval Zanella Netto wrote:
>>> This change expects that PI-FUTEX is supported by the kernel. This is
>>> the case since a long time but it is possible to disable the FUTEX
>>> subsystem or the FUTEX_PI part of it while building the kernel.
>>> Is it okay to assume that PI-FUTEX is available or should there be a
>>> check somewhere during startup and in case of -ENOSYS a fallback to
>>> current implementation?
>>
>> We removed the __ASSUME_FUTEX_LOCK_PI (f5c77f78ec03363d5e550c4996deb75ee3f2e32a)
>> in favor or always check for PI support at runtime during pthread_mutex_init
>> (prio_inherit_missing).
>>
>> Since the kernel still might return ENOSYS for FUTEX_PI I think we should
>> keep probing its support as runtime.
> 
> Okay. Since that one is static, I guess I would have to make my own
> check in pthread_cond.
> 

Or move the prio_inherit_missing to its own TU and use is an internal
symbol.

> But… Now that I look at it again. The kernel has this FUTEX_PI option
> which depends on RT_MUTEXES. But RT_MUTEXES has no off switch so it must
> always be selected once FUTEX itself is enabled. The I2C subsystem
> selects RT_MUTEXES and I don't think there is a config without PI-FUTEX
> considering this.
> We _used_ to have runtime detection for PI-FUTEX support because not all
> architectures provided a cmpxchg function for futex. This is gone and
> all architectures as of v5.17 provide it. That would be commit
>    3297481d688a5 ("futex: Remove futex_cmpxchg detection")
>    https://git.kernel.org/torvalds/c/3297481d688a5
> 
> for reference. So I *think* this config option can be removed on kernel
> side and it appears to me as of v5.17 there should be no need for a
> runtime check regarding PI-futex.

Right, but at least for glibc we will need to keep the runtime check
because we still support old kernels.

> 
>>> --- a/nptl/pthread_cond_common.c
>>> +++ b/nptl/pthread_cond_common.c
>>> @@ -106,41 +106,23 @@ __condvar_fetch_xor_wseq_release (pthread_cond_t *cond, unsigned int val)
> …
>>>  static void __attribute__ ((unused))
>>>  __condvar_acquire_lock (pthread_cond_t *cond, int private)
>>>  {
> …
>>> +      int e;
>>> +
>>> +      e = __futex_lock_pi64 (&cond->__data.__pi_lock, 0, NULL, private);
>>> +      if (e != 0)
>>> +        futex_fatal_error ();
>>
>> The __futex_lock_pi64 already issues futex_fatal_error() non-expected return code;
>> so I think we should only use it futex-internal.{c,h}.
> 
> There shouldn't be any error. There might be the case where the lock
> owner is gone (ESRCH I believe) or the theoretical ENOMEM. ESRCH isn't
> handled now but it can't be recognized either. It would require to kill
> the thread owning the lock.
> So either abort the operation if the futex-op returns an error because
> "this shouldn't happen" or I don't know.
> 

On pthread_mutex_lock we handle ESRCH only for non-robust PI mutexes, and
we delay the thread indefinitely. I am not sure which is the best approach,
but I am tending for the delay one for consistency.

>> And I think we will need to handle ENOSYS here, maybe to use the old locking logic
>> if the kernel does not support FUTEX_PI. I think it should be fair to assume that
>> if your running your workload on an environment without FUTEX_PI support you are
>> not subject to the issue you raised.
> 
> Yes, that is fair to assume. Also given the above it might be a
> leftover. But let me add the fallback code and then we can remove once
> it is certain on Kernel's side.

I think we won't be able to remove because we still need to handle older
kernels that might return ENOSYS.

> 
>> I am ccing Carlos, he has helped fix some issue on cond vars recently and he
>> might have some idea if using PI aware locks does make sense here.
>>
>> Also, I think we really need regression testcases for this change.
> 
> I came up with something to test this. It required a few CPUs and task
> pinning otherwise the small window didn't trigger.

Right, I think the idea would to provide a way to over multiples runs from
multiple developers in multiple machines we can assume that this is triggered.
I agree that for such problems is really hard to come up with reliable test
cases without spending a lot of cpu time.

> 
>>>      }
>>>  }
> 
> Sebastian

