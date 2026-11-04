Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805148;
	b=2KqKrEWvByu68pan8wHRl9YsFxfuWGQKkqVxvMgIIn66emozej4lugti5sEf79zqeLP/
	 3ydLQ0cp3wfiZa+B4vs8SyV0XVykne637+Ll0IEHunXJ/xjS4BSUZ/hK/GrhZPEjXC/e7
	 pgr+pV/Jbv52Mgy1oNyvp3Q3GDEhIg8t3vDLjrUG9KcsIbI4rtL7gTMFdKsj9qs8grErI
	 J+i1vt+PSEHU9Wt4G4wn+fVzX3L/jECvR4G7KAsCRpn8ySD1OkS81Wf3IA2ZPgNt4pfDN
	 jP/wwrrrCwPsNkHWVUYxWKCpY07qtgXaZCoOrABot6j9DZkic5MrCKUR2WF7cL9x78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805148;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JFjXz+DM4ofvkk2EmcoTPHQH7AEhGNy+pLKqdHTFcPQ=;
	b=aRz/OSD893pQhcEufpE7SY6nloNi3dQebe8zTDLFP+dgZE2mDzuyYWQ6AjepHfekJAxb
	 VwdNwqUH5kd6/ne9MpcxU+2xUcyyK0ehEoEPGZlwGZFi1Vu88y99WmlOiGk1z8HzRJmJl
	 kqRp/l+EdMt3KoCTwPB6DEYLNnA7eRrTdXc6J5RSKPPnui/gBlTPMFAZSTNhNubR3Bt6Y
	 vGjoR9GvhTxIdUiGY2t1LbQ5qaoGSbDuYYk/1ns1uQshuIUGoZnbw46z9nBBYd56G71lS
	 xYb3moZQOt+8weX9/bLSTefROSVHbZockXNJjhVPx41DOniSQaO4MzuLHQbkwisTY8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WO66eT93;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C42606A328
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 15:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C42606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WO66eT93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793805140;
	bh=JFjXz+DM4ofvkk2EmcoTPHQH7AEhGNy+pLKqdHTFcPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WO66eT93v+ULHVLBpZvmcUnsTxxq/Riu5MydA/+knd34lY+Wdl1JoSdCVuIEgPbeR
	 v4AW6Jn1tvWR4algaRTxEVXDNsPeYEaR9vhhOmpAJmHL2JE5z5h+0+Oq/pMGxJtYsb
	 ZIGMyf0NCHXlGHwAfGTwcrQeTuRraVpV/ThKok3V/TM0Y6svXWoxyOuh1JDvHRl7st
	 N97sK8cny+iIGvhWU5kfhBGvYtx6N8vNjbrIgPIAQWXj1P3hyAcCNi11/6TugVif3c
	 22rSINPKdykFCovGboFRs/4plmPWeVY8xBtWMklF3fkvri76TIY5ew7Ic3b70Z3VeZ
	 AyhYFGRG8nUJw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKTSg6dlXzKq5;
	Wed, 04 Nov 2026 10:12:19 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Claudio Scordino <claudio@evidence.eu.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 01/12] sched: Reject SCHED_FLAG_KEEP_PARAMS before reserving deadline bandwidth
Date: Wed,  4 Nov 2026 10:10:22 -0500
Message-Id: <fc36341b93c2e994ccec71a5ab6d5c8e76b3d73c.1793804635.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
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

__sched_setscheduler() returns -EINVAL for a SCHED_FLAG_KEEP_PARAMS
request that would change scheduling class, after sched_dl_overflow()
has reserved the bandwidth of the request, and nothing gives it back.
Switching a SCHED_OTHER task to SCHED_DEADLINE that way fails and leaks
the runtime that sched_setattr() filled in from the task's slice, up to
100ms with a custom one, into the root domain's total_bw. Repeated, it
makes the root domain refuse every deadline task, and refuse to offline
its last CPU.

Reserve the bandwidth after that check, last of the checks. A refused
request also leaves sched_reset_on_fork as it was again.

Fixes: 8a70415351ba ("sched: Reject SCHED_FLAG_KEEP_PARAMS when it would change scheduling class")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/syscalls.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 3fa447aabe7f..f0b7b2d52614 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -655,17 +655,6 @@ int __sched_setscheduler(struct task_struct *p,
 		goto recheck;
 	}
 
-	/*
-	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
-	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
-	 * is available.
-	 */
-	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		retval = -EBUSY;
-		goto unlock;
-	}
-
-	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
 	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
@@ -699,6 +688,19 @@ int __sched_setscheduler(struct task_struct *p,
 		queue_flags |= DEQUEUE_CLASS;
 	}
 
+	/*
+	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
+	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
+	 * is available. Last of the checks: nothing gives back the
+	 * bandwidth it reserves.
+	 */
+	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
+		retval = -EBUSY;
+		goto unlock;
+	}
+
+	p->sched_reset_on_fork = reset_on_fork;
+
 	scx_prepare_setscheduler(p, policy);
 
 	scoped_guard (sched_change, p, queue_flags) {
-- 
2.47.3

