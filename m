Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2CB3E317A
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917276; cv=none; b=pLEd/pJC5FpSY6XiQ5ooIz68tUzSgA3xQcpqD+YckDBppnrCtFibRc4bDH2d+sZuy/LpzGxN6/ZT2jugjJMNEeOsM2/8gF08gVmPPJLwWtu7mHZo7mY64mgIQNupTidV5UdF2XKykoF5plziFAZH1i/ecz2c+eP5y7/M5Z5tJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917276; c=relaxed/simple;
	bh=N3OJlCmNm5ZFq7j1A2SYJQW6LfmovEqwcV0g/6bRjFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o0X6VDaDffscSwpyC0p4hudPi4vz46jMZesGxws9Di6YoH8K27C+YgcaVT+rew/gXIRwL9k8aLRxkAM8ObrQsqTGLBCtmyB40g9z+Zo8+rdGwOqJ944YqR1S/FwioE3XbK5/f2aKN188VQDWcLMt/o2/Z9ILfRbWpTZIx3Hb3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7de75c9be4aso10209379a34.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 04 May 2026 10:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917274; x=1778522074;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf1acHnuMkvLtJHbgF3Z56jQ1gcWmSXrdwsWfpDSszg=;
        b=lqaCMGK5/f+mgWymkMtenmqdcsTPBSUjP0dgKww9ijGuBF6p66FubgVpcCkqoxeOL2
         1xyehm0hd/BlpKxx2gGm22g3pBEByIO89SwG2TeUfIEwayCP92v9t4a5W7hl5gHZSj9V
         OyVQW/amRHWXBlF9hBguaG4JXgaXaiTYgPQi2E3PcYKAIOu47jxGQE0mdGgVyRoeULui
         pGILTDlij0vsTJnw9ld/yyOVTyMs0gDdOnCA/znTiin7M485eacU0d13ns2UpotMx7CD
         B95sq/3owDm3e49DBaSIDxRCNzmijBIOVyLcbTfcSEIYoZ/OrYK1jbkqUgDS6eGiNG6J
         WiiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xsleplVs25F7QZXWHtEL+tuDmMA4eH7lQ3A+kUb0z6kkCCF6SlmGHfH32aQstUgfBVXTUBUbPsm68vOIFpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9iBrBmuFBJmitQOa6OG6sI704OxwWYt0BLYVPerkc/jn9VbBw
	eJVF+xgK7U37gcSb/l67VHPPGLDnACxExFjP/XrwDEKA05B7tZ7kMRuCKNSS/mH0B/4IJg09mYq
	rxRaNwQ9bLal7o36hdiXyY21iwp+weFU3imkaezd2qbXAQV7FaIIik3f/2pA=
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f022:b0:68a:e01a:9b99 with SMTP id
 006d021491bc7-69697df9a6cmr5304663eaf.50.1777917273794; Mon, 04 May 2026
 10:54:33 -0700 (PDT)
Date: Mon, 04 May 2026 10:54:33 -0700
In-Reply-To: <6936812a.a70a0220.38f243.0090.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f8dd59.170a0220.bb392.0004.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: sleeping function called from invalid context
 in kvm_mmu_notifier_invalidate_range_start
From: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dwmw@amazon.co.uk, kvm@vger.kernel.org, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, lkp@intel.com, llvm@lists.linux.dev, 
	lorenzo.stoakes@oracle.com, me@brighamcampbell.com, mhocko@suse.com, 
	oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, rientjes@google.com, 
	rppt@kernel.org, seanjc@google.com, shaikhkamal2012@gmail.com, 
	shakeel.butt@linux.dev, skhan@linuxfoundation.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b9303e6bff70 Add linux-next specific files for 20260430
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13745dba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5474e13c6d20d45c
dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125dd748580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b3a0a2e50f73/disk-b9303e6b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3d481b220d4/vmlinux-b9303e6b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6e012913960/bzImage-b9303e6b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 40, name: oom_reaper
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by oom_reaper/40:
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:611 [inline]
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task_mm mm/oom_kill.c:566 [inline]
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task mm/oom_kill.c:609 [inline]
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reaper+0x2bb/0xc10 mm/oom_kill.c:650
 #1: ffffffff8e3066c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: mmu_notifier_invalidate_range_start_nonblock include/linux/mmu_notifier.h:495 [inline]
 #1: ffffffff8e3066c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: zap_vma_for_reaping+0x193/0x380 mm/memory.c:2119
 #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:294 [inline]
 #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: mn_hlist_invalidate_range_start mm/mmu_notifier.c:515 [inline]
 #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: __mmu_notifier_invalidate_range_start+0x5a1/0xb60 mm/mmu_notifier.c:580
 #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: kvm_mmu_notifier_invalidate_range_start+0x1b7/0xc00 virt/kvm/kvm_main.c:744
CPU: 0 UID: 0 PID: 40 Comm: oom_reaper Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:9163
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc2/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 kvm_mmu_notifier_invalidate_range_start+0x1b7/0xc00 virt/kvm/kvm_main.c:744
 mn_hlist_invalidate_range_start mm/mmu_notifier.c:525 [inline]
 __mmu_notifier_invalidate_range_start+0x6e4/0xb60 mm/mmu_notifier.c:580
 mmu_notifier_invalidate_range_start_nonblock include/linux/mmu_notifier.h:498 [inline]
 zap_vma_for_reaping+0x1f7/0x380 mm/memory.c:2119
 __oom_reap_task_mm mm/oom_kill.c:548 [inline]
 oom_reap_task_mm mm/oom_kill.c:585 [inline]
 oom_reap_task mm/oom_kill.c:609 [inline]
 oom_reaper+0x51e/0xc10 mm/oom_kill.c:650
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 40, name: oom_reaper
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by oom_reaper/40:
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:611 [inline]
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task_mm mm/oom_kill.c:566 [inline]
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reap_task mm/oom_kill.c:609 [inline]
 #0: ffff8880335ed1b0 (&mm->mmap_lock){++++}-{4:4}, at: oom_reaper+0x2bb/0xc10 mm/oom_kill.c:650
 #1: ffffffff8e3066c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: __mmu_notifier_invalidate_range_end+0x67/0x400 mm/mmu_notifier.c:611
 #2: ffffffff8e306718 (srcu){.+.+}-{0:0}, at: __mmu_notifier_invalidate_range_end+0x67/0x400 mm/mmu_notifier.c:611
 #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #3: ffff88803996caf8 (&kvm->mn_invalidate_lock){+.+.}-{3:3}, at: kvm_mmu_notifier_invalidate_range_end+0x1d6/0x3d0 virt/kvm/kvm_main.c:814
CPU: 0 UID: 0 PID: 40 Comm: oom_reaper Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:9163
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc2/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 kvm_mmu_notifier_invalidate_range_end+0x1d6/0x3d0 virt/kvm/kvm_main.c:814
 mn_hlist_invalidate_end mm/mmu_notifier.c:597 [inline]
 __mmu_notifier_invalidate_range_end+0x23b/0x400 mm/mmu_notifier.c:616
 mmu_notifier_invalidate_range_end include/linux/mmu_notifier.h:511 [inline]
 zap_vma_for_reaping+0x2d9/0x380 mm/memory.c:2124
 __oom_reap_task_mm mm/oom_kill.c:548 [inline]
 oom_reap_task_mm mm/oom_kill.c:585 [inline]
 oom_reap_task mm/oom_kill.c:609 [inline]
 oom_reaper+0x51e/0xc10 mm/oom_kill.c:650
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
oom_reaper: reaped process 6034 (syz.0.24), now anon-rss:0kB, file-rss:64kB, shmem-rss:0kB


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
