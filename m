Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182965;
	b=1bv/cFqOkTHSumm4fauAeiHXNn1peW1ntuETnEckctz+nKZY1/I53qsd5RXLqrELZhvv
	 GB/SdEm61LmSdoLk3AOmjNcNdXPBVHs0aawGs5Q+JLJKsGdTDpdRHjr1WmuMMavHNYCVD
	 KKlplMp5Xsg/ld2e9L4Scs130BaEAH+HTJoqnHjsyjamTg8cbip/B+5JJp2NLe+fNZ7et
	 OW5/exhWrdtI1HteWE5U3DCbEInSLEcdjlElVIlM1tg3ZhuhiGq6gcWpPoEvTjIS4XTYZ
	 5ERssJejUgzUaXSORYkQH/q5SO8Flk0aqpzRiEMrulY9Vcg69J4iLQsNC62j8VhE6MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182965;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qCB2fix+3aS6n5q6I9UQJElOCRYSoqXkzqP1nc/GtB0=;
	b=DWj1EVX2fvYRMYC41DCKquiK1EJ40MQyu90J4Ybtl1VOSgPSQREWATvt+SnS7BjbBz+H
	 nTyuzOd/kJeOpcGqr5KkMP+Jk8lmMwVtscJwLcKg2bmgVkv9Gj4YxvmUsz3xSsDUD4ow1
	 RzBhaoGXDRo6S0T6xHgKs4+1g5pmYaw5/QqukWG1y7p6+JkYj6hlr6jTZFjYjNrbPZNRI
	 1isfn2btfg8SPnkW3Q1lc88tD7z9s+JaMRcKfsj95gnkEkMvYLzH3m3HuYlbIv0GTRd2S
	 7S+xAjtnx+g+Hpa73EUbrZltz7X3tpWqHgTaOaKfQEELCJtDfbfdtrRyYeJkGyM9A1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HD2pGZDt;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2D60A5BC6
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 13:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C2D60A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HD2pGZDt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795182962;
	bh=qCB2fix+3aS6n5q6I9UQJElOCRYSoqXkzqP1nc/GtB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HD2pGZDtv8qQU14U3Xg5JIpavl4XwXzds0i1XXcTn5vWLNtttgkFFpxSyL6eTl/sG
	 pfeNlwWYCo6pTLneWiZlX+kE6ZpAm5TY4OtkwIaWGXA/hwS8z2zQh5PGwArLDhk4Jm
	 CoI6TG4V2lXtCia0cr4KbyDBjXPRSe3nqKHhiG77UW207Yi+w8zxAXaw055mQ/LFuu
	 s470TorlJe0FxLef5jMcs3M90CF0scStSZCaEFwQBwW2CLDIUWQzsYrZLUMCklxX6V
	 Ew9XCs2R3Ir0wQzHVOkhc7/EBngfR2y+/PBHpFZ4f9NrVESMFiDUi7W1L0ERxekREG
	 3h9ZIYs3g/Jpw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jWH1G4cL9zTw6;
	Fri, 20 Nov 2026 08:56:02 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v9 19/33] sched/deadline: Count only active CPUs when spreading extra_bw
Date: Fri, 20 Nov 2026 08:55:42 -0500
Message-Id: <d5498fc466e0d41c6189eef2ecfb8d99c5aee586.1795181240.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
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

__dl_add() and __dl_sub() change the total_bw of a root domain. They
also spread the change over the extra_bw of its CPUs, which GRUB uses
for SCHED_FLAG_RECLAIM tasks. __dl_update() changes only the active
CPUs, so the cpus argument must count those. Most callers pass
dl_bw_cpus(), which does.

dl_task_offline_migration() and dl_add_task_root_domain() pass
cpumask_weight(rd->span) instead. That also counts the inactive CPUs of
the span. A span holds one while that CPU goes offline, which is when
dl_task_offline_migration() runs. Each active CPU then gets a smaller
share of the change than it should. A later change made with
dl_bw_cpus() does not undo it exactly. extra_bw stays off until the
next rebuild of the root domains resets it. SCHED_FLAG_RECLAIM tasks
would reclaim a little more or less than their share meanwhile. This
was found by reading.

Fix this by passing dl_bw_cpus() of the CPU whose root domain changes.

Fixes: 59d06cea1198 ("sched/deadline: Fix bandwidth accounting at all levels after offline migration")
Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/deadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a21b504d467f..2e1b78d8f2db 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1062,7 +1062,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 			dl_b = &src_rq->rd->dl_bw;
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw,
-				 cpumask_weight(src_rq->rd->span));
+				 dl_bw_cpus(cpu_of(src_rq)));
 			raw_spin_unlock(&dl_b->lock);
 		}
 		/*
@@ -1074,7 +1074,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 		dl_b = &later_rq->rd->dl_bw;
 		raw_spin_lock(&dl_b->lock);
 		__dl_add(dl_b, p->dl.dl_bw,
-			 cpumask_weight(later_rq->rd->span));
+			 dl_bw_cpus(cpu_of(later_rq)));
 		raw_spin_unlock(&dl_b->lock);
 		dl_record_bw_cpu(&p->dl, later_rq->cpu);
 		p->dl.dl_bw_gen = dl_bw_gen;
@@ -4338,7 +4338,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	dl_b = &rq->rd->dl_bw;
 
 	raw_spin_lock(&dl_b->lock);
-	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+	__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
 	raw_spin_unlock(&dl_b->lock);
 	dl_record_bw_cpu(&p->dl, cpu);
 	p->dl.dl_bw_gen = dl_bw_gen;
-- 
2.47.3

