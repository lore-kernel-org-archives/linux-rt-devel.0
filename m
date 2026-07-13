Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40D35CBCB
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979095; cv=none; b=ZOsKa9c9uQwu2B/LFIzLTSio/S/Gmjz1yWEUwPoYoRWBFYuelEyyti4SmZcJy9eLBoBXZYwKC6Bfl1spA8hANghWZB/Txo8TuH0aCnCB6c2O35FKa5wwCbBWip93In8QWJAaEFBzjUb28GVg25ymHX2FHi32m+6ABaBs0yM2M+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979095; c=relaxed/simple;
	bh=tm0m35PCxp1FkT9230tpXfSGtscsHUGupr0C8M/89KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=DOX3ii9UyEvhTxQaGcM4uNypeCebYCaF4IcA04s6Mt6FE+TvGHDw0S8cAXIb5PYqExfm4GvoRGc2Q51dcy9XXsl6F5P0oQ2wGofjE1fjKI6Lg7iYqcwd3OmHH48So57Ug1TKtEkl60+hWci1jSarnaVUIPAibb6EsPDZhMYqrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyfUqu/Y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyfUqu/Y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f25d47dcso2286125e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979092; x=1784583892; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5DZ2wnEYE0t0eLEvNMJDLzTpJbDUy0ZG5iAhAz+AYU=;
        b=lyfUqu/Y9rqkyCiqzhfHBSd+oFxTmBy/Y0n6QhgqIuZYtRNDcTFKwKMwTEjjxG1NfB
         P6i8nPYP5kSDh9OwgoqdvGrZNB9nycHhZlSIbM2tFR36301hiHz5uqIutLFr2ftq7E4z
         /epKAhJHdsw+fj1EF9IwwJ54/N6DeRK7yhvWwkMhBGPWABFGrdf/kU5GSPimEt664qWO
         3oN2D6e+AzrlCc+4mtV1uIwIJYSkHuIJ8yTGM4EqobVJfhwcENAN96x++iTlF1bHqpy/
         KjAZ8KmMeJm9VK7UYKQYl4hDh3w3lopk0kRYEcA8qrdlprtYBSmbZ42Hd3RmXfjVV94d
         mcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979092; x=1784583892;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y5DZ2wnEYE0t0eLEvNMJDLzTpJbDUy0ZG5iAhAz+AYU=;
        b=Gtciws/tOsc3B5gs+lJpFlfwl2crEfMmu4KwSytN7YGN2iLEpvb2wq67KMX6Q94d9S
         TnV8w9eJp0fA81tEBISzg9MtFcF3ih46xq5imGYB0eC5hGff0FDWltN5cgL3OBXwpPvf
         cIIQ8favxbOncgCeRml74ei8Nje3Tqw0sx7iX/Sz7YWquewZEybA+2gQhxh/ES7WcKk+
         e5ssgf5y5Ds/zhwg2QuIOLxRBkDkNz0teFCnOO+sVkaS7qd3yfh9R1PHX6q/HjCTbnJT
         7cEKLLgbV+qUYcDSn+aKEjCIQyhG9FSGAOq8UfW/r4E0+iEAhUvaNBwDqDtkEPNthXFD
         BUxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrx3GYSFuQBuqDgsGkULhHGRxcLz54Of0q86z3Ab+4/oc9gPp9Nxtjs9y8euQVrv8jZrVkixCXkPYr8D5fsuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPG0q5dAfmjEEdPGSM7osTFGYDC5YlkTA9eTTFYXdCVuvZrZkl
	1NYnB5D3INsFclGAFvX/gS4ZxWNpmr3qyUYoBNJXeNYKMuY/qT10sh+g
X-Gm-Gg: AfdE7clotQrmi1ul/KaJCmDYMMzBmKiKwqoBPKXdhZIHI09WwvzbJTId3peHWS9fNc2
	2EKE6eK1MkZc/kWd+vPuTCVy6tZO52c7ToLNVNryDBt5USLgx3xXV/HEyVP2iRDWjEXnsWnQJhK
	B7g3jeZyURGxD5xCE7onfPp4Kv5rB+sxD5hkgOJtYjbGP6NlacGa3QQSddp1B3TXUDPHQTCLJW2
	cB+VDheVWK+EB1aryr4bGcc9D5cU5ECI8UikM2I8uBoerz2pP7TTSOAEHMJWAY/GEIfoA95m9Rf
	+iijDEoFZ9ydzKb6hcb/cRCI+KAPhjigniJw+Ud0Z9cyu/wlCrfWnJxWBOnEBiJQiv9WZozGoFI
	MU8M2AKGEV2rmHUb0VXxoP26WOmnymXKkDjHmy4+zzHQUvX8V7dNMz0ZsGSc188Z3QuM9PD3jxA
	+yRZ/Jd79LwuTr9UW4QXbcoA==
X-Received: by 2002:a05:600c:6089:b0:493:b7cb:c5f with SMTP id 5b1f17b1804b1-493fa8afbb6mr103142795e9.11.1783979091931;
        Mon, 13 Jul 2026 14:44:51 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49506a1fbcesm23074035e9.0.2026.07.13.14.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:44:51 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Subject: Re: [PATCH v4 4/4] slub: apply new pw_queue_on() interface
Date: Mon, 13 Jul 2026 18:44:49 -0300
Message-ID: <alVcUZcSeLf187VD@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <157f60cb-ff83-4fed-8b05-e6c6390f85bc@kernel.org>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-5-leobras.c@gmail.com> <20260520145308.nay9zt6r@linutronix.de> <alQWr2L_Kn23pxd9@WindFlash> <20260713073634.3Hrxpfcx@linutronix.de> <157f60cb-ff83-4fed-8b05-e6c6390f85bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 13, 2026 at 12:55:36PM +0200, Vlastimil Babka (SUSE) wrote:
> On 7/13/26 09:36, Sebastian Andrzej Siewior wrote:
> > On 2026-07-12 19:35:28 [-0300], Leonardo Bras wrote:
> >> On Wed, May 20, 2026 at 04:53:08PM +0200, Sebastian Andrzej Siewior wrote:
> >> > On 2026-05-18 22:27:50 [-0300], Leonardo Bras wrote:
> >> > > @@ -4733,121 +4735,121 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
> >> > >  
> >> > >  	/*
> >> > >  	 * We assume the percpu sheaves contain only local objects although it's
> >> > >  	 * not completely guaranteed, so we verify later.
> >> > >  	 */
> >> > >  	if (unlikely(node_requested && node != numa_mem_id())) {
> >> > >  		stat(s, ALLOC_NODE_MISMATCH);
> >> > >  		return NULL;
> >> > >  	}
> >> > >  
> >> > > -	if (!local_trylock(&s->cpu_sheaves->lock))
> >> > > +	if (!pw_trylock_local(&s->cpu_sheaves->lock))
> >> > >  		return NULL;
> >> > 
> >> > alloc_from_pcs() can be called from kmalloc_nolock()/ NMI context.
> >> > I don't remember why exactly local_trylock_t was introduced here instead
> >> > of a per-CPU spinlock_t. 
> >> 
> >> Probably to save the cost of using atomic operations on locking, and having 
> 
> Yes. Also function call overhead as spinlocks are often not inlined.

Oh, right, I remember getting numbers on that. Inlined per-cpu spinlocks 
take much less time.

> 
> >> about the same restrictions that would allow using local_locks
> 
> Indeed.
> 
> >> > But there should be nothing wrong with a
> >> > trylock on it from NMI as you do here.
> >> 
> >> Awesome!
> > 
> > The problem is always the unlock which requires full locking and is
> > usually the problem from NMI.
> > 
> >> > 
> >> > One thing worth noting, on !PREEMPT_RT, spin_trylock() always succeeds
> >> > on UP. kmalloc_nolock() checks for it, not sure about other callers.
> >> 
> >> 
> >> Sorry, I did not sure I understand that part. 
> >> You mean we have since it always returns true, we may be in NMI context, 
> >> after it was interrupted holding this lock, and it will return true which 
> >> will use the protected area even though the lock should avoid it?
> > 
> > from include/linux/spinlock_api_up.h:
> > | static __always_inline int _raw_spin_trylock(raw_spinlock_t *lock)
> > |         __cond_acquires(true, lock)
> > | {
> > |         __LOCK(lock);
> > |         return 1;
> > | }
> > 
> > on UP a spin_trylock() always succeeds.
> 
> Indeed. This was a problem in the page allocator, because there we don't
> even disable irqs, so it wasn't just nmi, but an irq that could get a
> false-positive spin_trylock(). See 038a102535eb ("mm/page_alloc: prevent pcp
> corruption with SMP=n") which was a hot fix.
> 
> This was later cleaned up with 3 commits starting with a373f371166d
> ("mm/page_alloc: effectively disable pcp with CONFIG_SMP=n").
> 
> Since here you're also replacing local_trylock() (with no _irqsave) with
> effectively spin_trylock(), the problem also won't be limited to NMIs and
> thus the checks in kmalloc_nolock() won't help.
> 
> But I see in Patch 1:
> 
> +config PWLOCKS
> +	bool "Per-CPU Work locks"
> +	depends on SMP || COMPILE_TEST
> 
> So that's basically avoiding the problem in the same way as the page
> allocator after the clean up.
> Maybe just remove the COMPILE_TEST part? It's not clear to me what it
> achieves. Just make it require SMP as there's no point for this on !SMP.
> 

I don't mind removing it, but IIRC that was added by Marcelo, I have to 
ask him the reason he added it.

Thanks!
Leo
