Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155453;
	b=oqXbP4y+kj9UFQ0QJR9ozSqwlhifZkIzPkfAjrKWIc/Mnx6M9RrozBHOlpy8IMfcSPDe
	 S+EcO0SB85d8yhow6wx46XF5irJIUPNxGYy9tORY6KNXPhcu6+5RkqGCbr/OYD2sj/+rO
	 G65Wh9aEnOeqF8PH1lbpbaEYp5LsBoxHY7CGIKslSnRGV0uRz6cxfjOn4MxFVPTMkHqY4
	 bHoQEtftGUMVFxQ/jj21Ui5Oh4NFPOjt9fAzwf10/GFc71o50vgLXLUCXu7dPbUy181Y2
	 xSYn5TnKDoPMLWr8pWnau+3SG3dUvNEzJsXKid4OGobX+iYQiUQ13h646uTHgt7MY0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155453;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ZmhbHppnJq1rq5xH9Hjby65jFnk2sntA3+LaX4tQlF8=;
	b=JNZVheP9NIhtN/jP7DPwobRhCYC+kuLNWO1LXQOnhgWEtZ6qTvORR1HvEV9iYfYJUcDk
	 wKRAJo7Pz0bIBhSualnxxgaM3EoIFKpoU6jJcAIDul4LBr9wTiskfc3z4/3+IVdqqdwRO
	 S1SSlkdGZiwFAPB9wrIRpZE9uH++enLbwlaJeAQzWBGt8hhAHT4yggsXsnoRUf1TbbV2t
	 JIGWoB6YnZgiVMuURaawzqs2oBsLW2QqFFIYYBxBKeIquAyVspQcJ+Hnv/+NXKCCPH5pg
	 rInUt/Oj7rgJMOaHhXv92KpDinwEL7MS7LroNbDR+xMQEIA/areImLcjn/2ze7GhIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="kK/xYDbu";
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6F606A31A
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 02:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FB6F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=kK/xYDbu
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZmhbHppnJq1rq5xH9Hjby65jFnk2sntA3+LaX4tQlF8=;
	b=kK/xYDbu7y/CQKyOqZn6TUyqJN11YOhQQ5a0FlG2JrBbdPGH5UkF+Hg3Kv72O3LvAvDBI4gG1
	6yJtNsD8dGiLxJ6g/2AMI2KJktSN+gS4EUoRrbE1w80eOOvZnt836sDPTbcsKmY8WuZ0B57gPbw
	zCpthXh1pvubJngs+scHm80=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jDsBR2MTdz1T4H5;
	Wed, 28 Oct 2026 10:43:59 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C7E4202E6;
	Wed, 28 Oct 2026 10:44:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 28 Oct
 2026 10:44:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<bigeasy@linutronix.de>, <clrkwllms@kernel.org>, <rostedt@goodmis.org>,
	<rppt@kernel.org>, <arnd@arndb.de>, <bp@alien8.de>, <kmehltretter@gmail.com>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <quchaosheng000406@163.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/2] docs: Remove the unsupported preempt= modes
Date: Wed, 28 Oct 2026 10:43:31 +0800
Message-ID: <20261028024333.795917-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)

The none and voluntary preemption models can no longer be selected with
CONFIG_PREEMPT_DYNAMIC:

- commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
  stopped PREEMPT_NONE and PREEMPT_VOLUNTARY from being offered on
  architectures that select ARCH_HAS_PREEMPT_LAZY;

- commit d3d16750693b ("sched: dynamic: Make PREEMPT_DYNAMIC depend on
  ARCH_HAS_PREEMPT_LAZY") made that dependency official and removed the
  code that parsed "preempt=none" and "preempt=voluntary".

Two documentation files still describe both as runtime options. The first
patch drops them from the preempt= entry in kernel-parameters.txt, the
second fixes the model table in sched-preemption.rst, which also misstates
why an architecture may or may not offer them.

Nothing in the code changes.

Jinjie Ruan (2):
  docs: kernel-parameters: Drop unsupported preempt= modes
  docs: sched-preemption: Fix the list of runtime-selectable models

 Documentation/admin-guide/kernel-parameters.txt |  2 --
 Documentation/scheduler/sched-preemption.rst    | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.34.1

