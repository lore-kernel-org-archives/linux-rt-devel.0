Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29741BA83
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860516; cv=none; b=OTWaMohpVL6z4i90N0csCaF0Esb4hLoDILz5Xh3VwNOBIIq/3EL3+CkJrvjUBCFmPr1WULfv1U4fvfeva0H59RCTLiT90tEic/Y8V8hWcOhIrfH23BHka75Wzt5GGwqQyTw0bMPDt7QK6ea1foPfE5tqqT0Xt5VvI+VkiHPcbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860516; c=relaxed/simple;
	bh=SkndvVcClBLGG6kNriPFNu+EsYdwFbaRIq6vpvFgXdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUmXbbWuTfebpf+T9iiiWwvyupUjHRAlkq3Soi8+dMvYSaz+tRr358SpAoF+dcFzMxhX6WHFBzOlGuvHr+NO0Y2NnPYVOLsAA0SvmUGBfXaBtugr+jTW2Zk7fiETj36KoDFH3CaTSzj366XQwP6uIzAULQxUJPEUIFR2pmIN2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=aRnAe1k8; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="aRnAe1k8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791860506; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v4/APHhHCJN6Oe2GAIYuPhZh2zCS6zZBYZwHGHGmZZs=;
	b=aRnAe1k8DMGLV/eIJV+3f7IDTHsw8PW2UC3NCS9JnxP73kXsVz1Skc+LO73fUqNtyqKy192gfPjN9fNtVEvfq4QnVki9RvkLIDrXajYT1dsFXaqOOlITtKuMQ3fE7ve1jZMSQY+uWBgbUG3HlE0oBoBOPvDgGXYLM89+qSCU2IA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0758048|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.15641-0.00146527-0.842125;FP=12607255534717618390|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=wangqk1@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jawVVu6_1791860504;
Received: from DESKTOP-EL1SUEF.xiaopeng.local(mailfrom:wangqk1@xiaopeng.com fp:SMTPD_---.jawVVu6_1791860504 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 11:01:44 +0800
From: wangqk1 <wangqk1@xiaopeng.com>
To: linux-kernel@vger.kernel.org
Cc: xiedl3@xiaopeng.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev
Subject: [RFC 1/1] sched/rt: Avoid RTO push to stopped CPUs during shutdown
Date: Tue, 13 Oct 2026 11:01:40 +0800
Message-ID: <20261013030140.682182-2-wangqk1@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013030140.682182-1-wangqk1@xiaopeng.com>
References: <20261013030140.682182-1-wangqk1@xiaopeng.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During system poweroff, machine_power_off() invokes smp_send_stop(). A
CPU receiving IPI_CPU_STOP parks without running the CPU hotplug teardown.
Its RT overload state can therefore retain a stale rto_mask bit.

A CPU still executing the RTO irq_work iterator can select that stale bit
and queue work to the stopped CPU.

Observed call trace:
  irq_work_queue_on()
  rto_push_irq_work_func()
  irq_work_single()
  __flush_smp_call_function_queue()
  generic_smp_call_function_single_interrupt()
  ipi_handler()

Stop RTO forwarding after terminal system states begin and skip rto_mask
candidates that are already offline.

This is a workaround, not a complete synchronization protocol. The
cpu_online() test is not atomic with irq_work_queue_on(), and panic or
crash-kexec paths do not set a terminal system_state before stopping CPUs.

Signed-off-by: wangqk1 <wangqk1@xiaopeng.com>
---
 kernel/sched/rt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 85303add726d..716ac30c5afb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2084,6 +2084,14 @@ static void push_rt_tasks(struct rq *rq)
 
 #ifdef HAVE_RT_PUSH_IPI
 
+static inline bool rto_push_allowed(void)
+{
+	enum system_states state = READ_ONCE(system_state);
+
+	return state != SYSTEM_HALT && state != SYSTEM_POWER_OFF &&
+	       state != SYSTEM_RESTART;
+}
+
 /*
  * When a high priority task schedules out from a CPU and a lower priority
  * task is scheduled in, a check is made to see if there's any RT tasks
@@ -2131,6 +2139,11 @@ static int rto_next_cpu(struct root_domain *rd)
 	int next;
 	int cpu;
 
+	if (unlikely(!rto_push_allowed())) {
+		rd->rto_cpu = -1;
+		return -1;
+	}
+
 	/*
 	 * When starting the IPI RT pushing, the rto_cpu is set to -1,
 	 * rt_next_cpu() will simply return the first CPU found in
@@ -2155,8 +2168,13 @@ static int rto_next_cpu(struct root_domain *rd)
 		if (cpu == this_cpu)
 			continue;
 
-		if (cpu < nr_cpu_ids)
+		if (cpu < nr_cpu_ids) {
+			/* smp_send_stop() does not clear stale rto_mask bits. */
+			if (!cpu_online(cpu))
+				continue;
+
 			return cpu;
+		}
 
 		rd->rto_cpu = -1;
 
-- 
2.43.0

