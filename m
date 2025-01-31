Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812791F12E7
	for <linux-rt-devel@lists.linux.dev>; Fri, 31 Jan 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738344832; cv=none; b=mOpaGfxj9HKX2vnTpe3nzGBIe/6JBA49LGA8tl0Ff6/gSClhu/itcmkE7/PQIiNmQFbTIuIcBaaTUqGXj0yYmwQMPoe1PUX/QDlqxHqMLH0GBva0s9u5QEzBMrrfY+Z1k6gy6icaKWvjEewyR/fTw2sxGAr2+OkCSQl7Gh7PhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738344832; c=relaxed/simple;
	bh=EcrfTjo6O9M92qG+uVJobyUj4TzCoeItH05F87bcC5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETXndEl0JYBFwXfe4uicIdiHYrKPd84TSEOamJ3hNpF/gLx4Ni3QziT/Fvvzstuo/Yzx3q/0uchBWytW8y8bdn9ihuHHUrtbAa98EmDFZG3S3Fmy05wE5Sm47Hr5Tuw70ZMGdVGd+Rjz8gJkrHyo1B8ufajdpe46jzdkY+HB5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4daX29y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4daX29y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738344829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sh7rZo29LbcUqiWG3szHfB7+fwxZgId2aXRpEeI0+wg=;
	b=c4daX29yX4MjSQx9I0fkhpKX5ABhNSvZemW1LDS1GToVb0XfAH7/d2lZAJ4+WbqQrzBcV5
	MjqkUF9NfbmbAY67Uoiuf7hN8z6qa0+6Sb4mjSgEYTOnETCyxMWRydyxkNadrpuR91u97A
	/PBYWIYvi7JvdV3zEOfKJlQOzwW7uR0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Q-Znd0zmO9yJqjjJJHuExQ-1; Fri,
 31 Jan 2025 12:33:44 -0500
X-MC-Unique: Q-Znd0zmO9yJqjjJJHuExQ-1
X-Mimecast-MFC-AGG-ID: Q-Znd0zmO9yJqjjJJHuExQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E5D31955DE0;
	Fri, 31 Jan 2025 17:33:42 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9B191955F3B;
	Fri, 31 Jan 2025 17:33:39 +0000 (UTC)
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
Subject: [PATCH v4 2/2] clocksource: Use migrate_disable() to avoid calling get_random_u32() in atomic context
Date: Fri, 31 Jan 2025 12:33:23 -0500
Message-ID: <20250131173323.891943-2-longman@redhat.com>
In-Reply-To: <20250131173323.891943-1-longman@redhat.com>
References: <20250131173323.891943-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The following bug report happened with a PREEMPT_RT kernel.

[   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
[   30.962673] preempt_count: 1, expected: 0
[   30.962676] RCU nest depth: 0, expected: 0

It is due to the fact that clocksource_verify_choose_cpus() is invoked
with preemption disabled.  This function invokes get_random_u32()
to obtain random numbers for choosing CPUs.  The batched_entropy_32
local lock and/or the base_crng.lock spinlock in driver/char/random.c
will be acquired during the call. In PREEMPT_RT kernel, they are both
sleeping locks and so cannot be acquired in atomic context.

Fix this problem by using migrate_disable() to allow
smp_processor_id() to be reliably used without introducing atomic
context. The preempt_disable() function is then called after
clocksource_verify_choose_cpus() but before the clocksource measurement
is being run to avoid introducing unexpected latency.

Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 77d9566d3aa6..2a7802ec480c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -373,10 +373,10 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
 	cpus_read_lock();
-	preempt_disable();
+	migrate_disable();
 	clocksource_verify_choose_cpus();
 	if (cpumask_empty(&cpus_chosen)) {
-		preempt_enable();
+		migrate_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
@@ -384,6 +384,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	testcpu = smp_processor_id();
 	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
 		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	preempt_disable();
 	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;
@@ -403,6 +404,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_min = cs_nsec;
 	}
 	preempt_enable();
+	migrate_enable();
 	cpus_read_unlock();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
-- 
2.48.1

