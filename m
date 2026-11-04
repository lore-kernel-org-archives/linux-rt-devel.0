Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805148;
	b=4VuXa2a/oMA+4AzfbAVy13Qr1qeZP2DWUwM4LayR7kX/vLQHw/xycsu/XJIHcEaIgLfg
	 kgUdmlUPjzVVSWJGOXmfi82lM26dnxpj7mct3+3xMUFMnjjlyvl9Aim0EDjHRF49RqQ9Z
	 zlafU+uGLsn70c/zntNljdM8355ZxzC56HTTjhXR1deT6rwelm1Uwv4P6gKNSnkrvgcsx
	 LxWH8eawLkN/FOv2NdBiOdmhSt7d57Ka3AWdqq5ZUE3ANa4H9ZtyWdaLHcwYiIPH7kTYW
	 aacGOaN9dkBOPGNBPHSDo/waEipeFYRlpmaXreAWsHHFyQJpfC8L80ySumAw8opbTSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805148;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eCsYlyeDatWwk3gyqQ53gtawZtD5gGro/bi+HOIZjKQ=;
	b=hxOPSA0XBx2Q6wC7DD4buo2Z9Ue0gEKNqxBXObptksqRBzDuDnDVbLoWS7f5TouL4I+r
	 BtmL4HC7bXF9YihcXwRTSGZ6SSeEpKETYdJ3cTA/Vp+gB85B8DbnlAxgbbnG0l98hyS/R
	 PdPk9Gft1TjbK/c+jBSupyvjM8NNSL2CQkUSF2rvjufK9/feG97HllXbpiiK+X0Airm6c
	 1uIRKw64b4R7DsJA0ClzAP4MPYenHF7cdQyNccdujRyaWldSPSJudWXPB17Fc7WGlzbgD
	 Ua2Tz9ZM9SyIn7xovqVkV+nB6TSPKhud0+6urf/t/jGgsxZNVltWCJFILsJHAbXPpSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=iv43mrsJ;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D57606A32D
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 15:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D57606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=iv43mrsJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793805140;
	bh=eCsYlyeDatWwk3gyqQ53gtawZtD5gGro/bi+HOIZjKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iv43mrsJacb/TGhr9vv8QXMsBYd2vJih0zCTp8sMFX5OwBQp6cQ2zCr5GZFrh5oNE
	 VBb2ExJ3ZuCuOmCE6zAbaR+pADTKwN7jZwJ5+VFKD3P6dujDhXTf7NrNH9T9NpSWf8
	 pX0A9xNq92WBjhhwXgPDP/vEf3EbRjfqkk+ylz4FmlrVFjcCCA5FS1M7zFfG+811/m
	 HaTyVFZAnomoyu/r8QnkvPvfSq06935RZcYMaM2VpeepVnvBbsO1LfD2xT3dGCl7iZ
	 BMWJ/gqNyohseqUKEa7koebRPmMfVrl8KK5mJH6IQ8b/KpFUMdjdMG/gXiDvL+XeBm
	 csdOGe48Q3wYA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKTSh32NjzLNn;
	Wed, 04 Nov 2026 10:12:20 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Claudio Scordino <claudio@evidence.eu.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 04/12] sched/deadline: Do not lose a throttled task switched out and back
Date: Wed,  4 Nov 2026 10:10:25 -0500
Message-Id: <1b0485061f99455deaca614016de741f2091c4a8.1793804635.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
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

A SCHED_DEADLINE task that is throttled, switched to another policy and
switched back before its 0-lag time can be left throttled with nothing
to replenish it: runnable, queued as far as the core is concerned, but
on no dl_rq and with no timer pending. It never runs again, and a fatal
signal cannot make it run; only another switch out of SCHED_DEADLINE
requeues it.

 1. the task exhausts its runtime: dl_throttled is set, and the
    replenishment timer armed for the start of its next period;
 2. sched_setscheduler() switches it to SCHED_OTHER: switched_from_dl()
    calls task_non_contending(), which arms the inactive timer for the
    0-lag time; the parameters are kept until then, so that leaving and
    reentering SCHED_DEADLINE gains no bandwidth;
 3. the replenishment timer fires: dl_task_timer() finds a task that is
    not a deadline task and returns, dl_throttled still set;
 4. sched_setattr() switches it back before the 0-lag time:
    switched_to_dl() cancels the inactive timer, and enqueue_dl_entity()
    leaves a throttled task to its replenishment timer, which has fired
    already.

The window between the deadline and the 0-lag time is the overrun
scaled by period/runtime: about 100us for an overrun of 20us at 20%
bandwidth. The replenishment timer cleared the parameters, dl_throttled
included, of a task it found out of SCHED_DEADLINE until
commit 209a0cbda7a0 ("sched/deadline: Improve the tracking of active
utilization") moved that reset to the inactive timer, at the 0-lag
time.

Clear dl_throttled there again. The deadline has passed by then, so a
return before the 0-lag time starts a new period when the task is
enqueued (ENQUEUE_MOVE, or the wakeup of a sleeper), as the
replenishment would have; a return after it finds the parameters reset
by the inactive timer, as before.

The selftest added two patches later fails its throttled_round_trip
case 8 times out of 8, on v7.3 as on v7.4-rc1 with the four deadline
fixes of sched/urgent, and passes it 8 times out of 8 with this change.
It was found by a cgroup selftest under development,
test_concurrency_deadline, which hung about once in 1350 runs.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/deadline.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 30a52e42c26d..d474fbfd9be6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1232,10 +1232,17 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 
 	/*
 	 * The task might have changed its scheduling policy to something
-	 * different than SCHED_DEADLINE (through switched_from_dl()).
+	 * different than SCHED_DEADLINE (through switched_from_dl()). It
+	 * keeps its parameters until its 0-lag time and may come back to
+	 * SCHED_DEADLINE before then, switched_to_dl() cancelling the
+	 * inactive timer: it must not come back throttled, since this was
+	 * its replenishment. Its deadline has passed: the enqueue starts a
+	 * new period.
 	 */
-	if (!dl_task(p))
+	if (!dl_task(p)) {
+		dl_se->dl_throttled = 0;
 		goto unlock;
+	}
 
 	/*
 	 * The task might have been boosted by someone else and might be in the
-- 
2.47.3

