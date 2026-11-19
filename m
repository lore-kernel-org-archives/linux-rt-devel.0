Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115238;
	b=w7nDN+3Svmbh3b1coC0OPADwmlAe1Ays6wvZ7yrins2SUqCrYCL+T2gEOHNWMsTpfXHQ
	 WTVjFqN1VnaonjFXgo5o4M7nuK0J20JjuQVsULypmTO3W/oYEoKe/UIA8Yx1vMkgq7pp0
	 ytU1V/cK+/IUKMcNyPNHqsz1pQ3d1To4VEAbtSZP0d3Ydb6BoaEGb8EIJd9byaVsbOzRf
	 TH6aVWs7rQZ06EnwjqoQU752sFwv8rF1t4cykPw913rE0P1AvNCNgj/uoBhQb0754snXx
	 sxPg3nU4Zo/rBKsYbOtI5iJczGCDALpyrpOr9toIeTvh3zW1J8oLabGlNXTeIGYhKtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115238;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2GDIvsu7zv8+pf1iUkWvntMzShMjZhVgxoA9fdCxHRA=;
	b=42LVaTUTHqqGArXE/3gG8NqRB3sD+YiCyyWzLDG2mAbyUPh5KwDv2vEeXn1LPQZ2OUMG
	 i40hGO7DRD6LxzdJtV8Ca1ZFhu2N1RaTofbz7SSzWQ0NaB9dCzfzADbGT2uU8+ZiW51WP
	 /xUqkJDnJBTGZj/qa5sn/oFBakHCEImMAxaurGRd5F/qdkVrtnHAB+vCEH2gbGwWUUGmY
	 +Y62bxzIQw2aOfD8hOJvEzexoz7WQZ3SMtxq3S8sjfy+sYZMA5eckIdaBRTLIl39/xDhY
	 /MF08L/x22IT0S/BDmEtyivc0+Tb34fk4siISuuuP9oWSF8SG3vlZVt/ksLTe4mUAXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Nv6Cs47Q;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688AA606A335
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 19:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 688AA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Nv6Cs47Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795115237;
	bh=2GDIvsu7zv8+pf1iUkWvntMzShMjZhVgxoA9fdCxHRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nv6Cs47QSep2j34SDsMOP6ePrBJsHsgMVGgJcxQTWX5SO9HJC5naOfPP+Sfrt9Bu8
	 7OZ4mPlPu0ZhhIxczlsqeRfyr9Ys+RV7MP/o3cVZHkZ7gw/MI/QQooxMGAeKUZ3GZ5
	 1dY+kayohH5/hjq5oPKCuqz/9MXMSv04ddiirFb73kGvUi1Zn+4KDmjEiKRz1XmRh7
	 O4AcQ8kcyRUKPqyKNpBrnuke5M7dKve8PL7EmSIn/Bw7oIIvoRJFVXm+5po+MOGqlZ
	 v7dIfNvl+s21jmb1FMknWRnhopMlIbMbHtEGJxusKkHSm/qrNPXODt1E9uzW18plXB
	 oldrVfKcj62gA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVnys4cNczS4j;
	Thu, 19 Nov 2026 14:07:17 -0500 (EST)
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
Subject: [PATCH v5 04/17] sched/deadline: Do not divide by zero active CPUs of a root domain
Date: Thu, 19 Nov 2026 14:07:01 -0500
Message-Id: <46cf3d11435498c167e87c1e402c6ab2522f71ab.1795115075.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795115075.git.mathieu.desnoyers@efficios.com>
References: <cover.1795115075.git.mathieu.desnoyers@efficios.com>
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

__dl_sub() and __dl_add() divide by their cpus argument. Most callers
pass dl_bw_cpus(), the number of active CPUs of a root domain. That
number can be 0, and the division then traps.

Commit daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl
tasks") added extra_bw, the bandwidth that deadline tasks can reclaim
on a runqueue. A change of a root domain's total_bw is spread over the
extra_bw of its active CPUs.

During hotplug, a CPU sits in the default root domain, which can then
have no active CPU. This lasts from the rebuild in
sched_cpu_deactivate() to the offline, and from the online to
sched_cpu_activate(). A debugfs write to the runtime or period of its
fair or ext server divides there. A write of the current value passes
admission in the window. In 8-CPU VMs of v7.4-rc2, a loop of such writes
oopses at the first offline and online:

  Oops: divide error: 0000 [#1] SMP NOPTI
  RIP: 0010:dl_server_apply_params+0x335/0x380
  Call Trace:
   sched_server_write_common.isra.0+0x1c0/0x260
   full_proxy_write+0x58/0x90
   vfs_write+0xcb/0x550

By reading, two other paths would divide by zero:
- inactive_task_timer(), for a task that left SCHED_DEADLINE or died,
  if its CPU went offline.
- sched_setattr(SCHED_DEADLINE) on a task asleep on an offline CPU,
  with admission control off.

Fix this by changing total_bw alone when the root domain has no active
CPU.

With this patch, the reproducer survives 20 rounds with no warning.

Fixes: daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl tasks")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index dfae08625342..b614d5fc1a1a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -189,18 +189,25 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
 	}
 }
 
+/*
+ * Spread a change of total_bw over the extra_bw of the active CPUs of the
+ * root domain. @cpus is their number. With no active CPU, as can happen
+ * during CPU hotplug, change total_bw alone.
+ */
 static inline
 void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 {
 	dl_b->total_bw -= tsk_bw;
-	__dl_update(dl_b, (s32)tsk_bw / cpus);
+	if (cpus)
+		__dl_update(dl_b, (s32)tsk_bw / cpus);
 }
 
 static inline
 void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 {
 	dl_b->total_bw += tsk_bw;
-	__dl_update(dl_b, -((s32)tsk_bw / cpus));
+	if (cpus)
+		__dl_update(dl_b, -((s32)tsk_bw / cpus));
 }
 
 static inline bool
-- 
2.47.3

