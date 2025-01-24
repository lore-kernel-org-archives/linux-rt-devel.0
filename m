Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C02248BA
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745197; cv=none; b=WYOxB33uSsURMQGfJv0Tnwih5w9hSZPn+aAQOJuL2YX4NFHmyOjsLDM810DNxksU6qPtRRWiOxupMoK9lYeyi1olkBQikPZ7tTRj4k1T+ssM3LI/TMIpuiudRKS1yLfgKi3/s5X+WkU/mNymXMojALHEYvXj78/cGvY9dPxBJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745197; c=relaxed/simple;
	bh=V+Qc7YnTCB8I1IcyG/JPsW2HofuqPfklRLXHAg2HwwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJSFE+K+H9cZWCtyXETq/0vzggkhQ/kSDpBn7+43X4+duK1LwFNX2NU/Cnwg7gIjSesbXDLDo2rx7YxJCq9vs4KYCUhSi3eOLr8rQB4uQVd8aVjL/eF7iwVd+IQSjDdkhJdbQa8NPEPbydxTW8e/ET86S9JAYra1u+Um5tZkvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTBYbkYQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTBYbkYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737745194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ct8u+nGekdLNK69naunLwCvptNtjR00Iwpr/JLIZh0=;
	b=FTBYbkYQtfVAXu55oz5JDT4RdUyvF3oNV2P7Y19Xh6Acr+JHNVwx6iLaoxhvy4lJjg4RMH
	1Baj7pzdhtuEkCZ02+jCxlBW83gaVp/yjTSlgcrBRStSG5ntrUs2PcHhYym5pJVXPEYROA
	n+oRzLakp/06DkCfrlmfMtoqmepjukQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-RtjmLl_mMnWCIts0MNPLOg-1; Fri,
 24 Jan 2025 13:59:51 -0500
X-MC-Unique: RtjmLl_mMnWCIts0MNPLOg-1
X-Mimecast-MFC-AGG-ID: RtjmLl_mMnWCIts0MNPLOg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1797B19560BB;
	Fri, 24 Jan 2025 18:59:48 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0773180034C;
	Fri, 24 Jan 2025 18:59:45 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] clocksource: Defer preempt_disable() after clocksource_verify_choose_cpus()
Date: Fri, 24 Jan 2025 13:59:23 -0500
Message-ID: <20250124185923.3610964-2-longman@redhat.com>
In-Reply-To: <20250124185923.3610964-1-longman@redhat.com>
References: <20250124185923.3610964-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The following bug report happened in a PREEMPT_RT kernel.

[   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
[   30.962673] preempt_count: 1, expected: 0
[   30.962676] RCU nest depth: 0, expected: 0
[   30.962680] 3 locks held by kwatchdog/2012:
[   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
[   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
[   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
[   30.977827] Preemption disabled at:
[   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
[   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
[   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
[   30.982846] Call Trace:
[   30.982850]  <TASK>
[   30.983821]  dump_stack_lvl+0x57/0x81
[   30.983821]  __might_resched.cold+0xf4/0x12f
[   30.983824]  rt_spin_lock+0x4c/0x100
[   30.988833]  get_random_u32+0x4f/0x110
[   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
[   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
[   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
[   30.993898]  clocksource_watchdog_kthread+0x18/0x50
[   30.993898]  kthread+0x114/0x140
[   30.993898]  ret_from_fork+0x2c/0x50
[   31.002864]  </TASK>

It is due to the fact that get_random_u32() is called in
clocksource_verify_choose_cpus() with preemption disabled.
If crng_ready() is true by the time get_random_u32() is called, The
batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
it is a rtmutex and we can't acquire it with preemption disabled.

To avoid this problem, we can't call get_random_u32() with preemption
disabled. However, smp_processor_id() has to be called with preemption
disabled though and we have to exclude the current CPU from the
cpus_chosen list to be tested.

Extract current CPU removal code out from
clocksource_verify_choose_cpus() and defer the preempt_disable()
call to after clocksource_verify_choose_cpus() and before
current CPU removal. Also use raw_smp_processor_id() in
clocksource_verify_choose_cpus().

Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 77d9566d3aa6..8ffec49971ac 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -313,7 +313,6 @@ static void clocksource_verify_choose_cpus(void)
 	if (n < 0) {
 		/* Check all of the CPUs. */
 		cpumask_copy(&cpus_chosen, cpu_online_mask);
-		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
 		return;
 	}
 
@@ -322,9 +321,13 @@ static void clocksource_verify_choose_cpus(void)
 	if (n == 0 || num_online_cpus() <= 1)
 		return;
 
-	/* Make sure to select at least one CPU other than the current CPU. */
+	/*
+	 * Make sure to select at least one CPU other than the current CPU.
+	 * raw_smp_processor_id() is used opportunistically here as
+	 * preemption isn't disabled.
+	 */
 	cpu = cpumask_first(cpu_online_mask);
-	if (cpu == smp_processor_id())
+	if (cpu == raw_smp_processor_id())
 		cpu = cpumask_next(cpu, cpu_online_mask);
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
 		return;
@@ -349,9 +352,6 @@ static void clocksource_verify_choose_cpus(void)
 		if (!WARN_ON_ONCE(cpu >= nr_cpu_ids))
 			cpumask_set_cpu(cpu, &cpus_chosen);
 	}
-
-	/* Don't verify ourselves. */
-	cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
 }
 
 static void clocksource_verify_one_cpu(void *csin)
@@ -373,15 +373,18 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
 	cpus_read_lock();
-	preempt_disable();
 	clocksource_verify_choose_cpus();
+	preempt_disable();
+
+	/* Don't verify ourselves. */
+	testcpu = smp_processor_id();
+	cpumask_clear_cpu(testcpu, &cpus_chosen);
 	if (cpumask_empty(&cpus_chosen)) {
 		preempt_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
 	}
-	testcpu = smp_processor_id();
 	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
 		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
 	for_each_cpu(cpu, &cpus_chosen) {
-- 
2.47.1

