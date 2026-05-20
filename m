Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7373EE1D3
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288793; cv=none; b=OqGmoB2K4kAntG31t4J5UnTrDtYzxhrAmEuD7+13jCaf0BPi5x4MX1JVomAlx1makSDLlZQjix44YorK5G43Xe57QdLoaaSOFv70Rm0cnYFwczENw7oC3I8XvKifxSIsX7LjQFL2qKwWMW0PF9PwcapjUimjgdwQyWNT7XN4AEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288793; c=relaxed/simple;
	bh=vb99io4b1uHW4fgC/bBTGZYxfWjnea0pXihI7SMZxtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeA6SWp31nXQaK/PVX4IxmvVptjiCTt29aV0ZSd2Hk+ZwIpSV7aUwVjrSLGeag6bfE4yngVujZwEkGNtX5QAUYCC7HOnxjWcZaZpCZLMERPmUSKT3d3n7o0t8dSzM1DQXVogo5mXmlfOOgFWXMCbhR6FNFoa4vi/1bXqqJYhCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tb5cWw37; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FT6L1KrL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tb5cWw37";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FT6L1KrL"
Date: Wed, 20 May 2026 16:53:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779288790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mk2uML0f+DmowIUT8McBPWXKD76M6vlEQFs4dU+CHo=;
	b=Tb5cWw373iYJzxUi63XwdH/EOQFLGovvQiB8BL4RVGvYFTMDw9jkLcj6Eac65cEmYur9xN
	hedaMfb8R88PiK1jm0Y1Y44BHpKgX8OfDK5x/67/W5qagWOr3YFYkoyVWxfpPR2RZR1Vc/
	L8t4a3a9Dp/HdeYav19jAYj49gbLXIh/QTfTqzRO6SQJIurAuga61jTSgtSAWfcVz/7k6Q
	guBQ93DcgZsii0P5Ik89YGdgn3yYeDzkovSe5drUQ67UNmhBPAgqkFG3pmvDcleIgyopOT
	dpuFVTGVgwoiaOYXZNeewYt+WZ3tic40EQLw/7JJ0GuCQ1+B/f/i3QkfXKOreA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779288790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mk2uML0f+DmowIUT8McBPWXKD76M6vlEQFs4dU+CHo=;
	b=FT6L1KrLsjVwCf6fGAeFVCl5O4Mz5bZa+IM2nXsByZo7RL37YpDxOtHnx/5AkedPD+hmzd
	PufPFmlC3Sm1dODg==
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
Subject: Re: [PATCH v4 4/4] slub: apply new pw_queue_on() interface
Message-ID: <20260520145308.nay9zt6r@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-5-leobras.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519012754.240804-5-leobras.c@gmail.com>

On 2026-05-18 22:27:50 [-0300], Leonardo Bras wrote:
> @@ -4733,121 +4735,121 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  
>  	/*
>  	 * We assume the percpu sheaves contain only local objects although it's
>  	 * not completely guaranteed, so we verify later.
>  	 */
>  	if (unlikely(node_requested && node != numa_mem_id())) {
>  		stat(s, ALLOC_NODE_MISMATCH);
>  		return NULL;
>  	}
>  
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	if (!pw_trylock_local(&s->cpu_sheaves->lock))
>  		return NULL;

alloc_from_pcs() can be called from kmalloc_nolock()/ NMI context.
I don't remember why exactly local_trylock_t was introduced here instead
of a per-CPU spinlock_t. But there should be nothing wrong with a
trylock on it from NMI as you do here.

One thing worth noting, on !PREEMPT_RT, spin_trylock() always succeeds
on UP. kmalloc_nolock() checks for it, not sure about other callers.

Sebastian
