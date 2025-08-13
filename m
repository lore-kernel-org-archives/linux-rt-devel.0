Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7D2EFDA9
	for <linux-rt-devel@lists.linux.dev>; Wed, 13 Aug 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085443; cv=none; b=f1Q2itbjDQPTJRy2Wi/emImaxwi6VASfDGUP/ED9msS4uu9IS/ISB3QL857WlQQKU348N+ILSSMOILfNqlhsoF3kbboFRgrTj+0DzRaIgMF2J0dgk5uxCg6AB9lsmoMU1Tw/w71qmXauqlBUYKx3Lrfpx2CIAfgRWN9Lgl0FzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085443; c=relaxed/simple;
	bh=Zf2QhI8jQ0RJ3JTvKnj4feUNlf+wUitU/3CBcHEaS3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE5RFJ/k4zVWmsiszpdME0Ti1ezb306RPRFcRhr3xVUgKnEXPJ6WD16EoWEDzlq0Kt/jAQ1X7SR1Dydq5tSjQZtTCDgq5SBKOlFeDFJGW2mbTFkQXbL8pA772ZMLy0XWFLoh7rIIJkTHsyYEEaD+Yi/1GryVN1OcJGed/rjLLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 354C712FC;
	Wed, 13 Aug 2025 04:43:52 -0700 (PDT)
Received: from [10.57.1.244] (unknown [10.57.1.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BC853F738;
	Wed, 13 Aug 2025 04:43:57 -0700 (PDT)
Message-ID: <0d90f4c0-3eb8-4004-b22e-1a840d69fb50@arm.com>
Date: Wed, 13 Aug 2025 12:43:50 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] arm64: Sleeping function called from invalid context in
 do_debug_exception on PREEMPT_RT
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Yunseong Kim <ysk@kzalloc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Austin Kim <austindh.kim@gmail.com>,
 linux-rt-devel@lists.linux.dev, syzkaller@googlegroups.com,
 stable@vger.kernel.org, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
 <aJw3L7B7u5qAPOMz@e129823.arm.com>
 <17f91b9a-0a3a-47e1-bdfb-06237ae5da55@kzalloc.com>
 <aJxT2ie1wW2+/OCg@e129823.arm.com> <aJxjvh4sAcUOJT2V@uudg.org>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <aJxjvh4sAcUOJT2V@uudg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 13/08/2025 11:06, Luis Claudio R. Goncalves wrote:
> On Wed, Aug 13, 2025 at 09:59:06AM +0100, Yeoreum Yun wrote:
>> +Ada Couprie Diaz
Thanks for the ping !
>>> Hi Yeoreum,
>>>
>>> Thank you for pointing it!
>>>
>>> On 8/13/25 3:56 PM, Yeoreum Yun wrote:
>>>> Hi Yunseong,
>>>>
>>>>> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>>>> | in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 20466, name: syz.0.1689
>>>>> | preempt_count: 1, expected: 0
>>>>> | RCU nest depth: 0, expected: 0
>>>>> | Preemption disabled at:
>>>>> | [<ffff800080241600>] debug_exception_enter arch/arm64/mm/fault.c:978 [inline]
>>>>> | [<ffff800080241600>] do_debug_exception+0x68/0x2fc arch/arm64/mm/fault.c:997
>>>>> | CPU: 0 UID: 0 PID: 20466 Comm: syz.0.1689 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT
>>>>> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
>>>>> | Call trace:
>>>>> |  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
>>>>> |  __dump_stack+0x30/0x40 lib/dump_stack.c:94
>>>>> |  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
>>>>> |  dump_stack+0x1c/0x3c lib/dump_stack.c:129
>>>>> |  __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
>>>>> |  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>>>>> |  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
>>>>> |  spin_lock include/linux/spinlock_rt.h:44 [inline]
>>>>> |  force_sig_info_to_task+0x6c/0x4a8 kernel/signal.c:1302
>>>>> |  force_sig_fault_to_task kernel/signal.c:1699 [inline]
>>>>> |  force_sig_fault+0xc4/0x110 kernel/signal.c:1704
>>>>> |  arm64_force_sig_fault+0x6c/0x80 arch/arm64/kernel/traps.c:265
>>>>> |  send_user_sigtrap arch/arm64/kernel/debug-monitors.c:237 [inline]
>>>>> |  single_step_handler+0x1f4/0x36c arch/arm64/kernel/debug-monitors.c:257
>>>>> |  do_debug_exception+0x154/0x2fc arch/arm64/mm/fault.c:1002
>>>>> |  el0_dbg+0x44/0x120 arch/arm64/kernel/entry-common.c:756
>>>>> |  el0t_64_sync_handler+0x3c/0x108 arch/arm64/kernel/entry-common.c:832
>>>>> |  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600
>>>>>
>>>>>
>>>>> It seems that commit eaff68b32861 ("arm64: entry: Add entry and exit functions
>>>>> for debug exception") in 6.17-rc1, also present as 6fb44438a5e1 in mainline,
>>>>> removed code that previously avoided sleeping context issues when handling
>>>>> debug exceptions:
>>>>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/arch/arm64/mm/fault.c?id=eaff68b3286116d499a3d4e513a36d772faba587
>>>> No. Her patch commit 31575e11ecf7 (arm64: debug: split brk64 exception entry)
>>>> solves your splat since el0_brk64() doesn't call debug_exception_enter()
>>>> by spliting el0/el1 brk64 entry exception entry.
>>>>
>>>> Formerly, el(0/1)_dbg() are handled in do_debug_exception() together
>>>> and it calls debug_exception_enter() disabling preemption and this makes
>>>> your splat while handling brk excepttion from el0.
That's correct : one of the goal of the series was to be able to
adapt each debug exception handler to what is needed,
which allowed us to keep preemption enabled, or re-enable it
much earlier, to prevent issues as above for some exceptions.
>>> Do you think a fix is necessary if this issue also affects the LTS kernel
>>> before 6.17-rc1? As far as I know, most production RT kernels are still
>>> based on the existing LTS versions.
Luis originally reported the issue on kernels 6.13-rt and 6.14-rc1[1].
After some quick testing, the issue is present on
6.1-rt, 6.6-rt and 6.12-rt as well.
5.15-rt either doesn't have the issue, or doesn't report it.
>> IMHO, I think her patch should be backedported.
> I also strongly suggest backporting Ada's patch series, as without them
> using anything that resorts to debug exceptions (ptrace, gdb, ...) on
> aarch64 with PREEMPT_RT enabled may result in a backtrace or worse.
>
> Luis
Hopefully it shouldn't be too hard to backport for recent kernels,
as I don't think those areas change a lot, but I haven't looked into it.

I'm not sure when I would have time to work on backporting, but
I'd be happy to help anyway or do it if I have the time in the future,
given there seems to be some interest (and good reasons).
>> [0]: https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@arm.com/
>>
>> Thanks.
>>
>> --
>> Sincerely,
>> Yeoreum Yun
Best,
Ada
[1]: https://lore.kernel.org/linux-arm-kernel/Z6YW_Kx4S2tmj2BP@uudg.org/
