Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441430C358
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810325; cv=none; b=XsZMJHiixIkEPGOWbhe2vhNkYmd1gWv0KL33s5E2Ycx2PDknBHzAkt4nwzb8tQzrCqSGFCIQ/LkaZLzYp7u1ogBA05q/LsOW1rvdt+ZvTCkiNh+zU3JDbyQf+bmWKzDPM6zRA4NwcPvwnHlmL+dbIPYRWVLeg8CaPE0Dwy56uz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810325; c=relaxed/simple;
	bh=7OSpskV0b3Z0Y8Bcg2JJJY4wTw6TjjgMjW58E+iZS7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUON/8p7HafrIwATQ/UNNI6pEhHQaS+GABVdumeUGv1erFLHC0B9whb0MoMTYmMFXdD6j+rqL5fWP/ujx1DJuJJve/JRWCY4W8OzNe2PJW8AVdl3wQipHM2G615nfyXfhr1DV9ErNzVYXXtn6v9zVWcKEYAqDq8TP3Hs9X6g+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kvOYlxtJ; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kvOYlxtJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7OSpskV0b3Z0Y8Bcg2JJJY4wTw6TjjgMjW58E+iZS7o=;
	b=kvOYlxtJmCYNMp9WeJIuVCzWorl+2SJZb2XtqxPvXNRCY0nlVMofkQ+a9r5v65P21+M9WhFCD
	FVRr8qK/4uSz5pYaj0sePRZA8tLa/sMzeo/p58khjgr/V521yOYLwExrg0hJYPoXCA3uKkVbYiA
	OJaDPY1NjSVK405Mgudpdf8=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cxx2z0ZhbzKm6c;
	Thu, 30 Oct 2025 15:44:43 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 64FB41A016C;
	Thu, 30 Oct 2025 15:45:12 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 15:45:11 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>
CC: <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rt-devel@lists.linux.dev>, <linux@armlinux.org.uk>,
	<tglx@linutronix.de>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Date: Thu, 30 Oct 2025 15:45:07 +0800
Message-ID: <20251030074507.33863-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030072339.63vdFNo3@linutronix.de>
References: <20251030072339.63vdFNo3@linutronix.de>
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

On Thu, 30 Oct 2025 08:23:39 +0100, Sebastian Andrzej Siewior wrote:
> It is not a performance issue, it is a latency issue. If the scheduling
> latency increases by 300us because of this then the PREEMPT_RT system
> becomes worthless.

I understand what you mean. But this delay only occurs when the static
key is enabled/disabled, right? For users, we can control when to
enable/disable the static key, but it's a real shame if jump labels
aren't available.
Therefore, my personal opinion is that informing users that JUMP_LABEL
might cause unexpected delays, rather than disabling it, would be more
appropriate. ;)

Xie Yuanbin
