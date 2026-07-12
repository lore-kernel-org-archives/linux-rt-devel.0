Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632F350298
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891928; cv=none; b=Gk6mtQt/CaFOpTBqWumC71NWNb0NTjTVfnKxEKTMhWeTFyZAgJEwNIOSo9goL+AdAT8/DG67rJbkGOjrwDZYA/OWst2eRW2HPh1HvZGG8YS0b7+bg3gS7oh6VNisAgfrJV/x6E/xT6DN05RhLpY13EY0o5EoF9iUwp1YxPknc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891928; c=relaxed/simple;
	bh=y8zaWWRlBXdoCTRTCckJiK4xo6/vhohLPR6vt7YCJ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=EMSSE7W/NkNYEIJ+fqNnXAdzDLQ8i2aTvv/8qhZnBwu2vNQOOsUptYCYgtb7NY5UTRkIoyn1WB8N6NRv10sphbIjtLZAr2hvxu0LOqTZ+wWdR8uJCWA7S5SnnaaeI8WoJzUProTnri0E6rYiKiuXuJP7qAtQcjrHKB7SeVE9U68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKVa3v/1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKVa3v/1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b27c7451so43018135e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783891924; x=1784496724; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZTw5ebndj59SW60Cuk+CY+pvjsLxjMDKRujQQgs+Vk=;
        b=mKVa3v/1KusLjICB2o53DEvAihMb/2kB9iWOq1Lxw+5YrIY/5MJ0Iv9l3CQOHv4o+S
         XC+6abmiLBB50V/C/4rdHNt0C5qAVFiej7FBW11cV3ICQ9sg/Z4PvITjvnt5K768CBBQ
         JZ028mdCJt+78YQPMr0JamzBvfVre3/BUXaTwaMOio+WIyvJB9R9OG7jTki12Hbsjc4J
         4bTRriRqc4yPUy2C7hYV/lEb9uBflC6qhxPoDBHlmabNglaioQCYbUMdVXvRRu2tRvFl
         lC0DVlcWMM/wcPmj7rstzrbkGA3HttEb9ZNA+aUVDKtIuPy5Ls3ukUiW2mQv+q4ztjy5
         JUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783891924; x=1784496724;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kZTw5ebndj59SW60Cuk+CY+pvjsLxjMDKRujQQgs+Vk=;
        b=nCP7BsgN6uInWKHtgw501IFtY+15gLEq7MKxUb4RHF/P42FwOWTnqxULUIimcHmFvF
         dHADCiYa/B95r+9owwI38nbzWesPspYr1e+nr6gc9p7a9U9WjAiig5Cf0SNStDW60npk
         kiS73nOuu8PnmY/Ve44SM+M+cNLm/EZDfFvpuJ1I6rY3BXGLUO5RN+WiU1r0MsPztvMa
         B4p4ACkz1LcVKrxX1kmdewwMoKqvV+7nad4ZOpzf9qrQc+Dduvf6flmmROOAyMwzDMDL
         vdeA/BWOEMIT8nN+7Hzz2Ma8AVLfLjGxshh0JmHQvXcSG2KIqm3tNxYOA0IMzidLPdp5
         1K7w==
X-Forwarded-Encrypted: i=1; AHgh+RpY6HLEMHOdEnZGW4q21FtNwePbHMCB+4i++pD8Fae0V0ZSEM4Q1fjGcop+8IVozWSMYYQ3PpwI2u4aELo/Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz76skypHsPsdkeTfdGfuaxwYF9cd1P4gDyeKHC0Ybao1XSa2Eb
	7BhFseKGnoLhIFA7phujf8K9bbF96ydmqVF6WWZ2Yy89M04veaTHtk0F
X-Gm-Gg: AfdE7ck61ef0RfdVpAipsATQMPzavvZwoSOgKEBxQ0UQGm717Ir/RTZJ1Oxar1oNugv
	stfD2RNpav4cxfSEJZmyDRDrrgg7cfRiZWLL037hhyMiemsrMb6dv9RsfPuPamLg4CP/4Yc/0Iz
	2yuOQsGGQ2W6/oLawWpaQ9pd5qC1v3kvl2Am6an8yV1LRZxDDmY2lM1ANdfSlOWSA6gaSNGoehb
	GdIYv6ELBorGzt+aX2GKybBtgaWlLdti4oHYKq90zZ/FYzoefkwtzAHPv1jtby/faBQi0SpC7LC
	JUtJfCAxlkDRQT4NQbq/G7mCnILYEkWPdebARL42gANyXjWpDp6YSL88Kmk53ciQquHWGOMxvG9
	vRUsLxcaoJKw3h2vNz0lJkrnnAxFc5in0hIe+8xLq2MXH8peZyfiYb5YwuoMxyeXcXNXCzOUGui
	0899SGnXn6zwtIt3qwL3Ak5FOmIGmOavk2
X-Received: by 2002:a05:600c:1c27:b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-493f887ab70mr70822705e9.2.1783891923923;
        Sun, 12 Jul 2026 14:32:03 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm332803075e9.8.2026.07.12.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:32:03 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush work
Date: Sun, 12 Jul 2026 18:32:01 -0300
Message-ID: <alQH0VK2X2smhaWQ@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87tsruvv6z.fsf@trenco.lwn.net>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-2-leobras.c@gmail.com> <87tsruvv6z.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 26, 2026 at 01:15:32PM -0600, Jonathan Corbet wrote:
> Leonardo Bras <leobras.c@gmail.com> writes:
> 
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.

Hi Jonathan, thanks for reviewing!

> 
> A couple of documentation-related nits:
> 
> > ---
> >  MAINTAINERS                                   |   7 +
> >  .../admin-guide/kernel-parameters.txt         |  10 +
> >  Documentation/locking/pwlocks.rst             |  76 +++++
> 
> You have added a new RST file here, but haven't added it to the table of
> contents in index.rst.  So it won't be part of the docs build.

Ooops, will find a place to add it then :)

This part was added by Marcelo, I have no experience on adding docs to the 
kernel tree. Your suggestions will be really useful :)


> 
> >  init/Kconfig                                  |  35 +++
> >  kernel/Makefile                               |   2 +
> >  include/linux/pwlocks.h                       | 265 ++++++++++++++++++
> >  kernel/pwlocks.c                              |  47 ++++
> >  7 files changed, 442 insertions(+)
> >  create mode 100644 Documentation/locking/pwlocks.rst
> >  create mode 100644 include/linux/pwlocks.h
> >  create mode 100644 kernel/pwlocks.c
> 
> [...]
> 
> > diff --git a/Documentation/locking/pwlocks.rst b/Documentation/locking/pwlocks.rst
> > new file mode 100644
> > index 000000000000..09f4a5417bc1
> > --- /dev/null
> > +++ b/Documentation/locking/pwlocks.rst
> > @@ -0,0 +1,76 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=========
> > +PW (Per-CPU Work) locks
> > +=========
> 
> The over/underlines should match the text in length.
> 

Will change!

> > +Some places in the kernel implement a parallel programming strategy
> > +consisting on local_locks() for most of the work, and some rare remote
> > +operations are scheduled on target cpu. This keeps cache bouncing low since
> > +cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > +kernels, even though the very few remote operations will be expensive due
> > +to scheduling overhead.
> > +
> > +On the other hand, for RT workloads this can represent a problem:
> > +scheduling work on remote cpu that are executing low latency tasks
> > +is undesired and can introduce unexpected deadline misses.
> > +
> > +PW locks help to convert sites that use local_locks (for cpu local operations)
> > +and queue_work_on (for queueing work remotely, to be executed
> > +locally on the owner cpu of the lock) to a spinlocks.
> > +
> > +The lock is declared pw_lock_t type.
> > +The lock is initialized with pw_lock_init.
> > +The lock is locked with pw_lock (takes a lock and cpu as a parameter).
> > +The lock is unlocked with pw_unlock (takes a lock and cpu as a parameter).
> 
> Did you want that to be an itemized list?  If so, put "- " in front of
> each line.

Oh, good idea!

> 
> > +The pw_lock_irqsave function disables interrupts and saves current interrupt state,
> > +cpu as a parameter.
> > +
> > +For trylock variant, there is the pw_trylock_t type, initialized with
> > +pw_trylock_init. Then the corresponding pw_trylock and pw_trylock_irqsave.
> > +
> > +work_struct should be replaced by pw_struct, which contains a cpu parameter
> > +(owner cpu of the lock), initialized by INIT_PW.
> > +
> > +The queue work related functions (analogous to queue_work_on and flush_work) are:
> > +pw_queue_on and pw_flush.
> > +
> > +The behaviour of the PW lock functions is as follows:
> > +
> > +* !CONFIG_PWLOCKS (or CONFIG_PWLOCKS and pwlocks=off kernel boot parameter):
> > +        - pw_lock:			local_lock
> > +        - pw_lock_irqsave:		local_lock_irqsave
> > +        - pw_trylock:			local_trylock
> > +        - pw_trylock_irqsave:		local_trylock_irqsave
> > +        - pw_unlock:			local_unlock
> > +        - pw_lock_local:		local_lock
> > +        - pw_trylock_local:		local_trylock
> > +        - pw_unlock_local:		local_unlock
> > +        - pw_queue_on:         		queue_work_on
> > +        - pw_flush:	            	flush_work
> 
> This will not render the way you expect it to.  You want a literal block
> ere.  So end the text with "...is as follows::"  and indent the entire
> literal block.

Will do like this!

> 
> > +* CONFIG_PWLOCKS (and CONFIG_PWLOCKS_DEFAULT=y or pwlocks=on kernel boot parameter),
> > +        - pw_lock:			spin_lock
> > +        - pw_lock_irqsave:		spin_lock_irqsave
> > +        - pw_trylock:			spin_trylock
> > +        - pw_trylock_irqsave:		spin_trylock_irqsave
> > +        - pw_unlock:			spin_unlock
> > +        - pw_lock_local:		preempt_disable OR migrate_disable + spin_lock
> > +        - pw_trylock_local:		preempt_disable OR migrate_disable + spin_trylock
> > +        - pw_unlock_local:		preempt_enable OR migrate_enable + spin_unlock
> > +        - pw_queue_on:         		executes work function on caller cpu
> > +        - pw_flush:            		empty
> > +
> > +pw_get_cpu(work_struct), to be called from within per-cpu work function,
> > +returns the target cpu.
> > +
> > +On the locking functions above, there are the local locking functions
> > +(pw_lock_local, pw_trylock_local and pw_unlock_local) that must only
> 
> If you write functions like pw_lock_local(), you'll get automatic cross
> links to the kerneldoc documentation ... which I'm sure must exist ...

They will be added at this patch, so I will add the () so the link works :)

> 
> > +be used to access per-CPU data from the CPU that owns that data,
> > +and never remotely. They disable preemption/migration and don't require
> > +a cpu parameter, making them a replacement for local_lock functions that
> > +does not introduce overhead.
> > +
> > +These should only be used when accessing per-CPU data of the local CPU.
> > +
> 
> [...]
> 
> > +#else /* CONFIG_PWLOCKS */
> > +
> > +DECLARE_STATIC_KEY_MAYBE(CONFIG_PWLOCKS_DEFAULT, pw_sl);
> > +
> > +typedef union {
> > +	spinlock_t sl;
> > +	local_lock_t ll;
> > +} pw_lock_t;
> > +
> > +typedef union {
> > +	spinlock_t sl;
> > +	local_trylock_t ll;
> > +} pw_trylock_t;
> > +
> > +struct pw_struct {
> > +	struct work_struct work;
> > +	int cpu;
> > +};
> > +
> > +#ifdef CONFIG_PREEMPT_RT
> > +#define preempt_or_migrate_disable migrate_disable
> > +#define preempt_or_migrate_enable migrate_enable
> > +#else
> > +#define preempt_or_migrate_disable preempt_disable
> > +#define preempt_or_migrate_enable preempt_enable
> > +#endif
> > +
> > +#define pw_lock_init(lock)							\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		spin_lock_init(lock.sl);					\
> > +	else									\
> > +		local_lock_init(lock.ll);					\
> > +} while (0)
> 
> Sigh, I guess I was over-optimistic about kerneldoc comments.
> 
> Is there a reason why these aren't inline functions?
> 

I could not find a way of making *_irqsave() an inline function, so ended 
up using macros as they looked simple enough (and the underlying functions 
would take care of type check). Already working on converting as many of 
the above as possible. 

Thanks again for reviewing!

Leo
