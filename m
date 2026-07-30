Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E836EA8B
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jul 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378565; cv=none; b=BBMSoFvaiPVk9SdwgPcp/i/GfTW92mJ6jUTuXaJh/jYAYbTpe3IUAV0FASjJtIZy4nxwFFD4MnPIfnAkJWLpj4Syjfgul5Bszv1+o4NWTujc0apWJh+zoyzAakiiYwikancCiE1CFbvySY59+mVD/tjfC+t8kOkg2xdV/bLCZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378565; c=relaxed/simple;
	bh=f47uiq4k/MGByAFShVHaqzOVCYMmYEDdv9XurfayGT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyK73FCCuyhHy82+9tndbkQzMS4fV6neTLog0jOMJG6qOru6YpDCSt0s9PlyWh/fK1zY3wJCJAcbMt4nzG8gCZToq4Rg9tWzBcMVisomlwMzlZdNRj9IUxW3sjjQ4DnkjbubWo4h7XtODyyDQbmvTEl2HJwY606SZCNpN+52GLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvylsSGH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvylsSGH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1923509b3a.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785378563; x=1785983363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Ff4D4Hg0ozL6OR5O3nYY9MlOsOrIIti+CW3zT9zsbs=;
        b=bvylsSGHvdVFB2yTUfoZr0iLMxw0fXwRmep3vn/vvVS8HCrQlIUT0RHISVq0t24Qd9
         2FK4vo3TmwdvuPQwx1MosdNNiJTd8COlGmNFdAPPRPOvcBIeKfTXGBbuwkf1vLDhHDIc
         memzTq8yrEfuPCW2p55i+VpBYUh34vWdMnPfro/4KVmfFAKLKWSV3AtnFjSAUQMW2Ytb
         JAs35y4s2X3JItKjZaw2/cfQTco4vodwNl8rbX3A4cm8t1ss6bx2ny9fnHqZFTptzzl/
         A9r+cqJUCkIEpP1d1rfOFBMGh0jBYRkBb+9oRtUpVLY1T0hUU625LqvoKD8m+FfJ6P5j
         o/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785378563; x=1785983363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ff4D4Hg0ozL6OR5O3nYY9MlOsOrIIti+CW3zT9zsbs=;
        b=O17/efw6kg1qgnmAaIf/4b6IpKF+7cssgUcDP3WmLNosLk1tkqOxogcEfgfYUUfcSZ
         R0r0Zumx84jc4Zo6Yab0H6roylNx/bJ6GtkySY1j77S1D7eLsCC3CFHPjLhhELh4MHvf
         /GKhF0jUrhIPws2+Kz30g1IzP0tNOgUAjTPVojnttp5FjCzC/pOb44l7O68b1xvZA0Vg
         0FEF0Qh+1gapXrDW7DcMKjo9lpkCO7qNbOUbR8kTCXBxxnGBFwA6eMtvLxmhA/kykwO1
         TavW5QvSF/kxwn3gbclFsDG1mbh1ddvA08CDy5vCexY0Otuaowmx69iTlpl7HXIsxuJa
         pLow==
X-Forwarded-Encrypted: i=1; AHgh+RpQcrxnGScDj5fdWHWRZz1gDfHgyvTueKFeEBKCblkit5qtWkymeVH1XT+lcpuZ5p/5aEkpeaXvYsigj14JEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3NhYRDPUvFzinTMH4ktC1yhJAOWK3lZuXzKJCidkmdbIKu6CD
	Y8hWtIbF+01uxEYpW0yoLlOwkA9kdLNIHK0j33gnqIQWL7BAmTWtGeYp
X-Gm-Gg: AR+sD122A0hjudJqBHH1EFB475TwjMfAU4cJfTJYmQsnO07Nlw6kbexdACh4YVbYguP
	tqotPSawO19IUrLyV0gOuKRBs9xipmI4btKq1hHE/pkgZ2IO244Y0vUGI4kxl+iJCtD+ZKq7Cmg
	ffkqetjoDy+ODoXdl8j/O8inW1rfIvXAYNLPuB5VT40s5yeJ7FIP0a5xL6xTYRk0ak33YdYqX42
	iTxpgrC2Tc0Rpfqbeu0akQ6M/ZrmPU7oEjti4cin4WPlLHFSo5BWwKAt9nGx1+HWXovDquMasZg
	PvikvHasqiSpauLxPFtqvC4ZKE3ZpasUNduMzYy/FgtxzYk7knFtczGNVl+yU+sYrk7x2RDtp+E
	hSuT8Gb613myhCIr47NhAOCcDxuw7067R2wj73gpE5qb4cqsfjEyQEOJg9GkSEwK4H0M1gctzvb
	7w8hIDAXfsG+GC15t1InFtSwbJYyx/Rc1JL1UyxX4UvnA4VeKCHnaXVcYctmk2uxijpdL9zSIxE
	w0Kgl6kN84BG3qvCT2ZObGTQ0MrnZUR
X-Received: by 2002:a05:6a21:4d92:b0:3bb:106d:77be with SMTP id adf61e73a8af0-3c9007ef410mr657212637.44.1785378563428;
        Wed, 29 Jul 2026 19:29:23 -0700 (PDT)
Received: from lixiang-ThinkCentre-M755e-N000.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb7b8df4fsm1496917a12.2.2026.07.29.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:29:22 -0700 (PDT)
From: ruipengqi <ruipengqi3@gmail.com>
To: akpm@linux-foundation.org,
	peterz@infradead.org,
	bigeasy@linutronix.de
Cc: lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	zhouyuhang@kylinos.cn,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	ebiggers@kernel.org,
	inux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ruipengqi3@gmail.com
Subject: [PATCH 0/2] hung_task: extend blocking task stacktrace dump to rtmutex
Date: Thu, 30 Jul 2026 10:29:07 +0800
Message-Id: <cover.1785376929.git.ruipengqi3@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruipeng Qi <ruipengqi3@gmail.com>

Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
lock types. Extend it to also cover rtmutex or rt_mutex-based
implementations locks on PREEMPT_RT, so that when a task is hung
on an rtmutex, the hung task detector can identify and report which
task holds the lock.

On 64-bit systems, lock pointers are 8-byte aligned, so their three
least significant bits are always zero. Use these bits to encode the
blocker type.

Unlike semaphores, rtmutex has built-in owner tracking via lock->owner,
so no additional bookkeeping is needed. The owner can be read with
rt_mutex_owner().

With this change, the hung task detector can now show blocker task's
info like below:

[ 3000.899985] INFO: task cat:195 blocked for more than 120 seconds.
[ 3000.900561]       Not tainted 7.2.0-rc4-00366-gf339a6eb59f3-dirty #22
[ 3000.900930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3000.901376] task:cat             state:D stack:13784 pid:195   tgid:195   ppid:1      task_flags:0x400000 flags:0x00080000
[ 3000.902081] Call Trace:
[ 3000.902233]  <TASK>
[ 3000.902383]  __schedule+0x514/0xf50
[ 3000.902677]  rt_mutex_schedule+0x1b/0x30
[ 3000.902916]  rt_mutex_slowlock_block.constprop.0+0x3b/0x1c0
[ 3000.903242]  __rt_mutex_slowlock_locked.constprop.0+0xa8/0x200
[ 3000.903716]  rt_mutex_slowlock.constprop.0+0x48/0xb0
[ 3000.904023]  rt_mutex_lock+0x32/0x40
[ 3000.904249]  read_dummy_rtmutex+0x2a/0x60 [hung_task_tests]
[ 3000.904647]  full_proxy_read+0x5b/0x90
[ 3000.904843]  vfs_read+0xb0/0x370
[ 3000.905051]  ? vm_mmap_pgoff+0xf1/0x1b0
[ 3000.905293]  ? vm_mmap_pgoff+0x122/0x1b0
[ 3000.905684]  ksys_read+0x68/0xe0
[ 3000.905980]  do_syscall_64+0xf9/0x540
[ 3000.906213]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3000.906643] RIP: 0033:0x49a182
[ 3000.906844] RSP: 002b:00007ffc431f6528 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 3000.907251] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
[ 3000.907673] RDX: 0000000000010000 RSI: 00007f69b2166000 RDI: 0000000000000003
[ 3000.908044] RBP: 00007f69b2166000 R08: 00000000ffffffff R09: 0000000000000000
[ 3000.908485] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
[ 3000.908816] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
[ 3000.909206]  </TASK>
[ 3000.909351] INFO: task cat:195 is blocked on a rtmutex likely owned by task cat:194.
[ 3000.909832] task:cat             state:S stack:13784 pid:194   tgid:194   ppid:1      task_flags:0x400000 flags:0x00080000
[ 3000.910426] Call Trace:
[ 3000.910618]  <TASK>
[ 3000.910727]  __schedule+0x514/0xf50
[ 3000.910912]  schedule+0x22/0xa0
[ 3000.911064]  schedule_timeout+0x81/0x100
[ 3000.911254]  ? __pfx_process_timeout+0x10/0x10
[ 3000.911522]  msleep_interruptible+0x28/0x50
[ 3000.911754]  read_dummy_rtmutex+0x34/0x60 [hung_task_tests]
[ 3000.912019]  full_proxy_read+0x5b/0x90
[ 3000.912212]  vfs_read+0xb0/0x370
[ 3000.912378]  ? vm_mmap_pgoff+0xf1/0x1b0
[ 3000.912630]  ? vm_mmap_pgoff+0x122/0x1b0
[ 3000.912839]  ksys_read+0x68/0xe0
[ 3000.913007]  do_syscall_64+0xf9/0x540
[ 3000.913187]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3000.913461] RIP: 0033:0x49a182
[ 3000.913618] RSP: 002b:00007ffd0b4cf048 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 3000.913972] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
[ 3000.914294] RDX: 0000000000010000 RSI: 00007fbf49a0d000 RDI: 0000000000000003
[ 3000.914648] RBP: 00007fbf49a0d000 R08: 00000000ffffffff R09: 0000000000000000
[ 3000.914955] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
[ 3000.915208] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
[ 3000.915439]  </TASK>

Ruipeng Qi (2):
  hung_task: show the blocker task if the task is hung on rtmutex
  samples: enhance hung_task detector test with rtmutex support

 include/linux/hung_task.h           | 31 +++++++++++++-----
 kernel/hung_task.c                  | 22 +++++++++++++
 kernel/locking/mutex.c              |  4 +--
 kernel/locking/rtmutex.c            | 13 ++++++++
 kernel/locking/rwsem.c              |  8 ++---
 kernel/locking/semaphore.c          |  4 +--
 lib/Kconfig.debug                   |  1 -
 samples/Kconfig                     |  2 +-
 samples/hung_task/hung_task_tests.c | 50 ++++++++++++++++++++++++++---
 9 files changed, 113 insertions(+), 22 deletions(-)

-- 
2.25.1

