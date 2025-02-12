Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451F25C6FE
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382866; cv=none; b=mxz9cCtXX65GiwvMlswtRfI8RTbgwha6cgfdxrge0QLaas5A9vXrXVp1PftXoktTW3ZjMle0K3Nlwdyna2J2OixfiIwom8yPIPaVq5FBzdlg4710ezyRNd/3Q7FgE96oawfwCFUBNwPD7yTCsBr47vwVVn0/Igg0oGqWrsk5H3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382866; c=relaxed/simple;
	bh=9P6aD6z9J+LRkYNxF0HBCx8UnJoJSDbP+73sNd7f73U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaNt55TgNhm2zgj1O1TChZMGje9tpcSOxuGyk8PJoVzm3+U2B/6BRkBwcSz+FATfU0Hp74hGAln2izObcgJ4O0ywcHxnEnkji87auf6/nxzrhBjxYcdSyN+LiLzePSasXEUTiW12Bj7bu7CJLFIeNjd6XG1j9GecaqAuAP30E4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMTcAjwq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMTcAjwq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso13299265ad.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382864; x=1739987664; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hu6QsGa+qHktPy+tmaTXnDpSj6f9ETMtsxvlXy1ya+U=;
        b=AMTcAjwqzdsP32pWmSy8u7Y7RHDvhFsnamcGvFZj46e9WSWWXZbGFnFKniVyY0qXXX
         WLKhUxlsrsBjgMGPB8NPo8dHAHxAbgzof992JaOzOsIynDUi1K65HEvDLycy863Dt6/A
         Lrli7O1ydYaNZyhlq9DdriYO4O8MgaAtvaFXV5fqHCLC/yfLtG0Yz101GmzEhMOr5dwe
         5bObiuTMeTj7m2hW3duiYuZxh4TD+iuW9Za/tYvDamr+Jt2lAQpvtvXTv/EcXRBF/TUV
         2mFXoSJPe8xCve4UsQjo7wmnRA6O+zH2kbN+t2ieAuxRxTw88toK9A85s1WDNi1XvW4Z
         qQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382864; x=1739987664;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu6QsGa+qHktPy+tmaTXnDpSj6f9ETMtsxvlXy1ya+U=;
        b=RTnj/zkwNdpk7gMyY5u87xG8Q84o/EKWz60d9n6gQOJ5/wHkpmPXVBke1w44pGc8tY
         9UDwsxXtOEYr038TaNmXAooupIHMm9Bo+sneKiPhto39Ytlk0pcKVoEN0ZxnFfvQ+TFu
         X+hBuJnVHKHpNLftUdQ6cIEH2ZXy9GDd9MUl8It33f5n723UtSnIgfQOxwpu6cgR702b
         EqOtTQ+KQ+aoC6ECFKFx+4xANy2rXPuPnpW49E8wsMYrAuKernjtvdJNowxkRebYyJFa
         EKESZz6KgArep56WveoCgByvAoo3RYoJ9r5dnnczGLY2ab9XlIw/UHwdAplPaFhX3i5t
         7+HA==
X-Forwarded-Encrypted: i=1; AJvYcCVIofR+gqQE0m7tekOJFTXxZG96q+MBNOmBiVffKBFXvClgBLzIf5B/+gFsUx1OjlPFp69pxU8Q/QQZl8smTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZgMS6hCQKFWDsxetx07BnYy2kpQjGj8vrDZnSyT8frFetAek5
	8tL+p7tpsmrjyf5XPwF949zWo4ubIvdzSd3VW5gsrRPSPewbgc4I
X-Gm-Gg: ASbGncslyzos526gd7RGZyBYQSvFAGhTFuA2PKuns8qEzbj7IUPLcOJhvg8lR+rvMoo
	suYqxUfu6J78kAkT6Ac5F36WOazyL2B4R5Ep+UiAxvxzPPqN00J9szUwTeBM3TCfgTibKhrXXFj
	El9FrzjD3oBLgkfuCxBq8tmzL+hJpeudecprkKqk64Qpx2ZCED7Fwtr5+8+OBBpchn5HCK7hFcJ
	w3XVG2uijAMM42VS5BQbGvob4/ru29YwOr7DAhmrB/J0oWkqxBPWqaHq9hfeYTt/F9JqGlYT/UO
	j39hVpJV442i7/iGTej3/b38yxla91j5GkQtM257e9coxQDfRFyiKCyQz7ZckfEV
X-Google-Smtp-Source: AGHT+IE+UTnNuZOPnIWrW4gzYmJBXLCwk7t2IeRY+1DQOqqxxvT7Ueh7SNVVQNj3HJfqPtR79LR9Nw==
X-Received: by 2002:a05:6a00:2e28:b0:730:7771:39c8 with SMTP id d2e1a72fcca58-7322c5a9352mr6110516b3a.13.1739382862764;
        Wed, 12 Feb 2025 09:54:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730832c84b2sm6784658b3a.40.2025.02.12.09.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:54:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <49075164-c44b-4921-b422-dd336ce14e79@roeck-us.net>
Date: Wed, 12 Feb 2025 09:54:20 -0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible circular locking dependency backtrace seen when enabling
 PREEMPT_RT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212114531.4e95ffe7@gandalf.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250212114531.4e95ffe7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/25 08:45, Steven Rostedt wrote:
> On Wed, 12 Feb 2025 07:56:44 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> when enabling PREEMPT_RT together with lock debugging, I see the attached
>> "possible circular locking dependency" warning when instantiating the pcnet32
>> Ethernet adapter with qemu.
>>
>> Note: This is with
>>
>> lockdep: Remove disable_irq_lockdep().
>> lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()
>>
>> applied on the top of the mainline kernel.
> 
> Thanks for the report.
> 
>>
>> Thanks,
>> Guenter
>>
>> ---
>> Build reference: v6.14-rc2-3-g59b1a66735ce
>> Compiler version: x86_64-linux-gcc (GCC) 13.3.0
>> Qemu version: 9.1.2 (v9.1.2-51-g94825e22f3)
>> ...
>> Starting network: [   26.638045] pcnet32 0000:00:02.0 eth0: link up
>> [   26.639386]
>> [   26.639429] ======================================================
>> [   26.639435] WARNING: possible circular locking dependency detected
>> [   26.639595] 6.14.0-rc2-00003-g59b1a66735ce #1 Tainted: G                 N
>> [   26.639609] ------------------------------------------------------
>> [   26.639616] irq/22-eth0/2680 is trying to acquire lock:
>> [   26.639648] ffff9cb0438dae30 (&lp->lock){+.+.}-{3:3}, at: pcnet32_interrupt+0x2e/0x1e0
> 
> So the spin_lock(lp->lock) is being taken from the interrupt handler (now a
> thread), while it already holds the softirq_ctrl.lock from the
> local_bh_disable() in the irq_thread_fn().
> 
>> [   26.639853]
>> [   26.639853] but task is already holding lock:
>> [   26.639858] ffff9cb0bdc1c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
>> [   26.639877]
>> [   26.639877] which lock already depends on the new lock.
>> [   26.639877]
>> [   26.639882]
>> [   26.639882] the existing dependency chain (in reverse order) is:
>> [   26.639898]
>> [   26.639898] -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
>> [   26.639950]        rt_spin_lock+0x39/0x170
>> [   26.639985]        __local_bh_disable_ip+0x94/0x180
>> [   26.639991]        __netdev_alloc_skb+0x139/0x1c0
> 
> The __netdev_alloc_skb() calls local_bh_disable() (which takes the
> softirq_ctrl.lock in PREEMPT_RT).
> 
>> [   26.639998]        pcnet32_init_ring+0x18b/0x310
>> [   26.640003]        pcnet32_open+0x477/0x820
> 
> But here it already acquired the lp->lock via a spin_lock_irqsave().
> 
> Now, local_bh_disable() in non PREEMPT_RT disables preemption as well as
> softirqs. But in PREEMPT_RT it does not disable preemption and has the
> following code from __local_bh_disable_ip() in softirq.c:
> 
> 	/* First entry of a task into a BH disabled section? */
> 	if (!current->softirq_disable_cnt) {
> 		if (preemptible()) {
> 			local_lock(&softirq_ctrl.lock);
> 			/* Required to meet the RCU bottomhalf requirements. */
> 			rcu_read_lock();
> 		} else {
> 			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
> 		}
> 	}
> 
> Where that local_lock() disables preemption and prevents softirqs from
> executing on this CPU.
> 
> But in non PREEMPT_RT, spin_lock_irqsave() (as well as spin_lock_irq())
> disables preemption and because it also disables interrupts will disable
> softirqs too.
> 
> Shouldn't the spin_lock_irq*() variants for PREEMPT_RT also disable local_bh?
> 
> Like this patch (untested):
> 
> diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
> index f6499c37157d..50ad0fab66b6 100644
> --- a/include/linux/spinlock_rt.h
> +++ b/include/linux/spinlock_rt.h
> @@ -90,6 +90,7 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
>   
>   static __always_inline void spin_lock_irq(spinlock_t *lock)
>   {
> +	local_bh_disable();
>   	rt_spin_lock(lock);
>   }
>   
> @@ -97,12 +98,14 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
>   	do {						 \
>   		typecheck(unsigned long, flags);	 \
>   		flags = 0;				 \
> +		local_bh_disable();			 \
>   		spin_lock(lock);			 \
>   	} while (0)
>   
>   static __always_inline void spin_unlock(spinlock_t *lock)
>   {
>   	rt_spin_unlock(lock);
> +	local_bh_enable();
>   }
>   
>   static __always_inline void spin_unlock_bh(spinlock_t *lock)
> @@ -114,6 +117,7 @@ static __always_inline void spin_unlock_bh(spinlock_t *lock)
>   static __always_inline void spin_unlock_irq(spinlock_t *lock)
>   {
>   	rt_spin_unlock(lock);
> +	local_bh_enable();
>   }
>   
>   static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
> 
> 
> We could probably consolidate the spin_lock_bh() with spin_lock_irq()
> variants.
> 
> Guenter,
> 
> Can you test that patch to see if it stops this lockdep splat?
> 

That results in a variety of interesting warning backtraces and crashes :-).

[    0.013997] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:212 __local_bh_enable_ip+0xe2/0x160
...
[    0.014890] Call Trace:
[    0.014975]  <TASK>
[    0.015082]  ? __warn+0x8c/0x190
[    0.015115]  ? __local_bh_enable_ip+0xe2/0x160
[    0.015127]  ? report_bug+0x164/0x190
[    0.015144]  ? early_fixup_exception+0xa4/0xc0
[    0.015158]  ? early_idt_handler_common+0x2f/0x40
[    0.015184]  ? update_page_count+0x3c/0x50
[    0.015192]  ? __local_bh_enable_ip+0xe2/0x160
[    0.015206]  ? phys_pte_init+0xaa/0x1c0
[    0.015225]  ? phys_pmd_init+0x242/0x3d0
[    0.015248]  ? phys_pud_init+0xb4/0x3d0
[    0.015261]  ? phys_pud_init+0x52/0x3d0
[    0.015276]  ? __kernel_physical_mapping_init+0x171/0x380
[    0.015298]  ? init_memory_mapping+0x14e/0x3d0
[    0.015335]  ? init_mem_mapping+0xed/0x450
[    0.015350]  ? setup_arch+0x757/0xd60
[    0.015371]  ? start_kernel+0x6b/0x810
[    0.015391]  ? x86_64_start_reservations+0x18/0x30
[    0.015397]  ? x86_64_start_kernel+0xc5/0xe0
[    0.015406]  ? common_startup_64+0x12c/0x138
[    0.015447]  </TASK>
...
[    0.246710] ------------[ cut here ]------------
[    0.246720] kernel BUG at mm/vmalloc.c:3118!
[    0.247070] Oops: invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
[    0.247152] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.14.0-rc2-00004-g7c65c4480e19 #1
[    0.247175] Tainted: [W]=WARN
[    0.247180] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.247185] RIP: 0010:__get_vm_area_node+0x124/0x140
[    0.247204] Code: ff ff ff 48 0f bd ca ba 0c 00 00 00 83 c1 01 39 d1 0f 4c ca ba 1e 00 00 00 39 d1 0f 4f ca 48 d3 e0 49 89 c6 e9 4a ff ff f
f 90 <0f> 0b 48 89 ef e8 e2 5f 01 00 31 ed eb b0 66 66 2e 0f 1f 84 00 00
[    0.247210] RSP: 0000:ffffffffbdc03df8 EFLAGS: 00010006
[    0.247221] RAX: 000000000000a200 RBX: 0000000000000004 RCX: 0000000000000004
[    0.247225] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000004000
[    0.247227] RBP: 0000000000004000 R08: ffffac1540000000 R09: ffffcc153fffffff
[    0.247230] R10: ffff9459010577c0 R11: 0000000000000000 R12: 0000000000000004
[    0.247233] R13: ffffffffbdc03e88 R14: 0000000000000001 R15: 0000000000014770
[    0.247236] FS:  0000000000000000(0000) GS:ffff94590f800000(0000) knlGS:0000000000000000
[    0.247240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.247243] CR2: ffff94590f001000 CR3: 000000000d2f6000 CR4: 00000000000000b0
[    0.247247] Call Trace:
[    0.247278]  <TASK>
[    0.247295]  ? die+0x31/0x80
[    0.247304]  ? do_trap+0xd8/0x100
[    0.247312]  ? __get_vm_area_node+0x124/0x140
[    0.247320]  ? __get_vm_area_node+0x124/0x140
[    0.247326]  ? do_error_trap+0x78/0x100
[    0.247333]  ? __get_vm_area_node+0x124/0x140
[    0.247342]  ? exc_invalid_op+0x51/0x70
[    0.247348]  ? __get_vm_area_node+0x124/0x140
[    0.247354]  ? asm_exc_invalid_op+0x1a/0x20
[    0.247374]  ? __get_vm_area_node+0x124/0x140
[    0.247389]  get_vm_area_caller+0x39/0x50
[    0.247406]  ? irq_init_percpu_irqstack+0xe8/0x120
[    0.247414]  vmap+0x64/0xe0
[    0.247423]  irq_init_percpu_irqstack+0xe8/0x120
[    0.247435]  init_IRQ+0x56/0x70
[    0.247446]  start_kernel+0x366/0x810
[    0.247456]  x86_64_start_reservations+0x18/0x30
[    0.247463]  x86_64_start_kernel+0xc5/0xe0
[    0.247470]  common_startup_64+0x12c/0x138
[    0.247489]  </TASK>

