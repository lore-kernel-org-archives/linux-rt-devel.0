Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DC3B8920;
	Wed, 20 May 2026 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315117; cv=none; b=eVyoVNiNwZ++MGEIG3IHM4+5M3Q9PaQGjQgomOMBQu30xwwXiEVBn3L3WKkR0LEv2v2Q+et5wFKtspQDxBh7bXlU1FK97Sr+NmtmwQjpn0DYAuXJSqg97oaph4GIvVjERGN8IJMxPC4/dTV/cmztMNhUkfHdn0EYoUcilGlSK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315117; c=relaxed/simple;
	bh=8luQpYpHEArlHeAmKrN95fhm+q2yTqUrReGzoJt0D1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXAqA4ZKqopw511XTmRo1eP7RhSYKDdOxm5IsrDlW5K72Hhfde82JQBPu4sk6op8OfgwhrB566uopfM85j+07oZ3HaSQ7T0IG3KjeBnYUB5QyoL53TBxrwThmQzAZOTXs5BHC+ah8lNZ9UtxCKrxkD/Dzt6g17/0N64REodwNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hk2DzEnO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hk2DzEnO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yqUTc95zaXzBCvNT6iyCp5NSrSJr7kPxrBu5IuNUhLo=; b=hk2DzEnOkPmw6uDWwtI5SKtmaF
	Qp2HCq2BmdleB3skO3PGeFvUQgPzAsL3cl+IK/9i/ljFEWWrJBnR2csiywvddD3QTKYRXFUsGQwQ/
	teFrfqbZYVecSUyuVJ+F934TBm2BfoaO+4WRUfvdA+ReTkyq3PDexyg7uSlySUQqVU2WgEdE1doCn
	y+wR0zGVhrTuu8BEWB/dQvWukKiD37sk1waPzXgqD+5EAaJ0iSuDl3iNJc3ZBNythSKbaXcz1wUVc
	evUJIV9OALldGCiiMTK+WLkUDfACXzvedH9sTk/Il0kRtRJAkgxarRi5pD88XsHQlFLVq7RVfhtBe
	9xKXr7ow==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPp3h-00000005vta-0sHy;
	Wed, 20 May 2026 22:06:33 +0000
Message-ID: <fec6554d-3639-4c27-9a14-3d3914c51588@infradead.org>
Date: Wed, 20 May 2026 15:06:30 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush
 work
To: Leonardo Bras <leobras.c@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Gary Guo <gary@garyguo.net>, Christian Brauner <brauner@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-2-leobras.c@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260519012754.240804-2-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/18/26 6:27 PM, Leonardo Bras wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c6d79275c6..7102031207c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21775,20 +21775,27 @@ QORIQ DPAA2 FSL-MC BUS DRIVER
>  M:	Ioana Ciornei <ioana.ciornei@nxp.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
>  F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
>  F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
>  F:	drivers/bus/fsl-mc/
>  F:	include/uapi/linux/fsl_mc.h
>  
> +PW Locks
> +M:	Leonardo Bras <leobras.c@gmail.com>
> +S:	Supported
> +F:	Documentation/locking/pwlocks.rst
> +F:	include/linux/pwlocks.h
> +F:	kernel/pwlocks.c

MAINTAINERS entries should be in alphabetical order: PW is not in the
middle of the Q entries.

> +
>  QT1010 MEDIA DRIVER
>  L:	linux-media@vger.kernel.org
>  S:	Orphan
>  W:	https://linuxtv.org
>  Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  F:	drivers/media/tuners/qt1010*
>  
>  QUALCOMM ATH12K WIRELESS DRIVER
>  M:	Jeff Johnson <jjohnson@kernel.org>
>  L:	linux-wireless@vger.kernel.org


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

Overline and underline should be at least as long as the heading text.

> +
> +Some places in the kernel implement a parallel programming strategy
> +consisting on local_locks() for most of the work, and some rare remote
> +operations are scheduled on target cpu. This keeps cache bouncing low since

                            on a target CPU.

> +cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> +kernels, even though the very few remote operations will be expensive due
> +to scheduling overhead.
> +
> +On the other hand, for RT workloads this can represent a problem:
> +scheduling work on remote cpu that are executing low latency tasks

                             CPUs

> +is undesired and can introduce unexpected deadline misses.

      undesirable
?

> +
> +PW locks help to convert sites that use local_locks (for cpu local operations)
> +and queue_work_on (for queueing work remotely, to be executed
> +locally on the owner cpu of the lock) to a spinlocks.

                                         to spinlocks.

> +
> +The lock is declared pw_lock_t type.
> +The lock is initialized with pw_lock_init.
> +The lock is locked with pw_lock (takes a lock and cpu as a parameter).
> +The lock is unlocked with pw_unlock (takes a lock and cpu as a parameter).
> +
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

                      CPU.

> +
> +On the locking functions above, there are the local locking functions
> +(pw_lock_local, pw_trylock_local and pw_unlock_local) that must only
> +be used to access per-CPU data from the CPU that owns that data,
> +and never remotely. They disable preemption/migration and don't require
> +a cpu parameter, making them a replacement for local_lock functions that
> +does not introduce overhead.
> +
> +These should only be used when accessing per-CPU data of the local CPU.
> +

Running "make htmldocs" with this patch says:

Documentation/locking/pwlocks.rst: WARNING: document isn't included in any toctree [toc.not_included]

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

	                 to give the user

> +	  thus reduce interruptions and context switches. On the other hand, it
> +	  increases generated code and will use atomic operations if spinlocks
> +	  are selected.
> +
> +	  If set, will use the default behavior set in PWLOCKS_DEFAULT unless boot

	                                                               unless the boot

> +	  parameter pwlocks is passed with a different behavior.
> +
> +	  If unset, will use the local_lock() + queue_work_on() strategy,
> +	  regardless of the boot parameter or PWLOCKS_DEFAULT.
> +
> +	  Say N if unsure.
> +
> +config PWLOCKS_DEFAULT
> +	bool "Use per-CPU spinlocks by default on PWLOCKS"
> +	depends on PWLOCKS
> +	default n
> +	help
> +	  If set, will use per-CPU spinlocks as default behavior for per-CPU
> +	  remote operations.
> +
> +	  If unset, will use local_lock() + queue_work_on(cpu) as default
> +	  behavior for remote operations.
> +
> +	  Say N if unsure

	           unsure.

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

-- 
~Randy

