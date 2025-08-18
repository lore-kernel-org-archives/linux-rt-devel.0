Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070731AF27
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518069; cv=none; b=LjI/QuC6cDEiwg0gYlmSV7TgkkdQDVOXMSMI5IjbpNS8cUiuTk7AwuPFsD2bKP6w+F7VAxW3SjeChjuNBQi6xJTQonYyRxeznaikGMdmH2CAt6mF3t6T7NlE7cDLXxO/OxNo6RZ/+3cRjW0wKOg0Ck9cYYOx2RdfIrFcVscYWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518069; c=relaxed/simple;
	bh=/phsCS3I/nFd9s5kGe9o+G5yYz+VaOf1xq7h7J+KRIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWauGgZqCJHtTnzs7b/n6Aw2gt9M3SOFWlaLQKeLAshS/UWpkHKMPgsMEq4zN4GunXowkjF/Xe5zQwGVcPedarYoqXVdJsnhHBKAT6OTF6DRbuOTwPX41s15AkvLQtEPJpRL+il6aQSE9b8Xnp2E31pmH4dW21qnozHIuJstPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24458051ac6so6349375ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 04:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518066; x=1756122866;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j0UaOO8rZF+g3Zx9pBFamOuPKGjUnRi+oCF5jlGQSg=;
        b=D1kRHtBd/3wpW656fmWgN9qWH9yhgLY3ObY/j459MT22sFMDRdcDbkGsBR0HWIDFCN
         YIcn31kAWwh3GUzBS0pjlz+35NVv9+i/6F4Tq/Pa/MkHhrj8dAeyW5BNeTszjc0urUel
         uMW/f21EtjRKrQyAY3CUMcFClki3C/BkplnoK77uJf0GuBvJeWLQK4wXXAS0FdL9juRN
         Zwl1yZ8+SSjAKPFOUdy8ua2icBppgkKpTeoUN7Xzcu9rcH/o2oLVEo5anVpu/dTmpeO2
         1hHdrjY4d5o5nxdCFxGqFjfh9bxTUFs1RMSzgs8nI+xNnRaZo5g0ihJR/Sa7mB4NWmm+
         nLuw==
X-Forwarded-Encrypted: i=1; AJvYcCVhlsxDtnfJoEesaoUc1UCzSfuhp3/A7lTP7IF0TFh6BI3mZCYoirRBH7lC+p5j8Xoj0gb2SBXyP7hGzdBrDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdSMSQ9rauYolDC10dcNBY4YDi8wBgJHvmiLOlq4GIOt8esHeB
	OE2eoGP5bi9j3suKpRMgqqxtX+GWJa/Cy6vtBeOGfmpmyOOLstRi+8YP
X-Gm-Gg: ASbGncuvpBtl3fR2TjMf/1Qj+ZJ9NoMrikf2SxOUSpGtQVpbatoJMSVEUWYxvHFYOED
	lnoeIYe/lqjMAvGJCwK5KNq2hFea59lJbacAfpYxsxxat6OFCxB5VwsZOZYaAFF28yGalBt4PXG
	RKXUaXaSgyW+SydduiC2945TjgKW7e7oR8MHqj2njzEkz5RazPdbd5UcjVRlEFX1o+RJ6RzqPjC
	mZ2GsOd0NPb0LoJzIHj5c4MO9hoJSreMjZPx+coN95gOGARwybcnQYzrxz1qgk8aLEUAhJwu59h
	YNUx2KWrNjNto1Q4ChRfKr+ZfnYRePBPVISBlVpX7gIDOstaAo0ScM3EuOVry2oIbN06BN/TOyx
	pEYeIgk0D19e+OFZkJ2Avlt8mJ6brnscE
X-Google-Smtp-Source: AGHT+IHcawVAvSljzh8Pdv1UKq7clEV5BqQhmAWfnxLDkORzc+FbZeWfscwEo5htvUHiUGKek6i6fw==
X-Received: by 2002:a17:902:d488:b0:234:f1b5:6e9b with SMTP id d9443c01a7336-2446d6d4c76mr84107745ad.1.1755518066253;
        Mon, 18 Aug 2025 04:54:26 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331123409sm10860483a91.20.2025.08.18.04.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:54:25 -0700 (PDT)
Message-ID: <6450c5b4-b3cf-490f-ba7e-6201669829d9@kzalloc.com>
Date: Mon, 18 Aug 2025 20:54:21 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] md/raid5-ppl: Fix invalid context sleep in
 ppl_io_unit_finished() on PREEMPT_RT
To: Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 linux-raid@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250817113114.1335810-3-ysk@kzalloc.com>
 <acd0a040-18ce-05f5-4896-ad24dda6fb00@huaweicloud.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <acd0a040-18ce-05f5-4896-ad24dda6fb00@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yu,

On 8/18/25 9:56 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/17 19:31, Yunseong Kim 写道:
>> The function ppl_io_unit_finished() uses a local_irq_save()/spin_lock()
>> sequence. On a PREEMPT_RT enabled kernel, spin_lock() can sleep. Calling it
>> with interrupts disabled creates an atomic context where sleeping is
>> forbidden.
>>
> What? I believe spin_lock can never sleep.

I think you might have been a bit surprised by me sending a patch out of
the blue. It would be helpful to refer to the references below:

 On PREEMPT_RT kernels, these lock types are converted to sleeping locks:
  local_lock
  spinlock_t
  rwlock_t

Link: https://docs.kernel.org/locking/locktypes.html#sleeping-locks

>> Ensuring that the interrupt state is managed atomically with the lock
>> itself. The change is applied to both the 'log->io_list_lock' and
>> 'ppl_conf->no_mem_stripes_lock' critical sections within the function.
>>
>> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
>> ---
>>   drivers/md/raid5-ppl.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
>> index 56b234683ee6..650bd59ead72 100644
>> --- a/drivers/md/raid5-ppl.c
>> +++ b/drivers/md/raid5-ppl.c
>> @@ -553,15 +553,13 @@ static void ppl_io_unit_finished(struct ppl_io_unit *io)
>>         pr_debug("%s: seq: %llu\n", __func__, io->seq);
>>   -    local_irq_save(flags);
>> -
>> -    spin_lock(&log->io_list_lock);
>> +    spin_lock_irqsave(&log->io_list_lock, flags);

 The changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
 have a few implications. For example, on a non-PREEMPT_RT kernel the
 following code sequence works as expected:

 local_irq_disable();
 spin_lock(&lock);
 
 and is fully equivalent to:
 
 spin_lock_irq(&lock);
 
 Same applies to rwlock_t and the _irqsave() suffix variants.

Link: https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-rwlock-t


>>       list_del(&io->log_sibling);
>> -    spin_unlock(&log->io_list_lock);
>> +    spin_unlock_irqrestore(&log->io_list_lock, flags);
>>         mempool_free(io, &ppl_conf->io_pool);
>>   -    spin_lock(&ppl_conf->no_mem_stripes_lock);
>> +    spin_lock_irqsave(&ppl_conf->no_mem_stripes_lock, flags);
> 
> Please notice, local_irq_save + spin_lock is the same as
> spin_lock_irqsave, I don't think your changes have any functonal
> chagnes.

This issue has also been a problem in other subsystems, such as USB:

[BUG] usb: gadget: dummy_hcd: Sleeping function called from invalid
context in dummy_dequeue on PREEMPT_RT

Link: https://lore.kernel.org/lkml/20250816065933.EPwBJ0Sd@linutronix.de/t/#u

I am currently contributing to the kernel to address the areas that need to
adapt to this paradigm shift so that the PREEMPT_RT Linux kernel can be
well supported. I have CC’d other RT people so they can also review
this part.

> Thanks,
> Kuai

Thank you!

Yunseong
