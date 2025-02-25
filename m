Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8138DE0
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458997; cv=none; b=HR0GE2JZe/whSW3Eo+KirbRqOPBudRWDjQhl4XwxsnWwhrG4C2XdoAkfkMssYfuuiFHUCkqqk8cTcnzTJdnB8NNWTFzKap8m8DEqrdUrMqkvrpiYMdZOkbVTMjD2YNMs4EEBWafrlT1I0Qqdi8l4spmbGetdNaOJNx61ZtWwPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458997; c=relaxed/simple;
	bh=+uFmWw8gGci37xxeXCvpUX0UrpicG+M3kOFG3hZAxeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TjpsZH6qUF6n2LiKHr9BngAOZMvSx4Y2Jebp/8uBMROAKo9fxrmki7Xb8if+j11WrC3Q22H0dCry72P8/GY0FDrU2P+BGCt/cV3vwykg6K9Yy4wo92roMRlfFyPDdu58NE4POmuHEph1S3oAkQL06po3mX+WkvNhJd5qJDPuheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyhxDk20; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyhxDk20"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so10549582a91.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 20:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740458994; x=1741063794; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WML36qDnvVIElwQTHGuCgsMTY/0nIzeEJEz0+6vOdX4=;
        b=lyhxDk20fJU4RiQS3mwID9FeWIgFUNf4Pb3abVx2Y3FY665zfV+QR+msUvO+SBDHhk
         OnQZeBLHDFnuBD2aUiNUaYo224fQBPjykTbn1gHGhQtg2vRcw/d1RSpyKf/K5B8dM/GM
         NSocxVJxVHTx2VljvwRpIQXW28pR0/oEGqkdn2E/0vDZ5pE94Q41ISxVrQuMefZ42ZRR
         PTQVCUNr2FcwHipVQ7t8UMqUsI0LfS6N6FLHtqVWWtEy6uBAwPIe59s5xMTbH1TFcA7d
         pGAPQUHDZYbVRs9DdTsrCcVdcoANnGmga6DV4pjS5XM5/IVoBX9mEM8UcLNe6HiDxhAa
         KeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740458994; x=1741063794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WML36qDnvVIElwQTHGuCgsMTY/0nIzeEJEz0+6vOdX4=;
        b=TfhOxnIorSbBeR4Ju8LXoTnpc5kqqCPW4a2P32NoDyylSgyk9Dkv9WBzhuMOf1aADu
         I4WSGYyHpExuO7sMFEgoXyGQjffgstonqZiB/Ds7p1BuJVQnHZGtLJ6VRpyq3DJ16F8R
         eHmv3M+KOxVi/GjAlTOwNLOTsLNnz1i/jRyh5K87DUdHXRTIcnt9+52V28cQhw79tGvU
         WL/ozWCMoQ8k5G1sPAghn9GNw6vdrEdEpcWybffrPfeM/LLqHU8LCbgYxyjJfJeGBqG3
         0IPaUsMd4DgTBmk0hPj6sLSpHhS+3Ndt6apP9186oaJycHaSdPywniyejpppgTeY7ta4
         MCbw==
X-Gm-Message-State: AOJu0Yz0GMxgjIhq/J/XPx28pbtKMcVVrTJhDbZ4FZcUqj/IZYC4+csk
	STqOuvpc+0XzhPsvzpbF1c+oZFPvocruQxEy+asRhWE3iqlIN3+ie8RyXg==
X-Gm-Gg: ASbGncuar/7b6Yx2BRimeDFVeKHndPoqIvHcCoyQD94hoM/aU96CJbkFPn4D7LVyRO8
	e6ykkeop9HmO+AVkJg6PqjfiqAva4PKiGUzOOYNplaNLf4USd/ob67ZldHtdt7PW9jo4QHiZyn2
	PYypPfOzx9XEb+8woC6tHxXZwW/4Pnq3hCtEOuRDnnje7mvj/39ciISmV+UCxVnaiP5E6m7aVJ6
	ADATbJZUHQrXGPpmIXmWVp/7YgKzSRE0leMGFOUi2m5BlfsXSDk2bxUFaJaETfZoxVCJAUb3u3n
	Bk6BXwBuIjUSj8S/4EDPWYuLXplm9Gw8kY+bzEQ=
X-Google-Smtp-Source: AGHT+IGQsost//w9iINOZqYLlJjsshHfV9M1g0drfjoD1LocJcQmOgv6mwZQ54xNm7R570PC7PmU7w==
X-Received: by 2002:a17:90a:da87:b0:2fa:1e3e:9be0 with SMTP id 98e67ed59e1d1-2fce78c9247mr24535481a91.19.1740458994114;
        Mon, 24 Feb 2025 20:49:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a43cd99sm537372a91.35.2025.02.24.20.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 20:49:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 24 Feb 2025 20:49:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: linux-rt-devel@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Possible circular locking warning in Cadence macb driver when
 enabling PREEMPT_RT
Message-ID: <5d31bebf-c377-4530-9f78-c9a440133383@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I found another circular locking dependency warning when enabling
PREEMPT_RT, this time in the Cadence macb driver. The warning is reported
for aarch64 (xlnx-versal-virt) and riscv64 (sifive_u), in both cases with
the default Ethernet interface supported by qemu.

Backtraces, both raw and decoded, are attached below. Please let me know
if there is anything I can help to fix the problem.

Thanks,
Guenter

---
Starting network: [   24.451016] macb ff0c0000.ethernet eth0: configuring for fixed/rgmii-id link mode
[   24.512338] macb ff0c0000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
udhcpc: started, v1.36.1
udhcpc: broadcasting discover
[   24.788698] 
[   24.788735] ======================================================
[   24.788744] WARNING: possible circular locking dependency detected
[   24.788882] 6.14.0-rc3-00012-g2408a807bfc3 #1 Tainted: G                 N
[   24.788934] ------------------------------------------------------
[   24.788939] udhcpc/2642 is trying to acquire lock:
[   24.788977] ffff000007db7560 (&bp->lock){+.+.}-{3:3}, at: macb_start_xmit+0xb34/0xc98
[   24.789558] 
[   24.789558] but task is already holding lock:
[   24.789562] ffff000007db5370 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit+0x298/0xc98
[   24.789588] 
[   24.789588] which lock already depends on the new lock.
[   24.789588] 
[   24.789592] 
[   24.789592] the existing dependency chain (in reverse order) is:
[   24.789605] 
[   24.789605] -> #3 (&queue->tx_ptr_lock){+...}-{3:3}:
[   24.789647]        rt_spin_lock+0x54/0x1a0
[   24.789678]        macb_start_xmit+0x298/0xc98
[   24.789684]        dev_hard_start_xmit+0xb8/0x2d4
[   24.789693]        sch_direct_xmit+0x8c/0x37c
[   24.789701]        __dev_queue_xmit+0xef4/0x1200
[   24.789708]        packet_xmit+0xc0/0x13c
[   24.789716]        packet_sendmsg+0x8d8/0x133c
[   24.789723]        __sock_sendmsg+0x5c/0xac
[   24.789730]        __sys_sendto+0x118/0x184
[   24.789737]        __arm64_sys_sendto+0x28/0x38
[   24.789743]        invoke_syscall+0x48/0x10c
[   24.789753]        el0_svc_common.constprop.0+0x40/0xe0
[   24.789761]        do_el0_svc+0x1c/0x28
[   24.789768]        el0_svc+0x48/0x110
[   24.789775]        el0t_64_sync_handler+0x10c/0x138
[   24.789782]        el0t_64_sync+0x198/0x19c
[   24.789810] 
[   24.789810] -> #2 (_xmit_ETHER#2){+...}-{3:3}:
[   24.789828]        rt_spin_lock+0x54/0x1a0
[   24.789834]        sch_direct_xmit+0x11c/0x37c
[   24.789841]        __dev_queue_xmit+0xef4/0x1200
[   24.789847]        packet_xmit+0xc0/0x13c
[   24.789853]        packet_sendmsg+0x8d8/0x133c
[   24.789860]        __sock_sendmsg+0x5c/0xac
[   24.789866]        __sys_sendto+0x118/0x184
[   24.789873]        __arm64_sys_sendto+0x28/0x38
[   24.789879]        invoke_syscall+0x48/0x10c
[   24.789886]        el0_svc_common.constprop.0+0x40/0xe0
[   24.789893]        do_el0_svc+0x1c/0x28
[   24.789900]        el0_svc+0x48/0x110
[   24.789906]        el0t_64_sync_handler+0x10c/0x138
[   24.789912]        el0t_64_sync+0x198/0x19c
[   24.789923] 
[   24.789923] -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
[   24.789935]        rt_spin_lock+0x54/0x1a0
[   24.789941]        __local_bh_disable_ip+0x154/0x1e0
[   24.789949]        __netdev_alloc_skb+0x160/0x1e4
[   24.789957]        gem_rx_refill+0x114/0x278
[   24.789963]        gem_init_rings+0xd4/0x130
[   24.789969]        macb_mac_link_up+0x9c/0x2b0
[   24.789976]        phylink_resolve+0x150/0x5cc
[   24.789983]        process_one_work+0x234/0x658
[   24.789991]        worker_thread+0x1b8/0x354
[   24.789997]        kthread+0x13c/0x22c
[   24.790004]        ret_from_fork+0x10/0x20
[   24.790010] 
[   24.790010] -> #0 (&bp->lock){+.+.}-{3:3}:
[   24.790022]        __lock_acquire+0x1534/0x2064
[   24.790031]        lock_acquire+0x1cc/0x350
[   24.790038]        rt_spin_lock+0x54/0x1a0
[   24.790044]        macb_start_xmit+0xb34/0xc98
[   24.790050]        dev_hard_start_xmit+0xb8/0x2d4
[   24.790057]        sch_direct_xmit+0x8c/0x37c
[   24.790063]        __dev_queue_xmit+0xef4/0x1200
[   24.790069]        packet_xmit+0xc0/0x13c
[   24.790076]        packet_sendmsg+0x8d8/0x133c
[   24.790082]        __sock_sendmsg+0x5c/0xac
[   24.790088]        __sys_sendto+0x118/0x184
[   24.790095]        __arm64_sys_sendto+0x28/0x38
[   24.790101]        invoke_syscall+0x48/0x10c
[   24.790108]        el0_svc_common.constprop.0+0x40/0xe0
[   24.790116]        do_el0_svc+0x1c/0x28
[   24.790123]        el0_svc+0x48/0x110
[   24.790129]        el0t_64_sync_handler+0x10c/0x138
[   24.790135]        el0t_64_sync+0x198/0x19c
[   24.790142] 
[   24.790142] other info that might help us debug this:
[   24.790142] 
[   24.790165] Chain exists of:
[   24.790165]   &bp->lock --> _xmit_ETHER#2 --> &queue->tx_ptr_lock
[   24.790165] 
[   24.790196]  Possible unsafe locking scenario:
[   24.790196] 
[   24.790199]        CPU0                    CPU1
[   24.790203]        ----                    ----
[   24.790209]   lock(&queue->tx_ptr_lock);
[   24.790221]                                lock(_xmit_ETHER#2);
[   24.790235]                                lock(&queue->tx_ptr_lock);
[   24.790251]   lock(&bp->lock);
[   24.790265] 
[   24.790265]  *** DEADLOCK ***
[   24.790265] 
[   24.790280] 10 locks held by udhcpc/2642:
[   24.790294]  #0: ffff00001fcbc278 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x154/0x1e0
[   24.790321]  #1: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xe8/0x1a0
[   24.790349]  #2: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x138/0x1e0
[   24.790368]  #3: ffff8000837b1740 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x64/0x1200
[   24.790386]  #4: ffff000007fe1398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0xe64/0x1200
[   24.790405]  #5: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x40/0xfc
[   24.790423]  #6: ffff0000052ec318 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x11c/0x37c
[   24.790443]  #7: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xe8/0x1a0
[   24.790461]  #8: ffff000007db5370 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit+0x298/0xc98
[   24.790480]  #9: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xe8/0x1a0
[   24.790503] 
[   24.790503] stack backtrace:
[   24.790588] CPU: 1 UID: 0 PID: 2642 Comm: udhcpc Tainted: G                 N 6.14.0-rc3-00012-g2408a807bfc3 #1
[   24.790625] Tainted: [N]=TEST
[   24.790634] Hardware name: Xilinx Versal Virtual development board (DT)
[   24.790730] Call trace:
[   24.790799]  show_stack+0x18/0x24 (C)
[   24.790850]  dump_stack_lvl+0xa0/0xf0
[   24.790863]  dump_stack+0x18/0x24
[   24.790869]  print_circular_bug+0x28c/0x370
[   24.790879]  check_noncircular+0x198/0x1ac
[   24.790887]  __lock_acquire+0x1534/0x2064
[   24.790895]  lock_acquire+0x1cc/0x350
[   24.790902]  rt_spin_lock+0x54/0x1a0
[   24.790909]  macb_start_xmit+0xb34/0xc98
[   24.790916]  dev_hard_start_xmit+0xb8/0x2d4
[   24.790924]  sch_direct_xmit+0x8c/0x37c
[   24.790931]  __dev_queue_xmit+0xef4/0x1200
[   24.790938]  packet_xmit+0xc0/0x13c
[   24.790945]  packet_sendmsg+0x8d8/0x133c
[   24.790953]  __sock_sendmsg+0x5c/0xac
[   24.790960]  __sys_sendto+0x118/0x184
[   24.790967]  __arm64_sys_sendto+0x28/0x38
[   24.790975]  invoke_syscall+0x48/0x10c
[   24.790983]  el0_svc_common.constprop.0+0x40/0xe0
[   24.790996]  do_el0_svc+0x1c/0x28
[   24.791004]  el0_svc+0x48/0x110
[   24.791011]  el0t_64_sync_handler+0x10c/0x138
[   24.791018]  el0t_64_sync+0x198/0x19c
udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400

---
Starting network: [   24.451016] macb ff0c0000.ethernet eth0: configuring for fixed/rgmii-id link mode
[   24.512338] macb ff0c0000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
udhcpc: started, v1.36.1
udhcpc: broadcasting discover
[   24.788698]
[   24.788735] ======================================================
[   24.788744] WARNING: possible circular locking dependency detected
[   24.788882] 6.14.0-rc3-00012-g2408a807bfc3 #1 Tainted: G                 N
[   24.788934] ------------------------------------------------------
[   24.788939] udhcpc/2642 is trying to acquire lock:
[   24.788977] ffff000007db7560 (&bp->lock){+.+.}-{3:3}, at: macb_start_xmit (drivers/net/ethernet/cadence/macb_main.c:2391) 
[   24.789558]
[   24.789558] but task is already holding lock:
[   24.789562] ffff000007db5370 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit (drivers/net/ethernet/cadence/macb_main.c:2371) 
[   24.789588]
[   24.789588] which lock already depends on the new lock.
[   24.789588]
[   24.789592]
[   24.789592] the existing dependency chain (in reverse order) is:
[   24.789605]
[   24.789605] -> #3 (&queue->tx_ptr_lock){+...}-{3:3}:
[   24.789647] rt_spin_lock (kernel/locking/spinlock_rt.c:48 (discriminator 1) kernel/locking/spinlock_rt.c:57 (discriminator 1)) 
[   24.789678] macb_start_xmit (drivers/net/ethernet/cadence/macb_main.c:2371) 
[   24.789684] dev_hard_start_xmit (include/linux/netdevice.h:5150 include/linux/netdevice.h:5159 net/core/dev.c:3735 net/core/dev.c:3751) 
[   24.789693] sch_direct_xmit (net/sched/sch_generic.c:343) 
[   24.789701] __dev_queue_xmit (net/core/dev.c:3974 (discriminator 1) net/core/dev.c:4550 (discriminator 1)) 
[   24.789708] packet_xmit (include/linux/netdevice.h:3311 net/packet/af_packet.c:276) 
[   24.789716] packet_sendmsg (net/packet/af_packet.c:3132 (discriminator 1) net/packet/af_packet.c:3164 (discriminator 1)) 
[   24.789723] __sock_sendmsg (net/socket.c:718 (discriminator 1) net/socket.c:733 (discriminator 1)) 
[   24.789730] __sys_sendto (net/socket.c:2187) 
[   24.789737] __arm64_sys_sendto (net/socket.c:2190) 
[   24.789743] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:54) 
[   24.789753] el0_svc_common.constprop.0 (include/linux/thread_info.h:135 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)) 
[   24.789761] do_el0_svc (arch/arm64/kernel/syscall.c:152) 
[   24.789768] el0_svc (arch/arm64/include/asm/irqflags.h:82 (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1) arch/arm64/kernel/entry-common.c:745 (discriminator 1)) 
[   24.789775] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:763) 
[   24.789782] el0t_64_sync (arch/arm64/kernel/entry.S:600) 
[   24.789810]
[   24.789810] -> #2 (_xmit_ETHER#2){+...}-{3:3}:
[   24.789828] rt_spin_lock (kernel/locking/spinlock_rt.c:48 (discriminator 1) kernel/locking/spinlock_rt.c:57 (discriminator 1)) 
[   24.789834] sch_direct_xmit (include/linux/netdevice.h:4592 (discriminator 2) net/sched/sch_generic.c:341 (discriminator 2)) 
[   24.789841] __dev_queue_xmit (net/core/dev.c:3974 (discriminator 1) net/core/dev.c:4550 (discriminator 1)) 
[   24.789847] packet_xmit (include/linux/netdevice.h:3311 net/packet/af_packet.c:276) 
[   24.789853] packet_sendmsg (net/packet/af_packet.c:3132 (discriminator 1) net/packet/af_packet.c:3164 (discriminator 1)) 
[   24.789860] __sock_sendmsg (net/socket.c:718 (discriminator 1) net/socket.c:733 (discriminator 1)) 
[   24.789866] __sys_sendto (net/socket.c:2187) 
[   24.789873] __arm64_sys_sendto (net/socket.c:2190) 
[   24.789879] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:54) 
[   24.789886] el0_svc_common.constprop.0 (include/linux/thread_info.h:135 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)) 
[   24.789893] do_el0_svc (arch/arm64/kernel/syscall.c:152) 
[   24.789900] el0_svc (arch/arm64/include/asm/irqflags.h:82 (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1) arch/arm64/kernel/entry-common.c:745 (discriminator 1)) 
[   24.789906] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:763) 
[   24.789912] el0t_64_sync (arch/arm64/kernel/entry.S:600) 
[   24.789923]
[   24.789923] -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
[   24.789935] rt_spin_lock (kernel/locking/spinlock_rt.c:48 (discriminator 1) kernel/locking/spinlock_rt.c:57 (discriminator 1)) 
[   24.789941] __local_bh_disable_ip (include/linux/rcupdate.h:847 kernel/softirq.c:156) 
[   24.789949] __netdev_alloc_skb (net/core/skbuff.c:759) 
[   24.789957] gem_rx_refill (include/linux/skbuff.h:3410 drivers/net/ethernet/cadence/macb_main.c:1317) 
[   24.789963] gem_init_rings (drivers/net/ethernet/cadence/macb_main.c:2608 (discriminator 1)) 
[   24.789969] macb_mac_link_up (drivers/net/ethernet/cadence/macb_main.c:754) 
[   24.789976] phylink_resolve (drivers/net/phy/phylink.c:1675 drivers/net/phy/phylink.c:1803) 
[   24.789983] process_one_work (kernel/workqueue.c:3241) 
[   24.789991] worker_thread (kernel/workqueue.c:3311 (discriminator 2) kernel/workqueue.c:3398 (discriminator 2)) 
[   24.789997] kthread (kernel/kthread.c:464) 
[   24.790004] ret_from_fork (arch/arm64/kernel/entry.S:863) 
[   24.790010]
[   24.790010] -> #0 (&bp->lock){+.+.}-{3:3}:
[   24.790022] __lock_acquire (kernel/locking/lockdep.c:3164 (discriminator 1) kernel/locking/lockdep.c:3282 (discriminator 1) kernel/locking/lockdep.c:3906 (discriminator 1) kernel/locking/lockdep.c:5228 (discriminator 1)) 
[   24.790031] lock_acquire (arch/arm64/include/asm/percpu.h:40 kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853 kernel/locking/lockdep.c:5816) 
[   24.790038] rt_spin_lock (kernel/locking/spinlock_rt.c:48 (discriminator 1) kernel/locking/spinlock_rt.c:57 (discriminator 1)) 
[   24.790044] macb_start_xmit (drivers/net/ethernet/cadence/macb_main.c:2391) 
[   24.790050] dev_hard_start_xmit (include/linux/netdevice.h:5150 include/linux/netdevice.h:5159 net/core/dev.c:3735 net/core/dev.c:3751) 
[   24.790057] sch_direct_xmit (net/sched/sch_generic.c:343) 
[   24.790063] __dev_queue_xmit (net/core/dev.c:3974 (discriminator 1) net/core/dev.c:4550 (discriminator 1)) 
[   24.790069] packet_xmit (include/linux/netdevice.h:3311 net/packet/af_packet.c:276) 
[   24.790076] packet_sendmsg (net/packet/af_packet.c:3132 (discriminator 1) net/packet/af_packet.c:3164 (discriminator 1)) 
[   24.790082] __sock_sendmsg (net/socket.c:718 (discriminator 1) net/socket.c:733 (discriminator 1)) 
[   24.790088] __sys_sendto (net/socket.c:2187) 
[   24.790095] __arm64_sys_sendto (net/socket.c:2190) 
[   24.790101] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:54) 
[   24.790108] el0_svc_common.constprop.0 (include/linux/thread_info.h:135 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)) 
[   24.790116] do_el0_svc (arch/arm64/kernel/syscall.c:152) 
[   24.790123] el0_svc (arch/arm64/include/asm/irqflags.h:82 (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1) arch/arm64/kernel/entry-common.c:745 (discriminator 1)) 
[   24.790129] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:763) 
[   24.790135] el0t_64_sync (arch/arm64/kernel/entry.S:600) 
[   24.790142]
[   24.790142] other info that might help us debug this:
[   24.790142]
[   24.790165] Chain exists of:
[   24.790165]   &bp->lock --> _xmit_ETHER#2 --> &queue->tx_ptr_lock
[   24.790165]
[   24.790196]  Possible unsafe locking scenario:
[   24.790196]
[   24.790199]        CPU0                    CPU1
[   24.790203]        ----                    ----
[   24.790209]   lock(&queue->tx_ptr_lock);
[   24.790221]                                lock(_xmit_ETHER#2);
[   24.790235]                                lock(&queue->tx_ptr_lock);
[   24.790251]   lock(&bp->lock);
[   24.790265]
[   24.790265]  *** DEADLOCK ***
[   24.790265]
[   24.790280] 10 locks held by udhcpc/2642:
[   24.790294] #0: ffff00001fcbc278 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip (include/linux/rcupdate.h:847 kernel/softirq.c:156) 
[   24.790321] #1: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock (include/linux/rcupdate.h:847 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
[   24.790349] #2: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip (kernel/softirq.c:154) 
[   24.790368] #3: ffff8000837b1740 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit (include/linux/bottom_half.h:20 include/linux/rcupdate.h:901 net/core/dev.c:4509) 
[   24.790386] #4: ffff000007fe1398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit (include/net/sch_generic.h:197 (discriminator 1) include/net/sch_generic.h:194 (discriminator 1) net/core/dev.c:3961 (discriminator 1) net/core/dev.c:4550 (discriminator 1)) 
[   24.790405] #5: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock (kernel/locking/spinlock_rt.c:109 (discriminator 1) kernel/locking/spinlock_rt.c:118 (discriminator 1)) 
[   24.790423] #6: ffff0000052ec318 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit (include/linux/netdevice.h:4592 (discriminator 2) net/sched/sch_generic.c:341 (discriminator 2)) 
[   24.790443] #7: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock (include/linux/rcupdate.h:847 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
[   24.790461] #8: ffff000007db5370 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit (drivers/net/ethernet/cadence/macb_main.c:2371) 
[   24.790480] #9: ffff8000837b1718 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock (include/linux/rcupdate.h:847 kernel/locking/spinlock_rt.c:50 kernel/locking/spinlock_rt.c:57) 
[   24.790503]
[   24.790503] stack backtrace:
[   24.790588] CPU: 1 UID: 0 PID: 2642 Comm: udhcpc Tainted: G                 N 6.14.0-rc3-00012-g2408a807bfc3 #1
[   24.790625] Tainted: [N]=TEST
[   24.790634] Hardware name: Xilinx Versal Virtual development board (DT)
[   24.790730] Call trace:
[   24.790799] show_stack (arch/arm64/kernel/stacktrace.c:468) (C)
[   24.790850] dump_stack_lvl (lib/dump_stack.c:123) 
[   24.790863] dump_stack (lib/dump_stack.c:130) 
[   24.790869] print_circular_bug (kernel/locking/lockdep.c:2078) 
[   24.790879] check_noncircular (kernel/locking/lockdep.c:2211) 
[   24.790887] __lock_acquire (kernel/locking/lockdep.c:3164 (discriminator 1) kernel/locking/lockdep.c:3282 (discriminator 1) kernel/locking/lockdep.c:3906 (discriminator 1) kernel/locking/lockdep.c:5228 (discriminator 1)) 
[   24.790895] lock_acquire (arch/arm64/include/asm/percpu.h:40 kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853 kernel/locking/lockdep.c:5816) 
[   24.790902] rt_spin_lock (kernel/locking/spinlock_rt.c:48 (discriminator 1) kernel/locking/spinlock_rt.c:57 (discriminator 1)) 
[   24.790909] macb_start_xmit (drivers/net/ethernet/cadence/macb_main.c:2391) 
[   24.790916] dev_hard_start_xmit (include/linux/netdevice.h:5150 include/linux/netdevice.h:5159 net/core/dev.c:3735 net/core/dev.c:3751) 
[   24.790924] sch_direct_xmit (net/sched/sch_generic.c:343) 
[   24.790931] __dev_queue_xmit (net/core/dev.c:3974 (discriminator 1) net/core/dev.c:4550 (discriminator 1)) 
[   24.790938] packet_xmit (include/linux/netdevice.h:3311 net/packet/af_packet.c:276) 
[   24.790945] packet_sendmsg (net/packet/af_packet.c:3132 (discriminator 1) net/packet/af_packet.c:3164 (discriminator 1)) 
[   24.790953] __sock_sendmsg (net/socket.c:718 (discriminator 1) net/socket.c:733 (discriminator 1)) 
[   24.790960] __sys_sendto (net/socket.c:2187) 
[   24.790967] __arm64_sys_sendto (net/socket.c:2190) 
[   24.790975] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:54) 
[   24.790983] el0_svc_common.constprop.0 (include/linux/thread_info.h:135 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)) 
[   24.790996] do_el0_svc (arch/arm64/kernel/syscall.c:152) 
[   24.791004] el0_svc (arch/arm64/include/asm/irqflags.h:82 (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1) arch/arm64/kernel/entry-common.c:745 (discriminator 1)) 
[   24.791011] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:763) 
[   24.791018] el0t_64_sync (arch/arm64/kernel/entry.S:600) 
udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
