Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65A242D89
	for <linux-rt-devel@lists.linux.dev>; Sat,  9 Aug 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761273; cv=none; b=d5Mi7So3Q3u2NKiLp/Xtpvh7bQ1PrJzBFkeHWW4zQ1uLO+cdZfUvjH8lz3GRDXRIbAYdEXK28Arht2TbDler2AKHl/rE0BY+WtPQfCqThfxA22omzBD0zN486C0TV9twiks54IL1h363IkECQds+f6k8WlXUtTkFj/sbhwsbCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761273; c=relaxed/simple;
	bh=yEgpWM9alLUuN7wZwmttedF5P1rg710YOjB98POZGbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ah+wm0wgRLoHO9P50cHBUXlzqkzU1WTjFmyBPFFUwhgwxRlId+n+w83iiNfrK0/pIInQwnHk+PKbFIogig68i47CUX99raFtmTJBLnAosoR1rA9lSE6rwDt4n//NVkKbbdO0qsCX0q9iSIoY2km8ztoXj0DfLG9wrQTQIHivJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n26hh+VH; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n26hh+VH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yX
	y9iTU1zIv1DoZeuTR4acBDv8VeQCTLTXLCgjA+LG8=; b=n26hh+VHKM+NUMhTn0
	g1JSthHFf5P1DIKjgq2HcCdBIzmrTVMVsFEf3FZiYyqOyI04OZTqdM9Prg7tu6tb
	5aOkv0+Si2gBPNj5aCpVAdvC8Sc7DJzVxcJ+wsNvIKdB1yWuE64z1cx8Mf9v62H1
	gMqyuK0G/yMkTA/TmzEq/Za54=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3kqf1h5dorc5FAw--.44224S2;
	Sun, 10 Aug 2025 01:40:06 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] sched/fair: Make the BW replenish timer expire in hardirq context for PREEMPT_RT
Date: Sun, 10 Aug 2025 01:39:45 +0800
Message-Id: <20250809173945.1953141-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3kqf1h5dorc5FAw--.44224S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWkWw45ArW5uF1kGF1xZrb_yoWrury8pF
	Wjkry5tr1UJr10q3WkCwn7WFyru397Jr47A3Z7G3ySyw13Cry8tF1Sgr1YgFZ0krZa9r1S
	vF1Fvry3Zr90yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zioGQ3UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwqkCmiXWhlEMwABsp

Valentin Schneider has made changes in 2023 to move the callback logic of
the BW replenish timer into the hardirq context in the PREEMPT_RT system.
Given that the PREEMPT_RT code has already been merged into the mainline
and considering the serious impact of this issue, I believe it is
essential to incorporate this change into the mainline to prevent others
using the PREEMPT_RT system from encountering this frustrating problem.
Our project has also encountered the same issue on the Linux 6.1.134
RT-Linux kernel, and I have written a reproducible program that almost
100% triggers the panic caused by this problem on our system.
The reproducible program is inspired by previous discussions related to
the cgroup issue, which contained the following description:
    Consider the following scenario under PREEMPT_RT:
    o A CFS task p0 gets throttled while holding read_lock(&lock)
    o A task p1 blocks on write_lock(&lock), making further readers enter the
      slowpath
    o A ktimers or ksoftirqd task blocks on read_lock(&lock)
    If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued on
    the same CPU as one where ktimers/ksoftirqd is blocked on read_lock(&lock),
    this creates a circular dependency.
My reproducible program also follows the logic described above. The detailed
implementation of the 100% reproducible program runs on a Linux 6.1.134
RT-Linux system with only six CPUs.
I wrote a kernel module named testcgroupbug.ko, which creates a proc node that
responds to an ioctl command. Depending on the mode parameter passed, it
performs different operations. There are two modes: read mode and write mode.
In read mode, it executes read_lock and then enters a loop, waiting for a
write-mode task to exist before executing a dead loop that lasts for 0.25
seconds, registering a pinned hrtimer in HRTIMER_MODE_ABS_PINNED mode,
and finally executing read_unlock once the specified timeout expires.
In write mode, it executes write_lock and waits for the specified timeout to
expire before executing write_unlock.
The script that runs the program is structured as follows (the main idea is
to keep all CPUs busy except CPU 1, inducing the system to choose CPU 1 for
executing the related cgroup period timer operations. Thus, when the
read-mode task enters the kernel via ioctl, the creation of the soft-mode
pinned hrtimer also occurs on CPU 1, thereby forming the aforementioned
circular dependency):
taskset -c 0 ./deadloop &
taskset -c 2 ./deadloop &
taskset -c 3 ./deadloop &
taskset -c 4 ./deadloop &
taskset -c 5 ./deadloop &
sleep 3
mkdir /sys/fs/cgroup/test
echo "500000 1000000" > /sys/fs/cgroup/test/cpu.max
sleep 1
taskset -c 1 ./rwlock_read 5 &
pid=$!
echo $pid > /sys/fs/cgroup/test/cgroup.procs
chrt -f 60 ./rwlock_write 3 &
In the script above, rwlock_read is the read-mode function executed in the
kernel module, where 5 indicates the timeout period of 5 seconds. The
rwlock_write function represents the write-mode function executed in the
kernel module, where 3 indicates the timeout period of 3 seconds.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a0593..54c998661 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6456,8 +6456,13 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *paren
 	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
+#ifdef CONFIG_PREEMPT_RT
+	hrtimer_setup(&cfs_b->period_timer, sched_cfs_period_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_HARD);
+#else
 	hrtimer_setup(&cfs_b->period_timer, sched_cfs_period_timer, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_ABS_PINNED);
+#endif
 
 	/* Add a random offset so that timers interleave */
 	hrtimer_set_expires(&cfs_b->period_timer,
@@ -6483,7 +6488,11 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	cfs_b->period_active = 1;
 	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+#ifdef CONFIG_PREEMPT_RT
+	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED_HARD);
+#else
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
+#endif
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
-- 
2.34.1

