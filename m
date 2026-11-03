Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672160;
	b=POvVjS8h4gdnC+CkTHgGiPoZSoQN5sRCm4oy0WltVJqzhwpnOCNdGDK2mkgJDSJrEsq3
	 Mob/fbIbPSy3lpGxt75QFjJMUclXH6V08Uu2TgB1fNi2Zyrk/LZWgera2+9WJ0/a/MWPY
	 WepWKeFmo47Z2SN5xcF0wRa6+dPBaoWMDmD2OxXxBmeJtgoN+pzkjKIB2J+xi/GjKmJJm
	 /MHClhM/78EjyDG0Aw4mp7SYnH7U4V4CXgxSeBEzuP1P73Syl/wqyj5G8EoI1IqfI3zPh
	 LnGF3L5DeeI/Z7RcHMgzNVgdHWWZYubOS3dUfH5EBZNX48O0ZbWWpATy4MmXkXq+2Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672160;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=h2jSleEyCdCf1WyjqdW65FR18D28p9mvgGWHAtd6NJ4=;
	b=1V0E1K22rigcLg3MCUBFXwwq1kQGuhpPByq3dXKrx+1QWWyZ3FXpktLS3q1RlBqufJe5
	 /DvKQxwhzauw1J6eD+4M3z13un3JXbpjfF/tuS4I1iE1dyyyAoVPweSKKSmH6dT2Zx6JW
	 blnyCAZXuI8LdU3i6dj/LGsBOACzuSeenGfu5C4TwX/CuYDf4sre7j0EEQV7GQGZxuMRA
	 5YLNVCXwVNNM7TluF6QbbwoxTkTuqO05WmU7vyszJaZt1lkqnjVluyr8BM9adfc0/jY5U
	 HSQ0JhIbBW3XADI5KVQwzdQDRPmnmHZCI8zg+eiPIFLNwO55lXCPX+a0w5wUYMQX0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="aYo/SUJZ";
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B60606A336
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 02:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B60606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aYo/SUJZ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=h2jSleEyCdCf1WyjqdW65FR18D28p9mvgGWHAtd6NJ4=;
	b=aYo/SUJZ/pwFqsMNlQd3WzocHdxLHqoQEchORj0CGyFU1Ue3rmBNFwDvIJmiCUEfnf/mb6YD5
	ht9zqhYhRPllvZcACkCnvmfsavAao3ySdhTvNkzM1Dp/c2TYQ7MhFZW4nHyQXGhUhr1CYFUl6vO
	jgAfqZQXzUYpOVrwF00FabM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jJXH62d8pzmV76;
	Tue,  3 Nov 2026 10:15:46 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 47D3640572;
	Tue,  3 Nov 2026 10:15:56 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 10:15:55 +0800
Message-ID: <3d2968f2-5171-4558-92a3-41cab745d282@huawei.com>
Date: Tue, 3 Nov 2026 10:15:54 +0800
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: sched-preemption: Fix the list of
 runtime-selectable models
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<clrkwllms@kernel.org>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<arnd@arndb.de>, <bp@alien8.de>, <kmehltretter@gmail.com>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <quchaosheng000406@163.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
References: <20261028024333.795917-1-ruanjinjie@huawei.com>
 <20261028024333.795917-3-ruanjinjie@huawei.com>
 <20261102133424.rJTJIkFX@linutronix.de>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261102133424.rJTJIkFX@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/11/2 21:34, Sebastian Andrzej Siewior 写道:
> On 2026-10-28 10:43:33 [+0800], Jinjie Ruan wrote:
>> --- a/Documentation/scheduler/sched-preemption.rst
>> +++ b/Documentation/scheduler/sched-preemption.rst
>> @@ -20,9 +20,6 @@ change.
>>  The models selectable at runtime are:
>>  
>>  	=========	====================================================
>> -	none		No preemption of kernel code other than at explicit
>> -			``cond_resched()`` / blocking points.
>> -	voluntary	As ``none``, plus ``might_sleep()`` sites.
>>  	full		Any section that is not explicitly preempt disabled
>>  			may be preempted at any time.
>>  	lazy		As ``full``, except that the scheduling request is
> 
> This is fine.
> 
>> @@ -31,10 +28,12 @@ The models selectable at runtime are:
>>  			apply to real-time tasks.
>>  	=========	====================================================
>>  
>> -Not every model is available on every kernel.  An architecture that provides
>> -lazy-preempt support offers only ``full`` and ``lazy``, and ``none`` and
>> -``voluntary`` are rejected there.  A PREEMPT_RT kernel always offers ``full``,
>> -and ``lazy`` as well if the architecture provides it.
>> +CONFIG_PREEMPT_DYNAMIC depends on CONFIG_ARCH_HAS_PREEMPT_LAZY, so ``none``
>> +and ``voluntary`` are never selectable at runtime; passing either is
>> +rejected with "Dynamic Preempt: unsupported mode".  The two models are only
>> +left as build-time choices on architectures without lazy-preempt support.
>> +A PREEMPT_RT kernel always offers ``full``, and ``lazy`` as well if the
>> +architecture provides it.
> 
> What about:
>  Not every model is available on every kernel.  An architecture that provides
>  preemption support supports ``full``. If additionally lazy-preempt is
>  supported then the choice ``lazy`` becomes available. An architecture
>  without preemption support can not enable CONFIG_PREEMPT_DYNAMIC. On

Hi Sebastian,

There seems to be an issue with this sentence: PREEMPT_DYNAMIC depends
on ARCH_HAS_PREEMPT_LAZY, not “preemption support.”

What about:

Not every model is available on every kernel.  A kernel built with
CONFIG_PREEMPT_DYNAMIC offers only ``full`` and ``lazy``; ``none`` and
``voluntary`` can only be chosen at build time, on architectures where
they are available.  A PREEMPT_RT kernel always offers ``full``, and
``lazy`` as well if the architecture provides it.


>  such an architecture the preemption model can only be selected at
>  compile time. 
> 
> Sebastian

-- 
Best regards,
Jinjie

