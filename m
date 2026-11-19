Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119388;
	b=iTwKIBqyvD6YUGejNojt/1CO7nPAnTOp2BGIdTPFYYPznaE2hV4n8eCTqYUCDKn7Qo6y
	 9UdYtIXxQ+NX9rGtpGCgzLFtvFWRJ5UV0USRDJwxfE1EbgP5vK7cTAF3TQhoQb9qgho5N
	 tXcrezkHf1OK5puJA51XiWyMt8nPDXL4X+1iGsUWr8qbpJosobB98cokpXwDnFNiRYLxK
	 IL5WgD4CAwqHr3oMHq+iIaTtk1EtLDF7sk9iVTcYxaVimUWs5Eb5TGTE/TghqlTTTi6ny
	 Kt0/dv7maT0F/aOft/6a6rNnImNtvfuZhWTRqmn91+ER7ADJxjNuPWD9TFVVawKvpZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119388;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ADboeXQohNTvbFLPoiyONtn0V51sHFi0IppZb8Okl54=;
	b=PamOwc2XRVAvfcma0iW9uKcbPIEXo8IUCx26Xsy6BRAh+ZMg6hxeA6NU/uKaiqI43eVM
	 KzTdNXrYsdKwqpv4MaE9isWn1issKxQDVqmTgWTkD+eEiG+dNjbegRZl34BQoREtCz1yQ
	 8EArfzqrE7b9p/HQPrkLvqwn87L2Oq6N0Kh5NMlgw3u/KBEf1iW7Bau/IN/9GHspUbkSF
	 byJKMapw4hakGKf08ZaDtvXFJRnjpiAFjDzLWQPMZgZF5I9dwFB984ZKgdNgHEJpVDosS
	 THFGJdEsuJqszQbvR70FYhSdlU97U/VWVe+oD8dnXqUyzvXGKsG+1vGb+Eq485Rhw9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=EKIYmtGH;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60660A380B
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 20:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D60660A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=EKIYmtGH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795119382;
	bh=ADboeXQohNTvbFLPoiyONtn0V51sHFi0IppZb8Okl54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKIYmtGH8dWuMnTC4kgMaimuppzaL+aMaZS8WrwboGMDgFxCeK4k94Cpet0iYBL/Y
	 cUBFk2yIjC4gAdFvQ34Ut/TzDMZ1c3vVHGBmD9irJnN3gA+NG3QEJGU0HsTvgYv/3Q
	 gXD3nLoGZ50vTjjrSL9rnKRnCXNw8kZ7Y2wWkyxIJxt8jJlzbPJm0yJxcqLIjG1oe3
	 Hk4RqVeMTmr8rU2/s7PbmZgPUukzrj7VJig82ZL109koIHnH7ZuCdvklsYkkXUO5BA
	 XUyZaX6M7x7DqytnPdOgj9KMXf4u8ksX2LHAt0zQtboYFfRtzXlB1ew3Im9q0602V9
	 fwErCKJfQkGsg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVqVY6Sp4zTdD;
	Thu, 19 Nov 2026 15:16:21 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v8 24/33] sched/deadline: Replenish a throttled task boosted while asleep
Date: Thu, 19 Nov 2026 15:16:03 -0500
Message-Id: <72cc0f62cfe227c6d86accb10d3c36fd2ec7ebdf.1795116791.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
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
donor changes" keeps the donor pointer from going stale. After a deboost in
the class, "sched/deadline: Reset the donor's runtime at a deboost in
the class" starts a period of the task's own reservation.

The Sashiko AI review of this series found this.

Fixes: feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads while enqueuing")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 66a1150c4811..f4b670fee4a0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1637,10 +1637,13 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
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

