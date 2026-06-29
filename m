Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073A308F39
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737350; cv=none; b=q2rOsu0k6n5p/ZrZtQB4lEmOSoUM2gHkW241fguz6b+ddmmz3B7qUvFiMxPp8wwYc/wHp3vNZKWVFQ2XjF3RM//WBM3Vvvte9MHkGPstLV96wVD+VwVm2fgNGssocLxvR1DLUzAgUl9dEGVRdTASArTFJKpZ1ZcUekFtCvJp5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737350; c=relaxed/simple;
	bh=O+/YUQD7YAYGSS5DehzY5s76C5ID0xVuOZFRGvMTkns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hh5oIKbP+zZUsAd1yGCbZudbxMykfr+kHAATkAk4GBsqr3xbYpWe0JoBh0UxhvYE/7mHtceUZ/CC2TaibTC57tTi+e0cmK4aXtSnfCcBQwS7So36v3DooFP1U9pUJkZ9dpiis7JA1TIEBomvHaH3oKLUad9IGUP7kqxCNIvM5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2WZBudhe; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2WZBudhe"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O+/YUQD7YAYGSS5DehzY5s76C5ID0xVuOZFRGvMTkns=;
	b=2WZBudhenS3hM7mMwRIBVvPr/ThfSgz9lYWaUAUXKzw+rms+JuhUfZ2f2Qvr4Ol5Tv83L3W5M
	R82qUDI/0vzLePM/Tt9O/T5egeDzpdeVUoyssT5fm3z40XZ8yZOdimhg6N7GvGV+qJIewGrlaLr
	K4lVPTsnMqFBoWYxGanvTc0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gpm7w366hzmV8L;
	Mon, 29 Jun 2026 20:39:56 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 22A4740580;
	Mon, 29 Jun 2026 20:49:05 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 29 Jun 2026 20:49:04 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>, <linux@armlinux.org.uk>,
	<rmk+kernel@armlinux.org.uk>
CC: <xieyuanbin1@huawei.com>, <arnd@arndb.de>, <clrkwllms@kernel.org>,
	<liaohua4@huawei.com>, <lilinjie8@huawei.com>, <linusw@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <rostedt@goodmis.org>
Subject: Re: [PATCH v2] ARM: enable interrupts when unhandled user faults are triggered
Date: Mon, 29 Jun 2026 20:48:16 +0800
Message-ID: <20260629124816.136079-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629123349.134224-1-xieyuanbin1@huawei.com>
References: <20260629123349.134224-1-xieyuanbin1@huawei.com>
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

On Mon, 29 Jun 2026 11:40:22 +0200, Sebastian Andrzej Siewior wrote:
> If this is moved to the callers of arm_notify_die() then I don't know
> what to do about baddataabort(). It looks like it gets invoked with
> disabled interrupts, too but I'm not sure. This looks like pre ARM v7.
> Is it reasonable to add such a check there?

Oh, I'm not sure about this place either. Would interrupts here be
disabled? I'm not familiar with the entry assembly code of v4t, so
I don't know how to construct a user-space program that can run to
baddataabort(), and I also don't have a v4t device to test it.
