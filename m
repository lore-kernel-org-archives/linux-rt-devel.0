Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924675;
	b=JXh5JbX2XDQZnFrUTCtVAMMYu/gldno/XJsXcRarfGdejYSvuzMbcqK4jUOmNnqGCgd8
	 TZ6xys5yrp3U4G9dL6Ic2g3Njy/6PH2nUE4rlAng2pTgr6DFoNRbzsayYvf08G32UbenS
	 PHNcNZhoKUouxdcI0pzsFsFhzlEd3fHY281A276wB+z325ko8TAE6Ef6hVaj4qeKR9Ljn
	 Z9ke1fJUYNm5UyKZkDkJRjbnVvuCcqLvR6fBTIz4CjJ8W3BQrHR3aXnArWnkIeBqJeAUr
	 62Zmz+cd8OAn59lWhVvB5MJJwnCaIZ3cT+sBclCdd779Fe9Z5wo96B2dXJU+GNjzPGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0mpHTZ1wTWSyVYujmTmJVz2NigpNkoFUGWUyz0iXGUA=;
	b=KVzVzCKmxEZeJkV8ZJMHUTW3H0tHNM4C0xkvrATJz+RPduosSjRRAQrgJIB1CMw/i74u
	 vA4Xu3NJioM6ktR8OhEp91b4zS0Td9JEXFqUgbP8upJ94R0mm6ZBmeeiet1nTOB7UWSuw
	 BldGVCuXAwZ/1hlrw1JA54jNCa99CgVTHco/IFkp9TQXN0B1tKBsLlHf8G37Hxi+roSt+
	 kA9a5CzUdAdb6MFGhlWrKt9+D0FkFYmFB0grpSKaZ9/kzHddoykWaLvnra9ecoWfWeO6k
	 KVBXlsuKkTflM1RtttrK6BmTd/Ysf2uxRTCCTucGtM8ym5TvFcug4tH6QqNtT/zapZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="MWhH8vH/";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FE606A8BD
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267FE606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=MWhH8vH/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924665;
	bh=0mpHTZ1wTWSyVYujmTmJVz2NigpNkoFUGWUyz0iXGUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWhH8vH/Di8WSKIoOslI/Kj+6VicLN4cBsD4mdkfmi2yts4DSr7Awm4AgJYjq3Nia
	 7+xL2YRBS1OCSrNhwy0YAqObpEOGEXznNx+h+EgcLPZi4pRKcpz2xa56bNXC+t+AcP
	 p2+XQtemuOYHdh5ckAjsrMibar1OHAIq8KZmKy5LmZDtQ48pE+OiphqBdHmmCUYR+o
	 w09vc4LzWekvHJTE4yUd5Z+7DRei5eog4wxYiWsBgZBRlCHweBY1ug7l3tlEuEcE8g
	 wiZIqR+g6lt32INpQvzlvLDv5WLKVbSFJfNICPIdJxqMvOrQq68A4YMb7KROmZTMhy
	 M/jthicYhvbyg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV10RkQzRKN;
	Tue, 17 Nov 2026 09:11:05 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	tglx@kernel.org,
	will@kernel.org,
	boqun@kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	parri.andrea@gmail.com,
	m.szyprowski@samsung.com,
	kayracizmeci@gmail.com,
	weihengqiuu@gmail.com,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v7 05/40] sched/deadline: Refuse dl_server debugfs writes while the rq is offline
Date: Tue, 17 Nov 2026 09:10:26 -0500
Message-Id: <2bee6a143319301f082855a15274f0563e99b8a5.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
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

Commit 4043f5498416 ("sched/deadline: Reject debugfs dl_server writes
for offline CPUs") refuses a write to a dl_server's runtime or period
on an offline CPU. Its message says that such a write has no meaningful
semantics.

It tests cpu_online(). But during hotplug the CPU is still online while
it sits in the default root domain. This lasts from the rebuild in
sched_cpu_deactivate() to the offline, and from the online to
sched_cpu_activate(). That root domain does not count the server's
bandwidth. A write in the window still goes through admission. With
admission control off, it changes total_bw there. On v7.4-rc2, a write
of the current value divides by zero in that window. The previous patch
removes the division, not the write.

Fix this by testing rq->online instead. It is set under the runqueue
lock when the CPU joins a root domain that counts it, after
cpu_active() is set.

A write now fails with EBUSY while the CPU goes offline or comes
online, as a write on an offline CPU already does. Writes at any other
time are unchanged.

Applied without the previous patch, this patch alone also stops the
oops. The reproducer survives 20 rounds with no warning, in 3 VMs of 3.

Fixes: d741f297bcea ("sched/fair: Fair server interface")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/debug.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e6a3b516c703..e0d6cd3bd607 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -410,7 +410,15 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 			return  -EINVAL;
 		}
 
-		if (!cpu_online(cpu_of(rq)))
+		/*
+		 * Refuse the write while the runqueue is offline. This
+		 * includes the windows where the CPU goes offline or comes
+		 * online. The root domain then does not count the server's
+		 * bandwidth, and may have no active CPU. rq->online is set
+		 * under this lock when the CPU joins a root domain that
+		 * counts it. cpu_active() is set before that.
+		 */
+		if (!rq->online)
 			return -EBUSY;
 
 		update_rq_clock(rq);
-- 
2.47.3

