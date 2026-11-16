Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855963;
	b=axB7dPxSLOsVE2u8fAyucJubcQIAejo9c680SPWdNilOO2LpTYoCsKS4zenaEPVu5kM3
	 oxBYblw0G6JA8Zm8ZwyOuMcKVfaGNS3hk2yQqC2f5yxRjZpRx8j9/NyhHdfdeYEYNFEnE
	 zD+JiRWQ9kVXttIvYHrv+PN+wMQZ1pl8SgKnS8Vrb1gIbXrcM3md6P/sHIygORxPzOIvs
	 t8wTunu90aQ0uC1oPJd1ljzRP+wE1OR1t+55wa88MnIwp3OBniOscMgOz3shZXYbHk1yw
	 1046crCfGabz5fYE/k0Ci7qRNkiRFa5+ePzqBZGdZw5bJQKVKEWdf8K5L+TE4e5Y9Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855963;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mIltUQDWgDrAq5CVaYRA9ajYPPZHuvdWTuz+uslCgic=;
	b=h2CZzX6nWSiKoDzZ+CKCUinzqG/QLPE2hSRCoUbzPTwXH6Qq/1bU2k1UTAPya7RkYyvN
	 Jbi/DEqQqOObb9wScrTB/jt8KFu2E+Xea1nzNwH85GlZK4Iu2nr8Xp2ZZCFwERjUAfKZ1
	 BqN36YQuderStHA2Bg2bsBruJIKepMF1tW2k48nvv3wpbn8hCEkM62AZK9YSy1mwlkNH+
	 tKalIjhRxkq46leKPV6qwq/hK39lmR8ZPhMhxud8PRXeUELMAqNt16nd4E6xoSRgFC26g
	 9GuUJwywVnKvjgWcpL7qe2T4AOp+1u8WuWsyEMHWCnm6hvlMsn6KEUDQuYwiOgcU5Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=fiKluJey;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67583606A8A9
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 19:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67583606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=fiKluJey
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794855955;
	bh=mIltUQDWgDrAq5CVaYRA9ajYPPZHuvdWTuz+uslCgic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiKluJey2nQ0ImLzJrI5nxdEc8PG82m+vgmntS/CNLPWNgr08NP7QFDpJG0KoVgzv
	 B+heq5fz7wlncAIImKEsJmm43CtP9HI1KP9vddxAQrdXSyLrIKRTxcAJ9QF/aklx19
	 bjPHBFMe1YAhar5nkEk5BIflc4CgnhLpKN2J5SC0O/t2QZ43zidyq2FO4rynepLwDF
	 1pH/PTGhPkNv8KT08xSZZ82A+MOw0H+FfSZgFjDQoKKUoy44ViSPFs8LbQaOTAqVjz
	 8x59EOp82/yyQDM+eTiCfT0kOVZvF95x+dYh9NS09oAo5ECZWgwdMW66YrDbhSQnsx
	 5DRhI6N2/7B/g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jSy4g0qP4zQSs;
	Mon, 16 Nov 2026 14:05:55 -0500 (EST)
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
Subject: [PATCH v6 08/37] sched/deadline: Do not replenish a boost from cleared parameters
Date: Mon, 16 Nov 2026 14:05:20 -0500
Message-Id: <20261116190549.230119-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
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

When a SCHED_DEADLINE waiter boosts the owner of an rt_mutex, the owner
runs on the waiter's parameters, through dl.pi_se. Commit 2d3d891d3344
("sched/deadline: Add SCHED_DEADLINE inheritance logic") calls this a
temporary solution. The owner is never throttled. When its runtime runs
out, replenish_dl_entity() refills it at once from the waiter's
dl_runtime.

The waiter can leave SCHED_DEADLINE before the chain walk deboosts the
owner. Its parameters can be cleared in between, at its 0-lag time.
replenish_dl_entity() then loops forever on a dl_runtime of 0. It
holds the rq lock with interrupts off, so the owner's CPU locks up.

O is a SCHED_OTHER task that holds the rt_mutex L. W is a SCHED_DEADLINE
task. T is any other task:

  CPU 0 (O)                         CPU 1 (W)                     CPU 2 (T)

  locks L
                                    blocks on L
                                      rt_mutex_setprio(O, W)
                                        O->dl.pi_se = &W->dl
                                    sleeps
                                      task_non_contending()
                                        arms W's inactive timer
                                                                  sched_setscheduler(W)
                                                                    W leaves SCHED_DEADLINE
                                                                    task_rq_unlock(W)
                                    <W's inactive timer>
                                    inactive_task_timer()
                                      __dl_clear_params()
                                        W->dl.dl_runtime = 0
  <tick>
  update_curr_dl_se()
    enqueue_task_dl()
      replenish_dl_entity()
        runtime += W->dl.dl_runtime
        loops forever
                                                                    rt_mutex_adjust_pi(W)
                                                                      rt_mutex_setprio(O, W)
                                                                        spins on O's rq lock

Fix this by reading the inherited parameters once, and by not refilling
from a runtime of 0. The owner stays runnable. Its deadline stays where
it was. It runs until the chain walk deboosts it, or until it releases
the lock. That also covers sysrq-n: normalize_rt_tasks() changes the
waiter without a chain walk. The warning stays for an entity that is not
boosted.

A 300ms debug delay before rt_mutex_adjust_pi() locks up v7.4-rc1 in
8-CPU VMs, but not a kernel with this patch.

The Sashiko AI review of the third posting found the lockup. Juri Lelli
suggested this fix in place of a larger one.

Fixes: a5e7be3b28a2 ("sched/deadline: Clear dl_entity params when setscheduling to different class")
Suggested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/avL8oOtjKqVNR7-l@jlelli-thinkpadt14gen4.remote.csb/
---
 kernel/sched/deadline.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e4d7cbf4861d..c4ea51059941 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -807,8 +807,26 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct sched_dl_entity *pi_se = pi_of(dl_se);
+	u64 runtime = READ_ONCE(pi_se->dl_runtime);
+	u64 deadline = READ_ONCE(pi_se->dl_deadline);
+	u64 period = READ_ONCE(pi_se->dl_period);
 
-	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <= 0);
+	/*
+	 * A boosted entity runs on the parameters of its donor, the top
+	 * waiter of an rt_mutex. The donor can leave the class and have them
+	 * cleared before the chain walk deboosts this entity. They are
+	 * cleared under the donor's rq lock, which can be another one. So
+	 * read each of them once. Refilling from a runtime of 0 would loop
+	 * forever. Leave the entity runnable instead: the walk deboosts it,
+	 * or its task releases the lock.
+	 */
+	if (unlikely(!runtime)) {
+		WARN_ON_ONCE(!is_dl_boosted(dl_se));
+		dl_se->dl_yielded = 0;
+		dl_se->dl_throttled = 0;
+		return;
+	}
 
 	/*
 	 * This could be the case for a !-dl task that is boosted.
@@ -822,8 +840,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 */
 	if (dl_se->dl_deadline == 0 ||
 	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+		dl_se->deadline = rq_clock(rq) + deadline;
+		dl_se->runtime = runtime;
 	}
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
@@ -836,8 +854,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * arbitrary large.
 	 */
 	while (dl_se->runtime <= 0) {
-		dl_se->deadline += pi_of(dl_se)->dl_period;
-		dl_se->runtime += pi_of(dl_se)->dl_runtime;
+		dl_se->deadline += period;
+		dl_se->runtime += runtime;
 	}
 
 	/*
-- 
2.47.3

