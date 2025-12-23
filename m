Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40B2DAFA1
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Dec 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500321; cv=none; b=F/SUgnANgt61ok82VszEimqy0B1QmuoeXOnK3boKNZVDR6E7zm0tAGX4axf+tqgIuRBTTDEUwkhO8mKbBl3zhaJLMnELptSpNhlNatlvH6KtqnP/MzYxKQ5xlwkQb+dButymhwok1ww1OiNmF0EhKqXAgi1VQi40FKBDvDcunYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500321; c=relaxed/simple;
	bh=iCxNjgh2Jb2apyi67NCDapy5cpoy/aQmSir4jaW/WnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIcuA0AAGmcJkO+nVbaG+7gDAzZZYZrMPbDYKzp0jDGz1jwzNRDor0w4DhWrSXS8d6B3r4qEDje/B3ICcMKUZbrsL3t49m4psWkm5Y7rTMl6anL3EsBqRwFThjComE2qQpQOnJ6YDYy0L4kcNWN+qJ02I8XL3ttGsRgdQlDu3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34b3f61fd0cso418970a91.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 23 Dec 2025 06:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766500319; x=1767105119;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijJxP8v5AVEEgKb0/Y9mwcrJkwFTeayWUwFNsqY/b5Q=;
        b=LPfkDtehIAkS9MsZOY/sJnIsrH6SXk83UUazTugoVfkHqFMCXgKLX2LmgOeNNzimeS
         O/jpcPXKxe4d22AtKCNVrmg9QlZ4afFRVj23d0nyOzPQ8iVRcjqF0Xnf03k6Yflh0crO
         WYe1kP0ofNVAvrQr5pzkDdAl5jfrVP1Jm20RRP2lyWskdCUYpsBfiOBSmALkoClaPD/o
         oz6BTGeNSNEtIScO1KUnQbO42cNhm15utnhsczspNg5qfbZJdP0RcS5xuub4UFVrqYpa
         +/QmAR0vzsU+rM9KqWEf4X9ovXVtocG/dKNMrz6yb+UEn88gVPG+Z0Ur/XuaNytm12RM
         FO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+7ilbrvuGGad5KeGFbSmwAVGHUN76394sMtSa//gTMeeUKBSYIvvSO83UhcEaAlr5NYJgqA1MTnmx9u27sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCD/9yU8ynR1cxW0NbZjeLtZBB7NXrYgLs7R1/VV067VIbi8Mk
	ml7E2R8Up0+tdF3fkrQvKRc36/AC9un+SUw0PgE76F8mIBJ04x5skP0k
X-Gm-Gg: AY/fxX7n/gGfZ8XEqGjIfXyXEl+5GudiCix9OwD5J9Okv0udaZvv8m4tUo5dGEn4pNJ
	d6j3ab+kUD+S9Y63vbY/I5BLQ4LrcEv5UVrFL4Nd/UojfbvNUUfDSgWXZaX2mzdM/egbLmu2dFk
	k8C9PF0hcVGovEwIDNfuLacHEj3gGl5e8A4ewX2PAjAYQ8l+1Od2/oxt1Ad6GNhft0fcDfwsjXa
	Nr68Z9yD8ITJR7uZ/s+H/0oO/jJc2MZY57zIgxZPS25W0SfG41sDv8w1WBIwhNm1etLs8WKnUfJ
	61yKs5EaafzTvSAey7X6rUYzAS1YaXY5SOmv9CPIcnsXepOZB2Si8IO1PwbMb0f3izXd5RtTxGf
	WOD4CSgCX1kTkkb6nhiHKYD5SZSRJqIZ8K9pRw/ipaezHFtW+XtTxAY4z690LqJJajkWYCcA+fA
	7Ech1NPTz5oblWELVoNAC+XQ9fsBkL2qSGG2Vch7zBYIwZh5YkeEshcER9296c2mxbFLCJgrqud
	nQXWUHzYPma04A=
X-Google-Smtp-Source: AGHT+IF76wK9lhAOxM/G4Y8ZDMLkkU0FNMLgoYkfxF60ieay2Upp5vjmOPdV+zrwjsOwmn7mDb+sYw==
X-Received: by 2002:a17:90b:3f86:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-34e921c1ab2mr9629255a91.5.1766500319409;
        Tue, 23 Dec 2025 06:31:59 -0800 (PST)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7af2b60bsm14069542b3a.15.2025.12.23.06.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 06:31:59 -0800 (PST)
Message-ID: <92a7c013-0676-4c81-867f-b55c69a1edd6@kzalloc.com>
Date: Tue, 23 Dec 2025 23:31:54 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via RV
 (Runtime Verification) monitor rtapp:sleep
To: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rostedt@goodmis.org,
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <87fraslu9c.fsf@yellow.woof> <87jyz5kuf2.fsf@yellow.woof>
 <20251202112644.YUux4LKd@linutronix.de>
 <53f17978-40e5-4b2e-b719-552612b0e775@kzalloc.com>
 <871pl1y3oh.fsf@yellow.woof>
 <0d06ce4c-6ff2-401a-90d9-5a4dfd2abebb@kzalloc.com>
 <ee8474631ce309539918e17b60e4ca150327115d.camel@redhat.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <ee8474631ce309539918e17b60e4ca150327115d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gabriele,

Thanks for the follow-up and for taking the time to double-check the
configuration details.

On 12/22/25 4:40 PM, Gabriele Monaco wrote:
> On Thu, 2025-12-11 at 16:58 +0900, Yunseong Kim wrote:
>> I am currently considering how to model this to cover cases that go 
>> beyond what CONFIG_DEBUG_ATOMIC_SLEEP covers.
>>
>> My specific concern is about custom functions where might_sleep() might 
>> be missing. In such cases, if the code hits a fast path (no scheduling),
>> CONFIG_DEBUG_ATOMIC_SLEEP won't trigger. I'm wondering if RV can detect
>> these potential bugs.
> 
> Hi Yunseong,
> 
> I finally got to reflect a bit more on this.
> As we discussed at LPC, RV wouldn't help with not annotated functions because
> you'd need to add tracepoints there, so probably the best is to just add a
> might_sleep and be done with it.

Thanks for your insight! I agree that for unannotated functions, adding
might_sleep() directly is the most straightforward approach.

I will also double-check sleepable memory allocations in the context of
PREEMPT_RT kernels to see if there are other patterns being missed.

> Other than that, I double checked and CONFIG_DEBUG_ATOMIC_SLEEP is in fact
> disabled on non-debug kernels in Fedora/RHEL (and I presume also in Debian and
> friends), so the other concern you raised is indeed valid.

I agree that CONFIG_DEBUG_ATOMIC_SLEEP covers most cases, but as you
pointed out, the fact that it's disabled in production kernels (Fedora,
RHEL, Debian, Ubuntu etc.) gives this approach real-world value. I was
hesitant about whether this was worth a contribution, so I truly appreciate
your encouraging feedback.

> Although perhaps rather unlikely, I'm not sure we can completely rule out cases
> in which non-debug kernel (where several other debugging features besides
> CONFIG_DEBUG_ATOMIC_SLEEP are disabled) behave differently enough for some bugs,
> otherwise invisible on debug kernels, to pop up.
> 
> Another use could be debugging kernel modules on non-debug kernels, perhaps to
> avoid some other debug features to be present while still relying on the
> packaged kernel.
> 
> For this to work you'd need to add a tracepoint on might_sleep when
> CONFIG_DEBUG_ATOMIC_SLEEP is disabled (and it's currently a NOP), hopefully that
> wouldn't make people too angry.

My interest in this arose because I've been seeing these legacy patterns
consistently reported as bugs in the Real-Time (PREEMPT_RT) kernel. It
seems many kernel developers are still unaware that these patterns are
problematic, partly because some older Linux learning materials actually
recommended them. This makes it quite likely that such code will continue
to find its way into the upstream.

> Again, none of this would be ground-breaking but it doesn't look useless either.
> 
> Any thoughts?

I will keep looking into more meaningful contributions for RV. For instance,
I’ve been considering a monitor to detect excessive memory compaction issues
under specific workloads, which I’ve encountered during kernel development.

> Thanks,
> Gabriele

It was a great pleasure discussing these ideas with you and Nam. I sorry
for any lack of clarity in my previous explanations during LPC 25.

Thanks again for your insights! :)

Best regards,
Yunseong
