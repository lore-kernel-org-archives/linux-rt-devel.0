Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB837267A
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282554; cv=none; b=kLQiO9p3EtcFwV/icLHVTMB/ZhotHqA7ia7Rom08zlGf9enOS1hzCQPnKzyNAmniuydZZw/iiwmSgHRipGt6fYJ0xJfltpamK094TUZhYE6P7fR+Im0kJ9NXulat0k1P1m5fLqWrlKlP6gwJsg8OkbsTQJz8nWqqegGG8M7g9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282554; c=relaxed/simple;
	bh=A1DB8YpDHku7vNj1EPA9Jz5VGyMQruSTI7VAyIjV5/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haoVAxk6mYPldySkoMJXFdzeaRzGSdfSEV8tRc6bIzjelYZDQEWMK8jt9nfA31dJVEGcsSxSJ9b/izrfnayThaNVTLvTiZsBE7Hiz1hN/BFU7JYgL7EliO1pBvbmc7ZsEb39JNe94iY7s/fsexamNtckJz04nSEUZjqKf8CY3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpHeu5XE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPIj50Bo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpHeu5XE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPIj50Bo"
Date: Wed, 20 May 2026 15:09:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779282545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cya+tMoFymUiiUMO949m9cNeRyJ+/OxofgEYmhbqfEQ=;
	b=YpHeu5XEac5sy2OB4xvanyH4HNjNtxA1u+7eO1k07GpkSy5GwFoA8WOl7v1VZtofZxZKPo
	zDP42xAZanOGd53qKghSjYEL/H/8HnqzAYH86BFu8Z/8g/XnyzJGNtNmENMgHA6qmuGps2
	1xIErcW/Tm78/NQcQbyVbOrawlYLY+Ao0+tXu6KxDCxjP78fw7Ifl7RtK2EseOIEzlNbby
	v3AGB5p4tYCLpC6huA6timfuuHLoV4W8c8uRI4xFJlz4cIZrTyUn02t/naw700GqV2LIHS
	BpJfp0KHCEVIT+R15se35cGI2UDN9pWTdE/FVi/WyVsZ0ZoysyjfmHKedmkzsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779282545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cya+tMoFymUiiUMO949m9cNeRyJ+/OxofgEYmhbqfEQ=;
	b=tPIj50Bor+vehmmu8fzN+AwNvSd1OiMEbGVBNTXebC32AR0UKdYTKpeWVm2OcmZvw/0FR9
	cRDAia8bpc4kGjBQ==
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
	Thomas Gleixner <tglx@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>, Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Masahiro Yamada <masahiroy@kernel.org>, Coiby Xu <coxu@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 0/4] Introduce Per-CPU Work helpers (was QPW)
Message-ID: <20260520130903.Ebsd4aUa@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519012754.240804-1-leobras.c@gmail.com>

On 2026-05-18 22:27:46 [-0300], Leonardo Bras wrote:
> The problem:
> Some places in the kernel implement a parallel programming strategy
> consisting on local_locks() for most of the work, and some rare remote
> operations are scheduled on target cpu. This keeps cache bouncing low since
> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> kernels, even though the very few remote operations will be expensive due
> to scheduling overhead.
> 
> On the other hand, for RT workloads this can represent a problem: getting
> an important workload scheduled out to deal with remote requests is
> sure to introduce unexpected deadline misses.
> 
> The idea:
> Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
It does not become a _spin_lock because it does not spin. It sleeps.

> In this case, instead of scheduling work on a remote cpu, it should
> be safe to grab that remote cpu's per-cpu spinlock and run the required
> work locally. That major cost, which is un/locking in every local function,
> already happens in PREEMPT_RT.

We did have this before but only in the RT tree. It was a bit messy from
the naming because it started with local_ but then it was a remote CPU.
The main issue was the different code path which led to a few deadlocks
back then.
By the time local_lock_t went upstream, the cross-CPU locking was
removed. As far as I remember, the cross-CPU user which did schedule
work on a remote CPU and annoyed NOHZ folks were replaced.

> Also, there is no need to worry about extra cache bouncing:
> The cacheline invalidation already happens due to schedule_work_on().
> 
> This will avoid schedule_work_on(), and thus avoid scheduling-out an
> RT workload.
> 
> Proposed solution:
> A new interface called PerCPU Work (PW), which should replace
> Work Queue in the above mentioned use case.
> 
> If CONFIG_PWLOCKS=n this interfaces just wraps the current
> local_locks + WorkQueue behavior, so no expected change in runtime.
> 
> If CONFIG_PWLOCKS=y, and kernel boot option pwlocks=1,
> pw_queue_on(cpu,...) will lock that cpu's per-cpu structure
> and perform work on it locally. 
> 
Sebastian
