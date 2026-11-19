Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105508;
	b=Yv1I0qNMsR3YZLc9A4QSvAFFm2m6sFDywdby+g5cvKc12DpfFhwceY1eTz73DvMpcg4M
	 3y0CfbCsh8rElhGu3jBdmqJ5Bgg1bgh8Zyzmj5/M+SjU9noaSXcen7f296pm+LIPzR61x
	 7NfmYurdLq3bW9MN45Cl72uu7qq8WT/k0Ep3/nv3vnm2wgZ17wrF0irux5+Up7lYCu/83
	 7NRKEyAomWO+TKSxcHqQabPyxUlxSZwW8mOQGY82DqMFW6tO1RV+a4ooCvC5bY58o6UmU
	 wDGAwU6v5M59xWTFZTzFe4ETLBR/0/Bae3fay62DxMuLn99CXw8DxRSybIlYUvAEwQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105508;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6c2WfmmuO5OP5xCe2CrO1/Z/FsV4bpBjjt1tFRNTMew=;
	b=Gcdmw76J54dew0QvRNqguflQoNPZAFESjHVmoM+cO1ovb4uOKY/9Kf5CGHCgCQm1Zm5j
	 GOB7XyqlrNWrHdSpG7+AOoSXxQnIi6ffQ4PQK77qi09faADK9/AKmYVP5DGIeY8OvuWX/
	 jahZZEj8JSjH1zj2h6aujjMMcefEBs+d3Z05sRjGjOHQ5oISkfK1xg2U5cS/g4YFbzkem
	 L0CwjkNWV5Fy5bDHFtFFRm7CvxiSHJqY8VCqwfc2rJ3eGsjwKU8sOsuDNUCRlsDeT89IV
	 Unm8elEyyiELM9sKRCsLcHePNVZJmKp+AKNW232dfZ+yMD8kE5xW1HwIKUECHeNaGVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=QTO+mOsY;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D63606A320
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 16:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D63606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=QTO+mOsY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105504;
	bh=6c2WfmmuO5OP5xCe2CrO1/Z/FsV4bpBjjt1tFRNTMew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTO+mOsYtnTVJM624RM5KZnHb4YoCbzl2efXhdI2G9hdFLxGnfzutfTKpFDcTP/nZ
	 zmN52bTr6T6FH+ME5xJmA26SAv2PrNey34P+uNT8WSz7rmgl6CyNw0JA1KkijMgYpZ
	 bD3xH0mN3uRLCp2fRcYHIvAd7L/IUFg0JjLukMgZNtHphW0iDVTvoxtsWsXG6lhH3s
	 G3fXWhZcd6yDmN6i6VYpfRViVw2/tTetEuj1PvuCnaHpMMElep2jGc6BPsamNFzd3w
	 +TJbGOjqBgW+y83Iay6Ht5lkYWjuyOPSC3y69G5qvXnyEdu+fteFAotjdMnnN7vxAz
	 N4Wr+XFsj9LIQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkMh32YyzSPm;
	Thu, 19 Nov 2026 11:25:04 -0500 (EST)
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
Subject: [RESEND PATCH v4 15/17] sched/debug: Show the deadline bandwidth of each runqueue
Date: Thu, 19 Nov 2026 11:24:55 -0500
Message-Id: <804f19feedc793d7cb668337f998cdaec2857cbc.1795105408.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795105408.git.mathieu.desnoyers@efficios.com>
References: <cover.1795105408.git.mathieu.desnoyers@efficios.com>
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

For each CPU, sched_debug prints the deadline bandwidth of its root
domain. It does not print the two sums of its runqueue. this_bw is the
bandwidth of the deadline tasks assigned to the CPU. running_bw is the
part of it that belongs to active tasks.

GRUB reclaiming depends on both sums. grub_reclaim() takes this_bw -
running_bw as the inactive bandwidth of the CPU. The more inactive
bandwidth, the slower a reclaiming task uses up its runtime.

The kernel warns when a sum wraps around, and when running_bw exceeds
this_bw. Bandwidth left behind in this_bw triggers no warning.

Print both sums. The deadline_bw_test selftest added later in this
series reads this_bw in its params_waking case. It checks that this_bw
is back to its first value once the tasks of the case are gone.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ddb382df454b..2c373adf3196 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1175,6 +1175,8 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
 
 	PU(dl_nr_running);
+	PU(running_bw);
+	PU(this_bw);
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
-- 
2.47.3

