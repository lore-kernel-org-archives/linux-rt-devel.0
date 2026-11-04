Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826737;
	b=ZpXO1uLK/Hee99CWgFXcWF29h2BklFm4RWEX5FsmYheLguoZIqR3h8y8Fnrfdq4TTeZz
	 +F1gK6XfnRCJjGzyq1oJ/ocUVrWlM+uy1lWKrFLmDpSWlhfprwBmiZQaRTkknPzJwvGGG
	 4xYof8vtvB22NjOZTDgI8N8dPrBLqOtLFJoWUTLOJyMFi6WNkh9CL+UwDi6SzmJQsjsek
	 mfMiHu9yeeRXv1nxSqTYWrHeijXMcXPWb8wZ0lqVFtKuQUPvNVE+GAfTWd4NSDS+TeUCm
	 3EgwraPZzuCgi2FotkCZ3+obpQeTZNJSBgDVY/Pk+GbFTUN0AJSfooeNL9gFZd5OP8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826737;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Iq+pznlnzu/qU50yyJxufWBiCcDbgVCSPC0v09LMgfw=;
	b=jUK9a1YuNnHYtc9U/VM4eFdTI8UnDgF6xP1r7hqrqMefULFdLqT1VPJRLlWDtpjizrjK
	 Dh7BVz66rX/FI5ZlL4hHnmPTYIidFgzAvcQh5VdEr4f7z1OpId71msPIV/QfWNKXOrFHt
	 pSOPCNzdHjK0kc8WE4UTxXJJ9iTY1jCH9nknv8JoGFlg60QGWqwIM80N9ZTah6vBHWfYi
	 AZEbDdlwZr9C4aPxr3IqjPFRMWjJ8cLIq3cdEoG/Yq5jlH0R8QGwDQk9uDT9OTYh8jULR
	 Tpcs6UbK6SFdDFm8zq9ZKhZCkh4y09qOyzg2CA20U8fiMjJ5RSZWArfYzXvDmiUfrgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="v/Pkdm7O";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9C60820A1
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 21:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC9C60820A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=v/Pkdm7O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793826734;
	bh=Iq+pznlnzu/qU50yyJxufWBiCcDbgVCSPC0v09LMgfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v/Pkdm7OsG89DSzheZStmUfkx5vGrEDIeG4DiwrJfof7sUNUYZgMLyar/DKR7/Xir
	 16uON/f443xXPITX2AFG76IF5reth/hLx0tEbPIlXVkOpTJxu5A/LQQcuzebeJ1lav
	 jBDZpcvkVzPYqHCadOKpFy/AVyCJo5c89YcI4HoZUzztr/SCvKMiXHzOe018gF0BXz
	 /423/MoGSMhaIufUg/O3ION7lGK1/ud1Do1gmAU5sue68+DbBG2S7JleqU7tt1Y3gI
	 8qsY1rFPmC7fOrzbnBWkCb5flBznbj7rL7v99YZLWFcRRKn9yf2/Ikrgu+RfDXs0Z5
	 hU6pSAd8BWlEA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKdRy3GqSzLXb;
	Wed, 04 Nov 2026 16:12:14 -0500 (EST)
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
Subject: [PATCH v2 12/21] sched/debug: Show the deadline bandwidth of each runqueue
Date: Wed,  4 Nov 2026 16:11:58 -0500
Message-Id: <20261104211207.1392343-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
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

sched_debug prints the bandwidth each root domain has handed out
(dl_bw->total_bw), and nothing of the two sums each runqueue keeps:
this_bw, the bandwidth of every deadline task of that CPU, and
running_bw, the part of it whose tasks are active. GRUB drains the
runtime of a reclaiming task at the rate the two give, the bandwidth of
its CPU that is reserved and active (grub_reclaim(): max_bw - (this_bw -
running_bw) - extra_bw): the less of its CPU is active, the slower its
runtime drains, and the longer it runs on.

Both sums have invariants a test can check, which the kernel itself
warns about when they break: neither may wrap, and running_bw never
exceeds this_bw. Print them.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e6a3b516c703..8a726817baa0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1166,6 +1166,8 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
 
 	PU(dl_nr_running);
+	PU(running_bw);
+	PU(this_bw);
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
-- 
2.47.3

