Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790184;
	b=S8NQxd+KXCzEHPbZE4gZhVcpI3MeEoFm2DU0YvZmrZ47GhQ6LInU53vf/J1rDiUgaUaM
	 RkujvWLvAJ4tG25V+4zdPjwAPA5y/8VFbqtwafYQkYa7CHkbjobnbNmtvVT79SYq8Jnlh
	 CpoiP3uCcmxXUtSBYCDypkz3EdlFpey3mVNbQbkw6rJw81TRLgxhSAK680UOY8Z9KRemN
	 B2Z9017iRlTnOSuRvL05ipuBRWOJ+5kKl9OHzTRdrb/eCKsvUGdncy16rskES/kPNCpP5
	 yjZOrvun+2+7opCgEpcC2t2w6SQv8lHARJqN8l8V5ESeVTnCtF5mJGz4q+LK/hhlRHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790184;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=llgoDA5m9FpaZqhoTWbUzXCdS1sfPDCt8phc1DUxitk=;
	b=aCiNOEDw9H7hQxJLyexHcGGuwSZVqvb9DUt3OgqFF4+fhG1Z2bMUGJLk7mI9ESefVZHS
	 w8FToIa/prWDfaLws3T/0nEyE7toEljf95uiROCHYn/Yjs1mk5Eu9UmwPNBrIuDKePajK
	 D7EzwoddueMgJwbOaVqUDFQ8SpKFszp6EoauJCDbdp1oi+bxmznwBe93l8Nq6q15O/7R8
	 lStGasi9R0loPRmDRdqYw+YdCSA33Fymuu/zETbFlCmPMi3Y6mTSUInX/B3ZKpXNbDRLy
	 yXVX9B+dpkBpEHNgPy6albnu2e4a7PPKdla2fQPkq1PSq7l8S19q7dDVhPxVSBS5RtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=wLEVJxoO;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8E606CDB0
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 14:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F8E606CDB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=wLEVJxoO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795790179;
	bh=llgoDA5m9FpaZqhoTWbUzXCdS1sfPDCt8phc1DUxitk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wLEVJxoOoT/s/92DUTC4TGDW6ci/xvjLHx2ek+tLbbBo3Nl7MCehyP+Cf4jtERk8N
	 kgm3ahUgFKdHe8m3+2TX9CJu4mgzWOPUDBY6dq7l6CdolqZDyUswD2TS8Zedri0Glm
	 L/H1ul10Iwjec3HvMeIMAmMVqlfFWyWJLztix/IKN/HY/a29OEGUo3lp0PgtwDxzWB
	 vo38AWosnLQQtdOiRC8VsLcAJMvMve9uSm3P1blL3sMH6yPdi4rE7+whbqKfyUBSMf
	 Adpm9A5xALWam6ULWlWKuZfzkHegc9b2oeTAupjAEo/DtiA23DilmhhxxDK98iHXWs
	 8CsIQuwsjJl7w==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbbZW3LvlzXCQ;
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
Subject: [PATCH v12 34/43] sched/deadline: Cancel the replenishment timer with the parameters
Date: Fri, 27 Nov 2026 09:36:01 -0500
Message-ID: <bf332219b2e9744e536502a4eb04baa0674e4fa8.1795771148.git.mathieu.desnoyers@efficios.com>
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

A task that leaves SCHED_DEADLINE has its parameters cleared at its
0-lag time. Its replenishment timer can still be armed then. If the
task comes back and throttles before that timer fires, start_dl_timer()
does not restart it, since it is queued. The replenishment would then
come at the period of the reservation the task left. Too early, it would
give the task runtime it has not earned. Too late, it would delay the
task by up to a period.

Commit a649f237db18 ("sched,dl: Fix sched class hopping CBS hole") armed
the replenishment timer when a task leaves the class. The timer then
reset the task if it was still out. Commit 209a0cbda7a0
("sched/deadline: Improve the tracking of active utilization") moved
that reset to the inactive timer, at the 0-lag time. Nothing cancels
the replenishment timer there.

The timer of a throttled task fires at its next period, which can come
after the 0-lag time:
- A task that yielded is throttled with runtime left. Its 0-lag time
  comes before its deadline.
- A constrained-deadline task that overran by little reaches its 0-lag
  time before the end of its period.

Fix this by cancelling the timer where the parameters are cleared. This
includes task_non_contending(). switched_from_dl() calls it to release
the bandwidth of a task that leaves asleep past its 0-lag time. A
constrained task that overran as it blocked has the timer armed there
too.

The Sashiko AI review of this series found this. It has no reproducer.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3eeb4c5cd924..94d2b962208e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -993,6 +993,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 				if (dl_task && READ_ONCE(p->__state) == TASK_DEAD)
 					sub_rq_bw(dl_se, &rq->dl);
 				dl_task_release_bw(p);
+				cancel_replenish_timer(dl_se);
 				__dl_clear_params(dl_se);
 			}
 		}
@@ -2932,6 +2933,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		}
 
 		dl_task_release_bw(p);
+		cancel_replenish_timer(dl_se);
 		__dl_clear_params(dl_se);
 
 		goto unlock;
-- 
2.47.3

