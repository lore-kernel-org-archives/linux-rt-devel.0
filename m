Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015905;
	b=ZV67jMZxuRP9MrN3fKsD2/wcQo4Yi3N9jWBwxjPtLzOK5JJrTujWh8gtt+JyEA3SFQyD
	 walu+U9sSBAttv1xY5ct4MhxF62VT7PtBu24HMQzPYsPqzsOAxV92gxC75kHcAcjNDBCC
	 w2d3CR8d8pvKKUyEk630tdO2IOU/HJYXyD4iB8W7DRI1RKcZ04rUs9nS+v4HUeIxYFHbG
	 f+EQGTb1WaBzWgRQAhuI+7ixBrcnBhPKB2Ye1yH4cnDzKmj1axo1ABrHZDZB6lNdenqUm
	 Bi8fQ+7Gffy4d/B0ThHLCxjTecmHo8b7C7a2vCqNf/0zONcsDCUUBIEWAUT9FdKhIeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015905;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c69RlMavxq1KwOmGI5hrKX4u2sisjnsbyQ/essU+5FE=;
	b=J1zZr+Aalkn9FXXqhfxDqX+p4ZfQiPIBL/uuhPNKZIAk8Tu4GM2+76jeyiqjzyCJ7hga
	 SrM+/7jxqVVpHUrz7bkKluas4bwbug41nGTTWohibUMG3BLKMgG2eK0tp7ocM3LvjPCXz
	 iBvrV9VmCuaG+F1nhqe05XsY3cmsK7ZTSPXjGRrZ5T0sV2oF/E2oV8fJHKFtIjaRtkSoz
	 fTaLYUnDsKKANDtZLCvKVDUGpUfqN3p0tGJtbN2yWCbQd0EFEZqeXmK5/DBTxU5u4t7Dm
	 szXg6N0uVtwvdNquo6RdM0v4x4QNgwZpPfHf34cdRhV1CWlYLvyafQGGtSKQo/FyWYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=H9tYAFbK;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E38606EE92
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 01:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E38606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=H9tYAFbK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794015904;
	bh=c69RlMavxq1KwOmGI5hrKX4u2sisjnsbyQ/essU+5FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9tYAFbKPaCqm4BS/ATJn+7uVyzczKRlFmUiTVY2QDDIDi1EefvLGBRkneX6IFZ2H
	 PmaVnVu4zjffiGOVFijwyWfm/AaJUMove8ODXd1sTugpkP9eEuoI2WLHTxvXLSByHh
	 K4MYzPBnL4ofoKUQDHT75l08H58vL1f8RImVf3DX6khJML85XNIqXoMRAvzcu6qufb
	 hRj7FUWfO+aFJr4QLqcTfme1s09wngMP1urG+LHMP39v/23lt32dZIMjr0oiKA03Hd
	 evti9KtPdZqvbPLS8QL+i71EM4m1h+hYVQIxuSnGBCOU9yJrqL85rURa9X3Shxihi2
	 PI29PP+z/CvXA==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLzPr2YZjzMFF;
	Fri, 06 Nov 2026 20:45:04 -0500 (EST)
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
Subject: [PATCH v4 15/26] sched/deadline: Leave a dying task out of a rebuild of the accounting
Date: Fri,  6 Nov 2026 20:44:40 -0500
Message-Id: <20261107014451.1487825-16-mathieu.desnoyers@efficios.com>
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

A rebuild of the root domains' accounting finds the tasks of a cpuset
through css_task_iter, which hides an exiting task once its process has
no live thread left, and hides a dying thread of a process with live
threads only once cgroup_task_dead() takes it off the cpuset, after its
last schedule. The walk without cpusets finds every task. Either can
find a task at its last schedule, between the release of its bandwidth
there, task_non_contending() past its 0-lag time, and the reset of its
dl_bw: both run under the runqueue lock, which the walk does not take.
The walk then counts, in a root domain the rebuild has just cleared, a
bandwidth that nothing releases again.

Leave out a dead task that is not on the departed list: its bandwidth
is released, or being released. do_task_dead() sets TASK_DEAD under
pi_lock, which the walk holds, so a task found alive dies after the
walk, and releases what the walk counted. A dead task on the list keeps
its bandwidth until its timer, and the rebuild counts it where the list
says, as before.

Found by the Sashiko AI review of the second posting of this series.

Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/deadline.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 45a896a4f461..3f3de4b74a2d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3643,6 +3643,15 @@ void dl_add_task_root_domain(struct task_struct *p)
 		cpu = p->dl.dl_departed_cpu;
 		if (!cpu_active(cpu))
 			goto unlock;
+	} else if (READ_ONCE(p->__state) == TASK_DEAD) {
+		/*
+		 * Dead and not departed: its bandwidth was released at its
+		 * last schedule, under its runqueue lock and not this one,
+		 * and dl_bw may still say otherwise. do_task_dead() sets
+		 * TASK_DEAD under pi_lock before that, so a task found alive
+		 * here dies after this walk, and releases what it counted.
+		 */
+		goto unlock;
 	}
 	rq = cpu_rq(cpu);
 	dl_b = &rq->rd->dl_bw;
-- 
2.47.3

