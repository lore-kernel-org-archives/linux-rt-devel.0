Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907260;
	b=EELb2FKLj/d1jm1SvHIbT40+OwC5x9D435dh9ju5aTQKVdRMp4dBjF5vHOi6ywKqOA64
	 knll2T3493AJBAOIEE2xkDgXx4+LXSqEdJouHsFSx7qcTsacSLBBjGm9VmpwInfbJEWfd
	 uoSimBWVcrxt0FDJ9wctDYVAB3LcztAUjfSnXqGATOXDYgk13nBcQ0x8HffdzNKE/7yUP
	 rv/MSgT+xDfP6fEiO1JOoHfxZb9th8NzYQdoBX0dp739Mw2M7HAl3aezZPdBsyN0TWuaH
	 AaMuIILooo7L6zN4AO9uEbyyKiHZ70YSJhbhzHfpya5esQmz5d1XYxLIzocTV22uQYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907260;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9xcKHMbn3SsYLrcgRVCN+uYKxdH8XYhCdsy+dXlYLgA=;
	b=SsYrDv1Jc4/U3YTv7dcuNHu9UoFFZWt2LQ3/w+9r+SBV2HUg+y2t2D8WU/6RKISs3L+S
	 ET6BXFS6UHxWwDIrntzZvjFi13iwjIZcJh/RKec0bJGdVv1zuxL3UflueDkZ3RxWk6oqH
	 +tDvzfL7xaoWr+V6hF57JXasb6wBfFjpapmoBvam3Vh2yVH/6aJZafDkCaGPa6Ko9zj//
	 GiBlEQXOs10+3aHZob7Wc1We4OK0UbWyr/Jt+7Y6xMEC9bCq6ZwtphzCfnGNO4lRCAZfk
	 /sF7vJoomFwruV+g38F5bXUjbUrNQ9vQd5ns2IclE3zL4dihtXTmOdlVnEELuFBoD6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=T3Y2FqCm;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32FB60A2606
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 19:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A32FB60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=T3Y2FqCm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793907252;
	bh=9xcKHMbn3SsYLrcgRVCN+uYKxdH8XYhCdsy+dXlYLgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3Y2FqCmR8Ff1NGspV0s2QL4Ofq2YBYPDEBhyEuWSZzWYspvomB1y2OD/y0AX/RoJ
	 aQ8pxHH1F4/0Yn/8i0Zu2eFtKoInygXHy2MewI8XnmqtevneJg/o5AjmEVaF1Rh86i
	 kpXV+S6rVdHfHB9rXYtfzwjBtlG1HPejMXUm8+TRZWADazBb9UZ5nLEXZ8IV2By8J6
	 PMy3jD1RQl5xnwa9DzAcik9sCaLbpPdAUbTh7SPYP71xQQdQZ7OVk62Mq/gQvFYylt
	 cUkzEO8hJvxOsbCL7pkT7sfEGwc/m8f01mVoHoLkoJnA8dpYM6SUI4UdKTrr3Gw8oq
	 875HSx7K4kruQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLCDN2YBbzLkq;
	Thu, 05 Nov 2026 14:34:12 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v3 21/24] sched/debug: Show the deadline bandwidth of each runqueue
Date: Thu,  5 Nov 2026 14:33:56 -0500
Message-Id: <20261105193359.1450487-22-mathieu.desnoyers@efficios.com>
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
index a4ae092e0a68..c8a2cf18fdd1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1171,6 +1171,8 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
 
 	PU(dl_nr_running);
+	PU(running_bw);
+	PU(this_bw);
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
-- 
2.47.3

