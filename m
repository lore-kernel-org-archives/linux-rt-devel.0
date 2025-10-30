Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042532ABE0
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792022; cv=none; b=j9CScCIV2RrnMiY3bvC+cdyw7G9I2iegLxbEN/XGTpq69K4Vyn1tq/eeRZMfTVd+5gyBmvu5AyZoTUGz8DdNvEQ4EyGMlEf3OkgF+rfFZ0z5UfdnkUsYJEBCOtvmIlc5oniltkicQU3T1ObHOAn36IgDgUD6nzsKlZxQCgcLZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792022; c=relaxed/simple;
	bh=La6nPJ+mBWseLc1/q4pp6q2DuHjzkflifv8qvL4nzX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5PKvI8sp+SGrK9Wxci+MmWW85/hTaGajWMZtRfvdLYFvXSWaf1K9GUfwJ/sqkPZOeDpC2Jlt/KKIXBknVD1kTkyLm85p6t2+LSEwEZTXsY70UXAkq2XBepfDozpWKl4A25hHZMDE12sU5Mexfk18kGnwIay0LZeA93LHHvNKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YY2VUD/F; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YY2VUD/F"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=La6nPJ+mBWseLc1/q4pp6q2DuHjzkflifv8qvL4nzX4=;
	b=YY2VUD/FrWicRGdZjmf9rAAXDLpTB+d/eRKZ2rxky/tJM45Sw1unhKMR6wMPUe54TrYRoPChy
	4zFq0W0Lc0wAZMYrGVntdUPMWN0EFIIUGK/vYes3eOKnA8JRcFJ6r12N15zs4yRpUgPXN4pL16t
	e/8WgXYlW6dPbySqpKL5oco=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cxpGv5HWyz1cyVh;
	Thu, 30 Oct 2025 10:39:35 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 021511800CE;
	Thu, 30 Oct 2025 10:40:05 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 10:40:04 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>
CC: <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rt-devel@lists.linux.dev>, <linux@armlinux.org.uk>,
	<tglx@linutronix.de>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Date: Thu, 30 Oct 2025 10:39:59 +0800
Message-ID: <20251030023959.5416-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029155918.503060-5-bigeasy@linutronix.de>
References: <20251029155918.503060-5-bigeasy@linutronix.de>
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

On Wed, 29 Oct 2025 16:59:17 +0100, Thomas Gleixner wrote:
> jump-labels are used to efficiently switch between two possible code
> paths. To achieve this, stop_machine() is used to keep the CPU in a
> known state while the opcode is modified. The usage of stop_machine()
> here leads to large latency spikes which can be observed on PREEMPT_RT.
>
> Jump labels may change the target during runtime and are not restricted
> to debug or "configuration/ setup" part of a PREEMPT_RT system where
> high latencies could be defined as acceptable.
>
> Disable jump-label support on a PREEMPT_RT system.

This sounds like a performance issue rather than a feature issue.
Banning users from using the jump label because of a performance problem
seems like throwing the baby out with the bathwater.
Perhaps we could add a config like CONFIG_ARM_JUMP_LABEL_RT_FORCE that
allows users to select, and inform users in the description about
potential latency.

Xie Yuanbin
