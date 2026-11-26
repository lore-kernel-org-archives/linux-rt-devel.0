Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655345;
	b=0Mg+5WJyNMXg8EhMQDn8NOJ0hdOQjrKdcIsSgXlg/nCmYpQZet8+mYOrq5cmvWzg/d9x
	 /00a4A7NdQxCLcbSFiahYrlSer0sDiyPfjS+A3miEnmvlS1gbcgGTT/yfhdUyXz3tMzNJ
	 Rcre17/O0DjalzdUTY4S+geNANst6vSjcG5d850kpoM0O8l7V8QwXEL1TKhYrBpT/R6CT
	 Onpj9+nSHZDy0mUxyCL90uhrxYzcVPv8mz6tY/iS9wL5V9Bq2D1WNCJbwuby72vWBbUWV
	 ZBdS4s0wVvMuHrRqO4GnUfcAqfMSkSC6juL7DdN0kKfE71HrEe165uEFdIBRG8kyEFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655345;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uaKiK4hvBUH29lzPskFGU6hlfoEJOFubPVOJgzWUYxc=;
	b=UrCd5/cUnZgJ5oGdLWFO/egKJCXVfOQpAI3LqH9FOb9YYV/h33ZpqbuqJFuqk/18qg3U
	 b6Nv8gEPyNbyYCjYo7wAFbrqFSRaZvcTGRZ6oGUuSTlSI8q8r5aHv4Lb1sU5YvEcNznMj
	 eys0tgFxg8W+hxglxuYLVzUbY+nc7WdXYk/GbgqTwNs10NKUzlAOqTiEvQqbFhp61aeEK
	 lZK8dee/sKFc72/FJjD8xg0f571oTASMK9zgsx0NZw38RWIQIrrcUabRpoPJH47DV9eNO
	 RD+NYkvbDvB7U93vrkrigLhXG5uGOMoeIlnnO3NwjsIYPvcQJzWrNzO+KGBZIBH4QOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=LGF4Hpve;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8560A5BD7
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 01:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A8560A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=LGF4Hpve
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795655343;
	bh=uaKiK4hvBUH29lzPskFGU6hlfoEJOFubPVOJgzWUYxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGF4HpveB9576Mz1K5v4H9mQsGjAOZiCuXgdokpx7eLhVPLw45aNVwx9gUKv61YSo
	 /zN06OnlrzVAQHN73eKVv/e+sfuxdGMZM1fmUq5Ngal7oWFSjwogxkQiV3ELvlFrdD
	 e48NgkUERejM7gDhzENK4ag7w85IUVJAanwHo5d1sufxDOf2JYYlDWagnuPL5YSg3f
	 7c3gJVqHo5fy3iMiLF8CzOD5y08nPSIbyCvyZbEVElyrJ2nKUvT3xFBe67XfO6aFDk
	 j31Ca7e+F0SIzzPa18EJRcm4l+7s5yXXsL460KvkjFCUztnDLhb2Iv61k7mXFZrwT9
	 ipuiOP6czd8fA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jZdjV4yPXzWqj;
	Wed, 25 Nov 2026 20:09:02 -0500 (EST)
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
Subject: [PATCH v11 20/43] sched/deadline: Do not truncate a bandwidth to 32 bits in __dl_add/sub()
Date: Wed, 25 Nov 2026 20:08:19 -0500
Message-ID: <2bdd24ddcd59a009ffe973baea119c8d73d8e672.1795646914.git.mathieu.desnoyers@efficios.com>
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

__dl_add() and __dl_sub() spread a change of total_bw over the extra_bw
of the active CPUs of the root domain. Commit daec57983670
("sched/deadline: Reclaim bandwidth not used by dl tasks") added this,
for the bandwidth of one task. That is at most 1 << 20, the bandwidth
of one CPU.

But cpuset_can_attach() reserves the sum of the bandwidths of all the
deadline tasks it moves, with dl_bw_alloc(). __dl_add() and __dl_sub()
cast the bandwidth to s32 before the division. Past S32_MAX, more than
2048 CPUs of deadline bandwidth, the cast flips its sign. The extra_bw
of each CPU then moves the wrong way. GRUB lets reclaiming tasks run
more than the free bandwidth, or less. This was found by reading. It
needs a machine with more than 2048 CPUs, so no case tests it.

Fix this by dividing on 64 bits, with div_u64().

The Sashiko AI review of the first series found this.

Fixes: daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl tasks")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 347db90e9e9b..ffe381f9eb99 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -205,7 +205,7 @@ void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 {
 	dl_b->total_bw -= tsk_bw;
 	if (cpus)
-		__dl_update(dl_b, (s32)tsk_bw / cpus);
+		__dl_update(dl_b, div_u64(tsk_bw, cpus));
 }
 
 static inline
@@ -213,7 +213,7 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 {
 	dl_b->total_bw += tsk_bw;
 	if (cpus)
-		__dl_update(dl_b, -((s32)tsk_bw / cpus));
+		__dl_update(dl_b, -(s64)div_u64(tsk_bw, cpus));
 }
 
 static inline bool
-- 
2.47.3

