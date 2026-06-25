Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA63E123E
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390430; cv=none; b=vDs3IFJ7K0hzxDDcq/9RPm1enzt8Eaz4Bn7GK21kehfYSGmD5ORMbMTTMsAMCPYbnAs9/628YExGgNAHsA40pqPzPgRtIw+N0NXE4TQZ3xdB5jM9oe1J5jg7IjzKVo/nbY6hRfxApH/aIzU6MTvsiPsckvFEPAytSsbwW6PID5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390430; c=relaxed/simple;
	bh=hOPR0zrtO3spcDxp4bwyn8NGPVw/3JNcC+iO71WnyMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UD3OsaRPzDAZboxwRMOMdYD38h0r7HAOskNveIlADNOVuQLgFFC4EOFmZqQAKe7+nZArp8XvEA+wkAV7kL8qWEQN64ucnTmDwqpxqMk7hCYYorphUUbPpZv4cIw45In+N7S6Kg6Pg+v7tTEI7Wf+ebh0MbFMLfiDKNmGsra+ViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JFThUlrE; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JFThUlrE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lWzgkEXj1zq4UNNnpINCriQKGxQChcPS+GE0OzhntmY=;
	b=JFThUlrEgJaJEZd3nOvfE8L3ZGL7/zBgx/ft69xExuuGC9sRI1HfG62d6fG+bd2qH6NeQYIk/
	YVRI/Rv0aggkbbH/Jv+OO4bHnXCz7pHjSzzwuRDMAtZji8dT2IRDSR71+jpgK1spMLv2owG6gH6
	BsV0IVd5cflNBeXtSWQix1w=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gmHrP1c8nzmV8G;
	Thu, 25 Jun 2026 20:17:57 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F07E4055B;
	Thu, 25 Jun 2026 20:27:03 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 25 Jun 2026 20:27:02 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <bigeasy@linutronix.de>,
	<rmk+kernel@armlinux.org.uk>
CC: <clrkwllms@kernel.org>, <rostedt@goodmis.org>, <linusw@kernel.org>,
	<arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<liaohua4@huawei.com>, <lilinjie8@huawei.com>, Xie Yuanbin
	<xieyuanbin1@huawei.com>
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling user mode errors
Date: Thu, 25 Jun 2026 20:26:12 +0800
Message-ID: <20260625122612.43501-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aj0BpqlaCh3cVw8Q@shell.armlinux.org.uk>
References: <aj0BpqlaCh3cVw8Q@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Thu, 25 Jun 2026 11:23:34 +0100, Russell King wrote:
>> 3. enable interrupts in do_DataAbort()/do_PrefetchAbort() after
>>    `inf->fn()`, this may be ok.
>> 
>> From this perspective, arm_notify_die() also seems to be a good place?
>
> If one is happy with higher latency for preempt cases, then it may
> be, but if we want lower latency, then it ought to be earlier.
> My preference is (3).

```c
	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
		return;

	if (likely(user_mode(regs)))
		local_irq_enable();

	pr_alert("8<--- cut here ---\n");
```
or
```c
	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
		return;

	if (likely(interrupts_enabled(regs)))
		local_irq_enable();

	pr_alert("8<--- cut here ---\n");
```

Which one do you prefer? I prefer the first one, because for kernel
fault, kernel may have encountered a serious issue,
and enabling interrupts may be not appropriate.
