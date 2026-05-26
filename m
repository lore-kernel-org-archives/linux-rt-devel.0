Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207731353B
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 May 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822941; cv=none; b=jkTnLr3hP0h807ISNQaUngzO7mxEw/oEJNgbK27ONUJr3OSYxg47eHt4g0Lj4/r/Pv2dAyLecHaUAmaY+PkCr2TysTdZjutlPF7fWGy9shGBGl1mXtYfD+5u15OlXK4fRggFNi77/Hms5JR9KVFO3Iy3iPzy5jNQEcsKK3a8g8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822941; c=relaxed/simple;
	bh=lTrTM+deYxbAbF+eoWHTg/aQtUYUYzTNuDRA0MrLEAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rvu9ik/ZI6M/7AQIoGj6DKSy8xbROrkEOMfxYpCG3E7dITByiCU6h9cQ3NpFnv4MJ70fFD58goKTyWpJo6QGfK1FfMrQeilFO6IMrKw7H3RM36rm83MDUrD0K0+sV9o5nW1sZS2R+CP1iDakRQjEahhPyNGwwHg0Gduiz6zsohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Fbhlw8Pe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Fbhlw8Pe"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 04AC240E30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1779822933; bh=dB5eVTfF0zRDfVbnx1RL/rZVOm/m3B8TjzZiFdbIjUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fbhlw8Peae/8Hn0G1NPZxsR98yGpJoEnjnunxVRipUa/p8k2DOYXmReUgyriFlR9a
	 PBNYfMv2jxeK2gZpaj1+L2TBav0nie5ztMvDq9yzLGzsrlcGRANFjUpqYTmIWOFAJQ
	 ZIsrq+c6yhG/vdCOwxT3+rxOU2Tb9ykSaYe3Zskmz68qZNfsc1dftEyBIWfNGd6By5
	 FxcIq1KClJquic948orLD+YRpnIs/DaTg6h5/prZ9bhv8LbDgV37+tQnuX6GvGELZ1
	 8vYd4KZ7QkBJWo7kqBIIc/NNG/y8FZf+FbJq4b82Hlwmu7RG4hv0d2tC67xYFAHxjC
	 fb4gsW/t4m7mg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 04AC240E30;
	Tue, 26 May 2026 19:15:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Leonardo Bras <leobras.c@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Leonardo Bras <leobras.c@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Harry Yoo
 <harry@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
 <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Randy
 Dunlap <rdunlap@infradead.org>, Feng Tang <feng.tang@linux.alibaba.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco
 Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>, Li RongQing
 <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Thomas
 Gleixner
 <tglx@kernel.org>, Douglas Anderson <dianders@chromium.org>, Gary Guo
 <gary@garyguo.net>, Christian Brauner <brauner@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, Marcelo Tosatti
 <mtosatti@redhat.com>
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush
 work
In-Reply-To: <20260519012754.240804-2-leobras.c@gmail.com>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-2-leobras.c@gmail.com>
Date: Tue, 26 May 2026 13:15:32 -0600
Message-ID: <87tsruvv6z.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Leonardo Bras <leobras.c@gmail.com> writes:

> Some places in the kernel implement a parallel programming strategy
> consisting on local_locks() for most of the work, and some rare remote
> operations are scheduled on target cpu. This keeps cache bouncing low since
> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> kernels, even though the very few remote operations will be expensive due
> to scheduling overhead.

A couple of documentation-related nits:

> ---
>  MAINTAINERS                                   |   7 +
>  .../admin-guide/kernel-parameters.txt         |  10 +
>  Documentation/locking/pwlocks.rst             |  76 +++++

You have added a new RST file here, but haven't added it to the table of
contents in index.rst.  So it won't be part of the docs build.

>  init/Kconfig                                  |  35 +++
>  kernel/Makefile                               |   2 +
>  include/linux/pwlocks.h                       | 265 ++++++++++++++++++
>  kernel/pwlocks.c                              |  47 ++++
>  7 files changed, 442 insertions(+)
>  create mode 100644 Documentation/locking/pwlocks.rst
>  create mode 100644 include/linux/pwlocks.h
>  create mode 100644 kernel/pwlocks.c

[...]

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

The over/underlines should match the text in length.

> +Some places in the kernel implement a parallel programming strategy
> +consisting on local_locks() for most of the work, and some rare remote
> +operations are scheduled on target cpu. This keeps cache bouncing low since
> +cacheline tends to be mostly local, and avoids the cost of locks in non-RT
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
> +
> +The lock is declared pw_lock_t type.
> +The lock is initialized with pw_lock_init.
> +The lock is locked with pw_lock (takes a lock and cpu as a parameter).
> +The lock is unlocked with pw_unlock (takes a lock and cpu as a parameter).

Did you want that to be an itemized list?  If so, put "- " in front of
each line.

> +The pw_lock_irqsave function disables interrupts and saves current interrupt state,
> +cpu as a parameter.
> +
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

This will not render the way you expect it to.  You want a literal block
ere.  So end the text with "...is as follows::"  and indent the entire
literal block.

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

If you write functions like pw_lock_local(), you'll get automatic cross
links to the kerneldoc documentation ... which I'm sure must exist ...

> +be used to access per-CPU data from the CPU that owns that data,
> +and never remotely. They disable preemption/migration and don't require
> +a cpu parameter, making them a replacement for local_lock functions that
> +does not introduce overhead.
> +
> +These should only be used when accessing per-CPU data of the local CPU.
> +

[...]

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
> +
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
> +
> +#define pw_lock_init(lock)							\
> +do {										\
> +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> +		spin_lock_init(lock.sl);					\
> +	else									\
> +		local_lock_init(lock.ll);					\
> +} while (0)

Sigh, I guess I was over-optimistic about kerneldoc comments.

Is there a reason why these aren't inline functions?

Thanks,

jon
