Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015904;
	b=1VgkkJAY4x/g6o6RWU/wvf7rNBZ3gSmJZhxYNIcLqN63wNHMHn/gUfob+JRNb78NSwlX
	 Ro5SfRahgq92wA9gyAs74DOJXT1tAU5ZpgafeDSqd/pzdEKEpb06fSUXDcCKBTXi9LuHO
	 IS5YLmSIXTlaEFMXGRWYE+oC4RSmkBhuds9yIsot9aAFq88HSEKRHBJXvXqiGN+9//bT4
	 TdQqw55bkvfsfZXc/jixsTl/fH2jXS01Cd9WbSmc6WPAubqR6eIJfAtJiR8TBGZylF+8B
	 p3qlAtruwQXLsrYOVvxY8bmT5j8kvwIpndB7eYxzxBvJR5rZKghKjf6M31n4PJ614MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015904;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DUqVHoAlTP7z4c9p2vG1aHucUMrYKKYexcxS3ktF96o=;
	b=EjQAAI/vVHlbiaH3eXb8KH79FZhFVH3FaeUav90bmMEJbLrBALuWYjqAHZ2tXnBDiok+
	 fCsULiDlBuZetoEAKm7UIfc0tHguHAURj/R8K0Nm8zS5ui4ezWF/As5f3gDWRcuLChiOf
	 F3HdX76IVB7Ja/ukPTPSoWzRlUgwGMhGnrI4jLnp6tGygC/oTQW4siRUZOcqtX0pJjdTD
	 r0TB00/l0UokxXJYnc6dvGXtrYoiC4BiJo6TYFOg6TVgeyjDqz/mP07ejUAuAowt1gAPc
	 Hpcjr8RPmQMpjGUfk+75yutrK5d85Z9paouaWm3hKK3BRzwW0MKkt0Uq2GDNy9tZxvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=UP59KEZN;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE95606EE87
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 01:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE95606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=UP59KEZN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794015903;
	bh=DUqVHoAlTP7z4c9p2vG1aHucUMrYKKYexcxS3ktF96o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UP59KEZNKnf9WKuVwisMPCvc1eT3fSraHrW0fI/G3Fcp3ZpokAEWWlxcu5qzqfMs7
	 EiW7TQGgBIDlQHEa0sBoZ4SkwNdvUFIwFupSrOnyUBbv944/aLjDKAdB9vCXpFsQuO
	 gXu74Jj1U6PFVfaoHJpX44gxMmpQgKW6ClcmLV8bhif9f/9VgoXiZM0bUsGL7y+93U
	 ZQK/kR+qZFExnG8AXS3g4XZjIETv0QU3NeYYnwQCbA/4iJaAeXBxPvPIcK32QHYznK
	 vK7zGGkPrfeorBjhxy5t6AZGtE1Lbrvo+n8tKTdFxqPE2nYXMzoUr/rig8eesCilTx
	 nTeBPjqnsy4vQ==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLzPp5DH9zLKc;
	Fri, 06 Nov 2026 20:45:02 -0500 (EST)
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
Subject: [PATCH v4 11/26] sched/deadline: Reject SCHED_DEADLINE on exited tasks
Date: Fri,  6 Nov 2026 20:44:36 -0500
Message-Id: <20261107014451.1487825-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
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

From: Juri Lelli <juri.lelli@redhat.com>

sched_setattr(SCHED_DEADLINE) on a zombie task succeeds and charges
total_bw via sched_dl_overflow(), but the task has already done its
final schedule() and will never run again. Nothing releases the reserved
bandwidth. Repeating this fills total_bw to the admission cap, after
which sched_setattr(SCHED_DEADLINE) and CPU offline fail with -EBUSY.

Reject sched_setattr(SCHED_DEADLINE) on exited tasks with -ESRCH.

A task of the class that exited, switched to another policy, runs
switched_from_dl(), which decrements the count of deadline tasks of its
cpuset that cgroup_task_dead() decremented already: at 0 with a deadline
task left in it, the cpuset is skipped by the next rebuild of the root
domains' accounting, and that task's bandwidth with it. Reject that as
well. The deadline_bw_test selftest added later in this series has the
case, death_zombie_switched: on v7.4-rc1 the switch is accepted, and
the one-CPU partition root the zombie ran in admits 9 tasks of 10% after
a rebuild, with a task of 30% still in it, where 6 are due.

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Reported-by: Weiheng Qiu <weihengqiuu@gmail.com>
Closes: https://lore.kernel.org/all/3f6e6c87-645b-45fd-8fc6-8da5bc5b82d8@gmail.com/
Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-4-dd761fe005b4@redhat.com/
Cc: stable@vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[mathieu: reject a task of the class leaving it too, found by the
 Sashiko AI review of the patch]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/syscalls.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 89c185f7d498..12830e4f8842 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -584,6 +584,19 @@ int __sched_setscheduler(struct task_struct *p,
 	if (retval)
 		goto unlock;
 
+	/*
+	 * Reject SCHED_DEADLINE on exited tasks. A zombie will never be
+	 * scheduled again, so sched_dl_overflow() would charge total_bw
+	 * that nothing will ever release. And reject a change of policy of
+	 * one in the class: cgroup_task_dead() took it off the count of
+	 * deadline tasks of its cpuset, which switched_from_dl() would
+	 * decrement a second time.
+	 */
+	if ((dl_policy(policy) || dl_task(p)) && p->exit_state) {
+		retval = -ESRCH;
+		goto unlock;
+	}
+
 	/*
 	 * If not changing anything there's no need to proceed further,
 	 * but store a possible modification of reset_on_fork.
-- 
2.47.3

