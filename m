Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909C297A7D
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 May 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302931; cv=none; b=ux33Qt3Xlu9OP88UeK81pqbdQ+x45NI3fszwR7Y2C2uLIPqz8NS6zghZKxlhDtTqY+BCIaiZwN9a6vMmbY07aCNGnZ+vS+nLhOlwdFKIVc2Hzahy7hA25ViOEShwQvF1r8EigbqJ3FYDFpQjGX7m+CG2KUFd9T86UALOylyUZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302931; c=relaxed/simple;
	bh=5U6gtE5DKJs+3iz70q0Fs++Wgk0JBNMWol2ZQLojvHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVGhz0vKvyCF25nv7Gdg1YEjSvxEI6ACL2TB0gtQdhGQzxA9GFB1xzdemn+RMxlD4gn/CNVnWZ/G9TTEP6bb7iSgHvBhMcVAI4L6qk5hoiSwRtpRHAL+519GL7Qv4voBnqGrWr1zB7SBjzrErn4VEFSXztblF762p652Wz0HyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnSf+BX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnSf+BX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747302928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiz6ndGJFjTghJ7XdcRmJq3QP9TYb8f/oaZ3mhqnyAI=;
	b=TnSf+BX7fFQsFAjfmwU6PYfLSniyR/WEhnAAxIxkMvwBvhhrvA5ZECKxMlkI/85xRObqza
	dkwwirf8bAchzX0K045EHo4uENjPzhv9iFuCxSSOLVtgYDcRbKQlfjBrT2zyiUowEwysR1
	s5REbGUZCJRaDzOntC5QJpE3RCuTtlE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-UfwD2AFmPU6DNNsouY9geQ-1; Thu, 15 May 2025 05:55:26 -0400
X-MC-Unique: UfwD2AFmPU6DNNsouY9geQ-1
X-Mimecast-MFC-AGG-ID: UfwD2AFmPU6DNNsouY9geQ_1747302926
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a0af6219a5so420881f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 May 2025 02:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747302925; x=1747907725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiz6ndGJFjTghJ7XdcRmJq3QP9TYb8f/oaZ3mhqnyAI=;
        b=rsuJP2mQ7nQK8EDA2ij6pp9pIt55/L/4+rzVu0DZwO7jcTg6OyuWBtq39yM6xqu5CA
         BsFLjIXbV1Dh6R41jL+Ced8KrEFedOedGzE5ljJM6KNYvTl1l7svTdOqJe62l5JavKJ0
         Dj/jsmL9wpeuk9EOzbJ3OyXiw/7yvUVI7/l4fzWf52GmLnpZQfPm3sEoVef8L1EDwAhZ
         /fT9LBA0nesTthv8yxoAZaDHGZUXxNEFSVWcIWSVkBieAcAEWplVVI0CtSeusxuiSSYZ
         +OBCkA+rZcSTLdUWY42CJaZVr2KEBAWWcrD/6a/ZqNDFeBVTJcP3tthKIY3eiiOzw68G
         c0/A==
X-Forwarded-Encrypted: i=1; AJvYcCUnWfTwirqAfB74jolrUWOqL79+9cE2R/FEZxPBM02eaSPVRjmMj+tYsFMQIeFlHAwkIPUqz686xy0uzt/V4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ1w5EXSPuuyHv7NDKQ0VsO/NwAkAaDwxBlFOmwQ5FmIe3UT2e
	D96fN3V8WdcpOE+abLghhaJR+THZ2NllHGMyNgDq0UT6TnUf2uRaWbUrNP9v+fBSAhBtgQ+43zG
	p+OFpPU5Ndj7q8VZ9vpTK4rkVjjQyPxTLQe0Q/BVHzfZDsVsh9bPgQJylyOK09eF/nqvb
X-Gm-Gg: ASbGncvC2v1PlyjRh9MDwFsVkRhEWZvKvQbNiiK+rNbiNUHflJUO9tE5KBET0kShyIV
	kdRv2slQG5fzokESm2sedXs2igHsPeUiy59sXGEtK4WFNIcTXHFVZgvbFyKVCF0floxnqDe+wXw
	o9LwE4k3qOTRJ7IGyIgis/KAhvtMBKWTryyncsUmch6bJ1IvOtcZZi5Ud2eC5l2No5WGhTUfKwC
	nBjVDbotJ92Dx01tS0xLwwhsMVRjfs9HOT0ZklEi+VxEATglwABZvkdGtKJOh4MAjRWeabHdgHm
	8Tdd4tSbU2gUqMDwnTW7HogR16wOIiBv0xLMxMEDWtrPOpfvfd5uLZv0F9Y=
X-Received: by 2002:a05:6000:2408:b0:3a0:b84f:46de with SMTP id ffacd0b85a97d-3a3512102b9mr2493122f8f.21.1747302925641;
        Thu, 15 May 2025 02:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE9JwGTJdw25VAJtcZJc6HTRnmqmzlBaO2XKeTPhb95VPmN8r7Vkk/2fj/yJLLse1gPsf9Hg==
X-Received: by 2002:a05:6000:2408:b0:3a0:b84f:46de with SMTP id ffacd0b85a97d-3a3512102b9mr2493100f8f.21.1747302925244;
        Thu, 15 May 2025 02:55:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35225355csm1734053f8f.44.2025.05.15.02.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:55:24 -0700 (PDT)
Message-ID: <235b93a5-6989-4131-9099-c0c03bb6afc1@redhat.com>
Date: Thu, 15 May 2025 11:55:23 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 10/15] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
 <20250512092736.229935-11-bigeasy@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250512092736.229935-11-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2e4iUyvW0_QXucI8V8RENuHXn4-mnR3w0lMwttCJA-g_1747302926
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CC sched maintainers.

On 5/12/25 11:27 AM, Sebastian Andrzej Siewior wrote:
> mirred_nest_level is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Move mirred_nest_level to struct netdev_xmit as u8, provide wrappers.
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netdevice_xmit.h |  3 +++
>  net/sched/act_mirred.c         | 28 +++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
> index 38325e0702968..848735b3a7c02 100644
> --- a/include/linux/netdevice_xmit.h
> +++ b/include/linux/netdevice_xmit.h
> @@ -8,6 +8,9 @@ struct netdev_xmit {
>  #ifdef CONFIG_NET_EGRESS
>  	u8  skip_txqueue;
>  #endif
> +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> +	u8 sched_mirred_nest;
> +#endif
>  };

The above struct is embedded into task_struct in RT build. The new field
 *should* use an existing hole. According to my weak knowledge in that
area the task_struct binary layout is a critical, an explicit ack from
SMEs would be nice.

Thanks,

Paolo

