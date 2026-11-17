Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924681;
	b=VD2ywAOyM1/uy70+RisPZQgo9OlxLlFZEuARmL6s8aBqGlkOUaIxS/1rqgTGNv//ioNH
	 aJEnx2ms/tOlWqs4moQVKnnT0txGoXocShMRtVBh6DVfcY6hu1r2B6f+3S5M4o8Dm+FMN
	 vCmJmGBwVrA9PiWVu4AMAzrIKn3hfQg5o7gGerr5OViC1oyKEkKMnX6RHQhUSZq801kNM
	 6BDujOJ6/Piq8VORLMCH9GCE6DiHQhp2rctKfIVKgMuHxP2Zxmr1OdA8aCbzsrlbv5UbP
	 tXBkr1k19PzwmnFRWXnJwLlzkIHJnyfO9jlA4ozUYoFxUVSIt1GWZxveRUJiJWi6TQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924681;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9M5NIeA6NVT761eo01xF0IUXBCXx78ISN0+NnuJquUE=;
	b=OqHxMmKPf5klrSAqHBR9takGSaT4QCkjH+GLzvaUVm7i3qLzHe+QPgYHdiEAiqtW+u2q
	 Ic8f/6xkKdY5lN9AvF/SIZIN5HaVQxcx9V1dsOLX4SBSBOPA05VEElPrb+BBtcQvrVpsN
	 Kcs67QWDIUVykxQnYTDafQmL+w+WaUCU9DqK7rfn7th/nWBJ9e9S91G7lgZq9j8bgz/me
	 TB1Np2YX49XBymskLppXTvyVdFMC7iy3fR3087sTpiSrkFX4CFt9QQJyBwIbGaHReCIt4
	 H9XBPLOfMMlgtOCj6qlf2QpDPnv7D2EhOnx2yCMTLWrdqdsxm0NIYDt3b3HTu7IVZqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=OMQeCWGR;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4D606EF83
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F4D606EF83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=OMQeCWGR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794924670;
	bh=9M5NIeA6NVT761eo01xF0IUXBCXx78ISN0+NnuJquUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMQeCWGRtdT2aJvUdiNkKwa8xNr5T1e7EJ8M3cNvw5XvPS2kcQVWlSdUJiOtTRYym
	 BzMggnW2S8RSVhKcWvGvLYddRmtBuKnuC4Ei5RK352qclvZ2yRMQ9nrviExjObMdxe
	 NCZt8uZIN04ht9WelBoIXdXYN2JI+il3/zjQ//CSy09UNHqGP/81QTkNxnu7aMxeEw
	 swff5dIzlJYfmfTiULw6E3q1VdzDM1mz8wASfraGL09G26WJKj0pZFoTK+BsTRB+gg
	 A9XyatsifpROyqKk4gT05zhSYyq9ZMFsjZz9GMK8e1t4qIhcpFt8lBBTDqIkPj2Xbj
	 zgsg1K6GhMMtQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTRV65KTQzRgs;
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
Subject: [PATCH v7 35/40] sched/deadline: Check the runtime of a task that comes back runnable
Date: Tue, 17 Nov 2026 09:10:56 -0500
Message-Id: <96169a73e9e4118608f5557462dd37b798ae606c.1794922146.git.mathieu.desnoyers@efficios.com>
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

Commit a649f237db18 ("sched,dl: Fix sched class hopping CBS hole")
keeps the runtime and the deadline of a task that leaves
SCHED_DEADLINE. A task that comes back before its deadline goes on with
them. So leaving the class and coming back gives no new runtime.

But the task can come back with new parameters. If it is asleep, its
wakeup checks the runtime left against them, with dl_entity_overflow().
If it is runnable, enqueue_dl_entity() starts a new period only if the
deadline has passed. The runtime left is not checked.

So a task can come back with a smaller runtime, and still run on the
old one. Admission control counts only the new one. Juri Lelli found
this case. On v7.4-rc2, a task of 50ms every 100ms came back through
SCHED_OTHER with 10ms every 100ms. It ran 39ms of the next 100ms.

Fix this by applying the wakeup rule to a task that enters the class
runnable, with update_dl_entity(). It starts a new period, or reduces
the runtime of a constrained task, if the runtime left does not fit the
new parameters. The task gets no more than a wakeup would give it.

The return_running_new_params case of deadline_bw_test, added later in
this series, tests this. It fails on v7.4-rc2 and passes with this
patch. The return_asleep_new_params case tests the wakeup, and passes
on both.

Fixes: a649f237db18 ("sched,dl: Fix sched class hopping CBS hole")
Reported-by: Juri Lelli <juri.lelli@redhat.com>
Closes: https://lore.kernel.org/all/avHvPjz4dL0zNyGb@jlelli-thinkpadt14gen4.remote.csb/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1a07f4109cc5..b650c37ae561 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2834,6 +2834,14 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 		update_dl_entity(dl_se);
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
+	} else if ((flags & ENQUEUE_CLASS) && !is_dl_boosted(dl_se)) {
+		/*
+		 * The task enters the class runnable. It may come back before
+		 * its deadline, with the runtime left from older parameters.
+		 * Check that runtime against the new parameters, as a wakeup
+		 * does.
+		 */
+		update_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_MOVE) &&
 		   !is_dl_boosted(dl_se) &&
 		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
-- 
2.47.3

