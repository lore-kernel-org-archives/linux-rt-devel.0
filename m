Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AF2045B6
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Feb 2025 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415638; cv=none; b=TiOwwmwdNU65DSqnnFx9CNlDyvHbTdAhc6LPmYRW+yFL7tyYzXJj9n8qDcs8GXiPBJFCjZfGCYl6TgQumA0LRIBu0w0kZVLzIV4x/i9LRKCuuwtUmeehI9lCrsn0go4CpRDFEtAddzlChWlCiUL9B8KWVZV+m5N91i8Cigxk0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415638; c=relaxed/simple;
	bh=CDg75yNWrOAs+yCPL9HuRHn/Y610P8WBA57CoIkJnLE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UMN6S18riDl+GeLjnD6t07BWHWWK5zlGo/3F3lauCOmlv2HGFxfA7txFHkeg70MpOdmj8LvrDEAjcY1iRz4HZ/GsuA9opBvSY+4JqUPx0npPXuEZO5mw2JkMVKsZL5+SR8/CQJozxTdttBHwYHA/BuoTDVbRI9R74fEcAn3iQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkEz32xr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkEz32xr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739415635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWwww+9wjYnmYiIoosHtl2D22JscWljOY5A6wHcnvOU=;
	b=RkEz32xrD0G4MMYe9zS110cilHLa8JxtdgyaY9djcMpzxS21pA5MhGkTiLQEfmkF0bIOfA
	eMCbRdwsC3CwiPOy1ThIc2ukR/zhw5C/hTc+fmQJErtEqUDS9NJYBJxMk/6MP1i+272Fdg
	xmGrR9Qjog29AgnNEKB3oKNwPUkiopY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-PbrMl1i9MDSFbz0qzlGM_A-1; Wed, 12 Feb 2025 22:00:32 -0500
X-MC-Unique: PbrMl1i9MDSFbz0qzlGM_A-1
X-Mimecast-MFC-AGG-ID: PbrMl1i9MDSFbz0qzlGM_A
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c07bba1575so53539785a.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 19:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739415632; x=1740020432;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWwww+9wjYnmYiIoosHtl2D22JscWljOY5A6wHcnvOU=;
        b=NEHbZCun+ewMe6FwIMo9DESf8czv5z+cs5aeHMi7LNy7vaUXei6OxGCOp55bLkMAZR
         oIWpOK8he++7v95ojYojMGO/w2niUiNOjfX13nOGzrj6RcjXFFJxwgBgeor0DaRccV1P
         0CItZh3Mlcz2OaX9JxTCRdGk9NjAa/+osS2l3ZJdrFWYXunMRr4jS8bFCP3iONiI+xxH
         YlsIjG+chqQjVLmriTO0jsMJM3vHaxfFcQn+9KqWVJAisUy/WeqMvz8U+nTKNafUs30r
         Gs7oSeb8UHaLSlfI6ZisRa5j/2uoqOVaMjHmS3tWKbjVR3RPCOv7SxU4rdpQo1LHn1Tz
         9u2w==
X-Forwarded-Encrypted: i=1; AJvYcCVG+m3kfAogDoCigluqMYLUbj7CLHgwpFNAGDJjWSQzPd/t0X7ONbDOf0510xIg9WL3FdWcrKGusKmC19ioVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgtpsI7wXl3lmjMk0zUhztQnw1XeRwNlsKvT+5uMdHbI8E8slf
	XN871ZJyTCfVQ2bn7T35WirkrpBDOvEeV4WGSMLdVnQSxZkBGAmcnw0qZjJe3cy2dodxsZFXSKI
	CCmydxMegSzmuthSfH+9z6yAx5MriOXop7O77rTeRKKqR3GmOlQ2PGpp2JDvmhyCA
X-Gm-Gg: ASbGncsXb46pDekjqPJhdscM50GMMxAqQZUpqb8HSqWL0Q9Xh6U47E5c0fHkbDuzwkZ
	yau6LyQ9vkyCJVO1RO/NkhcWTtbH8QG5KKsi5HmpWhp7HrJBX/TYCCTCeOt1Ug/rqzRfMiaOOkf
	iQZHC3oAFYgFXa/FgWkxQ02rufU/lFcMxeMRey94Lf4/lHKZFA+BAr38jsxY4LAMXnhbNG5AwkO
	mmyU+/4ppMNNiFyCPQjUOPbULim8bf7CGs/jj682PleAKqHrdkj1U+3o7GnQ+/cA2GCV+3BkUaz
	747YT34IiotqqbSuwWwySfV88kq4+IG3nuFbtnqHymJSyYZK
X-Received: by 2002:a05:620a:4154:b0:7b6:e47a:8e1d with SMTP id af79cd13be357-7c07a14eca8mr288913485a.31.1739415631956;
        Wed, 12 Feb 2025 19:00:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrPdXEC7uKTGrnTsRzg3yFpGic5d9M8ugrhFeLTyhpIMQ12jCFsEbrGCa3smwHMxU+LwNpWQ==
X-Received: by 2002:a05:620a:4154:b0:7b6:e47a:8e1d with SMTP id af79cd13be357-7c07a14eca8mr288908485a.31.1739415631630;
        Wed, 12 Feb 2025 19:00:31 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c608269sm26919485a.31.2025.02.12.19.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 19:00:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b9fdff48-da6a-4190-addb-acb948ea9ad7@redhat.com>
Date: Wed, 12 Feb 2025 22:00:29 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: Don't call find_vm_area() in RT kernel
To: Andrey Konovalov <andreyknvl@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250212162151.1599059-1-longman@redhat.com>
 <CA+fCnZdbW1Y8gsMhMtKxYZz3W6+CeovOVsi+DZbWsFTE2VNPbA@mail.gmail.com>
In-Reply-To: <CA+fCnZdbW1Y8gsMhMtKxYZz3W6+CeovOVsi+DZbWsFTE2VNPbA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O46zMAE1N-f5CJf_XAUfZKzjcmJUrYqbe-cUU88rQVY_1739415632
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/25 8:48 PM, Andrey Konovalov wrote:
> On Wed, Feb 12, 2025 at 5:22 PM Waiman Long <longman@redhat.com> wrote:
>> The following bug report appeared with a test run in a RT debug kernel.
>>
>> [ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> [ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
>> [ 3359.353853] preempt_count: 1, expected: 0
>>    :
>> [ 3359.353933] Call trace:
>>    :
>> [ 3359.353955]  rt_spin_lock+0x70/0x140
>> [ 3359.353959]  find_vmap_area+0x84/0x168
>> [ 3359.353963]  find_vm_area+0x1c/0x50
>> [ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
>> [ 3359.353972]  print_report+0x108/0x1f8
>> [ 3359.353976]  kasan_report+0x90/0xc8
>> [ 3359.353980]  __asan_load1+0x60/0x70
>>
>> Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
>> changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
>> The print_address_description() function is called with report_lock
>> acquired and interrupt disabled.  However, the find_vm_area() function
>> still needs to acquire a spinlock_t which becomes a sleeping lock in
>> the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
>> changing report_lock to a raw_spinlock_t is not enough to completely
>> solve this RT kernel problem.
>>
>> Fix this bug report by skipping the find_vm_area() call in this case
>> and just print out the address as is.
>>
>> For !RT kernel, follow the example set in commit 0cce06ba859a
>> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
>> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
>> inside raw_spinlock_t warning.
> Would it be possible to get lockdep to allow taking spinlock_t inside
> raw_spinlock_t instead of annotating the callers for the !RT case? Or
> is this a rare thing for this to be allowed on !RT?

Lockdep currently issues warnings for taking spinlock_t inside 
raw_spinlock_t because it is not allowed in RT. Test coverage of RT 
kernels is likely less than !RT kernel and so less bug of this kind will 
be caught. By making !RT doing the same check, we increase coverage. 
However, we do allow override in the !RT case, but it has to be done on 
a case-by-case basis.

Currently we only do that for debugging code, not the code that will be 
used in production kernel yet.

Cheers,
Longman

