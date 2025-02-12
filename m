Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB70134A8
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367255; cv=none; b=HgXDJ/SOG7rVuNgIRBT7aVRKCtnFXPavHEHwjj9cQ+3Y1gocep9T/fH3nRxScF4H8gV4xJoM41tOjqnnjIHDj48+8Bg8zA2YVodR0AE9GY0rnPSKE/oLIqHhs/XjzQmYJBfzC8RTsU9CJcJCsSgBZ59L1GYtqTq16/Y2EcfZg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367255; c=relaxed/simple;
	bh=Ar3+UJm2+3Xl3Ikw4Q4JPTOxtaU6TTApmjDQC+jXAlU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e2/4Oqqm7m7D9jIa1Uif7ixPnva5lwdYgomn6a8oBgBYXKEic/wZ+wZNPmxv4zef3R8FzA1YQ1Br6xlZSEFy2yy8Azdq9gPuEefh3GCvo2qgPBY331v143CdnaUWPmO7QRwgJovOtz1XX4khCxcAuMaMSX42ote6uv+KuhTyw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/g9At4f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/g9At4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739367252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjHxnqTK7Tsl4746vRmLwJhugP3RFRR70bNvY/4d+hc=;
	b=K/g9At4fJuWwTduCRXpmuUuGHSQVbIWWazfJ5XCtXS+tJiwKXw+8WNaRy/K6rCyqRkAxVV
	tZzQa+1vW0L19XeKBGg0sf53LmuiNBMI05QFycklI0f0HSJYiFd1sYTh8tvgOEHJpA7d1y
	6eOdFBFy04nsgMh3DquZqMqb/12uT0E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-_bNU2BeJMz-lDmF2jqhETw-1; Wed, 12 Feb 2025 08:34:10 -0500
X-MC-Unique: _bNU2BeJMz-lDmF2jqhETw-1
X-Mimecast-MFC-AGG-ID: _bNU2BeJMz-lDmF2jqhETw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e65aca0e5cso735096d6.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 05:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367250; x=1739972050;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjHxnqTK7Tsl4746vRmLwJhugP3RFRR70bNvY/4d+hc=;
        b=qZf5vuG1fP6+8MjJcYVBYXSSVu5n9p8HS2a/XtOA2XZLyF4x3dr/ew6s9VJOzKoAzn
         DnczGG/MWBMHf/N+bjIKPtWhNDgi1Jnzk6zxpbfnZgwSEbM/hzuXOLLucrT6duWME/ip
         yEUd0yGuG7rhEc2qjgm1e6tiKKmkoFy2o+gfOkQodqUu3l+ulgqawglHp3OoEyr5cOqp
         Or8LUsKeLV9KQzk931nmUQnzResVuV4H7KOzpEmR1iC+6/Ppw25JsqT7U1tWGZNFvvRr
         mwOrmYgASNpXjeNADEIvco6M8QT6rq89DCPAzq+fv0VWpVIO1hSV1LQTT9JKFu9zPEzE
         LFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlBNW6Afx7m5VNWQ+fmtWk7tOYPuINALIqfETD+l0ZC7/Nj5NLM7pyUYV4fW4qmNOmEiYVn2zOL1vybjEqwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHhN2LkBSLcCZaND2u89sKxVdE5SoYDuZxWBcjKH+Ra+bK0mK2
	b8jxI5deSvavWLgvkuFkSslJxGlrYp49Xyfgo9W/RXQWrR6YpDMF0OR62AeNN0rPAmSliJHpw6O
	w3dRBCIsvyHEqRXwfHd1UL5+rgPkauLhug27zBMJO/FDNi4ZILkGHg6xUs26dhUc9
X-Gm-Gg: ASbGncscRJ2S9JiEadaVKNmIAY1GRjy4APFIuYmO+RGifCkvQnsy9IYdwkjU93kM+NR
	UBVXvDXByWZYZj0e11xcqv+4wJ4CkiPp9mGId+trc/IEd49KNYXEIa0nBoduaLgzfo+FLGYyPB9
	ZC9C4UVoTQhWRFyAhk7de6CazZZsMHMW5r0JXACo8qsKYucDbpinUvkuzIm1JtHtqBdrXFjQr1K
	pk3QvjDuLj1hmBvV0wpgI3blE6n0mU4ewe9JgMibm4CV1qpYFMZRrvmr6BQNAXtl2WVIHLIarsh
	g/xQdTkyiMewGCW6g5DN6HHg5Tm6JTAXSW4dv7r+y4BIkMn4
X-Received: by 2002:a05:6214:c42:b0:6d8:a9a6:83ef with SMTP id 6a1803df08f44-6e46f1da496mr49185526d6.20.1739367250389;
        Wed, 12 Feb 2025 05:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs0Pe9/V9TaL6+rhFjbdDu36BTL6SFLc78XicWOC9wyqy6n/fQPDTVqV0uazIlKcaI48DP+g==
X-Received: by 2002:a05:6214:c42:b0:6d8:a9a6:83ef with SMTP id 6a1803df08f44-6e46f1da496mr49184616d6.20.1739367249055;
        Wed, 12 Feb 2025 05:34:09 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e659e49ae1sm2715296d6.124.2025.02.12.05.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 05:34:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cfe70f31-e650-4033-9281-baa4cdc40b96@redhat.com>
Date: Wed, 12 Feb 2025 08:34:06 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
 <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
In-Reply-To: <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RAY6ufOKAZn3aIS4UsQMyR6d19xHbE0K75AdbtpoHJo_1739367250
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/12/25 6:59 AM, Andrey Ryabinin wrote:
> On Tue, Feb 11, 2025 at 5:08 PM Waiman Long <longman@redhat.com> wrote:
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 3fe77a360f1c..e1ee687966aa 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -398,9 +398,20 @@ static void print_address_description(void *addr, u8 tag,
>>                  pr_err("\n");
>>          }
>>
>> -       if (is_vmalloc_addr(addr)) {
>> -               struct vm_struct *va = find_vm_area(addr);
>> +       if (!is_vmalloc_addr(addr))
>> +               goto print_page;
>>
>> +       /*
>> +        * RT kernel cannot call find_vm_area() in atomic context.
>> +        * For !RT kernel, prevent spinlock_t inside raw_spinlock_t warning
>> +        * by raising wait-type to WAIT_SLEEP.
>> +        */
>> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>> +               struct vm_struct *va;
>> +
>> +               lock_map_acquire_try(&vmalloc_map);
>> +               va = find_vm_area(addr);
> Can we hide all this logic behind some function like
> kasan_find_vm_area() which would return NULL for -rt?
Sure. We can certainly do that.
>
>>                  if (va) {
>>                          pr_err("The buggy address belongs to the virtual mapping at\n"
>>                                 " [%px, %px) created by:\n"
>> @@ -410,8 +421,13 @@ static void print_address_description(void *addr, u8 tag,
>>
>>                          page = vmalloc_to_page(addr);
> Or does vmalloc_to_page() secretly take  some lock somewhere so we
> need to guard it with this 'vmalloc_map' too?
> So my suggestion above wouldn't be enough, if that's the case.

AFAICS, vmalloc_to_page() doesn't seem to take any lock.  Even if it 
takes another spinlock, it will still be under the vmalloc_map 
protection until lock_map_release() is called.

Cheers,
Longman

