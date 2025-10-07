Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF82D8363
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Oct 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850021; cv=none; b=kb3p+GIjYs5r/MoCYQ0JaZVkjY+dT6bQ7eobiOKn6zAsAyMv9RoHluoSShD6pMQP+BkDr8oQwT152eIBvBGDDN/wJjCc88BKXEl3vKHQXZOqabdLKwok/Uixbuc3TxCrR8eF/MxU3367FXAQKQegBL9FDD4cmnHIwPIc41XQPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850021; c=relaxed/simple;
	bh=3g1p7NRPsEFW+8WfskgLywGQ6IGrvAc+PkRC+0FDsQ8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TIOsTqG6/+gB9nXrTkadN/xhKrhoicyxxHd4xZ3HDj+a4Xo5R3RJ91xsxZTNb8OsmHeZg923h93yLYZ+Ph7RR5ChzX3/MBDfnOS+i6veUq8YaetsphGi9bzO9xyY157Bmbd4sTJkPZeEwdLuDcLsBHtt4UFCJohCcJdx6xGIMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FU4uYkkp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU4uYkkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759850018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ddiEFnR46rtXw+UiR7skdwc2jg2aUuZyVlLI31wHEQ=;
	b=FU4uYkkpcszCTxSWHuQ6YQh1ne4Vp5c8CUf0XVJB/31KeIfovzduaZe2FLbvdmqTifnGnb
	pxzEsBlh3I2jEvQQAxJnl79v2HLp6xDFJ9P06/io5tlqzySn2pFu6/MMAizmSIvnK7Sc4a
	P2LVXVg9GP4YTEq7KQdpwc9r8HngLzg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-wMx6rDI_Mty7lInYNH9IMg-1; Tue, 07 Oct 2025 11:13:37 -0400
X-MC-Unique: wMx6rDI_Mty7lInYNH9IMg-1
X-Mimecast-MFC-AGG-ID: wMx6rDI_Mty7lInYNH9IMg_1759850016
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85adb6a349cso1383963985a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Oct 2025 08:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850015; x=1760454815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ddiEFnR46rtXw+UiR7skdwc2jg2aUuZyVlLI31wHEQ=;
        b=Xd2GaZswexxx3g0+pGdJfsxl/lLatEhqE1GMlTtXU09mMMDkK9I60hAAL8WSguBYVz
         gkNn+cXCSxASfRoF6uhrw3J+xnZbkMZOuV+fK1t8t2DruakiY8rmsNIAdgfA7SpSNu72
         DT8QFOaesdWupNeyjJN7PWeBKgfMAFAMRY6qc6NKTtyDdSH++2dSFM+Lj7PbnhVMvyOZ
         aDWVqNLgk2kXTshDhNTXDplACjCaAGMCYWqvjAOn2bfBi0doNvg0Whb6BhkXXhWkZ/y7
         jpYIBAM5FP5ZYB1HimzuaoSdpCEH0pTHHGmeBFLpCb/k4lgWDnH84mUCMlrOluYyXfvC
         Eidw==
X-Gm-Message-State: AOJu0Yyf+NMM/9GCUZYrxvCYefR33F57eCjIi19KFZTYzGwt5N9Dd2i2
	al+8G1E2lG2H/DA5wpYkgTbeSgFKLXuF9++5WM8PJQWhVhmsMR8TDfNZgY+Qs+6+IhgIJQZpvYZ
	6IQmnUMr43kwrP8aPKSwUvNKUAM/68I35B31HCfdjEBT4W6yB/C1y3IwmFD09s1uW4i0j
X-Gm-Gg: ASbGncvjUbPzeLLRQl0TAdsADcHIhoRaszYxy2ua0RJTst8PzqcUmzplBjzNpWJSRja
	XpyMLqHBRlRxDwMlcyrQzDJnQLD0nZ3Rh4y14IzwazSIVQ8caGHQz9/4udEGPGMYLekZJeQYyZz
	TiYqSbd+IELqSSjMNW9fIHKam8/8xYvaWgxAS9u1kV0h2DkazQkKFLqpR1ot+zX0tM4Qn53RQ0I
	q0yDgyYtXPtUJnhdj1KdRpkBJFw6nWqtJv53+BdGWUH80aY52gmH47DU6Vc0+u7JgURQfoEHdK/
	48yMj+hjO4kQetGW7AIC2QR+bMCZtXPcv4rM5EchQhtArV9WDLoiXHLtkaLofoolOGaTVXq8GUU
	cKQcz6KQn3Xmaz3dR
X-Received: by 2002:a05:620a:414c:b0:82f:10ac:450b with SMTP id af79cd13be357-8835547b2b8mr10201085a.65.1759850015510;
        Tue, 07 Oct 2025 08:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjiF9gc8pOklg8N0RJ6EiJeux930DBMaWT2qfH2J/+Lt9g3eAzI5oqofA3NtrMK34LqAJ/Ww==
X-Received: by 2002:a05:620a:414c:b0:82f:10ac:450b with SMTP id af79cd13be357-8835547b2b8mr10192885a.65.1759850014838;
        Tue, 07 Oct 2025 08:13:34 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777112965dsm1555614385a.11.2025.10.07.08.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 08:13:34 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
Date: Tue, 7 Oct 2025 11:13:33 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com>
In-Reply-To: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iCL1pfCpBnQC50kX5_qBpifELq9dkVjObD0A4j35F-o_1759850016
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 2:02 AM, Guangbo Cui wrote:
> When injecting AER errors under PREEMPT_RT, the kernel may trigger a
> lockdep warning about an invalid wait context:
>
> ```
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
> ```
>
> This happens because the AER injection path (`aer_inj_read_config()`)
> is called in the context of the PCIe PME interrupt thread, which runs
> through `irq_forced_thread_fn()` under PREEMPT_RT. In this context,
> `pci_lock` (a raw_spinlock_t) is held with interrupts disabled
> (`spin_lock_irqsave()`), and then `aer_inj_read_config()` tries to
> acquire `inject_lock`, which is a `rt_spin_lock`. (Thanks Waiman Long)
>
> `rt_spin_lock` may sleep, so acquiring it while holding a raw spinlock
> with IRQs disabled violates the lock ordering rules. This leads to
> the “Invalid wait context” lockdep warning.
>
> In other words, the lock order looks like this:
>
> ```
>    raw_spin_lock_irqsave(&pci_lock);
>        ↓
>    rt_spin_lock(&inject_lock);   <-- not allowed
> ```
>
> To fix this, convert `inject_lock` from an `rt_spin_lock` to a
> `raw_spinlock_t`, a raw spinlock is safe and consistent with the
> surrounding locking scheme.
>
> This resolves the lockdep “Invalid wait context” warning observed when
> injecting correctable AER errors through `/dev/aer_inject` on PREEMPT_RT.
>
> This was discovered while testing PCIe AER error injection on an arm64
> QEMU virtual machine:
>
> ```
>    qemu-system-aarch64 \
>        -nographic \
>        -machine virt,highmem=off,gic-version=3 \
>        -cpu cortex-a72 \
>        -kernel arch/arm64/boot/Image \
>        -initrd initramfs.cpio.gz \
>        -append "console=ttyAMA0 root=/dev/ram rdinit=/linuxrc nokaslr" \
>        -m 2G \
>        -smp 1 \
>        -netdev user,id=net0,hostfwd=tcp::2223-:22 \
>        -device virtio-net-pci,netdev=net0 \
>        -device pcie-root-port,id=rp0,chassis=1,slot=0x0 \
>        -device pci-testdev -s -S
> ```
>
> Injecting a correctable PCIe error via /dev/aer_inject caused a BUG
> report with "Invalid wait context" in the irq/PCIe thread.
>
> ```
> ~ # export HEX="00020000000000000100000000000000000000000000000000000000"
> ~ # echo -n "$HEX" | xxd -r -p | tee /dev/aer_inject >/dev/null
> [ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 00000001/00000000 into device 0000:00:02.0
> [ 1850.949951]
> [ 1850.950479] =============================
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
> [ 1850.955932] stack backtrace:
> [ 1850.956412] CPU: 0 UID: 0 PID: 56 Comm: irq/16-PCIe PME Not tainted 6.17.0-11316-g7a405dbb0f03-dirty #7 PREEMPT_{RT,(full)}
> [ 1850.957039] Hardware name: linux,dummy-virt (DT)
> [ 1850.957409] Call trace:
> [ 1850.957727]  show_stack+0x18/0x24 (C)
> [ 1850.958089]  dump_stack_lvl+0x40/0xbc
> [ 1850.958339]  dump_stack+0x18/0x24
> [ 1850.958586]  __lock_acquire+0xa84/0x3008
> [ 1850.958907]  lock_acquire+0x128/0x2a8
> [ 1850.959171]  rt_spin_lock+0x50/0x1b8
> [ 1850.959476]  aer_inj_read_config+0x38/0x1dc
> [ 1850.959821]  pci_bus_read_config_dword+0x80/0xd8
> [ 1850.960079]  pcie_capability_read_dword+0xac/0xd8
> [ 1850.960454]  pcie_pme_irq+0x44/0xc4
> [ 1850.960728]  irq_forced_thread_fn+0x30/0x94
> [ 1850.960984]  irq_thread+0x1ac/0x3a4
> [ 1850.961308]  kthread+0x1b4/0x208
> [ 1850.961557]  ret_from_fork+0x10/0x20
> [ 1850.963088] pcieport 0000:00:02.0: AER: Correctable error message received from 0000:00:02.0
> [ 1850.963330] pcieport 0000:00:02.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> [ 1850.963351] pcieport 0000:00:02.0:   device [1b36:000c] error status/mask=00000001/0000e000
> [ 1850.963385] pcieport 0000:00:02.0:    [ 0] RxErr                  (First)
> ```
>
> Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>

Changing inject_lock into a raw_spinlock is the most obvious solution as 
long as it meets the criteria that the lock hold time is deterministic 
and relatively short and no other sleeping locks are being acquired down 
the locking chain.

I am afraid that the these criteria are not met. First of all in 
aer_inject_exit(), inject_lock is acquired while iterating the a linked 
list which can last for while depending on how many items are in the 
list. This may be OK as long as it is guaranteed the list will not be 
long. Another problem is that it call kfree() while holding the lock. 
kfree() will likely acquire another rt_spin_lock which is a sleeping 
lock. You will have to consider pulling kfree() out from the lock 
critical section.

Another function __find_aer_error() which does list iteration is called 
while holding inject_lock. Again this may be a problem. If the linked 
list can be long, you may have to consider breaking inject_lock into 2 
or more separate locks to guard different data.

Cheers,
Longman

