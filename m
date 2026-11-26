Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655355;
	b=Ip28rFAz/sOLVjItGSUnJe0kH4vBCZ0qX3Zz0bOatunyWscsmdvqkZIsQRlgpdVt3PJZ
	 9OF55/HU/jfEzvXvQUFeym+Z3t3z47NsnOhYi7bzjS1ZhL7ZP+Oq0sZ569unkcfhvMCYH
	 QSokxbTBfqPwn8RfPpOawDV6r4n8bCbGXfvcGqa+hjZh+zZGeiUnvwyp6ZyfCxbCs6k9i
	 5FcxQosLI1uB72F5sf2fmlzeKBlGN/9VxF9XBcieEeqdouRtmIfRE76J9Gxgwxomr/qac
	 uQpXrfzwDK7zxAtuQN1yKbPmeidAj3+762VhfkUT1+KbUVJmvGdfT0zRXxgZOsYn3fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655355;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uv/C27lvUWYsJil8n2nsOZ9Rw1t3A6CD/wl7lMb7A48=;
	b=A103INwNMnwqU6QEWjsM7bcw/DbtUNQBGwcxMrUxxYSsdyQ97KXMhleMVJv1wsvfTVu3
	 BmRbRl9q2z+w8OTaVztKnJL3N77S7pwuquUANL4Z5oST4lZFnDFdDHTjuE9oDeVqLcqRp
	 scUCbhJUU3NbGSKlu/XQKwr+HndqWhL3CYpQjahwto8jNfixaRoUKAai/py4j02XYviN9
	 Ia873BLJNoUaZSW7cKak/4LPp19ErVUbIEtIB+sCZQBIOaun5eyCIZhfrPViuN+4WaEyV
	 UWrQ15WJFci3MVpApWHIjfcC+/T6fErYGLLEqt9KFBf6sPRPxlhoXgHTAQVe+vSw9/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=vZWcbKBK;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BC606EC6F
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 01:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A96BC606EC6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=vZWcbKBK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795655353;
	bh=uv/C27lvUWYsJil8n2nsOZ9Rw1t3A6CD/wl7lMb7A48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vZWcbKBKBr3gC30No7vuqmH9pO/fYye9TDNg4HP0Q+FD1cBJ74JasDmsh48ab+E5A
	 S+RhsYDGYvHP16GeFDJPa5eMopXSzYT/ej7v5ZawfAvrcNRJ0LSCGUfd7041LjcnRY
	 1qmcV1XcnQKRe5Op9PFoLy0P9RFG2UBQpdC0ui3vZMDQr6fjhohr6bDbl/yDQdMN2S
	 xDQJ9DTlqaT9GS19c0FgPJjZ4sA08zMKf8o3lQxgvb+HbXte3cY++o/PSKakVoWltT
	 0CtMGFPPOwmN6HL8CYANP5LjdQ+LcFbyKtG08e2tKlCxZJ55K04eNq+VoalIAbj7r1
	 Xp9Z+wU4/DtoQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jZdjj203wzWWD;
	Wed, 25 Nov 2026 20:09:13 -0500 (EST)
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
Subject: [PATCH v11 35/43] sched/deadline: Cap the runtime left of a constrained task at dl_runtime
Date: Wed, 25 Nov 2026 20:08:34 -0500
Message-ID: <5df20553606c28d4083b679380395301ff942231.1795646914.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
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
index 828923a77107..6e4edadddf24 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1648,6 +1648,19 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
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

