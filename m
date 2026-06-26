Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6F3E3C48
	for <linux-rt-devel@lists.linux.dev>; Fri, 26 Jun 2026 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462650; cv=none; b=mTmDAEMiVhc25Nizx3siZ2ccBPSueXaxApRh+IozwpYW2paJMXwsO5oyWOn0h/x7Vs0zjQVMJi+wnjEwH1sylEFxTt8PovLnCBRIXG6rxfc3YrmYZnKo3Vd5XSHp6RmIJAGOOPzzhlbpJSwBW5sm5fcp8KZzsa+/eGUuJYqPJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462650; c=relaxed/simple;
	bh=sd33oz6pbfPjDa5fACSSUfY22ie6IIiUvimEtQAlO1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a269bRuetgU1XVTQpdf9ogN1bJClkfw1MLhVVQmgHmwbPO/OxaiL2lr+G4UgI0ce92jJF6V9YAb4SU9rKzdiPi7yGS8+FbMYlMql3WxGobl/v1ouhSugng2MTtFbC68mbv+3Oy5oNdZ0RaUClzjF6Jw1M/DF5X+PynJT+BeQhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VvMoTbz+; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VvMoTbz+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sd33oz6pbfPjDa5fACSSUfY22ie6IIiUvimEtQAlO1M=;
	b=VvMoTbz+cRX0X3hr5ZE6K73zzFaOmm8P1u38thRtHaA1psp3g8AL+h/oS8q2lh7oi33Ia2DTc
	qcHgDenkqBpgUjnqBMI1HsP0xm9nYZNAaz3dkFKVk44TMjrqJRz+a86AsKw+Pm2gW2QBbSCNEs0
	2ckhjTOmtUk4EshtQcNCJi0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gmpYf3ZgTz12LG1;
	Fri, 26 Jun 2026 16:21:58 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 77AFE40575;
	Fri, 26 Jun 2026 16:30:44 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 26 Jun 2026 16:30:43 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <bigeasy@linutronix.de>,
	<rmk+kernel@armlinux.org.uk>
CC: <clrkwllms@kernel.org>, <rostedt@goodmis.org>, <linusw@kernel.org>,
	<arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<liaohua4@huawei.com>, <lilinjie8@huawei.com>, Xie Yuanbin
	<xieyuanbin1@huawei.com>
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling user mode errors
Date: Fri, 26 Jun 2026 16:29:53 +0800
Message-ID: <20260626082953.47503-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625152159.WtO_S3i7@linutronix.de>
References: <20260625152159.WtO_S3i7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Thu, 25 Jun 2026 17:21:59 +0200,Sebastian Andrzej Siewior wrote:
> Why would the latter be not appropriate?.
> Anyway, in the kernel case you do die() which disables interrupts as of
> oops_begin(). It does later restore the state in oops_end() and invokes
> make_task_dead(). This one will complain if either preemption or
> interrupts are disabled and reset both.
>
> Should you get that far and not panic() earlier (due to in_interrupt()
> for instance) then interrupts will be later enabled before that kernel
> thread is killed. So it could be done earlier or not, at this point the
> system is pretty much done.

My personal view is as follows: First, an Unhandled kernel fault indicates
that the kernel has encountered an error, which is different from an
Unhandled user fault. An Unhandled user fault can be artificially
constructed by user programs, whereas a healthy kernel, in theory, should
not trigger an Unhandled kernel fault.

When a kernel has already encountered a fault, I think that printing fault
information is more meaningful than improving the kernel's real-time
performance. Imagine this: The interrupts enable here, and at the same
time an interrupt arrives, and then another kernel error is triggered
within the interrupt context. The log would be a disaster.

But no matter what, the above are merely my personal views,
and I respect the maintainer's opinions.
