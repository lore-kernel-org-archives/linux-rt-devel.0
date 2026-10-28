Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155454;
	b=NcenzZ0eSk1SWnCreDHe+rMqFH2gXjNtgMf70GcZ6uXfDRLmDcP1nWmozwdC9M01hC5h
	 MYZh6LnLrYMdorI12Ji+TxoKXbr03+flPzONrj9sajXHstXfiN8LFpOF5XeNMZzgLSphb
	 tI/JplpVG24xVhYac27xyrxrj1UfXLFRSt9eWsTG/0NnE0vBa/mGLNCSUAgvBd9D+G7s1
	 B0tKd3nX4zIMGtQ6Pdz4HQb3W+03Q39S08vofz2HVbtelh2AdsIHeWorMfguWiMdbyYKO
	 eGidXVdS8FfcEl+9FQ0vwEPw2eGydziIR2y36CqLyOKny+zXsr4fw7NBExHblDnKvCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155454;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=oo/01Jp9FjfS/2vPevSBVo3jb7P52PPUK77gNUPhv1Q=;
	b=yk6/yiOUWryjleZypoYSE8/QTnc54uksqVIyfPLlko+HWaoMIIWnNjdOIj4R46+iPJAV
	 KQxH3KZ+bHt+hxIECA+JrcSOmkh7tJnPIRt/LKo2gRRaQWWATQef942bsUIu2Z/429jw5
	 e0IJ4s5jpGluzbmu89+MGh7c+jGVVcVQIdZ67wwP3pBenR8C6sKBfZamFLcfLi7mliNGs
	 pZBQ0y4nE7UxlXxWkPXBwm6XqMlawu3SCGW7aWLLIk4peWkXlTSY3ALkBcuol4aZuZ87h
	 OxWrw7e5Rjqt6j5vRxfXq72vA+NLYWMomV+PaGHEGVL8ONFZsmfbzZvn51BTlHhyBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0ya6vdEb;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391A606A31F
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 02:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9391A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0ya6vdEb
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oo/01Jp9FjfS/2vPevSBVo3jb7P52PPUK77gNUPhv1Q=;
	b=0ya6vdEbU5Mfqn1RFJsUVc/88GAzKW+T/UBkDTmNWfJgQMH59agRyxVZ/B5GgYIouxxqL34nX
	ENUgBMJZecIpIWCm2y0m+Ybkgmxt7UvaBglR10oSURNSmBD9j1FyTesjKhpX6FGSWa3GyFVks2T
	0aAqqT2OD2zbiBGNYLNk1hs=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jDsBV60Xtz1cyqv;
	Wed, 28 Oct 2026 10:44:02 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 688134057C;
	Wed, 28 Oct 2026 10:44:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 28 Oct
 2026 10:44:08 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<bigeasy@linutronix.de>, <clrkwllms@kernel.org>, <rostedt@goodmis.org>,
	<rppt@kernel.org>, <arnd@arndb.de>, <bp@alien8.de>, <kmehltretter@gmail.com>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <quchaosheng000406@163.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 1/2] docs: kernel-parameters: Drop unsupported preempt= modes
Date: Wed, 28 Oct 2026 10:43:32 +0800
Message-ID: <20261028024333.795917-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028024333.795917-1-ruanjinjie@huawei.com>
References: <20261028024333.795917-1-ruanjinjie@huawei.com>
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

Since commit d3d16750693b ("sched: dynamic: Make PREEMPT_DYNAMIC depend
on ARCH_HAS_PREEMPT_LAZY") only "full" and "lazy" are accepted with
CONFIG_PREEMPT_DYNAMIC: every architecture that supports it selects
ARCH_HAS_PREEMPT_LAZY, which excludes the none and voluntary models.
Passing either is rejected with "Dynamic Preempt: unsupported mode".

Remove the two lines so the parameter reference matches the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fce0d52b9cfe..11f0b700d56a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5428,8 +5428,6 @@ Kernel parameters
 
 	preempt=	[KNL]
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
-			none - Limited to cond_resched() calls
-			voluntary - Limited to cond_resched() and might_sleep() calls
 			full - Any section that isn't explicitly preempt disabled
 			       can be preempted anytime.  Tasks will also yield
 			       contended spinlocks (if the critical section isn't
-- 
2.34.1

