Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907261;
	b=RRvs7GREkW6C5BVQHQx+lZQuXggtOJ/hekxfNXP/N/VVfQ/gtosfswPQGSk8bN74layn
	 seyZJOKoAljebfMijwYJnXBrovCawNCoUJJMrm9zmsfPJZ/54vhRm4FRKza8HxmUOxj++
	 +vtq1/oj3zYj5ZKgCee52K1A24sIVYyTmNlN9UQVXA/s8p8mpwX0wuD0SeBFhL1kj+JsY
	 IG6yyf3y/z40gM6xQXd2uyjcJEGpoUYQz1ydv42j5yBJKRhReuHv5Rp15gMIrQ/wxxiHD
	 n43DbRX3KnA2t+/fqgR4gMbhX0C82YpMLDRNHMpBlyg2lZ//VuY8AfiVu21tjvI+4wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907261;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GT7dekXcYnD31vqjRelA7RyNED54YgcxHpxVUycqC2I=;
	b=lUsIsNKKDnW1xq7Xe0Ht7lUuXnBb1IID4HA5njK4mCz/qx24SIJF7IEw44a0TIIsikIM
	 4I9DgIgBfvSujMgwJyaBZ4fqLyE6e9pwhgdzoJc481K7rb8A0c/xI8uzqgaMtcEbJ14RP
	 sghz+hcLpohzPx2kG8ZkQi4AiiGnS1d6ASPyFbkgHMtDKifvxA5SXE0k+83lgEoSbz4/y
	 HrntsZn/iZgeWYLMluypHjX2aOasG39WnDtKPWFpf6tkwgDfMCUOSUZu3VeP9yNqmRcsf
	 9F8bV/vNnYLgzQJ3PI1lRvkxO/UwkTAPkfG59MdhyXlqQEN/ievR4tUSNe/qCYVGV9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=C4sJsqsf;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A5606F5B4
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 19:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 653A5606F5B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=C4sJsqsf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793907250;
	bh=GT7dekXcYnD31vqjRelA7RyNED54YgcxHpxVUycqC2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4sJsqsfxahZ/F13HcnLIvp2wiFnnIa2pdWNYMma3D8IS5aQXjztSr62RsLwEaL+4
	 bXCHoI0NxWaVf21CFTzUZwkJ+ZfL+Uo69hYOCv1suk0sfWmUrF2nkG2iibNVd19O4s
	 AhozLwexIruIVH0MxyoII5sG5DctWrfkuBWIRP8JEnuI9JYOgfNx5QjqWyOPMZWSR4
	 v2sg7I6WI/VTLQ1Xr19XeB49TF9iREH/qAZa0z60Opvxs4PDr72TyQijMIf/SHK0Kq
	 lcDmK5UUGuDLRpbf+W+n9TV+GW9iLZbdNvcc7vWWXGo9Nfy+vvc9W+VTq3X3l7kyEX
	 iXwa2LDubFuIg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLCDL2kzhzLJt;
	Thu, 05 Nov 2026 14:34:10 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [PATCH v3 09/24] sched/deadline: Reject SCHED_DEADLINE on exited tasks
Date: Thu,  5 Nov 2026 14:33:44 -0500
Message-Id: <20261105193359.1450487-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
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
index bffeb4143161..c143b7d02efc 100644
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

