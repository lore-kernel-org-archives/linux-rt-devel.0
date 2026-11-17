Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924679;
	b=l1DrzkOwe+oN0vzVK0U32v9GZk3HZBuK3bUlvOP2WjRGD8XW8Qk5iqFlQpRomtGNEYzk
	 FIG1vYbubGjDlh/mzpppZXjV+5C+aV8ls+iDc0Aem1OVK8qyehrBxbiAab9qKDFZc+NK/
	 F4GSNbufJB8w2IA9ebJ+86rF3dyShyDRM9iwgyTxn6U/KrCyaWZbnKZC6mdG0Gt9KPgvB
	 SQtDqeybldE7w+VQbG51gesNXGWd4qIVivk21CYpUScxvj9Bl0dMFa/nZiuHONu4yBuRD
	 /+B1FvkXIVNchc7Uf/ZoRYQhKAc23VEcwpmfJqwZisg5T0h/JpQlCUNoVw/F5ijHwng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924679;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FP9MD/yXiHXDDJZaRzb/OHA792mH9cWBCRiBUHF3JYM=;
	b=YvGvWXvBWkY/WZr8XGX7pRHKcfutmER1dX3ds0nukHcGwN932sTeNcJHeKjfumrIsdUA
	 W3rBpQ7uu3yjX9lpAtdGutFmEalBhvSK23jDPXtgucPVFQQ7Wj0cetCLE0xUbOzci1/IT
	 B1jT5znWRPg3qeNdbNXp/vNEEnAaGCuiaeokhDBeRVFd146t91IxaucEfn8yPlU2rcZkU
	 GxKBWAvq5vBJ2QHcPxAICq5iov+voFI8TlctCv5MwFWuH8mULLwFmR4ZNekacqieqxOJW
	 JiaJxouNyu5K47TrmyjYTI8MrkQOyltLHWK8X53610BkbADdnoMrduFDqlfe8EjJciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Jy+DXPhd;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55094606E331
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55094606E331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Jy+DXPhd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924670;
	bh=FP9MD/yXiHXDDJZaRzb/OHA792mH9cWBCRiBUHF3JYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jy+DXPhdrAO3XwCqdWXJkz6lOwhuvguvDnNfI+hf38X8XDoMh2UDi96xjgOdc4NBX
	 OVB8RdTvNQF66Zrtq4giBBzq/7ubMXoR2pTPrKiZr27/O1QlVKBHjoAjdu5UtwFcF+
	 R/xgX8K1uLUMXeOYbs4U9SpwrtO+Kpp64zXFnrv2NEG0NsLmhf0lmrp+096HJnqRaJ
	 72fFjBOJyqa1fLc+OMC7r3kf45stwF4nd7OZRySMPHmfGS/zuoApoIpf0xrqiD4q2w
	 KMxJy/hEOjyKLTaHU11pFGBsu2bDPpirDlA9FB9WiHYxzVejRuf/0+9ga1IAgaLQCh
	 3PcXpXQs4Y5Zg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV6421yzRHS;
	Tue, 17 Nov 2026 09:11:10 -0500 (EST)
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
Subject: [PATCH v7 34/40] sched/deadline: Cap the runtime left of a constrained task at dl_runtime
Date: Tue, 17 Nov 2026 09:10:55 -0500
Message-Id: <a26053a5f8ceae9f5b3e5e587d3f73efdba12762.1794922146.git.mathieu.desnoyers@efficios.com>
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

sched_setattr() can change the parameters of a SCHED_DEADLINE task. The
task keeps its runtime and its absolute deadline: the new parameters
take effect at the next period. At the next wakeup, update_dl_entity()
checks the runtime left against the new parameters.

For a constrained task, that check uses the density, dl_runtime /
dl_deadline. Commit 2317d5f1c349 ("sched/deadline: Use deadline instead
of period when calculating overflow") made dl_entity_overflow() compare
with it: "We care about if the runtime can make its deadline, not its
period." Commit 3effcb4247e7 ("sched/deadline: Use the revised wakeup
rule for suspending constrained dl tasks") then cut the runtime of a
constrained task that overflows to density * laxity. Both bound the
runtime by dl_runtime only while the deadline is at most dl_deadline
ahead.

A change to a shorter dl_deadline breaks that. The old deadline can be
farther ahead. The check then keeps more runtime than the new
dl_runtime, or computes more. For example, take a task of 50ms every
100ms with 49ms left. Changed to 8ms in 20ms every 100ms, it would wake
with 39.6ms. It would then run far more than its new runtime in this
period. Admission control already counts the new, smaller bandwidth. So
other deadline tasks could miss their deadlines.

An implicit task is not affected. Its check compares with its
bandwidth, which bounds the runtime for any deadline.

Fix this by keeping no more than dl_runtime before the check, for a
constrained task. A boosted task runs on the parameters of its donor,
and is left alone. The runtime is signed and can be negative there, so
compare it as signed.

The cases change_constrained_new_params and wake_constrained_new_params
of deadline_bw_test, added later in this series, test this. The first
changes a running task, the second a sleeping one. Both fail without
this patch.

The Sashiko AI review of the sixth posting of this series found this.

Fixes: 2317d5f1c349 ("sched/deadline: Use deadline instead of period when calculating overflow")
Fixes: 3effcb4247e7 ("sched/deadline: Use the revised wakeup rule for suspending constrained dl tasks")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 90b17969554b..1a07f4109cc5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1389,6 +1389,25 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
 
+	/*
+	 * The checks below compare the runtime left with the density,
+	 * dl_runtime / dl_deadline. That bounds the runtime by dl_runtime
+	 * only while the deadline is at most dl_deadline ahead. After a
+	 * change to a shorter dl_deadline, the deadline can be farther
+	 * ahead, and the runtime left larger than dl_runtime. A constrained
+	 * task would then run more than dl_runtime in a period. Keep no
+	 * more than dl_runtime.
+	 *
+	 * An implicit task is checked against its bandwidth, which holds
+	 * for any deadline. A boosted task runs on the parameters of its
+	 * donor. Leave both alone.
+	 *
+	 * The runtime is signed, and can be negative here.
+	 */
+	if (!dl_is_implicit(dl_se) && !is_dl_boosted(dl_se) &&
+	    dl_se->runtime > (s64)dl_se->dl_runtime)
+		dl_se->runtime = dl_se->dl_runtime;
+
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, rq_clock(rq))) {
 
-- 
2.47.3

