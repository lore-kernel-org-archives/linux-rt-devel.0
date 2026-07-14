Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B63644C3
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023974; cv=none; b=StcJP3bie1cXdrP8Kf7AvtBTaTxr3xcIGQhHWFhM19vro7jDIuYWdVXUo5Ou+n0BK3CTCUIBBiRvDiyGg2+uR1cIUQtCfXQ0aHJ7NJhcjckpR+IjwvNvLXtECtsTgtFc+cRrM6FTQYfUAYusxG5JL4QtcxLXM1h9Am8tIeqxXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023974; c=relaxed/simple;
	bh=eGQhjevRi4VUY0qp+zJAH8KVskQKAiTQMslzprRoCd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srvFq2DYjTVSd0EWYkOmqD/GN+ZYhr6CEeBaDaY1mOdNkNLg93oqT2ie+4v4gYvbTPwd74vxLloy85kKrbJ2+MnhDjnfu7gAwCEBJM7N6B/Ler8GkKxqDqwg8X4YtdUTATOtIILnzNsc7baMnYvN8oBmEVL14MK8yWpQjD6hcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zk2GyPuL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UX4RPTay; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zk2GyPuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UX4RPTay"
Date: Tue, 14 Jul 2026 12:12:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784023971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTkmerU8UE91t1uqi1Zg80dTpHp+N6TCCSgmWke5AWY=;
	b=zk2GyPuLv/CULvPLi8yopdSODYUTrhGxZKZk8dd8mzHUNuBSoZcHm43puFTCkFjFXm8uD0
	EKzG/04UrVUW5/s+MKyPIecaj7TnLKSsJhra2w69fUBlZqCRtgex48kf84oZWv+ijO7xUB
	MXwsbqhdUvynljp3nafCL1enVh0Xp8d/AJUv6JgfXle0ZzSTTq8sBb6IEcWVhyy4IO8/Nf
	/s+UlSdE/v9xVUUZpvRTJ4pVRv9yKjQPDDR3a25XVGjttjZOmrgfZv5qsP92UwibxkupX1
	ZRClx/XM9C1sf50o+COZoIqgSIL+m5BDD0Lri5/T6Nvz3L8z47TpJqgu3s7SUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784023971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTkmerU8UE91t1uqi1Zg80dTpHp+N6TCCSgmWke5AWY=;
	b=UX4RPTayR35zaZYCZZkIfXYdmcBvYC+h+fQ87S32/PfxvcS+wsHmXehsVSYaPPhLzb4Uhl
	mvzIyqsh+iM8wJCg==
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
Message-ID: <20260714101248.hV06z2cr@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260520130903.Ebsd4aUa@linutronix.de>
 <alP58SgTc2_8OFPc@WindFlash>
 <20260713080723.XOTiibfG@linutronix.de>
 <alVV44RO_SolaqMW@WindFlash>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alVV44RO_SolaqMW@WindFlash>

On 2026-07-13 18:17:23 [-0300], Leonardo Bras wrote:
> IIRC there are multiple users of this mechanism around the kernel. I 
> remember picking the first three (swap, slub and memcontrol) as examples of 
> how to use pwlocks (QPW at the time). With the concept proven, I could then 
> proceed to work with other potential users to replace it. (We ended up 
> dropping memcontrol in the process)
> 
> The main idea is to replace as many potential users as possible to reduce 
> as much as possible the amount of IPIs in isolated cpus, and allow Linux 
> to run workloads which require much lower latency.

Right. I am not entirely opposed to this idea. If you can't improve the
situation by other means I would consider this as the last resort. If
the mm folks are on board with this, then even better.

> This idea came as a general solution to a bunch of latency violations  
> Marcelo and I were coming across.
> 
> Thanks!
> Leo

Sebastian
