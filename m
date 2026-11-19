Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096188;
	b=N05B3P/uP4jhLg9c6KlSada1p2k2hAN3TQApLZVGggTfF2vD7c9gHu60OZkSNkB+AewC
	 GxzQvZsj6KFumSessedq7ddV22RWtJYsqqSSGXLzfu4g6/unMJfQsg/2j2EvqjwMaLu1e
	 SHpF0V0gcBlt1uUAclb9gvqoKlEEajUiNygkqbXri3tK0aqZBvWqHN10uuVSke05tnqPq
	 PJ8WcfjVaZfYyOeHv8XzM8tuWbpqJi6im2ZUjcGMNJ06BfwQokK5DXvqTxZlUl15c25FB
	 u2zDruwkGUUYQT9X7iWSZ3RxDJgnf4GCAuNqvjFlyx/1zbYRdRQo+7XhvYd4Csq4fNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096188;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6c2WfmmuO5OP5xCe2CrO1/Z/FsV4bpBjjt1tFRNTMew=;
	b=NAFKHZb8znIH7DtbbrNoVRvdytphZt+KaPtXazG6RUrp6Tybb8n/4UXfKVNAckvZVFy3
	 luLuuL2Zc16nfvIUNIHvrv4+96qY9raeEa9hrRsB5d9fjRcwp4akDiGRSnTfYqpj715DA
	 mQ1aKh7toQNPO8V8oftiY4XwvDrrOg6ptaq59JwTXy87LArOjzVhzHasiu2W762TBSCEX
	 JznMtw+UuT88hwmEoyynghM7KKo8XKLRGT3SDJzeBXimR6bb5NBNrc34EozCTI4+9T/Ii
	 Iz6PFP2UOy8Ij0KyTPM+bX0G7fxgnT3DBEUx4FovgtcgPNXHhqNPj4m/kiI98dSvhsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=nbAjXoZt;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0760A6F44
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E0760A6F44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=nbAjXoZt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795096186;
	bh=6c2WfmmuO5OP5xCe2CrO1/Z/FsV4bpBjjt1tFRNTMew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbAjXoZtX42PeowIIhmpcBkDF8U15tOnggCrszKcifuwlLJnYdgew2IoXBY1Hbszc
	 dBzJ46njTAslmkOEBbESkeHP9cqP3jm89C7X6KHiKDiAg/I3I/YcUH23B6SwnQOn8A
	 KJFQOX0SXBojrzgah9ihf9gCLfOYgTnDS3WNrsCbAeXch+wPM+xcTncGbnVY3iEo7O
	 k1DxK/YoqVBdR/HX8+xaEEU6oxjO5bFTomm0J7cTJvOIwSXY6kTkQetbLNgjp8NvdC
	 VGeurA8w3i3JNYdPT+rK/5QNebwmt/ljB+KxA0p86HqVmjrF5ubSTvW4PEyUf8pGtc
	 xxd1eabf6SwtA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVfwV2Xt0zSS4;
	Thu, 19 Nov 2026 08:49:46 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v3 15/17] sched/debug: Show the deadline bandwidth of each runqueue
Date: Thu, 19 Nov 2026 08:49:38 -0500
Message-Id: <4cf619e4c29a370891bb62a0f1fc17e10b0fc943.1795092090.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
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

