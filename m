Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E627175A97
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873478; cv=none; b=Os8kzNca8QnrY0FqmZU9k4CAPNpO1Nbkh/GDkf1oQ7ZCB2spFbtKqzLiPymK5EtGtdxeSlH8ASUZBXclrGwrFY5anbMFYhhQG55c7UVauTyXQVtfeJW4gE1zo3tAOwMgpHjXJ4S+6HOQ7v8jmo2PdEt722bKGAcgN3AiJNkjl64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873478; c=relaxed/simple;
	bh=GWG8+Fkc5xjGAGYyc6PWpSSDUOddYLJcJz9k8WGAfTo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cBkrDEZCogfsXQ42KKF4a91wjhYKfDvB+gaFwDbzQs5zFdivCDkEx88/pfWogW0FxqJgRFytDTY+1xHfbGu7SUCoILkzw1iTsw8KTc/z/CUmza8HLucjnWnjmeG15JYm8N5sYc0VEChPlEWfLk/io76IFx8pVHqT8xzpYsMFFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmOhXb1S; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmOhXb1S"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f710f066so3601425ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873476; x=1788478276; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ByhfPFFYRyQOKzwOCdD7VT4FkrQ9JW/PGTIdcjTJE7E=;
        b=wmOhXb1SkYqI9RzOMprI9bl4+441VPN6ci3vYMxsJ+t4snBRaxNffG/M/3DHhULRYe
         +uu3MOOgW013vpHzOcvL2fPpHShX9n7+E9HBnH+AXhWoobJdON9ZqwWdxZLvkehMUVgl
         LPZqrZezaxTjUZaJ678SbHqlGofme1qtzCufcrjQkbVBuBcwN+0uy1w0nH3bF4Fa3PfW
         lZLHcqizsbf28DIaMjjql1Klhnc4fTnQH4mYHeXtRTuKrtwLpncWtsHI2/limyWZyrr8
         TsPq+sLEazvq83raIEpIXEFUvGvF5MLCfN4EGIbx3bmd0fBFSIgSQUZ1IOvKPbYUpWNJ
         e8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873476; x=1788478276;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ByhfPFFYRyQOKzwOCdD7VT4FkrQ9JW/PGTIdcjTJE7E=;
        b=sMEiaYs4zHX1FbRuoOI7dPeeEDliO4YlZmdF2hgHNDK9RDGkluWn2RWZ/H4ka+a4fh
         GLkkQOVk8cISKXSADToOBkXosgrvQW7mzNe4+6BmhrE1zjHAMFOKzxSuiPB2/R0+fu4c
         oy5n40CZxnYnE3rmNEVRk3LO7rzdqDDn4R/kWq4MQEbQ9UkpzJGxcU4nHyBnmZ3KCTAX
         Fm/dNvCGDD7iX8uq6z6jhPxhKtb7949y1alaZeScNyTBJPjFLKKLr+EuvjrtFpTyTreb
         Ckv6YRceYZI5bTntxAfHF3KfLeEOzEoPIsLH0unzd0YHTuubb9yySR6RDFxasMmJY0Nk
         GdCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSWDXhbg9jTDojboVb4XrcSEhdnaURY+7Ix5NODFblSCfL52RgyKekKJBWr41ctmm6GDgjkE9HkgenLsCwaw==@lists.linux.dev
X-Gm-Message-State: AFuF++maLzN9xLKhyBGMPORC5lea1/z8TufLmV+qvgAULhEOUkZLlsDP
	/AG3Tw4a+dJHkimL9ZnYMiSpQM/7cguLanRa84+07nOWHDi3XBn/RaROMNME0o3ZjqXh9lJtcmW
	IP0hK34FnsxKdVg==
X-Received: from dybnj45.prod.google.com ([2002:a05:7300:d0ad:b0:322:61cd:851e])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc4:b0:2d6:f80c:6ff1 with SMTP id d9443c01a7336-2d726784320mr120542355ad.9.1787873476188;
 Thu, 27 Aug 2026 16:31:16 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:38 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-1-stevensd@google.com>
Subject: [RFC 00/10] Reclaimable kernel stacks
From: David Stevens <stevensd@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

This RFC is a different approach to reducing kernel stack usage from the
earlier dynamic kernel stack RFC [1]. This patch series aims to reduce
the cost of kernel stacks by partially reclaiming stacks of blocked
tasks when it is safe to do so.

On Android, system processes typically have 2000-3000 threads. App
processes add 1000s more threads on top of this. The number of app
processes varies based on device RAM size, but the end result is that
1-2% of system RAM is consumed by kernel stacks. However, most of these
threads spend extended periods of time blocked. As such, reclaiming
blocked kernel stacks can reduce total kernel stack memory usage by
upwards of 50% in various multi-tasking test cases.

When a task is blocked, we know exactly where the top of its stack is
and can reclaim any pages past that point. Since any accesses to that
portion of the stack are bugs like use-after-return or buffer overflow,
turning those invalid accesses into hard crashes could even be
considered a positive.

Tracking blocked state and when it is safe to reclaim a stack is done
via a series of hooks in the scheduler. The actual reclaim of stacks is
done asynchronously in a shrinker.

Once a task's stack has been reclaimed, it cannot be rescheduled until
its stack is repopulated. Although there can be a repopulation fast path
within the scheduler, reliably allocating memory to repopulate the stack
requires a fallback path that defers the repopulation and wakeup to a
workqueue context that can use GFP_KERNEL.

The primary challenge is avoiding reclaim deadlocks. If a task blocks
while holding a lock used by direct reclaim and then has its stack
reclaimed, using GFP_KERNEL to reallocate its stack risks deadlock. To
avoid this, only tasks which are known not to hold any locks upon which
reclaim depends are considered eligible for stack reclaim. Automatically
inferring this property is not feasible, so instead a new
PF_RECLAIMABLE_STACK task flag is used to annotate blocking locations
that are known safe. While annotating all safe blocking locations is not
feasible, the vast majority of userspace threads block using a fairly
small number of syscalls - futex, epoll, nanosleep, etc. The 10
annotations added in this series cover >95% of userspace threads on
Android based on my testing. Since missing annotations are leaving an
optimization on the table rather than an actual bug, other annotations
can be added later as needed.

Although reclaimable stacks will not cause reclaim to deadlock, it does
introduce a dependency on needing to allocate memory before an OOM
victim can exit, as reclaimed stacks need to be repopulated before their
tasks can run. While the OOM reaper will still be able to immediately
free the victim's mm, the freeing of non-mm memory may be delayed. This
can lead to more OOM kills. While this is not a significant concern on
Android due to the reliance on lmkd over the kernel OOM killer, it may
be a concern on other systems.

This RFC was developed primarily on 6.18 and 7.1 based kernels. I have
done fairly heavy stress testing, but it has not yet been deployed to
any production systems. If initial feedback on the RFC is somewhat
positive, I will work on deploying it to production systems for further
stability and performance testing as well as resolving the handful of
TODOs left in the RFC.

[1] https://lore.kernel.org/linux-mm/20260424191456.2679717-1-stevensd@google.com/

David Stevens (10):
  Add !MEMCG memcg_list_lru_alloc implementation
  mm/vmalloc: Skip vmallocinfo NUMA stats for VM_SPARSE
  fork: refactor vmap stack alloc/free into helpers
  mm: vmalloc: support creating aligned vm areas
  fork: allocate reclaimable stacks with VM_SPARSE
  Reclaim memory from blocked kernel stacks
  Reclaim stacks via a shrinker
  Set PF_RECLAIMABLE_STACK in various places
  x86: Enable reclaimable stacks
  arm64: Enable reclaimable stacks

 arch/Kconfig                       |  18 +
 arch/arm64/Kconfig                 |   1 +
 arch/arm64/include/asm/processor.h |   5 +
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/processor.h   |   5 +
 drivers/android/binder/thread.rs   |  14 +
 fs/eventpoll.c                     |   3 +
 fs/pipe.c                          |  28 +-
 fs/select.c                        |   3 +
 include/linux/list_lru.h           |   7 +-
 include/linux/sched.h              |  44 +-
 include/linux/sched/task_stack.h   |  23 +
 include/linux/vmalloc.h            |   2 +
 kernel/Makefile                    |   2 +
 kernel/fork.c                      | 140 +++++-
 kernel/futex/waitwake.c            |   3 +
 kernel/sched/core.c                |  18 +-
 kernel/sched/sched.h               |   3 +
 kernel/signal.c                    |  36 +-
 kernel/stack_shrinker.c            | 760 +++++++++++++++++++++++++++++
 kernel/stack_shrinker.h            |  58 +++
 kernel/time/hrtimer.c              |   3 +
 mm/vmalloc.c                       |  27 +-
 rust/kernel/task.rs                |  16 +
 24 files changed, 1175 insertions(+), 45 deletions(-)
 create mode 100644 kernel/stack_shrinker.c
 create mode 100644 kernel/stack_shrinker.h


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.55.0.897.gb25b4bd76c-goog

