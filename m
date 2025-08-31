Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E702AD0C
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 Aug 2025 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756603716; cv=none; b=MiB92Xda4bAu+wF2JHLTpqlCFLrZho6sSouwWMymmueZrG4Yac6rYcNbp+swcINiW747wSkzvmAZvr4woJtzbDd/Rj8ksh3XgVMPKRS6vi6JncQ2OGv1kMHtFt6obmqV1k/GvsqkDZ9djP57O6Ul4IcmHbRMPTKojPJ/hzNYpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756603716; c=relaxed/simple;
	bh=KDJpfsP4YCTuqoD0AK6B2xe1GvRTYvgCJOP8C8dL5ZM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ap44fR8kaCCfmFdyfa91CfD8R3oDvajhjMGVWhMytJCfZAyVn6+L0mlYNcDElnNjidFHjyo8TwggqfKVaY8Rz9bnAJRCBFKD5KQGiboWYOjbdI+h70bUBLx4ub4fSts+U82Uukmg5GHDmhhD0s7Sbow6gGa0erTCEDWY8zJw5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24896af0650so6819615ad.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 30 Aug 2025 18:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756603713; x=1757208513;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isJ9YgsELTrLE7rgj+66ZSG6AsLLiBAnaMmUnZA80zY=;
        b=fm0TuzQX6fl2f2VOfVP4L2itbgajvW8Cy6F3s8msfFdC7iBIT4l0UGRbFhn6C9Ty/4
         vJn7xjcopdGQyZ4KOPbiTuXKKtjyxEB7O/Tc9Ey5cxOfv9XXGvzGU/ZLzP4fxBTcttHE
         7a8JJyREnqiOBpLH0M0TH6aA3zsT0Dmf0ypd1x4FiNGANejmBKj63YCHsUcCZX8jk49n
         2jIT5VuZ4Yr1yQu8tvkTxnea9TixzTPUXSkVGPwBU+s3pzZJOtHXXr23yXhNWB9YiRP2
         EQ1HW141FK3+b4sf0P3Ejf4XkxNcQxBtMaGo3Y5RDui6Iy8aLkEHwsO/6LEwX/5pXAkZ
         bSRw==
X-Forwarded-Encrypted: i=1; AJvYcCV8fH7PtpLpdiM+l98Fgzp6xarErtJBDhl4zuphDZOHImtscX0k51wQrLF1K0DVPAequlbFANf5GMQIbJKYoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo6TzL9zAJoybUhtyk2oIfLCFCN616CwgqFn/PUpOmU8AbWouk
	c86y0Gbro+BAep1f2WSN6NQ6ZRjbpHGlA83iGEBme2JCL0Dc+BOWIESt
X-Gm-Gg: ASbGncurG7dPhGUR0CWQOzv+a6hYscBbRWvddc84jSpyyaJcTTpLLwUEgAge795aMEy
	sRUpAWanijKq/okyoAECuMkcMkpmIhxDMDAaKryDwUknPhbu9PkM8tRb88SaFl2gYIKXUw2gt3Q
	Xx3EdgCSBU5CVqX9IX4IJh2horCwBH4m3iDvptf70yNUv7EhWHaq7gvBaF2Fu9lMS/3l3qifqXz
	dNrOuerjKNMf8V/qpV5TL1z4030XxcD0SSW0k39xdWkkWn4jMoz1p9ySRw1giW3QDxu0KrjyYVd
	QSfGrv6fDkMNFBq2kIB2mLtdFoawuMf/6V/KJhuhzvsRQU/KNTeQtXbx4p4AlQuFP/Aof++ULiA
	NBOqlln+2FNyomS/8Y9khAIwHr0r1AgNbBdh56+cCtc8Ffz7F46u5tjmFIyihbU14EsO5lAjEWh
	b0UcQPsgguD8DYWMRAiYxWOY6rjg4w
X-Google-Smtp-Source: AGHT+IEM/dtlb/OLbYvlIpN8TePT5zSVAl0O7/OiPFKvgTUksOuYDt2OSBd84y+Xx8kFubI42YX25g==
X-Received: by 2002:a17:90b:1b50:b0:321:75c1:ff04 with SMTP id 98e67ed59e1d1-327f5c090damr4750387a91.8.1756603713371;
        Sat, 30 Aug 2025 18:28:33 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e01b21dfsm3433438a91.2.2025.08.30.18.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 18:28:32 -0700 (PDT)
Message-ID: <f564f596-577e-4a66-a501-033c68765bf4@kzalloc.com>
Date: Sun, 31 Aug 2025 10:28:26 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>,
 Byungchul Park <byungchul@sk.com>,
 "max.byungchul.park@gmail.com" <max.byungchul.park@gmail.com>,
 vvghjk1234@gmail.com
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [BUG] mm/slub: Contention caused by kmem_cache_node->list_lock on
 PREEMPT_RT
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I've been analyzing a system critical contention observed on a PREEMPT_RT
enabled kernel (based on v6.17-rc3). The issue stems from internal lock
contention within the SLUB allocator, particularly under high memory
pressure scenarios such as massive RCU callback processing.

In PREEMPT_RT configurations, spinlock_t is implemented as a sleepable
RT-Mutex. The kmem_cache_node->list_lock in SLUB protects the node-level
partial slab lists and is a very hot lock, frequently accessed during the
memory freeing path.

When multiple CPUs contend heavily for this lock, the overhead associated
with RT-Mutexes (context switching, priority inheritance, sleeping/waking)
causes severe stagnation in the memory subsystem's progress.

I observed a scenario where a task performing memory compaction became
indefinitely stuck waiting for a folio lock. It appears the owner of the
folio lock was also stalled due to the contention on SLUB's list_lock,
resulting in a system-wide contention.

The task is stuck in migrate_pages_batch waiting for a folio lock during 
memory compaction:

 INFO: task hung in migrate_pages_batch
 INFO: task syz.7.2768:30677 blocked for more than 143 seconds.
       Not tainted 6.17.0-rc3-00269-g11e7861d680c-dirty #73
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:syz.7.2768      state:D stack:0     pid:30677 tgid:30673 ppid:20684  task_flags:0x400040 flags:0x00000011
 Call trace:
  __switch_to+0x2b4/0x474 arch/arm64/kernel/process.c:741 (T)
  context_switch kernel/sched/core.c:5357 [inline]
  __schedule+0x6c4/0xe2c kernel/sched/core.c:6961
  __schedule_loop kernel/sched/core.c:7043 [inline]
  schedule+0x50/0xf0 kernel/sched/core.c:7058
  io_schedule+0x38/0xa0 kernel/sched/core.c:7903
  folio_wait_bit_common+0x360/0x698 mm/filemap.c:1317
  __folio_lock+0x2c/0x3c mm/filemap.c:1675
  folio_lock include/linux/pagemap.h:1133 [inline]
  migrate_folio_unmap mm/migrate.c:1246 [inline]
  migrate_pages_batch+0x448/0x1a80 mm/migrate.c:1873
  migrate_pages_sync mm/migrate.c:2023 [inline]
  migrate_pages+0x101c/0x14f4 mm/migrate.c:2105
  compact_zone+0x1044/0x1ae8 mm/compaction.c:2647
  compact_node mm/compaction.c:2916 [inline]
  compact_nodes mm/compaction.c:2938 [inline]
  sysctl_compaction_handler+0x244/0x3f4 mm/compaction.c:2989
  proc_sys_call_handler+0x224/0x3fc fs/proc/proc_sysctl.c:600
  proc_sys_write+0x2c/0x3c fs/proc/proc_sysctl.c:626
  do_iter_readv_writev+0x314/0x3e0 fs/read_write.c:-1
  vfs_writev+0x194/0x470 fs/read_write.c:1057
  do_pwritev fs/read_write.c:1153 [inline]
  __do_sys_pwritev2 fs/read_write.c:1211 [inline]
  __se_sys_pwritev2 fs/read_write.c:1202 [inline]
  __arm64_sys_pwritev2+0xf0/0x194 fs/read_write.c:1202
  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
  invoke_syscall+0x64/0x168 arch/arm64/kernel/syscall.c:49
  el0_svc_common+0xb4/0x164 arch/arm64/kernel/syscall.c:132
  do_el0_svc+0x2c/0x3c arch/arm64/kernel/syscall.c:151
  el0_svc+0x40/0x144 arch/arm64/kernel/entry-common.c:879
  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
  el0t_64_sync+0x1b8/0x1bc arch/arm64/kernel/entry.S:596
 NMI backtrace for cpu 0
 CPU: 0 UID: 0 PID: 55 Comm: khungtaskd Kdump: loaded Not tainted 6.17.0-rc3-00269-g11e7861d680c-dirty #73 PREEMPT_{RT,(full)} 
 Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
 Call trace:
  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
  __dump_stack+0x30/0x40 lib/dump_stack.c:94
  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
  dump_stack+0x1c/0x3c lib/dump_stack.c:129
  nmi_cpu_backtrace+0x278/0x31c lib/nmi_backtrace.c:113
  nmi_trigger_cpumask_backtrace+0x134/0x2cc lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x30/0x40 arch/arm64/kernel/smp.c:936
  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
  watchdog+0x858/0x890 kernel/hung_task.c:491
  kthread+0x314/0x384 kernel/kthread.c:463
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
 Sending NMI from CPU 0 to CPUs 1-3:
 NMI backtrace for cpu 1
 CPU: 1 UID: 0 PID: 28 Comm: rcuc/1 Kdump: loaded Not tainted 6.17.0-rc3-00269-g11e7861d680c-dirty #73 PREEMPT_{RT,(full)} 
 Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
 pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
 pc : _raw_spin_unlock_irq+0x18/0x70 kernel/locking/spinlock.c:202
 lr : __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:158 [inline]
 lr : _raw_spin_unlock_irq+0x10/0x70 kernel/locking/spinlock.c:202
 sp : ffff800089f0fa40
 x29: ffff800089f0fa40 x28: ffff0000c0004640 x27: 0000000000000000
 x26: 0000000000000000 x25: 0000000000001000 x24: ffff8000855f169c
 x23: 0000000000000001 x22: ffff800089f0fa68 x21: ffff800089f0fb48
 x20: ffff0000c11e6440 x19: ffff0000c0004640 x18: 000000651c596d12
 x17: 0000000000000000 x16: 0000000000000008 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000000010 x12: ffff80008b0cfa68
 x11: 0000000000000008 x10: 00000000ffffffff x9 : ffffffffffffffff
 x8 : 0000000000000000 x7 : bbbbbbbbbbbbbbbb x6 : 392e39383520205b
 x5 : ffff8000806849f4 x4 : 0000000000000001 x3 : 0000000000000010
 x2 : ffff800089f0fa68 x1 : ffff0000c11e6440 x0 : ffff0000c0004640
 Call trace:
  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline] (P)
  _raw_spin_unlock_irq+0x18/0x70 kernel/locking/spinlock.c:202 (P)
  raw_spin_unlock_irq_wake include/linux/sched/wake_q.h:82 [inline]
  rtlock_slowlock_locked+0xcb0/0xe0c kernel/locking/rtmutex.c:1864
  rtlock_slowlock kernel/locking/rtmutex.c:1895 [inline]
  rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
  __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
  rt_spin_lock+0x6c/0xe0 kernel/locking/spinlock_rt.c:57
  spin_lock include/linux/spinlock_rt.h:44 [inline]
  free_to_partial_list+0x74/0x5bc mm/slub.c:4427
  __slab_free+0x208/0x254 mm/slub.c:4498
  do_slab_free mm/slub.c:4632 [inline]
  slab_free mm/slub.c:4681 [inline]
  kmem_cache_free+0x320/0x5f0 mm/slub.c:4782
  mem_pool_free mm/kmemleak.c:508 [inline]
  free_object_rcu+0x104/0x11c mm/kmemleak.c:536
  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
  rcu_core kernel/rcu/tree.c:2861 [inline]
  rcu_cpu_kthread+0x404/0xcd0 kernel/rcu/tree.c:2949
  smpboot_thread_fn+0x270/0x474 kernel/smpboot.c:160
  kthread+0x314/0x384 kernel/kthread.c:463
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
 NMI backtrace for cpu 3
 CPU: 3 UID: 0 PID: 44 Comm: rcuc/3 Kdump: loaded Not tainted 6.17.0-rc3-00269-g11e7861d680c-dirty #73 PREEMPT_{RT,(full)} 
 Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
 pstate: 03400005 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : finish_task_switch+0xb0/0x308 kernel/sched/core.c:5225
 lr : raw_spin_rq_unlock kernel/sched/core.c:680 [inline]
 lr : raw_spin_rq_unlock_irq kernel/sched/sched.h:1530 [inline]
 lr : finish_lock_switch kernel/sched/core.c:5105 [inline]
 lr : finish_task_switch+0xa8/0x308 kernel/sched/core.c:5223
 sp : ffff80008b0cf940
 x29: ffff80008b0cf950 x28: ffff0000c11fab28 x27: ffff800088169df0
 x26: ffff0000c11fa440 x25: ffff8000855e93b4 x24: ffff800088169df0
 x23: 0000000000001000 x22: 0000000000000000 x21: bcf48000855e8a30
 x20: ffff0000c11fa440 x19: ffff0000c1301440 x18: 00000062aca2a5d2
 x17: fffffffffffff63c x16: 0000000000200b20 x15: 0000000000135c81
 x14: ffff800088169df0 x13: 000000000132d6aa x12: 00000000001f4245
 x11: 0000000000000000 x10: 00000000ffffffff x9 : 0000000000000001
 x8 : 0000000100000001 x7 : bbbbbbbbbbbbbbbb x6 : ffff8000a954fd48
 x5 : 0000000000000001 x4 : 0000000000001000 x3 : ffff0000c11fa440
 x2 : 0000000000000001 x1 : ffff80008741f318 x0 : 0000000000000001
 Call trace:
  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
  raw_spin_rq_unlock_irq kernel/sched/sched.h:1531 [inline] (P)
  finish_lock_switch kernel/sched/core.c:5105 [inline] (P)
  finish_task_switch+0xb0/0x308 kernel/sched/core.c:5223 (P)
  context_switch kernel/sched/core.c:5360 [inline]
  __schedule+0x6c8/0xe2c kernel/sched/core.c:6961
  __schedule_loop kernel/sched/core.c:7043 [inline]
  schedule_rtlock+0x24/0x44 kernel/sched/core.c:7122
  rtlock_slowlock_locked+0xd20/0xe0c kernel/locking/rtmutex.c:1868
  rtlock_slowlock kernel/locking/rtmutex.c:1895 [inline]
  rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
  __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
  rt_spin_lock+0x6c/0xe0 kernel/locking/spinlock_rt.c:57
  spin_lock include/linux/spinlock_rt.h:44 [inline]
  free_to_partial_list+0x74/0x5bc mm/slub.c:4427
  __slab_free+0x208/0x254 mm/slub.c:4498
  do_slab_free mm/slub.c:4632 [inline]
  slab_free mm/slub.c:4681 [inline]
  kmem_cache_free+0x320/0x5f0 mm/slub.c:4782
  mem_pool_free mm/kmemleak.c:508 [inline]
  free_object_rcu+0x104/0x11c mm/kmemleak.c:536
  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
  rcu_core kernel/rcu/tree.c:2861 [inline]
  rcu_cpu_kthread+0x404/0xcd0 kernel/rcu/tree.c:2949
  smpboot_thread_fn+0x270/0x474 kernel/smpboot.c:160
  kthread+0x314/0x384 kernel/kthread.c:463
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
 NMI backtrace for cpu 2
 CPU: 2 UID: 0 PID: 36 Comm: rcuc/2 Kdump: loaded Not tainted 6.17.0-rc3-00269-g11e7861d680c-dirty #73 PREEMPT_{RT,(full)} 
 Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
 pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 pc : _raw_spin_unlock_irqrestore+0x2c/0x80 kernel/locking/spinlock.c:194
 lr : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
 lr : _raw_spin_unlock_irqrestore+0x18/0x80 kernel/locking/spinlock.c:194
 sp : ffff80008afafa80
 x29: ffff80008afafa80 x28: ffff0000c0004640 x27: 0000000000000000
 x26: ffff8000806849f4 x25: ffff8002cf620000 x24: ffff0000c11f0440
 x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000c11fad30
 x20: 0000000000000008 x19: 0000000000000000 x18: ffff80008565bf38
 x17: 0000000000000006 x16: 0000000000000010 x15: 0000000000000000
 x14: ffff800088169df0 x13: 0000000000000130 x12: 0000000000000110
 x11: 0000000000000000 x10: 00000000ffffffff x9 : ffffffffffffffff
 x8 : 00000000000000c0 x7 : bbbbbbbbbbbbbbbb x6 : 000000000000003f
 x5 : 0000000000000001 x4 : 000000895af9d556 x3 : 0000000000000004
 x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff0000c11fad30
 Call trace:
  __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline] (P)
  _raw_spin_unlock_irqrestore+0x2c/0x80 kernel/locking/spinlock.c:194 (P)
  class_raw_spinlock_irqsave_destructor include/linux/spinlock.h:557 [inline]
  try_to_wake_up+0x3b0/0x7e0 kernel/sched/core.c:4216
  wake_up_state+0x14/0x20 kernel/sched/core.c:4465
  rt_mutex_wake_up_q kernel/locking/rtmutex.c:566 [inline]
  rt_mutex_slowunlock+0x16c/0x2ac kernel/locking/rtmutex.c:1469
  rt_spin_unlock+0x24/0x34 kernel/locking/spinlock_rt.c:85
  spin_unlock_irqrestore include/linux/spinlock_rt.h:122 [inline]
  free_to_partial_list+0x2b8/0x5bc mm/slub.c:4466
  __slab_free+0x208/0x254 mm/slub.c:4498
  do_slab_free mm/slub.c:4632 [inline]
  slab_free mm/slub.c:4681 [inline]
  kmem_cache_free+0x320/0x5f0 mm/slub.c:4782
  mem_pool_free mm/kmemleak.c:508 [inline]
  free_object_rcu+0x104/0x11c mm/kmemleak.c:536
  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
  rcu_core kernel/rcu/tree.c:2861 [inline]
  rcu_cpu_kthread+0x404/0xcd0 kernel/rcu/tree.c:2949
  smpboot_thread_fn+0x270/0x474 kernel/smpboot.c:160
  kthread+0x314/0x384 kernel/kthread.c:463
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

NMI Backtrace shows RCU threads (rcuc/X) on multiple CPUs are experiencing
severe contention while trying to acquire the RT-Mutex in
free_to_partial_list(). Similar contention traces were observed on other
CPUs.

The core issue is that kmem_cache_node->list_lock is too hot to operate as
a sleeping lock (RT-Mutex) under high contention scenarios. I've seeking
community feedback on the best approach to ensure system stability while
maintaining RT guarantees. Here’s my thought on a possible direction:

1. Convert list_lock to raw_spinlock_t (Immediate Fix)

 The most straightforward solution is to change kmem_cache_node->list_lock
 from spinlock_t to raw_spinlock_t. This ensures the lock remains a
 non-sleeping spinlock even on PREEMPT_RT.

   - Pros:
     Reliably resolves the deadlock by eliminating the RT-Mutex overhead.
     Minimal code changes required.

   - Cons:
     Reintroduces a traditional spinlock, which could theoretically
     slightly increase latency for high-priority RT tasks. However, given
     the very short critical section protected by this lock, this may be a
     reasonable trade-off for stability.

2. Reducing Lock Contention

 Instead of changing the lock type, we could reduce the frequency of
 acquiring the node-level list_lock. Contention primarily occurs when
 per-CPU partial lists (kmem_cache_cpu->partial) are flushed to the node
 list (kmem_cache_node->partial).
 Tuning and Batching: We could adjust the thresholds in flush_cpu_slab()
 or enhance batch processing when moving slabs to reduce the number of
 lock acquisitions.

   - Pros:
     Improves overall SLUB scalability while maintaining PREEMPT_RT locking
     semantics (using RT-Mutexes).

   - Cons:
     Implementation and tuning are complex. It may increase per-CPU memory
     usage and might not entirely resolve contention under extreme loads.

3. Deferring Node List Updates

 A structural change to avoid acquiring the list_lock (RT-Mutex) in the
 memory freeing fast path. Instead of moving slabs to the node list
 immediately by the task freeing the memory (especially in RCU callback
 context), this work could be deferred to a dedicated workqueue or kthread.

   - Pros:
     Removes heavy RT-Mutex acquisition from the fast path, potentially
     improving response times.

   - Cons:
     Adds significant complexity to the SLUB architecture. It might impact
     performance in non-RT environments or delay memory reclamation.

Given the severity of the observed deadlock, Option 1 using raw_spinlock_t
appears to be the most pragmatic and immediate solution to guarantee system
stability. However, I would like to hear the community's opinion on whether
this is the best approach aligned with PREEMPT_RT goals, or if the MM/RT
community prefers a longer-term structural improvement like Option 2 or 3.

Please let me know if further adjustments, testing, or reproduction are
needed. Welcome any feedback or suggestions regarding this issue.

Best regards.
Yunseong Kim
