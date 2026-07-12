Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDB3AA1B8
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889394; cv=none; b=B5ikG4l33pJlGRoP2JjdoX3ShKz1RpVeZneoZ2TDMZLYEpz0nWcBYvwK2Xtog0CTJp0+1lGbsFE0Ux1kNwUQw5dhzRQ90SfOWxzyVP3I5ME1KOSdwB175LmXo5oEOqXmVzNNI7E+0+YT6eSYftWl0YxGKtdMXjr1kWqQ4didvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889394; c=relaxed/simple;
	bh=QQWiDW0S3JoSbdmOL3Bxc1tS2wVQ+1NCCTx5oBu/RnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=WrNF2lJPJNePhfZixPGy2DcyimXzcdfEj8Ny+B7tLoWfvTzSR+3QLih23r3I7dO2l+rX7GOnrqNMhI1kgntjviUHaGG6ZBIeZZmXhQ2r15rFOgyVqOKgGvD/DW0KGP1F8rZyd0H6j1EYL6Od7q/qYmCNpxWZ9eg5xj6No7a/Scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCvgYr+D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCvgYr+D"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1266600f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783889390; x=1784494190; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDEBrmK5ELlZI3KMGYQTdjOrzTJtzhLAoIt0p9CXoVI=;
        b=TCvgYr+DwNqiCJu0JKvdmMHvjvduHFAF30Y3Dnl54RP8nDQfBy6Vl52LvmeorOn+sH
         oMhD3DdZZJ5BQkjkcUdZY9qF06yvFRIJcrQ+GGu7Ausqxk8YNMufPy2jkHzyxDt36qnq
         zf3EaJgB9i4oCRL2iTALOayw39ax81EllK/SNQVO/MpbUT9iIye0Ya8cbvh+VXpgN369
         vago3mPWhaZhgrbzbhXMNd7t/powuHlQ4qOOrvDnZ5+QU9G4mLkciBRB1wUX++4XCPWy
         Gxv3CbGUoCgNF9pNxlozz1xkVhpYOF0JdzT+VSLNrErvm/VW9VPSQkBVJnM6pGTa2Q6l
         K+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783889390; x=1784494190;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iDEBrmK5ELlZI3KMGYQTdjOrzTJtzhLAoIt0p9CXoVI=;
        b=GSd2cC2bS23sOoeZB3ZzgOLTKgUaqVpeRSHGtwsQleW1mSkIkgM2vg9Sy4YXYmzBxC
         bmDVEDVwN7bMfL5u/Bfrf5tI+bvXhsuRjoPbZmUTRY8uVLLu0vJrguFCppT9QGicyFkf
         tR423+K7MVRzvM6pdnJBpcV5xeL1OCLRma9gTQwbbARrtcnZPpWLdqplvt7pIch540LP
         rQ8isK3k/nbfBInumDlcdhy6I8IU80fSOy3iAbDU+2AA25ke7AygAQh8ccclhOkPcUje
         7AYU1oiFUbHuYuIlSDkdP4j1Wg4g0XxTyo9JRw+adVuXApxM2vhhHaFaU5RcSjzDK/to
         wDcg==
X-Forwarded-Encrypted: i=1; AHgh+RoKdGT/Eph3lzqXn1W1zeRoGJpe6qfVLLhpw3qbbCXWaWTb0GY77EvKGYo0NmVVwDJrUYkfZ0XmzWatQS9t/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6EfIaOdl85M6ZpCRsHsa7rXUOUEQqsSdr7EMUFnCiQSvSQiMV
	QA5kXRGSIeTBnKbhKwUX4P4EWTtgt6d0OhRqNXaD1h7/U8f0sFeb+aZk
X-Gm-Gg: AfdE7cnj5pCkojHkjLjkClfTWYYcv+eNw7WHwCs6+GQfR1EjwEMvWNOakxx3V7H4ynD
	z+8jXpWLr79BCGXsP1U3kM9WqgciRFIkfX2SJLeV+XS2xXShahwvD28b6kPshV9oilmGagVVrnw
	b0H8TzXEkO52NUgiWHnGqd70UyIoJI4+4YtkbYtEmtgm+yNkLzYEtADaGbMiXv6q39msTDMRhA1
	a3lR+qWQDVXo1bD42mXpmjUl4Ckl7V2+WggmjtJFwMYOkpQrq+2UEudNkQKs/54cFgJsGr9HtyH
	xM+Hai7ty1qQVxm9k3BU5qNsgaSIWw+ZvP1gLqe57o/T4OYMOE42e5bf6D81RtmQXYb45JTLxoS
	q61Tq+rjz+amZob+XmQ7lUOfcluBG8Vj2pRzG2th2Z/kUfdWilxm+yXT8Mx2T/h9yTouOkvjJCk
	1EfidMyRy8AwCYiGHqF67Lcg==
X-Received: by 2002:a05:6000:2209:b0:47e:4b03:1aac with SMTP id ffacd0b85a97d-47f2dcc657bmr6545301f8f.38.1783889390356;
        Sun, 12 Jul 2026 13:49:50 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm80618062f8f.26.2026.07.12.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:49:49 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush work
Date: Sun, 12 Jul 2026 17:49:38 -0300
Message-ID: <alP94iaRUgnqF9Oy@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ag2IDR-JWn8k3bUG@localhost.localdomain>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-2-leobras.c@gmail.com> <ag2IDR-JWn8k3bUG@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 12:08:13PM +0200, Frederic Weisbecker wrote:
> Le Mon, May 18, 2026 at 10:27:47PM -0300, Leonardo Bras a écrit :
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem:
> > scheduling work on remote cpu that are executing low latency tasks
> > is undesired and can introduce unexpected deadline misses.
> > 
> > It's interesting, though, that local_lock()s in RT kernels become
> > spinlock(). We can make use of those to avoid scheduling work on a remote
> > cpu by directly updating another cpu's per_cpu structure, while holding
> > it's spinlock().
> > 
> > In order to do that, it's necessary to introduce a new set of functions to
> > make it possible to get another cpu's per-cpu "local" lock (pw_{un,}lock*)
> > and also do the corresponding queueing (pw_queue_on()) and flushing
> > (pw_flush()) helpers to run the remote work.
> > 
> > Users of non-RT kernels but with low latency requirements can select
> > similar functionality by using the CONFIG_PWLOCKS compile time option.
> > 
> > On CONFIG_PWLOCKS disabled kernels, no changes are expected, as every
> > one of the introduced helpers work the exactly same as the current
> > implementation:
> > pw_{un,}lock*()		->  local_{un,}lock*() (ignores cpu parameter)
> > pw_queue_on()  		->  queue_work_on()
> > pw_flush()		->  flush_work()
> > 
> > For PWLOCKS enabled kernels, though, pw_{un,}lock*() will use the extra
> > cpu parameter to select the correct per-cpu structure to work on,
> > and acquire the spinlock for that cpu.
> > 
> > pw_queue_on() will just call the requested function in the current
> > cpu, which will operate in another cpu's per-cpu object. Since the
> > local_locks() become spinlock()s in PWLOCKS enabled kernels, we are
> > safe doing that.
> > 
> > pw_flush() then becomes a no-op since no work is actually scheduled on a
> > remote cpu.
> > 
> > Some minimal code rework is needed in order to make this mechanism work:
> > The calls for local_{un,}lock*() on the functions that are currently
> > scheduled on remote cpus need to be replaced by either pw_{un,}lock_*(),
> > PWLOCKS enabled kernels they can reference a different cpu. It's also
> > necessary to use a pw_struct instead of a work_struct, but it just
> > contains a work struct and, in CONFIG_PWLOCKS, the target cpu.
> > 
> > This should have almost no impact on non-CONFIG_PWLOCKS kernels: few
> > this_cpu_ptr() will become per_cpu_ptr(,smp_processor_id()) on non-hotpath
> > functions.
> > 
> > On CONFIG_PWLOCKS kernels, this should avoid deadlines misses by
> > removing scheduling noise.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> I like it! Just a few observations:
>

Hi Frederic, thanks for reviewing!
 
> > +#ifndef CONFIG_PWLOCKS
> > +
> > +typedef local_lock_t pw_lock_t;
> > +typedef local_trylock_t pw_trylock_t;
> > +
> > +struct pw_struct {
> > +	struct work_struct work;
> > +};
> > +
> > +#define pw_lock_init(lock)				\
> > +	local_lock_init(lock)
> > +
> > +#define pw_trylock_init(lock)				\
> > +	local_trylock_init(lock)
> > +
> > +#define pw_lock(lock, cpu)				\
> > +	local_lock(lock)
> 
> For debugging purpose, it would be nice to ensure that in those off-case,
> cpu is indeed the local one. Basically all the non-local functions, those that
> take a cpu, should verify:
> 
> lockdep_assert(cpu == smp_processor_id())

I see the point, should not be an issue, as non-local functions are not
hotpath.

> 
> > +
> > +#define pw_lock_local(lock)				\
> > +	local_lock(lock)
> > +
> > +#define pw_lock_irqsave(lock, flags, cpu)		\
> > +	local_lock_irqsave(lock, flags)
> > +
> > +#define pw_lock_local_irqsave(lock, flags)		\
> > +	local_lock_irqsave(lock, flags)
> > +
> > +#define pw_trylock(lock, cpu)				\
> > +	local_trylock(lock)
> > +
> > +#define pw_trylock_local(lock)				\
> > +	local_trylock(lock)
> > +
> > +#define pw_trylock_irqsave(lock, flags, cpu)		\
> > +	local_trylock_irqsave(lock, flags)
> > +
> > +#define pw_unlock(lock, cpu)				\
> > +	local_unlock(lock)
> > +
> > +#define pw_unlock_local(lock)				\
> > +	local_unlock(lock)
> > +
> > +#define pw_unlock_irqrestore(lock, flags, cpu)		\
> > +	local_unlock_irqrestore(lock, flags)
> > +
> > +#define pw_unlock_local_irqrestore(lock, flags)		\
> > +	local_unlock_irqrestore(lock, flags)
> > +
> > +#define pw_lockdep_assert_held(lock)			\
> > +	lockdep_assert_held(lock)
> > +
> > +#define pw_queue_on(c, wq, pw)				\
> > +	queue_work_on(c, wq, &(pw)->work)
> > +
> > +#define pw_flush(pw)					\
> > +	flush_work(&(pw)->work)
> > +
> > +#define pw_get_cpu(pw)	smp_processor_id()
> > +
> > +#define pw_is_cpu_remote(cpu)		(false)
> > +
> > +#define INIT_PW(pw, func, c)				\
> > +	INIT_WORK(&(pw)->work, (func))
> > +
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
> 
> This can be no-op in !CONFIG_PREEMPT_RT because non-rt spinlocks
> disable preemption already.
> 

I remember this was useful because we were getting the per-cpu variable 
before we preempt_disable in the lock code, and that could be bad if we get 
preempted after getting the per-cpu variable, and migrated to another core.

This is supposed to cost very little, because it's planned to match 
whatever is inside the lock, which would just be incrementing a nesting 
counter.

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
> It looks like all these macros could be inline functions.
> 

I think the one with irqsave does not :(
So I ended up staying with defines all around.

Do you suggest replacing all except the irqsave ones with inline functions?
(I tried that, and the macro version looked easier to read. I have no issue 
reusing the inline version again) 

> > +
> > +#define pw_trylock_init(lock)							\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		spin_lock_init(lock.sl);					\
> > +	else									\
> > +		local_trylock_init(lock.ll);					\
> > +} while (0)
> > +
> > +#define pw_lock(lock, cpu)
> > \
> 
> And those could have the same local CPU debug check.
> 

Sure

> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		spin_lock(per_cpu_ptr(lock.sl, cpu));				\
> > +	else									\
> > +		local_lock(lock.ll);						\
> > +} while (0)
> > +
> > +#define pw_lock_local(lock)							\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> > +		preempt_or_migrate_disable();					\
> > +		spin_lock(this_cpu_ptr(lock.sl));				\
> > +	} else {								\
> > +		local_lock(lock.ll);						\
> > +	}									\
> > +} while (0)
> > +
> > +#define pw_lock_irqsave(lock, flags, cpu)					\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		spin_lock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);	\
> > +	else									\
> > +		local_lock_irqsave(lock.ll, flags);				\
> > +} while (0)
> > +
> > +#define pw_lock_local_irqsave(lock, flags)					\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> > +		preempt_or_migrate_disable();					\
> > +		spin_lock_irqsave(this_cpu_ptr(lock.sl), flags);		\
> > +	} else {								\
> > +		local_lock_irqsave(lock.ll, flags);				\
> > +	}									\
> > +} while (0)
> > +
> > +#define pw_trylock(lock, cpu)							\
> > +({										\
> > +	int t;									\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		t = spin_trylock(per_cpu_ptr(lock.sl, cpu));			\
> > +	else									\
> > +		t = local_trylock(lock.ll);					\
> > +	t;									\
> > +})
> > +
> > +#define pw_trylock_local(lock)							\
> > +({										\
> > +	int t;									\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> > +		preempt_or_migrate_disable();					\
> > +		t = spin_trylock(this_cpu_ptr(lock.sl));			\
> > +		if (!t)								\
> > +			preempt_or_migrate_enable();
> > \
> 
> This is duplicating the RT logic in local_lock_internal.h and it would be
> tempting to propose spin_local_lock_t that both pw and RT local_lock could rely
> upon. But I'm afraid that would create a less readable result:
> 
> - we would need to check the CONFIG_PREEMPT_RT there before doing the
>   migrate_disable/enable
> 
> - RT local lock don't take the lock on IRQ/NMI, which is fine as pw is not
>   expected to be used on the non-threaded parts of IRQs not NMIs. Still that's
>   one more conditional to add there.
> 
> - we'll need to differenciate local/remote operations.
> 
> Well let's stick to what you did for now (Peter might have a different opinion though).
> 

I get your point. I will take a look on that.

> > +	} else {								\
> > +		t = local_trylock(lock.ll);					\
> > +	}									\
> > +	t;									\
> > +})
> > +
> > +#define pw_trylock_irqsave(lock, flags, cpu)					\
> > +({										\
> > +	int t;									\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		t = spin_trylock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);	\
> > +	else									\
> > +		t = local_trylock_irqsave(lock.ll, flags);			\
> > +	t;									\
> > +})
> > +
> > +#define pw_unlock(lock, cpu)							\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		spin_unlock(per_cpu_ptr(lock.sl, cpu));			\
> > +	else									\
> > +		local_unlock(lock.ll);					\
> > +} while (0)
> > +
> > +#define pw_unlock_local(lock)							\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> > +		spin_unlock(this_cpu_ptr(lock.sl));				\
> > +		preempt_or_migrate_enable();					\
> > +	} else {								\
> > +		local_unlock(lock.ll);						\
> > +	}									\
> > +} while (0)
> > +
> > +#define pw_unlock_irqrestore(lock, flags, cpu)					\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		spin_unlock_irqrestore(per_cpu_ptr(lock.sl, cpu), flags);	\
> > +	else									\
> > +		local_unlock_irqrestore(lock.ll, flags);			\
> > +} while (0)
> > +
> > +#define pw_unlock_local_irqrestore(lock, flags)					\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> > +		spin_unlock_irqrestore(this_cpu_ptr(lock.sl), flags);	\
> > +		preempt_or_migrate_enable();					\
> > +	} else {								\
> > +		local_unlock_irqrestore(lock.ll, flags);			\
> > +	}									\
> > +} while (0)
> > +
> > +#define pw_lockdep_assert_held(lock)						\
> > +do {										\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		lockdep_assert_held(this_cpu_ptr(lock.sl));			\
> > +	else									\
> > +		lockdep_assert_held(this_cpu_ptr(lock.ll));			\
> > +} while (0)
> > +
> > +#define pw_queue_on(c, wq, pw)							\
> > +do {										\
> > +	int __c = c;								\
> > +	struct pw_struct *__pw = (pw);						\
> > +	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
> > +		WARN_ON((__c) != __pw->cpu);					\
> > +		__pw->work.func(&__pw->work);					\
> > +	} else {								\
> > +		queue_work_on(__c, wq, &(__pw)->work);				\
> > +	}									\
> > +} while (0)
> > +
> > +/*
> > + * Does nothing if PWLOCKS is set to use spinlock, as the task is already done at the
> > + * time pw_queue_on() returns.
> > + */
> > +#define pw_flush(pw)								\
> > +do {										\
> > +	struct pw_struct *__pw = (pw);						\
> > +	if (!static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
> > +		flush_work(&__pw->work);					\
> > +} while (0)
> > +
> > +#define pw_get_cpu(w)			container_of((w), struct pw_struct, work)->cpu
> > +
> > +#define pw_is_cpu_remote(cpu)		((cpu) != smp_processor_id())
> > +
> > +#define INIT_PW(pw, func, c)							\
> > +do {										\
> > +	struct pw_struct *__pw = (pw);						\
> > +	INIT_WORK(&__pw->work, (func));						\
> > +	__pw->cpu = (c);							\
> > +} while (0)
> > +
> > +#endif /* CONFIG_PWLOCKS */
> > +#endif /* LINUX_PWLOCKS_H */
> > diff --git a/kernel/pwlocks.c b/kernel/pwlocks.c
> > new file mode 100644
> > index 000000000000..1ebf5cb979b9
> > --- /dev/null
> > +++ b/kernel/pwlocks.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "linux/export.h"
> > +#include <linux/sched.h>
> > +#include <linux/pwlocks.h>
> > +#include <linux/string.h>
> > +#include <linux/sched/isolation.h>
> > +
> > +DEFINE_STATIC_KEY_MAYBE(CONFIG_PWLOCKS_DEFAULT, pw_sl);
> > +EXPORT_SYMBOL(pw_sl);
> > +
> > +static bool pwlocks_param_specified;
> > +
> > +static int __init pwlocks_setup(char *str)
> > +{
> > +	int opt;
> > +
> > +	if (!get_option(&str, &opt)) {
> > +		pr_warn("PWLOCKS: invalid pwlocks parameter: %s, ignoring.\n", str);
> > +		return 0;
> > +	}
> > +
> > +	if (opt)
> > +		static_branch_enable(&pw_sl);
> > +	else
> > +		static_branch_disable(&pw_sl);
> > +
> > +	pwlocks_param_specified = true;
> > +
> > +	return 1;
> > +}
> > +__setup("pwlocks=", pwlocks_setup);
> > +
> > +/*
> > + * Enable PWLOCKS if CPUs want to avoid kernel noise.
> > + */
> > +static int __init pwlocks_init(void)
> > +{
> > +	if (pwlocks_param_specified)
> > +		return 0;
> > +
> > +	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> > +		static_branch_enable(&pw_sl);
> > +
> > +	return 0;
> > +}
> > +
> > +late_initcall(pwlocks_init);
> 
> That should be a pre-SMP initcall. Otherwise you risk some asymetric calls.
> 

Noted.
Will take a deeper look on that part for next version

Thanks!
Leo
