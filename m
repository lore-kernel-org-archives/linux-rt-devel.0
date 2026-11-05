Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907260;
	b=O9gOanRTY5I3RZlHY+fkZN9QqpHLjqf/qp4jDXAD9Yzk12t8GeTgqMEJf99JkWqvMzkD
	 PjPZNJi1RSXNWUndAid8jaTXe4RTHaeDprLr4mCTjhMyod3UzSNhABmHgtuF0HdxNpwMY
	 aL7hs7WOEqi9bLUT3h7wKfV46boIcIv4fhzixkeE4ecrbIAhTAQvzL7bWTtZZQGyCOcw8
	 xGdfY5LQkZemmFOiIr7EmaBK/67vA+RgVSJLKypHqMbUSWzulC+DOpOu05gl0m35tm3ei
	 jrxXfpvok6szJmbT+QLR2SX/mDFz08CE1ybH7pM3jN99+M5Lg3YXA/cyNHnxGXqFLWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907260;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=af+4ajGlgtX+ITY+QAIEdN5bCJZjAJgGwtyaF8TMBHU=;
	b=tIhElT1rFvQhRgGdY7xCI7Y4xkfvMyVWZ21psyeVkJVLibWO0rkZVhosw2n9KXTnYPQH
	 vSXOWqzzJG+zPde8evCnBCN2sfFAU6Nkup2iM8yfvDMcScXzOiBHxnuF2Tv4w5G7NEXXC
	 yj9qm/zhJsR9XAhC2e4dcdxAAqaKJutVgdTgrPzlLuvdYYGE1B+PXeqX3PmzW7eWEJUeH
	 AIIyHW/LzqyseKb6IR9WEyH8w5kX3QJ2PStkXs4y/Up4F/+OjeRVsiPGB249TkZoP5mpw
	 ylwzFNpX+jHXhkWfPRelZfr+KsYgWtN1xg7cKVA/xVcwSS7YpC8xrtpQzGf7ix3dd2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=OQLVdqta;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0E6082BD3
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 19:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3D0E6082BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=OQLVdqta
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793907251;
	bh=af+4ajGlgtX+ITY+QAIEdN5bCJZjAJgGwtyaF8TMBHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQLVdqtawSXJY1GnRjdy1hBUsjTfNYsg6Mf9B3zNX9pkhLhbNZuRr3HvRN6I1VG+/
	 CZbej3v5BYhj06exYBPCc1MlBDplBuTh+o8Ru47xnV5Y7J5LbsxpdBr7TE2BnBAs84
	 fqw0ltBEnZkvu3/S45eG+eN4AJCKNL2fedvETi1hAT0geMKpNmWoviUtg+Sa0LFWht
	 1nl6T0vWePw3YvioHw3Y6Wc+4fs9d8Dov8L93XITj3/aogx9fxSMkSOcpR3uTcB38j
	 08jZ1QGNtXxleCWhDW4Ub9CfmlBzBFpj/hber+Zynj1cYZ+rAH1ZOCycsOlfEYHPEp
	 sqnxrvIgyby4w==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLCDM3kywzLPT;
	Thu, 05 Nov 2026 14:34:11 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 16/24] cgroup/cpuset: Wait for an attach before rebuilding the sched domains
Date: Thu,  5 Nov 2026 14:33:51 -0500
Message-Id: <20261105193359.1450487-17-mathieu.desnoyers@efficios.com>
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

cpuset_can_attach() sets aside, in the root domain of the destination,
the bandwidth of the deadline tasks it is about to move, and drops
cpuset_mutex until cpuset_attach() moves them. A rebuild of the sched
domains in between, rebuild_sched_domains() from a write of
sched_rt_runtime_us or from the energy model, takes cpuset_mutex and
runs: dl_rebuild_rd_accounting() clears the root domains and counts
each task where its cpuset says, and the reservation is gone. The
attach then moves the bandwidth of each task out of the root domain it
left, on the strength of a reservation that is no longer there, and the
destination's total_bw ends short of what its tasks hold: it admits
deadline tasks beyond its capacity, and underflows when they leave.

The writes of a cpuset's files wait for an attach in progress before
taking cpuset_mutex, wait_attach_done_lock(), since
commit 75f7a25ec6bb ("cgroup/cpuset: Prevent race between task attach
and cpuset state change"), and CPU hotplug holds cpus_write_lock, which
an attach holds for reading throughout. Wait in
rebuild_sched_domains_cpuslocked() as well: a rebuild from the hotplug
path finds no attach in progress, and one from the sysctl or the energy
model lets the attach complete first.

The deadline_bw_test selftest added later in this series has the case,
move_vs_rebuild: a process of 2049 threads, one of them a deadline task
asleep, moved in and out of a one-CPU partition root while a writer of
sched_rt_runtime_us rebuilds the sched domains 20 times, six rounds.
With the patches of this series before this one, a round leaves a root
domain short of the task's bandwidth, the root domain of the other CPUs
admitting 3 more tasks of 10% in three 8-CPU VMs and the partition root
none at all in a fourth, in 4 VMs of 4; with this change the six rounds
pass, in 2 VMs of 2.

Found by the Sashiko AI review of the second posting of this series.

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/cgroup/cpuset.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5b8f1d9552a6..aa946baeb4b9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1067,7 +1067,13 @@ void rebuild_sched_domains_locked(void)
 
 static void rebuild_sched_domains_cpuslocked(void)
 {
-	mutex_lock(&cpuset_mutex);
+	/*
+	 * An attach in progress has set aside, in the root domain its tasks
+	 * move to, the deadline bandwidth it moves once it takes
+	 * cpuset_mutex again: the rebuild of the accounting would drop that
+	 * reservation, and the move would go through on its strength.
+	 */
+	wait_attach_done_lock();
 	rebuild_sched_domains_locked();
 	mutex_unlock(&cpuset_mutex);
 }
-- 
2.47.3

