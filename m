Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794D231832
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787536948; cv=none; b=q2kPIlQuW6i1f3iUrNpnXduPngRM9U4ZtNQy1G6pnqwd78tITdFUy7EJ6A/7XsVLuvaFO71LRLz6ToKatqRITXXoYGJ/WXhcor37zmAdPI7FLais581SDFLPmVL8fPzHw5BevRAzzC93M7sbETu/ier8oxLfwGG0eWcIab5HByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787536948; c=relaxed/simple;
	bh=MA8ttnhVXssSWNPRWcIf9wvACYi5UnjUDBMsKwLK5tk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hlKlWR2TFnr53+u+xrYGHSHqyuZtU2qtNZcQcU9ytWlixembEbY6P7EvQ9lpCJoklH/03fkcgNUAd8k54TTX+KH36ycHqBiVeYct7jVh+RmmO7AlCgyeNl9EABIw6VjhfgUG0+E3eN/bIkgtCPTbM5qjNGiIxlTkibxcOQPg+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE03RpQf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE03RpQf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d5655cc850so33317475ad.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 23 Aug 2026 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787536946; x=1788141746; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hflPuwPAn93W0+zJycBKeubYA/0Oh5dPeuCHUMPeKdc=;
        b=AE03RpQfgiXvITZnEJt69kOa3L+X3RQriE9dMLCm87YXy/VH79nHbevlqflEGekc2C
         gckHGBk1NzqlVi8N+qaZDix97l0UYhvnIBhMtZesZ8/OxbUVut4Ii86xzN2y2XXLIbr4
         V0GbeXBNjDfR3SZIdsxmTRVnkEHx3hAa/ejG4Zwv1+auqeBA+U86g3OZgLhtJx0A5CBU
         3TKKxFjMjUgz+q0DbW+P2PpMIW7VP9gCwQKy33pCsrs6QrNIeqEgl94T+ih65ocIC8uM
         tVIqGTtueuYLIk1CSCXcj5Qw2JopkoGvRM0v037BpKA2Gu8M0C8YFdUATuCgeAGXG/0N
         2ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787536946; x=1788141746;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hflPuwPAn93W0+zJycBKeubYA/0Oh5dPeuCHUMPeKdc=;
        b=c0AkFMixw6TrSqvQfc84FsjjDhHNTAaVyTwNfN9BGORWTXy5//EwR6gBxk8EBpAp2Y
         YinkZObd7c0+PpINyVBuO82O1QwFs0SvilTAd5LD8UMLCcoXlWhMw1491Lb6CcpOctne
         0b5+pSaag0G65ZGeRe52gnmfJ489mg4e1RSc+ZSvnRTFPKhfxnEdZbL4K4+FbU9mTjjy
         ZBwXBBnC/QoGizauc/KQh3Y74cGtK6pdJoRpZshd0wBKAGBWYnbBd15UrexqSxW4xKxV
         UuxF43IW6YT5Cmno/j41IgPg00s1yKrSWoAQMAzx7b8JRn9hGTggEFLF/P87b67+bXT6
         O/pg==
X-Forwarded-Encrypted: i=1; AHgh+RrYYG7XPSsg+BAZvHcoKZxhDPTKwjGv2h/ELi7UGfzf3laTzXv4pQkUyvmJ+lcjSbi9J5fBj4IrqsCzIXUbsA==@lists.linux.dev
X-Gm-Message-State: AFuF++nn2jTr+XforPGgiGdY5o5R6fND0Jh40Tuj0f8e96WUiIhLtvRt
	5puhlp53xaabYOLCqceBqeSqPSf863XVB0du+IaEs3N9IKBi0i6F5zFF
X-Gm-Gg: AR+sD13dmqTQUHsaQPu+sb2u7AXrryPdHrCl6lw/OJhPS/EHSBLBJITh6IlUALXq7Cx
	927WzEHKxtpGKa7c7voD1IFBaERqkCpz1ssW5zhrZ32jlQlnONg/RDKuEG6q/Vlbm+IFOcoOko0
	QhH/doR8OsGD5osL5+iiwbf3Ukyl4Wb0bKfml6M62dCHRs4dBEv1TjBKJHPzEDSxr85HhfkSR9i
	P7oVWOpoV7P1NT3hQR5AW+gtViNIKQu8ksKEyJwkPF+bi7fenMBgNPoaX7IcjlNI0TmJBQ3q/Rk
	nn+RICWsVbGgeAWuib5fYAA6yYnNIQf8b4KBbFTcoshjc76h881o2SWzJjfch69peSSCQSWQrzc
	ZIkzk2v912Pdb+sTz66nrHOOrT1swQVa0Bs+CoWLeCeacXaXrgGSfOCQt2oeQW1Xzfh5Eis/DcI
	Qg3jY+RkbAqQVXliLJEILh7i2gQiqQpBQ+86hz+Tskxzc20EI6cguLySR6EJiodFNBiRiLgui2
X-Received: by 2002:a17:902:e943:b0:2d6:3c2f:69b with SMTP id d9443c01a7336-2d64af6f8cemr433835535ad.8.1787536946222;
        Sun, 23 Aug 2026 19:02:26 -0700 (PDT)
Received: from [10.121.80.84] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768e180dsm12313525ad.77.2026.08.23.19.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 19:02:25 -0700 (PDT)
Message-ID: <7686ada4-0b67-4df5-82bb-b5dfdf050fc2@gmail.com>
Date: Mon, 24 Aug 2026 10:02:25 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ruipeng Qi <ruipengqi3@gmail.com>
Subject: Re: [PATCH v2 0/2] hung_task: show the blocker task if the task is
 hung on rtmutex
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, peterz@infradead.org, bigeasy@linutronix.de,
 mhiramat@kernel.org, pmladek@suse.com, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, clrkwllms@kernel.org,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <cover.1786193045.git.ruipengqi3@gmail.com>
 <20260808153416.49698-1-lance.yang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260808153416.49698-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/8/2026 11:34 PM, Lance Yang wrote:
> Hi Ruipeng,
>
> Guess I'll have to be the bad guy here ...
>
> Already raised this in v1 [1], but never got an answer ...
>
> This touches locking too, and Peter has already made it pretty clear he
> doesn't want this kind of debug code there.

Hi, Lance

Peter remains opposed to this kind of debug code, so I will cease work 
on this patch series. Thank you.


Best Regards，
Ruipeng

> Please don't send another version unless Peter is on board. Otherwise,
> just spinning wheels ...
>
> [1]https://lore.kernel.org/all/138ba5ec-41a1-4fe3-851a-51dbb866afae@linux.dev/
>
> Thanks, Lance
>
> On Sat, Aug 08, 2026 at 09:02:16PM +0800, ruipengqi wrote:
>> From: Ruipeng Qi<ruipengqi3@gmail.com>
>>
>> Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
>> lock types. Extend it to also cover rtmutex or rt_mutex-based lock
>> implementations on PREEMPT_RT, so that when a task is hung on an
>> rtmutex, the hung task detector can identify and report which task holds
>> the lock.
>>
>> Add rt_mutex_task_owner() to get the task's lock owner when a task is
>> blocked by an rtmutex-based lock implementation.
>>
>> Since the LSBs of task->blocker pointer are already fully utilized and
>> leave no room for new blocker types, this version avoids adding a new
>> blocker type by directly leveraging rt_mutex_task_owner() to retrieve
>> the lock owner information.
>>
>> With this change, the hung task detector can now show blocker task's
>> info like below:
>>
>> [ 3000.899985] INFO: task cat:195 blocked for more than 120 seconds.
>> [ 3000.900561]       Not tainted 7.2.0-rc4-00366-gf339a6eb59f3-dirty #22
>> [ 3000.900930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 3000.901376] task:cat             state:D stack:13784 pid:195   tgid:195   ppid:1      task_flags:0x400000 flags:0x00080000
>> [ 3000.902081] Call Trace:
>> [ 3000.902233]  <TASK>
>> [ 3000.902383]  __schedule+0x514/0xf50
>> [ 3000.902677]  rt_mutex_schedule+0x1b/0x30
>> [ 3000.902916]  rt_mutex_slowlock_block.constprop.0+0x3b/0x1c0
>> [ 3000.903242]  __rt_mutex_slowlock_locked.constprop.0+0xa8/0x200
>> [ 3000.903716]  rt_mutex_slowlock.constprop.0+0x48/0xb0
>> [ 3000.904023]  rt_mutex_lock+0x32/0x40
>> [ 3000.904249]  read_dummy_rtmutex+0x2a/0x60 [hung_task_tests]
>> [ 3000.904647]  full_proxy_read+0x5b/0x90
>> [ 3000.904843]  vfs_read+0xb0/0x370
>> [ 3000.905051]  ? vm_mmap_pgoff+0xf1/0x1b0
>> [ 3000.905293]  ? vm_mmap_pgoff+0x122/0x1b0
>> [ 3000.905684]  ksys_read+0x68/0xe0
>> [ 3000.905980]  do_syscall_64+0xf9/0x540
>> [ 3000.906213]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> [ 3000.906643] RIP: 0033:0x49a182
>> [ 3000.906844] RSP: 002b:00007ffc431f6528 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> [ 3000.907251] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
>> [ 3000.907673] RDX: 0000000000010000 RSI: 00007f69b2166000 RDI: 0000000000000003
>> [ 3000.908044] RBP: 00007f69b2166000 R08: 00000000ffffffff R09: 0000000000000000
>> [ 3000.908485] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
>> [ 3000.908816] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
>> [ 3000.909206]  </TASK>
>> [ 3000.909351] INFO: task cat:195 is blocked on a rtmutex likely owned by task cat:194.
>> [ 3000.909832] task:cat             state:S stack:13784 pid:194   tgid:194   ppid:1      task_flags:0x400000 flags:0x00080000
>> [ 3000.910426] Call Trace:
>> [ 3000.910618]  <TASK>
>> [ 3000.910727]  __schedule+0x514/0xf50
>> [ 3000.910912]  schedule+0x22/0xa0
>> [ 3000.911064]  schedule_timeout+0x81/0x100
>> [ 3000.911254]  ? __pfx_process_timeout+0x10/0x10
>> [ 3000.911522]  msleep_interruptible+0x28/0x50
>> [ 3000.911754]  read_dummy_rtmutex+0x34/0x60 [hung_task_tests]
>> [ 3000.912019]  full_proxy_read+0x5b/0x90
>> [ 3000.912212]  vfs_read+0xb0/0x370
>> [ 3000.912378]  ? vm_mmap_pgoff+0xf1/0x1b0
>> [ 3000.912630]  ? vm_mmap_pgoff+0x122/0x1b0
>> [ 3000.912839]  ksys_read+0x68/0xe0
>> [ 3000.913007]  do_syscall_64+0xf9/0x540
>> [ 3000.913187]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> [ 3000.913461] RIP: 0033:0x49a182
>> [ 3000.913618] RSP: 002b:00007ffd0b4cf048 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> [ 3000.913972] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
>> [ 3000.914294] RDX: 0000000000010000 RSI: 00007fbf49a0d000 RDI: 0000000000000003
>> [ 3000.914648] RBP: 00007fbf49a0d000 R08: 00000000ffffffff R09: 0000000000000000
>> [ 3000.914955] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
>> [ 3000.915208] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
>> [ 3000.915439]  </TASK>
>>
>> ---
>> v2 changes:
>> - Reduce #ifdef-ery by using rt_mutex_task_owner() instead of adding a new blocker type,
>> suggested by Petr.
>> - Remove the unused function debug_trace_blocker(), suggested by Xusheng.
>> - Clean up and update relevant comments.
>> -https://lore.kernel.org/all/cover.1785376929.git.ruipengqi3@gmail.com/
>>
>> Ruipeng Qi (2):
>>   hung_task: show the blocker task if the task is hung on rtmutex
>>   samples: enhance hung_task detector test with rtmutex support
>>
>> include/linux/rtmutex.h             |  2 ++
>> kernel/hung_task.c                  | 26 +++++++++++++--
>> kernel/locking/rtmutex_api.c        | 29 +++++++++++++++++
>> lib/Kconfig.debug                   |  1 -
>> samples/Kconfig                     |  2 +-
>> samples/hung_task/hung_task_tests.c | 50 ++++++++++++++++++++++++++---
>> 6 files changed, 101 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.25.1
>>
>>
