Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105508;
	b=ezq4/cEpOsCHTEDjEgGfTUdG74xnfJFAkJfZpByOTrp9RL4ZIZrsY+H2mBQjY5OSHOjF
	 873EOGmcDej56LOEUogpgnF7YMIaOsAf5/9oor9ugtnVK6FqZ32PUbVTBWXi2AeFdDZjE
	 CVS+uDaf131LoQPQ6XiyYfXB/rmnnR95Rg1FMymFxROxM3YvlMjyB4OkYlyL++Be76JQT
	 ap4ILMmfz4brdP7XgvBaHyiLRprP1WtHNk7+oLWk4KrjWLcBzkHDQ4LYAh9w8Lx4rryGn
	 a0wVra/FE6J94BzYgeM1Pc8BtorBn7+8vjSLa1CUIR79waEFZwM6qWAKRLaZM5Hyehg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105508;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=18ZdUzzadRsL6aFCNsE+0dn3GNsx1KvXA2R8ZIV+JwY=;
	b=1e/0NCeChiSFO0Y9Np6ZkAv2Ux3LTKgQ3LyibFRJxEEoxqTTw7vsKJA1xQlfxmwG1BDv
	 VHsMiEiEXvNwXwL9deoPdZe4VxIM4UVvRYBKi3p8GKHc+iz7690Zb0yknu5+6Dhnxxpj+
	 9i82dQk+B3ZJfxwbvjfw3EbKVQ4enOhgcUFDwDeMKdB+v6xM7CEl/clMylLyE13hvaWSG
	 s/bihJ9rNAyOVerVaBP8w0or1jiGkP3DLvbsqYbIwr2SS9Afea4ZVakt3Zkc30X4kV7IX
	 2ceTeSfOIquULuSwIbQ9KV70zsqQmtI4vwVhXLoBs2WECY/nzQ3G23uTcRG2IVg0e9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="N5jkM/2O";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC260A5BDC
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 16:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EEC260A5BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=N5jkM/2O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105503;
	bh=18ZdUzzadRsL6aFCNsE+0dn3GNsx1KvXA2R8ZIV+JwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5jkM/2OsYWwYxASdQwUH7EaftABouOuQEsDi4BNWscmGmwiXu3NqLHRSCRUgyNU1
	 Zf66kPEgx+J5t8Nso1+XCHjewfAnwqIZ42E0+v84AHAZ08i/Il2WH3rB7/Lz2iC1zq
	 1Vs2amEFd0ANeZh5w8DFhPZsOwWpAVQZ+khK7lMJZas4KwSyq4sOSFFpbfwZEo1OCW
	 ydauzjobqF4PjZejgFKYlRaNNmiWySt9Wp5fR/+vezK5BUbYK0c/KY/+jWKpy0bC51
	 uqd/pCl2UIOhjEZwIYPAC07uUewTKRemB10OH+p/H+5RfQjmF3HuLYbhAjugelgVBR
	 4DBfe94P9GtEA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkMg03Z4zTnK;
	Thu, 19 Nov 2026 11:25:03 -0500 (EST)
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
Subject: [RESEND PATCH v4 07/17] sched/deadline: Do not lose a throttled task switched out and back
Date: Thu, 19 Nov 2026 11:24:47 -0500
Message-Id: <e58738e763010632a024a6874a97f1d980b90ce3.1795105408.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795105408.git.mathieu.desnoyers@efficios.com>
References: <cover.1795105408.git.mathieu.desnoyers@efficios.com>
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

A SCHED_DEADLINE task can be throttled, switched to another policy, and
switched back before its 0-lag time. It may then never run again, not
even to die of a fatal signal.

A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
("sched/deadline: Improve the tracking of active utilization") moved
their reset from the replenishment timer to the inactive timer, which
switched_to_dl() cancels.

This misses a task that was throttled when it left. An overrun can put
its 0-lag time after its replenishment timer. That timer fires while
the task is out of the class, and does nothing. On the return of the
task, enqueue_dl_entity() leaves it to that timer, which has fired. The
task is then on no dl_rq, with no timer pending, until it leaves
SCHED_DEADLINE again.

Fix this by replenishing the task when the timer finds it out of the
class, as for a throttled task that is not queued. Its return then
enqueues it.

Clearing dl_throttled alone would not do. It would forgive the overrun.
A yield left set, or the old deadline of a constrained task, would
throttle the task again. The Sashiko AI review of this series found this
in the first version of this patch.

A cgroup selftest under development hung on this bug about once in
1350 runs. The throttled_round_trip case of deadline_switch_test, added
later in this series, fails 8 times out of 8 on v7.3 and v7.4-rc2. It
passes with this patch.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b614d5fc1a1a..e4d7cbf4861d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1233,9 +1233,18 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	/*
 	 * The task might have changed its scheduling policy to something
 	 * different than SCHED_DEADLINE (through switched_from_dl()).
+	 * It keeps its parameters until its 0-lag time. If it comes back
+	 * before then, nothing else would lift its throttle. So replenish
+	 * it now, as the !queued case below does. Its return enqueues it.
 	 */
-	if (!dl_task(p))
+	if (!dl_task(p)) {
+		if (dl_se->dl_throttled && !is_dl_boosted(dl_se)) {
+			sched_clock_tick();
+			update_rq_clock(rq);
+			replenish_dl_entity(dl_se);
+		}
 		goto unlock;
+	}
 
 	/*
 	 * The task might have been boosted by someone else and might be in the
-- 
2.47.3

