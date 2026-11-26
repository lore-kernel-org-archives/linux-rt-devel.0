Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655349;
	b=m5bu9JRwMas3iGBwk2EKuLPC9XYObXJFpGRzogbchllTHbhbKcrVz3FGQg/gQ2OT9+kS
	 32RsHuPaILWiIuh6ByAhoPwjciNTtqgWEk7Yj8hNi45f8YtZg3KpMu8GCMDIE6gabHj3I
	 9btYu4aEhmREVWJWwvFXz438765Rx+z2UAA/3aMIm1ajpb8eO9DHJDEXvFCs/NP9Cm4pV
	 MYxpHys/BbxDSjMbCPweKapHsMlhhAZvrFePMLXc1NJcfPRW/iLUC7v+XbStLrIlU/bhq
	 OzkKDCyazbICMGXRj3N/p+kJ2ROjSXXDAPN0eIWu+/FBI/ZSJlh50HOyrzbiKXTuBgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655349;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jcvnt2MEndmR72Oufzu4zRYtgpH0SGtAcMgoQtZh+rI=;
	b=y+uiS8Xi5UOHa1qxXHsVcdxwRCY/A+LXPXXCiwpcb4ZBnNsaQSGh/1jLXPnZZy11ep2M
	 5mAbA+7p8xrMFhEZVvszRnl0JehZEUNnQstCkImxPzwOBbi8wXgurPT/N3ib3KYmUQwz6
	 tzvgEc8FJvMb9MPmoCiihtbkFfZe6Mxm4oOQQb7Ytn46OC0cNJDNMxC20W+q5YkUJhAx1
	 NKZnrQjjqkYw809nlqC49UP1TCYf+TU4a9CIGl9zTpXVrx59Ea+7zDBlDVHIsEDBFhsgi
	 7HBedilivmeMb7uRk+tZcxakB0lg5mpofxJHrd1UK2CbsYeHYyUM2vN/JXkeF1Bx9Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WzBMQHB5;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F92606CE44
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 01:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45F92606CE44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WzBMQHB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795655348;
	bh=Jcvnt2MEndmR72Oufzu4zRYtgpH0SGtAcMgoQtZh+rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzBMQHB5HweBxBO5TIIGAmsEi8g/+qOrra8iEEcevvq2TvnxheMMYyv2vxZX12vtB
	 2L7Rv52p0LNBFMfDjpY662mcGfofjMspREV+p9YGrBSszvr7wVd85F41iySA6FGZrd
	 WFPK5/T8hvse9C5yz1k7AWTTvViBuNilvpeFmR6ZUEA5orr/TNeEZuH3Ic5eQWu7F8
	 LX8//85mZxn8M3a4OkLwc3B/zNp04HaPMJ5THbv1cq6xkhVs9dtsE/8L1b2yWMmmCa
	 g1m6pycrtMY0RXLH+mfIRbCD/ynnQXawgigpz9GTpesTWHaTeuKm/DEG6UT0HnPVbA
	 IFxFp5m5sn+gA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jZdjb6rdNzWg3;
	Wed, 25 Nov 2026 20:09:07 -0500 (EST)
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
Subject: [PATCH v11 27/43] sched/deadline: Replenish a throttled task boosted while asleep
Date: Wed, 25 Nov 2026 20:08:26 -0500
Message-ID: <f3e7c8f840d132f99c675ebba3a4593c01359bf9.1795646914.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
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

A deadline task can be throttled as it blocks, with an rt_mutex held.
Its replenishment timer is then armed. A deadline waiter can boost the
task while it sleeps.

Commit feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads
while enqueuing") lets a boost override the throttle. enqueue_task_dl()
lifts the throttle of a boosted task, and dl_task_timer() ignores a
boosted task. This covers a task that is enqueued while boosted. But a
boost of a sleeping task does not enqueue it.

T is a SCHED_DEADLINE task that holds the rt_mutex L. W is a
SCHED_DEADLINE task with an earlier deadline:

  T                                  W                              T's timer

  uses up its runtime, sleeps
    dl_throttled = 1
    start_dl_timer()
                                     pthread_mutex_timedlock(L)
                                       rt_mutex_setprio(T, W)
                                       T sleeps: no enqueue
                                                                    dl_task_timer()
                                                                      T is boosted: returns
                                     times out
                                       rt_mutex_setprio(T, NULL)
  wakes up
    enqueue_dl_entity()
      dl_throttled: waits for the timer

The timer has already fired. T would never run again, not even to die
of SIGKILL. Every later waiter on L would hang too. This was found by
reading.

Fix this by returning early in dl_task_timer() only for a boosted task
that is queued. A boosted task that sleeps then takes the existing path
for a throttled task that is not queued: it is replenished.

The refill reads the parameters of the donor, from the timer. So this
relies on two earlier patches. "sched/deadline: Do not replenish a boost
from cleared parameters" keeps the refill from looping on cleared
parameters. "rtmutex: Continue the chain walk when a waiter's deadline
donor changes" keeps the donor pointer from going stale. After a
deboost in the class, "sched/deadline: Restore the owner's period at a
deboost in the class", later in this series, gives the task the values
of its own reservation back.

The Sashiko AI review of this series found this.

Fixes: feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads while enqueuing")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 11774b3b9fe9..172fb2811d4a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1675,10 +1675,13 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	}
 
 	/*
-	 * The task might have been boosted by someone else and might be in the
-	 * boosting/deboosting path, its not throttled.
+	 * A boost overrides the throttle. enqueue_task_dl() lifts it when the
+	 * boost enqueues the task, or when the task wakes up boosted. So a
+	 * queued task needs nothing here. A boost of a sleeping task does not
+	 * enqueue it, and it can end before the wakeup. Nothing would lift the
+	 * throttle then. So let a sleeping task reach the !queued case below.
 	 */
-	if (is_dl_boosted(dl_se))
+	if (is_dl_boosted(dl_se) && task_on_rq_queued(p))
 		goto unlock;
 
 	/*
-- 
2.47.3

