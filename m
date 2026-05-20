Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E783D8128
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284920; cv=none; b=aHQ+Ot/wJtnf58HwyxhFW5ABvwqm5CgAWKHiwZE87mDSkp7FHmfc7Kh9D5tf2RlnYPwBg4WzmJcxBrdc5kCa90+LOumUsYx9xtNREPId4Dw/PZi5Jh9bXOW5T3n/41XKvd7jAdDYZ5A0NL3BLTShWylkx9iXC+cwPxHa1+iw/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284920; c=relaxed/simple;
	bh=OCynP4w5lxHgU/SSQG1QgQCFG2wFxhRcxoy3KPUO/08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ4/gXzO0VaVaO7zCtvIasn6+kvNmC77JD0sVh/kPG8ulVnUP5Cx/XQPalaHMxy0NhpSbk/6fO9SG7ifsK0UxX80JEmwZPnQG9ZQ1aepbzZXNfEMWclqiVlns8qHRq0auZpwZXHRrbJd81t/KWrN68ibDj2pdjifI17iDJY+Vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byvhboAQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VP9GcVCh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byvhboAQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VP9GcVCh"
Date: Wed, 20 May 2026 15:48:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779284916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PIwz7i+0vxj6uE8KaagTQfRIpVbvdcmnBp/C+6NBNNU=;
	b=byvhboAQdRlRfXuYyRJ0xVcKQ3p25eFgWKo8RhGd3M602cZ0PyL5SnnJH+D+WOHt24jxZT
	exr/Lcnow2gwmB3+8Dwkq4bUVZmUoZ8zppQGDekRoVok+8jPPg5yDara1/SB5gzE4N/PCG
	nIxqoLSFl1OQmcN2nKbDMbVImoGbZT1TTfZrwJpWmRCmDsjB5JolSqosVUlCSMler0Qqyf
	OzYL76fzD9ADY6E4lGQiL+SHHRmE0ucvk2By1EjYIOo+jZcJ38aemEXsOFgzDTgWMDkGva
	6f5spJxYqL6P7MUd7tvQfPen43cW2D5IV005G/njrGSYsDatdlpmADHp5d864Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779284916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PIwz7i+0vxj6uE8KaagTQfRIpVbvdcmnBp/C+6NBNNU=;
	b=VP9GcVChYssWUWbr6kLa3386edZkgucRcPpz1Y3hxUw2vGzoEJGIMEPptwM2fPy0aYqInb
	Wq/7KPvtt6k5KhCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>, Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush
 work
Message-ID: <20260520134832.WS7TrMnu@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-2-leobras.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519012754.240804-2-leobras.c@gmail.com>

On 2026-05-18 22:27:47 [-0300], Leonardo Bras wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..68c8a6f9d227 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2810,20 +2810,30 @@ Kernel parameters
>  			  If a queue's affinity mask contains only isolated
>  			  CPUs then this parameter has no effect on the
>  			  interrupt routing decision, though interrupts are
>  			  only delivered when tasks running on those
>  			  isolated CPUs submit IO. IO submitted on
>  			  housekeeping CPUs has no influence on those
>  			  queues.
>  
>  			The format of <cpu-list> is described above.
>  
> +	pwlocks=	[KNL,SMP] Select a behavior on per-CPU resource sharing
> +			and remote interference mechanism on a kernel built with
> +			CONFIG_PWLOCKS.
> +			Format: { "0" | "1" }
> +			0 - local_lock() + queue_work_on(remote_cpu)
> +			1 - spin_lock() for both local and remote operations
> +
> +			Selecting 1 may be interesting for systems that want
> +			to avoid interruption & context switches from IPIs.
> +

This documentation is supposed to be for an administrator/ user of the
system. Exposing him to underlying kernel technique shouldn't happen.
It does not explain the users/ outcome so it sounds like best hope.

>  	iucv=		[HW,NET]
>  
>  	ivrs_ioapic	[HW,X86-64]
>  			Provide an override to the IOAPIC-ID<->DEVICE-ID
>  			mapping provided in the IVRS ACPI table.
>  			By default, PCI segment is 0, and can be omitted.
>  
>  			For example, to map IOAPIC-ID decimal 10 to
>  			PCI segment 0x1 and PCI device 00:14.0,
>  			write the parameter as:
> diff --git a/Documentation/locking/pwlocks.rst b/Documentation/locking/pwlocks.rst
> new file mode 100644
> index 000000000000..09f4a5417bc1
> --- /dev/null
> +++ b/Documentation/locking/pwlocks.rst
> @@ -0,0 +1,76 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========
> +PW (Per-CPU Work) locks
> +=========
> +
> +Some places in the kernel implement a parallel programming strategy
> +consisting on local_locks() for most of the work, and some rare remote
> +operations are scheduled on target cpu. This keeps cache bouncing low since
> +cacheline tends to be mostly local, and avoids the cost of locks in non-RT

PREEMPT_RT can be spelled out if you mean it so it is not confused with
other meanings of the two letters.

> +kernels, even though the very few remote operations will be expensive due
> +to scheduling overhead.
> +
> +On the other hand, for RT workloads this can represent a problem:
> +scheduling work on remote cpu that are executing low latency tasks
> +is undesired and can introduce unexpected deadline misses.
> +
> +PW locks help to convert sites that use local_locks (for cpu local operations)
> +and queue_work_on (for queueing work remotely, to be executed
> +locally on the owner cpu of the lock) to a spinlocks.

not spinlocks.

> +
> +The lock is declared pw_lock_t type.
> +The lock is initialized with pw_lock_init.
> +The lock is locked with pw_lock (takes a lock and cpu as a parameter).
> +The lock is unlocked with pw_unlock (takes a lock and cpu as a parameter).

If it is a function, it should end with ()

> +The pw_lock_irqsave function disables interrupts and saves current interrupt state,
> +cpu as a parameter.

CPU.

> +For trylock variant, there is the pw_trylock_t type, initialized with
> +pw_trylock_init. Then the corresponding pw_trylock and pw_trylock_irqsave.
> +
> +work_struct should be replaced by pw_struct, which contains a cpu parameter
> +(owner cpu of the lock), initialized by INIT_PW.
> +
> +The queue work related functions (analogous to queue_work_on and flush_work) are:
> +pw_queue_on and pw_flush.
> +
> +The behaviour of the PW lock functions is as follows:
> +
> +* !CONFIG_PWLOCKS (or CONFIG_PWLOCKS and pwlocks=off kernel boot parameter):
> +        - pw_lock:			local_lock
> +        - pw_lock_irqsave:		local_lock_irqsave
> +        - pw_trylock:			local_trylock
> +        - pw_trylock_irqsave:		local_trylock_irqsave
> +        - pw_unlock:			local_unlock
> +        - pw_lock_local:		local_lock
> +        - pw_trylock_local:		local_trylock
> +        - pw_unlock_local:		local_unlock
> +        - pw_queue_on:         		queue_work_on
> +        - pw_flush:	            	flush_work
> +
> +* CONFIG_PWLOCKS (and CONFIG_PWLOCKS_DEFAULT=y or pwlocks=on kernel boot parameter),
> +        - pw_lock:			spin_lock
> +        - pw_lock_irqsave:		spin_lock_irqsave
> +        - pw_trylock:			spin_trylock
> +        - pw_trylock_irqsave:		spin_trylock_irqsave
> +        - pw_unlock:			spin_unlock
> +        - pw_lock_local:		preempt_disable OR migrate_disable + spin_lock
> +        - pw_trylock_local:		preempt_disable OR migrate_disable + spin_trylock
> +        - pw_unlock_local:		preempt_enable OR migrate_enable + spin_unlock
> +        - pw_queue_on:         		executes work function on caller cpu
> +        - pw_flush:            		empty
> +
> +pw_get_cpu(work_struct), to be called from within per-cpu work function,
> +returns the target cpu.
> +
> +On the locking functions above, there are the local locking functions
> +(pw_lock_local, pw_trylock_local and pw_unlock_local) that must only
> +be used to access per-CPU data from the CPU that owns that data,
> +and never remotely. They disable preemption/migration and don't require
> +a cpu parameter, making them a replacement for local_lock functions that
> +does not introduce overhead.

Why do you need to either the one or the other? My only guess is that
migrate_disable() is sufficient but you prefer preempt_disable() on
!PREEMPT_RT because it is cheaper.

> +These should only be used when accessing per-CPU data of the local CPU.
> +
> diff --git a/init/Kconfig b/init/Kconfig
> index 2937c4d308ae..3fb751dc4530 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -764,20 +764,55 @@ config CPU_ISOLATION
>  	depends on SMP
>  	default y
>  	help
>  	  Make sure that CPUs running critical tasks are not disturbed by
>  	  any source of "noise" such as unbound workqueues, timers, kthreads...
>  	  Unbound jobs get offloaded to housekeeping CPUs. This is driven by
>  	  the "isolcpus=" boot parameter.
>  
>  	  Say Y if unsure.
>  
> +config PWLOCKS
> +	bool "Per-CPU Work locks"
> +	depends on SMP || COMPILE_TEST
> +	default n
> +	help
> +	  Allow changing the behavior on per-CPU resource sharing with cache,
> +	  from the regular local_locks() + queue_work_on(remote_cpu) to using
> +	  per-CPU spinlocks on both local and remote operations.
> +
> +	  This is useful to give user the option on reducing IPIs to CPUs, and
> +	  thus reduce interruptions and context switches. On the other hand, it
> +	  increases generated code and will use atomic operations if spinlocks
> +	  are selected.

I think the goal is to avoid scheduling a task on a remote CPU to get
something done.

> +
> +	  If set, will use the default behavior set in PWLOCKS_DEFAULT unless boot
> +	  parameter pwlocks is passed with a different behavior.
> +
> +	  If unset, will use the local_lock() + queue_work_on() strategy,
> +	  regardless of the boot parameter or PWLOCKS_DEFAULT.

This sounds like it affects the greater kernel.

> +	  Say N if unsure.
> +
> +config PWLOCKS_DEFAULT
> +	bool "Use per-CPU spinlocks by default on PWLOCKS"
> +	depends on PWLOCKS
> +	default n

n is default.

> +	help
> +	  If set, will use per-CPU spinlocks as default behavior for per-CPU
> +	  remote operations.
> +
> +	  If unset, will use local_lock() + queue_work_on(cpu) as default
> +	  behavior for remote operations.
> +
> +	  Say N if unsure
> +
>  source "kernel/rcu/Kconfig"
>  
>  config IKCONFIG
>  	tristate "Kernel .config support"
>  	help
>  	  This option enables the complete Linux kernel ".config" file
>  	  contents to be saved in the kernel. It provides documentation
>  	  of which kernel options are used in a running kernel or in an
>  	  on-disk kernel.  This information can be extracted from the kernel
>  	  image file with the script scripts/extract-ikconfig and used as
> diff --git a/include/linux/pwlocks.h b/include/linux/pwlocks.h
> new file mode 100644
> index 000000000000..3d79621655f9
> --- /dev/null
> +++ b/include/linux/pwlocks.h
> @@ -0,0 +1,265 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PWLOCKS_H
> +#define _LINUX_PWLOCKS_H
> +
> +#include "linux/spinlock.h"
> +#include "linux/local_lock.h"
> +#include "linux/workqueue.h"
> +
> +#ifndef CONFIG_PWLOCKS
> +
> +typedef local_lock_t pw_lock_t;
> +typedef local_trylock_t pw_trylock_t;
> +
> +struct pw_struct {
> +	struct work_struct work;
> +};
> +
> +#define pw_lock_init(lock)				\
> +	local_lock_init(lock)
> +
> +#define pw_trylock_init(lock)				\
> +	local_trylock_init(lock)
> +
> +#define pw_lock(lock, cpu)				\
> +	local_lock(lock)
> +
> +#define pw_lock_local(lock)				\
> +	local_lock(lock)
> +
> +#define pw_lock_irqsave(lock, flags, cpu)		\
> +	local_lock_irqsave(lock, flags)

The part where you have a `cpu' argument which is not used is entirely
confusing.

> +
> +#define pw_lock_local_irqsave(lock, flags)		\
> +	local_lock_irqsave(lock, flags)
> +
> +#define pw_trylock(lock, cpu)				\
> +	local_trylock(lock)
> +
> +#define pw_trylock_local(lock)				\
> +	local_trylock(lock)
> +
> +#define pw_trylock_irqsave(lock, flags, cpu)		\
> +	local_trylock_irqsave(lock, flags)
> +
> +#define pw_unlock(lock, cpu)				\
> +	local_unlock(lock)
> +
> +#define pw_unlock_local(lock)				\
> +	local_unlock(lock)
> +
> +#define pw_unlock_irqrestore(lock, flags, cpu)		\
> +	local_unlock_irqrestore(lock, flags)
> +
> +#define pw_unlock_local_irqrestore(lock, flags)		\
> +	local_unlock_irqrestore(lock, flags)
> +
> +#define pw_lockdep_assert_held(lock)			\
> +	lockdep_assert_held(lock)
> +
> +#define pw_queue_on(c, wq, pw)				\
> +	queue_work_on(c, wq, &(pw)->work)
> +
> +#define pw_flush(pw)					\
> +	flush_work(&(pw)->work)
> +
> +#define pw_get_cpu(pw)	smp_processor_id()
> +
> +#define pw_is_cpu_remote(cpu)		(false)
> +
> +#define INIT_PW(pw, func, c)				\
> +	INIT_WORK(&(pw)->work, (func))
> +
> +#else /* CONFIG_PWLOCKS */
> +
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_PWLOCKS_DEFAULT, pw_sl);
> +
> +typedef union {
> +	spinlock_t sl;
> +	local_lock_t ll;
> +} pw_lock_t;
> +
> +typedef union {
> +	spinlock_t sl;
> +	local_trylock_t ll;
> +} pw_trylock_t;

Why do you use local_trylock_t ? Its use case is different compared to
local_lock_t. _IF_ you are fine with local_trylock_t then you should be
able to deal with a per-CPU spinlock_t and none of this should be
needed.

> +struct pw_struct {
> +	struct work_struct work;
> +	int cpu;
> +};
> +
> +#ifdef CONFIG_PREEMPT_RT
> +#define preempt_or_migrate_disable migrate_disable
> +#define preempt_or_migrate_enable migrate_enable
> +#else
> +#define preempt_or_migrate_disable preempt_disable
> +#define preempt_or_migrate_enable preempt_enable
> +#endif

if then () but this looks terrible.

> +
> +#define pw_lock_init(lock)							\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		spin_lock_init(lock.sl);					\
> +	else									\
> +		local_lock_init(lock.ll);					\
> +} while (0)
> +
> +#define pw_trylock_init(lock)							\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		spin_lock_init(lock.sl);					\
> +	else									\
> +		local_trylock_init(lock.ll);					\
> +} while (0)
> +
> +#define pw_lock(lock, cpu)							\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		spin_lock(per_cpu_ptr(lock.sl, cpu));				\
> +	else									\
> +		local_lock(lock.ll);						\
> +} while (0)
> +
> +#define pw_lock_local(lock)							\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> +		preempt_or_migrate_disable();					\
> +		spin_lock(this_cpu_ptr(lock.sl));				\
> +	} else {								\
> +		local_lock(lock.ll);						\
> +	}									\
> +} while (0)
> +
> +#define pw_lock_irqsave(lock, flags, cpu)					\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		spin_lock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);	\
> +	else									\
> +		local_lock_irqsave(lock.ll, flags);				\
> +} while (0)
> +
> +#define pw_lock_local_irqsave(lock, flags)					\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> +		preempt_or_migrate_disable();					\
> +		spin_lock_irqsave(this_cpu_ptr(lock.sl), flags);		\
> +	} else {								\
> +		local_lock_irqsave(lock.ll, flags);				\
> +	}									\
> +} while (0)
> +
> +#define pw_trylock(lock, cpu)							\
> +({										\
> +	int t;									\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		t = spin_trylock(per_cpu_ptr(lock.sl, cpu));			\
> +	else									\
> +		t = local_trylock(lock.ll);					\
> +	t;									\
> +})
> +
> +#define pw_trylock_local(lock)							\
> +({										\
> +	int t;									\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> +		preempt_or_migrate_disable();					\
> +		t = spin_trylock(this_cpu_ptr(lock.sl));			\
> +		if (!t)								\
> +			preempt_or_migrate_enable();				\
> +	} else {								\
> +		t = local_trylock(lock.ll);					\
> +	}									\
> +	t;									\
> +})
> +
> +#define pw_trylock_irqsave(lock, flags, cpu)					\
> +({										\
> +	int t;									\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		t = spin_trylock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);	\
> +	else									\
> +		t = local_trylock_irqsave(lock.ll, flags);			\
> +	t;									\
> +})
> +
> +#define pw_unlock(lock, cpu)							\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		spin_unlock(per_cpu_ptr(lock.sl, cpu));			\
> +	else									\
> +		local_unlock(lock.ll);					\
> +} while (0)
> +
> +#define pw_unlock_local(lock)							\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> +		spin_unlock(this_cpu_ptr(lock.sl));				\
> +		preempt_or_migrate_enable();					\
> +	} else {								\
> +		local_unlock(lock.ll);						\
> +	}									\
> +} while (0)
> +
> +#define pw_unlock_irqrestore(lock, flags, cpu)					\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		spin_unlock_irqrestore(per_cpu_ptr(lock.sl, cpu), flags);	\
> +	else									\
> +		local_unlock_irqrestore(lock.ll, flags);			\
> +} while (0)
> +
> +#define pw_unlock_local_irqrestore(lock, flags)					\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> +		spin_unlock_irqrestore(this_cpu_ptr(lock.sl), flags);	\
> +		preempt_or_migrate_enable();					\
> +	} else {								\
> +		local_unlock_irqrestore(lock.ll, flags);			\
> +	}									\
> +} while (0)
> +
> +#define pw_lockdep_assert_held(lock)						\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		lockdep_assert_held(this_cpu_ptr(lock.sl));			\
> +	else									\
> +		lockdep_assert_held(this_cpu_ptr(lock.ll));			\
> +} while (0)
> +
> +#define pw_queue_on(c, wq, pw)							\
> +do {										\
> +	int __c = c;								\
> +	struct pw_struct *__pw = (pw);						\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> +		WARN_ON((__c) != __pw->cpu);					\
> +		__pw->work.func(&__pw->work);					\
> +	} else {								\
> +		queue_work_on(__c, wq, &(__pw)->work);				\
> +	}									\
> +} while (0)
> +
> +/*
> + * Does nothing if PWLOCKS is set to use spinlock, as the task is already done at the
> + * time pw_queue_on() returns.
> + */
> +#define pw_flush(pw)								\
> +do {										\
> +	struct pw_struct *__pw = (pw);						\
> +	if (!static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		flush_work(&__pw->work);					\
> +} while (0)

I don't think this should be a collection of macros. Either proper
functions or static inline _if_ this is performance critical for some
reason.

> +
> +#define pw_get_cpu(w)			container_of((w), struct pw_struct, work)->cpu
> +
> +#define pw_is_cpu_remote(cpu)		((cpu) != smp_processor_id())
> +
> +#define INIT_PW(pw, func, c)							\
> +do {										\
> +	struct pw_struct *__pw = (pw);						\
> +	INIT_WORK(&__pw->work, (func));						\
> +	__pw->cpu = (c);							\
> +} while (0)
> +
> +#endif /* CONFIG_PWLOCKS */
> +#endif /* LINUX_PWLOCKS_H */
> diff --git a/kernel/pwlocks.c b/kernel/pwlocks.c
> new file mode 100644
> index 000000000000..1ebf5cb979b9
> --- /dev/null
> +++ b/kernel/pwlocks.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/export.h"
> +#include <linux/sched.h>
> +#include <linux/pwlocks.h>
> +#include <linux/string.h>
> +#include <linux/sched/isolation.h>
> +
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_PWLOCKS_DEFAULT, pw_sl);
> +EXPORT_SYMBOL(pw_sl);
> +
> +static bool pwlocks_param_specified;
> +
> +static int __init pwlocks_setup(char *str)
> +{
> +	int opt;
> +
> +	if (!get_option(&str, &opt)) {
> +		pr_warn("PWLOCKS: invalid pwlocks parameter: %s, ignoring.\n", str);
> +		return 0;
> +	}
> +
> +	if (opt)
> +		static_branch_enable(&pw_sl);
> +	else
> +		static_branch_disable(&pw_sl);
> +
> +	pwlocks_param_specified = true;
> +
> +	return 1;
> +}
> +__setup("pwlocks=", pwlocks_setup);
> +
> +/*
> + * Enable PWLOCKS if CPUs want to avoid kernel noise.
> + */
> +static int __init pwlocks_init(void)
> +{
> +	if (pwlocks_param_specified)
> +		return 0;
> +
> +	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> +		static_branch_enable(&pw_sl);

How likely is it, that you you had users before late_initcall()? Also
can it happen that one of them uses one function to lock and the other
unlock in this brief window? There is no check if this was used before
static_branch usage.

> +
> +	return 0;
> +}
> +
> +late_initcall(pwlocks_init);

Sebastian
