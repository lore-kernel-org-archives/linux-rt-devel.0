Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164061;
	b=eMdKwQDkm8X7w8T1GKayqozmv1Y24JYdFCKKfEO7JbFdskAZsdE9qOWUkTtisVJQJcpb
	 x0LO+eMSxMTt3fhAruxpkgZy2zBnD2C+IwTJjvhsXtSpyQfaBga5btOfzsp7UpKsAalb4
	 mh6ijwr+qwIVAisaP65HMcpIXHc7I5me0zzv1GKtrtkkR1ad8Iw71Ln8+FD4N6dkid70A
	 rGYTJu2wfZi1ZM1OYQOb7d+akGOpMkGkOnwRYhV6lY+Wog2kwL0hIpUYsZvy4qzOAswhs
	 Di/KgSXhgx54j5oL7brVr1gX8jyGBA7F3r9JYY2fiMS8I3qu83noRBxoxggOF99kx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164061;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nPbPKPRbXcEofKYqokd7VQKwOPfUx31CS6vwr7Chvh8=;
	b=uOQA6FhPi+kfm7pQ2CGKGrrI13f45PfsIPcS1UDAcrkiGwjzMqzhq1xuRZI/8hkbKW2v
	 rU7QMIoR2HQGP88wCvQS771/gDlj/qBiBrlVZcWRueLmyR14DiPKxS+n5c+iSqxb+mCcA
	 TGn/8QXEsc3oy16G80u6iHT5fJdtuCIts8buQAfNxj33fI7seTOrbCYuPpxMiq+hkW1My
	 lorRUB2vjlLm7GS/ptMx6urwQO/1WNRSKXbY4w0SINtViSHs2k8MddWs4lpxdxeDsZq0b
	 dEBu+gvVqu1VeiX1PdA9a7CWXnQLEOjpF8HOHJc6PwBBXL1qJ07CS0GY/+/s+0lflNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=iwLnYk8u;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1F606D83A
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 18:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC1F606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=iwLnYk8u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794164060;
	bh=nPbPKPRbXcEofKYqokd7VQKwOPfUx31CS6vwr7Chvh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwLnYk8uRhesVnEMo+A/UQF9oGJGydZG/bbZjIgajLapcK5CEZivNX9VvJr6PUDUE
	 JGuVPlZBzxoZEA0YW0iYSfRkA1efyRZi+sbU851ehrngOSrnPANocfzM2oFXZWS7xl
	 2ddZmNIMlLJ83anNZVFRgIUErI9i6t4KPqK2wz+coVjdmtbm8TvMGb2VQ57C3wdXP5
	 maYLEhUBfKDmZPIATRLzlINM/gSAI5S5m8vGXhucoTZZg3WlzAzR878ptTLLhZMZv3
	 FbUolev+PRUDqdoSCQNvb6ppPBrC1R1V8IyJE1L7H3kloMsoGSoF2SNr6PkMRoomam
	 uKqZMbYkrU40A==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jN2C00c4VzMqx;
	Sun, 08 Nov 2026 13:54:20 -0500 (EST)
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
Subject: [PATCH v5 09/29] sched/deadline: Reset the deadline and the runtime with the parameters
Date: Sun,  8 Nov 2026 13:53:46 -0500
Message-Id: <20261108185406.1549770-10-mathieu.desnoyers@efficios.com>
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

A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
("sched/deadline: Improve the tracking of active utilization") moved
their reset to that time. Before it, the replenishment timer did the
reset at the deadline. So a task back after the reset found its
deadline passed, and started a new period. But __dl_clear_params()
resets neither the deadline nor the runtime.

Now a task back after its 0-lag time can be enqueued on its old
deadline and runtime. With runtime left, its 0-lag time comes before
its deadline. Back before that deadline, it would first spend the runtime
of the reservation it gave back. Back after it, a constrained task
would be throttled until its old period ends. "sched/deadline: Do not
lose a throttled task switched out and back" moves the deadline of a
throttled task on. This widens the window before the deadline to about
a period.

A task with no parameters of its own, boosted by a deadline waiter,
keeps the donor's deadline and runtime after its deboost. If it then
enters SCHED_DEADLINE before that deadline, it runs on the donor's
runtime. On v7.4-rc1, a task of 10ms per 100ms ran 40ms of its first
period.

Fix this by resetting the deadline and the runtime in
__dl_clear_params(), and in switched_from_dl() at the deboost of a task
with no parameters. The next enqueue then starts a new period.

The Sashiko AI review found the first case in the second posting of
this series, and the deboost in the third. The deboost_resets_period
case of deadline_bw_test, added later in this series, tests the
deboost.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/deadline.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index cf24d2df6bfc..cc43c5eeae51 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3573,6 +3573,16 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(&p->dl, false);
 
+	/*
+	 * A task with no parameters of its own was boosted into the class.
+	 * Its deadline and runtime are the donor's. Reset them, so that its
+	 * next entry into the class starts a new period.
+	 */
+	if (!p->dl.dl_runtime) {
+		p->dl.deadline = 0;
+		p->dl.runtime = 0;
+	}
+
 	/*
 	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
 	 * keep track of that on its cpuset (for correct bandwidth tracking).
@@ -3999,6 +4009,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_bw			= 0;
 	dl_se->dl_density		= 0;
 
+	dl_se->deadline			= 0;
+	dl_se->runtime			= 0;
+
 	dl_se->dl_throttled		= 0;
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
-- 
2.47.3

