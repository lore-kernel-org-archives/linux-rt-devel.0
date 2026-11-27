Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790175;
	b=TzGsUk1Gnhn0XDmAuo5oebIXMwuig1T6BaRDKoEVAQeIRZdf3aShqX8bzYbssJURrXBx
	 RJsBMakO8CA58H67WQDsC4v7nQFhJqBmS0t/5gzsjaver/c/S9jWx6aRHf9KJl2hYC0C2
	 tOWZUEGRYHPFK9dh5RL7JDHmdJzsWbKGlb9P06+RC7UM6WwPgiu3Z7jQxtIbPP1FFypg6
	 GyEO0yjxaD8ua1WqYmC1pzcwwkPW7AZu1Fzu9rc6PoIlGi4/Ui0tq/ojtcoRjgW6F17J3
	 imtcOK9c2wQi7NF7vIubvKWsTCpjQcXbUsn/ITjn3PmNdJvS56Ofy+89iY6hY31XhgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790175;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dfv08/N+kF+Mvy690ORsGCHE5ksDbaHpXa/TyHWA4Dw=;
	b=pJtUJtaO/lHrTggPhS4bv++9clRfedG6cVJwcIFs6+0MyqWAbhiF8suvP7rr36aU3eyC
	 M3+Rhl9M5SHbmSPjt2N8dhuGoqNqmSZ8kvuZ/O+nHaPHjKdI9bX3dBu+DjKE+394E34ac
	 P2X+7eLa7yyRQgNVPuklYwsowF4HfwbU69hEZ8eNWmb3TyqPb9GW/AdTnj/hy6fCRVN5y
	 lX3IUQIHHusmLfjJ43yjS9hN+rugX5UP8SCpFO9M7Bh6Oz8hi4p7V5XPOrn1T3Qttju1C
	 xe+Sxq5wz7LPk8u+xGtH4B8IQsznol/pUV1cWS5RsntsuHYn6voFn+3ZOSQXFsdkDeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HuIBRMSi;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E91606A32A
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 14:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E91606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HuIBRMSi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795790174;
	bh=Dfv08/N+kF+Mvy690ORsGCHE5ksDbaHpXa/TyHWA4Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HuIBRMSiYOs//LyjaWIcWEutvTx7KrC7NdeOncGe2NcY3w1Zk1j4PJD320Dkz0cVN
	 mgcSfiApn5hgICeABSJn2QBP61vvBtc+Gj3ZR76xERQqhuTRSBN7sHnzFUOOZlOR+p
	 jUXkET54R/gMThqDncKpyYrvfcLiRf4J/XzNatbqDo+YSNgnAOsub6iRRv3gOPClLq
	 BU6FK+AIL+7h96gWnVk0xg1Qp2DxQLQi05R7Xjd4XlAks57WiALmjmeRN7ogzwX/xD
	 yeMvRiyLRshm+X3qLfp4++hXMNnP4Tu0wRJTvr9eKDapJQSa9HGdt0cAU3kvmbsU9a
	 4pGrK/8EGLXWw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbbZQ0PPFzXPH;
	Fri, 27 Nov 2026 09:36:14 -0500 (EST)
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
Subject: [PATCH v12 04/43] sched/deadline: Leave a dying task out of a rebuild of the accounting
Date: Fri, 27 Nov 2026 09:35:31 -0500
Message-ID: <257df8bcd4ff70527a197a7be6cea3bb9202b01a.1795771147.git.mathieu.desnoyers@efficios.com>
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

This patch completes "sched/deadline: Rebuild the root domains'
accounting from the task list". The walk of that patch finds exiting
tasks, which the cpuset iterator skipped. The fix needs the record
that "sched/deadline: Record the root domain holding a task's
bandwidth" adds. The three go to stable together.

The Sashiko AI review of this series found this window. It also found a
gap in the first version of this fix. That version also left out a task
between TASK_DEAD and its last schedule, with its 0-lag time ahead.

Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 28fa8f0bc81b..5d065ad27cc2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3834,6 +3834,17 @@ void dl_add_task_root_domain(struct task_struct *p)
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

