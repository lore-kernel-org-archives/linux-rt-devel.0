Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD419367F5C
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104813; cv=none; b=FaN8t9/O+bmxp0e4MrIe9rmcMivLENdf0W1u0YoqreHaP+S/oT37Vhb3l9tcTakmsyudNq3fFY8rPCYJOLoD7zlVDZ42/M/Ps1SU4EV5RDOPFKdoVk7fKzrLl3iyUlCNglQcDlcWEpuw4LgUt/scddKbbYZXU01y31WnY7AZNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104813; c=relaxed/simple;
	bh=OjA3HLzG1M2x2TrcfUcXoE1RQgPeJSDcIQZLH9zElHQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cgBWV0UUxTjNsiXEr0vSQicL/UpqE0+lfInLrScDW+LnaAPItJL9F0ni5ovllX6G4HSM+YRaLE/RfKd3yzbcfvlX1vsefBjl5pYFstMx/GLydXaCllvD/JIIM4zp3gYDb8VYG7XNexTMaMmH8S7lKfRAwavsxWGqQbEkgneN+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfIyL8jj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfIyL8jj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769104802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZLWX7Ttit3Pt1qm85Tbi244EW7S3psWz/a7zbS1I90=;
	b=EfIyL8jjGp4xUDTAEygL0coSOoCAJnbr1Q1fvKvOyKXuRVf3IbhUcifuaaJt4WlIrKyc7k
	Ldalk1+kc8WdaOgQJ08WTlmCVn5Tp1oU4cHBF7MyU4FyqKQ6/txKQl5cpqFGdklykqNxVi
	Y7eQA/WsNHcA8GRWP7WI1GZoYuB6O2g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-lfuAtuMxP8CJ_mFA6kcTNg-1; Thu, 22 Jan 2026 13:00:01 -0500
X-MC-Unique: lfuAtuMxP8CJ_mFA6kcTNg-1
X-Mimecast-MFC-AGG-ID: lfuAtuMxP8CJ_mFA6kcTNg_1769104800
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a241b5cdso209012185a.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 10:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104800; x=1769709600;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZLWX7Ttit3Pt1qm85Tbi244EW7S3psWz/a7zbS1I90=;
        b=dZpPg+2fvLcrSkJpQpc2J6Ryf8d4CccEmiMxchh0PyH6Z1IrykAV0HrEVKxKDdOCue
         0F/9fkDj1qLIbrCpGhMmx5otyEjVWZ7thKbZrfZ56VoX0pzxt1mkL1YBpXmwvw0yDyFj
         S00Ydv1VUzyY70VgRcSjAE4zVLvFGwKoWKOyvNnitVbIEsWwViXTRz7cPF7uh6B6bNTC
         KTcJHHUahPRopqIRK7DFtAhIv27DKL3XH+sBSn3ftpbUy75AY9KsguvWtgrHgNEy7bPz
         +uOx0FvCn+yY0S2orm+uh7PupJIrhCQwlI2T1UvkQVytTqca06NbdHn7VknPExnqP025
         /MeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVHU49dJQr1uBwWGemUhGEZ5mK+mToygvZNXXs3zI471y4h6H22JlrJPNwV7g6o2mCYmCtj4JGsJ127N7zhA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9LkBU3HUi8u08aMKSiOeoRqFs3kQzohLPXrb+/raqOvdxQnGp
	CjWyQowSoozfySLr/AjW24KcsefcJfqixT1LZPH+1qtDi5QoB+iIPcR5SrEGuIRc6QaNHpsmnuN
	ppuHP1S8gzbSAzolBp7mieL2mIP60WZPu5k3H21NKKs8/inZtj/E8Tp5gzCrHgutdZ54J
X-Gm-Gg: AZuq6aL7wpiAE++F+TPRphTN5f7HxVHhtLcxW4Q9tz7Avi7fzURkOH6M2J4fLiMhfZE
	bEpb8T890ejIaD/yKCctGIw5r0KhSe4R2Nq7tUYRZ+2ljlNrQQNGiix1Iyv/+G5L1LGwN+Pry4u
	6fKcDrgPP7JdX3LbrklygGundECbleyh14YNlYSPatf4+09nhuXB8uIluv2mGXzMJIH1eXXUqoP
	vlZEf+iTcXsfVIVAm7kYFca0xemfel7ns2uA4a/yFig3ktmNzBEMp1ocWdAcJjVp5wnghXdGeef
	QEfqENSo4pR6UvUDFbOQjwgV2I2uwy7o2CKfu+RrvXgicD/AUDSfTdPD6ZqhLJqJH96L+IE2Sd9
	XgD++PPXZaVxKvyvxP1QhKNI/JQtb2yMYlZiCfrWMaKmrFTl2im10tojx
X-Received: by 2002:a05:620a:1924:b0:89f:9693:2522 with SMTP id af79cd13be357-8c6e2e4ac7cmr34980385a.73.1769104800450;
        Thu, 22 Jan 2026 10:00:00 -0800 (PST)
X-Received: by 2002:a05:620a:1924:b0:89f:9693:2522 with SMTP id af79cd13be357-8c6e2e4ac7cmr34977385a.73.1769104800080;
        Thu, 22 Jan 2026 10:00:00 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6af506829sm1272959385a.37.2026.01.22.09.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:59:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0fcbb05f-fa7b-47a1-bd4a-d59f1e0ddc35@redhat.com>
Date: Thu, 22 Jan 2026 12:59:57 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mm_init: Don't call cond_resched() in
 deferred_init_memmap_chunk() if rcu_preempt_depth() set
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Waiman Long <llong@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Wei Yang <richard.weiyang@gmail.com>,
 David Hildenbrand <david@kernel.org>
References: <20260121191036.461389-1-longman@redhat.com>
 <20260121114330.6cd34b4732c7803f1720f0ba@linux-foundation.org>
 <0e385146-67a3-4fdd-b119-059caba8c5f0@redhat.com>
 <13d0b8b5-1ba7-4a3e-a686-13a7b993d471@paulmck-laptop>
 <20260122075747.uSLrSJez@linutronix.de>
In-Reply-To: <20260122075747.uSLrSJez@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: At9Wyk9o-tvC_QVyDlxGAAolzMN8o6CCG0HWDjhGiMo_1769104800
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/26 2:57 AM, Sebastian Andrzej Siewior wrote:
> On 2026-01-21 13:27:32 [-0800], Paul E. McKenney wrote:
>>>>> --- a/mm/mm_init.c
>>>>> +++ b/mm/mm_init.c
>>>>> @@ -2085,7 +2085,12 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>>>>>    			spfn = chunk_end;
>>>>> -			if (irqs_disabled())
>>>>> +			/*
>>>>> +			 * pgdat_resize_lock() only disables irqs in non-RT
>>>>> +			 * kernels but calls rcu_read_lock() in a PREEMPT_RT
>>>>> +			 * kernel.
>>>>> +			 */
>>>>> +			if (irqs_disabled() || rcu_preempt_depth())
>>>>>    				touch_nmi_watchdog();
>>>> rcu_preempt_depth() seems a fairly internal low-level thing - it's
>>>> rarely used.
> If you acquire a lock from time to time and you pass a bool the let the
> function below know whether scheduling is fine or not then it is
> obvious. If you choose to check for symptoms of an acquired lock then
> you have to use also the rarely used functions ;)
>
>>> That is true. Beside the scheduler, workqueue also use rcu_preempt_depth().
>>> This API is included in "include/linux/rcupdate.h" which is included
>>> directly or indirectly by many kernel files. So even though it is rarely
>>> used, but it is still a public API.
>> It is a bit tricky, for example, given a kernel built with both
>> CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_DYNAMIC=y, it will never
>> invoke touch_nmi_watchdog(), even if it really is in an RCU read-side
>> critical section.  This is because it was intended for lockdep-like use,
>> where (for example) you don't want to complain about sleeping in an RCU
>> read-side critical section unless you are 100% sure that you are in fact
>> in an RCU read-side critical section.
>>
>> Maybe something like this?
>>
>> 	if (irqs_disabled() || !IS_ENABLED(CONFIG_PREEMPT_RCU) || rcu_preempt_depth())
>> 		touch_nmi_watchdog();
> I don't understand the PREEMPT_NONE+DYNAMIC reasoning. irqs_disabled()
> should not be affected by this and rcu_preempt_depth() will be 0 for
> !CONFIG_PREEMPT_RCU so I don't think this is required.
>
>> This would *always* invoke touch_nmi_watchdog() for such kernels, which
>> might or might not be OK.
>>
>> I freely confesss that I am not sure which of these is appropriate in
>> this setting.
> What about a more straight forward and obvious approach?
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index fc2a6f1e518f1..0b283fd48b282 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2059,7 +2059,7 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
>    */
>   static unsigned long __init
>   deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> -			   struct zone *zone)
> +			   struct zone *zone, bool may_schedule)
>   {
>   	int nid = zone_to_nid(zone);
>   	unsigned long nr_pages = 0;
> @@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>   
>   			spfn = chunk_end;
>   
> -			if (irqs_disabled())
> -				touch_nmi_watchdog();
> -			else
> +			if (may_schedule)
>   				cond_resched();
> +			else
> +				touch_nmi_watchdog();
>   		}
>   	}
>   
> @@ -2101,7 +2101,7 @@ deferred_init_memmap_job(unsigned long start_pfn, unsigned long end_pfn,
>   {
>   	struct zone *zone = arg;
>   
> -	deferred_init_memmap_chunk(start_pfn, end_pfn, zone);
> +	deferred_init_memmap_chunk(start_pfn, end_pfn, zone, true);
>   }
>   
>   static unsigned int __init
> @@ -2216,7 +2216,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
>   	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);
>   	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
>   	     spfn = epfn, epfn += PAGES_PER_SECTION) {
> -		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
> +		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone, false);
>   	}
>   
>   	/*
>
> Wouldn't this work?

Yes, I think that is the better approach. I will post a v3 with change 
as Mike has no objection to it. Thanks!

Cheers,
Longman

