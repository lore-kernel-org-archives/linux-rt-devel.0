Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887D3F54BB
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722035; cv=none; b=Hka+il8+EqpVGKsQ2KPimKL0DCJDGjedYB81YHXinFIlyYgkioCP058CGhRubEhuRMzTe/N4N4MQNyArj1LrNZFsEgNL4SwOSgCkSIxoFf58wyL2VKKHx9ka+3/4IBjs38QOHmxdzeStlwe4fLVZxITxh5IQj6bi2NBvPPqYuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722035; c=relaxed/simple;
	bh=e7KQgzL9AOfONV7XswuAUp+DLcTX725NBTXRKFY8zcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAx/Wbn9Lr4bTCyWKPQrQl0RyqSi291W47eilABy5u62vpSjvcp3zjhieB6Qoy7a6TmBHLNPTJLKq8IKwctfB+knkhL+nnU0baPdYrduq/b8RUt3x4fUvzSHEOzOS+xL0CBFNX183tjkuBeoddcmhyIoGP4q7PhUw6NPR0zOKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bc1eBkuu; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bc1eBkuu"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qGpv5qbqQS7ZSoDmaLAuR5/2EqiThiMa2p7f3hUe5sA=;
	b=bc1eBkuuakI2e+0xCAO9C8iufRWXphlU95ySnEB0GneP6t5IhoA8eSkI2knUtlIxEA6Bu0EJy
	/wideb9nKgePC+ffTCMrkPEVpzeH3Dh3QxV6iPpnsnISRE7ydoZwt3QcrVlRHaRNt8Btc+HMri3
	S4P6EhoF6QOaozxPBgckAFI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gpfSV4y5hz1T4Hf;
	Mon, 29 Jun 2026 16:23:54 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 879B1203C1;
	Mon, 29 Jun 2026 16:32:42 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 29 Jun 2026 16:32:41 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>, <linux@armlinux.org.uk>,
	<rmk+kernel@armlinux.org.uk>
CC: <arnd@arndb.de>, <clrkwllms@kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <linusw@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <rostedt@goodmis.org>,
	<xieyuanbin1@huawei.com>
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling user mode errors
Date: Mon, 29 Jun 2026 16:31:50 +0800
Message-ID: <20260629083150.72460-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629075726.McX9yWi1@linutronix.de>
References: <20260629075726.McX9yWi1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Mon, 29 Jun 2026 09:57:26 +0200, Sebastian Andrzej Siewior wrote:
> In oops_enter() not only interrupts are disabled but also the emergency
> mode of the console is enabled. That means all console output is written
> via the atomic_write interface to the console as it the output happens.
> At this point, your real-time guarantees are gone. There is no need to
> worry about anything here since everything is lost.
>
> Restricting it to user context is reasonable: Here you kill the task and
> need enabled interrupts in order to send the signal.
> For kernel threads it is not needed because the "printing" happens with
> disabled interrupts anyway and without any buffering. Should this event
> not end with panic() then it will kill the kernel thread and enable
> interrupts before doing so.

Thanks. So, can I take it that you agree with the first one?

On Thu, 25 Jun 2026 20:26:12 +0800, Xie Yuanbin wrote:
> ```c
> 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
> 		return;
>
> 	if (likely(user_mode(regs)))
> 		local_irq_enable();
>
> 	pr_alert("8<--- cut here ---\n");
> ```
> or
> ```c
> 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
> 		return;
>
> 	if (likely(interrupts_enabled(regs)))
> 		local_irq_enable();
>
> 	pr_alert("8<--- cut here ---\n");
> ```
