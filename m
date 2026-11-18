Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032411;
	b=inkQMxVBYIKCGVWx0C24TJoI8mLPGUhW/T7ICvvFU0Jup4qNSNGcOgZKieGrRVjmn5Tc
	 lAOOm444taRrJSjVkdN5NHpnaixXbWzVroUSIUzyvFGPIoYEJUSzjVyHnwA/Mh1EqRE3C
	 HPGhLTpeHHxZY+kjaW75kmR21fCaijQLE/o8Cs75ar6s6RYnJyROL4TzcL4ZJRmque9wL
	 4+dtTR/PabV1MZSJrwHaPoAGDWufccns+5Ti7JTj8exbollQo9jvX23oUpGj4Qltvobki
	 SSZcqqg+rng7F5DLpBwbbU3TXOiyJg1UOQmBiygtPJd+HEWCKs8f0k3G97aiVVqbkow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032411;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VF8D/NpkOVfXwYS7vocB3YSAlBjCCPP6hp45RuIin7I=;
	b=UVLlCiFsAxoaE75ynC0XyPgyq+QSCGb495FVZNyTvowDMQrSsSHnH32FF3qIJBIQc9L1
	 1pnX1c3ss7077Qd+WFny1DhtVhkRja49JXONEQmOqfesxjigE4NOtqD8ovObfcbHUz49c
	 IC+UWv4K26lTEZeYFL9vFfyBYiVcVOMriNHSYL+bdZMJdDJHsPc6dAM8NoQJoixgDQZkZ
	 9URvrMAgiBGo8G1UW4VeZ7eFpM7Tt+SYdRlsn2Y9qJs75xv4IZSLparBmCyujjmy1Lqsn
	 n7gxO4pIzOr04P/UA9LV8PfljaXX+6oRU3YmiEcEudquLOAjS6YubereCOM06ccwYbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Hi2EISyv;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B4606A338
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 20:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75B4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Hi2EISyv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795032404;
	bh=VF8D/NpkOVfXwYS7vocB3YSAlBjCCPP6hp45RuIin7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hi2EISyvOnJcElxOyH8l0Qc73zxBKiy4smLQIp8GrywggGpyVM5fDogrIOdhVUFlK
	 t0ujf19xwMYygQWJ4N0hf9Ue+4wAMTR9JtTpEO3ssCKP0pFmZPwVrodCdLPMEkxYZb
	 E2lJ3wJJL67z7FVyd++4FsDRC8Ev4XwajmiXC4w6LMcFZ9gsxlj5MsLw+RLdU7vibB
	 q6YVu6TwZ7o4FHPYTSpht3IYEy8uUfs002Lth9H8Z3/E8GHCneGJrpJ5pz1gq8d02M
	 1kbmvF/2v/9H2A3otMP0WlWv37rehJuvuNFj3btMExeqr7J4gmYUhkzBNbrys4NSwm
	 vbpeOAb+brpEA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVCKv6d5gzSJ8;
	Wed, 18 Nov 2026 15:06:43 -0500 (EST)
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
Subject: [PATCH 02/16] sched/deadline: Do not admit bandwidth for parameters that are kept
Date: Wed, 18 Nov 2026 15:06:27 -0500
Message-Id: <ab5b150fe61d5db767aa98f1b1255661ad5de333.1795031605.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
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

__sched_setscheduler() runs the deadline admission test on a request
with SCHED_FLAG_KEEP_PARAMS. But the task keeps its parameters: the
call skips __setscheduler_params().

Commit f4dddf90d58d ("sched: Skip priority checks with
SCHED_FLAG_KEEP_PARAMS") made sys_sched_setattr() copy the task's own
parameters into such a request. Then the priority checks pass.
get_params() copies them without a lock.

Another call can change the task's parameters before
__sched_setscheduler() takes the runqueue lock. The request is then
stale, and dl_param_changed() takes it for a change. sched_dl_overflow()
would put the stale bandwidth in place of the task's own in total_bw,
and in this_bw for a sleeping task. But the task keeps its own dl_bw.
Its release at the 0-lag time takes that dl_bw, and the difference
stays behind.

Fix this by skipping sched_dl_overflow() for SCHED_FLAG_KEEP_PARAMS.
There is nothing to admit for parameters that are kept.

Found by reading, after the Sashiko AI review of this series raised the
boosted case of the previous patch. Not reproduced: the parameter change
must land inside that window.

Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/syscalls.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 89b0d5787f45..6f8ce5fd94a1 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -690,8 +690,16 @@ int __sched_setscheduler(struct task_struct *p,
 	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
 	 * is available. Keep this check last. If a later check failed,
 	 * nothing would give back the bandwidth it reserves.
+	 *
+	 * With SCHED_FLAG_KEEP_PARAMS, the task keeps its parameters, so
+	 * there is nothing to admit. Such a call changes other attributes,
+	 * such as the utilization clamps. A deadline task does not use its
+	 * clamps, but keeps them for when it leaves the class. The
+	 * parameters in attr may also be stale: sys_sched_setattr() read
+	 * them from the task without a lock.
 	 */
-	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
+	    (dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
 		retval = -EBUSY;
 		goto unlock;
 	}
-- 
2.47.3

