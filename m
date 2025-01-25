Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49020468C
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Jan 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737770110; cv=none; b=FfjixUkWgD/5zJ1PQ3ye/+vEswAMICnNre5Qcfw15KsDDUiqaEBgHaqFpeoP3KZ4v5vcBIj7z7mSDDrHRFYynK3Rvu8B54ZrgcK5elD3zOfLbSqK5/n0//CIM7Vf6YXnIDTESFfGgCHQ9rhLxPm6M12l/OtTNFYu0SG3C/dFdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737770110; c=relaxed/simple;
	bh=1SKBaYq6MrcXbMp5TSQ4b1mjUvW+9Fe5VKe3IHjht2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCpARFJZx5jklGFynlsp47X8GfN+BUzP9IsWoTnEmZV0ZXBD8SH40ilYk0ApRrXmKLmBeFGhYtKzOxkENCIhTrgiLa8Kmp0f3yzyGwSIl+LsPxPlslj40L0r6brduTr/DIE7V8AFJxW54HaxHCfAYFBw/M6WnP9gTTLjS1A7G2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXJv4/cT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXJv4/cT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737770107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfBI69kTG1U0a5VnaZ+DhqzZrCV3aR94+OU9hGCmaV0=;
	b=RXJv4/cTyYV+z+LvPughvRO5+AoRqZ4sfqOZ6lQMbDyqYs59c4yXoafMSISfu5uqKjjE82
	Z8KGk5g9OrusRLq1HxRfqVnafjb8zp4G4nnB80sSqFeGJ9tZBDDRwHABjKmCgOZr327bVw
	FPBaq3I7SCl6UsT6b57CWt8t0a264rU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-_d7_un-aOrywPzPwgKZfJw-1; Fri,
 24 Jan 2025 20:55:03 -0500
X-MC-Unique: _d7_un-aOrywPzPwgKZfJw-1
X-Mimecast-MFC-AGG-ID: _d7_un-aOrywPzPwgKZfJw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E52C19560AF;
	Sat, 25 Jan 2025 01:55:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3B681800348;
	Sat, 25 Jan 2025 01:54:59 +0000 (UTC)
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
Subject: [PATCH v2 2/2] clocksource: Use get_random_bytes() in clocksource_verify_choose_cpus()
Date: Fri, 24 Jan 2025 20:54:42 -0500
Message-ID: <20250125015442.3740588-2-longman@redhat.com>
In-Reply-To: <20250125015442.3740588-1-longman@redhat.com>
References: <20250125015442.3740588-1-longman@redhat.com>
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

Fix this problem by using the less random get_random_bytes() function
which will not take any lock. In fact, it has the same random-ness as
get_random_u32_below() when crng_ready() is false.

Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 77d9566d3aa6..659c4b79119c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -340,9 +340,13 @@ static void clocksource_verify_choose_cpus(void)
 	 * and no replacement CPU is selected.  This gracefully handles
 	 * situations where verify_n_cpus is greater than the number of
 	 * CPUs that are currently online.
+	 *
+	 * The get_random_bytes() is used here to avoid taking lock with
+	 * preemption disabled.
 	 */
 	for (i = 1; i < n; i++) {
-		cpu = get_random_u32_below(nr_cpu_ids);
+		get_random_bytes(&cpu, sizeof(cpu));
+		cpu %= nr_cpu_ids;
 		cpu = cpumask_next(cpu - 1, cpu_online_mask);
 		if (cpu >= nr_cpu_ids)
 			cpu = cpumask_first(cpu_online_mask);
-- 
2.47.1

