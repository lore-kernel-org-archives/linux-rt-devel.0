Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC5412BEB
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Aug 2026 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194155; cv=none; b=GurvLWkq7/cHZVb9u6WemxTys56dnAmxo6gwNTgR1RHV2DDZaC1UcDAToabr/d1uOZfm/WfWf6GAvcN4/JpIJPl8AEv0XQkt7ChpDXhsvNDpuvMfIj4UdQDpNamYGyks2dP96RMNkozQr7m30DjxygmF85PKk1M4zJ8vKoYuelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194155; c=relaxed/simple;
	bh=p4iWvSdQ3hBFw02bBF37uFmRU0GFghwTJLWgZoWp+XA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYzss4wCr85qN/flN5ykGk/ekutrdKE1+bo0Lw7Ga1jWnAdY1jUPCHgbbTe6kykw9cRrBGrLIc4oCX2kYAWB4PUnkge5AWfh7I0qItR0//pTeqjSuHA2BZJn7ragIrT0fZmpSKHjDaBxCl+EcFwEXkkjuTH3UrxFM32C7oAozB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EysE+3ei; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EysE+3ei"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so5162855ad.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 08 Aug 2026 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786194152; x=1786798952; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0BSXQBs1gRn3aBhYJEQHhB3ImTCZijGMp204g8xucw=;
        b=EysE+3eicEC6rwHsxrgmGteT6rS5Qj4vUaO4GU58/T4DCNBbAHRmkYMKknFXjOfgWz
         WX0be9y9ddI8g9pkPgE5cw2PcjfT08P4W8EOR7HIXfb4xLos6juTTNpRJsIWmor0iw7+
         7kT8cq8cKRoXdGh7yLMEGoCOgRW9o4WJvT88a++jb7DpEnmfA/9tttbNF6OtRHU8mn5B
         D3Rlg0USMrzaagZbUMajPKsI2IY3mN3InAO9AnDsIuwz2aQXrIMdvhFAKwr4KkZgRFj1
         3xuwN8orBGbvV8kRU1ReQJJkOWtrxPS2QHcUxHxowIp4v5mAnc8WXpLh1Uss9cy0GQNL
         QtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786194152; x=1786798952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0BSXQBs1gRn3aBhYJEQHhB3ImTCZijGMp204g8xucw=;
        b=RAFaCnRvYvlrhKsn0HIt8ScMloIxICDL7+aKvL77VEztOtzCkDyi9DDS3wegqsJYhu
         /tmRIJBUX0x5AZ2fbYigrIJT9RrDloxir8v7Pc720P/8bXD43p62xu8isfBrPpLZocsf
         WFY9oDoUnSGnnPQGqmTXwKXaBuKsWEBLJfV+cYe1Qj2nFCoyNpJwgw/Yop45Ts8Ziz1s
         AmXB5MWqnZDRk/r38OJsGrsZhyy9LRkXFUdhWG4uYzzXl4ss+i5ppmP3pDUKWPFlnMVy
         Pztnw80vsOZNGh67gcEDNhW5ael5lQFDhdpMxhK028CyN/QNrr+uRz2j71Tu98q5KIik
         mqgA==
X-Forwarded-Encrypted: i=1; AHgh+RosszhIQedMeC+anEXPNRMWTghFA5AZ1GLLmd7P9GgsiHyrmytsL2ZJHJVv67x06/Hs0JzOsr+DpLFqmUEApg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfXn2UN1HX9tDLNNGcXScJpLZZwbcqFUXZVBvPCTJO2ItZgAYs
	5dLiXLlGAB7b62vV+4rASZwi7pUvAOxLX+AcraSM7ltExRUeDhf7v/qL
X-Gm-Gg: AR+sD10fGLPiWnfBKiAcd61iU6mqvZ//i1ZrLHa5IKdV/Ru6z9eCgALL9PBEed2a8oP
	/CZKtfxBIa5euCYgZnrbYcqjeVHpvx9+fmSflg9ZsnRGJ0LWgEUKVt8BRQe221cDFezg8plakMB
	4Bh7BXFk753GM2l7jdrySmNbYPQF62nQSoamrRGCyTCqBTghaW+mpN+L0Pyce433RBARPgDG/r/
	cWRLqjo7vC2JfSDMxFFVUeuGxpqJ91/+9MwhZM1q8w/+TyMCeTUpbQdaDZyb1I1/eQDEnALBVY0
	EfHti03hN+SqQsnSAKI5nCSLRgk+3sM80dcjtM35AbkoemRndxT0YVpjZ1j+PkUo/2SsRAzbOWT
	gGoODvgPk34yzx7izLypZlu82BCRkUPRXrPv3VmEJd2avIzrVIIgqXIZ6u57UPNtFVUauBGEzuH
	7rF2IZY7AnBbChPkhaZ2zlTQ/wnG6F8zDJr+hGRaEoVIet76i7ctlsuZRqSJ6lfH8HfFKtFFafd
	GH7pLsuPgF4J/ZkuyXdIWYZrmuUQK8S
X-Received: by 2002:a17:902:f610:b0:2d0:4021:bb6b with SMTP id d9443c01a7336-2d2a55dba41mr89761525ad.0.1786194151621;
        Sat, 08 Aug 2026 06:02:31 -0700 (PDT)
Received: from lixiang-ThinkCentre-M755e-N000.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccae6f8sm18584645ad.1.2026.08.08.06.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 06:02:31 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ruipengqi3@gmail.com
Subject: [PATCH v2 0/2] hung_task: show the blocker task if the task is hung on rtmutex
Date: Sat,  8 Aug 2026 21:02:16 +0800
Message-Id: <cover.1786193045.git.ruipengqi3@gmail.com>
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
lock types. Extend it to also cover rtmutex or rt_mutex-based lock
implementations on PREEMPT_RT, so that when a task is hung on an
rtmutex, the hung task detector can identify and report which task holds
the lock.

Add rt_mutex_task_owner() to get the task's lock owner when a task is
blocked by an rtmutex-based lock implementation.

Since the LSBs of task->blocker pointer are already fully utilized and
leave no room for new blocker types, this version avoids adding a new
blocker type by directly leveraging rt_mutex_task_owner() to retrieve
the lock owner information.

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

---
v2 changes:
 - Reduce #ifdef-ery by using rt_mutex_task_owner() instead of adding a new blocker type,
 suggested by Petr.
 - Remove the unused function debug_trace_blocker(), suggested by Xusheng.
 - Clean up and update relevant comments.
 - https://lore.kernel.org/all/cover.1785376929.git.ruipengqi3@gmail.com/

Ruipeng Qi (2):
  hung_task: show the blocker task if the task is hung on rtmutex
  samples: enhance hung_task detector test with rtmutex support

 include/linux/rtmutex.h             |  2 ++
 kernel/hung_task.c                  | 26 +++++++++++++--
 kernel/locking/rtmutex_api.c        | 29 +++++++++++++++++
 lib/Kconfig.debug                   |  1 -
 samples/Kconfig                     |  2 +-
 samples/hung_task/hung_task_tests.c | 50 ++++++++++++++++++++++++++---
 6 files changed, 101 insertions(+), 9 deletions(-)

-- 
2.25.1

