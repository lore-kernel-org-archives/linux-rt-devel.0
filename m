Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA13A89A0
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115414; cv=none; b=WaR4yacl1zjsziy2fd7DWJCco7O92nRTb/xX3QauqdACJb5esTz51KlxZX9hN4bPKOoXL1g7snkHoHaXwOixvjFD6i6WRItR9Y+wz+ZyvvJQU88LTdaZ6prK7fSR6MQ6PmFbk+6EaROIgCEVObnGrF1Q/CB8BHQWrtcHhsk+1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115414; c=relaxed/simple;
	bh=m3DhzaE30l9dpwUfX8p1dcbp9NVDN/RB8RDRCa5Dqak=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hJ5UQqFzXj2YtHnPmarRt8hL72CUPtfPaNlrN/62NNcwQa6WRtDheGg9mNqzkoE9/D8BwriphVmcUkR6glVEokUE4T+J5pf0Lp6Gef1RRnxOo0jIzFQLtRlcrfM7d2Dce75HpRXfVUdEQI3A7iA1YumyxZjY/UrGXHfJYCQkrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCbaaACP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCbaaACP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769115405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGuem69rerO7TvMKhZx4BKhxoFushL0GwwCO3214nuc=;
	b=LCbaaACPzBECfWXlGpYneYEiwlV01GSnwK+q6LNZbGxY71YvK4A1qF5JzVFazfQBPQhrGC
	Gbvm6iK9vl5/7Yhh7qEbHS3w/C7Au0pYS3IdHeB/usYstX5oEAcjfjcyCogvz3U5x+/8PI
	5aXKwMjC21oQZ8fEndotxYgcQYaIm6A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-N2Tj82TgN1Snb_72mIz2wg-1; Thu, 22 Jan 2026 15:56:42 -0500
X-MC-Unique: N2Tj82TgN1Snb_72mIz2wg-1
X-Mimecast-MFC-AGG-ID: N2Tj82TgN1Snb_72mIz2wg_1769115402
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50147745917so57132371cf.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 12:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769115402; x=1769720202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGuem69rerO7TvMKhZx4BKhxoFushL0GwwCO3214nuc=;
        b=FBi95H0Ivw6zLHWLhb1b9CoPXNxwC7GyEOEpZQF4k3fhqbd6arQc5a57tLcWl/EHi0
         NLD//xwEt9cM4XH5k24J4VIUlV44IOrLAieTjT5ZQVhEY3lLOf6BbDd74hfSGxNSG83S
         mGAtYG9tkaac5wZei2pShJ6OZzUhF59lvckRL+pqIvlskNiWWHShYKIRBAJAKpWdNyNA
         ZVJ+Yh32MCaLlxIAh02Vg6646P18NGqsch+/U5r5aP4dyHPzD8MsbnMcU/xLBFw64bjX
         dDwaIE+jumumsxOcUFOgZH2AkgzystdoqyEm7T0tPHIUt4oNsLC3O4DBHfYETjoEqslp
         jc1A==
X-Forwarded-Encrypted: i=1; AJvYcCUEkhP9ASsW+lRuTAdNhCQBEnCcfokVJrA/R+m+CfUOoirKls6ylTvgTrDo9rIyxzm15OeluXdAELh3KkhDOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz66fm7KFzBXfwfHD7NBQFlhuCw0hnu7jsUzaRAgMHODT4gSC/p
	8tDQXAH7xi/FT6H/Kf4Ftn39qbHhF8JyFXRIWdihZZmT1YGc3c984hRsuXg+JG0cE2Vnr+ec0V0
	PRv0LHyPAaVO7O1rHiYx7e3Rs/uwpF3H7ry6Mdtf3dJHJ4wPDXFcw6f/3odQ/JDhXzN+f
X-Gm-Gg: AZuq6aIX4h1/Yge9CUArlXjox3R6fbgEpcUw/qugyUoOZJzJ0y6PDplzcUynHkqdZOb
	22AQ0/6+/06z1cJYA+8RoTLCOIm7NSJe7RiJdHSzOeuEub7pNUMJLubcCjLNdaYf69nycPgX3VO
	Mzzp4fyRYHiJiofvS8Sa4yhJAt6wYUUUxyqgXuQYTAQwO4QPcnLsTzUK8Cf0MTebXthg+0Lzygn
	AckeN1wTkD5/WO2k9160boPRgQaTOfmZ9VnMaki4OVD6DanZeNB+S7+Duuy7wH2x8vHwh+TVIaB
	Gk3p9Zp+eZv9gJCAPey1ywwqBaYt42HXGrnZBJH3caceV7MoYATGHwWGZc626fYBCRMXLd9WWXq
	ElC5kfp5YPi59S9wFBESJaQlAN1PNg/iZLWok14ycSBIXn3gb5Q+haIgV
X-Received: by 2002:a05:622a:1988:b0:4ff:971b:4cba with SMTP id d75a77b69052e-502f7724947mr14758911cf.14.1769115402067;
        Thu, 22 Jan 2026 12:56:42 -0800 (PST)
X-Received: by 2002:a05:622a:1988:b0:4ff:971b:4cba with SMTP id d75a77b69052e-502f7724947mr14758581cf.14.1769115401684;
        Thu, 22 Jan 2026 12:56:41 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f724d2sm2586161cf.20.2026.01.22.12.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 12:56:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <87d0eae3-e16e-4820-adde-afb519c5dcfc@redhat.com>
Date: Thu, 22 Jan 2026 15:56:39 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/mm_init: Don't cond_resched() in
 deferred_init_memmap_chunk() if called from deferred_grow_zone()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Wei Yang <richard.weiyang@gmail.com>,
 David Hildenbrand <david@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20260122184343.546627-1-longman@redhat.com>
 <20260122112920.2b435873a0cc5f396df5d1a7@linux-foundation.org>
In-Reply-To: <20260122112920.2b435873a0cc5f396df5d1a7@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9YvvLhu7NQWxglDE0ZI7OpQXW97CyktpZCpmq-BqliI_1769115402
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/26 2:29 PM, Andrew Morton wrote:
> On Thu, 22 Jan 2026 13:43:43 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> Commit 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk()
>> in deferred_grow_zone()") made deferred_grow_zone() call
>> deferred_init_memmap_chunk() within a pgdat_resize_lock() critical
>> section with irqs disabled.
>>
>> It did check for irqs_disabled() in
>> deferred_init_memmap_chunk() to avoid calling cond_resched(). For a
>> PREEMPT_RT kernel build, however, spin_lock_irqsave() does not disable
>> interrupt but rcu_read_lock() is called. This leads to the following
>> bug report.
>>
>>    BUG: sleeping function called from invalid context at mm/mm_init.c:2091
>>    in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
>>    preempt_count: 0, expected: 0
>>
>> @@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>>   
>>   			spfn = chunk_end;
>>   
>> -			if (irqs_disabled())
>> -				touch_nmi_watchdog();
>> -			else
>> +			if (can_resched)
>>   				cond_resched();
>> +			else
>> +				touch_nmi_watchdog();
>>   		}
>>   	}
> Disables the cond_resched() in some situations.  Can this reintroduce
> the watchdog warnings which that cond_resched() was intended to
> prevent?
cond_resched() is disabled only when it is called from 
deferred_grow_zone() where a spinlock was acquired with irqs disabled in 
the case of non-RT kernel and in a rcu_read_lock() acquired with RT 
kernel. In either case, scheduling out should not be allowed or 
something bad may happen. I suppose that iterating of pfn's in 
deferred_grow_zone() requires pgdat_resize_lock() protection.

>
> The cond_resched() was added by <dig, dig> da97f2d56bbd ("mm: call
> cond_resched() from deferred_init_memmap()").
>
> Pasha's 2020 patch replaced touch_nmi_watchdog() with cond_resched() to
> prevent RCU stall warnings.  So I think the answer to my question is
> yes, going back to touch_nmi_watchdog() could reintroduce those RCU
> warnings.

deferred_init_memmap() will  still have cond_resched() called in the 
iteration loop. It had RCU stall problem before without cond_resched() 
because it needs to iterate all the available memory which can takes a 
long time if we are talking about TBs of memory.

For deferred_grow_zone(), as long as the number of pfn's that are 
iterated are not huge, RCU stall warning shouldn't happen.

Cheers,
Longman

