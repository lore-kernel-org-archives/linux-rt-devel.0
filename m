Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17089372EF3
	for <linux-rt-devel@lists.linux.dev>; Tue, 28 Apr 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367663; cv=none; b=cCiQugx+6WX09kTuoAqwEP+zEJj6SglJ1sB2tsYBb3t2feKRInZIXttYF7lFva8rbge2PK5tvXTfXckp/xiI4on8mCol8on9qKQgUzgZjzjCPQ2S5OX1yDQDcox9RE+5OGh15utRNQAH8zNvfTFYL37u1iqZjDAaUI9+MlJR11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367663; c=relaxed/simple;
	bh=4GkDVVEv08AkmrNXJY3nxp8e2TsLCNnF8yTHag+O6bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOA3Aad5qkZJincqIfE7MIXBYkb9wn9WV4EdeNRiPEJmdxDg8mG1gNbWQUqF+ayf9CE4SQoe+yA7f9k6RhUvm1InOxQhc6zYshPNfyGrWi67GKsjezFP6groiHLUEaqhthpaFHi+5GG+gnwLwKWDD6SFH4IXR5Ctrc+tYx8UvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMOrnfeR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMOrnfeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777367661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
	b=HMOrnfeRG71sV8y5jDg7KVt1unMmcKc9ITRD6VP5u6Y1TleWve0uj2D/EXa4i4vxEClN7o
	dWy4FLIk8H2Ip698rheu4fjRla3MVANu3YAk6M/S+tsu0nWWmPDjYrTfyt1KhZnY4f7xXR
	V6v3MLdk2tFLxQytFoWVfJIO+G26WYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-WDB-yb2_N7uyc6yb6DQbMQ-1; Tue, 28 Apr 2026 05:14:19 -0400
X-MC-Unique: WDB-yb2_N7uyc6yb6DQbMQ-1
X-Mimecast-MFC-AGG-ID: WDB-yb2_N7uyc6yb6DQbMQ_1777367659
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a2c034fso6852626f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 28 Apr 2026 02:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367658; x=1777972458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
        b=TGeHEFI6Ub6x6FWv0GpMgoH1+Vk5j1BFQQ9lBHfjfg7QI/NK6hfQc2EYjVpHuVlXmP
         p6ghNOij6Q698cGnbqqbZcwG92RvNI5akMS3rGErtjCKpMGa6JXt6E9mya6Znc7MC9xn
         9RRIDxUjoYnYzFnwptItNLPvXWD0PwY9UAC03eB+VoGec5l2MWWeyml2jY4X4kn3eRn9
         AFgUL0JuVcn+Y8srvnL7yGXYVRDisxWalRpjvJn/c4xzT9VWYfw4y8r/Oa+bsTMQPcz1
         oHIHxawINyLajQcxsYJEVtpb5wjStYdG2SM5S373NdeyQTgkZpK7wybQ+yKB5UZQxdia
         4VeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yCIScOsmap+R39bEYBfKG1oGS8J0FFDWjK85Fsgfwpt3qtRyRjYXrFZ9y89afPDiMh12kv9YgckGbsYC5Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWTOZ/UJqQETLqvXjXAmAlVsHlP3zN408WgiPpU/gBaoOAdFXg
	ZLhDVqruEncNrnJTQdN5Os7qOFxQt5igg5TjGMdv/F5ZFwX/fTwVjJp32LwG+j4XYDc1NIhYrAM
	pEBaYDJMqEg2aln5Oa5qjP5fWvXWKGYiyA8gqlTRKyVxkKR9zfCJI4CZSx8K8wZrbndya
X-Gm-Gg: AeBDieshme+HM3OxJGi5xRPVtL9VRKw7zQaQ7HPL22GbCEQuuePcVcu8gNI/JWq1qhw
	IDj8rkUGzMn0h6bBE8jlMs7HFjAKcM0Qe3NfijUngDmNRFHub8a569UCp0+RO4Ko7074ZvEwrBg
	LSkiDMgh6AYr1lImYCMQ8GJjq8wHKtUUhEQQREm2tDlEMyCq0I9P7L76jKMrHXPz17+v2GWdwJv
	MuvwDXCzNs71c/zzajyqBceddOOHDJ9GHFissKBHl+dNsBGtHTbni6fayvx6iaEPKgHick39EJD
	4ThXBsqRo/gaYnahdk0I4J442VLP4j2wlTgQrpcCu4qzj7N/z/N5GVX//tCq56ygb+so0Fhrqgb
	mgSoJkg2y/gf6Gt4/pdxl1YpDyU7PrAjySzevX8bWOM8EyQT5U8nGCxVJuL8keMOkBQ==
X-Received: by 2002:a5d:5f51:0:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4464a070032mr4183689f8f.42.1777367658500;
        Tue, 28 Apr 2026 02:14:18 -0700 (PDT)
X-Received: by 2002:a5d:5f51:0:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4464a070032mr4183660f8f.42.1777367658030;
        Tue, 28 Apr 2026 02:14:18 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fa89140sm4764422f8f.27.2026.04.28.02.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:14:17 -0700 (PDT)
Message-ID: <efe42959-81c4-4d35-a3d0-fd084c9cda25@redhat.com>
Date: Tue, 28 Apr 2026 11:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, clrkwllms@kernel.org,
 rostedt@goodmis.org, david.lebrun@uclouvain.be, alex.aring@gmail.com,
 Justin Iurman <justin.iurman@gmail.com>, stefano.salsano@uniroma2.it,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
 <20260423080056.KgHlh9Oa@linutronix.de>
 <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0gp1cflRXWhN-a6Uq31crW9_Kf5SydNBGa-SwLPeRjI_1777367659
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 4:08 PM, Andrea Mayer wrote:
> On Thu, 23 Apr 2026 10:00:56 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> Hi Sebastian,
> 
> thanks for the review, and to Simon and Justin as well.
> 
> 
>> On 2026-04-21 11:47:35 [+0200], Andrea Mayer wrote:
>>>
>>> [snip]
>>
>> So the dst passed to skb_dst_set_noref() has no reference count. The fix
>> is to use skb_dst_force() to increment the refcount on it. But this
>> requires that we are in the same RCU section. And I guess we are since
>> none of the warnings are visible.
>  
> Yes. lwtunnel_input() holds rcu_read_lock() around ops->input(), which is
> where seg6_input_core()/rpl_input() execute. The skb_dst_force() is called
> within that RCU section.
>  
> 
>> Doesn't this make ip6_route_input() on RT fragile in general due to the
>> RT6_LOOKUP_F_DST_NOREF usage or here something special about the two
>> files that are patched?
>> Based on your explanation it all makes sense, I am just not sure if this
>> race is limited to those two are if there is more to it.
> 
> seg6_input_core() and rpl_input() cache the dst via dst_cache_set_ip6(), which
> invokes dst_hold(). The dst_hold() calls rcuref_get(), failing on a zero
> refcount and triggering a WARN, but the pointer is still stored in the cache.
> After the RCU grace period completes the dst is freed, and a subsequent
> dst_cache_get() returns a dangling pointer.
>  
> The other callers of ip6_route_input() (e.g., ipv6_srh_rcv, ipv6_rpl_srh_rcv,
> ip6_rcv_finish_core) consume the NOREF dst without caching it. Even if the
> pcpu_rt's refcount is concurrently dropped to zero, the dst memory remains
> valid because dst_release() defers the actual free via call_rcu_hurry() and the
> caller is still inside the RCU read-side critical section.
> 
> 
>>> [snip]
>>>
>>> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
>>> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
>>
>> If having PREEMPT_RT_NEEDS_BH_LOCK unset is the requirement then the
>> right fixes: would be
>> Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
>>
>> as prior this commit the race is not possible, right?
> 
> I built and tested kernels at 3253cb49cbad and its parent fd4e876f59b7 (both
> CONFIG_PREEMPT_RT=y, without the fix): no issues at fd4e876f59b7.
> At 3253cb49cbad, a pcpu_rt cmpxchg contention in rt6_make_pcpu_route() shows
> up, which was addressed in 1adaea51c61b. I also tested at 1adaea51c61b, and at
> that point the dst_hold() race described in this patch appears.
>  
> The seg6/rpl code obtains a NOREF dst from ip6_route_input(), does not promote
> it via skb_dst_force(), and passes it to dst_cache_set_ip6() which calls
> dst_hold(). This pattern has been present since af4a2209b134 and a7a29f9c361f,
> and the current Fixes: tags point to the commits where it was introduced.
> Does that seem reasonable?

I think the above is correct, but also pointing to 3253cb49cbad4 would
be correct, since the latter is required to exploit the problem. I also
think cases like this one it's better to avoid the repost (since the
constant ML flood) and to err on the conservative side (older hash). So
I'm applying the patch as-is.

Thanks,

Paolo

