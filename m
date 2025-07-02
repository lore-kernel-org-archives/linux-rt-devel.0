Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C22D46D1
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Jul 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471264; cv=none; b=OeTYvwyLpjWs3R1xFlyozJFIoG47yqv3pJjEtSs3WjGLufm3tz1vTj+JR8r+2DGd0stqV9Rwr8Ex2F072ptDIqla8tzN7ZeBnDNTFbclvkdG94Mt4c3/r1/NmTwcyfPyDshMpQeOpNLyxAVVTFWrmMJBdjOlbADq6OshKfVmXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471264; c=relaxed/simple;
	bh=IECqy1n9vDysW/RzHb6Mf8qqQgPCCqgFmtKFE1V6L0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM1aJQ4eJ1pAUSg6Zp7OJm3eHEDYBrZC99Pcpfe1qDHF3xwdLpWTWEwnBxhPlgfCwd4T9yMT7yd169EU0vgejmiWwNgXAaIVKF5q6J28q6g5D6Hft2I5GL4SK2As/Ge5yU+9rYzgsR0A2HXxKreUStaleYiC8WjnSJvV/gIhTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5g58Xqx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5g58Xqx"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553cbe3e77dso1209935e87.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 02 Jul 2025 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751471261; x=1752076061; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dg0qjgsbd25kQ2WMiX3ztjtV7rTNZWqsHlNRU5eCd2k=;
        b=B5g58XqxHgMXKmFGrmMy4r/pYrPaIjoMAMqYpar4obb9/k5PZEJGobIs7/HIYFe0QW
         BHl46MjyqjLzn4QmH2miE59euoQhG4UYLB6JiRDtRulynAaOHfF6HlyJoABfJJEHj29N
         qQ5xMtiG4toDbH++5ZP2tEqbBJoBqmEdR875f6Pe+9U2955wf4JKEqH6Q0XJ09A8+ApP
         z3HAqwfb6Q89QUOvaE9FTPGfhyb/q/uX0q/8KXgSHrpmux5fX3GxXyiuCmCKSWch8sgF
         aLynGKeclwD6IST1eoiG3W51Pye5XrQqYHtZMWPmpSRMHAldFr6Q+mg6kPdAWxTfoJ2J
         YuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471261; x=1752076061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg0qjgsbd25kQ2WMiX3ztjtV7rTNZWqsHlNRU5eCd2k=;
        b=E00yyoNuZC5vsw7UWCZ2kS29MZQE1f2HtMn/NnIFV346IfL7JCaYlmRvI9otFZL82/
         zNL9yNoYFGk3hQcCf9yMOEtmGrF6Zmkx9mhHtnPl0YUOD+aX7SxsdfiSrlPDsoBsJ8a5
         rJdDBEGwSewKoanszt7RAaHcNbxJUnf+toARbbH7SENeb6yHUTB6R7ZvYAirdmvYNx/K
         LP1JJZCVqhMtMwCZ2anhzc8VsMaaNO8IJNy9jHf7PTCoTobcK9crnqK0lkEewfVUyFYu
         W1wVNDfoiIEb+u26Z4ktqLH8sHHHa7SQvGjRCV+ltB9FjtFvrWfDFTs88c9yw88frRj4
         7xQA==
X-Forwarded-Encrypted: i=1; AJvYcCUR/12xtvFSpZkw8i0Matp51Ja5PVRh0vlz6O9Jqyv9GMtgFxdpjTOiTpl0QDmuUqpA/UZVRjrHly8EEXDu0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN5XwxzcBBB/byu/0Tb8kVvYFJ5btDIAVrgfMDz12SJGHRSMpc
	8+mA6+84fD5RXz9eogRuz9US5oYynW1qRwWfb5DdQ4wmRx/jEPYOdA1g
X-Gm-Gg: ASbGncsPp201HvYEMsIzH29E+/YJXEEDNzssSVI0Jy1kNTLS7WqgGhS5TrPvPI3EFKZ
	8NMAkJ51998/x3/gyaOo2oZP6itdV144S+mf7eLwsX9lOFLwBBBq5oprqpanOViajEv2xPzvTtS
	zymLDWye7+qKH4xodbj1heLhFbSu5F4OnsWhWxFMf/U7mdud7UZ+kKwCqIl5MmRh1FLifqN+6dW
	jj4dBJA2r1n87RIgKr0hMqZALctGBenWRW7VjjZk0ymUH1Ksyi7d3a0l5FW56gJPCBrbP1rJ47o
	P0d7Ujkma07oGCBU1wrckzQwL3W03hmCTq6qafMF5U6ntth+nAlHs1ELQMi0xWytCQdhepKIhaC
	nYkI=
X-Google-Smtp-Source: AGHT+IHio6wfWnZlK4Mo3609S6+5VtjeT/3ln1hTQpayl9k1KGIhzopKfzGQ6qBGtftk0/WnBOd/qQ==
X-Received: by 2002:a05:6512:3191:b0:553:6514:669e with SMTP id 2adb3069b0e04-556282950d5mr421178e87.14.1751471260535;
        Wed, 02 Jul 2025 08:47:40 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2eec3dsm2160750e87.242.2025.07.02.08.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 08:47:40 -0700 (PDT)
Message-ID: <4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com>
Date: Wed, 2 Jul 2025 17:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
To: Yeoreum Yun <yeoreum.yun@arm.com>, glider@google.com,
 andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
 akpm@linux-foundation.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, byungchul@sk.com, max.byungchul.park@gmail.com
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, nd@arm.com,
 Yunseong Kim <ysk@kzalloc.com>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250701203545.216719-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/25 10:35 PM, Yeoreum Yun wrote:

FYI some of email addresses in CC look corrupted, e.g. "kpm@linux-foundation.org", "nd@arm.com"

> In below senario, kasan causes deadlock while reporting vm area informaion:
> 
> CPU0                                CPU1
> vmalloc();
>  alloc_vmap_area();
>   spin_lock(&vn->busy.lock)
>                                     spin_lock_bh(&some_lock);
>    <interrupt occurs>
>    <in softirq>
>    spin_lock(&some_lock);
>                                     <access invalid address>
>                                     kasan_report();
>                                      print_report();
>                                       print_address_description();
>                                        kasan_find_vm_area();
>                                         find_vm_area();
>                                          spin_lock(&vn->busy.lock) // deadlock!
> 
...

> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 8357e1a33699..61c590e8005e 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -387,7 +387,7 @@ static inline struct vm_struct *kasan_find_vm_area(void *addr)
>  	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>  	struct vm_struct *va;
> 
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_interrupt())

in_interrupt() returns true if BH disabled, so this indeed should avoid the deadlock.
However, it seems we have similar problem with 'spin_lock_irq[save](&some_lock)' case and
in_interrupt() check doesn't fix it.

And adding irqs_disabled() check wouldn't make sense because print_report() always
 runs with irqs disabled.

I see no obvious way to fix this rather than remove find_vm_area() call completely and just
print less info.

