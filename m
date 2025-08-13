Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3E186295
	for <linux-rt-devel@lists.linux.dev>; Wed, 13 Aug 2025 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755061315; cv=none; b=omvMg4T6TxUfvUlMKq9R+7SFSd5pSx726RVFvESX/qxuMH/MU/qZb2NLAOEddm53KllM7AtrnuhfOe4kQbGTdCDfpV/z+HRbjOtxcJjuyDbyP1CH2c9Nm0suqeFCaskmkYWVrUrEojdGsXukiY1ePXHAj4WDM71VPXztrNWrhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755061315; c=relaxed/simple;
	bh=cxRTsy9hkNHRvl3G4e+cV7OwDHpT0bE6avXISKhbeAc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bKef33asS5uDGj8RoAXEQdxYmBxCc8+HO3e+1fwleT/OXgNLnKNnUMl3fwZtQw9D1eB7xBXbOIwkU/bsEcUyiKECIm34kjb/sKSL9m7UdO6lvlUPoqlslgktGwECglU5emVmVQYeZWYBMoMdj0bwpNOuBT5KlVA4oV4ocM9aVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3badf1afc0so1235248a12.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 12 Aug 2025 22:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755061313; x=1755666113;
        h=content-transfer-encoding:subject:organization:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEZpKy93KwsZzwDENO82mv0vqJLUvc/sxgMgyLQLjXY=;
        b=M3Fo/qExyNYk9aY6JyiFdhDNJftU+WRtM5/ZinhEkx9MchaJUj/HqAcG/qCdnYbixm
         3a2O3gL75IAhRdgfSvgaykupcXWStHVAVTXFAOwc3u1bSRLJZtPuBI0SgrJZuY1uUwRh
         KtE3xZiUwe6TBi9n1cpIcAevdLRVyMHBtoYgfAsjgbSZP0sq4bt5tFPNm4xwIb8Hz7BS
         bG+yfZYhrvOlSZ8ik2nZB7alMhLGRCtpDaA7haxswWKPzE22UC3wUz7LRgQuObD9TJe2
         uSC+GJHD9ZgTj6Iz6VEaK5vu9vJroQt6Qn2vUOlIpkIhhl28kQ0n29ZVh1mAYkCm+laO
         0yKA==
X-Forwarded-Encrypted: i=1; AJvYcCWyNSCqQe+M4sIrbgu3bEUYYhco28Fwoo2P50ZwJIpt4FxVECAX6HiXlmsGG0qa7pPoXej/9h8b6W3HEvhM5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQhWvcoOBXY5yRiVWaac2KPc1j/cP79pYBXREo8LXuoy9Zoayb
	XEZKGeL9V4SSNysv825sPsxoacZhIhRCM758FRMEXfR7UQl5+qgRGiLB
X-Gm-Gg: ASbGncvDWErpWOK5nV9JyvLy3MDqKj1psaBNXLHQDdH2Nk5WOJ3Cj/xjF2kGuUt+r6R
	YeeoytPN/dafs0LvoAsK82NeljZkXrEksL+gP9qZ8NNv77LEUgX+HAd///62SO7YhkZUaU7T5RQ
	NxDJ3e1IuDS/hIVZanoH3wQm41hNIOrNrRS1DbvQvrO4TIy7qJ3TrUTFVAu3LYjTF8RqTtSVwJ7
	8DdVCMGdnBdo8HB4eXzoHqVn4S6fKMHRsJJ2HuoSyWVEZjf9EiFcSdsUX/XvUPm4ZHQZK/uQs3X
	pkK6ZeDlCoPSpQt531P8q/CMWRIRCB5Tur6LkUSU//deCFhmZpkQ5oTvO/unQ2bBjGX7KvbtlFa
	SGJjoavjPgJdGgT4vWThCQXM9DgT4+yAO
X-Google-Smtp-Source: AGHT+IGY5yLj/I/IkcPxLpksicKcihBsAfqxMOagl8R5SrYJsF+l3779kjiHTiFGMZhZcU8311NzNw==
X-Received: by 2002:a05:6a00:815:b0:730:87b2:e848 with SMTP id d2e1a72fcca58-76e20fae24dmr1088857b3a.5.1755061313110;
        Tue, 12 Aug 2025 22:01:53 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf606978bsm25154871b3a.89.2025.08.12.22.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 22:01:52 -0700 (PDT)
Message-ID: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
Date: Wed, 13 Aug 2025 14:01:47 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Austin Kim <austindh.kim@gmail.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
 syzkaller@googlegroups.com, stable@vger.kernel.org
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
Subject: [BUG] arm64: Sleeping function called from invalid context in
 do_debug_exception on PREEMPT_RT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On a PREEMPT_RT kernel based on v6.16-rc1, I hit the following splat:

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 20466, name: syz.0.1689
| preempt_count: 1, expected: 0
| RCU nest depth: 0, expected: 0
| Preemption disabled at:
| [<ffff800080241600>] debug_exception_enter arch/arm64/mm/fault.c:978 [inline]
| [<ffff800080241600>] do_debug_exception+0x68/0x2fc arch/arm64/mm/fault.c:997
| CPU: 0 UID: 0 PID: 20466 Comm: syz.0.1689 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT
| Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
| Call trace:
|  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
|  __dump_stack+0x30/0x40 lib/dump_stack.c:94
|  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
|  dump_stack+0x1c/0x3c lib/dump_stack.c:129
|  __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
|  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
|  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
|  spin_lock include/linux/spinlock_rt.h:44 [inline]
|  force_sig_info_to_task+0x6c/0x4a8 kernel/signal.c:1302
|  force_sig_fault_to_task kernel/signal.c:1699 [inline]
|  force_sig_fault+0xc4/0x110 kernel/signal.c:1704
|  arm64_force_sig_fault+0x6c/0x80 arch/arm64/kernel/traps.c:265
|  send_user_sigtrap arch/arm64/kernel/debug-monitors.c:237 [inline]
|  single_step_handler+0x1f4/0x36c arch/arm64/kernel/debug-monitors.c:257
|  do_debug_exception+0x154/0x2fc arch/arm64/mm/fault.c:1002
|  el0_dbg+0x44/0x120 arch/arm64/kernel/entry-common.c:756
|  el0t_64_sync_handler+0x3c/0x108 arch/arm64/kernel/entry-common.c:832
|  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600


It seems that commit eaff68b32861 ("arm64: entry: Add entry and exit functions
for debug exception") in 6.17-rc1, also present as 6fb44438a5e1 in mainline,
removed code that previously avoided sleeping context issues when handling
debug exceptions:
Link: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/arch/arm64/mm/fault.c?id=eaff68b3286116d499a3d4e513a36d772faba587

This appears to be triggered when force_sig_fault() is called from
debug exception context, which is not sleepable under PREEMPT_RT.

I understand that this path is primarily for debugging, but I would like
to discuss whether the patch needs some adjustment for PREEMPT_RT.

I also found that the issue can be reproduced depending on the changes
introduced by the following commit:
Link: https://github.com/torvalds/linux/commit/d8bb6718c4d

  arm64: Make debug exception handlers visible from RCU
  Make debug exceptions visible from RCU so that synchronize_rcu()
  correctly tracks the debug exception handler.

  This also introduces sanity checks for user-mode exceptions as same
  as x86's ist_enter()/ist_exit().

  The debug exception can interrupt in idle task. For example, it warns
  if we put a kprobe on a function called from idle task as below.
  The warning message showed that the rcu_read_lock() caused this
  problem. But actually, this means the RCU lost the context which
  was already in NMI/IRQ.

    /sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events
    /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable
    ...

For reference:
- v5.2.10: https://elixir.bootlin.com/linux/v5.2.10/source/arch/arm64/mm/fault.c#L810
- v5.3-rc3: https://elixir.bootlin.com/linux/v5.3-rc3/source/arch/arm64/mm/fault.c#L787


Do we need to restore some form of non-sleeping signal delivery in debug
exception context for PREEMPT_RT, or is there another preferred fix?

Thanks,
Yunseong
