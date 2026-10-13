Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B04718D3
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860515; cv=none; b=dIuq07Oy83bQUtBOezV+WGw4ETS4hphZRLXy9DdMN7l0UsJxN28yEp8LGUBrAxrc4HB710iHiqIvC/2caS3FUe0HSOp6qO1ZvEqDCNxlpAh8k3Lx8ShReiUlVcsnlo/OU8RJ+VUceQH4n6VKvz1GNpEvS5P1D8LV0VXRVUmCkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860515; c=relaxed/simple;
	bh=y3X2y52qQUFYtz8qbhjWzekz++Vx/aWBGsDyRwCkEB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZx4Y6iCwN3SRX0/A5xO9+5UQ2gdFu3SQgJGtyQ2CoXTtQOIGFFo1EXoNUylHwQoqPezkUmRIKxFhEeWJUORi6rQxiX3Pya97CuOOGbBclXUWAZe/rOkYNB37TX/ahBlhC0pbTtEgLvxKVyCRFrsYW8iqjNi8pBb+M1rIZDg/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=n+Gs5o0d; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="n+Gs5o0d"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791860504; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dmOTVyrFxBhnQZJyYKzyFOOBPbYhj5TFcpWHl0mfoaU=;
	b=n+Gs5o0d6rfSeFINRzhDB/txn9+zWQKDTGQf89df/CM+4MocauMC+n0i+83HVbPIrW9S+t3gay6mNX+Bx+Mlm/8iP8sedsl353M/iRp3gWYmzMz+7obFt7XmLgpz/YAh7eOSVszeBQy8V9A+1vSwTK9T1cpdut8bbmhAKoE4pLo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08943662|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.405197-0.00420858-0.590595;FP=12590358247546546247|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=wangqk1@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jawVVt0_1791860503;
Received: from DESKTOP-EL1SUEF.xiaopeng.local(mailfrom:wangqk1@xiaopeng.com fp:SMTPD_---.jawVVt0_1791860503 cluster:ay29)
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
Subject: [RFC 0/1] sched/rt: Avoid RTO push to stopped CPUs during shutdown
Date: Tue, 13 Oct 2026 11:01:39 +0800
Message-ID: <20261013030140.682182-1-wangqk1@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I am sending this RFC to discuss an rto push irq_work submission to a
CPU that has already been stopped during system shutdown.

On an SMP PREEMPT_RT arm64 system, machine_power_off() eventually calls
smp_send_stop(). The IPI_CPU_STOP handler parks the target CPU directly
without running normal CPU hotplug teardown.

In particular, rq_offline_rt() is not reached, so an overloaded RT
runqueue can retain a stale rto_mask bit after its CPU is no longer online.
Another CPU can still run rto_push_irq_work_func() and select that entry.

The observed path is:

  irq_work_queue_on()
  rto_push_irq_work_func()
  irq_work_single()
  __flush_smp_call_function_queue()
  generic_smp_call_function_single_interrupt()
  ipi_handler()

Normal CPU hotplug clears RT overload state and flushes pending
call-function and irq_work callbacks before a CPU is parked.
smp_send_stop() intentionally bypasses that protocol because it is also
used by panic and crash paths.

The patch stops rto forwarding after terminal system states begin and
skips rto_mask entries that are already offline.

This is a workaround, not a complete synchronization solution. It does
not make cpu_online() and irq_work_queue_on() atomic, and it does not
cover panic or crash-kexec paths.

I would appreciate feedback on whether this consumer-side hardening is
acceptable, or whether rto push needs an explicit quiesce protocol before
smp_send_stop() stops secondary CPUs.

Testing:
  - Built kernel/sched/rt.o with x86_64 defconfig.
  - checkpatch.pl reports no errors or warnings.
  - Runtime reproduction against mainline has not yet been performed.

Thanks,
wangqk1

wangqk1 (1):
  sched/rt: Avoid RTO push to stopped CPUs during shutdown

 kernel/sched/rt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.43.0
