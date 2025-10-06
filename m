Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6F1ADC7E
	for <linux-rt-devel@lists.linux.dev>; Mon,  6 Oct 2025 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781939; cv=none; b=h5ubsLCG1nMBLVRLwFSyuefLEOk/khHW0YCqXuoTfI4iwN40bOFV9iO29Tu2zd/AjX0zaC+RHigOqcH8NOj+7HMxdLJllfG4h78DQibWmQryvebxfF0ZpzBUvhOpu1xnDPPCdpGWoo7RFt9YH1n0YbxZgJak0IH94zcTNlvxsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781939; c=relaxed/simple;
	bh=5eQEIeNJ5EZYkPz01gAZjijISqu7bO+HYt1McJx8mUA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D+CR57k6IRKX4o+nYTNyNKTeW5vQuzFV8GPTAo4Fjs2pK+gdvnP+7FatWTIi6FX1jcq2o+a+U9/Tew5lMD24KdtHm4urlz1jm9fLBFX6RgEoI3ZnPoxhj6RWLEjxf9AOX8ny4QwqI8AfLcvH6Op9ywI9ayS/+j9dXC/5fKdmY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQd1ZB8T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQd1ZB8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759781936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRDjOk2UJBNY8OM4uijGV6YLvmoMX0A5enzMiF12TZI=;
	b=GQd1ZB8TCA0GJK3xZ3rANzFduAIH9T6P7CFyjoIstJt4XpLhZHdtZfCG3XV7ixxR4rkN9w
	8P4hJN4uSNylO/uuqDafP7uJNbHtOTu4Izu/8v1QPX+DzLhhvprSgv8KDsPus6UNOgGJ9a
	hYjBC9mqRHIb6pIE/KAErifijPFhWS4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-a0UrEDoFM3mwJU06F0KSNQ-1; Mon, 06 Oct 2025 16:18:55 -0400
X-MC-Unique: a0UrEDoFM3mwJU06F0KSNQ-1
X-Mimecast-MFC-AGG-ID: a0UrEDoFM3mwJU06F0KSNQ_1759781935
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-872d2ad9572so1209274585a.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 06 Oct 2025 13:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781933; x=1760386733;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRDjOk2UJBNY8OM4uijGV6YLvmoMX0A5enzMiF12TZI=;
        b=AdECjo6F1hong5mIK8Ulz0nXJa9UhuHPv8Y8RWYG4Mlcq8lFjnp5/gI3ztWKBe3TiP
         jtdjQ9EE5rnztzLm8ISSsMS+1t4mjAodxGxmKqsR2XCvCO9dm9Hym7mDyKNg072KFjem
         J3mvihk9dfvWWuOgnWVTCTf9BjsASh8w9fQYgTeE/Mhjf1PAaEFbo0KR7qf6mpAgaOwj
         6431hp1E6vTy0nq3gq0Pmg3w4TtIJ1fokVj++a9Lssm1t8ALeO+3Rd2D8yJfixmYu4OR
         bq8cjImAtUnV/6v0CEeEW9rdzrKSl6/yYj9h9C4R/iu+bEnGHrdzrnFMtYrhtCTbf6XM
         Gpiw==
X-Gm-Message-State: AOJu0YyuQJnY3vfkyHGjHTp4am/P05fxdMj9Jg/VkOqo/kjW+X1RDUlA
	Hpb6BugzExYs+g7EXF5PhU6w5gJKXMCtSz0nQ9ftg/CIWpTyGolXyCgQjHmjIOGE+u4LZBmUmYE
	gHz8vxMgVzyT1RvjcjcDXPPyLliPWjVoQhHtjR3k0JmO27ZUdsXom/XsAd7G4ITdJJuot
X-Gm-Gg: ASbGncveD9EvkffvSk8kI/GPaSLXh7xNEVPjJegZZ2MR8I2v5SqDcyKitWR1T38dWXW
	FkP8+wQdEEtHthOFXd3/klGYH73nG7IrC7EX2z0wA0g2ndC/ejuWAdYXbGMC91dmehkykq8lCwP
	ciHsVS+jUvfOu0poSuOIkY4Bnzru6OJYktfurKEmyjCTZxRLC+NYIL3/Hw7mtR2y+W24ZyNpBBH
	5AAFLnGvvsH6yfHK+w6wh0UkJxZaDzBQWpPNFop3gtuuBkUkK/Xr9c/PUFT/EHcE2Z15FCyECM7
	jQRJKvGrIFpbdT8DKLKf47t31ZlG3obWymzhlnOMVS0tq2rSz1KBcYtzQiYXqN7cOEMOA+1rXck
	RJIdorqpUYiMxEYb5
X-Received: by 2002:a05:620a:1707:b0:84b:ebcf:56a3 with SMTP id af79cd13be357-87a34aa4516mr1588124485a.21.1759781932759;
        Mon, 06 Oct 2025 13:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1dgJjNLxpPDAd6SOq/4Amrbct/qwou5kIt8RniF4E527vSqzwcPOgDR30Aenfez80Nn+SaQ==
X-Received: by 2002:a05:620a:1707:b0:84b:ebcf:56a3 with SMTP id af79cd13be357-87a34aa4516mr1588121585a.21.1759781932301;
        Mon, 06 Oct 2025 13:18:52 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877725550b3sm1380084485a.26.2025.10.06.13.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:18:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0bfeee57-d0dd-4480-8539-0ae5d7d4ea04@redhat.com>
Date: Mon, 6 Oct 2025 16:18:50 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Account for lockdep hardirq context in
 irq_forced_thread_fn under PREEMPT_RT
To: Guangbo Cui <2407018371@qq.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <tencent_B5CE9A8654E8B2476383AEC85C25BDA7BD05@qq.com>
In-Reply-To: <tencent_B5CE9A8654E8B2476383AEC85C25BDA7BD05@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dbjDniTwt7OLG3KOoeuevDmuxnzuZmQ56eG2AyDBtkU_1759781935
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/25 2:34 PM, Guangbo Cui wrote:
> In PREEMPT_RT, IRQs are forced to run in threaded. However, lockdep did not correctly
> account for this case, causing false-positive warnings about hardirq context violations
> when analyzing lock acquisition in such threaded IRQs (see function `task_wait_context`).
>
> This patch updates `irq_forced_thread_fn` to explicitly call `lockdep_hardirq_enter()`
> and `lockdep_hardirq_exit()` when PREEMPT_RT is enabled, ensuring lockdep correctly
> tracks the hardirq context even when the IRQ is executed in a forced thread.
>
> This was discovered while testing PCIe AER error injection on an arm64 QEMU virtual machine:
>
> ```
>    qemu-system-aarch64 \
>        -nographic \
>        -machine virt,highmem=off,gic-version=3 \
>        -cpu cortex-a72 \
>        -kernel arch/arm64/boot/Image \
>        -initrd initramfs.cpio.gz \
>        -append "console=ttyAMA0 root=/dev/ram rdinit=/linuxrc earlyprintk nokaslr" \
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

data->lock is a rt_spin_lock and pci_lock is a raw_spinlock_t with irq 
disabled. So the data->lock => pci_lock sequence is OK. However, 
inject_lock is a rt_spin_lock again. So you can't acquire it with a 
raw_spinlock held and interrupt disabled. It is something that needs to 
be fixed not worked around as if it is OK. It is not a false positive.

Cheers,
Longman

