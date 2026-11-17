Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924670;
	b=ZowQZgIyIsMAiHSGxL/35HLzCEW49+TPjfbiUp0kA+Fx5btI3o9cfDUh80wSx/AAihMp
	 KGcjnRz8kSvsGwbOfJZg+eYQDyh7j/wD+briyn+DndrflMZ/z5Ta2XYaI83eZsn/NtrLZ
	 IKUDKPNoD+4QUL7Qoz46Gx4GO+DKNfiV+NWQ5uVmKea493cyiH1x2gLTdBbNOnFmchTX9
	 Hj7t/BrjB/S+/01OPBJDYuMmxW+lt5VKeKPansvERrWM3h6Bva/98jAZmagXskuqOAacu
	 hMsD9wMWqG7of/R50zt5sxl1om9JYX+8znv8TK/1d25mM/VZHtb75X+2eA9vaMFyEIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924670;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=92AEzLw+pRmxtZyE4Naone75crazyPQ2ay8g0auSHNQ=;
	b=PaXUCQZ6Ou3S3PzDOxBvnqYmGTN31quvhj75VVzQEYAur+GXnZIbwkyHXVdV6Rk6wk3d
	 PnyJ+BoMCN+4M0npyUxC6oYzXnL86kS2XN9Ptaz37fODC4673hIUpPObNbYkyY+PULU6L
	 Wy9S0i+dGIkSkN71PnqdExHYnHiGrdZtuUONdH0Cy2nNDdfpczgEWj+bEoZzfUeTFoM0E
	 OPPgcNl17Sl2SvicFGdtcwra4k6pRilo7aPYZW7j0+Wme17IjCm72wqG/wU95+uU4q0BX
	 ullTECG6qu06NQraXJ/WVYGe8YUV0+lruEDH9rgRjkjqq+TCP27cniw06ilV9L/dkWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HI4T3hmH;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BE606A33D
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480BE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HI4T3hmH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924664;
	bh=92AEzLw+pRmxtZyE4Naone75crazyPQ2ay8g0auSHNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HI4T3hmHsIfiKkzlPWf6Wv8Ot2mQGUEg58oieVQQCdwFurs+1MwXA/zcEV+LZ0SZV
	 JvzsLtw+O+wUY6Gnh+ZFRdZQzyFAeq7hvEf7PzmQIqCuKcICXIhX4vmQEC9nLBdPz3
	 wCCqI5b4CMj0aOYyxrHkyaKxrxzM+tDkKkeYsIRlQ47zbjJjkvsrl6QUD5GSRAZcz/
	 iLWRWV+i2Oj0QPldEr6BCg0W+BCXjeWt8Fqeac6EP+OkjijkGvzO1ZDdb0sSLfXMI1
	 Bbh1cTZae8KeS31wczha8LPj4qVOzpFgLGk2lUlrC2OwefvNNv3v8TlApXyv5iOzxN
	 /3DFFkD1OhFQA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV03HjlzRgn;
	Tue, 17 Nov 2026 09:11:04 -0500 (EST)
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
Subject: [PATCH v7 02/40] sched/deadline: Do not admit bandwidth for parameters that are kept
Date: Tue, 17 Nov 2026 09:10:23 -0500
Message-Id: <2e7e71011a00a28230a9d917658de1cf1a6f520a.1794922146.git.mathieu.desnoyers@efficios.com>
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

Found by reading, after the Sashiko AI review of the first posting of
this series raised the boosted case of the previous patch. Not
reproduced: the parameter change must land inside that window.

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

