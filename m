Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4583FFAD6
	for <linux-rt-devel@lists.linux.dev>; Wed,  6 May 2026 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075865; cv=none; b=dQ4bfXIRHqaX69wtC3mIyCjNlrAKXHYBcJ2dp3n/GIXW7gS7YrQo9RtnYZwi4PgWiScGsffcNZRZm+PL7kGn0T9HOQ/vBWD5eFkgMCOpdSzBt3ls67++ch9SF2vLmGO0ol6vVADVitMNRBJJBIyfK71Rbo2h2VrJPl2EmLzWiIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075865; c=relaxed/simple;
	bh=Mp+WgSWHYdKleZjS+gQsLtyvkLgTIxaCvE/kSEKBR5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tc5NlE7XUcLGUywocDpCKT70BAHqHYtoOL9Rw/hQeanlAnszG6Rs44cZLEB0sTaXM0c7xVqk6/DADHoPhe18dK6fM9Z6YE46Xtw1/lSppNVzHLeYVW0Ysu0g5p5bj7Nr2wGGGWaLPRThrjDprpWQKjMM3LDkq9cnH08m7kdfL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e63Lr1sM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e63Lr1sM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-364ef32a758so10073205a91.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 06 May 2026 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778075862; x=1778680662; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bte2ikXfMH1X30UWHnUNHKf52jg/NvhErm9OVWL82Ks=;
        b=e63Lr1sM4Z2uHU69e/wPUZvCuDF5nQOuThsa94OGYbQJFk97G3I/DWNekFkpc96wM3
         fP7IUWZgd+XW9gJ33io0mnAmCv5vXgyKyxIyYKcJurSjmJN9v0iFxbiSMU85wqzNUgpz
         n22Mlz4JQOEtU6yNeaixSMKTzMLR8lucMWvCk+s6hWcYbCq60X4BSIQ7A/BPfAk2LWda
         MQt2ubNzUpftCXkky8eYnW6rtk+c/nyaKoGh6XntWQX6N0FmiLmj5r3ivV6+T4aQCaZz
         1rTnMSLpzgaGq9zBz00MZOSYnMyatI/GJU+Jt/tNq+VzWcin630oZ4NyrqkCWwooCjrS
         Zj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075862; x=1778680662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bte2ikXfMH1X30UWHnUNHKf52jg/NvhErm9OVWL82Ks=;
        b=i5782ed6Ens+FItb9H/o5CJZmWACUqVjEoGRCHHLVkMbBNUFfdEj7qVYlmrJCDCggN
         7WkbYbrJgwg4r3+MYr/m+YaK1y6uFuuvIfBBgBBWQOjCqETmwP3gBETo780S2Cn99ccO
         dSbxieTBGjS90eVL27s7EOdNfSebIi6irv4nxFs5fGhVbAnTuOjgfW+UVJcy4f+wWQ55
         78+rxaBeBX8AUb9QP5Poyc3Tx15JZFGycYBDWSsgZddfxyOiY3IGZgRY/33LhQeTlvxF
         f6WzhH1ap47HyFiTBTwKHsJGz7LBbobktoCfagYDdVQRzn3/pZ4YGFejCxvo2XPwlWgG
         LVhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rCtOQlRivQ1U70P4PO5MBWc3wU9KyWVVB1cM9qtfz3dIVFliT1VUUxtssy6Hr7oxVxVSjlJ70LEpigWtZiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpSKmkYBujDJcql7FALG2DRisrAS+SeERQXtgPyuT1aUZZUZ+9
	Yu9jcEVo6GCMqfLpcSf5NehCd1EGKeTXpwCrEWIOr1tvs2Z3bhuKvozYdokGqMNmsoSQUQvX5gU
	EgsJU7g==
X-Received: from pgbcr4.prod.google.com ([2002:a05:6a02:4104:b0:c80:2817:3a23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4314:b0:3a2:dbaa:82ec
 with SMTP id adf61e73a8af0-3aa5aae7ab0mr3951938637.32.1778075861517; Wed, 06
 May 2026 06:57:41 -0700 (PDT)
Date: Wed, 6 May 2026 06:57:40 -0700
In-Reply-To: <69f8dd59.170a0220.bb392.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <6936812a.a70a0220.38f243.0090.GAE@google.com> <69f8dd59.170a0220.bb392.0004.GAE@google.com>
Message-ID: <aftI1Nt2PTptaUs2@google.com>
Subject: Re: [syzbot] [mm?] BUG: sleeping function called from invalid context
 in kvm_mmu_notifier_invalidate_range_start
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, dwmw@amazon.co.uk, kvm@vger.kernel.org, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, lkp@intel.com, llvm@lists.linux.dev, 
	lorenzo.stoakes@oracle.com, me@brighamcampbell.com, mhocko@suse.com, 
	oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, rientjes@google.com, 
	rppt@kernel.org, shaikhkamal2012@gmail.com, shakeel.butt@linux.dev, 
	skhan@linuxfoundation.org, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 04, 2026, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b9303e6bff70 Add linux-next specific files for 20260430
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13745dba580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5474e13c6d20d45c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125dd748580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b3a0a2e50f73/disk-b9303e6b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d3d481b220d4/vmlinux-b9303e6b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d6e012913960/bzImage-b9303e6b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48

This is a known issue:

https://lore.kernel.org/all/20260429222502.25414-1-shaikhkamal2012@gmail.com

> in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 40, name: oom_reaper
> preempt_count: 0, expected: 0
> RCU nest depth: 0, expected: 0
> 4 locks held by oom_reaper/40:
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:611 [inline]
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task_mm mm/oom_kill.c:566 [inline]
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task mm/oom_kill.c:609 [inline]
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reaper+0x2bb/0xc10 mm/oom_kill.c:650
>  #1: ffffffff8e3066c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: mmu_notifier_invalidate_range_start_nonblock include/linux/mmu_notifier.h:495 [inline]
>  #1: ffffffff8e3066c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: zap_vma_for_reaping+0x193/0x380 mm/memory.c:2119
>  #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
>  #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:294 [inline]
>  #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: mn_hlist_invalidate_range_start mm/mmu_notifier.c:515 [inline]
>  #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: __mmu_notifier_invalidate_range_start+0x5a1/0xb60 mm/mmu_notifier.c:580
>  #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
>  #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: kvm_mmu_notifier_invalidate_range_start+0x1b7/0xc00 virt/kvm/kvm_main.c:744
> CPU: 0 UID: 0 PID: 40 Comm: oom_reaper Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  __might_resched+0x329/0x480 kernel/sched/core.c:9163
>  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>  rt_spin_lock+0xc2/0x400 kernel/locking/spinlock_rt.c:57
>  spin_lock include/linux/spinlock_rt.h:45 [inline]
>  kvm_mmu_notifier_invalidate_range_start+0x1b7/0xc00 virt/kvm/kvm_main.c:744
>  mn_hlist_invalidate_range_start mm/mmu_notifier.c:525 [inline]
>  __mmu_notifier_invalidate_range_start+0x6e4/0xb60 mm/mmu_notifier.c:580
>  mmu_notifier_invalidate_range_start_nonblock include/linux/mmu_notifier.h:498 [inline]
>  zap_vma_for_reaping+0x1f7/0x380 mm/memory.c:2119
>  __oom_reap_task_mm mm/oom_kill.c:548 [inline]
>  oom_reap_task_mm mm/oom_kill.c:585 [inline]
>  oom_reap_task mm/oom_kill.c:609 [inline]
>  oom_reaper+0x51e/0xc10 mm/oom_kill.c:650
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 40, name: oom_reaper
> preempt_count: 0, expected: 0
> RCU nest depth: 0, expected: 0
> 4 locks held by oom_reaper/40:
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:611 [inline]
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task_mm mm/oom_kill.c:566 [inline]
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task mm/oom_kill.c:609 [inline]
>  #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reaper+0x2bb/0xc10 mm/oom_kill.c:650
>  #1: ffffffff8e3066c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: __mmu_notifier_invalidate_range_end+0x67/0x400 mm/mmu_notifier.c:611
>  #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: __mmu_notifier_invalidate_range_end+0x67/0x400 mm/mmu_notifier.c:611
>  #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
>  #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: kvm_mmu_notifier_invalidate_range_end+0x1d6/0x3d0 virt/kvm/kvm_main.c:814
> CPU: 0 UID: 0 PID: 40 Comm: oom_reaper Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  __might_resched+0x329/0x480 kernel/sched/core.c:9163
>  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>  rt_spin_lock+0xc2/0x400 kernel/locking/spinlock_rt.c:57
>  spin_lock include/linux/spinlock_rt.h:45 [inline]
>  kvm_mmu_notifier_invalidate_range_end+0x1d6/0x3d0 virt/kvm/kvm_main.c:814
>  mn_hlist_invalidate_end mm/mmu_notifier.c:597 [inline]
>  __mmu_notifier_invalidate_range_end+0x23b/0x400 mm/mmu_notifier.c:616
>  mmu_notifier_invalidate_range_end include/linux/mmu_notifier.h:511 [inline]
>  zap_vma_for_reaping+0x2d9/0x380 mm/memory.c:2124
>  __oom_reap_task_mm mm/oom_kill.c:548 [inline]
>  oom_reap_task_mm mm/oom_kill.c:585 [inline]
>  oom_reap_task mm/oom_kill.c:609 [inline]
>  oom_reaper+0x51e/0xc10 mm/oom_kill.c:650
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> oom_reaper: reaped process 6034 (syz.0.24), now anon-rss:0kB, file-rss:64kB, shmem-rss:0kB
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
