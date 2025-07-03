Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB6134CB
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Jul 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562732; cv=none; b=Bx8ST/ohCaxznk3I6JpgLCnZ8otYrXSP19lRyu7CCFgEzY9ng6FfHZxRh7DfvqqrUlMLcpTK8+AfsW5tmlGJ3pekF++pSx6VFFY/7m3Eg0b93FELoXYYi9Rx76g/uptrRX8mfRzqYQm9pNugJTmcudNaAzj7UD3LwKv5slYD+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562732; c=relaxed/simple;
	bh=Y+5PBjp3L+A/0PWkGIZorEGSdIsFWG49/tCq8S+8KQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfK8pOBFqH8vRoCNBFnGIX64ovrJ8sZhk4NbGQaAf7SsFQ98ioq0aGEw1wGzMTQ0jrUXm2ioGkpO36uVlbzIm1g+oWV9DqPbWxQy+iTFUJpGhIRspkTcUcq8dCNzDbk/VeguZBDSjOgn98KTolTmm4DCiJA6Vjle4KY55m8rem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJl3VwlJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJl3VwlJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553bcf41429so12403e87.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 03 Jul 2025 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751562729; x=1752167529; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JHsACmNVQDqMzth3zHYUx+TIWM589NbxHC9P7ivfVY=;
        b=EJl3VwlJuKZl9DcrmLE/wG+X8nuv+AnxXKpvvvhfJ+aIcm2FwMgCCSmi8jddZj/Hvr
         ris8R2rEgpO9Bac7idpzvvyI2Yy9/v/XWaYaNHGebW/mUKfXAYmG0gf/OmOu7W9d3PDL
         6bxdAVej9laYrupXjtBqp4FPrpUkN+jH4NFRtobX5+0WpRCCOVnXdkPAWTQi61v98EsI
         umBYj69K/Jgm66KGDDDF68txI1iP+RaluPiYs+2zxyzToiHRHJBuS4myiMXsEPmfDtIS
         FfYlDSrbB3l0aZUyS/DW0LRBpIW2MoX8gZQcW2P1gNetYCnEApeRAf9W6Sn+x4L5xN/k
         mT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751562729; x=1752167529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JHsACmNVQDqMzth3zHYUx+TIWM589NbxHC9P7ivfVY=;
        b=jGaOIeNd9sL5nBNvNXzXMm3njmCOlsOEhpQc5ZFLc9xLtQnUcxGlCdgwYXgGHT7cDo
         IfaV+1w3DOjnAguj13iHHeIR5op6o2pBo9aRCqMbRm+yiEMk9vzQesOadIDiA6RCUvIe
         5B/KPqBluelWceuqUf/T5OOXYUXHcEA+gyJWZPVQiWc8/UrksSvmOr+SXBPHBHEXqYtN
         sEkEhrMOxlgAZGfBhMHxzD7abHDw4DMrcidOeeQqUfc4Ufo/mi5AbaEVcqLLpj2rHgkY
         9nfTpPPbZHxDivlcbXpDd6WBena8ybZ1SQHSUbnUXW/6GZPv+lx6eWWRPjoMp4WBAsfV
         vfJg==
X-Forwarded-Encrypted: i=1; AJvYcCXHZF9Qqsc1ubZtx30XKHa6f2kQ40ONWen8NqpZBOinDHWlPWEo4usYyIm2MlTItZRpqZiwKALVmer8SVkQ4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXJgT7fjCbPBVZ4eNrEDjR0Plxu38/a48qqneWDz464Zt8IPLi
	PYkGVPHdfNoG2FIkTwYhedo7BqVmBEbS6Atz7Ys+y3VZvZec5L9hDvFf
X-Gm-Gg: ASbGncva4k5JwMa64EyRmBMUoD48ZddcRKqxWXOVzv6TealoCd2NlNT/C5N7i4zI1xe
	+NWaJwQx166Q90P29lMskDRWOP90zlJsYHJkTN9IGTFQmkys0+JKXmLnedNcXX1fHvXa0nqW2yL
	HV9GHx8TUgFj3Wuc0re3bswzlowUsstkHfws7Y0Q7pNQeoVwS7A4fbNYbFIVFh9MWkiBYHBxifm
	id+e55XZ7X3CQIROARLajlkhKzu00VrVch1TFYCxK4Udn2qn3e8sOAkSZ0yDzjndoeeVSZcM91w
	6ZwA02yvyjwYONTndpX/cCx/kzrID1VAc7n3+bGPJcZ6u4fLnPqzrhJU5v50BQFIee8Z
X-Google-Smtp-Source: AGHT+IHSUdgs8rkjr+uLDoqm0WJNQiSMXBB+h8aK0WD+wavVOnlqZxsO6zfCCjPgM4KKxosilHQWvA==
X-Received: by 2002:a05:6512:3ba6:b0:553:a2a2:21b6 with SMTP id 2adb3069b0e04-55632c86b8bmr327098e87.4.1751562728608;
        Thu, 03 Jul 2025 10:12:08 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384a9e43sm24902e87.173.2025.07.03.10.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 10:12:07 -0700 (PDT)
Message-ID: <1a7f32a8-16ff-406c-9542-8d2ad628d7f4@gmail.com>
Date: Thu, 3 Jul 2025 19:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, akpm@linux-foundation.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, byungchul@sk.com,
 max.byungchul.park@gmail.com, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Yunseong Kim <ysk@kzalloc.com>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
 <4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com>
 <aGVYoEueYjoC1hQh@e129823.arm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <aGVYoEueYjoC1hQh@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/25 6:04 PM, Yeoreum Yun wrote:
> Hi Andrey,
> 
>>
>> FYI some of email addresses in CC look corrupted, e.g. "kpm@linux-foundation.org", "nd@arm.com"
> 
> Sorry and Thanks to let me know :)
> 
>>
>>> In below senario, kasan causes deadlock while reporting vm area informaion:
>>>
>>> CPU0                                CPU1
>>> vmalloc();
>>>  alloc_vmap_area();
>>>   spin_lock(&vn->busy.lock)
>>>                                     spin_lock_bh(&some_lock);
>>>    <interrupt occurs>
>>>    <in softirq>
>>>    spin_lock(&some_lock);
>>>                                     <access invalid address>
>>>                                     kasan_report();
>>>                                      print_report();
>>>                                       print_address_description();
>>>                                        kasan_find_vm_area();
>>>                                         find_vm_area();
>>>                                          spin_lock(&vn->busy.lock) // deadlock!
>>>
>> ...
>>
>>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>>> index 8357e1a33699..61c590e8005e 100644
>>> --- a/mm/kasan/report.c
>>> +++ b/mm/kasan/report.c
>>> @@ -387,7 +387,7 @@ static inline struct vm_struct *kasan_find_vm_area(void *addr)
>>>  	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>>>  	struct vm_struct *va;
>>>
>>> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_interrupt())
>>
>> in_interrupt() returns true if BH disabled, so this indeed should avoid the deadlock.
>> However, it seems we have similar problem with 'spin_lock_irq[save](&some_lock)' case and
>> in_interrupt() check doesn't fix it.
>> And adding irqs_disabled() check wouldn't make sense because print_report() always
>>  runs with irqs disabled.
>> I see no obvious way to fix this rather than remove find_vm_area() call completely and just
>> print less info.
> 
> Right. unless there is API -- find_vm_area() with spin_trylock(),
> kasan_find_vm_area() should be removed.
> 
> But, I'm not sure adding the new API used only bv kasan is better then
> just remove kasan_find_vm_area().
> 
> Do you have any idea for this?
> 

I'd say the info from vm_struct is nice to have, but it's not essential for debugging.
It's probably not worth trying to keep it, so I'd vote for for removing kasan_find_vm_area().


> Thanks.
> 
> --
> Sincerely,
> Yeoreum Yun

