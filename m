Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F551E25FE
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jan 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738190429; cv=none; b=SyWWL6hPstjd1PixjjXuMpepqaeGeoGv3+UKvfNElpBI19t8IKHSzwFczmeKxqKVf85e63kYWtSXMttXcVVS8WK6MABBQKI4kBETvxMv8tQnbGG6jj+KuSRI2M6q3098Jd8UMjPc+IiMqYSUAEI9RL+Pq1cFudDdNIxc0Mvr/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738190429; c=relaxed/simple;
	bh=M0n5hsxEGBIHAPMTtB8uz8dBIRCZLdmTK1sUi6haSOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqTi2lx+y0GXSRJshgOKOWawP3pgZ1FndGQqq1NxBn95/XGwSxEDXQlPeS/MTAskNXE5vXYWNaCu6yIAz8JmAUb3tUou/cBFfhiNLKQnei1K2U2LYBvKmD+pOXldZfGhemdNZbvj/hJQjJo4QW9l9WAy4p2l4H8ypBh4hAc1Sqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRsVaGWx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRsVaGWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738190427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKxImgEo+uYTNeeJc5s+v8Bn7hVMZT0zwqE6/m/ojLU=;
	b=LRsVaGWxKVe3GR1dyFoR9t2iz/neN3n6P8IY8Xb9nWjbvRmWtKlPT57O//XxYR/M3yQnxd
	w1ZeF9hic+vMugUydzzlE3NKhIUd7ax7PG6++LAgy76dTjNP/z2iScYI8xW54X0NWQPDHz
	Fkq7Ut+uF+JkHhwD59LCiLfuLL2jQbs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-owF4nglIMk6hd6dZDCrhGg-1; Wed,
 29 Jan 2025 17:40:23 -0500
X-MC-Unique: owF4nglIMk6hd6dZDCrhGg-1
X-Mimecast-MFC-AGG-ID: owF4nglIMk6hd6dZDCrhGg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 667E81801F1E;
	Wed, 29 Jan 2025 22:40:21 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F25971800267;
	Wed, 29 Jan 2025 22:40:18 +0000 (UTC)
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
Subject: [PATCH v3 2/2] clocksource: Use get_random_bytes() in clocksource_verify_choose_cpus()
Date: Wed, 29 Jan 2025 17:40:01 -0500
Message-ID: <20250129224001.430506-2-longman@redhat.com>
In-Reply-To: <20250129224001.430506-1-longman@redhat.com>
References: <20250129224001.430506-1-longman@redhat.com>
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
clocksource_verify_choose_cpus() with preemption disabled.  The
batched_entropy_32 local lock and/or the base_crng.lock spinlock will
be acquired. In PREEMPT_RT kernel, they are rtmutexes and the above
warning will be printed if the fast path fails because of contention.

Fix this problem by moving the clocksource_verify_choose_cpus() call
before preempt_disable() while moving the part that needs preemption to
be disabled out into a new clocksource_verify_fixup_cpus() helper that
is called after preempt_disable(). In that way, the get_random_u32()
function will now be called with preemption enabled.

Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 42 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 77d9566d3aa6..08d6ac3a795f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -313,23 +313,14 @@ static void clocksource_verify_choose_cpus(void)
 	if (n < 0) {
 		/* Check all of the CPUs. */
 		cpumask_copy(&cpus_chosen, cpu_online_mask);
-		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
 		return;
 	}
 
 	/* If no checking desired, or no other CPU to check, leave. */
 	cpumask_clear(&cpus_chosen);
-	if (n == 0 || num_online_cpus() <= 1)
+	if (n <= 1 || num_online_cpus() <= 1)
 		return;
 
-	/* Make sure to select at least one CPU other than the current CPU. */
-	cpu = cpumask_first(cpu_online_mask);
-	if (cpu == smp_processor_id())
-		cpu = cpumask_next(cpu, cpu_online_mask);
-	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
-		return;
-	cpumask_set_cpu(cpu, &cpus_chosen);
-
 	/* Force a sane value for the boot parameter. */
 	if (n > nr_cpu_ids)
 		n = nr_cpu_ids;
@@ -341,7 +332,7 @@ static void clocksource_verify_choose_cpus(void)
 	 * situations where verify_n_cpus is greater than the number of
 	 * CPUs that are currently online.
 	 */
-	for (i = 1; i < n; i++) {
+	for (i = 0; i < n; i++) {
 		cpu = get_random_u32_below(nr_cpu_ids);
 		cpu = cpumask_next(cpu - 1, cpu_online_mask);
 		if (cpu >= nr_cpu_ids)
@@ -349,9 +340,32 @@ static void clocksource_verify_choose_cpus(void)
 		if (!WARN_ON_ONCE(cpu >= nr_cpu_ids))
 			cpumask_set_cpu(cpu, &cpus_chosen);
 	}
+}
+
+/*
+ * Return: true if success, false if not
+ */
+static bool clocksource_verify_fixup_cpus(void)
+{
+	int testcpu = smp_processor_id();
+	int cpu, n = verify_n_cpus;
+	bool ret;
 
 	/* Don't verify ourselves. */
-	cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
+	cpumask_clear_cpu(testcpu, &cpus_chosen);
+
+	ret = !cpumask_empty(&cpus_chosen);
+	if (!ret && (n != 0) && (num_online_cpus() > 1)) {
+		/* Make sure to select at least one CPU other than the current CPU. */
+		cpu = cpumask_first(cpu_online_mask);
+		if (cpu == testcpu)
+			cpu = cpumask_next(cpu, cpu_online_mask);
+		if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+			return false;
+		cpumask_set_cpu(cpu, &cpus_chosen);
+		return true;
+	}
+	return ret;
 }
 
 static void clocksource_verify_one_cpu(void *csin)
@@ -373,9 +387,9 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
 	cpus_read_lock();
-	preempt_disable();
 	clocksource_verify_choose_cpus();
-	if (cpumask_empty(&cpus_chosen)) {
+	preempt_disable();
+	if (!clocksource_verify_fixup_cpus()) {
 		preempt_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
-- 
2.48.1

