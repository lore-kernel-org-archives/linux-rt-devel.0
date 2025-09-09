Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D533302CAB
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Sep 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445258; cv=none; b=QnvGTPDbu7UzjLfaHXWneZ74ucSRte4qbeZnAmm+HdobUXnxIcXuaW795Arh5IOsOiE0EcNhJ22DVj5uh3RkRnY49ITjzdC/EYZ4O7zkC6rQREideI6oxrr0rmlwlJ9vhGijZB97ZQ7MtIM83Lz/KJIob6RYHEmSkbqIdU41/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445258; c=relaxed/simple;
	bh=SMkkNK8VhpBhMoz03wv6dc9blYE24Bgm8S71pNDE9fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoXcPxhHYr8bNXA3Uk6/QkDC3Px5bmUavmw5AczRJyOSdvFCovPW19EZwrrFs16kEwVI0/bgv8D/hg6BeNvCBZjPeZFlEzrZuKtOcvwUAhU5NtQZuj9/DXGDLhdXXJ/m9t3Tkvly2srcyoKVIKtvFz5Y0QUuFTVyFojjLCjpF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x25DLmkE; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x25DLmkE"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89ea3532bfbso1816515241.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 09 Sep 2025 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757445255; x=1758050055; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oHWzE6p6WjhR3fvexMoQqclmt3w+wxEZ/2BSX7DJrLs=;
        b=x25DLmkEE6V72moSffAqPNcXLO8o7IYdvyZFjSY/EwXyXqNFIN8wZDN8Dwe3rV1L1j
         bJiIMP3zfuVzVQyasEmjojRbCMkhNadb5J2JMboHYtR9vk0numVAyo2+KW44KozeKkTj
         EUMLMMqT2NJ72WEF7mhKGv02a3JWbIqO5Z+Izs0AG4QAYTAgDWzeTv/TC3vkHPgT1n/n
         Lv+/4Kkmbsehm2fPJ3jLUAjgmEX0245BKwk4AFaBDVoGyopeHjHWP++GFFznPcx+F32a
         5IZ0YqP1RoFivJNsmqw2SICTcPV1q4Gda5o6XaginKqidADmU4cWfLRcQyjSlHO+A7LJ
         YCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445255; x=1758050055;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHWzE6p6WjhR3fvexMoQqclmt3w+wxEZ/2BSX7DJrLs=;
        b=fIvhv/qFlB889Ac2lE4jixYzyWyqchmqbKXqznqqP+9AQsN/0fi/W8rcJTgQ0UeHpP
         FDX6FYxAmjCBIdVJdhm6Tya38UltZPQ0Df0tN3y+7El6+5ItUnazTEb4q4lP2mHRpECj
         XKp6fg8xU6RLJAVONnK+9HTsznivmdMWl8YDA6JLvro8APjwqRNedBA418SwEwdXR9tY
         1deNdT9XG11crLi/ewjfmV5vsIaMwtr6mVHFodjH+KxRUqOEmAAwBArOj8xtyxzhqGzc
         Tfpnby+FJByjpVvxIe3qcOxr9eI+HOBp4g7CAnuW+VuIqfOTFd36KwqoU93ADaBT2x5w
         hplQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgiXzr+rxGcRk0eumb7Z+6yb4mgrUzAQ2vkl+vkZfKsOrZjosxYMcXEPu7JgVfnOjgETcyLu1KV6TQbyBChw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVwH25R7yreozrtAEnpB1hbUYrHZfyMJoiNw7hCeJ3ihtgWys/
	pATSxFxwJ1b4h2RC/2bSptYyiUBd/A7OC4ZRMp1pekOHchwaASCClhLW/mVUDLO+JjM=
X-Gm-Gg: ASbGncsKEL3pdv99IuHG8qjUr6MzJyTsoJPr9dD64vWQcXsYc+m7E059G/rjI56DAga
	tOZqVoK4Rh1dMGhljC6CnhAS20vr3eYH4pmCYA7YBl/bbWyJI8JtW//qk2XSEkSwVs8X6IXPVdc
	hBmUgTRBozohzJLzElWNDjJNcfPEUW1hv4N/3AqH32PdEV+7j80otMn8TFzsGpiHVCJgw1e2/fF
	kQrJUI6gVArcG2/vkViNLjvWfTCPLtczqGaqkwcLixW3bVng814KaNN+9ISlPG9eME9sEFcqhxB
	NjJj1z9YRatAidxFH3NEQGv+UFCvHW7VgQ+Z+nkB9tK64YYrxTCUjUwUvCELMzgcB4C+5yk0Lxp
	WHj0A3BfTT683AkG3NYBMioEAyqrWDCX0Pp3CFvtkFhfubdeL5v903nHoglkeSHO49NX/pQLdUL
	2s12RgdmjVNawUq9dQNnAgi89ygVq+QiGGCkFDWuvvs80A7w==
X-Google-Smtp-Source: AGHT+IHXF8aSshQuB5/Ek/m7ZNdea55mrDFLUoj9f8fXcM0iJz+8lFQvs+tl2AYU+/PCS3RX8In6/Q==
X-Received: by 2002:a05:6102:32c4:b0:523:d0d7:b974 with SMTP id ada2fe7eead31-53d1678d391mr3391588137.31.1757445255066;
        Tue, 09 Sep 2025 12:14:15 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:9993:b0d6:8d71:ee9e:1ab7? ([2804:1b3:a7c1:9993:b0d6:8d71:ee9e:1ab7])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52af257c3e8sm11855090137.18.2025.09.09.12.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:14:14 -0700 (PDT)
Message-ID: <437ea968-d726-40c9-a833-08d94c5fe105@linaro.org>
Date: Tue, 9 Sep 2025 16:14:11 -0300
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
To: Florian Weimer <fweimer@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: libc-alpha@sourceware.org, John Ogness <john.ogness@linutronix.de>,
 linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>
References: <20250908163329.Qq79ujq_@linutronix.de>
 <4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
 <20250909073226.0qoHYZMo@linutronix.de>
 <lhubjnjbyt9.fsf@oldenburg.str.redhat.com>
 <20250909153758.JD5t64rY@linutronix.de>
 <lhubjnja8ng.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <lhubjnja8ng.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/09/25 13:32, Florian Weimer wrote:
> * Sebastian Andrzej Siewior:
> 
>>> Are there seccomp filters for PI futexes?  I wouldn't be surprised if
>>> people added them after some of the high-profile futex vulnerabilities.
>>> I think we should not support such seccomp filters, but we need to know
>>> what we are up against.
>>
>> I don't know. But don't you allow a syscall such a sys_futex and don't
>> filter additional arguments? Unless one would filter the op argument, it
>> shouldn't be an issue.
> 
> There's this historic example:
> 
>   Remove priority inheritance support for Futex in all Chrome policies,
>   including NaCl NonSFI
>   <https://issues.chromium.org/issues/40381864>
> 
> Some applications are exactly doing that, though, particularly for
> FUTEX_CMP_REQUEUE_PI.
> 
> Given how widely the Chromium sandbox code is used, I wonder if this is
> still an issue.
> 
>>>> There shouldn't be any error. There might be the case where the lock
>>>> owner is gone (ESRCH I believe) or the theoretical ENOMEM. ESRCH isn't
>>>> handled now but it can't be recognized either. It would require to kill
>>>> the thread owning the lock.
>>>> So either abort the operation if the futex-op returns an error because
>>>> "this shouldn't happen" or I don't know.
>>>
>>> ENOMEM needs to be reported to the caller because the application may
>>> want to react to it.
>>
>> Well. Right now it only checks ESRCH and EDEADLK. Everything else is
>> considered success.
>> So do want to update this + man-page?
> 
> The man page already mentions ENOMEM, it's just glibc that is buggy.
> 
>> But what should be done this pthread_cond_.*() functions? I guess we
>> can't forward that possible -ENOMEM to the caller?
> 
> Is this about the wait operation?  POSIX allows spurious wakeups, so we
> could technically return without an error.
> 
>> Also if we are in good mood, there pthread_mutex_lock() has this comment
>> |                 /* ESRCH can happen only for non-robust PI mutexes where
>> |                    the owner of the lock died.  */
>>
>> This is simply not true as far as the kernel goes. If the futex uaddr
>> contains a pid of a non-existing task then LOCK_PI will return ESRCH. A
>> simple testcase would be
>>
>> | #include <stdio.h>
>> | #include <pthread.h>
>> |
>> | static pthread_mutex_t l;
>> |
>> | static void *thread_code(void *arg)
>> | {
>> |         pthread_mutex_lock(&l);
>> |         return NULL;
>> | }
>> |
>> | int main(void)
>> | {
>> |         pthread_mutexattr_t attr;
>> |         pthread_t thread;
>> |         int ret;
>> |
>> |         ret = pthread_mutexattr_init(&attr);
>> |         ret |= pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
>> |         ret |= pthread_mutex_init(&l, &attr);
>> |         ret |= pthread_create(&thread, NULL, thread_code, NULL);
>> |         if (ret) {
>> |                 printf("->[%d] %d\n", __LINE__, ret);
>> |                 return 1;
>> |         }
>> |         pthread_join(thread, NULL);
>> |         ret = pthread_mutex_lock(&l);
>> |         printf("-> %d %m\n", ret);
>> |
>> |         return 0;
>> | }
>>
>> and strace says:
>> | futex(0x55afb0ceb080, FUTEX_LOCK_PI_PRIVATE, NULL) = -1 ESRCH (No such process)
>> | futex(0x7ffe73216f24, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, NULL, FUTEX_BITSET_MATCH_ANY
>>
>> the second futex() is the __futex_abstimed_wait64() that follows.
> 
> Does POSIX define what happens if a non-robust mutex is accessed again
> if a thread terminates without unlocking it first?  If yes, then this is
> indeed a problem.

Afaik this is UB for non-robust mutexes, although the resolution for Austin
Issue 755  [1] is not clear IMHO.

[1] https://www.austingroupbugs.net/view.php?id=755#c1875


