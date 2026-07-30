Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34653054C7
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jul 2026 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387985; cv=none; b=Og+Y6pYBIo//BEDrn+8NXTKjxHz1YT1lUry6DRslkrqm3DJ/PAVNb2jfg5AUt8zoOadEMGZIe7UFwEMVFzmEVck/34WZvELdXbQalcfOu8Md2kbwAGXuV1+dGWOSap/nQ0xB1L39NlNvRzEU1M4EjdcOG5HmV6Yd1S6z7TJvQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387985; c=relaxed/simple;
	bh=fQKE96/SnAxUO0ebYseki4+Yyzcp2wI56TzlCDe4lMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIhJIjl9KJetyf6Ie3hN3V9tpPdY9cuzU+rh1OOT+wIondWP03FW1EqQUvLuZFOQ6qeZOJx+iwfr6aufBj+CIHrV5+oUFJFM9WCkyWLrlnzOcUogro/qZnZrvns2BhZ42viU3LnyWb9UYwN1U8f1nPD8ezY4V0GIEKhSFH7FS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dcOd/GuH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dcOd/GuH"
Message-ID: <138ba5ec-41a1-4fe3-851a-51dbb866afae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785387980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiBofKYAg7Kh4AkmGa9AVwK9K17LYRb4NQmrD/NAMlw=;
	b=dcOd/GuHZl7l9IYP5DODCu+yU3sTN+8c7pIOCddBE0Sw2mliOEDRqLrJT0NV7lLtQszb3Q
	iAiW4voGpXX353hC9nCjZsxVVhCwfPfccCaNSvnCBJFfDYZr47uJGdBSHsFFZsp8cVyucN
	z39E/HGJjrP4dzSQ/NPUjsCV86qDdIo=
Date: Thu, 30 Jul 2026 13:06:08 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] hung_task: extend blocking task stacktrace dump to
 rtmutex
Content-Language: en-US
To: ruipengqi <ruipengqi3@gmail.com>, peterz@infradead.org
Cc: mhiramat@kernel.org, pmladek@suse.com, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, clrkwllms@kernel.org,
 rostedt@goodmis.org, zhouyuhang@kylinos.cn, arnd@arndb.de,
 colin.i.king@gmail.com, ebiggers@kernel.org, inux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org,
 bigeasy@linutronix.de
References: <cover.1785376929.git.ruipengqi3@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <cover.1785376929.git.ruipengqi3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Afraid Peter may still strongly object to this whole approach:

https://lore.kernel.org/lkml/20260325150336.GF3738786@noisy.programming.kicks-ass.net/

Emm ... did you reach out to Peter privately, hash this out off-list,
and get his okay to extend it to rtmutex?

Cheers, Lance

On 2026/7/30 10:29, ruipengqi wrote:
> From: Ruipeng Qi <ruipengqi3@gmail.com>
> 
> Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
> lock types. Extend it to also cover rtmutex or rt_mutex-based
> implementations locks on PREEMPT_RT, so that when a task is hung
> on an rtmutex, the hung task detector can identify and report which
> task holds the lock.
> 
> On 64-bit systems, lock pointers are 8-byte aligned, so their three
> least significant bits are always zero. Use these bits to encode the
> blocker type.
> 
> Unlike semaphores, rtmutex has built-in owner tracking via lock->owner,
> so no additional bookkeeping is needed. The owner can be read with
> rt_mutex_owner().
> 
> With this change, the hung task detector can now show blocker task's
> info like below:
> 
> [ 3000.899985] INFO: task cat:195 blocked for more than 120 seconds.
> [ 3000.900561]       Not tainted 7.2.0-rc4-00366-gf339a6eb59f3-dirty #22
> [ 3000.900930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3000.901376] task:cat             state:D stack:13784 pid:195   tgid:195   ppid:1      task_flags:0x400000 flags:0x00080000
> [ 3000.902081] Call Trace:
> [ 3000.902233]  <TASK>
> [ 3000.902383]  __schedule+0x514/0xf50
> [ 3000.902677]  rt_mutex_schedule+0x1b/0x30
> [ 3000.902916]  rt_mutex_slowlock_block.constprop.0+0x3b/0x1c0
> [ 3000.903242]  __rt_mutex_slowlock_locked.constprop.0+0xa8/0x200
> [ 3000.903716]  rt_mutex_slowlock.constprop.0+0x48/0xb0
> [ 3000.904023]  rt_mutex_lock+0x32/0x40
> [ 3000.904249]  read_dummy_rtmutex+0x2a/0x60 [hung_task_tests]
> [ 3000.904647]  full_proxy_read+0x5b/0x90
> [ 3000.904843]  vfs_read+0xb0/0x370
> [ 3000.905051]  ? vm_mmap_pgoff+0xf1/0x1b0
> [ 3000.905293]  ? vm_mmap_pgoff+0x122/0x1b0
> [ 3000.905684]  ksys_read+0x68/0xe0
> [ 3000.905980]  do_syscall_64+0xf9/0x540
> [ 3000.906213]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 3000.906643] RIP: 0033:0x49a182
> [ 3000.906844] RSP: 002b:00007ffc431f6528 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [ 3000.907251] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
> [ 3000.907673] RDX: 0000000000010000 RSI: 00007f69b2166000 RDI: 0000000000000003
> [ 3000.908044] RBP: 00007f69b2166000 R08: 00000000ffffffff R09: 0000000000000000
> [ 3000.908485] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
> [ 3000.908816] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
> [ 3000.909206]  </TASK>
> [ 3000.909351] INFO: task cat:195 is blocked on a rtmutex likely owned by task cat:194.
> [ 3000.909832] task:cat             state:S stack:13784 pid:194   tgid:194   ppid:1      task_flags:0x400000 flags:0x00080000
> [ 3000.910426] Call Trace:
> [ 3000.910618]  <TASK>
> [ 3000.910727]  __schedule+0x514/0xf50
> [ 3000.910912]  schedule+0x22/0xa0
> [ 3000.911064]  schedule_timeout+0x81/0x100
> [ 3000.911254]  ? __pfx_process_timeout+0x10/0x10
> [ 3000.911522]  msleep_interruptible+0x28/0x50
> [ 3000.911754]  read_dummy_rtmutex+0x34/0x60 [hung_task_tests]
> [ 3000.912019]  full_proxy_read+0x5b/0x90
> [ 3000.912212]  vfs_read+0xb0/0x370
> [ 3000.912378]  ? vm_mmap_pgoff+0xf1/0x1b0
> [ 3000.912630]  ? vm_mmap_pgoff+0x122/0x1b0
> [ 3000.912839]  ksys_read+0x68/0xe0
> [ 3000.913007]  do_syscall_64+0xf9/0x540
> [ 3000.913187]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 3000.913461] RIP: 0033:0x49a182
> [ 3000.913618] RSP: 002b:00007ffd0b4cf048 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [ 3000.913972] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
> [ 3000.914294] RDX: 0000000000010000 RSI: 00007fbf49a0d000 RDI: 0000000000000003
> [ 3000.914648] RBP: 00007fbf49a0d000 R08: 00000000ffffffff R09: 0000000000000000
> [ 3000.914955] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
> [ 3000.915208] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
> [ 3000.915439]  </TASK>
> 
> Ruipeng Qi (2):
>    hung_task: show the blocker task if the task is hung on rtmutex
>    samples: enhance hung_task detector test with rtmutex support
> 
>   include/linux/hung_task.h           | 31 +++++++++++++-----
>   kernel/hung_task.c                  | 22 +++++++++++++
>   kernel/locking/mutex.c              |  4 +--
>   kernel/locking/rtmutex.c            | 13 ++++++++
>   kernel/locking/rwsem.c              |  8 ++---
>   kernel/locking/semaphore.c          |  4 +--
>   lib/Kconfig.debug                   |  1 -
>   samples/Kconfig                     |  2 +-
>   samples/hung_task/hung_task_tests.c | 50 ++++++++++++++++++++++++++---
>   9 files changed, 113 insertions(+), 22 deletions(-)
> 

