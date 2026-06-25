Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDD175A64
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381663; cv=none; b=bcGIcE+I0IagE/g9SYK0yVr7kXW1kVqBY2xH2BIs8rakZKYZhj4aVTGLYIme7+MK0lR3PxotI6uMHgQMD3+U+wunbDyL0DRDUGDSIfX4/x7Keo2gE6FXSShOMME6/p6DNoI90bjhsAk977fboa4rI9+mmPgeeg0LWikrPBJzey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381663; c=relaxed/simple;
	bh=Gn/7+bLacjpkDmiHjHSBdfLnBik0k4SuB533WF9ToFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAAk56khMQb0fhSP8mavRV2OdGeKjqm6VWqUUzqhUJewOdTTdj+RpH/06NupQ0wseJ6xxR8rgQwJykni0wfggiYtoNHSHGNBOhYz1tUhSDmWz+jF8Z3fQ4nEccOZ1SItESENIiac14XqWpw4QKOW72sfHTfJRAhZcK1H9L9iLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TBFNCPTG; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TBFNCPTG"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rpR1F30zLrtOpvteu01mlEZqU7nBeoYmaGf4q3vajDw=;
	b=TBFNCPTGICFJy7hk4gMqHOL2c6tpvPhBC7UKbbaHTRJI6/hRouGa90quumD8EJQE1BwAUKhxx
	zrAAlfiq7DyqEbQuK37mDL71csDCEnkGUVogdlAKHqGXmxrOGShIPUbqsi3oEz0UKHImeAndCUD
	OKzK+jQIobi9hrlHNyY3wSw=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gmDcf2VXszpStS;
	Thu, 25 Jun 2026 17:52:34 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B84C2012A;
	Thu, 25 Jun 2026 18:00:51 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 25 Jun 2026 18:00:50 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
	<rostedt@goodmis.org>, <rmk+kernel@armlinux.org.uk>, <linusw@kernel.org>,
	<arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling user mode errors
Date: Thu, 25 Jun 2026 18:00:31 +0800
Message-ID: <20260625100031.25088-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625073522.182503-1-xieyuanbin1@huawei.com>
References: <20260625073522.182503-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On 2026-06-25 10:05:52 [+0100], Russell King wrote:
> > for this but actual breakpoint handling might be broken or is it 
> > just me? But then your stack trace looks like mine so :/
> 
> ARM Linux doesn't use BKPT. BKPT was an instruction introduced by Arm 
> Ltd in ARMv5TE. Prior to this, we use a UDF instruction instead (we 
> had to pick something!) and gdb and other tools use that as a 
> breapoint.
> 
> Moreover, BKPT isn't guaranteed to trap to the kernel, especially when 
> there is a hardware debugger connected. In that case, DDI0100E states 
> that use of BKPT must be according to the instructions provided with 
> the hardware debugger. This makes BKPT unsuitable for use.

When do_DataAbort()/do_PrefetchAbort() run into `inf->fn()`, and the
hook function return != 0 with interrupts disabled, the WARN may be
triggered. From the code perspective, there are countless possible
places, and "bkpt #0" is just one of these.

For example:
bcm5301x_init_early()->hook_fault_code(bcm5301x_abort_handler).
if CONFIG_ARCH_BCM_5301X=y, then bcm5301x_abort_handler() may return 1
without enabling the interrupts.
if CONFIG_ARCH_BCM_5301X=n, then in the same scenario it will run into
do_bad(), also return 1 without enabling the interrupts.

So I think maybe:
1. enable interrupts in all hook functions, maybe
   multiple points for modification.
2. enable interrupts in do_DataAbort()/do_PrefetchAbort() before
   `inf->fn()`, but harden_branch_predictor() may be difficult.
3. enable interrupts in do_DataAbort()/do_PrefetchAbort() after
   `inf->fn()`, this may be ok.

From this perspective, arm_notify_die() also seems to be a good place?
