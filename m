Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB46254AF4
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290361; cv=none; b=BV6MQGT8eUp6xRzXKQgerIe9ctZQuCS7aukXL7xGWDj75tysEwf/SN8xjMRvsQI0RzILu5hI6iXhWffcvdCYudcFCxYigs1FkPOL5i55kC7mehsL8mNNUVba+9BpY/1qwTjQ7njOqSkeQD4I5bhZeL44n5yhreQraI14wRTVBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290361; c=relaxed/simple;
	bh=hDHYS7nEx5Bkm+AEE5R8b+ib9+MAzF45LbY69eC3jiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OasYQ3wS+MqL0uRg+nkGD55zqphxtz4xUOESwrabjqBnJI8P9Az69fzJ/3Ou+A/P1yPz4rZ5oWJLNWAcNUp4SWFL+rVCDAzYowjBY9Y41BchSnPTd4i4L9Mx+G4Q/ABYOQZC8A2BuY4SrrThbiW5r0PW5j/NWDFTJC2YPV0UuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gti4GXk4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gti4GXk4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f0444b478so82128335ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290359; x=1739895159; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=daX5F6BLErsGmRdA+d4czlDRatekw8f/ZZ5giSpZLbo=;
        b=gti4GXk4HHrC5roR72zKQq9+VkZuvTBiPs/+1lg/VOd2WjPhhnpybnMAQ38X+wtGd9
         Z+982l2gs9LdmEWBuQ3dyQh8sjlZhEy93t2RxCdoiUdcHXQBXTCZLl+K5+vk/tWZ//Gi
         riZsTF9DXKRtyVZGl2Clb0A14Wszv3ZjsqrylwQ97tDiHoVihEl5ymZi3abUncOuLTuY
         1kz9f11tYQB4J0lzn4A5vQHAhTRfqaRx8TgpyreW9gptlT2Yp1vNv1kAWojsqK1M8BrH
         yMEKfGWnn7A5T+O5slpedpKiGpMZYEA0YepRwjcIMb0JzZKkB36ZcE04Usys0vUviMzu
         fjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290359; x=1739895159;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daX5F6BLErsGmRdA+d4czlDRatekw8f/ZZ5giSpZLbo=;
        b=I/59BCC/Ms0jsQ7f00+lL6bgA60Ke3NWUAzqFThBZk61wH74QP7oDZzhpVPmNYK3X+
         hv8BrvbMyM4xyu5VH9GWUh0fHjGoGi4iyaTzNhu09hm3FjFbqob5Lfr5RSKYtXibpq/k
         +umnlbqzyztHM6mwzTwzlgRTYO/gJsVSnR5uHEW52gz5h6DkjAo+j9TkBBwu4HCFAgHD
         1FsH4x9AEQcjWoZRaezpThDfwdGn6hbZFMfXINJtcUlk1nDF/b/Ft2s9ufZvGdk/56ja
         nuQeOh3FkIcC9vvwDoroYwEsnBZFU657C+8XLfBE+CFtcemyvwG8XuTaJopl3RFOT0wL
         qNlw==
X-Forwarded-Encrypted: i=1; AJvYcCWKG+QCxVbofD/D2PLR3CzLLh44wLYEIqu1wIod84WeWdZI2FSTrLFTgnFxXNKby8lWB/KrLqVFb/IXY9pmWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGdT8zBvHLtbEDaZrDJky/HoBQk2ivyV5Xf7N1M/OBiHZY+ubL
	xsUNy05FZ2dYD/0D5r2IzuSs3PyogRg88HTYr7OYsp7bW36eTRbv
X-Gm-Gg: ASbGncsvFdW5FEEaBGQ+3wZeDnCa22SK3xbJeWsid49FV8Es6fcOsv16g6X1pRJo97h
	uPc7Be+f5l30LvZYIOgaqSUl4ksZ5TLw6XjtLfCvtNryTIWADW6uac1E4DkseiDR6Tx4a1/nSoJ
	mfybkQ3ypYWl9UkZI/S1hwHAO+oSbYPKch7N0rAKcnY+EKhstzoJ06fQvlc/9ZOUj5UYFfoH7Ym
	vHWKhBt+NtmoGTnNTcjd3MUe9WV217QUCqjjLf94m9cqkTVodcpqJraEZQ0t8X5C8uZOfJdKHVF
	VI4C28YLbGm7/5lWEtGjQdxAQzTI
X-Google-Smtp-Source: AGHT+IHPTAj9o9mEbCeW3Pf9DAVh8c5mQANtS+g+9OsrBiine5AOVqRjpOX5jRLaQ5siurR4TY5Vnw==
X-Received: by 2002:a17:902:f68d:b0:21f:93f8:ce16 with SMTP id d9443c01a7336-21f93f8cfbbmr148092065ad.31.1739290359130;
        Tue, 11 Feb 2025 08:12:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce5dsm98494415ad.38.2025.02.11.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:12:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 11 Feb 2025 08:12:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Backtrace seen when enabling PREEMPT_RT
Message-ID: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When I tried to enable PREEMPT_RT together with various lock debugging
options, I got the attached backtraces.

This is with qemu's ne2k_pci Ethernet emulation.

Question: If I enable PREEMPT_RT tests at kerneltests.org, should I report
such issues or stop testing affected configurations (I understand that
ne2k_pci probably isn't used much nowadays).

Thanks,
Guenter

---
Build reference: v6.14-rc2-8-g3309945911b8
Compiler version: x86_64-linux-gcc (GCC) 13.3.0
Qemu version: 9.1.2 (v9.1.2-51-g94825e22f3)
...
Starting network: [   13.511263] ip (2707) used greatest stack depth: 11928 bytes left
[   13.708177] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   13.708226] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 8, name: kworker/0:0
[   13.708236] preempt_count: 0, expected: 0
[   13.708242] RCU nest depth: 6, expected: 6
[   13.708265] 14 locks held by kworker/0:0/8:
[   13.708280]  #0: ff4dd8b344e6dd38 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work+0x590/0x6d0
[   13.708568]  #1: ff5a3c8a40057e48 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1df/0x6d0
[   13.708582]  #2: ff4dd8b344fbc620 (&idev->mc_lock){+.+.}-{4:4}, at: mld_ifc_work+0x32/0x560
[   13.708595]  #3: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: mld_sendpack+0x73/0x380
[   13.708616]  #4: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: ip6_finish_output2+0xe0/0xb80
[   13.708629]  #5: ff4dd8b3bf61c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
[   13.708653]  #6: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
[   13.708669]  #7: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xab/0x180
[   13.708682]  #8: ffffffff90806ee0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x71/0x13b0
[   13.708694]  #9: ff4dd8b34566c398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0x1061/0x13b0
[   13.708705]  #10: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x52/0xc0
[   13.708717]  #11: ff4dd8b344c66f58 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x113/0x2b0
[   13.708737]  #12: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
[   13.708752]  #13: ff4dd8b344c14e40 (&ei_local->page_lock){+.+.}-{3:3}, at: ei_start_xmit+0xb5/0x470
[   13.708793] irq event stamp: 198329
[   13.708799] hardirqs last  enabled at (198328): [<ffffffff8fa1fb36>] _raw_spin_unlock_irqrestore+0x46/0x70
[   13.708808] hardirqs last disabled at (198329): [<ffffffff8f31d897>] ei_start_xmit+0x2a7/0x470
[   13.708816] softirqs last  enabled at (198304): [<ffffffff8e49a5ca>] __local_bh_enable_ip+0x11a/0x160
[   13.708824] softirqs last disabled at (198310): [<ffffffff8f5f1551>] __dev_queue_xmit+0x71/0x13b0
[   13.709017] CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Tainted: G                 N 6.14.0-rc2-00008-g3309945911b8 #1
[   13.709056] Tainted: [N]=TEST
[   13.709063] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   13.709129] Workqueue: mld mld_ifc_work
[   13.709214] Call Trace:
[   13.709249]  <TASK>
[   13.709292]  dump_stack_lvl+0x78/0xe0
[   13.709331]  __might_resched+0x152/0x210
[   13.709353]  rt_spin_lock+0x5b/0x170
[   13.709363]  ? ei_start_xmit+0xb5/0x470
[   13.709371]  ? __disable_irq_nosync+0x5b/0x90
[   13.709386]  ei_start_xmit+0xb5/0x470
[   13.709390]  ? lock_acquire.part.0+0x9a/0x220
[   13.709444]  dev_hard_start_xmit+0x47/0x260
[   13.709475]  sch_direct_xmit+0x91/0x2b0
[   13.709504]  __dev_queue_xmit+0x10e3/0x13b0
[   13.709524]  ? lock_acquire.part.0+0x9a/0x220
[   13.709534]  ? find_held_lock+0x2b/0x80
[   13.709557]  ? mark_held_locks+0x40/0x70
[   13.709571]  ? eth_header+0x25/0xb0
[   13.709608]  ip6_finish_output2+0x246/0xb80
[   13.709638]  ? ip6_mtu+0x9a/0x190
[   13.709671]  mld_sendpack+0x1bb/0x380
[   13.709734]  mld_ifc_work+0x22f/0x560
[   13.709762]  process_one_work+0x220/0x6d0
[   13.709812]  worker_thread+0x18c/0x320
[   13.709829]  ? __pfx_worker_thread+0x10/0x10
[   13.709836]  kthread+0xfe/0x220
[   13.709854]  ? __pfx_kthread+0x10/0x10
[   13.709871]  ret_from_fork+0x2f/0x50
[   13.709878]  ? __pfx_kthread+0x10/0x10
[   13.709889]  ret_from_fork_asm+0x1a/0x30
[   13.709969]  </TASK>
udhcpc: started, v1.36.1
udhcpc: broadcasting discover
udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
deleting routers
adding dns 10.0.2.3
OK
Found console ttyS0
Linux version 6.14.0-rc2-00008-g3309945911b8 (groeck@server.roeck-us.net) (x86_64-linux-gcc (GCC) 13.3.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_RT Tue Feb 11 07:24:33 PST 2025
Network interface test passed
TPM selftest failed
File system test skipped
Boot successful.
[   15.502550] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   15.502593] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 112, name: kworker/u16:4
[   15.502599] preempt_count: 0, expected: 0
[   15.502602] RCU nest depth: 6, expected: 6
[   15.502606] 15 locks held by kworker/u16:4/112:
[   15.502611]  #0: ff4dd8b344f91138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x590/0x6d0
[   15.502660]  #1: ff5a3c8a403efe48 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1df/0x6d0
[   15.502676]  #2: ffffffff909b1a98 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x74/0x690
[   15.502693]  #3: ff4dd8b344fbc620 (&idev->mc_lock){+.+.}-{4:4}, at: ipv6_mc_dad_complete+0x1a/0xe0
[   15.502709]  #4: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: mld_sendpack+0x73/0x380
[   15.502724]  #5: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: ip6_finish_output2+0xe0/0xb80
[   15.502740]  #6: ff4dd8b3bf61c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
[   15.502756]  #7: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
[   15.502772]  #8: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xab/0x180
[   15.502787]  #9: ffffffff90806ee0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x71/0x13b0
[   15.502801]  #10: ff4dd8b34566c398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0x1061/0x13b0
[   15.502815]  #11: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x52/0xc0
[   15.502829]  #12: ff4dd8b344c66f58 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x113/0x2b0
[   15.502847]  #13: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
[   15.502861]  #14: ff4dd8b344c14e40 (&ei_local->page_lock){+.+.}-{3:3}, at: ei_start_xmit+0xb5/0x470
[   15.502878] irq event stamp: 7561
[   15.502881] hardirqs last  enabled at (7560): [<ffffffff8fa1fb36>] _raw_spin_unlock_irqrestore+0x46/0x70
[   15.502889] hardirqs last disabled at (7561): [<ffffffff8f31d897>] ei_start_xmit+0x2a7/0x470
[   15.502895] softirqs last  enabled at (7538): [<ffffffff8e49a5ca>] __local_bh_enable_ip+0x11a/0x160
[   15.502901] softirqs last disabled at (7544): [<ffffffff8f5f1551>] __dev_queue_xmit+0x71/0x13b0
[   15.502916] CPU: 0 UID: 0 PID: 112 Comm: kworker/u16:4 Tainted: G        W        N 6.14.0-rc2-00008-g3309945911b8 #1
[   15.502929] Tainted: [W]=WARN, [N]=TEST
[   15.502931] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   15.502940] Workqueue: ipv6_addrconf addrconf_dad_work
[   15.502951] Call Trace:
[   15.502956]  <TASK>
[   15.502969]  dump_stack_lvl+0x78/0xe0
[   15.502982]  __might_resched+0x152/0x210
[   15.503009]  rt_spin_lock+0x5b/0x170
[   15.503015]  ? ei_start_xmit+0xb5/0x470
[   15.503024]  ? __disable_irq_nosync+0x5b/0x90
[   15.503042]  ei_start_xmit+0xb5/0x470
[   15.503048]  ? lock_acquire.part.0+0x9a/0x220
[   15.503116]  dev_hard_start_xmit+0x47/0x260
[   15.503154]  sch_direct_xmit+0x91/0x2b0
[   15.503191]  __dev_queue_xmit+0x10e3/0x13b0
[   15.503241]  ? lock_acquire.part.0+0x9a/0x220
[   15.503254]  ? find_held_lock+0x2b/0x80
[   15.503282]  ? mark_held_locks+0x40/0x70
[   15.503322]  ip6_finish_output2+0x38e/0xb80
[   15.503360]  ? ip6_mtu+0x9a/0x190
[   15.503400]  mld_sendpack+0x1bb/0x380
[   15.503479]  ipv6_mc_dad_complete+0xba/0xe0
[   15.503492]  addrconf_dad_completed+0x388/0x440
[   15.503498]  ? addrconf_dad_work+0x220/0x690
[   15.503543]  ? addrconf_dad_work+0x220/0x690
[   15.503552]  ? addrconf_dad_work+0x328/0x690
[   15.503562]  addrconf_dad_work+0x328/0x690
[   15.503587]  ? lock_acquire+0x33/0x80
[   15.503592]  ? process_one_work+0x1df/0x6d0
[   15.503628]  process_one_work+0x220/0x6d0
[   15.503691]  worker_thread+0x18c/0x320
[   15.503712]  ? __pfx_worker_thread+0x10/0x10
[   15.503721]  kthread+0xfe/0x220
[   15.503744]  ? __pfx_kthread+0x10/0x10
[   15.503765]  ret_from_fork+0x2f/0x50
[   15.503772]  ? __pfx_kthread+0x10/0x10
[   15.503786]  ret_from_fork_asm+0x1a/0x30
[   15.503873]  </TASK>
Rebooting
[   30.831707] ACPI: PM: Preparing to enter system sleep state S5
[   30.836459] reboot: Restarting system
[   30.836571] reboot: machine restart
------------
Skipping x86_64:q35:Icelake-Server:defconfig:rt:smp8:net=i82557a:mem4G:nvme:fstest=gfs2:btrfs ... 
Skipping x86_64:q35:Skylake-Client-IBRS:defconfig:rt:smp2:net=i82558b:efi32:mem1G:sdhci-mmc:ext2 ... 
Skipping x86_64:q35:KnightsMill:defconfig:rt:smp6:net=i82550:mem512:ata:fstest=minix:ext2 ... 
Skipping x86_64:pc:Opteron_G3:defconfig:nosmp:net=e1000:mem1G:usb:ext2 ... 
Skipping x86_64:q35:Opteron_G4:defconfig:nosmp:net=ne2k_pci:efi:mem512:ata:fstest=hfs+:ext2 ... 
Skipping x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net=pcnet:efi32:mem2G:ata:ext2 ... 

