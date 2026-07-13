Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A53955EF
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930050; cv=none; b=gXmeW2tF8jm+/MnDFwHoKz64HfmgIqXWJ/WpF8AbAcjvLLPc/hcXr8SYjFkgAZCAxM3lr9+kpRihn7FuX4hFFqCVm5oSfESwVgkJPObqSVUBhWb9NBe0d99ithaI2EtOmDf2meO8jhNyBM5nWIL4fQGBZgecQVZB8YZmfghnDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930050; c=relaxed/simple;
	bh=PlYewz4QKx+iY+NZEf75sBG8EMQzla5E4MyE2PuGtTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgbTUSjeNIucZxXZyB5nuDE/Sst+sF7qMWJEL5SjUJD4iyPMelXDKFPeSKMuQP5OFAG5Ai59+2gFoRImFZyE5WlxrY37jyhy/RkLEgBHOnhB55W3GQfJX8/JemVk1/PLwpFY9rYD70/t/OeXBkqn4gEhPaCD0JhYYBBY5emOIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qsxJhDXK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Ils9B7r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsxJhDXK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Ils9B7r"
Date: Mon, 13 Jul 2026 10:07:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783930046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q84cQF/9BVMsiNBoLtWw7XAwZ26UdZlfjYA2oOWNSc=;
	b=qsxJhDXKQ4hpymg/q+SxwgwbmubBtDpjqi0c2KuDavullwomp1Cy7Ytcpwn+N7UAvuZun8
	3VVx1YCRaBvQ4mSUfKB5jAzS7/E2hJhZGyOL7F6mBE2IeIyDGKELvfdbabJn49jqSEOBDR
	erZut1M4VC3zO2jeI9OsX9EurX2Ri51l5PtcepAqvUJG5IY6DvyvZ40lZBQAcuEHvmtzAq
	gyR44JwB2PWdX7bWdYD8KOTPplfZZpuRZXXGQlT4IP9gnuOk26RdhhqtjeYlu7ansQLY01
	senVn+OVhcfNe/lSupAp/rgE7UX937RSsa7nWQTn92v0Y312JDrVSaX5xJOOxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783930046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q84cQF/9BVMsiNBoLtWw7XAwZ26UdZlfjYA2oOWNSc=;
	b=1Ils9B7rKdgiHAW0BuuWKJgHBjbLhi0i/wv+n2YJ575Xl79HCES+SvSQw82t3EI60Pn84l
	SbZHVtB0fgwG37Aw==
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
Message-ID: <20260713080723.XOTiibfG@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260520130903.Ebsd4aUa@linutronix.de>
 <alP58SgTc2_8OFPc@WindFlash>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alP58SgTc2_8OFPc@WindFlash>

On 2026-07-12 17:32:49 [-0300], Leonardo Bras wrote:
> > > The idea:
> > > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> 
> Hi Sebastian, thank you for reviewing!
> (Sorry for the delay)
> 
> > It does not become a _spin_lock because it does not spin. It sleeps.
> 
> Right, it's a per-cpu mutex. 
> My point is that it's a full lock, and we could use it instead of doing the 
> whole scheduling thing, since we are already paying the 'atomic overhead' 
> to get the lock here.

The whole lock is a spinlock_t. There is also raw_spinlock_t and
bit_spin_lock(). All three are considered spinlocks.

> > > In this case, instead of scheduling work on a remote cpu, it should
> > > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > > work locally. That major cost, which is un/locking in every local function,
> > > already happens in PREEMPT_RT.
> > 
> > We did have this before but only in the RT tree. It was a bit messy from
> > the naming because it started with local_ but then it was a remote CPU.
> 
> Had the same naming issue here. This idea was initially a expansion to 
> local_lock() mechanism, about the same way you were planning in the past.
> 
> > The main issue was the different code path which led to a few deadlocks
> > back then.
> > By the time local_lock_t went upstream, the cross-CPU locking was
> > removed. As far as I remember, the cross-CPU user which did schedule
> > work on a remote CPU and annoyed NOHZ folks were replaced.
> 
> I understand this could be a big issue if used in a generic way.
> 
> What I am proposing here a mechanism that standardizes those 
> local_lock()+IPI strategies based on how they are done today, so we are 
> only explected to get 'remote-cpu' pwlocks in the 'IPI replacement' 
> operations.
> 
> The idea is pwlock_local* in every local function, and pwlock*(,cpu) in 
> operations that can be remote. 
> 
> Maybe being used in a more constrained way, it has less chance of being an 
> issue. Also, the whole idea is to improve CPU isolation numbers by 
> reducing IPIs, so maybe NOHZ people will be happier with that :)

I get that part. The local_lock_t part is cheap on !RT and becomes a
full lock on RT. While the lock details change the overall expectation
remain the same. With this change it is possible to acquire the lock
cross-CPU but this depends on the config/ setup. This might not be easy
in terms of testing and maintenance.
The more potential users you have, the better it might become in terms
of a selling argument. If you have just (say) two users it might be
simpler to address just those.

> Thanks again!
> Leo

Sebastian
