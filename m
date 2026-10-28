Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155454;
	b=HGvU7vFKSTJdcb5ihNZmIm2igW2aUOKVUmYNFieti6xlZCxfhHsDQN42pp+6P1QyE5aX
	 G+F9UeQSDEqbzcMSe4vu4HLA9ZbhUpqibDD3g6LNXn23qFeZFNTvrzudwVjSHDreejSWh
	 gQXRcPnk+BBdUZw0M0cLXJB1munEjpS/05zog8kJL6PX0pO5SCrnNMCI8jocGK7IXRqOs
	 YkXVjEQQWv59mvcHLCK+X14WJefqCoOTXHRz0Nqge4861XoI1ZbYy4HjteEWeCPvl8dsn
	 neSxsUgIm7SpxrIMMSvX4JL8qjr/ZQreEzD52y/oz+B5MbkRqrOKgrX4dS2Ivd/n5wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155454;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=6amw0xuR/0wHXI09csvyb45ihbeTnCR/nXnfcBWArEk=;
	b=OY2OHOh41uEOQH7Y500XFAk81bapfD8Iw5ndeM79u/WygLiB99ZMPgj2vpjhvYW12DwD
	 WqGwOO/Nzo+hF9EDOv7UpgRUsXwH1ylt2vtNQhisXgjIj9dKFQ9l8HOR9iKh0EZn6mjEn
	 mzxuY1TtT9qqZ/O5goAwCC1IZ2epPojaZOuhM3psHkh2N1uzVXvPwFiTvsgjhgIru2yk1
	 RwvCb3mGmyN9+zWEA77yIKs/Eou97YFojl+ihAaaC8MA7cPnGW0qKyDdLsH6ZC2BxA2FW
	 3bS6ZWI7FS/nwfn5Nk359EtVwPZrI3NORYG77Ic/PzIhKAc3uNFJ28/tknQvJ9SHMlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VVEUKljH;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C2606A320
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 02:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A61C2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VVEUKljH
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6amw0xuR/0wHXI09csvyb45ihbeTnCR/nXnfcBWArEk=;
	b=VVEUKljHGcliCzV63x8BOdvfJCXbmDGPhRz1BVJ+FuT5impFG+/GGSas0NDQA03tpzDZZhOWJ
	Tr7qBDYVrOFlMAsyuNm7/34wXY/CPQ90edaxFGDNh2oDTqi8wdqfMxEE/671aUG52Y9T0MMcGBD
	QPkMl/Ken3s+Fx2byQq5amI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jDsBW5L0WzLlYq;
	Wed, 28 Oct 2026 10:44:03 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1023240572;
	Wed, 28 Oct 2026 10:44:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 28 Oct
 2026 10:44:09 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<bigeasy@linutronix.de>, <clrkwllms@kernel.org>, <rostedt@goodmis.org>,
	<rppt@kernel.org>, <arnd@arndb.de>, <bp@alien8.de>, <kmehltretter@gmail.com>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <quchaosheng000406@163.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 2/2] docs: sched-preemption: Fix the list of runtime-selectable models
Date: Wed, 28 Oct 2026 10:43:33 +0800
Message-ID: <20261028024333.795917-3-ruanjinjie@huawei.com>
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

CONFIG_PREEMPT_DYNAMIC now depends on CONFIG_ARCH_HAS_PREEMPT_LAZY, so the
none and voluntary models can no longer be selected at runtime; passing
either to preempt= is rejected with "Dynamic Preempt: unsupported mode".

Drop them from the table of runtime-selectable models, and describe the
build-time situation instead of implying the choice simply depends on the
architecture offering lazy preemption.  Keep the per-model descriptions
below, which still explain how a scheduling request is honoured under
models used by other kernels.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 Documentation/scheduler/sched-preemption.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/scheduler/sched-preemption.rst b/Documentation/scheduler/sched-preemption.rst
index b48e53587a7a..0b5ddf7d26f2 100644
--- a/Documentation/scheduler/sched-preemption.rst
+++ b/Documentation/scheduler/sched-preemption.rst
@@ -20,9 +20,6 @@ change.
 The models selectable at runtime are:
 
 	=========	====================================================
-	none		No preemption of kernel code other than at explicit
-			``cond_resched()`` / blocking points.
-	voluntary	As ``none``, plus ``might_sleep()`` sites.
 	full		Any section that is not explicitly preempt disabled
 			may be preempted at any time.
 	lazy		As ``full``, except that the scheduling request is
@@ -31,10 +28,12 @@ The models selectable at runtime are:
 			apply to real-time tasks.
 	=========	====================================================
 
-Not every model is available on every kernel.  An architecture that provides
-lazy-preempt support offers only ``full`` and ``lazy``, and ``none`` and
-``voluntary`` are rejected there.  A PREEMPT_RT kernel always offers ``full``,
-and ``lazy`` as well if the architecture provides it.
+CONFIG_PREEMPT_DYNAMIC depends on CONFIG_ARCH_HAS_PREEMPT_LAZY, so ``none``
+and ``voluntary`` are never selectable at runtime; passing either is
+rejected with "Dynamic Preempt: unsupported mode".  The two models are only
+left as build-time choices on architectures without lazy-preempt support.
+A PREEMPT_RT kernel always offers ``full``, and ``lazy`` as well if the
+architecture provides it.
 
 The model that is actually active is reported in the boot log::
 
-- 
2.34.1

