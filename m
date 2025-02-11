Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527DE272905
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314492; cv=none; b=fiYnrPw+8hpuQZd9yuNVWLKVgXtElRv5AzWWuXn+B5YeI3/RUuAnUP0LXm1ifUXUzfL4c2RVyt24gg0Wqh6LfPb0y+M95fO7TMY1fghPM20dP/JqRjkdBOAj5hsz5qyppnX5iuw9Fj7/0mrmqzIArXKjjCbBrLDETC3syG1Bef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314492; c=relaxed/simple;
	bh=cLRqfkiapyvXOYCtEd/RskNeyvFrg2QUG+4f3glfr0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkrC/itYsDrOgX1ZY+L0ICUvvO3WnWVW/8V3F1mDbKcP9GFyhxGvl80fxm4jEp5lUZ1jwWnAdRVmUmJcAByWaKGN2LyYxEi9OPZYjVYVBLripVcR+qEA3eDyLOhMTmXWxTp5WFHFc7FvoxtzqkmlkCcbvpJyp/R3bCVkEeagiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii2wBKNk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii2wBKNk"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa0c039d47so9042322a91.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739314489; x=1739919289; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mnWUnJqRae+7Qjzrg5UYSXonQkeLOFgx2IZxlXwv4q8=;
        b=Ii2wBKNkQLkUbWtcZ95R6NnTY7toRB1sOkMAUdvQ98/6TYeowjkFSbM0mM+rHR7Z+v
         392REkWbo0r7p4VrtMdJ4h/AmHh+99g97zYBWDPejpHO4wLI0lD8AvNVagEjn/FnR/x5
         bRtfmmdh+9Am5xTTboQ27uFRnpjZuXjms+rEOVlkWF0mrxkgBHFyhp+7M/85OADbhD7n
         MXtbuXjScCEnhGjP5yW6fiqT9Jil5tmW9Oi3kpGGCmpiuOnlqvOobBJHtE10EdcEaO7l
         8ClqrKvbWr5kwoNplxWbPgTgQ7sFNS59vV8ZwazE6ddXrP1IueEq3aKQy6a1Mq2CM1YC
         K6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739314489; x=1739919289;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnWUnJqRae+7Qjzrg5UYSXonQkeLOFgx2IZxlXwv4q8=;
        b=hPBO+jF/h5Ska8GdrpfTLXAqTilOrmM3juTHigfIWBRvK6kC7U3sR2zzUdQxplW3Mb
         4JIzt8+aDUwS0iMZ2d0coqfZwQ4ywNZZ1lOuMYiPClne/ovG9ydSx3Wb8Yc5S1WXCuMH
         otgUIWNjf1A2lYWno82/SX1KGiqP642j7wHLfbP4peSIjoQCHjYzXqSU1+OuCVLO2zRE
         ilNHqkWYnvL4DU2EOz+CMvzEn1CTLSshRxg/DqO/DPRQtmJFuOiDJvLTksNF+Z5lSPyq
         JWd9XTqpqJ89sfNSNqZbL7c86WzvkMPg7sdVGxbtApb4mubucfnJfOF8qUa7D0oDutsq
         rObA==
X-Forwarded-Encrypted: i=1; AJvYcCVnFCdaPl+43KAH3JTsojqknuKLxwUezYHj/+bSUem6l+nlXqj+zk4D/xUgga1UjEPXk53uU806xMi1ksnXnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+MvMdQCizZgV7DqW0ZveyJTDipHQy0ej8OQ3ee97srxiZOSfR
	HmNp62N1n87j+KeVpNkqe2f2mBj5XDXqjsoALEDqataJrsI9/NCz
X-Gm-Gg: ASbGncup7mRc5fB9dnP94Xwv5lJ4hoeEtNfkpFDZAKNQgxTC3ueVyanpYUL0Z9HRv57
	EgdP8n9W5D5wdX2sxeZoW85h9i8EUOp1g0Zove9Ef+UgZ5VGZU7qWSCV1FJK0pDHZmj1af+zMO+
	MzhOKB6LnWOYBaGMxQKz/EFmqOV+Nn1rQYv1kzzw6oPyb0fNixWgasm1mBlZ5asSz4Glhv1UOyC
	rAn1xtIv9uchJFgM9JZXepJiVgvIQhkGADBXXe2GG2DR9BGVwxovUsAxZOL6IkATwyL718AqlTB
	uwrUx4Mfj2yu3bd5XFBi5EAdf6H372xUpsbpdiMjWD25nesXrULjPilQARNILYgR
X-Google-Smtp-Source: AGHT+IEldHufmuo6wq2bqMKrCPrhUa0XuClAut39ZZMoPaSs56nnnM57qaqP+5ZLjbfOsXQGSFElJw==
X-Received: by 2002:a17:90b:2810:b0:2ee:4513:f1d1 with SMTP id 98e67ed59e1d1-2fbf5c58377mr1066856a91.23.1739314489356;
        Tue, 11 Feb 2025 14:54:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab0233sm75843a91.44.2025.02.11.14.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:54:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bfecd294-d68d-4e71-af43-b19c59012c98@roeck-us.net>
Date: Tue, 11 Feb 2025 14:54:47 -0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backtrace seen when enabling PREEMPT_RT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250211122222.740824a0@gandalf.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250211122222.740824a0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/25 09:22, Steven Rostedt wrote:
> On Tue, 11 Feb 2025 08:12:37 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> When I tried to enable PREEMPT_RT together with various lock debugging
>> options, I got the attached backtraces.
>>
>> This is with qemu's ne2k_pci Ethernet emulation.
>>
>> Question: If I enable PREEMPT_RT tests at kerneltests.org, should I report
>> such issues or stop testing affected configurations (I understand that
>> ne2k_pci probably isn't used much nowadays).
> 
> Yes, I think you should still report this.
> 
>>
>> Thanks,
>> Guenter
>>
>> ---
>> Build reference: v6.14-rc2-8-g3309945911b8
>> Compiler version: x86_64-linux-gcc (GCC) 13.3.0
>> Qemu version: 9.1.2 (v9.1.2-51-g94825e22f3)
>> ...
>> Starting network: [   13.511263] ip (2707) used greatest stack depth: 11928 bytes left
>> [   13.708177] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> [   13.708226] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 8, name: kworker/0:0
> 
> Interrupts are disabled  while taking a spin_lock() (in RT that's a mutex).
> 
>> [   13.708236] preempt_count: 0, expected: 0
>> [   13.708242] RCU nest depth: 6, expected: 6
>> [   13.708265] 14 locks held by kworker/0:0/8:
>> [   13.708280]  #0: ff4dd8b344e6dd38 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work+0x590/0x6d0
>> [   13.708568]  #1: ff5a3c8a40057e48 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1df/0x6d0
>> [   13.708582]  #2: ff4dd8b344fbc620 (&idev->mc_lock){+.+.}-{4:4}, at: mld_ifc_work+0x32/0x560
>> [   13.708595]  #3: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: mld_sendpack+0x73/0x380
>> [   13.708616]  #4: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: ip6_finish_output2+0xe0/0xb80
>> [   13.708629]  #5: ff4dd8b3bf61c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
>> [   13.708653]  #6: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
>> [   13.708669]  #7: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xab/0x180
>> [   13.708682]  #8: ffffffff90806ee0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x71/0x13b0
>> [   13.708694]  #9: ff4dd8b34566c398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0x1061/0x13b0
>> [   13.708705]  #10: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x52/0xc0
>> [   13.708717]  #11: ff4dd8b344c66f58 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x113/0x2b0
>> [   13.708737]  #12: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
>> [   13.708752]  #13: ff4dd8b344c14e40 (&ei_local->page_lock){+.+.}-{3:3}, at: ei_start_xmit+0xb5/0x470
>> [   13.708793] irq event stamp: 198329
>> [   13.708799] hardirqs last  enabled at (198328): [<ffffffff8fa1fb36>] _raw_spin_unlock_irqrestore+0x46/0x70
>> [   13.708808] hardirqs last disabled at (198329): [<ffffffff8f31d897>] ei_start_xmit+0x2a7/0x470
> 
> Hmm, where is that ei_start_xmit+0x2a7, This would be good to run
> scripts/decode_stacktrace.sh on this.
> 

Does this help ?

[   13.163019] hardirqs last enabled at (52626): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[   13.163030] hardirqs last disabled at (52627): ei_start_xmit (include/linux/interrupt.h:460 (discriminator 1) drivers/net/ethernet/8390/lib8390.c:333 (discriminator 1) drivers/net/ethernet/8390/8390.c:23 (discriminator 1))
[   13.163038] softirqs last enabled at (52602): __local_bh_enable_ip (kernel/softirq.c:247)
[   13.163046] softirqs last disabled at (52608): __dev_queue_xmit (include/linux/bottom_half.h:20 (discriminator 1) include/linux/rcupdate.h:901 (discriminator 1) net/core/dev.c:4509 (discriminator 1))
[   13.163257] CPU: 2 UID: 0 PID: 59 Comm: kworker/2:1 Tainted: G                 N 6.14.0-rc2-00008-g3309945911b8 #1
[   13.163300] Tainted: [N]=TEST
[   13.163307] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   13.163376] Workqueue: mld mld_ifc_work
[   13.163466] Call Trace:
[   13.163501]  <TASK>
[   13.163544] dump_stack_lvl (lib/dump_stack.c:123)
[   13.163584] __might_resched (kernel/sched/core.c:8767)
[   13.163607] rt_spin_lock (kernel/locking/spinlock_rt.c:40 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57)
[   13.163618] ? ei_start_xmit (drivers/net/ethernet/8390/lib8390.c:337 drivers/net/ethernet/8390/8390.c:23)
[   13.163625] ? __disable_irq_nosync (kernel/irq/manage.c:702)
[   13.163638] ei_start_xmit (drivers/net/ethernet/8390/lib8390.c:337 drivers/net/ethernet/8390/8390.c:23)
[   13.163642] ? lock_acquire.part.0 (kernel/locking/lockdep.c:469 (discriminator 4) kernel/locking/lockdep.c:5853 (discriminator 4))
[   13.163685] dev_hard_start_xmit (include/linux/netdevice.h:5144 include/linux/netdevice.h:5153 net/core/dev.c:3735 net/core/dev.c:3751)
[   13.163709] sch_direct_xmit (net/sched/sch_generic.c:343)
[   13.163735] __dev_queue_xmit (net/core/dev.c:3974 (discriminator 1) net/core/dev.c:4550 (discriminator 1))
[   13.163751] ? lock_acquire.part.0 (kernel/locking/lockdep.c:469 (discriminator 4) kernel/locking/lockdep.c:5853 (discriminator 4))
[   13.163760] ? find_held_lock (kernel/locking/lockdep.c:5341 (discriminator 1))
[   13.163778] ? mark_held_locks (kernel/locking/lockdep.c:4323 (discriminator 1))
[   13.163790] ? eth_header (net/ethernet/eth.c:85)
[   13.163819] ip6_finish_output2 (include/net/neighbour.h:539 (discriminator 2) net/ipv6/ip6_output.c:141 (discriminator 2))
[   13.163843] ? ip6_mtu (net/ipv6/route.c:3220)
[   13.163869] mld_sendpack (net/ipv6/mcast.c:1866)
[   13.163918] mld_ifc_work (net/ipv6/mcast.c:2699)
[   13.163940] process_one_work (kernel/workqueue.c:3241)
[   13.163979] worker_thread (kernel/workqueue.c:3311 (discriminator 2) kernel/workqueue.c:3398 (discriminator 2))
[   13.163993] ? __pfx_worker_thread (kernel/workqueue.c:3344)
[   13.164000] kthread (kernel/kthread.c:464)
[   13.164015] ? __pfx_kthread (kernel/kthread.c:413)
[   13.164030] ret_from_fork (arch/x86/kernel/process.c:154)
[   13.164036] ? __pfx_kthread (kernel/kthread.c:413)
[   13.164046] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)

Guenter

