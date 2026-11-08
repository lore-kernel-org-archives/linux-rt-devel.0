Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164060;
	b=cuZHBc9yGkXqQHUmQLKy0ZVEYyO4kyOZGI5QX6mLbxnZnz+JQvHjf7DFANmalRKOFxJu
	 eJMDAHp3NlKAllkFYBB8iHjHVKzFOzanE08NQK4UNfqXqvA9N0ODtJuIiXsFjOWtnDEhs
	 Oe6A1Tiglqrq24QaMylZzc58H7NNvpVaJthXqH39AfEWtOj2NTGmvjzPbYBbbDl+8Btk0
	 lyboF71xRoAhglQqJ86JdgVeEW43TCAAfabQ79y5PfiPGqw4bswpG18Dl2hVmMGhzOKWJ
	 2QnuG3EUkVqp9JWCq7REWEM27ESM/rwo0IJdN97GuSOm3S7MSVRsAnKeCVWfExh9gbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164060;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2mEveiOnhjlEcaQn9Fni6d+Y22SUXt6tTuviX3I+yAU=;
	b=Y3V66HBPk4m8o3NZPsmCQKGnBErkbhBPfh1Qgg+19MMAhQamQunXgL9ha71zEuifrDkb
	 WvarbZ9Bk4Lba6jathGK7sj3YgpATPa5QTkLyFjzQwYF2WPYhyWIJM7GBSYiVDzYhkShG
	 txv/chVHSsY5uwN11Gkt9uwKE6RK574x0K/2VjtscBIBY7EIPoI1h1QB88WhY8a5IZh3p
	 lrtFNXzMskUClCsnqu2O+hkxdT07C4BIdTEacWKValsWnhJAdMjK688i5FT1hXxdtFV6b
	 0rAXeKH06NBD5yVBGLULzX/XDppjLvXVTFsCYmSpYuDfwXGu76CKICq5uvhSf5p9HCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=kuzWv8tt;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09410606A32A
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 18:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09410606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=kuzWv8tt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794164059;
	bh=2mEveiOnhjlEcaQn9Fni6d+Y22SUXt6tTuviX3I+yAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuzWv8ttZKLKXJQlrTv3Q0qQzBLsUaOykOXP6WBWf7uJ6BgOibQABQXB6yVbobQJ8
	 OWEjbX8P88V5Dkm0J5Ne+LK7b+K4llrkEAtX+t+gkaDskpA+hI04QD8sHG5YGU4/fE
	 zpgAvdpgtxI/TaKy7fjd3UcgjNDh9o0Ufr5Ir9QV0yMtgONs9wiYuD45JkwHg7xA7H
	 u8w3gSZurYhSa1qkINNAqkTx7xUMuI+XFbm/gARdMn8VtRhCIj9HlYl6iacE2ZI91U
	 rmWirJd9Fld0rFr69GQjpamTnsZ1XkUO17iXh/8RNy4rEx2XQmbmAsI3vfn6h11pcq
	 Ar4JbOc65jpDQ==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jN2By61QDzMqt;
	Sun, 08 Nov 2026 13:54:18 -0500 (EST)
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
Subject: [PATCH v5 06/29] sched: Take cpuset_mutex for a deadline policy change only with pi
Date: Sun,  8 Nov 2026 13:53:43 -0500
Message-Id: <20261108185406.1549770-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
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

__sched_setscheduler() takes cpuset_mutex for a change that involves
SCHED_DEADLINE. On success, it releases it only when pi is set.
normalize_rt_tasks(), for sysrq-n, is the one caller with pi unset. It
runs under read_lock(&tasklist_lock). So sysrq-n takes the mutex in
atomic context for a deadline task, and never releases it. Every later
change that involves SCHED_DEADLINE then blocks forever.

Commit 710da3c8ea7d ("sched/core: Prevent race condition between cpuset
and __sched_setscheduler()") took the cpuset lock only when pi is set.
normalize_rt_tasks() cannot take it under tasklist_lock. Its changelog
accepts this: after sysrq-n, the deadline guarantees are gone anyway.
Commit 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex") then took
the mutex only for deadline tasks. It replaced the pi test by a policy
test, and left the release under pi.

Fix this by taking the mutex for a deadline change only when pi is
set.

The policy test reads p->policy before the runqueue lock. It is checked
again under the lock only when the caller gave no policy. Otherwise,
the task can enter SCHED_DEADLINE in between. The call then takes it
out of the class without the mutex. A rebuild of the root domain
accounting could run at the same time. So check again under the
runqueue lock, and retry with the mutex.

sysrq-n on v7.4-rc1, with a deadline task and lockdep on:

  sysrq: Nice All RT Tasks
  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4356, name: deadline_switch
  locks held by deadline_switch/4356: 4, last CPU#3:
   ...
   #3: ffffffff83006098 (tasklist_lock){.+.+}-{3:3}, at: normalize_rt_tasks+0x34/0x150

A sched_setattr(SCHED_DEADLINE) after it never returned, in 2 VMs of 2.
The sysrq_normalize case of deadline_switch_test, added later in this
series, tests this with DEADLINE_TEST_SYSRQ=1. It passes with this
series.

Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/syscalls.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 56ce2352e89e..0bc778c12af4 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -561,9 +561,11 @@ int __sched_setscheduler(struct task_struct *p,
 
 	/*
 	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
-	 * information.
+	 * information. Do not take cpuset_mutex when pi is unset: the
+	 * caller is normalize_rt_tasks(), which holds tasklist_lock and
+	 * cannot sleep.
 	 */
-	if (dl_policy(policy) || dl_policy(p->policy)) {
+	if (pi && (dl_policy(policy) || dl_policy(p->policy))) {
 		cpuset_locked = true;
 		cpuset_lock();
 	}
@@ -654,6 +656,15 @@ int __sched_setscheduler(struct task_struct *p,
 		goto recheck;
 	}
 
+	/*
+	 * The task entered SCHED_DEADLINE after the unlocked read of its
+	 * policy above, so cpuset_mutex was not taken. Retry with it.
+	 */
+	if (pi && !cpuset_locked && task_has_dl_policy(p)) {
+		task_rq_unlock(rq, p, &rf);
+		goto recheck;
+	}
+
 	oldprio = p->prio;
 
 	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
-- 
2.47.3

