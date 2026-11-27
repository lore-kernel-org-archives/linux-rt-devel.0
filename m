Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790184;
	b=gGr38CPflgaLxFNjNHzB96hYd8tyimZMPyrdjbQ7tYb+o12rsvMTquLVXh/hhFlGXWk2
	 LqBn2U+NuSmgFaMAyUDGdKClk3rfohYlYrlv2y/2t26vU1ozrML8hobt8lox3htCjm7dj
	 YOUfK9qNBd97JJL06RBwgkj1CG8PKroE7CChcoT9dG2uve0rR+xkK2QOXlWE4qYNwwDr4
	 cyfl3Ft4oj6IjlHr94VPi4bd3moej9mCkoD3x6oKUfir0TbFskt0osj8xA++wgoxirJph
	 fGZAsqtn+mgQgwqrQJHHflJ67GrBZgNPSeBvonMvJosyq+YtU7IxBUbvj1a0ay4AvSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790184;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZrKZK1tulnHYrb/IyHDGx+cORIgMTJVwR5ksYLUbo8Y=;
	b=kCNUuGQdacaiJuLJmJvQ8OG+whYFTuEazQ4lwXyj0asrGYXufUxKFhyxjXQl4IHBTot7
	 LE1vRgR7oTi3j+FgNZz+A/2/VCclu//hlBWBCTLPu4yjam/wyIncaYsrhnAgyK7NB8uRA
	 zz/Bz6sxMMDG+rK4Lhoj3fhyFzTwx+gwVlecjwMFTwkfgJTlEWf2V3qBhEPe8mgaBdWqL
	 +Wj92INQXvg5ked/AmOYlTTh2XnwBBmGUXhnsCtcxWUATtxb2Vj3QrdD12J7mPInCyCrg
	 CL/q0bPA5mLZ6qc+Wu+wHlk3yCH8iN+RLzt89nnCcqTFJK80ncxSKKmFTmqjpZUQlGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=GLduOlfo;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577B606A6B4
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 14:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D577B606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=GLduOlfo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795790179;
	bh=ZrKZK1tulnHYrb/IyHDGx+cORIgMTJVwR5ksYLUbo8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLduOlforyCL3mgZlDt8snED6VvSqWtULyQf8Us+0pMxJRlISdrn8U7lAU6f/QYWQ
	 rzri8zb3yZ+sBnQsvijfaw/EfNYrM/A5g2qg3gUrNyUR89PXeXkuc0NA8+zypsOJzJ
	 xOY43PM8meC8XDY2iK2Az4urRqkMkOigA9JsRMWROIQ8LmaP7YTW+I98jk3wKcX8/q
	 98K+shozlcvEhr+xcg8ahMEIvq1mVLbZLWlD8jWunrUYPobc1rpW5Cm92mKqK7x4+N
	 EeCfQg2oVTmDxvAzCANrjxAjcj9pZY6O3pPILg1qFUmP6i8abrBwFggwZ5JvYsy+/r
	 fzkezGkc1WMYA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbbZW4dPyzXCR;
	Fri, 27 Nov 2026 09:36:19 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	tommaso.cucinotta@gmail.com,
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
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v12 35/43] sched/deadline: Cap the runtime left of a constrained task at dl_runtime
Date: Fri, 27 Nov 2026 09:36:02 -0500
Message-ID: <8865f3fb6a38b5a7a3ed02a49da62ce13a447adb.1795771148.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
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

After sched_setattr() shortens the dl_deadline of a constrained
SCHED_DEADLINE task, its next wakeup can leave it more runtime than its
new dl_runtime.

sched_setattr() keeps the runtime and the absolute deadline of the
task: the new parameters take effect at the next period. At the next
wakeup, update_dl_entity() checks the runtime left against the new
parameters. For a constrained task, that check uses the density,
dl_runtime / dl_deadline:
- Commit 2317d5f1c349 ("sched/deadline: Use deadline instead of period
  when calculating overflow") made dl_entity_overflow() compare with
  it: "We care about if the runtime can make its deadline, not its
  period."
- Commit 3effcb4247e7 ("sched/deadline: Use the revised wakeup rule for
  suspending constrained dl tasks") cut the runtime of a constrained
  task that overflows to density * laxity.

Both bound the runtime by dl_runtime only while the deadline is at
most dl_deadline ahead. After a change to a shorter dl_deadline, the
old deadline can be farther ahead. The check then keeps more runtime
than the new dl_runtime, or computes more.

For example, take a task of 50ms every 100ms, with 49ms left and its
deadline 99ms ahead. Changed to 8ms in 20ms every 100ms, it would wake
with 0.4 * 99ms = 39.6ms. Admission control already counts the new,
smaller bandwidth. So other deadline tasks could miss their deadlines.

An implicit task is not affected. Its check compares with its
bandwidth, which bounds the runtime for any deadline.

Fix this by keeping no more than dl_runtime before the check, for a
constrained task. A boosted task runs on the parameters of its donor,
and is left alone. The runtime is signed and can be negative there, so
compare it as signed.

The cases change_constrained_new_params and wake_constrained_new_params,
added to deadline_bw_test later in this series, test this. The first
changes a running task, the second a sleeping one.
wake_constrained_new_params fails without this patch, and passes with
it. change_constrained_new_params also needs "sched/deadline: Keep the
debt of a task across a change of parameters".

The Sashiko AI review of this series found this.

Fixes: 2317d5f1c349 ("sched/deadline: Use deadline instead of period when calculating overflow")
Fixes: 3effcb4247e7 ("sched/deadline: Use the revised wakeup rule for suspending constrained dl tasks")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 94d2b962208e..8babc3e2ac51 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1683,6 +1683,19 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
 
+	/*
+	 * The checks below let a constrained task keep up to its density
+	 * times the time left to its deadline. After a change to a shorter
+	 * dl_deadline, the deadline can be more than dl_deadline ahead, and
+	 * that allows more than dl_runtime. So cap the runtime at dl_runtime
+	 * first. An implicit task is checked against its bandwidth, which
+	 * keeps it within its reservation for any deadline. A boosted task
+	 * runs on the parameters of its donor.
+	 */
+	if (!dl_is_implicit(dl_se) && !is_dl_boosted(dl_se) &&
+	    dl_se->runtime > (s64)dl_se->dl_runtime)
+		dl_se->runtime = dl_se->dl_runtime;
+
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, rq_clock(rq))) {
 
-- 
2.47.3

