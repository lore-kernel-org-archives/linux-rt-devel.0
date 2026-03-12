Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282623B38AC
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Mar 2026 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311788; cv=none; b=C49Vu0xSxjmQXLU1J8O7isQ4GJo1FlfI48cQn/e0URu1J667KqaqqisO+vjbhn+Ea8gKK27VZaOP6DLXgW7ErYU0M3yvjq53hCYrQnqmriASk0M291PLVkwTz3IlF474oJz4x7Ne2MDzH5AFRIx+azGCuvcRKmpxIGCmUfGvbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311788; c=relaxed/simple;
	bh=U4scEkwLlZ0VuAmkLypf9F9edX/OF61hxlh8178UWxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2DQDNdzeCLgW6coCzIw4zGP/hI8y3NwTMvBJnyJvoFlbgTYZ0DdQ2HgoqkpB3fKUmHpw/uA8PWvuswrS5InZgHvuTdJLIhWyWnLfe183+GACD307R1kukFal9jjCDoDYlUcMOfGQaquB0vRR3Et/BWkX88FzKgPEkU2LVn3VwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp0hcXsa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp0hcXsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773311786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
	b=Xp0hcXsaen/FaUNGVnwczL4Z7gg2isaP7WLifGG3FOJCI18vkH+BlO8yRpoY5uEyC7aIFH
	1oWAnf/upkKtwDF+Mf4FdweehBBqucQHirXcqev4NFTsJ8tYfvEvWdH08yWOKfzSXKoYF+
	yviCDCDdoH+bVYA5cAAiSNPzQ0hoxMA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-me4LFURfNr-D3mdeYC0_ZA-1; Thu, 12 Mar 2026 06:36:24 -0400
X-MC-Unique: me4LFURfNr-D3mdeYC0_ZA-1
X-Mimecast-MFC-AGG-ID: me4LFURfNr-D3mdeYC0_ZA_1773311784
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439b8858b0cso827494f8f.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Mar 2026 03:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311784; x=1773916584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
        b=igo9L5ZKK1VvxYUOjgFTstbD/DEmyXj203y7ABeXlrBpcEHK/r/wvZz9erTNS/6Ykb
         tcg1p10S+viOLbwe6vPV95YgEh1EbZCDZddHy0awQWaCIDRGLsOcmZouTzsmcds5fvu0
         /6mw1Vvpto+Wf5aMaq9veunFI3eKu72pnKiwg8Z0fNIxRgrzqPWBn19YrJIn5rhyk74A
         rIL+DRjZVoFVyI9eYmt4WGYiUZDqWB+Iwwev/GkHtLGR3gQf50wDV5S6XydzPMeEPM+o
         8VUarGgxVSCLFS7ddM7ZhcB9yi20CX9UTNoJ6bKVqa5dTPoapYmgl/4TIzDUre/JsjrK
         QTfA==
X-Forwarded-Encrypted: i=1; AJvYcCXX+yCsLzRmNDZYNHM8sr8BEyLNeWbDtg5Sryd5jMWexqUX5pqqiNZdwDaNsi165WSJ+3Q4aLxUeLZ38Nw0ug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7YD95R7hMawTw8yoGoBg9wuHJDlWY8l15fS5lFKpghKikjiD3
	mQEeyQ6fpLQEoMCv+fn9xXSz/Rx3/bkIRNV0LPx8fIcE7hmltI2CKxyBjy+AGV3ntcSgDlPCpiB
	/YahWmgqZ/PO1DFJHbXQ1umJycLGTiBt2ljQf9XEyA1CtZSq7lTxzdyfT3zj4isFH3jtG
X-Gm-Gg: ATEYQzw1dgOv3N9T0W+zebVGBGjulYLWzWLejqTi5r9J3e8MG3GuPSEmkMYj382edgf
	e4lVVNglZT6HqURKhbcewyupeGDxPbY6xzYxxnCuq2Ke9MAkQDEawAtQV5CQ8hEOn08sXY+FdOG
	XcTL4MCV2+Cb4qGunJtjg3wuQKVDMJrrANaOxHeO6rSOtOwdSmA0eCmV7I6oXHvQhI3pID9clrx
	a0RXbKIOFWHa/a6irDPX9xgIwAs9mpr6uAi+wFwRaCG4FLa9aWo3oYyfpsZkEuBUWT1BWcBqXwm
	nTXe/XprQoQHmMlykggZseNkBizSXTmYP1WZsAQF4UzV7itL3m/hB6jbbK9MW1+XyqKktn7Eh0d
	ffODQMtDecc3L7aMEVyp9xZxzqzkx6Vu+NM8uvXxJ/7qA3JWjKFwHcEc=
X-Received: by 2002:a05:6000:25c2:b0:439:df60:f87a with SMTP id ffacd0b85a97d-439f8434264mr10631504f8f.46.1773311783595;
        Thu, 12 Mar 2026 03:36:23 -0700 (PDT)
X-Received: by 2002:a05:6000:25c2:b0:439:df60:f87a with SMTP id ffacd0b85a97d-439f8434264mr10631438f8f.46.1773311783136;
        Thu, 12 Mar 2026 03:36:23 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm8118630f8f.25.2026.03.12.03.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 03:36:22 -0700 (PDT)
Message-ID: <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
Date: Thu, 12 Mar 2026 11:36:20 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Eric Dumazet <edumazet@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abARG4sHFdUNqcRV@penguin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JYpMTZYAsWWOUKEW4wpWiUPWllpjWxMyw_F3gWsxupk_1773311784
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/10/26 1:39 PM, Nikolay Aleksandrov wrote:
> On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
>> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
>>> <razor@blackwall.org> wrote:
>>>>
>>>> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
>>>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>>
>>>>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
>>>>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
>>>>> when the bond mode is round-robin. If the bond device was never brought
>>>>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
>>>>>
>>>>> The XDP redirect path can reach this code even when the bond is not up:
>>>>> bpf_master_redirect_enabled_key is a global static key, so when any bond
>>>>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
>>>>> interception is enabled for all bond slaves system-wide. This allows the
>>>>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
>>>>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
>>>>> reached on a bond that was never opened.
>>>>>
>>>>> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
>>>>> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
>>>>> never opened), fall back to get_random_u32() for slave selection. The
>>>>> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
>>>>> publish the pointer to the XDP read side. A plain read suffices for the
>>>>> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
>>>>> under RTNL lock and is the only writer of rr_tx_counter.
>>>>>
>>>>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
>>>>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
>>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>> ---
>>>>>  drivers/net/bonding/bond_main.c | 9 +++++++--
>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> This is Jay's patch + the unlikely change, looks good to me.
>>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>
>>> Orthogonal to this patch  :
>>>
>>>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
>>> if this makes sense
>>> for the packets_per_slave == 0 or 1 case to haves this kind of
>>> randomness in the first place.
>>>
>>> Perhaps we could use a
>>>
>>> static DEFINE_PER_CPU(u32, rr_tx_counter)
>>>
>>> And :
>>>  slave_id = this_cpu_inc_return(rr_tx_counter);
>>
>> I also have mixed feelings about this patch.
>>
>> We probably should detect that the device is not ready before hitting
>> something deeper in the stack.
>>
>> Sure, a NULL deref is avoided, bu what happens next ?
>>
>> We send a packet while the device is not UP, I am pretty sure this
>> violates at least some RCU rules in device dismantling.
> 
> IIRC when the redirect continues, the packet should get dropped if the device is
> not up (checks at a few places), but that's outside of bond's jurisdiction and
> after the slave id is needed in xdp master redirect's path unfortunately.
> I'm not sure it can reach much further, it just has the master dev's slave id
> generation in its path.
> 
> In any case we shouldn't crash in the slave id generation in the bonding,
> that ndo's only job is to return a slave id.

I'm sorry for the back and forth, but I share Eric's concern. I think
the approach suggested by Daniel:

https://lore.kernel.org/netdev/4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net/

or the initial patch form:

https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m7c67bb12f85bc88d583788fb6e41113c46208ae7

would be better. To respond to old concerns raised there: the check is
IMHO bond-specific, as control moves from the lower interface to the
upper bonding device, and the code is under an RCU critical section, the
device can't go away before the xmit is completed.

/P

