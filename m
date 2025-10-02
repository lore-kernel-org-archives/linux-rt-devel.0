Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B026E709
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428677; cv=none; b=F6AETZLx2uuVRLQO1ThU3I8Ucf8yVFkHLen7P89HGgrfOgj5+CX4v/DM9oUl+ix1LRs21b2fbkcNDCw+PMrPn+zJNCQQQzaGegwZzdrcvUHAWkMpEtC1jcp/zxAwLdpstXCSE0dz53MZjzgI77iSoeczQFal3loU2GML+2wCZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428677; c=relaxed/simple;
	bh=/fvxDLX84RKzAlvxArYSUTdKHENkU+Sgw+KMtcjlpjY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hFHa6uPprxoSquKZLNwDvLXFC7/nU8wzK+bmDjQj6yOfCtOQKLWJhB0p4tejKTkxopvKjpyU3MVC346b9GKGoQB7Fro60pt976G81sFbpTw2INUeWszlFVAY/UTkUlUtRYKX6vkQyMq5bTGilUQ2pmWq7JEmqW+712G0sOEIWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJZKoKhS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJZKoKhS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759428675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/3VL778qVsrEG14dD8aS214ANjne650qKPHxRnv2Ro=;
	b=NJZKoKhS8dKdDKkZg5BXTG+LSt2YzyqGtuwp5fT4CF2Jdr2EvSh9L9JLVuD8yStaa5EXg5
	aF067JtTX3SAbwlQUlPJIASNWPBTRzHLWLRVmmV6+PtyOJTdLf3WE07Y02SCEwxXthfZpw
	0e/KX7PvoOKIiNgCumCXoAnPUCIoQHA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-w4Qd9-F2PSy4jHQmQ4ygNg-1; Thu, 02 Oct 2025 14:11:13 -0400
X-MC-Unique: w4Qd9-F2PSy4jHQmQ4ygNg-1
X-Mimecast-MFC-AGG-ID: w4Qd9-F2PSy4jHQmQ4ygNg_1759428673
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ddc5a484c9so32936521cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Oct 2025 11:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428673; x=1760033473;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/3VL778qVsrEG14dD8aS214ANjne650qKPHxRnv2Ro=;
        b=FH1NF1NP7Qhh1OTXU8aGdb3FSnCHE7f0Q83Cdc8tvlzZg24lybWRvklImAMqrC0kzJ
         gOHHdc3DcFoPI7eV2JCR1QwRjFvenwV8ilIOTImjvqA0xAijhdByX6JG0Bdb9E/LVHZH
         7gz7/g7faSolMwpBbKnMkE50qkcWQpl58tv0Cqd1MIw9slkDVSFVsZWL2JDkAjboWCwk
         Ov/0189M5PCnpUCiJ6xQL0q4BiwEtye35sWrHTKWX0/Kss04coRjno81K+pxzswL0UQb
         WTMFW/FuhKwd5qKZ3bOpYDYJi/nhXANfgTxkgnXblMSVkEL3/dgANjz97TVyubaRQ6VG
         WB4g==
X-Forwarded-Encrypted: i=1; AJvYcCXr83JpzA33ctg6tZ0Lbctu2SSNizL0yXLbEOnmg5yv2dIsDR32hdhmTU2po9mC6wWgUII9toy6LVTE0SAN1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX+NNXIpoH5IAtD/xxq+YbMigSEgq/Qa0EFMa0+TLIj0qwlasa
	04/GMgVq9Xal3SypVOxsumwEYgWZBz9Y96cWfgwEtypin46k1vDa+YyO2mbD66w1gjgifdfQpEE
	lIwqAg4Ax1RLhXxanUtc8oy/GilQZC0Wc1g20zs5MnPqqGhJL9ZjlBiXXKxI9+zOUQqMk
X-Gm-Gg: ASbGncsfwMjBkqgxKa72r7Q50OHbK8hL6iW+qEl7ubsc4AwcTulFTvrJXLPiTIJljGy
	a1+0yRy0ecz9GjMOP3W7v3hMN1tdRJGG3dfIuBo0x8gXSG9fhCeJUw2jJpRSjKUdepN99cmWc0X
	tym5Whzq1lVgE+wDDRdVRBZK353zT+TYx25GwQTZL2lzElu7UR2o1fcM8c7ytEguBzeLFdFxbxU
	3tiwEL46Nk2LYUmL4cIOfF5pvtgtPL6ghnA6Ts7/6J8XtV2Mhwkv8dpmt4Eo2eTwA3c+C92Guo7
	3/7PQD0VZNbPmlqHkkqobBwWn1kVEoGXXBA4PTXwAJcukCRThif5+34h+OJYIfhzBIMyvtlbU3P
	MT5SJYQIk8zdj0aNO
X-Received: by 2002:a05:622a:10f:b0:4d9:639:e9dc with SMTP id d75a77b69052e-4e576b4284fmr2889411cf.84.1759428673174;
        Thu, 02 Oct 2025 11:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpHLebwTF+3zLjEhXcm32FCiH8vMxE8GhuGHPClGlQ0YCiWQfMAgRAXQwNuIBsGTlPpdPySQ==
X-Received: by 2002:a05:622a:10f:b0:4d9:639:e9dc with SMTP id d75a77b69052e-4e576b4284fmr2888991cf.84.1759428672621;
        Thu, 02 Oct 2025 11:11:12 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777979704csm239935585a.50.2025.10.02.11.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 11:11:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <db316092-85c0-4cb6-9f85-5528a0bb7d65@redhat.com>
Date: Thu, 2 Oct 2025 14:11:10 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Tiffany Yang <ynaffit@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
References: <20251002052215.1433055-1-kuniyu@google.com>
 <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
In-Reply-To: <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 28C7UTy7pwYN4CBlqrC9Wh7IpmdQCR9xmnSyw0ip9tk_1759428673
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/25 4:28 AM, Michal Koutný wrote:
> Hello.
>
> Thanks for looking into this Kuniyuki.
>
> On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>> The writer side is under spin_lock_irq(), but the section is still
>> preemptible with CONFIG_PREEMPT_RT=y.
> I see similar construction in other places, e.g.
> 	mems_allowed_seq in set_mems_allowed
> 	period_seqcount in ioc_start_period
> 	pidmap_lock_seq in alloc_pid/pidfs_add_pid
> (where their outer lock becomes preemptible on PREEMPT_RT.)
>
>> Let's wrap the section with preempt_{disable,enable}_nested().
> Is it better to wrap them all (for CONFIG_PREEMPT_RT=y) or should they
> become seqlock_t on CONFIG_PREEMPT_RT=y?

Changing it to seqlock_t will introduce another lock that need to be 
handled. Alternatively, we can use seqcount_spinlock_t for freeze_seq 
for the current case and associate css_set_lock with the sequence count 
in seqcount_spinlock_init(). That should properly handle the case for 
PREEMPT_RT kernel.

Cheers,
Longman

