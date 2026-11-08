Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147244;
	b=qFJ7cd1rWc5mxqMvpaNWx/JpLcI6CMRnjWF7JlnL6l0uJ9wBCCNmTt5oEsgJbZGzDNR2
	 cENQQIc7P+DaYnc0fyAF/G7X6kkjzdOtL0ij+gUN0lD0Qa5ch1jdb69f4iCPqi29RHcG4
	 WlfoLAfVWjsFpKmdu1OS+vuT103ikIoAhRCqqgGVD0QnGNlTLOYNd1LPCDdW6nE9k8DDp
	 khswVD5CLk1mEsbnV3JfI7QJPIOdAxLO636wTrc3yRlRSrmgEttWfA9udh/HPjHXZDNgA
	 g9t8TFuGwEEhwlRbvyaa+Cic2ReVwBW8RBCmlxJviRauH4ntTjDskRGdgEIJwK1bKcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7zGNswp2S5A+aHdnil4xdYNIbQVKZZQyND/TlN9QSMM=;
	b=4lMH4+XFLiEZJTXxdCUBSMBEbY9eAhTFG4pMfLv8Tu205ZydrnwAsNxHzHnJ079RG/i0
	 YTiwW2SKEPq0VfYdvCFsSjNMOgDPJ8x5JIKZZpCiOeIRKnUknuXmu0th6+1DA4tEUdO4B
	 kzX8sNcOU2bX3SRGqX2OutqVFI3q5uphFEofjjBX6YN16N1IFGItXMm8+jvlY2tUvZfMj
	 CpY36wIa5YleilXhH/5KQR3L1zkYyu/1/wniqMWtvlBSZVj+KlsEk7nMevVJ7W1BeltGL
	 hxpvAlcIWz4XCfqzCHSQkrLIdP4Y7CiEb+5bjXp9w1g6qJdT0skyB5RpHsY96y/Z55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=f1SYvsTP;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFA606A321
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 14:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99EFA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=f1SYvsTP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794147236;
	bh=7zGNswp2S5A+aHdnil4xdYNIbQVKZZQyND/TlN9QSMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1SYvsTPRITRztGPlGrw+LtocMt0Rv2DQmVzWfpnSbyYj7FCejyQL8+gzKWY55JH5
	 6Hd5s+P4uDmDLpTzArmkNMCRiw+XVDmtGfCaJymN5pxSap4F/E0B2n0rpEziZk7F4H
	 /1A3QJgY3a3+ivmxW4zczEZJnqaE2MU8k88c0GqUclB374eJng1c6KDNFDmfKk17O6
	 e2ydozCNWs5xiEY+yGjMphr5rzynp0YNdjbnezu4d+/3V3V2urLgLVayXe/OW9mlWW
	 ig2mxB+ZM2aVf527ATyZhAXVa0J+WRAEtw0aFymZNCsc3IneSEr14oICaI+9sjEdkD
	 on0Z7zN9OKXiQ==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jMvzS0hnTzMgm;
	Sun, 08 Nov 2026 09:13:56 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	shuah@kernel.org,
	juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] locking/rtmutex: Stop spinning on the owner when the waiter is woken
Date: Sun,  8 Nov 2026 09:13:43 -0500
Message-Id: <20261108141347.1525532-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
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

The top waiter of an rt_mutex sets its sleep state. Then it spins in
rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
the waiter back to TASK_RUNNING. The spin loop does not check for this.
So a timeout or a signal is only handled when the owner blocks, or when
the waiter has to reschedule.

The rtmutex_spin_on_owner() is just an optimization with the idea that
if the owner is still running on a CPU, it will likely release it soon.
If the owner gets preempted or schedules out on its own, the spinning
will stop and the waiter will sleep. This came from PREEMPT_RT adaptive
spinning for rt_spin_locks that allowed them to behave more like normal
spin locks and speed up PREEMPT_RT performance.

The problem is that when this was implemented for futex and normal
mutexes it did not account for timeouts or other mechanisms where
the owner releasing the lock wasn't the only way for the spinning
task to exit the mutex acquire. The spinning currently does not
account for anything else but the lock being released or the owner
sleeping.

The owner of a PI futex is a user task. It can run for a long time.
With an owner spinning in userspace, a 1ms pthread_mutex_timedlock()
returned up to 1.4s late in testing. The timeout signal or any signal
to the waiter will not stop it from spinning, and the signal will be
delayed until it exits the spin.

With PREEMPT_RT, two contexts that take two ww_mutexes in opposite
order spin on each other. Only something else that needs one of the two
CPUs stops them. By default, the fair server does it after 950ms, to
run SCHED_OTHER tasks.

Luckily, when the spinning task needs to exit the mutex lock code, its
state is set to TASK_RUNNING. By having the spin check the spinning
task's state to see if it switches to running, it can exit the spin
appropriately.

Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/locking/rtmutex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5a9534c715b8..323973be2074 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1516,9 +1516,13 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 		 *  - current is not longer the top waiter
 		 *  - current is requested to reschedule (redundant
 		 *    for CONFIG_PREEMPT_RCU=y)
+		 *  - current is woken, by its timeout, a signal or
+		 *    whatever else would end the sleep the spin
+		 *    stands in for
 		 *  - the VCPU on which owner runs is preempted
 		 */
 		if (!owner_on_cpu(owner) || need_resched() ||
+		    task_is_running(current) ||
 		    !data_race(rt_mutex_waiter_is_top_waiter(lock, waiter))) {
 			res = false;
 			break;
-- 
2.47.3

