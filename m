Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805150;
	b=agwiNUjwmrsoPH0YHe8eXlkZIqvmWc7B27CSt7r5ilfw113i+JZWnSHYVxhKns7LEHLa
	 bqwsCMrewmUAUaHhex577+IprwmKyzIiKkZmGohYaidp/xQUKIAal+iungebkTO0Swdne
	 w4s8wtIhxNpdIwIULd324Ex3hY3Ny2eX02OLpfyxLE0a/kmTdaOmlJmEdtetABWp/QYw8
	 +0vruSsp86gBTrayYImfp31Ybk27Zud7YhGaFXOq1txrvd3zgjcl8W/YPrdrkiPSKdkdu
	 NYb47y5Y3Y59e/6VMpg9RROr+kG6LhfIJtVikIM4/cpet/XTOzh6KXtHoHRG+auHJHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805150;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C7/+RN7PDMRO7pHT+IVDUbw2xp4j3zIvBDh0XTZ3JLQ=;
	b=K0nrh+5rdRYPTZIA4c3Bu5O1ikvFdiGRnMydIwhvQNCAXWRIIn5r5fcD4d3nqRAU+0Yi
	 UdQYljzy4OKv9z+RWJLn5Z118ZXN6+49OHOOJgy/jBS5dB1eJeEnCDwDWE92VrFlnakuo
	 L521cfbMR6bAPuKTzv6xHFxsesx41wLabsunzjrApcd3ROJoP272ggS5f0/qtzjnFedNb
	 4tgr9dSN5gJSeQBQG8RJ4WD/SV/0o3v4+vbxmhGWCNnlaBgPyhzno4WfRQji9QZ2qV8n6
	 aUckWr70VP4V4tYfu3VmpqqiJ2EH3bvGdsC1WNL38aW0giHHp18qyVXwK96R9AP4YWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=UcKF0dUZ;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F89606D81C
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 15:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F89606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=UcKF0dUZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793805141;
	bh=C7/+RN7PDMRO7pHT+IVDUbw2xp4j3zIvBDh0XTZ3JLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcKF0dUZTTMhkaPPvq1sKTQxX6QYIkauaB3jFBKy0t4+qfdfMRR7VGl3QLxE40g0R
	 l7SaJoRUR2y5M2gW4lxuqpoTvNBTqGcNTEOQyaWwXk9xgP8oOi0H+IheOJiCqADVuu
	 PaQuRHAH6OvZaltL8zl/9qeqxOUV3ENV08/Q542WJcxN8WmdpqYlc2Q504xqVqQixP
	 /sngyDXOvHIvimC4BvMJ+A3/icGqIZgXIMNQrNnu9VTw4t7uWZxqAdMEMNBfAq+8Xe
	 pQJEjNCcn5mCiL1/4vPlUfizRAGlCJKdnk21IUF/U6TfBV5T9FBgY6QG1whB2MxCkG
	 hWvItJ8e+WgOA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKTSj41Z1zJqx;
	Wed, 04 Nov 2026 10:12:21 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Claudio Scordino <claudio@evidence.eu.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 11/12] sched/deadline: Rebuild the root domains' accounting without cpusets too
Date: Wed,  4 Nov 2026 10:10:32 -0500
Message-Id: <7ea39be6af23940c33a63002ea832838fe69bb9e.1793804635.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
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

A change of the root domains, which CPU hotplug and suspend and resume
make, clears their deadline bandwidth accounting and fills it back: the
servers of each CPU, and the bandwidth of the deadline tasks of each
cpuset. The walk that puts the tasks back lives in the cpuset code,
dl_rebuild_rd_accounting(), and is a stub without CONFIG_CPUSETS: such
a kernel loses the bandwidth of every deadline task at the first
hotplug, total_bw of the new root domain holding its servers alone.

The tasks are never told. Each still takes its bandwidth out of
total_bw once it leaves SCHED_DEADLINE, or dies: it underflows, and
admission afterwards refuses every deadline task of the root domain.

Walk the tasks instead of the cpusets, which is all there is without
them, and keep one declaration beside dl_clear_root_domains() for both.

In 8-CPU VMs built without CONFIG_CPUSETS, the hotplug_sleepers case of
the selftest added later in this series admits 9 tasks of 10ms every
100ms before taking a CPU offline and back, and 0 after, on v7.4-rc1 as
with the patches before this one; hotplug_departed and
hotplug_server_refused fail after it, and two more hotplug cases skip
for want of room. The five pass with this change, in 4 VMs, with no
warning.

Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/cpuset.h         |  5 -----
 include/linux/sched/deadline.h |  1 +
 kernel/sched/deadline.c        | 22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 914983387e95..608c3c5a9535 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -129,7 +129,6 @@ static inline int cpuset_do_page_mem_spread(void)
 
 extern bool current_cpuset_is_being_rebound(void);
 
-extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
@@ -273,10 +272,6 @@ static inline bool current_cpuset_is_being_rebound(void)
 	return false;
 }
 
-static inline void dl_rebuild_rd_accounting(void)
-{
-}
-
 static inline void rebuild_sched_domains(void)
 {
 	guard(cpus_read_lock)();
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index bdf39ac1d43d..e30b6ac2b050 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -33,6 +33,7 @@ struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
 extern void dl_clear_root_domains(void);
+extern void dl_rebuild_rd_accounting(void);
 /*
  * Return whether moving DL task @p to @new_mask requires moving DL
  * bandwidth accounting between root domains. This helper is specific to
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a8906cf96640..0ea902b9e5d0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3668,6 +3668,28 @@ void dl_clear_root_domain(struct root_domain *rd)
 		dl_server_add_bw(rd, i);
 }
 
+#ifndef CONFIG_CPUSETS
+/*
+ * Rebuild the root domains' accounting, where no cpuset holds the
+ * deadline tasks of each: they are found by walking them all, which
+ * dl_rebuild_rd_accounting() of the cpusets does per cpuset instead.
+ */
+void dl_rebuild_rd_accounting(void)
+{
+	struct task_struct *g, *p;
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&sched_domains_mutex);
+
+	dl_clear_root_domains();
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, p)
+		dl_add_task_root_domain(p);
+	read_unlock(&tasklist_lock);
+}
+#endif /* !CONFIG_CPUSETS */
+
 /*
  * Clear every root domain ahead of a rebuild of their accounting, which
  * dl_add_task_root_domain() then fills with the deadline tasks of the
-- 
2.47.3

