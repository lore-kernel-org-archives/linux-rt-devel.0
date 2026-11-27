Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790179;
	b=U/dsXpcgIE2Ai8h/RxzMwR4slZCFwSGuTSzNnmm61QZsgnFavEIEm+LoZ1SeHYtZeVHV
	 akP/q9HAcIVHsaBm0/RjT37pUAQTsqxR8ewEnW9z6VAGYxbUKzJ4nKza4WR4RxN9lZZuP
	 ujLEdhB5QuHsg9xkES7psi9Op3kEZJgYEYgLUZ70T9N03XqvT8vHiU/JZ1xW7irkj4s2d
	 iGaX+UXGKHJDdKidegoX9w2rX/WVNAK4nO08wqpc81X155I0u2+b3HRQDmnWlTZTsBNkk
	 zaHUiEDnao3RmukHT+/qYB5x8oOvAy1QnI40UwXE6HRliECNhz8ZCb6fKACblzfu6EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790179;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aS0DvzBzgJqAo5jV2WE5g5pT36OWQ4iGj2FYA7gJd9U=;
	b=Uzuz7nI1VGreM+OIHMDS1w2TIIL1ShWapE4Z+HTl5gxhYaALOj7GutKizg/Ea5QZtyaP
	 sOZwLSd3rbXcL4eLzAE1V485jjw64gsWVcEoyYYI0mbB0XmVsHvRSlgo4ndNAlmDUJ7td
	 qbUJckFCHz9Ui1mysU2zLqmY/ID4LiZgH2B8DfQiL7bEhGIBWx8f7Vi/y3xIi6a13CMlM
	 /sOw+4Fhl200KGhLKWRiDLzNYqsG/b/bK3WpEupiJOxqX046uWe9pBCDOfQAqBDec1ctH
	 mLYX0jhANoXY/kxRLIVSGZGlWC2moS32k/3mxknil80ZsoW05aQsPJva7+gAXfzDpiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=RdhxgKz7;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D460A261D
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 14:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 384D460A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=RdhxgKz7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795790176;
	bh=aS0DvzBzgJqAo5jV2WE5g5pT36OWQ4iGj2FYA7gJd9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdhxgKz735W4EFzyAyZnHNswUpSHlEZwdWR1f96N1jLNFP2dwtgR1OW8ptgPvz39I
	 eRj8K9t9mZ8mbzciqawLLrwXnv3TFS8zTN6NkojQzzXFgWSpTOqdjgHIklb61Jom+r
	 Se5DF3JvY41vd6uAw+SkjCvc7JgsJ+qIGZKdit3SvKdIUFGGfYwvrGLxg8xg3CFNRR
	 PRxq8RcR6mwmVaqPxkFQutV++gAM5n/j0Ms/PUUyZNAeSHQIDi7GagKxfHUSoh5Xtf
	 hqH9wB3ifKo6s9EZCnfaVJ8vFAGN8AEi+//ch3zK9I8vcU8hHq7dvQVyGVyt5p1ZWq
	 QQWlB+uEzSsfg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbbZS65myzXZK;
	Fri, 27 Nov 2026 09:36:16 -0500 (EST)
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
Subject: [PATCH v12 19/43] sched/deadline: Count only active CPUs when spreading extra_bw
Date: Fri, 27 Nov 2026 09:35:46 -0500
Message-ID: <019156e5ecd51a4b59b7bfdb6dde76fe549511c6.1795771148.git.mathieu.desnoyers@efficios.com>
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
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 882e7bc5a934..3f02d150e15d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1076,7 +1076,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 			dl_b = &src_rq->rd->dl_bw;
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw,
-				 cpumask_weight(src_rq->rd->span));
+				 dl_bw_cpus(cpu_of(src_rq)));
 			raw_spin_unlock(&dl_b->lock);
 		}
 		/*
@@ -1088,7 +1088,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 		dl_b = &later_rq->rd->dl_bw;
 		raw_spin_lock(&dl_b->lock);
 		__dl_add(dl_b, p->dl.dl_bw,
-			 cpumask_weight(later_rq->rd->span));
+			 dl_bw_cpus(cpu_of(later_rq)));
 		raw_spin_unlock(&dl_b->lock);
 		dl_record_bw_cpu(&p->dl, later_rq->cpu);
 		p->dl.dl_bw_gen = dl_bw_gen;
@@ -4366,7 +4366,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	dl_b = &rq->rd->dl_bw;
 
 	raw_spin_lock(&dl_b->lock);
-	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+	__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
 	raw_spin_unlock(&dl_b->lock);
 	dl_record_bw_cpu(&p->dl, cpu);
 	p->dl.dl_bw_gen = dl_bw_gen;
-- 
2.47.3

