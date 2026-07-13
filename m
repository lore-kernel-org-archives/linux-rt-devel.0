Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6735F162
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978867; cv=none; b=F40uVhjRtEVv5V7x3q2rlmJ1GrIOJL/bLPgm+dPnlWJ743Jl8dZCV6g2y0KEIsf6+FQ973/eWWHFX3pTbncm/v8f911xkDn83CyUOz2IbTmQ1aWLpNOHkluSh/THzcWbabgg8cZ2RnZNcvx1uKR0dyguVtgGw8E9/EHJHbZMAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978867; c=relaxed/simple;
	bh=SVMywLRbIFXVQzPixM0IKsUfpey0KwU4tI6WH0yTSZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=EInCroFtIsJd8qqN5SIxx4oljwWPMUD+5Rsd4WypBfcpIUdQ/wkMinVzVj6cLHZkurkZNEXHc7sLaHtVLrE+5/Zs8t/lTm8vF9Et135Ir0Vo0/TezIEJhjytamBNJ4ZLqGkXe+LFXH4Ibc4ZnbYMS7ME6qU36M2wVjDqGH4xMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwBWxfbs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwBWxfbs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b1710405so19537095e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783978864; x=1784583664; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kBTvf+Z85P+YG7179a/IzMuusmQi/QF8ZEk+OKIxHQ8=;
        b=jwBWxfbskzIPE+OTiQLP+d52lOKV813JWK4F58UpATugcnTVicZmO5yd+W3nomDgQb
         matN+CDzcTjPBkoW2ZRBBsAfqkPzKAWwdPe7vrdQUqZD9cNdWrvgYT3xNSEssLX0FA+K
         o27sa3D/FLndRKk58AozYutfptZhryWgh+bXlyTmRP1PJFMqKX6W2Yu43I2x1FhXree8
         QkakuaGZxf2kMoG9OtXfcjON7xyPTfOfKP8sZn8RAQZcwb8QpQ5HwkRqD9gXvCTtKSwc
         SIJjh0zNajgm0hGCFaFu3ZtJ+oqsCx+hlJ/dN3BxmG51zT0JH9JuMbxpRFznuj2GECev
         t5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978864; x=1784583664;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kBTvf+Z85P+YG7179a/IzMuusmQi/QF8ZEk+OKIxHQ8=;
        b=UBoHQUOzouX0s5C7gtGNYEgRlj7Z2mkvQoJtJEDJ3JszLawXZM9xgZZVv7uR5vESo0
         EV23754zJlYLnXiYagfyVm3hjHcsqi+COzUf+Z2vCRPiWwTbV7k/6640RpKJWW//kyg/
         8WckvBzY/qrVcMjpMY3ijOfByIaU8YmBouDWm8bmTx/gL8nZG4fr3Nm2GCZMa9u0Gw4R
         qRjiBNkdYMG1mYDBLfDV4qUQzHJvIGIcXIp7wAn0S8CCjoNrgRcLn6U63KKkFQIx7m5X
         Q4DCK+pm9EaddUxCV+1iS+23ZH9/egeB8w00SsnpfvkRDgt8TDvi4+1Yeno33Dt5ifNR
         8g0Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Y4amRHfXLXu8L8VnwykkrA9cVxy2negO4zaksb6VRiwVAwb7+xoVCgrwbyBTm3+tpPunoxke5M1Yq8x7cA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCkzFps2TXpmgB+JeJhNpfgoT+ZW02e5SUjeuqWvQ0A13W0bZZ
	nJUiqgBo0dzhUPphKTwwt06/RubiKK1N3XukapculOLU0+jLsZ68myf+
X-Gm-Gg: AfdE7cmZLQGNz1x6tIAKIhnKf7E1FZxe9E8RMOZYBGwQdGWowQCmKfGtUFaXQiQ1hgY
	k8KR4j0ymqD7eaMdm90E/muVhjtAcDpWyD2RtX0gos6iv5smwXHtpigkyX4yVgAxrRBMsYq40J3
	jGPY6aqlWCd1Mqc45NggjIBlWhGr+GCNwtNqL5EcM7S4bHX9pH3jpHgLlZU9naCkJSrriYr5FJ6
	yuKnlokVkmOjwHTNrhGu0QlMoyvYhWYaij6e/nbvTwLSEVtnnjHia6efBZX0BC8Bq8Tcy0ac69k
	brjLkbQAVG55xhP0Nkw6EX4OIuPpQJdiC0nmoKQJ6s4kpShKN8K4RJJom3bOcWRq6lKZ+5qZR6P
	WVXlhU2MENOYxDWvObyE2YRcIm6mL1VYipPGUNJM1uNZsMgJa7icNPRPR8hzlkcho5KDJOuzKS9
	GuMoVuLoj0tJfus7qak0nzpQ==
X-Received: by 2002:a05:600c:1908:b0:492:3e66:6c84 with SMTP id 5b1f17b1804b1-4951830e089mr11315545e9.30.1783978864353;
        Mon, 13 Jul 2026 14:41:04 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087384casm23602415e9.8.2026.07.13.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:41:03 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 4/4] slub: apply new pw_queue_on() interface
Date: Mon, 13 Jul 2026 18:40:57 -0300
Message-ID: <alVbaf-UVMNaEtvk@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713073634.3Hrxpfcx@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-5-leobras.c@gmail.com> <20260520145308.nay9zt6r@linutronix.de> <alQWr2L_Kn23pxd9@WindFlash> <20260713073634.3Hrxpfcx@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 13, 2026 at 09:36:34AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-12 19:35:28 [-0300], Leonardo Bras wrote:
> > On Wed, May 20, 2026 at 04:53:08PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-05-18 22:27:50 [-0300], Leonardo Bras wrote:
> > > > @@ -4733,121 +4735,121 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
> > > >  
> > > >  	/*
> > > >  	 * We assume the percpu sheaves contain only local objects although it's
> > > >  	 * not completely guaranteed, so we verify later.
> > > >  	 */
> > > >  	if (unlikely(node_requested && node != numa_mem_id())) {
> > > >  		stat(s, ALLOC_NODE_MISMATCH);
> > > >  		return NULL;
> > > >  	}
> > > >  
> > > > -	if (!local_trylock(&s->cpu_sheaves->lock))
> > > > +	if (!pw_trylock_local(&s->cpu_sheaves->lock))
> > > >  		return NULL;
> > > 
> > > alloc_from_pcs() can be called from kmalloc_nolock()/ NMI context.
> > > I don't remember why exactly local_trylock_t was introduced here instead
> > > of a per-CPU spinlock_t. 
> > 
> > Probably to save the cost of using atomic operations on locking, and having 
> > about the same restrictions that would allow using local_locks
> > 
> > > But there should be nothing wrong with a
> > > trylock on it from NMI as you do here.
> > 
> > Awesome!
> 
> The problem is always the unlock which requires full locking and is
> usually the problem from NMI.
>

You mean, like, the trylock succeeds in the NMI handle, does the per-cpu 
operations, and then unlock()s? 

Or by full locking you mean local_lock() instead of local_trylock() ?
 
> > > 
> > > One thing worth noting, on !PREEMPT_RT, spin_trylock() always succeeds
> > > on UP. kmalloc_nolock() checks for it, not sure about other callers.
> > 
> > 
> > Sorry, I did not sure I understand that part. 
> > You mean we have since it always returns true, we may be in NMI context, 
> > after it was interrupted holding this lock, and it will return true which 
> > will use the protected area even though the lock should avoid it?
> 
> from include/linux/spinlock_api_up.h:
> | static __always_inline int _raw_spin_trylock(raw_spinlock_t *lock)
> |         __cond_acquires(true, lock)
> | {
> |         __LOCK(lock);
> |         return 1;
> | }
> 
> on UP a spin_trylock() always succeeds.
> 

Right, I got that part, I was wondering the scenarios in which would that 
be an issue.

Thanks!
Leo
