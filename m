Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924680;
	b=Mx4sQlnulke+C68fUW3wsp4I7c3WyBrVcvwxo1Nr5FLOuXr8iSMD3qyW1xJ3z8fgkBsi
	 LoHSh0ww1wocffDKbNjVj8ZFyV0yppggZr9W2VPJy6812ZCMaxvNalml1ziPr03ev04rv
	 /he7aUAHzWbsDpAAYTaVdlNZIf2dTl1kTbNGFxfJAmyJo8m9YDOOUS3R6/kQ1yLv28/uX
	 XWPIaXfzhVI83xouAKaOJ1j22mIUoTmRCgR0iZL4v2Kr9oe20JrdRzMr0oJQgxcRNpGXw
	 Vt5g0DsZR1BwUreTARIOuflh+mc8Bqwc9qmlBqFwzVNZT5v78rDyKWoOq84lM6IGW/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924680;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lFP7Jb5QnBavccKZP1TiZmt+Fu/KItkai8FCKofUJpE=;
	b=QKkOC2VR+Fwa3W9otlxjGKaVtW4jVDI1Mrk8Efr14P+9OES2e5x2/qCutA+UjnKQdwPN
	 UxLGKVZ92GlRfbXc7l8Zt3T+OzaKGMXFLdB+4MbjnmOgNv88X7Q+w106t9QOAYm5+EEuT
	 WO97pHdXmPKKOezniyA216BJuWxE43Exb9sT6l5DTONOiWfovGnL60Vt/Ptn8RrfCMB8T
	 qoDLxMN2rCddPf+uosSVVjN6aNmP8FAxr1Pqd8muvN+itTqDmHEjXhRqnwt6pnlrIA4Cv
	 fDbp3QD66Vv4iFPtTa0IVU1weyYnPVqP9U1L4IMUfCOV2Bq+J+7xc3nlItALSU8MSGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=gogpd7mf;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C060A6F7C
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D3C060A6F7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=gogpd7mf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924667;
	bh=lFP7Jb5QnBavccKZP1TiZmt+Fu/KItkai8FCKofUJpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gogpd7mf04Jgr7IlyWrr0imevP79mmfNZw/KWYtHGE1dAdz8RkHw2SODVHzWpUPgc
	 MBLwmSAVCT1XVtfVCMittQftpuLkrTfZyNAmJEb7hPhECj3QaDcyFzqIBTs6DAicR4
	 NVJbGl74liPtVmO7Q4t2Js4RcISXBeghAbQcH/hRRjfUZ+I94Nh58VDnB6FjlpdPWB
	 rnoWQZ0ICOyEDGTs8ib0cUNPVZOa8alMeAL2MA3OOWnKR4qu+/iZZL5SgNMQIeBz7t
	 uy2UqE2UuLN+EXfDFAOWp4cqRUfLpsQwY1AJAkGA4HfDZKYFMC5jwzvhRscqp+NS+6
	 pJ/Ik3fM0z6Cg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV35pdZzRTN;
	Tue, 17 Nov 2026 09:11:07 -0500 (EST)
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
Subject: [PATCH v7 19/40] sched/deadline: Leave a dying task out of a rebuild of the accounting
Date: Tue, 17 Nov 2026 09:10:40 -0500
Message-Id: <f9efeeae47bd95ba9f775750b1ac399e71d1e17f.1794922146.git.mathieu.desnoyers@efficios.com>
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

A rebuild of the root domains' accounting takes the pi_lock of each
deadline task, not its rq lock. A dying task past its 0-lag time
releases its bandwidth at its last schedule. It holds its rq lock there,
not its pi_lock. Then it clears dl_bw. The rebuild can find the task
between the two steps.

In this diagram, T is a deadline task that exits on CPU 0 past its 0-lag
time. bw is its dl_bw. CPU 1 rebuilds the accounting:

  CPU 0 (T)                                  CPU 1 (rebuild)

  do_task_dead(): TASK_DEAD, under pi_lock
  __schedule(): T's rq lock taken
    task_non_contending(T)
      dl_task_release_bw(T)
        total_bw -= bw
        dl_bw_gen recorded
        record cleared
                                             dl_rebuild_rd_accounting()
                                               dl_clear_root_domains()
                                                 dl_bw_gen++
                                                 total_bw reset
                                               dl_add_task_root_domain(T)
                                                 T's pi_lock taken
                                                 dl_bw != 0, dl_bw_gen old
                                                 total_bw += bw
      __dl_clear_params(T): dl_bw = 0

dl_bw_gen does not help, since the release came before the rebuild. The
rebuild would count a bandwidth that nothing releases again. The root
domain would then refuse deadline tasks it has room for, until the next
rebuild.

Fix this with the record of the bandwidth, dl_bw_cpu. The release
clears it under dl_departed_lock, which the walk holds. So leave out a
dead task with no record. A dead task with a record has not reached its
last schedule. The walk counts it as a live task. That schedule then
releases the bandwidth, or puts the task on the departed list. A dead
task on the departed list keeps its bandwidth until its timer, and the
rebuild counts it as before.

The Sashiko AI review of v2 of this series found this window. Its review
of v4 found a gap in the first version of this fix. That version also
left out a task between TASK_DEAD and its last schedule, with its 0-lag
time ahead.

This patch completes "sched/deadline: Rebuild the root domains'
accounting from the task list". The walk of that patch finds exiting
tasks, which the cpuset iterator skipped. The fix needs the record
that "sched/deadline: Record the root domain holding a task's
bandwidth" adds. The three go to stable together.

Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 01fbbd02cf8d..779acb9836dc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3787,6 +3787,17 @@ void dl_add_task_root_domain(struct task_struct *p)
 		if (recorded < 0 || !cpu_active(recorded))
 			goto unlock;
 		cpu = recorded;
+	} else if (READ_ONCE(p->__state) == TASK_DEAD && p->dl.dl_bw_cpu < 0) {
+		/*
+		 * Count nothing for a dead task with no record. Its last
+		 * schedule released the bandwidth under its rq lock, and has
+		 * not cleared dl_bw yet. The release clears the record under
+		 * dl_departed_lock, which this walk holds. A dead task with a
+		 * record has not reached its last schedule. Count it as a
+		 * live task. That schedule then releases what the walk
+		 * counted, or puts the task on the departed list.
+		 */
+		goto unlock;
 	}
 	rq = cpu_rq(cpu);
 	dl_b = &rq->rd->dl_bw;
-- 
2.47.3

