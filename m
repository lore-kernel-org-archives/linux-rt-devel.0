Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7C38DDB
	for <linux-rt-devel@lists.linux.dev>; Fri,  4 Jul 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634558; cv=none; b=e9Q5deo1NVpwmILYhWGHDLpwSowPb175lKkZTzrWtB96v3QbJL1xu59BvLApB3dssb7EHvHGRXd/WVU0PvVMzvYP9iPGdJ9MxXWL2XQ9lIQ0T8gfXVw+uWg5IYREUVvOPPhxtiQ7LgMt6+DSYrgkngNJHXvLN/rhi6rjM9DDikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634558; c=relaxed/simple;
	bh=Ta9oBCAhubod8prwYsmUDErfCxhu2NU7MOvICvUcjz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg2sB76GOkTt0YT8yzahQdd8wHJye9t7owVCY6o44c6IKCnNZKoUYa2+hOswJuWimst1C6T6TZPacoMiQE9t1WQnXPZfOFPhIVmVsUPRy9l+sxgcF8HUxwky6GH8W1tePds2yM8qIR5cuhaiosli75E3JjMK5y4TlmbplMGp+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqG2zJPq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqG2zJPq"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553d27801b4so38517e87.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 04 Jul 2025 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634555; x=1752239355; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPT/Yn9IyO9lNhZMkeKSyj5/KPjAxsknNyMSqLYzrPY=;
        b=IqG2zJPqKn7nY5+o0h+o/WFkqNg0hVjqdUeFS/R2wEN/c+TQnz72qCsmgpKBCSrLJx
         xZiW1edJrVDbg5PgdeIOpIVgRCE2ldWGHd9+RFz5dYLkZc0owe3Hn9hnZe30oh6lNuti
         XXnZmgentWDny0OFFoACOrMvBwREPYwSJNvH8KKJ4Qv44atYF1KA0wpp+O9mM0Eo0v7Z
         HBaaKun3k8qGKbuYpQmsugNETc9N38OL4t3MWlS93wbjiRilp/IFtbW1t+HhD6XLE/od
         XPw64OqiFTFgYD9XLeCRKylhRo1dtQyn1E0Be+nxYH6HVgoECIgCyuZvmJgMOZAL21iQ
         JuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634555; x=1752239355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPT/Yn9IyO9lNhZMkeKSyj5/KPjAxsknNyMSqLYzrPY=;
        b=BuHa6H0b/xQHJUD32a57jZS4XrqaDrcEt9VMpvV95eWwWfl+OvKOaW4GisudHItoSe
         BzSfNkuanxD9kfbXH71vXwNobnIoasUksvZYOsI618o/YcMV28R5aA/Hm2NfIFzF0WTY
         nr0mTBpc3wt7e7XRFbsT8ve0+ZEk2UILDeqQJi52TOPItw/qeo09t/WlcYOwTw3cmnAa
         9WdTlmbqp59b9XHpWVjaHMusBhC1EJqF68rnD9gHMrbqpVBa56Dpdn6yDs0nbS4Zbdt7
         8hNlK5thyZFp+jyGXhUTxVQaVaEDJr5ntX91OgX+EEL4RlUL+fE6oUP4/usEi7c5Y3He
         6seQ==
X-Forwarded-Encrypted: i=1; AJvYcCXufmesk8BHDPGwh1DwuJZ0RNpgNU4mM071kepttoHlXYdnzQE7esZ3/2wqXFSknABgKFl4bkRtCDb4LUw2wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yymrv36HObZNSWjLj8ZtZQJhpwoapnLXVcE8AfG5b41QToFqJI5
	ajocN3+gnXr3CbkcCufDUyibVMo/JJ9okRcwR+1JfQFmLwqVpm9K8/7x
X-Gm-Gg: ASbGncv5crqS9fL13t0tpfwfW0VLYLFQpFfOELtmI84vOIKf7elq4H57Qq6nnz+r7xG
	UXqokTM8CiHzfkvmO/c6lADR6xnS8cz+URCVRtQ1B+i3G7Fndoswn+SkNrDWYEMoNneGx/GC5nI
	Fx6tFLCSM6WvtGnbyTew9QDnRNavJDOytzig5JU4wv+/Ow335Sy9hfh2JyZ0gUo3iNSh/G7BTNp
	AnQEA1NXIrYw2Ec+fQjwRn39FgZBdj0o75D4D4k8kbRnwDRiliQ5H0F3VRvdD3R39NHcOgriaos
	Ifyw2W1bfOMImpU7+9uwRFxl9oEFIsPaitxohgome4QcfxpT7bsdP5x9fPJSnA1JY4g6b19NDcB
	rPxw=
X-Google-Smtp-Source: AGHT+IHGkSf7b6gCzmikSMHbOGCPLDngVVQXuVASyhJ3m7+Ta9yHqoizqWxSIsu1KXw9T4avAiQtfA==
X-Received: by 2002:a05:6512:2247:b0:549:8c32:78ea with SMTP id 2adb3069b0e04-556f3db2bb9mr271494e87.7.1751634554993;
        Fri, 04 Jul 2025 06:09:14 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383bb14bsm246405e87.16.2025.07.04.06.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 06:09:13 -0700 (PDT)
Message-ID: <b32229f0-0702-4047-9e71-e3d6ed85f0bf@gmail.com>
Date: Fri, 4 Jul 2025 15:07:54 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible
 deadlock
To: Andrey Konovalov <andreyknvl@gmail.com>, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
 akpm@linux-foundation.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, byungchul@sk.com, max.byungchul.park@gmail.com,
 ysk@kzalloc.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZeL4KQJYg=yozG7Tr9JA=d+pMFHag_dkPUT=06khjz4xA@mail.gmail.com>
 <aGbSCG2B6464Lfz7@e129823.arm.com>
 <CA+fCnZfq570HfXpS1LLUVm0sHXW+rpkSOMLVzafZ2q_ogha47g@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CA+fCnZfq570HfXpS1LLUVm0sHXW+rpkSOMLVzafZ2q_ogha47g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/3/25 9:05 PM, Andrey Konovalov wrote:
> On Thu, Jul 3, 2025 at 8:55 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>>
>> Hi Andrey,
>>
>>>>
>>>> find_vm_area() couldn't be called in atomic_context.
>>>> If find_vm_area() is called to reports vm area information,
>>>> kasan can trigger deadlock like:
>>>>
>>>> CPU0                                CPU1
>>>> vmalloc();
>>>>  alloc_vmap_area();
>>>>   spin_lock(&vn->busy.lock)
>>>>                                     spin_lock_bh(&some_lock);
>>>>    <interrupt occurs>
>>>>    <in softirq>
>>>>    spin_lock(&some_lock);
>>>>                                     <access invalid address>
>>>>                                     kasan_report();
>>>>                                      print_report();
>>>>                                       print_address_description();
>>>>                                        kasan_find_vm_area();
>>>>                                         find_vm_area();
>>>>                                          spin_lock(&vn->busy.lock) // deadlock!
>>>>
>>>> To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
>>>
>>> Can we keep it for when we are in_task()?
>>
>> We couldn't do. since when kasan_find_vm_area() is called,
>> the report_lock is grabbed with irq disabled.
>>
>> Please check discuss with Andrey Ryabinin:
>>   https://lore.kernel.org/all/4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com/
> 
> That was about checking for !in_interrupt(), but I believe checking
> for in_task() is different? But I'm not an expert on these checks.

The problem is that CPU1 grabs '&vn->busy.lock' after the '&some_lock'. This could
happen both in task and in irq contexts, so the in_task() guard just won't change anything.



