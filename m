Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275943F8CA
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022483; cv=none; b=Iswp5NtLmifqACSWVUDfXh45IWGSMuJuc8ArsuiKzMtWTJvSjmse/KPvL8cyhAvGJ4m1h1eqU/RGFkIkM3yFT0UAqGx7a2987rX2m2XeWD/X8VHnsZMtMVBOm1HWf39BNLkuNSfT6aslAIPyI6E54H8CRYWIqr4ItXYnOhEemqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022483; c=relaxed/simple;
	bh=tAT4Z+WZSwzntwIe2Ep114LUICO74oUvIOFxwyfiux8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtf3PK/k2FR+2NhcUND0gLHcXdgFX/4hh+Q5UPAaAGeMMCGCgvJh5XV3ZgYuWVJpethLk3sL1m/UB4L+Y7xL1FzPjzOiOpdenVMR5v2mDg4tyGnONEG1/eBKRNIaw5xDQ7O7Z7Aa7BodYa4G+NMTIpTz4AqI35Fr9l+7YXawn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2hWoWkG4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LP96mIHU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2hWoWkG4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LP96mIHU"
Date: Tue, 14 Jul 2026 11:47:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784022474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsoTcN4gOIUfOGf3p48bZzeZDJjL/YfjT1YTWmmpNPE=;
	b=2hWoWkG465yKctF00Mw9KQ6sYZmw5YgJznP4SIGc5ImYPXmIYeS6IbfXVTCZTHv/KI4E2U
	f8Bk6aFvBq49FugZVTn/t+nTwVk3uOjUb+xLzqQ1ylaI4YuaVeQfW1h09gVtK/zATFk1TZ
	KoCxwcqYpF9YJ4jj1zLGKjJeoB4MSxGtc7Va4jbCSzz0ouoQjupqRadMZCq1GBawg720Bl
	pdo2Ck6m0mFasT7WVF1Iqf3WadNyYaLzwhhBu6WdOkok08jY6fpQ8fFG0EBD9iG9UOgs41
	BW39orBcuHa6++UhOEQPMc52HNKuWtZFgfJ6Oa6qJIbZP2toU8fOyfn2K8UUUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784022474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsoTcN4gOIUfOGf3p48bZzeZDJjL/YfjT1YTWmmpNPE=;
	b=LP96mIHUFuA16DNuxJK0oAMY1HLEt9nhBrM68LGoz5RXQeqSK/DTieqKA8U5nLiTSEr7Ea
	k0NF1Gm40CLZW6Bw==
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
Message-ID: <20260714094752.1Vi-C4fe@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-5-leobras.c@gmail.com>
 <20260520145308.nay9zt6r@linutronix.de>
 <alQWr2L_Kn23pxd9@WindFlash>
 <20260713073634.3Hrxpfcx@linutronix.de>
 <alVbaf-UVMNaEtvk@WindFlash>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alVbaf-UVMNaEtvk@WindFlash>

On 2026-07-13 18:40:57 [-0300], Leonardo Bras wrote:
> On Mon, Jul 13, 2026 at 09:36:34AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-07-12 19:35:28 [-0300], Leonardo Bras wrote:
> > > On Wed, May 20, 2026 at 04:53:08PM +0200, Sebastian Andrzej Siewior w=
rote:
> > > > On 2026-05-18 22:27:50 [-0300], Leonardo Bras wrote:
> > > > > @@ -4733,121 +4735,121 @@ void *alloc_from_pcs(struct kmem_cache =
*s, gfp_t gfp, int node)
> > > > > =20
> > > > >  	/*
> > > > >  	 * We assume the percpu sheaves contain only local objects alth=
ough it's
> > > > >  	 * not completely guaranteed, so we verify later.
> > > > >  	 */
> > > > >  	if (unlikely(node_requested && node !=3D numa_mem_id())) {
> > > > >  		stat(s, ALLOC_NODE_MISMATCH);
> > > > >  		return NULL;
> > > > >  	}
> > > > > =20
> > > > > -	if (!local_trylock(&s->cpu_sheaves->lock))
> > > > > +	if (!pw_trylock_local(&s->cpu_sheaves->lock))
> > > > >  		return NULL;
> > > >=20
> > > > alloc_from_pcs() can be called from kmalloc_nolock()/ NMI context.
> > > > I don't remember why exactly local_trylock_t was introduced here in=
stead
> > > > of a per-CPU spinlock_t.=20
> > >=20
> > > Probably to save the cost of using atomic operations on locking, and =
having=20
> > > about the same restrictions that would allow using local_locks
> > >=20
> > > > But there should be nothing wrong with a
> > > > trylock on it from NMI as you do here.
> > >=20
> > > Awesome!
> >=20
> > The problem is always the unlock which requires full locking and is
> > usually the problem from NMI.
> >
>=20
> You mean, like, the trylock succeeds in the NMI handle, does the per-cpu=
=20
> operations, and then unlock()s?=20

Yes.

I'm not sure what I was thinking when I wrote it back then. Try lock
with local_trylock() might work under RT from NMI. However the unlock
path (which needs to follow) requires an unconditional lock of the
inner-lock plus a potential wakeup of the waiter.=20
:
=E2=80=A6

> Thanks!
> Leo

Sebastian
