Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD721FF44
	for <linux-rt-devel@lists.linux.dev>; Fri,  1 Aug 2025 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754086008; cv=none; b=NIwYcSUrIBqCLx42BnQgCF3ShrQswBklBl5ZJ2daekbXezlQ088D50C6EcDLU8wDI4GZ1Dl7XGNlW0dC3DZ3nCVlgSjJT9Dfwz2O1xWgaGv14sAlKXcXbkrBEIAF7wTVdreu9aqj2U8szhVtaCrryAmoEtyZo8qo8tM23G0jEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754086008; c=relaxed/simple;
	bh=ZltjpFSnN2A6MCKEllpU7lv7jCbFdpKQWqCcPTkW4R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1JCimyAsJh3ikXz34R9HhnnWvPiSSWsrwWlK2gqX+8maApDWwoJDL4/HYaVLD/5POGq+M6xCqs8WvqDENfzvkLT5baaulCQDXC5U063pnc+k0+WoY4aMh/y2tTjYgEZsHK/Q83+eXoqBl81aMIxO3Fc7c6nubF1LfeK0N7x8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-240240f1478so4793985ad.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 01 Aug 2025 15:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754086006; x=1754690806;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGMI5UFLAL8h+XrJLA1qy7vAWgjKkChdeP7O9TQ3ZSg=;
        b=GM2A3PTw35c6urhFdCjWhVIYcFhuJnMbthNv3uSk0suX/DHYatdSOcK1p/jnzozrnj
         s6wk5mgonyXcovIyUMDLYgDuGuHTC/3L79myidW7FYF/WeALRd3S3VKRlyLiOGsBzm+V
         /9NTrb/OXlIVlAUWq5fqjysszBlyRPttca0HCGuRL9oMY8hAxWs0YtJAYrcGtZdCCM3m
         cjGV/2fE7Ce71trU6DnxaJqF+cHJfcfHH5yDjIUnA2/8+mCDOv7SaHY4lFvb1V5fQd+1
         McRPSLjqDJzrP8ct5qjOuJf7x465v5whu9HiiLgctI52RfatZUYdQ7e/niMVTV7Qr+hl
         XqxA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0bx82M/rsLP4gim1UA+LaWwiHjslQJFEV72Zivh5+TPuJgg2K4rKsImgZf5G2FLK0pFhWCVKgwM+NYqdtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxeg3TGym42RDol1rC1nE0Hn7pZMpGcxUwSias6XwWs9BsLsnPW
	7SXKt/e27N/6QEn5lfJchU8PCEt106i38yUzy2olRDuKOq9lxDzndQI7
X-Gm-Gg: ASbGncs2XDRr3GmbJKiT8JoW8Squ882Gfk2hu7bk5TturuWKhR6ey7qyNO6WAOqA6bS
	rQgwqkN1w6DO/XAPZdoVMBQUZp4gZyIa4p8hvvoF/HSeGz9JLV7dUUx2pHilxvRk3wzOY2tBhsZ
	BW6RG9QtElqhWGtSLGnlH5na3/sliRfYj2CjBdes+Q6R/lHDQWXrytMNerk75aAohYbsFNqrgvh
	w66tkznbHRWgkAhFzlcH8eEeoMLJY2EgdewZaUJ/wLbjYKT6vrIF4UIM7cAq2GezeZsT7ZlG97l
	oeI63J+EXNEd0BnW9EFj/Q68FYECFQDlRtEWysfc0O5NxmBWsgEufWWaJE6vqQe3rKnyzGtcTwU
	5bik/qbYwC7bMhloVXKkVU+wA6Y2Gr0+t
X-Google-Smtp-Source: AGHT+IEAXTkTyBkkZYD4R916cckUDfUr/XXYQMRwRWE4wJM7FlBkmpZyjC7daXSA6NIjb9GvKXDLFQ==
X-Received: by 2002:a17:90b:38cf:b0:31f:23f0:2df8 with SMTP id 98e67ed59e1d1-321162c7222mr590990a91.6.1754086005463;
        Fri, 01 Aug 2025 15:06:45 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32115948a74sm827193a91.4.2025.08.01.15.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 15:06:45 -0700 (PDT)
Message-ID: <4834c0cf-b0e8-49c8-a13b-27c80921a03d@kzalloc.com>
Date: Sat, 2 Aug 2025 07:06:39 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
To: Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Byungchul Park <byungchul@sk.com>,
 max.byungchul.park@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>,
 Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, stable@vger.kernel.org,
 kasan-dev@googlegroups.com, syzkaller@googlegroups.com,
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <2025072615-espresso-grandson-d510@gregkh>
 <77c582ad-471e-49b1-98f8-0addf2ca2bbb@I-love.SAKURA.ne.jp>
 <2025072614-molehill-sequel-3aff@gregkh> <87ldobp3gu.ffs@tglx>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <87ldobp3gu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Huge thanks to everyone for the feedback!

While working on earlier patches, running syzkaller on PREEMPT_RT uncovered
numerous sleep-in-atomic-context bugs and other synchronization issues unique to
that environment. This highlighted the need to address these problems.

On 7/26/25 8:59 오후, Thomas Gleixner wrote:
> On Sat, Jul 26 2025 at 09:59, Greg Kroah-Hartman wrote:
>> On Sat, Jul 26, 2025 at 04:44:42PM +0900, Tetsuo Handa wrote:
>>> static void __usb_hcd_giveback_urb(struct urb *urb)
>>> {
>>>   (...snipped...)
>>>   kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum) {
>>>     if (in_serving_softirq()) {
>>>       local_irq_save(flags); // calling local_irq_save() is wrong if CONFIG_PREEMPT_RT=y
>>>       kcov_remote_start_usb(id) {
>>>         kcov_remote_start(id) {
>>>           kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id)) {
>>>             (...snipped...)
>>>             local_lock_irqsave(&kcov_percpu_data.lock, flags) {
>>>               __local_lock_irqsave(lock, flags) {
>>>                 #ifndef CONFIG_PREEMPT_RT
>>>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L125
>>>                 #else
>>>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L235 // not calling local_irq_save(flags)
>>>                 #endif
> 
> Right, it does not invoke local_irq_save(flags), but it takes the
> underlying lock, which means it prevents reentrance.
> 
>> Ok, but then how does the big comment section for
>> kcov_remote_start_usb_softirq() work, where it explicitly states:
>>
>>  * 2. Disables interrupts for the duration of the coverage collection section.
>>  *    This allows avoiding nested remote coverage collection sections in the
>>  *    softirq context (a softirq might occur during the execution of a work in
>>  *    the BH workqueue, which runs with in_serving_softirq() > 0).
>>  *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
>>  *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
>>  *    the middle of its remote coverage collection section, and the interrupt
>>  *    handler might invoke __usb_hcd_giveback_urb() again.
>>
>>
>> You are removing half of this function entirely, which feels very wrong
>> to me as any sort of solution, as you have just said that all of that
>> documentation entry is now not needed.
> 
> I'm not so sure because kcov_percpu_data.lock is only held within
> kcov_remote_start() and kcov_remote_stop(), but the above comment
> suggests that the whole section needs to be serialized.
> 
> Though I'm not a KCOV wizard and might be completely wrong here.
> 
> If the whole section is required to be serialized, then this need
> another local lock in kcov_percpu_data to work correctly on RT.
> 
> Thanks,
> 
>         tglx

After receiving comments from maintainers, I realized that my initial patch set
wasn't heading in the right direction.


It seems that the following two patches conflict on PREEMPT_RT kernels:

1. kcov: replace local_irq_save() with a local_lock_t
   Link: https://github.com/torvalds/linux/commit/d5d2c51f1e5f
2. kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
   Link: https://github.com/torvalds/linux/commit/f85d39dd7ed8


My current approach involves:

* Removing the existing 'kcov_percpu_data.lock'
* Converting 'kcov->lock' and 'kcov_remote_lock' to raw spinlocks
* Relocating the kmalloc call for kcov_remote_add() outside kcov_ioctl_locked(),
  as GFP_ATOMIC allocations can potentially sleep under PREEMPT_RT.
  : As expected from further testing, keeping the GFP_ATOMIC allocation inside
  kcov_remote_add() still leads to sleep in atomic context.

This approach allows us to keep Andrey’s patch d5d2c51f1e5f while making
modifications as Sebastian suggested in his commit f85d39dd7ed8 message,
which I found particularly insightful and full of helpful hints.

The work I'm doing on PATCH v2 involves a number of changes, and I would truly
appreciate any critical feedback. I'm always happy to hear insights!


Best regards,
Yunseong Kim
