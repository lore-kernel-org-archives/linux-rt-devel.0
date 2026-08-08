Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC59328B71
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Aug 2026 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786203277; cv=none; b=XSFoHVpQbsIlIR6Cr0bSxvSxQ/VHXGEfv/bWgQOCrEBeHpULbkwBzUAYBnC67oZTGYVdjRjdJ3hqI2B5+9kStJUG8Zsoe7nnF/0F37BCbThGODXqyHxLUhtKlOOC7BG+FP3v/2SxKl/i5rY8TUHp+5rNN0voQjHyVOYacXaMBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786203277; c=relaxed/simple;
	bh=3D0G5+vkNOBtY0+pifDk0BNo7PHQz1BWxD10gZKzbl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tv3IVqNca3+iiE4iXikM0EnzeLYueVq3To4fovmo9XvoKQ6qX+Bfn1L8RLeSeOkimWoWnGVmC1ej3+09EIqF3bn8PCLUiUPFt5eI9y9OEp3vvKAx0o/Y/6yJKMBQkwiyI4B8hV3TlXKAAAGg+enMYxJocSFMNwIan1XtZ5JpqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vBsy/pIK; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vBsy/pIK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786203272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wJhKTX617WABgSx66ReUbIDPNqXRdWhduQT9zopWmw=;
	b=vBsy/pIK/vqBXquT5rEDtxWn5gO7WCj5v1HY142lwvnIwnDdwl/IREISpCpTQWbBdGgqQg
	KdlxTHO0Fl56ygfIKtOApqrp27HNNYIEHB3MZQWX4rw5zWWG0JtGSN5SxhCkhkALG/1UV9
	SFTenzUnwQbs+OsmWFnhLbDLSqjgV/4=
From: Lance Yang <lance.yang@linux.dev>
To: ruipengqi3@gmail.com
Cc: akpm@linux-foundation.org,
	peterz@infradead.org,
	bigeasy@linutronix.de,
	mhiramat@kernel.org,
	pmladek@suse.com,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 0/2] hung_task: show the blocker task if the task is hung on rtmutex
Date: Sat,  8 Aug 2026 23:34:16 +0800
Message-Id: <20260808153416.49698-1-lance.yang@linux.dev>
In-Reply-To: <cover.1786193045.git.ruipengqi3@gmail.com>
References: <cover.1786193045.git.ruipengqi3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Ruipeng,

Guess I'll have to be the bad guy here ...

Already raised this in v1 [1], but never got an answer ...

This touches locking too, and Peter has already made it pretty clear he
doesn't want this kind of debug code there.

Please don't send another version unless Peter is on board. Otherwise,
just spinning wheels ...

[1] https://lore.kernel.org/all/138ba5ec-41a1-4fe3-851a-51dbb866afae@linux.dev/

Thanks, Lance

On Sat, Aug 08, 2026 at 09:02:16PM +0800, ruipengqi wrote:
>From: Ruipeng Qi <ruipengqi3@gmail.com>
>
>Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
>lock types. Extend it to also cover rtmutex or rt_mutex-based lock
>implementations on PREEMPT_RT, so that when a task is hung on an
>rtmutex, the hung task detector can identify and report which task holds
>the lock.
>
>Add rt_mutex_task_owner() to get the task's lock owner when a task is
>blocked by an rtmutex-based lock implementation.
>
>Since the LSBs of task->blocker pointer are already fully utilized and
>leave no room for new blocker types, this version avoids adding a new
>blocker type by directly leveraging rt_mutex_task_owner() to retrieve
>the lock owner information.
>
>With this change, the hung task detector can now show blocker task's
>info like below:
>
>[ 3000.899985] INFO: task cat:195 blocked for more than 120 seconds.
>[ 3000.900561]       Not tainted 7.2.0-rc4-00366-gf339a6eb59f3-dirty #22
>[ 3000.900930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>[ 3000.901376] task:cat             state:D stack:13784 pid:195   tgid:195   ppid:1      task_flags:0x400000 flags:0x00080000
>[ 3000.902081] Call Trace:
>[ 3000.902233]  <TASK>
>[ 3000.902383]  __schedule+0x514/0xf50
>[ 3000.902677]  rt_mutex_schedule+0x1b/0x30
>[ 3000.902916]  rt_mutex_slowlock_block.constprop.0+0x3b/0x1c0
>[ 3000.903242]  __rt_mutex_slowlock_locked.constprop.0+0xa8/0x200
>[ 3000.903716]  rt_mutex_slowlock.constprop.0+0x48/0xb0
>[ 3000.904023]  rt_mutex_lock+0x32/0x40
>[ 3000.904249]  read_dummy_rtmutex+0x2a/0x60 [hung_task_tests]
>[ 3000.904647]  full_proxy_read+0x5b/0x90
>[ 3000.904843]  vfs_read+0xb0/0x370
>[ 3000.905051]  ? vm_mmap_pgoff+0xf1/0x1b0
>[ 3000.905293]  ? vm_mmap_pgoff+0x122/0x1b0
>[ 3000.905684]  ksys_read+0x68/0xe0
>[ 3000.905980]  do_syscall_64+0xf9/0x540
>[ 3000.906213]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>[ 3000.906643] RIP: 0033:0x49a182
>[ 3000.906844] RSP: 002b:00007ffc431f6528 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>[ 3000.907251] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
>[ 3000.907673] RDX: 0000000000010000 RSI: 00007f69b2166000 RDI: 0000000000000003
>[ 3000.908044] RBP: 00007f69b2166000 R08: 00000000ffffffff R09: 0000000000000000
>[ 3000.908485] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
>[ 3000.908816] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
>[ 3000.909206]  </TASK>
>[ 3000.909351] INFO: task cat:195 is blocked on a rtmutex likely owned by task cat:194.
>[ 3000.909832] task:cat             state:S stack:13784 pid:194   tgid:194   ppid:1      task_flags:0x400000 flags:0x00080000
>[ 3000.910426] Call Trace:
>[ 3000.910618]  <TASK>
>[ 3000.910727]  __schedule+0x514/0xf50
>[ 3000.910912]  schedule+0x22/0xa0
>[ 3000.911064]  schedule_timeout+0x81/0x100
>[ 3000.911254]  ? __pfx_process_timeout+0x10/0x10
>[ 3000.911522]  msleep_interruptible+0x28/0x50
>[ 3000.911754]  read_dummy_rtmutex+0x34/0x60 [hung_task_tests]
>[ 3000.912019]  full_proxy_read+0x5b/0x90
>[ 3000.912212]  vfs_read+0xb0/0x370
>[ 3000.912378]  ? vm_mmap_pgoff+0xf1/0x1b0
>[ 3000.912630]  ? vm_mmap_pgoff+0x122/0x1b0
>[ 3000.912839]  ksys_read+0x68/0xe0
>[ 3000.913007]  do_syscall_64+0xf9/0x540
>[ 3000.913187]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>[ 3000.913461] RIP: 0033:0x49a182
>[ 3000.913618] RSP: 002b:00007ffd0b4cf048 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>[ 3000.913972] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
>[ 3000.914294] RDX: 0000000000010000 RSI: 00007fbf49a0d000 RDI: 0000000000000003
>[ 3000.914648] RBP: 00007fbf49a0d000 R08: 00000000ffffffff R09: 0000000000000000
>[ 3000.914955] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
>[ 3000.915208] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
>[ 3000.915439]  </TASK>
>
>---
>v2 changes:
> - Reduce #ifdef-ery by using rt_mutex_task_owner() instead of adding a new blocker type,
> suggested by Petr.
> - Remove the unused function debug_trace_blocker(), suggested by Xusheng.
> - Clean up and update relevant comments.
> - https://lore.kernel.org/all/cover.1785376929.git.ruipengqi3@gmail.com/
>
>Ruipeng Qi (2):
>  hung_task: show the blocker task if the task is hung on rtmutex
>  samples: enhance hung_task detector test with rtmutex support
>
> include/linux/rtmutex.h             |  2 ++
> kernel/hung_task.c                  | 26 +++++++++++++--
> kernel/locking/rtmutex_api.c        | 29 +++++++++++++++++
> lib/Kconfig.debug                   |  1 -
> samples/Kconfig                     |  2 +-
> samples/hung_task/hung_task_tests.c | 50 ++++++++++++++++++++++++++---
> 6 files changed, 101 insertions(+), 9 deletions(-)
>
>-- 
>2.25.1
>
>
