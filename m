Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009595;
	b=3I027sWL7jUh1/zPtPzw5KqKvqoJ0WM/tbck01eMmz2ZPDzIR6GxXBbZIIEIcLQE2oj2
	 7fekeUwISmDV9yU7xucUVgdXkQbXyebQdRNz/tv31ihEkkXEzY8KpQ7Q7qBfeX3uW4pl7
	 C/3tWKMBBXn+CSFm5rNHmXYMf1WYLezYTa6j1iwK8JthhW4KQImMO99Z0rDoPqlcitq2c
	 QWY5FItqkHx9ireyu/tTdpeVDB0AN+Kgldeab/18VSqwv0WJ32KGRw8W7IoXbsF60mK5h
	 zqmNod4vJFsTkYKRQ1NQt1RVafBSNiYlnh1r8RtPajEGYluLuzN0ZTZ/kIPefZwyWyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009595;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PpUPxyvwlx0B8AD5xUC2UMH04Le3Oz1Nx0kRPHSzOzQ=;
	b=ODlMa5Bki7mVcQM0zvmRJxZBGrtYOqsP53VoB0zO/M5tCA51XVq7UGzWUSN1h9ovZibN
	 w/VxOMEaJdLrrK48gZ5IcV4ZmqelcW30WphBSeiDG5mzftj6UKBQfembzgjajTe786ldt
	 IBoCNs7iMGr42icZsnXK5eucnz9FNjOkAa14RWTCtlYIKvMC+zPNAJKfDM/fYViv+sYnw
	 4pd+/85BAWRZjNVo1kTDP6vHaPPpT6CeabZtR84kNiOezvDNmqkiwaRUnzLQHzZHDpCMz
	 Uj+SsksPReZkSamzXtpXp4G9/4E1gGmtmzfPHdVcOUQrBS/Q1RjyNP+GIc+YDN8Ladw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=F4MsfE+y;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D22606A33D
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 23:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D22606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=F4MsfE+y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794009586;
	bh=PpUPxyvwlx0B8AD5xUC2UMH04Le3Oz1Nx0kRPHSzOzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4MsfE+yBYGqu3nnxo9C08LkVVllIM8d2dcv28fP6AYA6veSGbQsil9kL+m7fNQBE
	 f4nzuhK4vHfVSZaw1RjbvdTD3Igg9uJUKi68TRwkUvhNqT40PZBVz6jwPtC8dlMzxS
	 5eaetWPLjiZQ6O8315WistOuIohoHLKGWvXc9D5QGlYVBiKcdR9uhCUqSyI/zoce6J
	 eDX6zsS0u5XiNCC6/dSOatFW0fiGUHAHDiCdWekmNgmiaQN7Fk4xsAWs/cq+jSmz/k
	 /RUs4lcUe8g+Z0WjixX6iwfox+MxpdMY3UFmEIoT0c/habud4pOEqk6f0Xcdgkjo3K
	 wXRlhUmK5O+1g==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLx4L4HFWzL0Q;
	Fri, 06 Nov 2026 18:59:46 -0500 (EST)
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
Subject: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when the waiter is woken
Date: Fri,  6 Nov 2026 18:59:27 -0500
Message-Id: <20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
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

The top waiter of an rt_mutex spins while the owner runs,
rtmutex_spin_on_owner(), and does not stop when it is woken: its timeout
and a signal find it running, set it TASK_RUNNING, and the spin goes on
until the owner leaves its CPU or the waiter's own CPU has to
reschedule. A PI futex owner is a user task that may run as long as it
likes. On v7.4-rc1, in 8-CPU VMs, behind an owner spinning in userspace,
a 1ms pthread_mutex_timedlock() returns ETIMEDOUT 126ms to 631ms late on
average, 1.4s at most, a SIGUSR1 is handled up to 1.9s late, and a
waiter killed with SIGKILL is reaped 0.5s late on average. With
PREEMPT_RT the wound of a ww_mutex is missed the same way: two contexts
in an ABBA on two CPUs at SCHED_FIFO spin on each other, and the older
one gets its second lock after 96ms on average, 0.95s at most.

Stop spinning once the waiter is woken, where the sleep the spin stands
in for would end: rt_mutex_slowlock_block() then sees the timeout, the
signal or the wound, as after schedule(). An rtlock waiter is woken out
of TASK_RTLOCK_WAIT by the lock handover alone, and spins as before.

With this patch the 1ms waits end after 1.01ms on average, a signal is
handled within 0.3ms (1.4ms with PREEMPT_RT), and the ww_mutex ABBA
resolves in 12us to 33us; a contended PI mutex keeps its throughput.
The futex_lock_pi_inherit and test-ww_mutex cases added later in this
series catch both.

Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
Cc: stable@vger.kernel.org
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

