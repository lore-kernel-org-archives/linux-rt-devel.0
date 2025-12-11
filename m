Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B922F01
	for <linux-rt-devel@lists.linux.dev>; Thu, 11 Dec 2025 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765427426; cv=none; b=O4oxpQho9mA0sazbRoLjVFgT6e1i/n5HbE7XS5nl5x1fdst+hBFALGkILTt9+7o5NPQbzXWlrxw982Ir0lI3DlAZsqPB1jTGA+nohHaSqjF0RMtIgt3e+3MTDtiCg0nX9z0ThaITgfLaFkn2s3NQfJjT7oIZyyLmKa2SYyLrK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765427426; c=relaxed/simple;
	bh=rDnHUQF3r1AMgpCQHMiLzc+CG8b01utAlAq7nNbX9Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9dILBwmmp92EMFu98+CDhdp7zdHgS80GxmItF3koYuPYngWFP7oSDmyOvtlImKsuCpBrvxv/PtYcFHLkByNlWSXdVXKMSzGQ6fFVj3YWUgyfxqwA2fdtYQkwaK4zUClgUY2wJj5ERoZeS6HjHuhJ3zp1NfAy8maDWpHJp1ieiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297f6ccc890so767715ad.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 10 Dec 2025 20:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765427424; x=1766032224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWrfEXbTer8q/iRow+0KBLnEfp0JClsOz4Kq6E2txQg=;
        b=f8x7yRnIchrjtU35RwEHgcid1boCWcKGTHZpXKAorXhL1qNupu8TrUGG+Z+gMTuhOm
         GMx4g1zT0uIhSaQekfgAEMpNgGb6yPL3+KkcUh8U09poQhF4Elw7JeqzqSaErOz7CdVv
         B5WpggXQf3Hpa/X+C7d6Wqf8hP2hCUv9CMK9nctb03qWWnFUjcuAh/oJaJkHcRFAWuhi
         WjkeZKizjj3xSlqkfQA/UcY7zVNOvmIlGXAq6Fmw7wA3sGHJGpR3ky04VFnmRzkmEsYq
         ZPmvJviRcjejuPgR4+SUwc1FmoCVr7xAc8dRuUqfuSs7plhcZZ6jVjfMsT82GKGUk2Gk
         pYbg==
X-Forwarded-Encrypted: i=1; AJvYcCX7WvhvI4uBp4BbY7coZxpzH8pqoQHNcLWF/PJGn68ATn28H3ASISDnPmrJRZ5uL6WmKADTipY2T6aDWKCKEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGSiDD80NFjPi3gcV+A0bEpgJROTZP0aAutNkvR6QHjumhfWfX
	wZ9L+49thlUB5ZFgw/N0R6NN7WZzt1XOUIy9qmzMnZOCXmLvz6TzJqo5
X-Gm-Gg: AY/fxX4pz/dcxFRU6SxzEtBorD3ERDPEvXvU6ZdLFzDySbKiNcQNv7EKT4/gob8FY02
	QXi71BHJkOVLuocS6kfrx+6CdeqXcLwRj2axbffmk5OpaUpQAUhLBHtSNkL7aI5tokM9fBjGh+G
	vM6v6FQnV6qkrPXKJGgfeLx2oeziVqC4zSkZtv9WvGc4oG0gmwr3z10vwQYtd3BveaxIcUkWWIq
	9uwIc5LdmCYAMAuhvAznK9vr8PuiYBkMWfsHwZW9/YA91ZINR1DzIIOJt/WkVJnNR36Ma5vFLij
	7q62/kXrofTNJdwWMIyoOAiMFGJe67yMVqsf0aUEbHLfnl0gRmDY3t3WjlUg+RKtfhmYDuvJ0/j
	A8xBC0zV/AwvEyLCuI96UkN2ob64Nxifbmi59/C5ktdkdEFqvNr/yd+7NUmZmJqQTXB++jbW2EE
	YEy28W7jpq7I8lSiug603IFiu4YByqwHQKOLHP5KZshg909Vcn712lWFxSpW1st+yWTGxu+fwLv
	nyPIMMoNni5IWBo5eskwHOZZsji
X-Google-Smtp-Source: AGHT+IEirdSxhyq24x5EZ9HCnhoACWqzQOtyEPAGD1ap3jh6yhlTnLH7xQNRl16EpjTLAFvs4n4y5w==
X-Received: by 2002:a17:902:ef46:b0:297:e604:598 with SMTP id d9443c01a7336-29eed28c5e7mr9000815ad.4.1765427423825;
        Wed, 10 Dec 2025 20:30:23 -0800 (PST)
Received: from [10.200.7.226] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea043eefsm8685025ad.84.2025.12.10.20.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 20:30:23 -0800 (PST)
Message-ID: <53f17978-40e5-4b2e-b719-552612b0e775@kzalloc.com>
Date: Thu, 11 Dec 2025 13:30:19 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via RV
 (Runtime Verification) monitor rtapp:sleep
To: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rostedt@goodmis.org,
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <87fraslu9c.fsf@yellow.woof> <87jyz5kuf2.fsf@yellow.woof>
 <20251202112644.YUux4LKd@linutronix.de>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
In-Reply-To: <20251202112644.YUux4LKd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nam and Gabriele,

Thanks for the great presentation at LPC 2025.

I have a follow-up question during the Gabriele's Session RV and 
real-time properties, regarding spinlock behavior in atomic
contexts (IRQ/preempt disabled) on the PREEMPT_RT kernel.

On 12/2/25 20:26, Sebastian Andrzej Siewior wrote:
> On 2025-12-02 12:14:09 [+0100], Nam Cao wrote:
>>> RV is not a static checker, it is a run-time checker.
>>>
>>> Just in case you are not aware yet, there is also Smatch:
>>> https://github.com/error27/smatch. But I can't offer much help there.
>>
>> I was looking up something unrelated, and I found that Smatch does
>> detect this sleep-in-atomic problem:
>> https://staticthinking.wordpress.com/2024/05/24/sleeping-in-atomic-warnings/
>>
>> I'm not sure if its design takes PREEMPT_RT into consideration. But
>> seems worth having a look.
> 
> It does not look like it does. Judging from
> 	https://github.com/error27/smatch/blob/master/check_preempt_info.c
> 
> it increments the preempt-counter on preempt_disable() and spin_lock().
> So it won't yell at
> 	preempt_disable();
> 	spin_lock();
> 
> while CONFIG_DEBUG_ATOMIC_SLEEP would.

I specifically believe that RV can encompass the role of
CONFIG_DEBUG_ATOMIC_SLEEP and even go beyond it.

My reasoning is that even if a sleepable (PREEMPT_RT) spinlock is used 
within an IRQ/preemption disabled section, CONFIG_DEBUG_ATOMIC_SLEEP 
might not trigger a warning if scheduling does not actually occur (i.e., 
if there is no contention for that spinlock). This is because the actual 
debugging check happens in __might_resched().

Therefore, I think RV could catch these potential bugs that might
otherwise be missed. Is my understanding in the right direction?

>> Nam
> 
> Sebastian

I really appreciate Nam and Sebastian for sharing valuable insights on
static analysis tools again.

I recently discussed this with the Kernel CVE team, and Greg confirmed
that such usage (sleepable spinlocks in IRQ/preempt disabled sections)
is handled as a CVE.

I would appreciate your insights on this matter.

Best regards,
Yunseong Kim
