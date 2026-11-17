Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924679;
	b=OPVhAS0icjY8esli/XYI3S83hXsaapwEiozgcWRhiEY1/eJQ3M/LmWcSA71VHC5mpTcT
	 sXFM2LBG9N1Swth8+pIHdgxdwWgUVSXBs+Nth9i/yQEceGIxaAUphXFITi9aXBkMwaa06
	 7vFMAjulrp8SmuX/Jrfx9hnwA7cgo3cLB/mh5CrD1T6uWiLGsXJ1n25IfP/KPbXfa7adl
	 cSgmf4Dek768BziZZ5l0IcCwn5/ePPd1PCTfY6/c46KNTvrktPXI84B2Y0nQBsGEor7Lm
	 KWZXFnoMPcq8QG6Mi11JQgMizVlQAgu8pmlUWmJlDf0BV5n516mszOxFdr1R9shaC3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924679;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bs/Ku4sHz2fSV8HldcGDwtrswmLI0cQKGxHaIV+Xyfg=;
	b=4xifsupzij40W09MMdeXgfiYAsuUPesGj3oQ6doKz+kHnAgxkYIUaToToPgQH33nLd68
	 tAmiGUJ97F5dB98e4GTC+BDUjnRU1Cy2cmDnzWODkWKaXaM9Xx2dw72aaLdrx3v+yMB79
	 syHoNSH6H1RUsKM9jveohYxXaze+ePoH7kRnFe+7pwBHZu6VF93pabeijCydB7ZhoOXs2
	 VTFVfqv2SK7/5w5QABvrYMiCVwHVRo3hcD3Wh+hOYDipU3AdBsHF1weuM6dYyxOwYDJmR
	 QdFoUqfVQnsRjUSV4Ky1arUv4D/KmpNJnsNGFTJgrPZhY1hWpYYKltt4kDlyIkNiqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HP1Sj50K;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB937606D3AE
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB937606D3AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=HP1Sj50K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924670;
	bh=Bs/Ku4sHz2fSV8HldcGDwtrswmLI0cQKGxHaIV+Xyfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HP1Sj50K03+6vfK/dsnbwQxLKKEbCpDAZLpucAX02DayjOwxPRt4bsoB772tS/fhi
	 2kvIYw9TTel5fRP6IAMLd0Y1E/qgWZgeDRuk95rO5cFpgx0kQ0OJYfELklqRHT79Zo
	 fMDI2++RRwPdVwI2PTbVAgbLgTmFFGA9qlLo4sa8r5RlBkW+cnyxPR6UNWNoXFnlky
	 6/LrXlOhe9831Q+VC3sw/r1B53P0TfDhDO0Zos7QTVjejU4MmHyS2kPnv913RZGHAQ
	 /TcbpEksKEK1fcKGRL54Er42SA0wJLgpOAVeL+26t2D4q9+8c+Dsv1Tz+UndbZrBbT
	 zleSYmb2UD7dg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV605xczRBY;
	Tue, 17 Nov 2026 09:11:10 -0500 (EST)
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
Subject: [PATCH v7 31/40] sched/deadline: Cancel the replenishment timer with the parameters
Date: Tue, 17 Nov 2026 09:10:52 -0500
Message-Id: <e00fd3ccc5be34826508d8e511f27cad57861570.1794922146.git.mathieu.desnoyers@efficios.com>
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

A task that leaves SCHED_DEADLINE has its parameters cleared at its
0-lag time. Its replenishment timer can still be armed then. If the
task comes back and throttles before that timer fires, start_dl_timer()
does not restart it, since it is queued. The replenishment would then
come at the period of the reservation the task left. Too early, it would
give the task runtime it has not earned. Too late, it would delay the
task by up to a period.

Commit a649f237db18 ("sched,dl: Fix sched class hopping CBS hole") armed
the replenishment timer when a task leaves the class. The timer then
reset the task if it was still out. Commit 209a0cbda7a0
("sched/deadline: Improve the tracking of active utilization") moved
that reset to the inactive timer, at the 0-lag time. Nothing cancels
the replenishment timer there.

The timer of a throttled task fires at its next period, which can come
after the 0-lag time:
- A task that yielded is throttled with runtime left. Its 0-lag time
  comes before its deadline.
- A constrained-deadline task that overran by little reaches its 0-lag
  time before the end of its period.

Fix this by cancelling the timer where the parameters are cleared. This
includes task_non_contending(). switched_from_dl() calls it to release
the bandwidth of a task that leaves asleep past its 0-lag time. A
constrained task that overran as it blocked has the timer armed there
too.

The Sashiko AI review of the first posting of this series found this.
It has no reproducer.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff559f2729fb..b9268c52935d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -694,6 +694,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 				if (dl_task && READ_ONCE(p->__state) == TASK_DEAD)
 					sub_rq_bw(dl_se, &rq->dl);
 				dl_task_release_bw(p);
+				cancel_replenish_timer(dl_se);
 				__dl_clear_params(dl_se);
 			}
 		}
@@ -2518,6 +2519,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		}
 
 		dl_task_release_bw(p);
+		cancel_replenish_timer(dl_se);
 		__dl_clear_params(dl_se);
 
 		goto unlock;
-- 
2.47.3

